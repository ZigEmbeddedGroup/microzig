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

const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_dev);

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const usb = microzig.core.usb;
const types = usb.types;
const descriptor = usb.descriptor;

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

/// Packet Memory Area base (CPU address space)
const PMA_BASE: usize = 0x40006000;
/// PMA size in bytes (peripheral address space)
const PMA_SIZE: usize = 512;
/// PMA access multiplier: each u16 PMA word occupies a u32 slot in CPU
/// address space (2x mapping), same as STM32F103.
const PMA_ACCESS_MULT: usize = 2;

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

// -- EPR bit positions / masks (raw access needed for toggle-on-write) --
const EPR_EA_MASK: u16 = 0x000F; // [3:0]   Endpoint Address
const EPR_STAT_TX_MASK: u16 = 0x0030; // [5:4]   TX Status (toggle)
const EPR_DTOG_TX: u16 = 0x0040; // [6]     TX Data Toggle (toggle)
const EPR_CTR_TX: u16 = 0x0080; // [7]     Correct Transfer TX (W0C)
const EPR_EP_KIND: u16 = 0x0100; // [8]     Endpoint Kind
const EPR_EP_TYPE_MASK: u16 = 0x0600; // [10:9]  Endpoint Type
const EPR_SETUP: u16 = 0x0800; // [11]    Setup transaction completed (RO)
const EPR_STAT_RX_MASK: u16 = 0x3000; // [13:12] RX Status (toggle)
const EPR_DTOG_RX: u16 = 0x4000; // [14]    RX Data Toggle (toggle)
const EPR_CTR_RX: u16 = 0x8000; // [15]    Correct Transfer RX (W0C)

// Bits that are read/write (non-toggle, non-W0C): EA, EP_KIND, EP_TYPE
const EPR_RW_MASK: u16 = EPR_EA_MASK | EPR_EP_KIND | EPR_EP_TYPE_MASK;

// EP_TYPE values (written into EPR bits [10:9])
const EP_TYPE_BULK: u16 = 0x0000;
const EP_TYPE_CONTROL: u16 = 0x0200;
const EP_TYPE_ISO: u16 = 0x0400;
const EP_TYPE_INTERRUPT: u16 = 0x0600;

// STAT_TX / STAT_RX values (2-bit field)
const STAT_DISABLED: u2 = 0b00;
const STAT_STALL: u2 = 0b01;
const STAT_NAK: u2 = 0b10;
const STAT_VALID: u2 = 0b11;

/// ISTR helper (field names differ between chips: RST vs RESET)
fn istr_is_reset(istr: Istr) bool {
    return if (@hasField(Istr, "RST")) istr.RST == 1 else istr.RESET == 1;
}

// --- Raw EPR reg access (bypass MMIO due to toggle-on-write semantics) ---

/// EPR registers: 0x00..0x1C (8 x u16 at u32 spacing).
/// These CANNOT use MMIO modify() because STAT_TX/RX, DTOG_TX/RX are
/// toggle-on-write, and CTR_TX/RX are write-0-to-clear.
fn epr_ptr(ep: u4) *volatile u16 {
    return @ptrFromInt(USBD_BASE + @as(usize, ep) * 4);
}

fn epr_read(ep: u4) u16 {
    return epr_ptr(ep).*;
}

fn epr_write(ep: u4, val: u16) void {
    epr_ptr(ep).* = val;
}

// --- EPR manipulation helpers (XOR trick for toggle bits) ---

/// Set STAT_TX to desired value using XOR trick.
fn epr_set_stat_tx(ep: u4, stat: u2) void {
    const val = epr_read(ep);
    const current: u2 = @truncate((val & EPR_STAT_TX_MASK) >> 4);
    const xor_val: u16 = @as(u16, current ^ stat) << 4;
    // Preserve RW bits, set W0C bits to 1 (don't clear), zero other toggle bits
    const write_val = (val & EPR_RW_MASK) | EPR_CTR_TX | EPR_CTR_RX | xor_val;
    epr_write(ep, write_val);
}

/// Set STAT_RX to desired value using XOR trick.
fn epr_set_stat_rx(ep: u4, stat: u2) void {
    const val = epr_read(ep);
    const current: u2 = @truncate((val & EPR_STAT_RX_MASK) >> 12);
    const xor_val: u16 = @as(u16, current ^ stat) << 12;
    const write_val = (val & EPR_RW_MASK) | EPR_CTR_TX | EPR_CTR_RX | xor_val;
    epr_write(ep, write_val);
}

