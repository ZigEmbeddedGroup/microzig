//! WCH USBHD/USBHS device backend
//!

const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_dev);

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const usb = microzig.core.usb;
const types = usb.types;
const descriptor = usb.descriptor;

pub const USBHD_MAX_ENDPOINTS_COUNT = 16;

const max_buffer_pool_size = USBHD_MAX_ENDPOINTS_COUNT * 2 * 512 + 64;

pub const Config = struct {
    max_endpoints_count: comptime_int = USBHD_MAX_ENDPOINTS_COUNT,

    prefer_high_speed: bool = true,

    /// Static buffer pool in SRAM, bump-allocated.
    buffer_bytes: comptime_int = max_buffer_pool_size,

    /// Future seam only; not implemented in this initial version.
    use_interrupts: bool = false,
};

const Regs = peripherals.USBHS;

const EpState = struct {
    buf: []align(4) u8 = &[_]u8{},
    // OUT:
    rx_armed: bool = false,
    rx_limit: u16 = 0,
    rx_last_len: u16 = 0, // valid until ep_readv() consumes it
    // IN:
    tx_busy: bool = false,
};

fn PerEndpointArray(comptime N: comptime_int) type {
    return [N][2]EpState; // [ep][dir]
}

fn epn(ep: types.Endpoint.Num) u4 {
    return @as(u4, @intCast(@intFromEnum(ep)));
}
fn speed_type(comptime cfg: Config) u2 {
    if (!cfg.prefer_high_speed) return 0; // FS
    return 1;
}

// --- USBHD token encodings ---
const Token = enum(u2) {
    Out = 0,
    Sof = 1,
    In = 2,
    Setup = 3,
};

const TOKEN_OUT: u2 = 0;
const TOKEN_SOF: u2 = 1;
const TOKEN_IN: u2 = 2;
const TOKEN_SETUP: u2 = 3;

// --- INT_FG raw bits (match USBHS.zig packed order) ---
const UIF_BUS_RST: u8 = 1 << 0;
const UIF_TRANSFER: u8 = 1 << 1;
const UIF_SUSPEND: u8 = 1 << 2;
const UIF_HST_SOF: u8 = 1 << 3;
const UIF_FIFO_OV: u8 = 1 << 4;
const UIF_SETUP_ACT: u8 = 1 << 5;
const UIF_ISO_ACT: u8 = 1 << 6;

// --- endpoint response encodings (WCH style) ---
const RES_ACK: u2 = 0;
const RES_NAK: u2 = 2;
const RES_STALL: u2 = 3;

const Res = enum(u2) {
    ACK = 0,
    NAK = 2,
    STALL = 3,
};

const TOG_DATA0: u2 = 0;
const TOG_DATA1: u2 = 1;

const Tog = enum(u2) {
    DATA0 = 0,
    DATA1 = 0b1,
    DATA2 = 0b10,
    MDATA = 0b11,
};

fn toggle_next(tog: u2) u2 {
    return if (tog == TOG_DATA0) TOG_DATA1 else TOG_DATA0;
}

// We use offset-based access for per-EP regs to keep helpers compact.
const RegU32 = microzig.mmio.Mmio(packed struct(u32) { v: u32 = 0 });
const RegU16 = microzig.mmio.Mmio(packed struct(u16) { v: u16 = 0 });
const RegU8 = microzig.mmio.Mmio(packed struct(u8) { v: u8 = 0 });
pub const RegCtrl = microzig.mmio.Mmio(packed struct(u8) {
    RES: u2 = 0,
    _reserved0: u1 = 0,
    TOG: u2 = 0,
    AUTO: bool = false,
    _reserved1: u2 = 0,
});

fn baseAddr() usize {
    return @intFromPtr(peripherals.USBHS);
}
fn mmio_u32(off: usize) *volatile RegU32 {
    return @ptrFromInt(baseAddr() + off);
}
fn mmio_u16(off: usize) *volatile RegU16 {
    return @ptrFromInt(baseAddr() + off);
}
fn mmio_tx_ctrl(off: usize) *volatile RegCtrl {
    return @ptrFromInt(baseAddr() + off);
}
fn mmio_rx_ctrl(off: usize) *volatile RegCtrl {
    return @ptrFromInt(baseAddr() + off);
}

