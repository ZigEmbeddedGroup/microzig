//! WCH CH32V203 USBD (PMA-based USB device) backend
//!
//! This driver targets the USBD peripheral at 0x40005C00, which is a
//! PMA-based full-speed USB device controller similar to the STM32F103.
//! It uses EPR registers with toggle-on-write semantics and a Packet Memory
//! Area (PMA) at 0x40006000 for buffer storage.
//!
//! This is NOT the same as the USBFS/OTG peripheral at 0x50000000
//! (which uses DMA buffers in SRAM).
//! NOTE: Some variants of the ch32v203 have USBD, some have USBFS, and some
//! have both.
//!
//! Prerequisite: `hal.time.init()` must be called before USB init (typically
//! done in `board.init()`) since we need SysTick for delays.

const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_dev);

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const usb = microzig.core.usb;
const types = usb.types;
const descriptor = usb.descriptor;
const time = @import("time.zig");

pub const max_packet_size: u11 = 64;

pub const USB_MAX_ENDPOINTS_COUNT = 8;

pub const Config = struct {
    max_endpoints_count: comptime_int = USB_MAX_ENDPOINTS_COUNT,
    prefer_high_speed: bool = false,
    /// Unused for USBD (buffers live in PMA), kept for API compat.
    buffer_bytes: comptime_int = 0,
};

// --- Hardware peripheral access ---

/// USB peripheral (named "USBD" on CH32V103, "USB" on CH32V20x)
const USB_PERIPH = if (@hasDecl(peripherals, "USBD")) peripherals.USBD else peripherals.USB;

/// Base address derived from the peripheral pointer (used for EPR indexed access)
const USBD_BASE: usize = @intFromPtr(USB_PERIPH);

/// EXTEND peripheral (for D+ pull-up control via USBDPU)
const EXTEND = peripherals.EXTEND;

/// ISTR packed struct type (field names vary between chips: RST vs RESET)
const Istr = @TypeOf(USB_PERIPH.ISTR).underlying_type;

// ISTR bit masks for rc_w0 clearing (write 0 to clear, write 1 to keep).
// Raw masks are used because field names differ between chip variants.
const ISTR_ESOF: u16 = 1 << 8;
const ISTR_SOF: u16 = 1 << 9;
const ISTR_RST: u16 = 1 << 10;
const ISTR_SUSP: u16 = 1 << 11;
const ISTR_ERR: u16 = 1 << 13;
const ISTR_PMAOVR: u16 = 1 << 14;

const EpType = enum(u2) { bulk = 0, control = 1, iso = 2, interrupt = 3 };
const Stat = enum(u2) { disabled = 0b00, stall = 0b01, nak = 0b10, valid = 0b11 };

/// ISTR helper (field names differ between chips: RST vs RESET)
fn istr_is_reset(istr: Istr) bool {
    return if (@hasField(Istr, "RST")) istr.RST == 1 else istr.RESET == 1;
}

// --- EPR register access and manipulation ---

