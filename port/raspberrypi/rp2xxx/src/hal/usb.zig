//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const chip = microzig.hal.compatibility.chip;
const usb = microzig.core.usb;

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const Config = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: comptime_int = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: comptime_int = 16,
    sync_noops: comptime_int = 3,
};

const HardwareEndpointData = struct {
    data_buffer: []align(64) u8,
};

const rp2xxx_buffers = struct {
    // Address 0x100-0xfff (3840 bytes) can be used for data buffers
    const USB_DPRAM_DATA_BUFFER_BASE = 0x50100100;

    const CTRL_EP_BUFFER_SIZE = 64;

    const USB_EP0_BUFFER0 = USB_DPRAM_DATA_BUFFER_BASE;
    const USB_EP0_BUFFER1 = USB_DPRAM_DATA_BUFFER_BASE + CTRL_EP_BUFFER_SIZE;

    const USB_DATA_BUFFER = USB_DPRAM_DATA_BUFFER_BASE + (2 * CTRL_EP_BUFFER_SIZE);
    const USB_DATA_BUFFER_SIZE = 3840 - (2 * CTRL_EP_BUFFER_SIZE);

    const ep0_buffer0: *align(64) [CTRL_EP_BUFFER_SIZE]u8 = @ptrFromInt(USB_EP0_BUFFER0);
    const ep0_buffer1: *align(64) [CTRL_EP_BUFFER_SIZE]u8 = @ptrFromInt(USB_EP0_BUFFER1);
    const data_buffer: *align(64) [USB_DATA_BUFFER_SIZE]u8 = @ptrFromInt(USB_DATA_BUFFER);

    fn data_offset(ep_data_buffer: []u8) u16 {
        const buf_base = @intFromPtr(&ep_data_buffer[0]);
        const dpram_base = @intFromPtr(peripherals.USB_DPRAM);
        return @as(u16, @intCast(buf_base - dpram_base));
    }
};

fn PerEndpoint(T: type) type {
    return extern struct {
        in: T,
        out: T,

        fn get(self: *volatile @This(), dir: usb.types.Dir) *volatile T {
            return switch (dir) {
                .In => &self.in,
                .Out => &self.out,
            };
        }
    };
}

// It would be nice to instead generate those arrays automatically with a regz patch.
const BufferControlMmio = microzig.mmio.Mmio(@TypeOf(peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL).underlying_type);
const buffer_control: *volatile [16]PerEndpoint(BufferControlMmio) = @ptrCast(&peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL);