/// Set both STAT_TX and STAT_RX simultaneously.
fn epr_set_stat_txrx(ep: u4, stat_tx: u2, stat_rx: u2) void {
    const val = epr_read(ep);
    const cur_tx: u2 = @truncate((val & EPR_STAT_TX_MASK) >> 4);
    const cur_rx: u2 = @truncate((val & EPR_STAT_RX_MASK) >> 12);
    const xor_tx: u16 = @as(u16, cur_tx ^ stat_tx) << 4;
    const xor_rx: u16 = @as(u16, cur_rx ^ stat_rx) << 12;
    const write_val = (val & EPR_RW_MASK) | EPR_CTR_TX | EPR_CTR_RX | xor_tx | xor_rx;
    epr_write(ep, write_val);
}

/// Clear CTR_TX (write 0 to the W0C bit, keep CTR_RX as 1).
fn epr_clear_ctr_tx(ep: u4) void {
    const val = epr_read(ep);
    epr_write(ep, (val & EPR_RW_MASK) | EPR_CTR_RX);
}

/// Clear CTR_RX (write 0 to the W0C bit, keep CTR_TX as 1).
fn epr_clear_ctr_rx(ep: u4) void {
    const val = epr_read(ep);
    epr_write(ep, (val & EPR_RW_MASK) | EPR_CTR_TX);
}

/// Clear DTOG_TX by toggling it if currently set.
fn epr_clear_dtog_tx(ep: u4) void {
    const val = epr_read(ep);
    if (val & EPR_DTOG_TX != 0) {
        epr_write(ep, (val & EPR_RW_MASK) | EPR_CTR_TX | EPR_CTR_RX | EPR_DTOG_TX);
    }
}

/// Clear DTOG_RX by toggling it if currently set.
fn epr_clear_dtog_rx(ep: u4) void {
    const val = epr_read(ep);
    if (val & EPR_DTOG_RX != 0) {
        epr_write(ep, (val & EPR_RW_MASK) | EPR_CTR_TX | EPR_CTR_RX | EPR_DTOG_RX);
    }
}

/// Configure an endpoint: set EA, EP_TYPE, clear toggles, set initial status.
fn epr_configure(ep: u4, ep_type: u16, stat_tx: u2, stat_rx: u2) void {
    // First write: set EA, EP_TYPE, clear everything else
    const base: u16 = (@as(u16, ep) & EPR_EA_MASK) | (ep_type & EPR_EP_TYPE_MASK) | EPR_CTR_TX | EPR_CTR_RX;
    epr_write(ep, base);

    // Now set desired status bits using XOR trick
    epr_set_stat_txrx(ep, stat_tx, stat_rx);

    // Clear data toggles
    epr_clear_dtog_tx(ep);
    epr_clear_dtog_rx(ep);
}

// --- PMA (Packet Memory Area) access helpers ---

// The BTABLE descriptor for each endpoint occupies 8 bytes in PMA space
// (4 x u16 words). With 2x mapping, each u16 occupies a u32 slot in CPU
// address space (only lower 16 bits valid).
//
// Layout per endpoint (PMA offsets):
//   +0: TX_ADDR   (u16)
//   +2: TX_COUNT  (u16)
//   +4: RX_ADDR   (u16)
//   +6: RX_COUNT  (u16)

/// Read a u16 from PMA at the given PMA byte offset.
fn pma_read16(pma_offset: u16) u16 {
    const addr: usize = PMA_BASE + @as(usize, pma_offset) * PMA_ACCESS_MULT;
    const ptr: *volatile u32 = @ptrFromInt(addr);
    return @truncate(ptr.*);
}

/// Write a u16 to PMA at the given PMA byte offset.
fn pma_write16(pma_offset: u16, val: u16) void {
    const addr: usize = PMA_BASE + @as(usize, pma_offset) * PMA_ACCESS_MULT;
    const ptr: *volatile u32 = @ptrFromInt(addr);
    ptr.* = val;
}

/// BTABLE descriptor field offsets (in PMA u16 words = 2 bytes each)
fn btable_tx_addr_offset(ep: u4) u16 {
    return @as(u16, ep) * 8 + 0;
}
fn btable_tx_count_offset(ep: u4) u16 {
    return @as(u16, ep) * 8 + 2;
}
fn btable_rx_addr_offset(ep: u4) u16 {
    return @as(u16, ep) * 8 + 4;
}
fn btable_rx_count_offset(ep: u4) u16 {
    return @as(u16, ep) * 8 + 6;
}