/// EPR (Endpoint Register) namespace: raw register access and toggle-on-write helpers.
///
/// These CANNOT use MMIO modify() because STAT_TX/RX, DTOG_TX/RX are
/// toggle-on-write, and CTR_TX/RX are write-0-to-clear.
const Epr = struct {
    // Bit positions / masks
    const ea_mask: u16 = 0x000F; // [3:0]   Endpoint Address
    const stat_tx_mask: u16 = 0x0030; // [5:4]   TX Status (toggle)
    const dtog_tx: u16 = 0x0040; // [6]     TX Data Toggle (toggle)
    const ctr_tx: u16 = 0x0080; // [7]     Correct Transfer TX (W0C)
    const ep_kind: u16 = 0x0100; // [8]     Endpoint Kind
    const ep_type_mask: u16 = 0x0600; // [10:9]  Endpoint Type
    const setup: u16 = 0x0800; // [11]    Setup transaction completed (RO)
    const stat_rx_mask: u16 = 0x3000; // [13:12] RX Status (toggle)
    const dtog_rx: u16 = 0x4000; // [14]    RX Data Toggle (toggle)
    const ctr_rx: u16 = 0x8000; // [15]    Correct Transfer RX (W0C)

    // Bits that are read/write (non-toggle, non-W0C): EA, EP_KIND, EP_TYPE
    const rw_mask: u16 = ea_mask | ep_kind | ep_type_mask;

    fn ptr(ep: u4) *volatile u16 {
        return @ptrFromInt(USBD_BASE + @as(usize, ep) * 4);
    }

    fn read(ep: u4) u16 {
        return ptr(ep).*;
    }

    fn write(ep: u4, val: u16) void {
        ptr(ep).* = val;
    }

    /// Set STAT_TX to desired value using XOR trick.
    fn set_stat_tx(ep: u4, stat: Stat) void {
        const val = read(ep);
        const current: u2 = @truncate((val & stat_tx_mask) >> 4);
        const xor_val: u16 = @as(u16, current ^ @backingInt(stat)) << 4;
        write(ep, (val & rw_mask) | ctr_tx | ctr_rx | xor_val);
    }

    /// Set STAT_RX to desired value using XOR trick.
    fn set_stat_rx(ep: u4, stat: Stat) void {
        const val = read(ep);
        const current: u2 = @truncate((val & stat_rx_mask) >> 12);
        const xor_val: u16 = @as(u16, current ^ @backingInt(stat)) << 12;
        write(ep, (val & rw_mask) | ctr_tx | ctr_rx | xor_val);
    }

    /// Set both STAT_TX and STAT_RX simultaneously.
    fn set_stat_txrx(ep: u4, s_tx: Stat, s_rx: Stat) void {
        const val = read(ep);
        const cur_tx: u2 = @truncate((val & stat_tx_mask) >> 4);
        const cur_rx: u2 = @truncate((val & stat_rx_mask) >> 12);
        const xor_tx: u16 = @as(u16, cur_tx ^ @backingInt(s_tx)) << 4;
        const xor_rx: u16 = @as(u16, cur_rx ^ @backingInt(s_rx)) << 12;
        write(ep, (val & rw_mask) | ctr_tx | ctr_rx | xor_tx | xor_rx);
    }

    /// Clear CTR_TX (write 0 to the W0C bit, keep CTR_RX as 1).
    fn clear_ctr_tx(ep: u4) void {
        const val = read(ep);
        write(ep, (val & rw_mask) | ctr_rx);
    }

    /// Clear CTR_RX (write 0 to the W0C bit, keep CTR_TX as 1).
    fn clear_ctr_rx(ep: u4) void {
        const val = read(ep);
        write(ep, (val & rw_mask) | ctr_tx);
    }

    /// Clear DTOG_TX by toggling it if currently set.
    fn clear_dtog_tx(ep: u4) void {
        const val = read(ep);
        if (val & dtog_tx != 0) {
            write(ep, (val & rw_mask) | ctr_tx | ctr_rx | dtog_tx);
        }
    }

    /// Clear DTOG_RX by toggling it if currently set.
    fn clear_dtog_rx(ep: u4) void {
        const val = read(ep);
        if (val & dtog_rx != 0) {
            write(ep, (val & rw_mask) | ctr_tx | ctr_rx | dtog_rx);
        }
    }

    /// Configure an endpoint: set EA, EP_TYPE, clear toggles, set initial status.
    fn configure(ep: u4, ep_type: EpType, s_tx: Stat, s_rx: Stat) void {
        // First write: set EA, EP_TYPE, clear everything else
        const base: u16 = (@as(u16, ep) & ea_mask) | (@as(u16, @backingInt(ep_type)) << 9) | ctr_tx | ctr_rx;
        write(ep, base);

        // Now set desired status bits using XOR trick
        set_stat_txrx(ep, s_tx, s_rx);

        // Clear data toggles
        clear_dtog_tx(ep);
        clear_dtog_rx(ep);
    }
};

// --- PMA (Packet Memory Area) access helpers ---

