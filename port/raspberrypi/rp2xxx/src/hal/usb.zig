//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;
const peri_dpram = microzig.chip.peripherals.USB_DPRAM;
const peri_usb = microzig.chip.peripherals.USB;
const usb = microzig.core.usb;

const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const UsbConfig = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: comptime_int = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: comptime_int = 16,
    synchronization_nops: comptime_int = 3,
    dpram_allocator: type = DpramAllocatorBump,
    swap_dpdm: bool = false,
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
pub fn Usb(comptime config: UsbConfig) type {
    // A set of functions required by the abstract USB impl to
    // create a concrete one.
    const f = struct {
        comptime {
            if (config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
                @compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
        }

        pub const cfg_max_endpoints_count = config.max_endpoints_count;
        pub const cfg_max_interfaces_count = config.max_interfaces_count;
        pub const high_speed = false;

        const HardwareEndpoint = packed struct(u7) {
            const ep_ctrl_all: *volatile [2 * (cfg_max_endpoints_count - 1)]EpCtrl =
                @ptrCast(&peri_dpram.EP1_IN_CONTROL);

            const buf_ctrl_all: *volatile [2 * (cfg_max_endpoints_count)]BufCtrl =
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

            fn into(this: @This()) Endpoint {
                assert(this._padding == 0);
                return .{ .num = this.num, .dir = if (this.is_out) .Out else .In };
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

            fn buffer_ready(this: @This()) []u8 {
                return this.buffer()[0..this.buf_ctrl().read().LENGTH_0];
            }
        };

        pub fn usb_init_device(_: *usb.DeviceConfiguration) void {
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

            endpoint_open(.in(.ep0), .Control, 0) catch unreachable;
            endpoint_open(.out(.ep0), .Control, 0) catch unreachable;

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peri_usb.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
        }

        /// Configures a given endpoint to send data (device-to-host, IN) when the host
        /// next asks for it.
        ///
        /// The contents of each of the slices in `data` will be _copied_ into USB SRAM,
        /// so you can reuse them immediately after this returns.
        /// No need to wait for the packet to be sent.
        pub fn usb_start_tx(ep_in: Endpoint.Num, data: []const []const u8) usize {
            const ep_hard: HardwareEndpoint = .in(ep_in);
            const buf = ep_hard.buffer();

            // It is technically possible to support longer buffers but this demo doesn't bother.
            var n: usize = 0;
            for (data) |buffer| {
                const space_left = buf.len - n;
                if (space_left >= buffer.len) {
                    // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
                    std.mem.copyForwards(u8, buf[n .. n + buffer.len], buffer);
                    n += buffer.len;
                } else {
                    std.mem.copyForwards(u8, buf[n..DpramBuffer.chunk_len], buffer[0..space_left]);
                    n = DpramBuffer.chunk_len;
                }
            }

            // The AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            // Write the buffer information to the buffer control register
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 1; // We have put data in
            rmw.LENGTH_0 = @as(u10, @intCast(n)); // There are this many bytes
            buf_ctrl.write(rmw);

            // Nop for some clock cycles
            // use volatile so the compiler doesn't optimize the nops away
            inline for (0..config.synchronization_nops) |_|
                asm volatile ("nop");

            // Set available bit
            rmw.AVAILABLE_0 = 1; // The data is for the computer to use now
            buf_ctrl.write(rmw);

            return n;
        }

        pub fn usb_start_rx(ep_out: Endpoint.Num, len: usize) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);

            if (ep_hard.awaiting_rx_get())
                return;

            // Configure the OUT:
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is NOT full, we want the computer to fill it
            rmw.AVAILABLE_0 = 1; // It is, however, available to be filled
            rmw.LENGTH_0 = @intCast(len); // Up tho this many bytes
            buf_ctrl.write(rmw);

            ep_hard.awaiting_rx_set();
        }

        pub fn endpoint_reset_rx(ep_out: Endpoint.Num) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);
            ep_hard.awaiting_rx_clr();
        }

        /// Check which interrupt flags are set
        pub fn get_interrupts() usb.InterruptStatus {
            const ints = peri_usb.INTS.read();

            return .{
                .BuffStatus = if (ints.BUFF_STATUS == 1) true else false,
                .BusReset = if (ints.BUS_RESET == 1) true else false,
                .DevConnDis = if (ints.DEV_CONN_DIS == 1) true else false,
                .DevSuspend = if (ints.DEV_SUSPEND == 1) true else false,
                .DevResumeFromHost = if (ints.DEV_RESUME_FROM_HOST == 1) true else false,
                .SetupReq = if (ints.SETUP_REQ == 1) true else false,
            };
        }

        /// Returns a received USB setup packet
        ///
        /// Side effect: The setup request status flag will be cleared
        ///
        /// One can assume that this function is only called if the
        /// setup request falg is set.
        pub fn get_setup_packet() usb.types.SetupPacket {
            // Clear the status flag (write-one-to-clear)
            peri_usb.SIE_STATUS.modify(.{ .SETUP_REC = 1 });

            // This assumes that the setup packet is arriving on EP0, our
            // control endpoint. Which it should be. We don't have any other
            // Control endpoints.

            // Copy the setup packet out of its dedicated buffer at the base of
            // USB SRAM. The PAC models this buffer as two 32-bit registers,
            // which is, like, not _wrong_ but slightly awkward since it means
            // we can't just treat it as bytes. Instead, copy it out to a byte
            // array.
            var setup_packet: [8]u8 = @splat(0);
            const spl: u32 = peri_dpram.SETUP_PACKET_LOW.raw;
            const sph: u32 = peri_dpram.SETUP_PACKET_HIGH.raw;
            @memcpy(setup_packet[0..4], std.mem.asBytes(&spl));
            @memcpy(setup_packet[4..8], std.mem.asBytes(&sph));
            // Reinterpret as setup packet
            return std.mem.bytesToValue(usb.types.SetupPacket, &setup_packet);
        }

        /// Called on a bus reset interrupt
        pub fn bus_reset() void {
            // Acknowledge by writing the write-one-to-clear status bit.
            peri_usb.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
            peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = 0 });
        }

        pub fn set_address(addr: u7) void {
            peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });
        }

        pub fn reset_ep0() void {
            // Next packet ID will be DATA1
            peri_dpram.EP0_IN_BUFFER_CONTROL.modify(.{ .PID_0 = 0 });
        }

        pub fn endpoint_open(ep: Endpoint, transfer_type: usb.types.TransferType, buf_size_hint: usize) error{OutOfBufferMemory}!void {
            _ = buf_size_hint;

            const ep_hard: HardwareEndpoint = .from(ep);

            assert(ep.num.to_int() < cfg_max_endpoints_count);
            ep_hard.awaiting_rx_clr();

            if (ep.num != .ep0) {
                var ep_ctrl = ep_hard.ep_ctrl().?;
                var rmw = ep_ctrl.read();
                rmw.ENABLE = 1;
                rmw.INTERRUPT_PER_BUFF = 1;
                rmw.ENDPOINT_TYPE = @enumFromInt(transfer_type.as_number());
                rmw.BUFFER_ADDRESS = (try config.dpram_allocator.alloc(1)).to_u16();
                ep_ctrl.write(rmw);
            }
        }

        pub const UnhandledEndpointIterator = struct {
            initial_unhandled_mask: u32,
            currently_unhandled_mask: u32,

            pub fn init() @This() {
                const mask = peri_usb.BUFF_STATUS.raw;
                return .{
                    .initial_unhandled_mask = mask,
                    .currently_unhandled_mask = mask,
                };
            }

            pub fn next(this: *@This()) ?usb.EndpointAndBuffer {
                const idx = std.math.cast(u5, @ctz(this.currently_unhandled_mask)) orelse {
                    if (this.initial_unhandled_mask != 0)
                        peri_usb.BUFF_STATUS.write_raw(this.initial_unhandled_mask);
                    return null;
                };
                this.currently_unhandled_mask &= this.currently_unhandled_mask -% 1; // clear lowest bit
                const ep: HardwareEndpoint = .from_idx(idx);
                return if (ep.is_out)
                    .{ .Out = .{ .ep_num = ep.num, .buffer = ep.buffer_ready() } }
                else
                    .{ .In = .{ .ep_num = ep.num, .buffer = ep.buffer_ready() } };
            }
        };
    };

    return usb.Usb(f);
}