// RX DMA: 0x20 + (ep-1)*4  (EP1..EP15)
// EP0 has its own dedicated DMA reg.
fn ep0_dma() *volatile RegU32 {
    return mmio_u32(0x1C);
}
fn uep_rx_dma(ep: u4) *volatile RegU32 {
    return mmio_u32(0x20 + (@as(usize, ep - 1) * 4));
}
// TX DMA: 0x5C + (ep-1)*4  (EP1..EP15)
fn uep_tx_dma(ep: u4) *volatile RegU32 {
    return mmio_u32(0x5C + (@as(usize, ep - 1) * 4));
}
// MAX_LEN: EP0..EP15 at 0x98 + ep*4
fn uep_max_len(ep: u4) *volatile RegU16 {
    return mmio_u16(0x98 + (@as(usize, ep) * 4));
}
// T_LEN: EP0..EP15 at 0xD8 + ep*4
fn uep_t_len(ep: u4) *volatile RegU16 {
    return mmio_u16(0xD8 + (@as(usize, ep) * 4));
}
// TX_CTRL: 0xDA + ep*4, RX_CTRL: 0xDB + ep*4
pub fn uep_tx_ctrl(ep: u4) *volatile RegCtrl {
    const ret: *volatile RegCtrl = mmio_tx_ctrl(0xDA + (@as(usize, ep) * 4));
    return ret;
}

fn uep_rx_ctrl(ep: u4) *volatile RegCtrl {
    return mmio_rx_ctrl(0xDB + (@as(usize, ep) * 4));
}

fn set_tx_ctrl(ep: u4, res: u2, tog: u2, auto: bool) void {
    // [1:0]=RES, [4:3]=TOG, [5]=AUTO
    const tx_ctrl: *volatile RegCtrl = uep_tx_ctrl(ep);
    tx_ctrl.write(.{
        .RES = res,
        .TOG = tog,
        .AUTO = auto,
    });
}
fn set_rx_ctrl(ep: u4, res: u2, tog: u2, auto: bool) void {
    // std.log.debug("ch32: set_rx_ctrl ep={} res={} tog={} auto={}", .{ ep, res, tog, auto });
    const ctrl: *volatile RegCtrl = uep_rx_ctrl(ep);
    ctrl.write(.{
        .RES = res,
        .TOG = tog,
        .AUTO = auto,
    });
}

fn current_rx_tog(ep: u4) u2 {
    return uep_rx_ctrl(ep).read().TOG;
}
fn current_tx_tog(ep: u4) u2 {
    return uep_tx_ctrl(ep).read().TOG;
}