const EndpointControlMimo = microzig.mmio.Mmio(@TypeOf(peripherals.USB_DPRAM.EP1_IN_CONTROL).underlying_type);
const endpoint_control: *volatile [15]PerEndpoint(EndpointControlMimo) = @ptrCast(&peripherals.USB_DPRAM.EP1_IN_CONTROL);

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// A set of functions required by the abstract USB impl to
/// create a concrete one.
pub fn Polled(config: Config) type {
    comptime {
        if (config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
            @compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
    }

    return struct {
        pub const max_supported_packet_size = 64;

        const vtable: usb.DeviceInterface.VTable = .{
            .ep_writev = ep_writev,
            .ep_readv = ep_readv,
            .ep_listen = ep_listen,
            .ep_open = ep_open,
            .set_address = set_address,
        };

        endpoints: [config.max_endpoints_count][2]HardwareEndpointData,
        data_buffer: []align(64) u8,
        interface: usb.DeviceInterface,

        pub fn poll(self: *@This(), controller: anytype) void {
            comptime usb.validate_controller(@TypeOf(controller));

            // Check which interrupt flags are set.
            const ints = peripherals.USB.INTS.read();

            // Setup request received?
            if (ints.SETUP_REQ != 0) {
                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                buffer_control[0].in.modify(.{ .PID_0 = 0 });

                const setup = get_setup_packet();
                controller.on_setup_req(&self.interface, &setup);
            }

            var buff_status: u32 = 0;
            // Events on one or more buffers? (In practice, always one.)
            if (ints.BUFF_STATUS != 0) {
                const bufbits_init = peripherals.USB.BUFF_STATUS.raw;
                buff_status |= bufbits_init;
                peripherals.USB.BUFF_STATUS.write_raw(bufbits_init);
            }

            inline for (0..2 * config.max_endpoints_count) |shift| {
                if (buff_status & (@as(u32, 1) << shift) != 0) {
                    // Here we exploit knowledge of the ordering of buffer control
                    // registers in the peripheral. Each endpoint has a pair of
                    // registers, IN being first
                    const ep_num = shift / 2;
                    const ep: usb.types.Endpoint = comptime .{
                        .num = @enumFromInt(ep_num),
                        .dir = if (shift & 1 == 0) .In else .Out,
                    };

                    const ep_hard = self.hardware_endpoint_get_by_address(ep);

                    // We should only get here if we've been notified that
                    // the buffer is ours again. This is indicated by the hw
                    // _clearing_ the AVAILABLE bit.
                    //
                    // It seems the hardware sets the AVAILABLE bit _after_ setting BUFF_STATUS
                    // So we wait for it just to be sure.
                    while (buffer_control[ep_num].get(ep.dir).read().AVAILABLE_0 != 0) {}

                    // Get the actual length of the data, which may be less
                    // than the buffer size.
                    const len = buffer_control[ep_num].get(ep.dir).read().LENGTH_0;

                    controller.on_buffer(&self.interface, ep, ep_hard.data_buffer[0..len]);
                }
            }

            // Has the host signaled a bus reset?
            if (ints.BUS_RESET != 0) {
                // Abort all endpoints
                peripherals.USB.EP_ABORT.raw = 0xFFFFFFFF;
                // Acknowledge by writing the write-one-to-clear status bit.
                peripherals.USB.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
                set_address(&self.interface, 0);
                controller.on_bus_reset(&self.interface);
                while (peripherals.USB.EP_ABORT_DONE.raw != 0xFFFFFFFF) {}
                peripherals.USB.EP_ABORT.raw = 0;
            }
        }

        pub fn init() @This() {
            if (chip == .RP2350)
                peripherals.USB.MAIN_CTRL.write(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            for (1..config.max_endpoints_count) |i| {
                endpoint_control[i - 1].in.write_raw(0);
                endpoint_control[i - 1].out.write_raw(0);
            }

            for (0..config.max_endpoints_count) |i| {
                buffer_control[i].in.write_raw(0);
                buffer_control[i].out.write_raw(0);
            }

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
            peripherals.USB.SIE_CTRL.modify(.{
                .EP0_INT_1BUF = 1,
            });

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

            var self: @This() = .{
                .endpoints = undefined,
                .data_buffer = rp2xxx_buffers.data_buffer,
                .interface = .{ .vtable = &vtable },
            };

            @memset(std.mem.asBytes(&self.endpoints), 0);
            ep_open(&self.interface, &.control(.in(.ep0), max_supported_packet_size));
            ep_open(&self.interface, &.control(.out(.ep0), max_supported_packet_size));

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peripherals.USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });

            // Listen for ACKs
            self.interface.ep_listen(.ep0, 0);

            return self;
        }

        /// Configures a given IN endpoint to send data when the host next asks for it.
        ///
        /// The contents of `buffer` will be _copied_ into USB SRAM, so you can
        /// reuse `buffer` immediately after this returns. No need to wait for the
        /// packet to be sent.
        fn ep_writev(
            itf: *usb.DeviceInterface,
            ep_num: usb.types.Endpoint.Num,
            data: []const []const u8,
        ) usb.types.Len {
            const self: *@This() = @fieldParentPtr("interface", itf);

            const bufctrl_ptr = &buffer_control[@intFromEnum(ep_num)].in;
            const ep = self.hardware_endpoint_get_by_address(.in(ep_num));

            const len = @min(data[0].len, ep.data_buffer.len);
            switch (chip) {
                .RP2040 => @memcpy(ep.data_buffer[0..len], data[0][0..len]),
                .RP2350 => {
                    const dst: [*]align(4) u32 = @ptrCast(ep.data_buffer.ptr);
                    const src: [*]align(1) const u32 = @ptrCast(data[0].ptr);
                    for (0..len / 4) |i|
                        dst[i] = src[i];
                    for (0..len % 4) |i|
                        ep.data_buffer[len - i - 1] = data[0][len - i - 1];
                },
            }

            var bufctrl = bufctrl_ptr.read();
            assert(bufctrl.AVAILABLE_0 == 0);
            // Write the buffer information to the buffer control register
            bufctrl.PID_0 ^= 1; // flip DATA0/1
            bufctrl.FULL_0 = 1; // We have put data in
            bufctrl.LENGTH_0 = @intCast(len); // There are this many bytes

            if (config.sync_noops != 0) {
                bufctrl_ptr.write(bufctrl);
                // The AVAILABLE bit in the buffer control register should be set
                // separately to the rest of the data in the buffer control register,
                // so that the rest of the data in the buffer control register is
                // accurate when the AVAILABLE bit is set.
                asm volatile ("nop\n" ** config.sync_noops);
            }
            // Set available bit
            bufctrl.AVAILABLE_0 = 1;
            bufctrl_ptr.write(bufctrl);

            return @intCast(len);
        }

        fn ep_readv(
            itf: *usb.DeviceInterface,
            ep_num: usb.types.Endpoint.Num,
            data: []const []u8,
        ) usb.types.Len {
            const self: *@This() = @fieldParentPtr("interface", itf);
            assert(data.len > 0);

            const bufctrl = &buffer_control[@intFromEnum(ep_num)].out.read();
            const ep = self.hardware_endpoint_get_by_address(.out(ep_num));
            var hw_buf: []align(1) u8 = ep.data_buffer[0..bufctrl.LENGTH_0];
            for (data) |dst| {
                const len = @min(dst.len, hw_buf.len);
                // make sure reads from device memory of size 1
                for (dst[0..len], hw_buf[0..len]) |*d, *s|
                    @atomicStore(u8, d, @atomicLoad(u8, s, .unordered), .unordered);
                hw_buf = hw_buf[len..];
                if (hw_buf.len == 0)
                    return @intCast(hw_buf.ptr - ep.data_buffer.ptr);
            }
            unreachable;
        }

        fn ep_listen(
            itf: *usb.DeviceInterface,
            ep_num: usb.types.Endpoint.Num,
            len: usb.types.Len,
        ) void {
            const self: *@This() = @fieldParentPtr("interface", itf);
            const bufctrl_ptr = &buffer_control[@intFromEnum(ep_num)].out;

            var bufctrl = bufctrl_ptr.read();
            const ep = self.hardware_endpoint_get_by_address(.out(ep_num));
            assert(bufctrl.AVAILABLE_0 == 0);
            // Configure the OUT:
            bufctrl.PID_0 ^= 1; // Flip DATA0/1
            bufctrl.FULL_0 = 0; // Buffer is NOT full, we want the computer to fill it
            bufctrl.LENGTH_0 = @intCast(@min(len, ep.data_buffer.len)); // Up tho this many bytes

            if (config.sync_noops != 0) {
                bufctrl_ptr.write(bufctrl);
                // The AVAILABLE bit in the buffer control register should be set
                // separately to the rest of the data in the buffer control register,
                // so that the rest of the data in the buffer control register is
                // accurate when the AVAILABLE bit is set.
                asm volatile ("nop\n" ** config.sync_noops);
            }
            // Set available bit
            bufctrl.AVAILABLE_0 = 1;
            bufctrl_ptr.write(bufctrl);
        }

        /// Returns a received USB setup packet
        ///
        /// Side effect: The setup request status flag will be cleared
        ///
        /// One can assume that this function is only called if the
        /// setup request flag is set.
        fn get_setup_packet() usb.types.SetupPacket {
            // Clear the status flag (write-one-to-clear)
            peripherals.USB.SIE_STATUS.modify(.{ .SETUP_REC = 1 });

            // This assumes that the setup packet is arriving on EP0, our
            // control endpoint. Which it should be. We don't have any other
            // Control endpoints.

            // The PAC models this buffer as two 32-bit registers.
            return @bitCast([2]u32{
                peripherals.USB_DPRAM.SETUP_PACKET_LOW.raw,
                peripherals.USB_DPRAM.SETUP_PACKET_HIGH.raw,
            });
        }

        fn set_address(_: *usb.DeviceInterface, addr: u7) void {
            peripherals.USB.ADDR_ENDP.write(.{ .ADDRESS = addr });
        }

        fn hardware_endpoint_get_by_address(self: *@This(), ep: usb.types.Endpoint) *HardwareEndpointData {
            return &self.endpoints[@intFromEnum(ep.num)][@intFromEnum(ep.dir)];
        }

        fn ep_open(itf: *usb.DeviceInterface, desc: *const usb.descriptor.Endpoint) void {
            const self: *@This() = @fieldParentPtr("interface", itf);

            assert(@intFromEnum(desc.endpoint.num) <= config.max_endpoints_count);

            const ep = desc.endpoint;
            const ep_hard = self.hardware_endpoint_get_by_address(ep);

            assert(desc.max_packet_size.into() <= max_supported_packet_size);

            buffer_control[@intFromEnum(ep.num)].get(ep.dir).modify(.{ .PID_0 = 1 });

            if (ep.num == .ep0) {
                // ep0 has fixed data buffer
                ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
            } else {
                ep_hard.data_buffer = self.endpoint_alloc(desc) catch unreachable;
                endpoint_control[@intFromEnum(ep.num) - 1].get(ep.dir).write(.{
                    .ENABLE = 1,
                    .INTERRUPT_PER_BUFF = 1,
                    .ENDPOINT_TYPE = @enumFromInt(@intFromEnum(desc.attributes.transfer_type)),
                    .BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep_hard.data_buffer),
                });
            }
        }

        fn endpoint_alloc(self: *@This(), desc: *const usb.descriptor.Endpoint) ![]align(64) u8 {
            // round up size to multiple of 64
            var size = try std.math.divCeil(u16, desc.max_packet_size.into(), 64) * 64;
            // double buffered Bulk endpoint
            if (desc.attributes.transfer_type == .Bulk)
                size *= 2;

            std.debug.assert(self.data_buffer.len >= size);

            defer self.data_buffer = @alignCast(self.data_buffer[size..]);
            return self.data_buffer[0..size];
        }
    };
}
