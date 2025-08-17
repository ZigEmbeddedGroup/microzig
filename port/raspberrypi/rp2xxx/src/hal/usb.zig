//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const chip = microzig.hal.compatibility.chip;

pub const usb = microzig.core.usb;
pub const types = usb.types;
pub const hid = usb.hid;
pub const cdc = usb.cdc;
pub const vendor = usb.vendor;
pub const templates = usb.templates.DescriptorsConfigTemplates;
pub const utils = usb.UsbUtils;

const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const UsbConfig = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: u8 = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: u8 = 16,
};

/// The rp2040 usb device impl
///
/// We create a concrete implementaion by passing a handful
/// of system specific functions to Usb(). Those functions
/// are used by the abstract USB impl of microzig.
pub fn Usb(comptime config: UsbConfig) type {
    return usb.Usb(F(config));
}

pub const DeviceConfiguration = usb.DeviceConfiguration;
pub const DeviceDescriptor = usb.DeviceDescriptor;
pub const DescType = usb.types.DescType;
pub const InterfaceDescriptor = usb.types.InterfaceDescriptor;
pub const ConfigurationDescriptor = usb.types.ConfigurationDescriptor;
pub const EndpointDescriptor = usb.types.EndpointDescriptor;
pub const EndpointConfiguration = usb.EndpointConfiguration;
pub const Dir = usb.types.Dir;
pub const TransferType = usb.types.TransferType;
pub const Endpoint = usb.types.Endpoint;

pub const utf8ToUtf16Le = usb.utf8ToUtf16Le;

const BufferControlMmio = microzig.mmio.Mmio(@TypeOf(microzig.chip.peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL).underlying_type);
const EndpointControlMimo = microzig.mmio.Mmio(@TypeOf(peripherals.USB_DPRAM.EP1_IN_CONTROL).underlying_type);
const EndpointType = microzig.chip.types.peripherals.USB_DPRAM.EndpointType;

const HardwareEndpoint = struct {
    configured: bool,
    ep: Endpoint,
    next_pid_1: bool,
    transfer_type: types.TransferType,
    endpoint_control_index: usize,
    buffer_control_index: usize,
    awaiting_rx: bool,

    max_packet_size: u11,
    buffer_control: ?*BufferControlMmio,
    endpoint_control: ?*EndpointControlMimo,
    data_buffer: []u8,
};

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
        const buf_base = @intFromPtr(&ep_data_buffer[0]);
        const dpram_base = @intFromPtr(peripherals.USB_DPRAM);
        return @as(u16, @intCast(buf_base - dpram_base));
    }
};

const rp2xxx_endpoints = struct {
    const USB_DPRAM_BASE = 0x50100000;
    const USB_DPRAM_BUFFERS_BASE = USB_DPRAM_BASE + 0x100;
    const USB_DPRAM_BUFFERS_CTRL_BASE = USB_DPRAM_BASE + 0x80;
    const USB_DPRAM_ENDPOINTS_CTRL_BASE = USB_DPRAM_BASE + 0x8;

    fn dir_index(dir: types.Dir) u1 {
        return switch (dir) {
            .In => 0,
            .Out => 1,
        };
    }

    pub fn get_ep_ctrl(ep: Endpoint) ?*EndpointControlMimo {
        if (ep.num == .ep0) {
            return null;
        } else {
            const ep_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_ENDPOINTS_CTRL_BASE));
            return @ptrCast(&ep_ctrl_base[ep.num.to_int() - 1][dir_index(ep.dir)]);
        }
    }

    pub fn get_buf_ctrl(ep: Endpoint) ?*BufferControlMmio {
        const buf_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_BUFFERS_CTRL_BASE));
        return @ptrCast(&buf_ctrl_base[ep.num.to_int()][dir_index(ep.dir)]);
    }
};

pub const ClkSrc = enum { pll_usb, pll_sys, xosc, gpin0, gpin1 };