/// Polled USBHD device backend for microzig core USB controller.
/// maybe we should pass a list of valid controller types, for validation
pub fn Polled(comptime cfg: Config) type {
    comptime {
        if (cfg.max_endpoints_count > USBHD_MAX_ENDPOINTS_COUNT)
            @compileError("USBHD max_endpoints_count cannot exceed 16");
        if (cfg.buffer_bytes < 64)
            @compileError("USBHD buffer_bytes must be at least 64");
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
        pool: [cfg.buffer_bytes]u8 = undefined,

        buffer_pool: []align(4) u8,

        interface: usb.DeviceInterface,

        pub fn init() Self {
            var self: Self = .{
                .endpoints = undefined,
                .buffer_pool = undefined,
                .interface = .{ .vtable = &vtable },
            };
            @memset(std.mem.asBytes(&self.endpoints), 0);
            @memset(self.pool[0..64], 0x7e);
            @memset(self.pool[64..], 0);

            self.buffer_pool = @alignCast(self.pool[64..]);

            usbhd_hw_init();

            // EP0 is required; open OUT then IN (or vice versa), we will share buffer.
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

            // EP0 OUT should always be able to accept status-stage OUT ZLP.
            // So keep EP0 RX in ACK state permanently.
            self.arm_ep0_out_always();

            // Connect pull-up to signal device ready
            Regs.USB_CTRL.modify(.{ .RB_UC_DEV_PU_EN = 1 });

            Regs.USB_CTRL.modify(.{
                .RB_UC_CLR_ALL = 0,
            });

            return self;
        }

        // TODO: replace with fixedbuffer allocator?
        fn endpoint_alloc(self: *Self, size: usize) []align(4) u8 {
            assert(self.buffer_pool.len >= size);
            const out = self.buffer_pool[0..size];
            self.buffer_pool = @alignCast(self.buffer_pool[size..]);
            return out;
        }

        fn st(self: *Self, ep_num: types.Endpoint.Num, dir: types.Dir) *EpState {
            return &self.endpoints[@intFromEnum(ep_num)][@intFromEnum(dir)];
        }

        fn arm_ep0_out_always(self: *Self) void {
            _ = self;
            // EP0 OUT is always ACK.
            set_rx_ctrl(0, RES_ACK, TOG_DATA0, false);
            // EP0 IN remains NAK until data is queued.
            // set_tx_ctrl(0, RES_NAK, TOG_DATA0, false);
        }

        fn on_bus_reset_local(self: *Self) void {
            // Clear state
            inline for (0..cfg.max_endpoints_count) |i| {
                self.endpoints[i][@intFromEnum(types.Dir.Out)].rx_armed = false;
                self.endpoints[i][@intFromEnum(types.Dir.Out)].rx_last_len = 0;
                self.endpoints[i][@intFromEnum(types.Dir.In)].tx_busy = false;
            }

            // Default: NAK all non-EP0 endpoints.
            for (1..cfg.max_endpoints_count) |i| {
                const e: u4 = @as(u4, @intCast(i));
                set_rx_ctrl(e, RES_NAK, TOG_DATA0, false);
                set_tx_ctrl(e, RES_NAK, TOG_DATA0, false);
            }

            // EP0 special.
            self.arm_ep0_out_always();
        }

        fn read_setup_from_ep0(self: *Self) types.SetupPacket {
            const ep0 = self.st(.ep0, .Out);
            assert(ep0.buf.len >= 8);
            const words_ptr: *align(4) const [2]u32 = @ptrCast(ep0.buf.ptr);
            return @bitCast(words_ptr.*);
        }

        // ---- comptime dispatch helpers (required by DeviceController API) ----

        fn call_on_buffer(self: *Self, dir: types.Dir, ep: u4, controller: anytype) void {
            // controller.on_buffer requires comptime ep parameter
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

        // ---- Poll loop -------------------------------------------------------

        pub fn poll(self: *Self, in_isr: bool, controller: anytype) void {
            _ = in_isr;
            while (true) {
                const fg: u8 = Regs.USB_INT_FG.raw;
                if (fg == 0) break;

                if ((fg & UIF_HST_SOF) != 0) {
                    // acknowledge SOF but ignore
                    Regs.USB_INT_FG.raw = UIF_HST_SOF;
                }
                if ((fg & UIF_SUSPEND) != 0) {
                    // acknowledge SUSPEND but ignore
                    Regs.USB_INT_FG.raw = UIF_SUSPEND;
                }

                if (fg & UIF_FIFO_OV != 0) {
                    log.warn("FIFO overflow!", .{});
                    Regs.USB_INT_FG.raw = UIF_FIFO_OV;
                }

                if ((fg & UIF_BUS_RST) != 0) {
                    log.info("bus reset\n\n\n", .{});
                    // clear
                    Regs.USB_INT_FG.raw = UIF_BUS_RST;

                    // address back to 0
                    set_address(&self.interface, 0);

                    self.on_bus_reset_local();
                    controller.on_bus_reset(&self.interface);
                }

                if ((fg & UIF_SETUP_ACT) != 0) {
                    log.info("SETUP received", .{});
                    Regs.USB_INT_FG.raw = UIF_SETUP_ACT;

                    const setup: types.SetupPacket = self.read_setup_from_ep0();

                    // After SETUP, EP0 IN data stage starts with DATA1.
                    set_tx_ctrl(0, RES_NAK, TOG_DATA1, false);
                    set_rx_ctrl(0, RES_ACK, TOG_DATA1, false);

                    controller.on_setup_req(&self.interface, &setup);
                }

                if ((fg & UIF_TRANSFER) != 0) {
                    // clear transfer
                    Regs.USB_INT_FG.raw = UIF_TRANSFER;
                    const stv = Regs.USB_INT_ST.read();
                    const ep: u4 = @as(u4, stv.MASK_UIS_H_RES__MASK_UIS_ENDP);
                    const token: u2 = @as(u2, stv.MASK_UIS_TOKEN);
                    self.handle_transfer(ep, token, controller);
                }
            }
        }

        fn handle_transfer(self: *Self, ep: u4, token: u2, controller: anytype) void {
            if (ep >= cfg.max_endpoints_count) return;
            if (token == TOKEN_SOF) return;
            switch (token) {
                TOKEN_OUT => self.handle_out(ep, controller),
                TOKEN_SOF => {},
                TOKEN_IN => self.handle_in(ep, controller),
                TOKEN_SETUP => {
                    // If UIF_SETUP_ACT isn't present, handle SETUP via TRANSFER.
                    if (ep == 0) {
                        const setup: types.SetupPacket = self.read_setup_from_ep0();
                        log.debug("Setup: {any}", .{setup});
                        set_tx_ctrl(0, RES_NAK, TOG_DATA1, false);
                        set_rx_ctrl(0, RES_ACK, TOG_DATA1, false);
                        controller.on_setup_req(&self.interface, &setup);
                    }
                },
            }
        }

        fn handle_out(self: *Self, ep: u4, controller: anytype) void {
            const len: u16 = Regs.USB_RX_LEN.read().R16_USB_RX_LEN;
            const stv = Regs.USB_INT_ST.read();
            const rx_ctrl = uep_rx_ctrl(ep).read();
            log.debug(
                "OUT ep{} len={} tog_ok={} rx_res={} rx_tog={}",
                .{ ep, len, stv.RB_UIS_TOG_OK, rx_ctrl.RES, rx_ctrl.TOG },
            );
            // EP0 OUT is always armed; accept status ZLP.
            if (ep == 0) {
                const st_out = self.st(.ep0, .Out);
                st_out.rx_last_len = len;
                const next = toggle_next(current_rx_tog(0));
                set_rx_ctrl(0, RES_ACK, next, false);
                // stay ACK
                self.call_on_buffer(.Out, 0, controller);
                return;
            }

            const num: types.Endpoint.Num = @enumFromInt(ep);
            const st_out = self.st(num, .Out);

            // Only read if previously armed (ep_listen)
            if (!st_out.rx_armed) {
                // set_rx_ctrl(ep, RES_NAK, TOG_DATA0, true);
                return;
            }

            // Disarm immediately (NAK) to regain ownership.
            st_out.rx_armed = false;
            const next = toggle_next(current_rx_tog(ep));
            set_rx_ctrl(ep, RES_NAK, next, false);

            const n = @min(@as(usize, len), st_out.buf.len);
            st_out.rx_last_len = @as(u16, @intCast(n));

            self.call_on_buffer(.Out, ep, controller);
        }

        // IN => into host from device
        fn handle_in(self: *Self, ep: u4, controller: anytype) void {
            const num: types.Endpoint.Num = @enumFromInt(ep);
            const st_in = self.st(num, .In);

            if (!st_in.tx_busy) {
                set_tx_ctrl(ep, RES_NAK, current_tx_tog(ep), false);
                return;
            }

            // Mark free before calling on_buffer(), so EP0_IN logic can immediately queue next chunk.
            st_in.tx_busy = false;
            const next = toggle_next(current_tx_tog(ep));
            set_tx_ctrl(ep, RES_NAK, next, false);

            // Notify controller/drivers of IN completion.
            self.call_on_buffer(.In, ep, controller);
        }

        // ---- VTable functions ------------------------------------------------

        fn set_address(_: *usb.DeviceInterface, addr: u7) void {
            log.info("set_address {}", .{addr});
            Regs.USB_DEV_AD.modify(.{ .MASK_USB_ADDR = addr });
        }

        fn ep_open(itf: *usb.DeviceInterface, desc_ptr: *const descriptor.Endpoint) void {
            const self: *Self = @fieldParentPtr("interface", itf);
            const desc = desc_ptr.*;

            const e = desc.endpoint;
            const ep_i: u4 = epn(e.num);
            assert(ep_i < cfg.max_endpoints_count);
            log.info("ep_open called for ep{}", .{ep_i});

            const mps: u16 = desc.max_packet_size.into();
            assert(mps > 0 and mps <= 2047);

            // EP0 shares a single DMA buffer for both directions.
            if (e.num == .ep0) {
                const out_st = self.st(.ep0, .Out);
                const in_st = self.st(.ep0, .In);
                if (ep0_dma().raw == 0) {
                    log.warn("EP0 DMA is null!", .{});
                }
                if (out_st.buf.len == 0 and in_st.buf.len == 0) {
                    // this should probably be fixed at 64 bytes for EP0 for HS?
                    const buf = self.endpoint_alloc(64);
                    out_st.buf = buf;
                    in_st.buf = buf;

                    const ptr_val = @as(u32, @intCast(@intFromPtr(buf.ptr)));
                    log.debug("Setting EP0 DMA buffer at {x}, len={}", .{ ptr_val, buf.len });
                    ep0_dma().raw = ptr_val;
                    uep_max_len(0).raw = @intCast(64);
                } else {
                    // Ensure both directions point at the same backing buffer.
                    if (out_st.buf.len == 0) out_st.buf = in_st.buf;
                    if (in_st.buf.len == 0) in_st.buf = out_st.buf;
                }
            } else {
                log.debug("ep_open ep{} dir={}", .{ ep_i, e.dir });
                // Non-EP0: separate DMA buffers per direction
                const st_ep = self.st(e.num, e.dir);

                if (st_ep.buf.len == 0) {
                    st_ep.buf = self.endpoint_alloc(@as(usize, 512));
                }

                const ptr_val: u32 = @as(u32, @intCast(@intFromPtr(st_ep.buf.ptr)));

                if (e.dir == .Out) {
                    uep_rx_dma(ep_i).raw = ptr_val;
                    uep_max_len(ep_i).raw = mps;
                    set_rx_ctrl(ep_i, RES_NAK, TOG_DATA0, false);
                } else {
                    uep_tx_dma(ep_i).raw = ptr_val;
                    set_tx_ctrl(ep_i, RES_NAK, TOG_DATA0, false);
                }
            }
            log.debug("allocation and DMA setup done for ep{}", .{ep_i});

            uep_t_len(ep_i).raw = 0;

            // Enable endpoint direction in UEP_CONFIG bitmaps.
            // TODO: make this a function, too ugly here
            var cfg_raw: u32 = Regs.UEP_CONFIG__UHOST_CTRL.raw;
            if (e.num != .ep0) {
                if (e.dir == .In) cfg_raw |= (@as(u32, 1) << ep_i) else cfg_raw |= (@as(u32, 1) << (16 + @as(u5, ep_i)));
            }
            Regs.UEP_CONFIG__UHOST_CTRL.raw = cfg_raw;

            // Endpoint type ISO marking (only for ISO endpoints).
            if (e.num != .ep0 and desc.attributes.transfer_type == .Isochronous) {
                var type_raw: u32 = Regs.UEP_TYPE.raw;
                if (e.dir == .In) type_raw |= (@as(u32, 1) << ep_i) else type_raw |= (@as(u32, 1) << (16 + @as(u5, ep_i)));
                Regs.UEP_TYPE.raw = type_raw;
            }

            // EP0 OUT always ACK
            if (e.num == .ep0 and e.dir == .Out) {
                self.arm_ep0_out_always();
            }

            log.debug("ep_open completed for ep{}", .{ep_i});
        }

        fn ep_listen(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, len: types.Len) void {
            log.info("ep_listen called for ep{} len={}", .{ ep_num, len });
            const self: *Self = @fieldParentPtr("interface", itf);

            // EP0 OUT is always armed; ignore listen semantics here.
            if (ep_num == .ep0) {
                const st0 = self.st(.ep0, .Out);
                st0.rx_limit = @as(u16, @intCast(len));
                // set_rx_ctrl(0, RES_ACK, TOG_DATA0, true);
                return;
            }

            const ep_i: u4 = epn(ep_num);
            if (ep_i > cfg.max_endpoints_count)
                @panic("ep_listen called for invalid endpoint");

            const st_out = self.st(ep_num, .Out);
            if (st_out.buf.len == 0)
                @panic("ep_listen called for endpoint with no buffer allocated");

            // Must not be called again until packet received.
            if (st_out.rx_armed)
                @panic("ep_listen called while OUT endpoint already armed");

            const limit = @min(st_out.buf.len, @as(usize, @intCast(len)));
            st_out.rx_limit = @as(u16, @intCast(limit));
            st_out.rx_armed = true;
            st_out.rx_last_len = 0;

            uep_max_len(ep_i).raw = @as(u16, @intCast(limit));

            asm volatile ("");
            set_rx_ctrl(ep_i, RES_ACK, current_rx_tog(ep_i), false);
        }

        fn ep_readv(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, data: []const []u8) types.Len {
            const self: *Self = @fieldParentPtr("interface", itf);

            const st_out = self.st(ep_num, .Out);
            assert(st_out.buf.len != 0);

            const want: usize = @as(usize, st_out.rx_last_len);
            assert(want <= st_out.buf.len);

            // Must be called exactly once per received packet.
            // Enforce by clearing rx_last_len after consumption.
            defer st_out.rx_last_len = 0;

            var remaining: []align(4) u8 = st_out.buf[0..want];
            var copied: usize = 0;

            for (data) |dst| {
                if (remaining.len == 0) break;
                const n = @min(dst.len, remaining.len);
                @memcpy(dst[0..n], remaining[0..n]);
                remaining = @alignCast(remaining[n..]);
                copied += n;
            }

            // Driver is responsible for re-arming via ep_listen().
            return @as(types.Len, @intCast(copied));
        }

        fn ep_writev(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, vec: []const []const u8) types.Len {
            const self: *Self = @fieldParentPtr("interface", itf);
            assert(vec.len > 0);

            const ep_i: u4 = epn(ep_num);
            assert(ep_i < cfg.max_endpoints_count);

            const st_in = self.st(ep_num, .In);
            assert(st_in.buf.len != 0);

            if (st_in.tx_busy) {
                log.warn("ep_writev called while {} IN endpoint busy, returning 0", .{ep_num});
                return 0;
            }

            // Copy vector into DMA buffer (up to MPS/buffer size)
            var w: usize = 0;
            for (vec) |chunk| {
                if (w >= st_in.buf.len) break;
                const n = @min(chunk.len, st_in.buf.len - w);
                @memcpy(st_in.buf[w .. w + n], chunk[0..n]);
                w += n;
            }

            uep_t_len(ep_i).raw = @as(u16, @intCast(w));

            st_in.tx_busy = true;
            // Arm IN

            set_tx_ctrl(ep_i, RES_ACK, current_tx_tog(ep_i), false);

            // For ZLP ACK, usb.DeviceInterface.ep_ack() expects ep_writev() returns 0.
            return @as(types.Len, @intCast(w));
        }

        // ---- HW init ---------------------------------------------------------

        fn usbhd_hw_init() void {
            // Reset SIE and clear FIFO
            Regs.UHOST_CTRL.raw = 0;
            Regs.UHOST_CTRL.modify(.{ .RB_UH_PHY_SUSPENDM = 1 });
            Regs.USB_CTRL.raw = 0; // not sure if writing zero then val is ok?
            Regs.USB_CTRL.modify(.{
                .RB_UC_CLR_ALL = 1,
                .RB_UC_RST_SIE = 1,
                .RB_UC_INT_BUSY = 1,
            });
            // wait 10us, TODO: replace with timer delay
            var i: u32 = 0;
            while (i < 1440) : (i += 1) {
                asm volatile ("nop");
            }

            Regs.USB_CTRL.modify(.{
                .RB_UC_RST_SIE = 0,
            });

            Regs.USB_CTRL.modify(.{
                .RB_UC_DMA_EN = 1,
                .RB_UC_INT_BUSY = 1,
                .RB_UC_SPEED_TYPE = speed_type(cfg),
            });

            // Enable source interrupts (we poll these flags, interrupt disabled)
            Regs.USB_INT_EN.modify(.{
                .RB_U_1WIRE_MODE = 1, // actually SETUP_ACT?
                .RB_UIE_BUS_RST__RB_UIE_DETECT = 1,
                .RB_UIE_TRANSFER = 1,
                .RB_UIE_SUSPEND = 1,
                .RB_UIE_FIFO_OV = 1,
                // .RB_UIE_HST_SOF = 1,
                .RB_UIE_DEV_NAK = 1,
            });
        }
    };
}

///! Skeleton ISR
pub fn usbhs_interrupt_handler() callconv(microzig.cpu.riscv_calling_convention) void {
    const fg = Regs.USB_INT_FG.raw;
    Regs.USB_INT_FG.raw = fg;
    @panic("Don't Enable USBHS Interrupt, Not yet supported!");
}
