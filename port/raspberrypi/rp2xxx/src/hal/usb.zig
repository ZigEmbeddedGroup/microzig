//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;
const peri_dpram = microzig.chip.peripherals.USB_DPRAM;
const peri_usb = microzig.chip.peripherals.USB;
const usb = microzig.core.usb;

const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const Config = struct {
    synchronization_nops: comptime_int = 3,
    dpram_allocator: type = DpramAllocatorBump,
    // swap_dpdm: bool = false,
};

const Endpoint = usb.types.Endpoint;
const EpCtrl = @TypeOf(peri_dpram.EP1_IN_CONTROL);
const BufCtrl = @TypeOf(peri_dpram.EP0_IN_BUFFER_CONTROL);

const dpram_size = 4096;
pub const DpramBuffer = struct {
    const chunk_len = 1 << Index.ignored_lsbs;
    const start_align = chunk_len;

    const Chunk = struct { data: [chunk_len]u8 align(start_align) = undefined };

    const memory_raw: *[dpram_size / chunk_len]Chunk =
        @alignCast(@volatileCast(@ptrCast(peri_dpram)));

    pub const Len =
        std.meta.Int(.unsigned, std.math.log2_int_ceil(u16, dpram_size));

    pub const Index = enum(Len) {
        const ignored_lsbs = 6;

        invalid = 0,
        ep0buf0 = (0x100 >> ignored_lsbs),
        ep0buf1,
        data_start,
        _,

        fn from_reg(reg: EpCtrl.underlying_type) @This() {
            return @enumFromInt(@shrExact(reg.BUFFER_ADDRESS, ignored_lsbs));
        }

        fn to_u16(this: @This()) u16 {
            return @as(u16, @intFromEnum(this)) << ignored_lsbs;
        }

        fn start(this: @This()) [*]align(start_align) u8 {
            return @ptrCast(&memory_raw[@intFromEnum(this)]);
        }
    };
};

pub const DpramAllocatorError = error{OutOfBufferMemory};

