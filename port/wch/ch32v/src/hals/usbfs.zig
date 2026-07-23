//! WCH USBFS/OTG device backend
//!

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

const max_buffer_pool_size = USB_MAX_ENDPOINTS_COUNT * 2 * 64 + 64;

pub const Config = struct {
    max_endpoints_count: comptime_int = USB_MAX_ENDPOINTS_COUNT,

    // setting this to true is a compile error for the USBFS peripheral
    // Here for compatibility with the HS peripheral
    prefer_high_speed: bool = false,

    /// Static buffer pool in SRAM, bump-allocated.
    buffer_bytes: comptime_int = max_buffer_pool_size,
};

const Regs = peripherals.USB_OTG_FS;

const EP_State = struct {
    buf: []align(4) u8 = &[_]u8{},
    // OUT:
    rx_armed: bool = false,
    rx_limit: u16 = 0,
    rx_last_len: u16 = 0, // valid until ep_readv() consumes it
    // IN:
    tx_busy: bool = false,
};

fn PerEndpointArray(comptime N: comptime_int) type {
    return [N][2]EP_State; // [ep][dir]
}

fn epn(ep: types.Endpoint.Num) u4 {
    return @as(u4, @intCast(@intFromEnum(ep)));
}
// --- USBHD token encodings ---
const TOKEN_OUT: u2 = 0;
const TOKEN_SOF: u2 = 1;
const TOKEN_IN: u2 = 2;
const TOKEN_SETUP: u2 = 3;

// --- endpoint response encodings ---
const RES_ACK: u2 = 0;
const RES_NAK: u2 = 2;

const TOG_DATA0: u1 = 0;
const TOG_DATA1: u1 = 1;

fn toggle_next(tog: u1) u1 {
    return if (tog == TOG_DATA0) TOG_DATA1 else TOG_DATA0;
}

// We use offset-based access for per-EP regs to keep helpers compact.
const Reg_U32 = microzig.mmio.Mmio(packed struct(u32) { v: u32 = 0 });
const Reg_U8 = microzig.mmio.Mmio(packed struct(u8) { v: u8 = 0 });
pub const RegCtrl = microzig.mmio.Mmio(packed struct(u8) {
    /// bit mask of handshake response type for USB endpoint X receiving (OUT)
    RES: u2 = 0x0,
    /// expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
    TOG: u1 = 0x0,
    /// enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
    AUTO: bool = false,
    padding: u4 = 0,
});

// Endpoint DMA: 0x10 + ep*4 (EP0..EP7)
// Depending on mode, DMA buffers must have at least 128
// or 256 bytes, and contain the TX and RX buffers
const UEP_DMA: *volatile [8]Reg_U32 = @ptrFromInt(0x50000010); // Regs.R32_UEP0_DMA
const EP_Regs: *volatile [8]extern struct {
    UEP_T_LEN: Reg_U8,
    padding: u8,
    UEP_TX_CTRL: RegCtrl,
    UEP_RX_CTRL: RegCtrl,
} = @ptrFromInt(0x50000030); // Regs.R8_UEP0_T_LEN

fn set_tx_ctrl(ep: u4, res: u2, tog: u1, auto: bool) void {
    // [1:0]=RES, [2]=TOG, [3]=AUTO
    const tx_ctrl: *volatile RegCtrl = &EP_Regs[ep].UEP_TX_CTRL;
    tx_ctrl.write(.{
        .RES = res,
        .TOG = tog,
        .AUTO = auto,
    });
}
fn set_rx_ctrl(ep: u4, res: u2, tog: u1, auto: bool) void {
    const ctrl: *volatile RegCtrl = &EP_Regs[ep].UEP_RX_CTRL;
    ctrl.write(.{
        .RES = res,
        .TOG = tog,
        .AUTO = auto,
    });
}

fn current_rx_tog(ep: u4) u1 {
    const rx_ctrl: *volatile RegCtrl = &EP_Regs[ep].UEP_RX_CTRL;
    return rx_ctrl.read().TOG;
}
fn current_tx_tog(ep: u4) u1 {
    const tx_ctrl: *volatile RegCtrl = &EP_Regs[ep].UEP_TX_CTRL;
    return tx_ctrl.read().TOG;
}

