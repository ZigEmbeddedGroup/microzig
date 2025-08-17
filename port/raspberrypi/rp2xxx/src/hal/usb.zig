//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const peri_usb = microzig.chip.peripherals.USB;
const peri_dpram = microzig.chip.peripherals.USB_DPRAM;
const chip = microzig.hal.compatibility.chip;

const usb = microzig.core.usb;
const types = usb.types;

const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const UsbConfig = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: comptime_int = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: comptime_int = 16,
    synchronization_nops: comptime_int = 3,
};

const Endpoint = usb.types.Endpoint;

const rp2xxx_buffers = struct {
    // Address 0x100-0xfff (3840 bytes) can be used for data buffers
    const USB_DPRAM_DATA_BUFFER_BASE = 0x50100100;

    const CTRL_EP_BUFFER_SIZE = 64;

    const USB_EP0_BUFFER0 = USB_DPRAM_DATA_BUFFER_BASE;
    const USB_EP0_BUFFER1 = USB_DPRAM_DATA_BUFFER_BASE + CTRL_EP_BUFFER_SIZE;

    const USB_DATA_BUFFER = USB_DPRAM_DATA_BUFFER_BASE + (2 * CTRL_EP_BUFFER_SIZE);
    const USB_DATA_BUFFER_SIZE = 3840 - (2 * CTRL_EP_BUFFER_SIZE);

    const ep0_buffer0: *[CTRL_EP_BUFFER_SIZE]u8 = @as(*[CTRL_EP_BUFFER_SIZE]u8, @ptrFromInt(USB_EP0_BUFFER0));
    const ep0_buffer1: *[CTRL_EP_BUFFER_SIZE]u8 = @as(*[CTRL_EP_BUFFER_SIZE]u8, @ptrFromInt(USB_EP0_BUFFER1));
    const data_buffer: *[USB_DATA_BUFFER_SIZE]u8 = @as(*[USB_DATA_BUFFER_SIZE]u8, @ptrFromInt(USB_DATA_BUFFER));

    fn data_offset(ep_data_buffer: []u8) u16 {
        const buf_base = @intFromPtr(ep_data_buffer.ptr);
        const dpram_base = @intFromPtr(peripherals.USB_DPRAM);
        return @as(u16, @intCast(buf_base - dpram_base));
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

        const HardwareEndpoint = packed struct(u5) {
            // DPRAM is better modelled with atomics than with volatile, because
            // the control registers contain "pointers" (offsets) into the shared memory.
            const Atomic = std.atomic.Value;

            const EpCtrl = Atomic(@TypeOf(peri_dpram.EP1_IN_CONTROL).underlying_type);
            const ep_ctrl_all: *[2 * (cfg_max_endpoints_count - 1)]EpCtrl =
                @volatileCast(@ptrCast(&peri_dpram.EP1_IN_CONTROL));

            const BufCtrl = Atomic(@TypeOf(peri_dpram.EP0_IN_BUFFER_CONTROL).underlying_type);
            const buf_ctrl_all: *[2 * (cfg_max_endpoints_count)]BufCtrl =
                @volatileCast(@ptrCast(&peri_dpram.EP0_IN_BUFFER_CONTROL));

            const Data = struct {
                transfer_type: types.TransferType,
                awaiting_rx: bool,

                data_buffer: []u8,
            };
            var global_data: [2 * config.max_endpoints_count]Data = undefined;

            is_out: bool,
            num: types.Endpoint.Num,

            inline fn int(this: @This()) u5 {
                return @bitCast(this);
            }

            inline fn data(this: @This()) *Data {
                return &global_data[this.int()];
            }

            fn from(ep: types.Endpoint) @This() {
                return .{
                    .num = ep.num,
                    .is_out = switch (ep.dir) {
                        .In => false,
                        .Out => true,
                    },
                };
            }

            fn into(this: @This()) types.Endpoint {
                return .{
                    .num = this.num,
                    .dir = if (this.is_out) .Out else .In,
                };
            }

            fn in(num: types.Endpoint.Num) @This() {
                return .{
                    .num = num,
                    .is_out = false,
                };
            }

            fn out(num: types.Endpoint.Num) @This() {
                return .{
                    .num = num,
                    .is_out = true,
                };
            }

            fn ep_ctrl(this: @This()) ?*EpCtrl {
                if (this.num == .ep0)
                    return null
                else {
                    return &ep_ctrl_all[this.int() - 2];
                }
            }

            fn buf_ctrl(this: @This()) *BufCtrl {
                return &buf_ctrl_all[this.int()];
            }
        };

        var data_buffer: []u8 = rp2xxx_buffers.data_buffer;

        pub fn usb_init_device(_: *usb.DeviceConfiguration) void {
            if (chip == .RP2350)
                peripherals.USB.MAIN_CTRL.modify(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            for (HardwareEndpoint.ep_ctrl_all) |*ep_ctrl|
                ep_ctrl.store(@bitCast(@as(u32, 0)), .seq_cst);
            for (HardwareEndpoint.buf_ctrl_all) |*buf_ctrl|
                buf_ctrl.store(@bitCast(@as(u32, 0)), .seq_cst);

            // Mux the controller to the onboard USB PHY. I was surprised that there are
            // alternatives to this, but, there are.
            peripherals.USB.USB_MUXING.modify(.{
                .TO_PHY = 1,
                // This bit is also set in the SDK example, without any discussion. It's
                // undocumented (being named does not count as being documented).
                .SOFTCON = 1,
            });

            // Force VBUS detect. Not all RP2040 boards wire up VBUS detect, which would
            // let us detect being plugged into a host (the Pi Pico, to its credit,
            // does). For maximum compatibility, we'll set the hardware to always
            // pretend VBUS has been detected.
            peripherals.USB.USB_PWR.modify(.{
                .VBUS_DETECT = 1,
                .VBUS_DETECT_OVERRIDE_EN = 1,
            });

            // Enable controller in device mode.
            peripherals.USB.MAIN_CTRL.modify(.{
                .CONTROLLER_EN = 1,
                .HOST_NDEVICE = 0,
            });

            // Request to have an interrupt (which really just means setting a bit in
            // the `buff_status` register) every time a buffer moves through EP0.
            peripherals.USB.SIE_CTRL.modify(.{ .EP0_INT_1BUF = 1 });

            // Enable interrupts (bits set in the `ints` register) for other conditions
            // we use:
            peripherals.USB.INTE.modify(.{
                // A buffer is done
                .BUFF_STATUS = 1,
                // The host has reset us
                .BUS_RESET = 1,
                // We've gotten a setup request on EP0
                .SETUP_REQ = 1,
            });

            @memset(std.mem.asBytes(&HardwareEndpoint.global_data), 0);
            endpoint_open(.in(.ep0), 64, types.TransferType.Control) catch unreachable;
            endpoint_open(.out(.ep0), 64, types.TransferType.Control) catch unreachable;

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peripherals.USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
        }

        /// Configures a given endpoint to send data (device-to-host, IN) when the host
        /// next asks for it.
        ///
        /// The contents of each of the slices in `data` will be _copied_ into USB SRAM,
        /// so you can reuse them immediately after this returns.
        /// No need to wait for the packet to be sent.
        pub fn usb_start_tx(
            ep_in: Endpoint.Num,
            data: []const []const u8,
        ) usize {
            const ep_hard: HardwareEndpoint = .in(ep_in);

            // It is technically possible to support longer buffers but this demo doesn't bother.
            const dst_buf_len = 64;
            var n: usize = 0;
            for (data) |buffer| {
                const space_left = dst_buf_len - n;
                if (space_left >= buffer.len) {
                    // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
                    std.mem.copyForwards(u8, ep_hard.data().data_buffer[n .. n + buffer.len], buffer);
                    n += buffer.len;
                } else {
                    std.mem.copyForwards(u8, ep_hard.data().data_buffer[n..], buffer[0..space_left]);
                    n = dst_buf_len;
                }
            }

            // The AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            // Write the buffer information to the buffer control register
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.load(.seq_cst);
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 1; // We have put data in
            rmw.LENGTH_0 = @as(u10, @intCast(n)); // There are this many bytes
            buf_ctrl.store(rmw, .seq_cst);

            // Nop for some clock cycles
            // use volatile so the compiler doesn't optimize the nops away
            inline for (0..config.synchronization_nops) |_|
                asm volatile ("nop");

            // Set available bit
            rmw.AVAILABLE_0 = 1; // The data is for the computer to use now
            buf_ctrl.store(rmw, .seq_cst);

            return n;
        }

        pub fn usb_start_rx(
            ep_out: Endpoint.Num,
            len: usize,
        ) void {
            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(len <= 64);

            const ep_hard: HardwareEndpoint = .out(ep_out);

            if (ep_hard.data().awaiting_rx)
                return;

            // Configure the OUT:
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.load(.seq_cst);
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is NOT full, we want the computer to fill it
            rmw.AVAILABLE_0 = 1; // It is, however, available to be filled
            rmw.LENGTH_0 = @intCast(len); // Up tho this many bytes
            buf_ctrl.store(rmw, .seq_cst);

            // Flip the DATA0/1 PID for the next receive
            ep_hard.data().awaiting_rx = true;
        }

        pub fn endpoint_reset_rx(ep_out: Endpoint.Num) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);
            ep_hard.data().awaiting_rx = false;
        }

        /// Check which interrupt flags are set
        pub fn get_interrupts() usb.InterruptStatus {
            const ints = peripherals.USB.INTS.read();

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
            peripherals.USB.SIE_STATUS.modify(.{ .SETUP_REC = 1 });

            // This assumes that the setup packet is arriving on EP0, our
            // control endpoint. Which it should be. We don't have any other
            // Control endpoints.

            // Copy the setup packet out of its dedicated buffer at the base of
            // USB SRAM. The PAC models this buffer as two 32-bit registers,
            // which is, like, not _wrong_ but slightly awkward since it means
            // we can't just treat it as bytes. Instead, copy it out to a byte
            // array.
            var setup_packet: [8]u8 = @splat(0);
            const spl: u32 = peripherals.USB_DPRAM.SETUP_PACKET_LOW.raw;
            const sph: u32 = peripherals.USB_DPRAM.SETUP_PACKET_HIGH.raw;
            @memcpy(setup_packet[0..4], std.mem.asBytes(&spl));
            @memcpy(setup_packet[4..8], std.mem.asBytes(&sph));
            // Reinterpret as setup packet
            return std.mem.bytesToValue(usb.types.SetupPacket, &setup_packet);
        }

        /// Called on a bus reset interrupt
        pub fn bus_reset() void {
            // Acknowledge by writing the write-one-to-clear status bit.
            peripherals.USB.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
            peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = 0 });
        }

        pub fn set_address(addr: u7) void {
            peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = addr });
        }

        pub fn reset_ep0() void {
            // Next packet ID will be DATA1
            peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL.modify(.{ .PID_0 = 0 });
        }

        pub fn endpoint_open(ep: Endpoint, packet_size: u11, transfer_type: types.TransferType) error{OutOfBufferMemory}!void {
            const ep_hard: HardwareEndpoint = .from(ep);

            endpoint_init(ep, transfer_type);

            if (ep.num != .ep0) {
                try endpoint_alloc(ep_hard, packet_size);
                endpoint_enable(ep_hard);
            }
        }

        fn endpoint_init(ep: Endpoint, transfer_type: types.TransferType) void {
            assert(ep.num.to_int() <= cfg_max_endpoints_count);

            var ep_hard: HardwareEndpoint = .from(ep);
            ep_hard.data().transfer_type = transfer_type;
            ep_hard.data().awaiting_rx = false;

            if (ep.num == .ep0) {
                // ep0 has fixed data buffer
                ep_hard.data().data_buffer = rp2xxx_buffers.ep0_buffer0;
            }
        }

        fn endpoint_alloc(ep_hard: HardwareEndpoint, packet_size: u11) error{OutOfBufferMemory}!void {
            // round up size to multiple of 64
            var size = (std.math.divCeil(u11, packet_size, 64) catch unreachable) * 64;
            // double buffered Bulk endpoint
            if (ep_hard.data().transfer_type == .Bulk) {
                size *= 2;
            }

            std.debug.assert(data_buffer.len >= size);

            ep_hard.data().data_buffer = data_buffer[0..size];
            data_buffer = data_buffer[size..];
        }

        fn endpoint_enable(ep_hard: HardwareEndpoint) void {
            const EndpointType = microzig.chip.types.peripherals.USB_DPRAM.EndpointType;
            var ep_ctrl = ep_hard.ep_ctrl().?;
            var rmw = ep_ctrl.load(.seq_cst);
            rmw.ENABLE = 1;
            rmw.INTERRUPT_PER_BUFF = 1;
            rmw.ENDPOINT_TYPE = @as(EndpointType, @enumFromInt(ep_hard.data().transfer_type.as_number()));
            rmw.BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep_hard.data().data_buffer);
            ep_ctrl.store(rmw, .seq_cst);
        }

        pub const UnhandledEndpointIterator = struct {
            initial_unhandled_mask: u32,
            currently_unhandled_mask: u32,

            pub fn init() @This() {
                const mask = peripherals.USB.BUFF_STATUS.raw;
                return .{
                    .initial_unhandled_mask = mask,
                    .currently_unhandled_mask = mask,
                };
            }

            pub fn deinit(this: @This()) void {
                const handled_mask = this.initial_unhandled_mask ^ this.currently_unhandled_mask;
                peripherals.USB.BUFF_STATUS.write_raw(handled_mask);
            }

            pub fn next(this: *@This()) ?usb.EndpointAndBuffer {
                const idx = std.math.cast(u5, @ctz(this.currently_unhandled_mask)) orelse return null;
                this.currently_unhandled_mask &= this.currently_unhandled_mask -% 1; // clear lowest bit

                const ep: Endpoint = .{
                    // Here we exploit knowledge of the ordering of buffer control
                    // registers in the peripheral. Each endpoint has a pair of
                    // registers, so we can determine the endpoint number by:
                    .num = .from_int(@intCast(idx >> 1)),
                    // Of the pair, the IN endpoint comes first, followed by OUT, so
                    // we can get the direction by:
                    .dir = if (idx & 1 == 0) .In else .Out,
                };

                const ep_hard = HardwareEndpoint.from(ep);
                const len = ep_hard.buf_ctrl().load(.seq_cst).LENGTH_0;

                return .{
                    .endpoint = ep,
                    .buffer = ep_hard.data().data_buffer[0..len],
                };
            }
        };
    };

    return usb.Usb(f);
}