pub const DpramAllocatorBump = struct {
    // First 0x100 bytes contain control registers and first 2 buffers are for endpoint 0.
    var top: DpramBuffer.Index = .data_start;

    fn alloc(len: DpramBuffer.Len) DpramAllocatorError!DpramBuffer.Index {
        if (top == .invalid) return error.OutOfBufferMemory;

        const next, const ovf = @addWithOverflow(len, @intFromEnum(top));
        if (ovf != 0 and next != 0)
            return error.OutOfBufferMemory;

        const ret: DpramBuffer.Index = @enumFromInt(next);
        defer top = ret;
        return ret;
    }
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// The rp2040 usb device impl
///
/// We create a concrete implementaion by passing a handful
/// of system specific functions to Usb(). Those functions
/// are used by the abstract USB impl of microzig.
pub fn Usb(comptime config: Config) type {
    return struct {
        pub const max_endpoints_count = RP2XXX_MAX_ENDPOINTS_COUNT;
        pub const max_transfer_size = 64; // TODO: Support other buffer sizes.
        pub const bcd_usb = 0x02_00;
        pub const default_strings: usb.Config.Strings = .{
            .manufacturer = "Raspberry Pi",
            .product = "Pico Test Device",
            .serial = "someserial",
        };
        pub const default_vid_pid: usb.Config.VidPid = .{
            .vendor = 0x2E8A,
            .product = 0x000a,
        };

        pub const Events = struct {
            pub const BufferIterator = struct {
                // One bit per endpoint.
                initial: u32,
                pending: u32,

                pub fn next(this: *@This()) ?usb.EndpointAndBuffer {
                    const idx = std.math.cast(u5, @ctz(this.pending)) orelse {
                        if (this.initial != 0)
                            peri_usb.BUFF_STATUS.write_raw(this.initial);
                        return null;
                    };
                    this.pending &= this.pending -% 1; // Clear lowest bit.
                    const ep: HardwareEndpoint = .from_idx(idx);
                    const buf = ep.buffer();
                    if (ep.is_out) {
                        const len = ep.buf_ctrl().read().LENGTH_0;
                        return .{ .Out = .{ .ep_num = ep.num, .buffer = buf[0..len] } };
                    } else return .{ .In = .{ .ep_num = ep.num, .buffer = buf } };
                }
            };

            unhandled_buffers: ?BufferIterator,
            bus_reset: bool,
            device_suspend: bool,
            host_resume: bool,
            setup_packet: ?usb.types.SetupPacket,
        };

        const HardwareEndpoint = packed struct(u7) {
            const ep_ctrl_all: *volatile [2 * (max_endpoints_count - 1)]EpCtrl =
                @ptrCast(&peri_dpram.EP1_IN_CONTROL);

            const buf_ctrl_all: *volatile [2 * (max_endpoints_count)]BufCtrl =
                @ptrCast(&peri_dpram.EP0_IN_BUFFER_CONTROL);

            var awaiting_rx: u32 = 0;

            _padding: u2 = 0, // 2 bits of padding so that address generation is a nop.
            is_out: bool,
            num: Endpoint.Num,

            inline fn to_idx(this: @This()) u5 {
                return @intCast(@shrExact(@as(u7, @bitCast(this)), 2));
            }

            inline fn from_idx(idx: u5) @This() {
                return @bitCast(@shlExact(@as(u7, idx), 2));
            }

            inline fn mask(this: @This()) u32 {
                return @as(u32, 1) << this.to_idx();
            }

            inline fn awaiting_rx_get(this: @This()) bool {
                return (this.mask() & @atomicLoad(u32, &awaiting_rx, .seq_cst)) != 0;
            }

            inline fn awaiting_rx_set(this: @This()) void {
                _ = @atomicRmw(u32, &awaiting_rx, .Or, this.mask(), .seq_cst);
            }

            inline fn awaiting_rx_clr(this: @This()) void {
                _ = @atomicRmw(u32, &awaiting_rx, .And, ~this.mask(), .seq_cst);
            }

            fn from(ep: Endpoint) @This() {
                return .{ .num = ep.num, .is_out = ep.dir == .Out };
            }

            fn in(num: Endpoint.Num) @This() {
                return .{ .num = num, .is_out = false };
            }

            fn out(num: Endpoint.Num) @This() {
                return .{ .num = num, .is_out = true };
            }

            fn ep_ctrl(this: @This()) ?*volatile EpCtrl {
                const i, const ovf = @subWithOverflow(this.to_idx(), 2);
                return if (ovf != 0) null else &ep_ctrl_all[i];
            }

            fn buf_ctrl(this: @This()) *volatile BufCtrl {
                return &buf_ctrl_all[this.to_idx()];
            }

            fn buffer(this: @This()) []u8 {
                const buf: DpramBuffer.Index = if (this.ep_ctrl()) |reg|
                    .from_reg(reg.read())
                else
                    .ep0buf0;
                return buf.start()[0..DpramBuffer.chunk_len];
            }
        };

        pub fn usb_init_device() ?[]u8 {
            if (chip == .RP2350)
                peri_usb.MAIN_CTRL.modify(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peri_dpram.SETUP_PACKET_LOW.write_raw(0);
            peri_dpram.SETUP_PACKET_HIGH.write_raw(0);

            for (HardwareEndpoint.ep_ctrl_all) |*ep_ctrl|
                ep_ctrl.write_raw(0);
            for (HardwareEndpoint.buf_ctrl_all) |*buf_ctrl|
                buf_ctrl.write_raw(0);

            // Mux the controller to the onboard USB PHY. I was surprised that there are
            // alternatives to this, but, there are.
            peri_usb.USB_MUXING.modify(.{
                .TO_PHY = 1,
                // This bit is also set in the SDK example, without any discussion. It's
                // undocumented (being named does not count as being documented).
                .SOFTCON = 1,
            });

            // Force VBUS detect. Not all RP2040 boards wire up VBUS detect, which would
            // let us detect being plugged into a host (the Pi Pico, to its credit,
            // does). For maximum compatibility, we'll set the hardware to always
            // pretend VBUS has been detected.
            peri_usb.USB_PWR.modify(.{
                .VBUS_DETECT = 1,
                .VBUS_DETECT_OVERRIDE_EN = 1,
            });

            // Enable controller in device mode.
            peri_usb.MAIN_CTRL.modify(.{
                .CONTROLLER_EN = 1,
                .HOST_NDEVICE = 0,
            });

            // Request to have an interrupt (which really just means setting a bit in
            // the `buff_status` register) every time a buffer moves through EP0.
            peri_usb.SIE_CTRL.modify(.{ .EP0_INT_1BUF = 1 });

            // Enable interrupts (bits set in the `ints` register) for other conditions
            // we use:
            peri_usb.INTE.modify(.{
                // A buffer is done
                .BUFF_STATUS = 1,
                // The host has reset us
                .BUS_RESET = 1,
                // We've gotten a setup request on EP0
                .SETUP_REQ = 1,
            });

            const ret = endpoint_open(.in(.ep0), .Control, 0) catch unreachable;
            _ = endpoint_open(.out(.ep0), .Control, 0) catch unreachable;

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peri_usb.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
            return ret;
        }

        pub fn set_address(addr: u7) void {
            peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });
        }

        /// Check which interrupt flags are set
        pub fn get_events() Events {
            const ints = peri_usb.INTS.read();
            return .{
                .unhandled_buffers = if (ints.BUFF_STATUS != 0) blk: {
                    const mask = peri_usb.BUFF_STATUS.raw;
                    break :blk .{ .initial = mask, .pending = mask };
                } else null,
                .bus_reset = ints.BUS_RESET == 1,
                .device_suspend = ints.DEV_SUSPEND == 1,
                .host_resume = ints.DEV_RESUME_FROM_HOST == 1,
                .setup_packet = if (ints.SETUP_REQ != 0) blk: {
                    // Clear the status flag (write-one-to-clear)
                    var sie_status: @TypeOf(peri_usb.SIE_STATUS).underlying_type = @bitCast(@as(u32, 0));
                    sie_status.SETUP_REC = 1;
                    peri_usb.SIE_STATUS.write(sie_status);

                    // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                    // to an IN on EP0 needs to use PID DATA1.
                    defer peri_dpram.EP0_IN_BUFFER_CONTROL.modify(.{ .PID_0 = 0 });

                    // Copy the setup packet out of its dedicated buffer at the base of
                    // USB SRAM. The PAC models this buffer as two 32-bit registers.
                    break :blk @bitCast([2]u32{
                        peri_dpram.SETUP_PACKET_LOW.raw,
                        peri_dpram.SETUP_PACKET_HIGH.raw,
                    });
                } else null,
            };
        }

        /// Configures a given endpoint to send data (device-to-host, IN) when the host
        /// next asks for it.
        ///
        /// The contents of each of the slices in `data` will be _copied_ into USB SRAM,
        /// so you can reuse them immediately after this returns.
        /// No need to wait for the packet to be sent.
        pub fn usb_start_tx(ep_in: Endpoint.Num, data: []const u8) usize {
            const ep_hard: HardwareEndpoint = .in(ep_in);
            const buf = ep_hard.buffer();

            const len = @min(buf.len, data.len);
            // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
            std.mem.copyForwards(u8, buf[0..len], data[0..len]);

            submit_tx_buffer(ep_in, buf.ptr + len);

            return len;
        }

        pub fn submit_tx_buffer(ep_in: Endpoint.Num, buffer_end: [*]const u8) void {
            const ep_hard: HardwareEndpoint = .in(ep_in);
            const buf = ep_hard.buffer();

            // It is technically possible to support longer buffers but this demo doesn't bother.
            const len = buffer_end - buf.ptr;
            if (len > max_transfer_size)
                std.log.err("wrong buffer submitted", .{});

            // Write the buffer information to the buffer control register
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 1; // We have put data in
            rmw.LENGTH_0 = @intCast(len); // There are this many bytes

            // If the CPU is running at a higher clock speed than USB,
            // the AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            if (config.synchronization_nops != 0) {
                buf_ctrl.write(rmw);
                asm volatile ("nop\n" ** config.synchronization_nops);
            }

            rmw.AVAILABLE_0 = 1;
            buf_ctrl.write(rmw);
        }

        pub fn signal_rx_ready(ep_out: Endpoint.Num, len: usize) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);

            // Configure the OUT:
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();
            if (ep_hard.awaiting_rx_get()) {
                std.log.err("should not be called twice {} {}", .{ rmw.FULL_0, rmw.AVAILABLE_0 });
                return;
            }
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is empty
            rmw.AVAILABLE_0 = 1; // And ready to be filled
            rmw.LENGTH_0 = @intCast(@min(len, max_transfer_size));
            buf_ctrl.write(rmw);

            ep_hard.awaiting_rx_set();
        }

        pub fn endpoint_reset_rx(ep_out: Endpoint.Num) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);
            ep_hard.awaiting_rx_clr();
        }

        /// Called on a bus reset interrupt
        pub fn bus_reset_clear() void {
            // Acknowledge by writing the write-one-to-clear status bit.
            var sie_status: @TypeOf(peri_usb.SIE_STATUS).underlying_type = @bitCast(@as(u32, 0));
            sie_status.BUS_RESET = 1;
            peri_usb.SIE_STATUS.write(sie_status);
            peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = 0 });
        }

        pub fn endpoint_open(ep: Endpoint, transfer_type: usb.types.TransferType, buf_size_hint: usize) error{OutOfBufferMemory}!?[]u8 {
            _ = buf_size_hint;

            const ep_hard: HardwareEndpoint = .from(ep);

            assert(ep.num.to_int() < max_endpoints_count);
            ep_hard.awaiting_rx_clr();

            const start = if (ep.num != .ep0) blk: {
                const buf = try config.dpram_allocator.alloc(1);
                var ep_ctrl = ep_hard.ep_ctrl().?;
                var rmw = ep_ctrl.read();
                rmw.ENABLE = 1;
                rmw.INTERRUPT_PER_BUFF = 1;
                rmw.ENDPOINT_TYPE = @enumFromInt(transfer_type.as_number());
                rmw.BUFFER_ADDRESS = buf.to_u16();
                ep_ctrl.write(rmw);
                break :blk buf.start();
            } else DpramBuffer.Index.ep0buf0.start();
            return start[0..max_transfer_size];
        }
    };
}