fn enable_endpoint(ep: u4) void {
    if (ep == 0) return;

    const mode: *volatile Reg_U8 = switch (ep) {
        1, 4 => @ptrCast(&Regs.R8_UEP4_1_MOD),
        2, 3 => @ptrCast(&Regs.R8_UEP2_3_MOD__R8_UH_EP_MOD),
        5, 6 => @ptrCast(&Regs.R8_UEP5_6_MOD),
        7 => @ptrCast(&Regs.R8_UEP7_MOD),
        else => unreachable,
    };
    const enable_bits: u8 = switch (ep) {
        1, 3, 6 => (1 << 6) | (1 << 7),
        2, 4, 5, 7 => (1 << 2) | (1 << 3),
        else => unreachable,
    };
    // With RX and TX enabled and BUF_MOD clear, the hardware uses a
    // contiguous 128-byte buffer: OUT at UEPn_DMA and IN at UEPn_DMA + 64.
    // The unused direction remains disabled at the protocol level by NAK.
    mode.raw |= enable_bits;
}

/// Polled USBFS device backend for the MicroZig core USB controller.
pub fn Polled(comptime cfg: Config) type {
    comptime {
        if (cfg.max_endpoints_count < 1)
            @compileError("USBFS max_endpoints_count must include endpoint 0");
        if (cfg.prefer_high_speed)
            @compileError("This peripheral only supports Full Speed, not High Speed");
        if (cfg.max_endpoints_count > USB_MAX_ENDPOINTS_COUNT)
            @compileError("USBFS max_endpoints_count cannot exceed 8");
        if (cfg.buffer_bytes < 128)
            @compileError("USBFS buffer_bytes must be at least 128");
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
        // USB DMA addresses must be 4-byte aligned.
        pool: [cfg.buffer_bytes]u8 align(4) = undefined,

        buffer_pool: []align(4) u8,

        interface: usb.DeviceInterface,

        pub fn init(self: *Self) void {
            self.interface = .{ .vtable = &vtable };
            self.endpoints = @splat(@splat(.{}));
            @memset(self.pool[0..64], 0x7e);
            @memset(self.pool[64..], 0);

            self.buffer_pool = @alignCast(self.pool[64..]);

            usbfs_hw_init();

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

            // Enable D+ pull-up to signal device presence to host.
            // Must happen AFTER EP0 is configured.
            Regs.R8_USB_CTRL.write(.{
                .RB_UC_DMA_EN = 1,
                .RB_UC_INT_BUSY = 1,
                .MASK_UC_SYS_CTRL_RB_UC_DEV_PU_EN = 0b10, // DEV_PU_EN
            });
        }

        // TODO: replace with fixedbuffer allocator?
        fn endpoint_alloc(self: *Self, size: usize) []align(4) u8 {
            assert(self.buffer_pool.len >= size);
            const out = self.buffer_pool[0..size];
            self.buffer_pool = @alignCast(self.buffer_pool[size..]);
            return out;
        }

        fn st(self: *Self, ep_num: types.Endpoint.Num, dir: types.Dir) *EP_State {
            return &self.endpoints[@intFromEnum(ep_num)][@intFromEnum(dir)];
        }

        fn arm_ep0_out_always(self: *Self) void {
            _ = self;
            set_rx_ctrl(0, RES_ACK, TOG_DATA0, false);
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
            const flags = Regs.R8_USB_INT_FG.read();
            if (flags.RB_UIF_SUSPEND == 0 and flags.RB_UIF_FIFO_OV == 0 and
                flags.RB_UIF_BUS_RST__RB_UIF_DETECT == 0 and flags.RB_UIF_TRANSFER == 0)
                return;

            if (flags.RB_UIF_SUSPEND != 0) {
                Regs.R8_USB_INT_FG.write(.{ .RB_UIF_SUSPEND = 1 });
            }

            if (flags.RB_UIF_FIFO_OV != 0) {
                log.warn("FIFO overflow!", .{});
                Regs.R8_USB_INT_FG.write(.{ .RB_UIF_FIFO_OV = 1 });
            }

            if (flags.RB_UIF_BUS_RST__RB_UIF_DETECT != 0) {
                log.debug("bus reset", .{});
                Regs.R8_USB_INT_FG.write(.{ .RB_UIF_BUS_RST__RB_UIF_DETECT = 1 });
                set_address(&self.interface, 0);
                self.on_bus_reset_local();
                controller.on_bus_reset(&self.interface);
            }

            if (flags.RB_UIF_TRANSFER != 0) {
                const stv = Regs.R8_USB_INT_ST.read();
                const ep: u4 = @as(u4, stv.MASK_UIS_H_RES__MASK_UIS_ENDP);
                const token: u2 = @as(u2, stv.MASK_UIS_TOKEN);
                self.handle_transfer(ep, token, controller);
                Regs.R8_USB_INT_FG.write(.{ .RB_UIF_TRANSFER = 1 });
            }
        }

        fn handle_transfer(self: *Self, ep: u4, token: u2, controller: anytype) void {
            if (ep >= cfg.max_endpoints_count) return;
            if (token == TOKEN_SOF) return;
            log.debug("Got token: {} on ep{}", .{ token, ep });
            switch (token) {
                TOKEN_OUT => self.handle_out(ep, controller),
                TOKEN_SOF => {},
                TOKEN_IN => self.handle_in(ep, controller),
                TOKEN_SETUP => {
                    const setup: types.SetupPacket = self.read_setup_from_ep0();
                    Regs.R8_UEP0_T_CTRL.modify(.{ .RB_UEP_T_TOG = TOG_DATA1 });
                    set_rx_ctrl(0, RES_ACK, TOG_DATA1, false);
                    const st_in = self.st(.ep0, .In);
                    st_in.tx_busy = false;
                    controller.on_setup_req(&self.interface, &setup);
                },
            }
        }

        fn handle_out(self: *Self, ep: u4, controller: anytype) void {
            const len: u16 = Regs.R16_USB_RX_LEN;
            const stv = Regs.R8_USB_INT_ST.read();
            const rx_ctrl_reg: *volatile RegCtrl = &EP_Regs[ep].UEP_RX_CTRL;
            const rx_ctrl = rx_ctrl_reg.read();
            log.debug(
                "OUT ep{} len={} tog_ok={} rx_res={} rx_tog={}",
                .{ ep, len, stv.RB_UIS_TOG_OK, rx_ctrl.RES, rx_ctrl.TOG },
            );
            if (ep != 0 and stv.RB_UIS_TOG_OK == 0) return;

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

            if (!st_in.tx_busy) return;

            // Mark free before calling on_buffer(), so EP0_IN logic can immediately queue next chunk.
            st_in.tx_busy = false;
            const next = toggle_next(current_tx_tog(ep));
            set_tx_ctrl(ep, RES_NAK, next, false);

            // Notify controller/drivers of IN completion.
            self.call_on_buffer(.In, ep, controller);

            // After EP0 IN completes, re-arm EP0 OUT for the next SETUP.
            // SETUP packets always use DATA0 toggle; the WCH USBFS hardware
            // checks the toggle even for SETUP, so we must reset to DATA0.
            if (ep == 0) {
                self.arm_ep0_out_always();
            }
        }

        // ---- VTable functions ------------------------------------------------

        fn set_address(_: *usb.DeviceInterface, addr: u7) void {
            log.debug("set_address to {}", .{addr});
            Regs.R8_USB_DEV_AD.modify(.{ .MASK_USB_ADDR = addr });
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
            const first_open = out_st.buf.len == 0;

            // We "open" the endpoint for both directions at once because the DMA buffers
            // must be contiguous
            // doing it like this will give us a contiguous buffer starting at the out buffer
            // but I don't really like it in separate calls.
            if (ep_i == 0) {
                if (out_st.buf.len == 0) {
                    out_st.buf = self.endpoint_alloc(64);
                    in_st.buf = out_st.buf;
                    @memset(out_st.buf[0..], 0x7e);
                }
            } else {
                if (out_st.buf.len == 0) {
                    out_st.buf = self.endpoint_alloc(64);
                    @memset(out_st.buf[0..], 0x7e);
                }
                if (in_st.buf.len == 0) {
                    in_st.buf = self.endpoint_alloc(64);
                    @memset(in_st.buf[0..], 0x7e);
                }
            }
            const ptr_val: u32 = @as(u32, @intCast(@intFromPtr(out_st.buf.ptr)));

            const dma: *volatile Reg_U32 = &UEP_DMA[ep_i];
            dma.raw = ptr_val;

            if (first_open) {
                set_rx_ctrl(ep_i, RES_NAK, TOG_DATA0, false);
                set_tx_ctrl(ep_i, RES_NAK, TOG_DATA0, false);
            }
            switch (e.dir) {
                .Out => set_rx_ctrl(ep_i, RES_NAK, TOG_DATA0, false),
                .In => set_tx_ctrl(ep_i, RES_NAK, TOG_DATA0, false),
            }

            const tx_len: *volatile Reg_U8 = &EP_Regs[ep_i].UEP_T_LEN;
            tx_len.raw = 0;
            enable_endpoint(ep_i);

            // EP0 OUT always ACK
            if (e.num == .ep0) {
                self.arm_ep0_out_always();
            }
        }

        fn ep_listen(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, len: types.Len) void {
            log.debug("ep_listen ep{} len={}", .{ ep_num, len });
            const self: *Self = @fieldParentPtr("interface", itf);

            // EP0 OUT is always armed; ignore listen semantics here.
            if (ep_num == .ep0) {
                const st0 = self.st(.ep0, .Out);
                st0.rx_limit = @as(u16, @intCast(len));
                return;
            }

            const ep_i: u4 = epn(ep_num);
            if (ep_i >= cfg.max_endpoints_count)
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

            var remaining: []u8 = st_out.buf[0..want];
            var copied: usize = 0;

            for (data) |dst| {
                if (remaining.len == 0) break;
                const n = @min(dst.len, remaining.len);
                @memcpy(dst[0..n], remaining[0..n]);
                remaining = remaining[n..];
                copied += n;
            }

            // Driver is responsible for re-arming via ep_listen().
            return @as(types.Len, @intCast(copied));
        }

        fn ep_writev(itf: *usb.DeviceInterface, ep_num: types.Endpoint.Num, vec: []const []const u8) types.Len {
            log.debug("ep_writev called for ep{} with {} chunks", .{ ep_num, vec.len });
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

            const tx_len: *volatile Reg_U8 = &EP_Regs[ep_i].UEP_T_LEN;
            tx_len.raw = @as(u8, @intCast(w));

            st_in.tx_busy = true;
            set_tx_ctrl(ep_i, RES_ACK, current_tx_tog(ep_i), false);

            // For ZLP ACK, usb.DeviceInterface.ep_ack() expects ep_writev() returns 0.
            return @as(types.Len, @intCast(w));
        }

        // ---- HW init ---------------------------------------------------------

        fn usbfs_hw_init() void {
            // 1. SIE reset + FIFO clear
            Regs.R8_USB_CTRL.write(.{
                .RB_UC_RST_SIE = 1,
                .RB_UC_CLR_ALL = 1,
            });
            var i: u32 = 0;
            while (i < 1440) : (i += 1) { // ~10us at 144MHz
                asm volatile ("nop");
            }
            Regs.R8_USB_CTRL.write(.{}); // release reset

            // 2. Enable interrupt flags (polled, not NVIC-enabled)
            Regs.R8_USB_INT_EN.write(.{
                .RB_UIE_BUS_RST__RB_UIE_DETECT = 1,
                .RB_UIE_TRANSFER = 1,
                .RB_UIE_SUSPEND = 1,
            });

            // 3. Disable non-control endpoints. ep_open enables both hardware
            // directions so its contiguous OUT/IN DMA-buffer layout is used.
            Regs.R8_UEP4_1_MOD.write(.{});
            Regs.R8_UEP2_3_MOD__R8_UH_EP_MOD.write(.{});
            Regs.R8_UEP5_6_MOD.write(.{});
            Regs.R8_UEP7_MOD.write(.{});

            // 4. Clear all pending flags, reset address
            Regs.R8_USB_INT_FG.write(.{
                .RB_UIF_BUS_RST__RB_UIF_DETECT = 1,
                .RB_UIF_TRANSFER = 1,
                .RB_UIF_SUSPEND = 1,
                .RB_UIF_HST_SOF = 1,
                .RB_UIF_FIFO_OV = 1,
            });
            Regs.R8_USB_DEV_AD.write(.{});

            // 5. Enable DMA and make the SIE answer busy until software clears
            // UIF_TRANSFER. This prevents a following token from overwriting
            // the status of the transfer currently being processed.
            Regs.R8_USB_CTRL.write(.{
                .RB_UC_DMA_EN = 1,
                .RB_UC_INT_BUSY = 1,
            });

            // 6. Enable USB port with pull-down disabled
            Regs.UDEV_CTRL__UHOST_CTRL.write(.{
                .RB_UH_PORT_EN__RB_UD_PORT_EN = 1,
                .RB_UH_PD_DIS__RB_UD_PD_DIS = 1,
            });
        }
    };
}

/// Skeleton ISR; interrupt-driven operation is not implemented yet.
pub fn usbfs_interrupt_handler() callconv(microzig.cpu.riscv_calling_convention) void {
    Regs.R8_USB_INT_FG.write(Regs.R8_USB_INT_FG.read());
    @panic("USBFS interrupt-driven operation is not supported");
}