fn btable_set_tx_addr(ep: u4, pma_addr: u16) void {
    pma_write16(btable_tx_addr_offset(ep), pma_addr);
}
fn btable_set_tx_count(ep: u4, count: u16) void {
    pma_write16(btable_tx_count_offset(ep), count);
}
fn btable_get_tx_count(ep: u4) u16 {
    return pma_read16(btable_tx_count_offset(ep)) & 0x03FF;
}
fn btable_set_rx_addr(ep: u4, pma_addr: u16) void {
    pma_write16(btable_rx_addr_offset(ep), pma_addr);
}

/// Set RX_COUNT with block size encoding for max receivable bytes.
/// For sizes <= 62: BL_SIZE=0, NUM_BLOCK = size/2
/// For sizes > 62:  BL_SIZE=1, NUM_BLOCK = size/32 - 1
fn btable_set_rx_count(ep: u4, max_size: u16) void {
    var val: u16 = 0;
    if (max_size <= 62) {
        // BL_SIZE=0, NUM_BLOCK = max_size/2
        val = (max_size / 2) << 10;
    } else {
        // BL_SIZE=1, NUM_BLOCK = max_size/32 - 1
        val = (1 << 15) | (((max_size / 32) - 1) << 10);
    }
    pma_write16(btable_rx_count_offset(ep), val);
}

fn btable_get_rx_count(ep: u4) u16 {
    return pma_read16(btable_rx_count_offset(ep)) & 0x03FF;
}

/// Copy bytes from CPU memory into PMA.
fn pma_write_bytes(pma_offset: u16, data: []const u8) void {
    var off = pma_offset;
    var i: usize = 0;
    while (i < data.len) {
        const lo: u16 = data[i];
        const hi: u16 = if (i + 1 < data.len) data[i + 1] else 0;
        pma_write16(off, lo | (hi << 8));
        off += 2;
        i += 2;
    }
}

/// Copy bytes from PMA into CPU memory.
fn pma_read_bytes(pma_offset: u16, buf: []u8, count: usize) void {
    var off = pma_offset;
    var i: usize = 0;
    while (i < count) {
        const word = pma_read16(off);
        buf[i] = @truncate(word);
        if (i + 1 < count) {
            buf[i + 1] = @truncate(word >> 8);
        }
        off += 2;
        i += 2;
    }
}

// --- PMA buffer allocation (static layout, bump pointer) ---