/// PMA (Packet Memory Area) namespace: read/write helpers for the shared
/// buffer memory. Each u16 PMA word occupies a u32 slot in CPU address
/// space (2x mapping), same as STM32F103.
const Pma = struct {
    const base: usize = 0x40006000;
    const size: usize = 512;
    const access_mult: usize = 2;

    /// Read a u16 from PMA at the given PMA byte offset.
    fn read16(pma_offset: u16) u16 {
        const addr: usize = base + @as(usize, pma_offset) * access_mult;
        const p: *volatile u32 = @ptrFromInt(addr);
        return @truncate(p.*);
    }

    /// Write a u16 to PMA at the given PMA byte offset.
    fn write16(pma_offset: u16, val: u16) void {
        const addr: usize = base + @as(usize, pma_offset) * access_mult;
        const p: *volatile u32 = @ptrFromInt(addr);
        p.* = val;
    }

    /// Copy bytes from CPU memory into PMA.
    fn write_bytes(pma_offset: u16, data: []const u8) void {
        var off = pma_offset;
        var i: usize = 0;
        while (i < data.len) {
            const lo: u16 = data[i];
            const hi: u16 = if (i + 1 < data.len) data[i + 1] else 0;
            write16(off, lo | (hi << 8));
            off += 2;
            i += 2;
        }
    }

    /// Copy bytes from PMA into CPU memory.
    fn read_bytes(pma_offset: u16, buf: []u8, count: usize) void {
        var off = pma_offset;
        var i: usize = 0;
        while (i < count) {
            const word = read16(off);
            buf[i] = @truncate(word);
            if (i + 1 < count) {
                buf[i + 1] = @truncate(word >> 8);
            }
            off += 2;
            i += 2;
        }
    }
};

// --- BTABLE (Buffer Descriptor Table) ---

/// BTABLE namespace: per-endpoint buffer descriptor access within PMA.
///
/// Layout per endpoint (PMA offsets):
///   +0: TX_ADDR   (u16)
///   +2: TX_COUNT  (u16)
///   +4: RX_ADDR   (u16)
///   +6: RX_COUNT  (u16)
const Btable = struct {
    /// Total BTABLE size: 8 endpoints * 8 bytes = 64 bytes
    const size: u16 = 64;

    fn tx_addr_offset(ep: u4) u16 {
        return @as(u16, ep) * 8 + 0;
    }
    fn tx_count_offset(ep: u4) u16 {
        return @as(u16, ep) * 8 + 2;
    }
    fn rx_addr_offset(ep: u4) u16 {
        return @as(u16, ep) * 8 + 4;
    }
    fn rx_count_offset(ep: u4) u16 {
        return @as(u16, ep) * 8 + 6;
    }

    fn set_tx_addr(ep: u4, pma_addr: u16) void {
        Pma.write16(tx_addr_offset(ep), pma_addr);
    }
    fn set_tx_count(ep: u4, count: u16) void {
        Pma.write16(tx_count_offset(ep), count);
    }
    fn get_tx_count(ep: u4) u16 {
        return Pma.read16(tx_count_offset(ep)) & 0x03FF;
    }
    fn set_rx_addr(ep: u4, pma_addr: u16) void {
        Pma.write16(rx_addr_offset(ep), pma_addr);
    }

    /// Set RX_COUNT with block size encoding for max receivable bytes.
    /// For sizes <= 62: BL_SIZE=0, NUM_BLOCK = size/2
    /// For sizes > 62:  BL_SIZE=1, NUM_BLOCK = size/32 - 1
    fn set_rx_count(ep: u4, max_size: u16) void {
        var val: u16 = 0;
        if (max_size <= 62) {
            val = (max_size / 2) << 10;
        } else {
            val = (1 << 15) | (((max_size / 32) - 1) << 10);
        }
        Pma.write16(rx_count_offset(ep), val);
    }

    fn get_rx_count(ep: u4) u16 {
        return Pma.read16(rx_count_offset(ep)) & 0x03FF;
    }
};

// --- Endpoint state tracking (mirrors usbfs.zig pattern) ---

const EP_State = struct {
    pma_addr: u16 = 0, // PMA offset for this buffer
    max_size: u16 = 0, // max packet size
    // OUT:
    rx_armed: bool = false,
    rx_limit: u16 = 0,
    rx_last_len: u16 = 0,
    // IN:
    tx_busy: bool = false,
};

fn PerEndpointArray(comptime N: comptime_int) type {
    return [N][2]EP_State; // [ep][dir]
}

fn epn(ep: types.Endpoint.Num) u4 {
    return @backingInt(ep);
}