/// You have to guarantee that the used source is 48 MHz.
pub fn init_clk(clk_src: ClkSrc) void {
    switch (clk_src) {
        .pll_usb => peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .clksrc_pll_usb }),
        .pll_sys => peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .clksrc_pll_sys }),
        .xosc => peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .xosc_clksrc }),
        .gpin0 => peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .clksrc_gpin0 }),
        .gpin1 => peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .clksrc_gpin1 }),
    }
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// A set of functions required by the abstract USB impl to
/// create a concrete one.
pub fn F(comptime config: UsbConfig) type {
    comptime {
        if (config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT) {
            @compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
        }
    }

    return struct {
        pub const cfg_max_endpoints_count: u8 = config.max_endpoints_count;
        pub const cfg_max_interfaces_count: u8 = config.max_interfaces_count;
        pub const high_speed = false;

        var endpoints: [config.max_endpoints_count][2]HardwareEndpoint = undefined;
        var data_buffer: []u8 = rp2xxx_buffers.data_buffer;

        pub fn usb_init_device(_: *usb.DeviceConfiguration) void {
            if (chip == .RP2350) {
                peripherals.USB.MAIN_CTRL.modify(.{
                    .PHY_ISO = 0,
                });
            }

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            for (1..cfg_max_endpoints_count) |i| {
                rp2xxx_endpoints.get_ep_ctrl(.in(.from_int(@intCast(i)))).?.write_raw(0);
                rp2xxx_endpoints.get_ep_ctrl(.out(.from_int(@intCast(i)))).?.write_raw(0);
            }

            for (0..cfg_max_endpoints_count) |i| {
                rp2xxx_endpoints.get_buf_ctrl(.in(.from_int(@intCast(i)))).?.write_raw(0);
                rp2xxx_endpoints.get_buf_ctrl(.out(.from_int(@intCast(i)))).?.write_raw(0);
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

            @memset(std.mem.asBytes(&endpoints), 0);
            endpoint_open(.in(.ep0), 64, types.TransferType.Control);
            endpoint_open(.out(.ep0), 64, types.TransferType.Control);

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
            const ep_hard = hardware_endpoint(.in(ep_in));

            // It is technically possible to support longer buffers but this demo doesn't bother.
            const dst_buf_len = 64;
            var n: usize = 0;
            for (data) |buffer| {
                const space_left = dst_buf_len - n;
                if (space_left >= buffer.len) {
                    // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
                    std.mem.copyForwards(u8, ep_hard.data_buffer[n .. n + buffer.len], buffer);
                    n += buffer.len;
                } else {
                    std.mem.copyForwards(u8, ep_hard.data_buffer[n..], buffer[0..space_left]);
                    n = dst_buf_len;
                }
            }

            // The AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            // Write the buffer information to the buffer control register
            ep_hard.buffer_control.?.modify(.{
                .PID_0 = @as(u1, @intFromBool(ep_hard.next_pid_1)), // DATA0/1, depending
                .FULL_0 = 1, // We have put data in
                .LENGTH_0 = @as(u10, @intCast(n)), // There are this many bytes
            });

            // Nop for some clock cycles
            // use volatile so the compiler doesn't optimize the nops away
            asm volatile (
                \\ nop
                \\ nop
                \\ nop
            );

            // Set available bit
            ep_hard.buffer_control.?.modify(.{
                .AVAILABLE_0 = 1, // The data is for the computer to use now
            });

            ep_hard.next_pid_1 = !ep_hard.next_pid_1;

            return n;
        }

        pub fn usb_start_rx(
            ep_out: Endpoint.Num,
            len: usize,
        ) void {
            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(len <= 64);

            const ep_hard = hardware_endpoint(.out(ep_out));

            if (ep_hard.awaiting_rx)
                return;

            // Check which DATA0/1 PID this endpoint is expecting next.
            const np: u1 = if (ep_hard.next_pid_1) 1 else 0;
            // Configure the OUT:
            ep_hard.buffer_control.?.modify(.{
                .PID_0 = np, // DATA0/1 depending
                .FULL_0 = 0, // Buffer is NOT full, we want the computer to fill it
                .AVAILABLE_0 = 1, // It is, however, available to be filled
                .LENGTH_0 = @as(u10, @intCast(len)), // Up tho this many bytes
            });

            // Flip the DATA0/1 PID for the next receive
            ep_hard.next_pid_1 = !ep_hard.next_pid_1;
            ep_hard.awaiting_rx = true;
        }

        pub fn endpoint_reset_rx(ep_out: Endpoint.Num) void {
            const ep_hard = hardware_endpoint(.out(ep_out));
            ep_hard.awaiting_rx = false;
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
            var ep = hardware_endpoint(.in(.ep0));
            ep.next_pid_1 = true;
        }

        fn hardware_endpoint(ep: Endpoint) *HardwareEndpoint {
            const dir_as_number: u1 = switch (ep.dir) {
                .Out => 0,
                .In => 1,
            };
            return &endpoints[ep.num.to_int()][dir_as_number];
        }

        pub fn endpoint_open(ep: Endpoint, max_packet_size: u11, transfer_type: types.TransferType) void {
            const ep_hard = hardware_endpoint(ep);

            endpoint_init(ep, max_packet_size, transfer_type);

            if (ep.num != .ep0) {
                endpoint_alloc(ep_hard) catch {};
                endpoint_enable(ep_hard);
            }
        }

        fn endpoint_init(ep: Endpoint, max_packet_size: u11, transfer_type: types.TransferType) void {
            assert(ep.num.to_int() <= cfg_max_endpoints_count);

            var ep_hard = hardware_endpoint(ep);
            ep_hard.ep = ep;
            ep_hard.max_packet_size = max_packet_size;
            ep_hard.transfer_type = transfer_type;
            ep_hard.next_pid_1 = false;
            ep_hard.awaiting_rx = false;

            ep_hard.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep);
            ep_hard.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep);

            if (ep.num == .ep0) {
                // ep0 has fixed data buffer
                ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
            }
        }

        fn endpoint_alloc(ep: *HardwareEndpoint) !void {
            // round up size to multiple of 64
            var size = try std.math.divCeil(u11, ep.max_packet_size, 64) * 64;
            // double buffered Bulk endpoint
            if (ep.transfer_type == .Bulk) {
                size *= 2;
            }

            std.debug.assert(data_buffer.len >= size);

            ep.data_buffer = data_buffer[0..size];
            data_buffer = data_buffer[size..];
        }

        fn endpoint_enable(ep: *HardwareEndpoint) void {
            ep.endpoint_control.?.modify(.{
                .ENABLE = 1,
                .INTERRUPT_PER_BUFF = 1,
                .ENDPOINT_TYPE = @as(EndpointType, @enumFromInt(ep.transfer_type.as_number())),
                .BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep.data_buffer),
            });
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
                    .dir = if (idx & 1 == 0) usb.types.Dir.In else usb.types.Dir.Out,
                };

                const ep_hard = hardware_endpoint(ep);
                const len = ep_hard.buffer_control.?.read().LENGTH_0;

                return .{
                    .endpoint = ep,
                    .buffer = ep_hard.data_buffer[0..len],
                };
            }
        };
    };
}