/// PMA memory layout:
///   0x00 - 0x3F: BTABLE (8 eps x 8 bytes = 64 bytes)
///   0x40+:       endpoint buffers
const PMA_BTABLE_SIZE: u16 = 64; // 8 endpoints * 8 bytes

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
    return @as(u4, @intCast(@intFromEnum(ep)));
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
            self.pma_next = PMA_BTABLE_SIZE;

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
            epr_set_stat_rx(0, STAT_VALID);

            // Enable interrupt masks: bus reset and correct transfer
            USB_PERIPH.CNTR.write(.{ .FRES = 0, .PDWN = 0, .RESETM = 1, .CTRM = 1 });
            USB_PERIPH.ISTR.write_raw(0); // clear any flags raised during init

            // Force a clean disconnect/connect cycle so the host detects
            // a fresh device attach (matches WCH EVT USB_Port_Set pattern).
            usb_port_set(false); // pull-up off, drive D+/D- low (SE0)
            {
                // ~20ms delay at 48MHz
                var d: u32 = 0;
                while (d < 960_000) : (d += 1) {
                    asm volatile ("nop");
                }
            }
            usb_port_set(true); // pins to floating input, pull-up on
        }

        fn pma_alloc(self: *Self, size: u16) u16 {
            const addr = self.pma_next;
            assert(addr + size <= PMA_SIZE);
            self.pma_next += size;
            return addr;
        }

        fn st(self: *Self, ep_num: types.Endpoint.Num, dir: types.Dir) *EP_State {
            return &self.endpoints[@intFromEnum(ep_num)][@intFromEnum(dir)];
        }

        fn on_bus_reset_local(self: *Self) void {
            // Clear state
            inline for (0..cfg.max_endpoints_count) |i| {
                self.endpoints[i][@intFromEnum(types.Dir.Out)].rx_armed = false;
                self.endpoints[i][@intFromEnum(types.Dir.Out)].rx_last_len = 0;
                self.endpoints[i][@intFromEnum(types.Dir.In)].tx_busy = false;
            }

            // Re-initialize BTABLE register and EP0 buffer descriptors
            USB_PERIPH.BTABLE.write_raw(0);
            const ep0_buf = self.st(.ep0, .Out).pma_addr;
            btable_set_tx_addr(0, ep0_buf);
            btable_set_tx_count(0, 0);
            btable_set_rx_addr(0, ep0_buf);
            btable_set_rx_count(0, 64);

            // Fully re-configure EP0: EA=0, CONTROL type, clear DTOGs
            epr_configure(0, EP_TYPE_CONTROL, STAT_NAK, STAT_VALID);

            // Non-EP0 endpoint registers are already at 0x0000 (DISABLED)
            // after hardware bus reset — leave them alone. Setting them to
            // NAK with EA=0 would make them respond to EP0 traffic.

            // Set DADDR: enable function at address 0
            USB_PERIPH.DADDR.write(.{ .EF = 1, .ADD = 0 });
        }

        // --- comptime dispatch helpers ---

        fn call_on_buffer(self: *Self, dir: types.Dir, ep: u4, controller: anytype) void {
            switch (dir) {
                .In => switch (ep) {
                    inline 0...15 => |i| {
                        const num: types.Endpoint.Num = @enumFromInt(i);
                        controller.on_buffer(&self.interface, .{ .num = num, .dir = .In });
                    },
                },
                .Out => switch (ep) {
                    inline 0...15 => |i| {
                        const num: types.Endpoint.Num = @enumFromInt(i);
                        controller.on_buffer(&self.interface, .{ .num = num, .dir = .Out });
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

            const val = epr_read(ep);

            if (val & EPR_CTR_RX != 0) {
                // SETUP or OUT
                const is_setup = (val & EPR_SETUP) != 0;
                epr_clear_ctr_rx(ep);

                if (is_setup) {
                    self.handle_setup(ep, controller);
                } else {
                    self.handle_out(ep, controller);
                }
            }

            if (val & EPR_CTR_TX != 0) {
                epr_clear_ctr_tx(ep);
                self.handle_in(ep, controller);
            }
        }

        fn handle_setup(self: *Self, ep: u4, controller: anytype) void {
            // Read 8-byte SETUP packet from PMA
            const rx_addr = pma_read16(btable_rx_addr_offset(ep));
            pma_read_bytes(rx_addr, &self.staging_buf, 8);
            const setup: types.SetupPacket = @bitCast(self.staging_buf[0..8].*);

            // After SETUP, hardware forces STAT_TX=NAK, STAT_RX=NAK and
            // clears DTOG_TX/DTOG_RX. We set RX to VALID so EP0 can
            // receive the status stage or data stage.
            epr_set_stat_rx(ep, STAT_VALID);

            const st_in = self.st(.ep0, .In);
            st_in.tx_busy = false;

            controller.on_setup_req(&self.interface, &setup);
        }

        fn handle_out(self: *Self, ep: u4, controller: anytype) void {
            const len = btable_get_rx_count(ep);

            if (ep == 0) {
                const st_out = self.st(.ep0, .Out);
                // Read data from PMA into staging buffer
                const rx_addr = pma_read16(btable_rx_addr_offset(ep));
                const n: usize = @min(@as(usize, len), 64);
                pma_read_bytes(rx_addr, &self.staging_buf, n);
                st_out.rx_last_len = @intCast(n);
                // Re-arm EP0 RX
                btable_set_rx_count(0, 64);
                epr_set_stat_rx(0, STAT_VALID);
                self.call_on_buffer(.Out, 0, controller);
                return;
            }

            const num: types.Endpoint.Num = @enumFromInt(ep);
            const st_out = self.st(num, .Out);

            if (!st_out.rx_armed) return;

            // Read data from PMA into staging buffer
            const rx_addr = pma_read16(btable_rx_addr_offset(ep));
            const n: usize = @min(@as(usize, len), @as(usize, st_out.max_size));
            pma_read_bytes(rx_addr, &self.staging_buf, n);

            st_out.rx_armed = false;
            st_out.rx_last_len = @intCast(n);
            // NAK until re-armed
            epr_set_stat_rx(ep, STAT_NAK);

            self.call_on_buffer(.Out, ep, controller);
        }

        fn handle_in(self: *Self, ep: u4, controller: anytype) void {
            const num: types.Endpoint.Num = @enumFromInt(ep);
            const st_in = self.st(num, .In);

            if (!st_in.tx_busy) return;

            st_in.tx_busy = false;
            // NAK until next write
            epr_set_stat_tx(ep, STAT_NAK);

            self.call_on_buffer(.In, ep, controller);

            // After EP0 IN, re-arm EP0 OUT for next SETUP/status
            if (ep == 0) {
                btable_set_rx_count(0, 64);
                epr_set_stat_rx(0, STAT_VALID);
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

            const mps: u16 = desc.max_packet_size.into();
            assert(mps > 0 and mps <= 64);

            const out_st = self.st(e.num, .Out);
            const in_st = self.st(e.num, .In);

            // Allocate PMA buffers on first open
            if (ep_i == 0) {
                // EP0 shares a single buffer for TX and RX
                if (out_st.pma_addr == 0 and out_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(64);
                    out_st.pma_addr = buf_addr;
                    out_st.max_size = 64;
                    in_st.pma_addr = buf_addr;
                    in_st.max_size = 64;

                    btable_set_tx_addr(0, buf_addr);
                    btable_set_tx_count(0, 0);
                    btable_set_rx_addr(0, buf_addr);
                    btable_set_rx_count(0, 64);

                    epr_configure(0, EP_TYPE_CONTROL, STAT_NAK, STAT_VALID);
                }
            } else {
                // Non-EP0: separate TX and RX buffers
                if (e.dir == .Out and out_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(mps);
                    out_st.pma_addr = buf_addr;
                    out_st.max_size = mps;

                    btable_set_rx_addr(ep_i, buf_addr);
                    btable_set_rx_count(ep_i, mps);
                }
                if (e.dir == .In and in_st.max_size == 0) {
                    const buf_addr = self.pma_alloc(mps);
                    in_st.pma_addr = buf_addr;
                    in_st.max_size = mps;

                    btable_set_tx_addr(ep_i, buf_addr);
                    btable_set_tx_count(ep_i, 0);
                }

                // Determine EP type
                const ep_type: u16 = switch (desc.attributes.transfer_type) {
                    .Control => EP_TYPE_CONTROL,
                    .Isochronous => EP_TYPE_ISO,
                    .Bulk => EP_TYPE_BULK,
                    .Interrupt => EP_TYPE_INTERRUPT,
                };

                // Configure EPR with the endpoint type
                // We need to read current EPR to check if already configured
                const cur = epr_read(ep_i);
                if (cur & EPR_EA_MASK != @as(u16, ep_i)) {
                    // First time configuring this endpoint
                    epr_configure(ep_i, ep_type, STAT_NAK, STAT_NAK);
                }

                // Set the appropriate direction to desired state
                switch (e.dir) {
                    .Out => epr_set_stat_rx(ep_i, STAT_NAK),
                    .In => epr_set_stat_tx(ep_i, STAT_NAK),
                }
            }
        }

        fn ep_listen(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, len: types.Len) void {
            log.debug("ep_listen ep{} len={}", .{ ep_num, len });
            const self: *Self = @fieldParentPtr("interface", itf);

            if (ep_num == .ep0) {
                const st0 = self.st(.ep0, .Out);
                st0.rx_limit = @intCast(len);
                return;
            }

            const ep_i: u4 = epn(ep_num);
            if (ep_i >= cfg.max_endpoints_count)
                @panic("ep_listen called for invalid endpoint");

            const st_out = self.st(ep_num, .Out);
            if (st_out.max_size == 0)
                @panic("ep_listen called for endpoint with no buffer allocated");
            if (st_out.rx_armed)
                @panic("ep_listen called while OUT endpoint already armed");

            const limit: u16 = @intCast(@min(@as(usize, st_out.max_size), @as(usize, @intCast(len))));
            st_out.rx_limit = limit;
            st_out.rx_armed = true;
            st_out.rx_last_len = 0;

            // Prepare BTABLE RX count and set RX to VALID
            btable_set_rx_count(ep_i, limit);
            epr_set_stat_rx(ep_i, STAT_VALID);
        }

        fn ep_readv(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, data: []const []u8) types.Len {
            const self: *Self = @fieldParentPtr("interface", itf);
            const st_out = self.st(ep_num, .Out);

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

            const st_in = self.st(ep_num, .In);
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
            const tx_addr = pma_read16(btable_tx_addr_offset(ep_i));
            pma_write_bytes(tx_addr, self.staging_buf[0..w]);
            btable_set_tx_count(ep_i, @intCast(w));

            st_in.tx_busy = true;
            epr_set_stat_tx(ep_i, STAT_VALID);

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
            var i: u32 = 0;
            while (i < 1000) : (i += 1) {
                asm volatile ("nop");
            }

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
            {
                var off: u16 = 0;
                while (off < PMA_BTABLE_SIZE) : (off += 2) {
                    pma_write16(off, 0);
                }
            }
        }
    };
}
