//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_dev);

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
    // Address 0x100-0xfff (3840 bytes) can be used for data buffers.
    // The first 0x100 bytes are registers (last one at offset 0xfc), the rest is available for
    // endpoint data buffers.
    const USB_DPRAM_DATA_BUFFER_BASE = @intFromPtr(peripherals.USB_DPRAM) + 0x100;

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
const BufferControlMmio = @TypeOf(peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL);
const buffer_control: *volatile [16]PerEndpoint(BufferControlMmio) = @ptrCast(&peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL);

const EndpointControlMmio = @TypeOf(peripherals.USB_DPRAM.EP1_IN_CONTROL);
const endpoint_control: *volatile [15]PerEndpoint(EndpointControlMmio) = @ptrCast(&peripherals.USB_DPRAM.EP1_IN_CONTROL);

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
        pub const max_supported_bcd_usb: usb.types.Version = .v1_10;
        pub const default_vendor_id: usb.Config.IdStringPair = .{ .id = 0x2E8A, .str = "Raspberry Pi" };
        pub const default_product_id: usb.Config.IdStringPair = switch (chip) {
            .RP2040 => .{ .id = 0x000A, .str = "Pico test device" },
            .RP2350 => .{ .id = 0x000F, .str = "Pico 2 test device" },
        };

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

        /// Poll to see if the host has sent anything. Delegate to the appropriate handler in the
        /// controller based on the interrupt field set.
        pub fn poll(self: *@This(), controller: anytype) void {
            comptime usb.validate_controller(@TypeOf(controller));

            // Check which interrupt flags are set.
            const ints = peripherals.USB.INTS.read();

            // Setup request received?
            if (ints.SETUP_REQ != 0) {
                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1.
                buffer_control[0].in.modify(.{ .PID_0 = 0 });

                // Clear the status flag (write-one-to-clear)
                peripherals.USB.SIE_STATUS.modify(.{ .SETUP_REC = 1 });

                // The SVD exposes this buffer as two 32-bit registers.
                const setup: usb.types.SetupPacket = @bitCast([2]u32{
                    peripherals.USB_DPRAM.SETUP_PACKET_LOW.raw,
                    peripherals.USB_DPRAM.SETUP_PACKET_HIGH.raw,
                });

                log.debug("setup {any}", .{setup});
                controller.on_setup_req(&self.interface, &setup);
            }

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BUFF_STATUS != 0) {
                const buff_status = peripherals.USB.BUFF_STATUS.raw;

                inline for (0..2 * config.max_endpoints_count) |shift| {
                    if (buff_status & (@as(u32, 1) << shift) != 0) {
                        // Here we exploit knowledge of the ordering of buffer control
                        // registers in the peripheral. Each endpoint has a pair of
                        // registers, IN being first
                        const ep_num = shift / 2;
                        const ep: usb.types.Endpoint = comptime .{
                            .num = @enumFromInt(ep_num),
                            .dir = if (shift % 2 == 0) .In else .Out,
                        };

                        // We should only get here if we've been notified that
                        // the buffer is ours again. This is indicated by the hw
                        // _clearing_ the AVAILABLE bit.
                        //
                        // It seems the hardware sets the AVAILABLE bit _after_ setting BUFF_STATUS
                        // So we wait for it just to be sure.
                        while (buffer_control[ep_num].get(ep.dir).read().AVAILABLE_0 != 0) {}

                        log.debug("buffer ep{} {t}", .{ ep_num, ep.dir });
                        controller.on_buffer(&self.interface, ep);
                    }
                }
                peripherals.USB.BUFF_STATUS.raw = buff_status;
            }

            // Has the host signaled a bus reset?
            if (ints.BUS_RESET != 0) {
                log.info("bus reset", .{});

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
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.raw = 0;
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.raw = 0;

            for (1..config.max_endpoints_count) |i| {
                endpoint_control[i - 1].in.raw = 0;
                endpoint_control[i - 1].out.raw = 0;
            }

            for (0..config.max_endpoints_count) |i| {
                buffer_control[i].in.raw = 0;
                buffer_control[i].out.raw = 0;
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
            // Set up endpoints.
            self.interface.ep_open(&.control(.in(.ep0), max_supported_packet_size));
            self.interface.ep_open(&.control(.out(.ep0), max_supported_packet_size));

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peripherals.USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });

            // Listen for ACKs
            self.interface.ep_listen(.ep0, max_supported_packet_size);

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
            log.debug("writev {t} {}: {any}", .{ ep_num, data[0].len, data[0] });

            const self: *@This() = @fieldParentPtr("interface", itf);

            const bufctrl_ptr = &buffer_control[@intFromEnum(ep_num)].in;
            const ep = self.hardware_endpoint_get_by_address(.in(ep_num));
            var hw_buf: []align(1) u8 = ep.data_buffer;

            for (data) |src| {
                const len = @min(src.len, hw_buf.len);
                dpram_memcpy(hw_buf[0..len], src[0..len]);
                hw_buf = hw_buf[len..];
            }

            const len: usb.types.Len = @intCast(ep.data_buffer.len - hw_buf.len);

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

            return len;
        }

        /// Copies the last sent packet from USB SRAM into the provided buffer.
        /// Slices in `data` must collectively be long enough to store the full packet.
        fn ep_readv(
            itf: *usb.DeviceInterface,
            ep_num: usb.types.Endpoint.Num,
            data: []const []u8,
        ) usb.types.Len {
            var total_len: usize = data[0].len;
            for (data[1..]) |d| total_len += d.len;
            log.debug("readv {t} {}", .{ ep_num, total_len });

            const self: *@This() = @fieldParentPtr("interface", itf);
            assert(data.len > 0);

            const bufctrl = buffer_control[@intFromEnum(ep_num)].out.read();
            const ep = self.hardware_endpoint_get_by_address(.out(ep_num));
            var hw_buf: []align(1) u8 = ep.data_buffer[0..bufctrl.LENGTH_0];
            for (data) |dst| {
                const len = @min(dst.len, hw_buf.len);
                dpram_memcpy(dst[0..len], hw_buf[0..len]);

                hw_buf = hw_buf[len..];
                if (hw_buf.len == 0)
                    return @intCast(hw_buf.ptr - ep.data_buffer.ptr);
            }
            log.warn("discarding rx data on ep {t}, {} bytes received", .{ ep_num, bufctrl.LENGTH_0 });
            return @intCast(total_len);
        }

        fn ep_listen(
            itf: *usb.DeviceInterface,
            ep_num: usb.types.Endpoint.Num,
            len: usb.types.Len,
        ) void {
            log.debug("listen {t} {}", .{ ep_num, len });

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

        fn set_address(_: *usb.DeviceInterface, addr: u7) void {
            log.debug("set addr {}", .{addr});

            peripherals.USB.ADDR_ENDP.write(.{ .ADDRESS = addr });
        }

        /// On the RP2350 @memcpy uses unaligned accesses,
        /// which only work on SRAM and fault on peripheral memory.
        fn dpram_memcpy(dst: []u8, src: []const u8) void {
            switch (chip) {
                .RP2040 => @memcpy(dst, src),
                .RP2350 => {
                    assert(dst.len == src.len);
                    // Could be optimized for aligned data, for now just copy
                    // byte by byte. Atomic operations are used so that
                    // the compiler does not try to optimize this.
                    for (dst, src) |*d, *s| {
                        const tmp = @atomicLoad(u8, s, .unordered);
                        @atomicStore(u8, d, tmp, .unordered);
                    }
                },
            }
        }

        fn hardware_endpoint_get_by_address(self: *@This(), ep: usb.types.Endpoint) *HardwareEndpointData {
            return &self.endpoints[@intFromEnum(ep.num)][@intFromEnum(ep.dir)];
        }

        fn ep_open(itf: *usb.DeviceInterface, desc: *const usb.descriptor.Endpoint) void {
            const ep = desc.endpoint;
            const attr = desc.attributes;
            log.debug(
                "ep open {t} {t} {{ type: {t}, sync: {t}, usage: {t}, size: {} }}",
                .{ ep.num, ep.dir, attr.transfer_type, attr.synchronisation, attr.usage, desc.max_packet_size.into() },
            );

            const self: *@This() = @fieldParentPtr("interface", itf);

            assert(@intFromEnum(desc.endpoint.num) <= config.max_endpoints_count);

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
                    .ENDPOINT_TYPE = @enumFromInt(@intFromEnum(attr.transfer_type)),
                    .BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep_hard.data_buffer),
                });
            }
            @memset(ep_hard.data_buffer, 0);
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