/// Polled USBFS device backend for the MicroZig core USB controller.
pub fn Polled(comptime cfg: Config) type {
    comptime {
        if (cfg.max_endpoints_count < 1)
            @compileError("USBD max_endpoints_count must include endpoint 0");
        if (cfg.prefer_high_speed)
            @compileError("USBD only supports Full Speed, not High Speed");
        if (cfg.max_endpoints_count > USB_MAX_ENDPOINTS_COUNT)
            @compileError("USBD max_endpoints_count cannot exceed 8");
    }

    return struct {
        const Self = @This();

        const vtable: usb.DeviceInterface.VTable = .{
            .ep_writev = ep_writev,
            .ep_readv = ep_readv,
            .ep_listen = ep_listen,
            .ep_open = ep_open,
            .set_address = set_address,
        };

        endpoints: PerEndpointArray(cfg.max_endpoints_count),
        pma_next: u16, // next free PMA offset
        interface: usb.DeviceInterface,

        // Temporary CPU-side buffer for PMA read/write (PMA cannot be
        // accessed byte-by-byte, so we stage through this).
        staging_buf: [64]u8 = undefined,

        pub fn init(self: *Self) void {
            log.warn("USBD init starting", .{});
            self.interface = .{ .vtable = &vtable };
            self.endpoints = @splat(@splat(.{}));
            self.pma_next = Btable.size;

            usbd_hw_init();

            // EP0 is required: open OUT then IN.
            self.interface.ep_open(&.{
                .endpoint = .out(.ep0),
                .max_packet_size = .from(64),
                .attributes = .{ .transfer_type = .Control, .usage = .data },
                .interval = 0,
            });
            self.interface.ep_open(&.{
                .endpoint = .in(.ep0),
                .max_packet_size = .from(64),
                .attributes = .{ .transfer_type = .Control, .usage = .data },
                .interval = 0,
            });

            // EP0 OUT always accepts packets
            Epr.set_stat_rx(0, .valid);

            // Enable interrupt masks: bus reset and correct transfer
            USB_PERIPH.CNTR.write(.{ .FRES = 0, .PDWN = 0, .RESETM = 1, .CTRM = 1 });
            USB_PERIPH.ISTR.write_raw(0); // clear any flags raised during init

            // Force a clean disconnect/connect cycle so the host detects
            // a fresh device attach (matches WCH EVT USB_Port_Set pattern).
            usb_port_set(false); // pull-up off, drive D+/D- low (SE0)
            time.delay_us(20_000); // ~20ms disconnect
            usb_port_set(true); // pins to floating input, pull-up on
        }

        fn pma_alloc(self: *Self, alloc_size: u16) u16 {
            const addr = self.pma_next;
            assert(addr + alloc_size <= Pma.size);
            self.pma_next += alloc_size;
            return addr;
        }

        fn st(self: *Self, ep_num: types.Endpoint.Num, dir: types.Dir) *EP_State {
            return &self.endpoints[@backingInt(ep_num)][@backingInt(dir)];
        }

        fn on_bus_reset_local(self: *Self) void {
            // Clear state
            inline for (0..cfg.max_endpoints_count) |i| {
                self.endpoints[i][@backingInt(types.Dir.out)].rx_armed = false;
                self.endpoints[i][@backingInt(types.Dir.out)].rx_last_len = 0;
                self.endpoints[i][@backingInt(types.Dir.in)].tx_busy = false;
            }

            // Re-initialize BTABLE register and EP0 buffer descriptors
            USB_PERIPH.BTABLE.write_raw(0);
            const ep0_buf = self.st(.ep0, .out).pma_addr;
            Btable.set_tx_addr(0, ep0_buf);
            Btable.set_tx_count(0, 0);
            Btable.set_rx_addr(0, ep0_buf);
            Btable.set_rx_count(0, 64);

            // Fully re-configure EP0: EA=0, CONTROL type, clear DTOGs
            Epr.configure(0, .control, .nak, .valid);

            // Non-EP0 endpoint registers are already at 0x0000 (DISABLED)
            // after hardware bus reset — leave them alone. Setting them to
            // NAK with EA=0 would make them respond to EP0 traffic.

            // Set DADDR: enable function at address 0
            USB_PERIPH.DADDR.write(.{ .EF = 1, .ADD = 0 });
        }

        // --- comptime dispatch helpers ---

        fn call_on_buffer(self: *Self, dir: types.Dir, ep: u4, controller: anytype) void {
            switch (dir) {
                .in => switch (ep) {
                    inline 0...15 => |i| {
                        const num: types.Endpoint.Num = @fromBackingInt(@intCast(i));
                        controller.on_buffer(&self.interface, .{ .num = num, .dir = .in });
                    },
                },
                .out => switch (ep) {
                    inline 0...15 => |i| {
                        const num: types.Endpoint.Num = @fromBackingInt(@intCast(i));
                        controller.on_buffer(&self.interface, .{ .num = num, .dir = .out });
                    },
                },
            }
        }

        // --- Poll loop ---

        pub fn poll(self: *Self, in_isr: bool, controller: anytype) void {
            _ = in_isr;
            const istr = USB_PERIPH.ISTR.read();

            if (istr_is_reset(istr)) {
                USB_PERIPH.ISTR.write_raw(~ISTR_RST);
                set_address(&self.interface, 0);
                self.on_bus_reset_local();
                controller.on_bus_reset(&self.interface);
            }

            if (istr.CTR == 1) {
                self.handle_ctr(controller);
            }

            if (istr.SUSP == 1) {
                USB_PERIPH.ISTR.write_raw(~ISTR_SUSP);
            }

            if (istr.ERR == 1) {
                USB_PERIPH.ISTR.write_raw(~ISTR_ERR);
            }

            if (istr.PMAOVR == 1) {
                log.warn("PMA overrun", .{});
                USB_PERIPH.ISTR.write_raw(~ISTR_PMAOVR);
            }

            // Clear SOF/ESOF so they don't accumulate
            if (istr.SOF == 1 or istr.ESOF == 1) {
                USB_PERIPH.ISTR.write_raw(~(ISTR_SOF | ISTR_ESOF));
            }
        }

        fn handle_ctr(self: *Self, controller: anytype) void {
            // Read ISTR to get EP_ID and DIR
            const istr = USB_PERIPH.ISTR.read();
            const ep: u4 = istr.EP_ID;
            _ = istr.DIR;

            if (ep >= cfg.max_endpoints_count) return;

            const val = Epr.read(ep);

            if (val & Epr.ctr_rx != 0) {
                // SETUP or OUT
                const is_setup = (val & Epr.setup) != 0;
                Epr.clear_ctr_rx(ep);

                if (is_setup) {
                    self.handle_setup(ep, controller);
                } else {
                    self.handle_out(ep, controller);
                }
            }

            if (val & Epr.ctr_tx != 0) {
                Epr.clear_ctr_tx(ep);
                self.handle_in(ep, controller);
            }
        }

        fn handle_setup(self: *Self, ep: u4, controller: anytype) void {
            // Read 8-byte SETUP packet from PMA
            const rx_addr = Pma.read16(Btable.rx_addr_offset(ep));
            Pma.read_bytes(rx_addr, &self.staging_buf, 8);
            const setup_pkt: types.SetupPacket = @bitCast(self.staging_buf[0..8].*);

            // After SETUP, hardware forces STAT_TX=NAK, STAT_RX=NAK and
            // clears DTOG_TX/DTOG_RX. We set RX to VALID so EP0 can
            // receive the status stage or data stage.
            Epr.set_stat_rx(ep, .valid);

            const st_in = self.st(.ep0, .in);
            st_in.tx_busy = false;

            controller.on_setup_req(&self.interface, &setup_pkt);
        }

        fn handle_out(self: *Self, ep: u4, controller: anytype) void {
            const len = Btable.get_rx_count(ep);

            if (ep == 0) {
                const st_out = self.st(.ep0, .out);
                // Read data from PMA into staging buffer
                const rx_addr = Pma.read16(Btable.rx_addr_offset(ep));
                const n: usize = @min(@as(usize, len), 64);
                Pma.read_bytes(rx_addr, &self.staging_buf, n);
                st_out.rx_last_len = @intCast(n);
                // Re-arm EP0 RX
                Btable.set_rx_count(0, 64);
                Epr.set_stat_rx(0, .valid);
                self.call_on_buffer(.out, 0, controller);
                return;
            }

            const num: types.Endpoint.Num = @fromBackingInt(@intCast(ep));
            const st_out = self.st(num, .out);

            if (!st_out.rx_armed) return;

            // Read data from PMA into staging buffer
            const rx_addr = Pma.read16(Btable.rx_addr_offset(ep));
            const n: usize = @min(@as(usize, len), @as(usize, st_out.max_size));
            Pma.read_bytes(rx_addr, &self.staging_buf, n);

            st_out.rx_armed = false;
            st_out.rx_last_len = @intCast(n);
            // NAK until re-armed
            Epr.set_stat_rx(ep, .nak);

            self.call_on_buffer(.out, ep, controller);
        }

        fn handle_in(self: *Self, ep: u4, controller: anytype) void {
            const num: types.Endpoint.Num = @fromBackingInt(@intCast(ep));
            const st_in = self.st(num, .in);

            if (!st_in.tx_busy) return;

            st_in.tx_busy = false;
            // NAK until next write
            Epr.set_stat_tx(ep, .nak);

            self.call_on_buffer(.in, ep, controller);

            // After EP0 IN, re-arm EP0 OUT for next SETUP/status
            if (ep == 0) {
                Btable.set_rx_count(0, 64);
                Epr.set_stat_rx(0, .valid);
            }
        }

        // --- VTable functions ---

        fn set_address(_: *usb.DeviceInterface, addr: u7) void {
            log.debug("set_address to {}", .{addr});
            USB_PERIPH.DADDR.write(.{ .EF = 1, .ADD = addr });
        }

        fn ep_open(itf: *usb.DeviceInterface, desc_ptr: *const descriptor.Endpoint) void {
            const self: *Self = @fieldParentPtr("interface", itf);
            const desc = desc_ptr.*;
            const e = desc.endpoint;
            const ep_i: u4 = epn(e.num);
            assert(ep_i < cfg.max_endpoints_count);
            log.debug("ep_open ep{} dir={}", .{ ep_i, e.dir });

            const mps: u16 = desc.max_packet_size.native();
            assert(mps > 0 and mps <= 64);

            const out_st = self.st(e.num, .out);
            const in_st = self.st(e.num, .in);

            // Allocate PMA buffers on first open
            if (ep_i == 0) {
                // EP0 shares a single buffer for TX and RX
                if (out_st.pma_addr == 0 and out_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(64);
                    out_st.pma_addr = buf_addr;
                    out_st.max_size = 64;
                    in_st.pma_addr = buf_addr;
                    in_st.max_size = 64;

                    Btable.set_tx_addr(0, buf_addr);
                    Btable.set_tx_count(0, 0);
                    Btable.set_rx_addr(0, buf_addr);
                    Btable.set_rx_count(0, 64);

                    Epr.configure(0, .control, .nak, .valid);
                }
            } else {
                // Non-EP0: separate TX and RX buffers
                if (e.dir == .out and out_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(mps);
                    out_st.pma_addr = buf_addr;
                    out_st.max_size = mps;

                    Btable.set_rx_addr(ep_i, buf_addr);
                    Btable.set_rx_count(ep_i, mps);
                }
                if (e.dir == .in and in_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(mps);
                    in_st.pma_addr = buf_addr;
                    in_st.max_size = mps;

                    Btable.set_tx_addr(ep_i, buf_addr);
                    Btable.set_tx_count(ep_i, 0);
                }

                // Determine EP type
                const ep_type: EpType = switch (desc.attributes.transfer_type) {
                    .Control => .control,
                    .Isochronous => .iso,
                    .Bulk => .bulk,
                    .Interrupt => .interrupt,
                };

                // Configure EPR with the endpoint type
                // We need to read current EPR to check if already configured
                const cur = Epr.read(ep_i);
                if (cur & Epr.ea_mask != @as(u16, ep_i)) {
                    // First time configuring this endpoint
                    Epr.configure(ep_i, ep_type, .nak, .nak);
                }

                // Set the appropriate direction to desired state
                switch (e.dir) {
                    .out => Epr.set_stat_rx(ep_i, .nak),
                    .in => Epr.set_stat_tx(ep_i, .nak),
                }
            }
        }

        fn ep_listen(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, len: types.Len) void {
            log.debug("ep_listen ep{} len={}", .{ ep_num, len });
            const self: *Self = @fieldParentPtr("interface", itf);

            if (ep_num == .ep0) {
                const st0 = self.st(.ep0, .out);
                st0.rx_limit = @intCast(len);
                return;
            }

            const ep_i: u4 = epn(ep_num);
            if (ep_i >= cfg.max_endpoints_count)
                @panic("ep_listen called for invalid endpoint");

            const st_out = self.st(ep_num, .out);
            if (st_out.max_size == 0)
                @panic("ep_listen called for endpoint with no buffer allocated");
            if (st_out.rx_armed)
                @panic("ep_listen called while OUT endpoint already armed");

            const limit: u16 = @intCast(@min(@as(usize, st_out.max_size), @as(usize, @intCast(len))));
            st_out.rx_limit = limit;
            st_out.rx_armed = true;
            st_out.rx_last_len = 0;

            // Prepare BTABLE RX count and set RX to VALID
            Btable.set_rx_count(ep_i, limit);
            Epr.set_stat_rx(ep_i, .valid);
        }

        fn ep_readv(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, data: []const []u8) types.Len {
            const self: *Self = @fieldParentPtr("interface", itf);
            const st_out = self.st(ep_num, .out);

            const want: usize = @as(usize, st_out.rx_last_len);
            defer st_out.rx_last_len = 0;

            // Data was already read from PMA into staging_buf during handle_out/handle_setup
            var remaining: []const u8 = self.staging_buf[0..want];
            var copied: usize = 0;

            for (data) |dst| {
                if (remaining.len == 0) break;
                const n = @min(dst.len, remaining.len);
                @memcpy(dst[0..n], remaining[0..n]);
                remaining = remaining[n..];
                copied += n;
            }

            return @intCast(copied);
        }

        fn ep_writev(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, vec: []const []const u8) types.Len {
            log.debug("ep_writev called for ep{} with {} chunks", .{ ep_num, vec.len });
            const self: *Self = @fieldParentPtr("interface", itf);
            assert(vec.len > 0);

            const ep_i: u4 = epn(ep_num);
            assert(ep_i < cfg.max_endpoints_count);

            const st_in = self.st(ep_num, .in);
            if (st_in.max_size == 0)
                @panic("ep_writev called for endpoint with no buffer allocated");

            if (st_in.tx_busy) {
                log.warn("ep_writev called while {} IN endpoint busy, returning 0", .{ep_num});
                return 0;
            }

            // Gather vector data into staging buffer
            var w: usize = 0;
            for (vec) |chunk| {
                if (w >= st_in.max_size) break;
                const n = @min(chunk.len, @as(usize, st_in.max_size) - w);
                @memcpy(self.staging_buf[w .. w + n], chunk[0..n]);
                w += n;
            }

            // Write to PMA
            const tx_addr = Pma.read16(Btable.tx_addr_offset(ep_i));
            Pma.write_bytes(tx_addr, self.staging_buf[0..w]);
            Btable.set_tx_count(ep_i, @intCast(w));

            st_in.tx_busy = true;
            Epr.set_stat_tx(ep_i, .valid);

            return @intCast(w);
        }

        // --- USB port control (matches WCH EVT USB_Port_Set) ---

        const gpio = @import("gpio.zig");
        const pa11 = gpio.Pin.init(0, 11); // PA11 = USB D-
        const pa12 = gpio.Pin.init(0, 12); // PA12 = USB D+

        fn usb_port_set(enable: bool) void {
            if (enable) {
                // Set PA11/PA12 to floating input so USB peripheral drives them
                pa11.set_input_mode(.floating);
                pa12.set_input_mode(.floating);
                // Enable D+ internal 1.5K pull-up
                EXTEND.EXTEND_CTR.modify(.{ .USBDPU = 1 });
            } else {
                // Disable D+ pull-up
                EXTEND.EXTEND_CTR.modify(.{ .USBDPU = 0 });
                // Drive PA11/PA12 low as push-pull outputs → SE0 = disconnect
                pa11.set_output_mode(.general_purpose_push_pull, .max_2MHz);
                pa12.set_output_mode(.general_purpose_push_pull, .max_2MHz);
                pa11.put(0);
                pa12.put(0);
            }
        }

        // --- HW init ---

        fn usbd_hw_init() void {
            // 1. Power up: clear PDWN while keeping FRES asserted.
            //    Reset value of CNTR is 0x0003 (FRES | PDWN).
            USB_PERIPH.CNTR.write(.{ .FRES = 1, .PDWN = 0 });

            // 2. Wait for analog transceiver startup (tSTARTUP >= 1us)
            time.delay_us(2); // 2us with margin

            // 3. Clear FRES to release USB from reset.
            //    EPR registers are held at 0 while FRES=1, so all
            //    endpoint configuration must happen AFTER this point.
            USB_PERIPH.CNTR.write(.{ .FRES = 0, .PDWN = 0 });

            // 4. Clear all interrupt flags
            USB_PERIPH.ISTR.write_raw(0);

            // 5. Set BTABLE = 0 (BTABLE at start of PMA)
            USB_PERIPH.BTABLE.write_raw(0);

            // 6. Enable function at address 0
            USB_PERIPH.DADDR.write(.{ .EF = 1, .ADD = 0 });

            // 7. Zero out the BTABLE area in PMA
            inline for (0..Btable.size / 2) |i| {
                Pma.write16(@intCast(i * 2), 0);
            }
        }
    };
}