pub fn ResetDriver(bootsel_activity_led: ?u5, interface_disable_mask: u32) type {
    return struct {
        const log_drv = std.log.scoped(.pico_reset);

        pub const Descriptor = extern struct {
            reset_interface: usb.descriptor.Interface,

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                _: usb.types.Len,
                interface_str: []const u8,
            ) usb.DescriptorCreateResult(@This()) {
                return .{ .descriptor = .{ .reset_interface = .{
                    .interface_number = alloc.next_itf(),
                    .alternate_setting = 0,
                    .num_endpoints = 0,
                    .interface_triple = .from(
                        .VendorSpecific,
                        @enumFromInt(0x00),
                        @enumFromInt(0x01),
                    ),
                    .interface_s = alloc.string(interface_str),
                } } };
            }
        };

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface) void {
            _ = desc;
            _ = device;
            self.* = .{};
        }

        pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            _ = self;
            switch (setup.request) {
                0x01 => {
                    const value = setup.value.into();
                    const mask = @as(u32, 1) << if (value & 0x100 != 0)
                        @intCast(value >> 9)
                    else
                        bootsel_activity_led orelse 0;
                    const itf_disable = (value & 0x7F) | interface_disable_mask;
                    log_drv.debug("Resetting to bootsel. Mask: {} Itf disable: {}", .{ mask, itf_disable });
                    microzig.hal.rom.reset_to_usb_boot();
                },
                0x02 => {
                    log_drv.debug("Resetting to flash", .{});
                    // Not implemented yet
                    microzig.hal.rom.reset_to_usb_boot();
                },
                else => return usb.nak,
            }
            return usb.ack;
        }
    };
}
