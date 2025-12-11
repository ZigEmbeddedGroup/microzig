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
const EpNum = usb.types.Endpoint.Num;

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const Config = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: u8 = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: u8 = 16,
};

pub const DeviceConfiguration = usb.DeviceConfiguration;
pub const DeviceDescriptor = usb.DeviceDescriptor;
pub const DescType = usb.descriptor.Type;
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
    ep_addr: types.Endpoint,
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

    pub fn get_ep_ctrl(ep_num: EpNum, ep_dir: types.Dir) ?*EndpointControlMimo {
        if (ep_num == .ep0) {
            return null;
        } else {
            const dir_index: u8 = if (ep_dir == .In) 0 else 1;
            const ep_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_ENDPOINTS_CTRL_BASE));
            return @ptrCast(&ep_ctrl_base[@intFromEnum(ep_num) - 1][dir_index]);
        }
    }

    pub fn get_buf_ctrl(ep_num: EpNum, ep_dir: types.Dir) ?*BufferControlMmio {
        const dir_index: u8 = if (ep_dir == .In) 0 else 1;
        const buf_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_BUFFERS_CTRL_BASE));
        return @ptrCast(&buf_ctrl_base[@intFromEnum(ep_num)][dir_index]);
    }
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// A set of functions required by the abstract USB impl to
/// create a concrete one.
pub fn Polled(
    config_descriptor: anytype,
    controller_config: usb.Config,
    device_config: Config,
) type {
    comptime {
        if (device_config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
            @compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
    }

    return struct {
        const vtable: usb.DeviceInterface.VTable = .{
            .start_tx = start_tx,
            .start_rx = start_rx,
            .set_address = set_address,
            .endpoint_open = endpoint_open,
        };

        endpoints: [device_config.max_endpoints_count][2]HardwareEndpoint,
        data_buffer: []u8,
        controller: usb.DeviceController(config_descriptor, controller_config),
        interface: usb.DeviceInterface,

        pub fn poll(this: *@This()) void {
            // Check which interrupt flags are set.

            const ints = peripherals.USB.INTS.read();

            // Setup request received?
            if (ints.SETUP_REQ != 0) {
                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                var ep = this.hardware_endpoint_get_by_address(.in(.ep0));
                ep.next_pid_1 = true;

                const setup = get_setup_packet();
                this.controller.on_setup_req(&setup);
            }

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BUFF_STATUS != 0) {
                const bufbits_init = peripherals.USB.BUFF_STATUS.raw;
                var bufbits = bufbits_init;

                while (true) {
                    // Who's still outstanding? Find their bit index by counting how
                    // many LSBs are zero.
                    const lowbit_index = std.math.cast(u5, @ctz(bufbits)) orelse break;
                    // Remove their bit from our set.
                    bufbits ^= @as(u32, @intCast(1)) << lowbit_index;

                    // Here we exploit knowledge of the ordering of buffer control
                    // registers in the peripheral. Each endpoint has a pair of
                    // registers, so we can determine the endpoint number by:
                    const epnum = @as(u4, @intCast(lowbit_index >> 1));
                    // Of the pair, the IN endpoint comes first, followed by OUT, so
                    // we can get the direction by:
                    const dir = if (lowbit_index & 1 == 0) usb.types.Dir.In else usb.types.Dir.Out;

                    const ep: types.Endpoint = .{ .num = @enumFromInt(epnum), .dir = dir };
                    // Process the buffer-done event.

                    // Process the buffer-done event.
                    //
                    // Scan the device table to figure out which endpoint struct
                    // corresponds to this address. We could use a smarter
                    // method here, but in practice, the number of endpoints is
                    // small so a linear scan doesn't kill us.

                    const ep_hard = this.hardware_endpoint_get_by_address(ep);

                    // We should only get here if we've been notified that
                    // the buffer is ours again. This is indicated by the hw
                    // _clearing_ the AVAILABLE bit.
                    //
                    // This ensures that we can return a shared reference to
                    // the databuffer contents without races.
                    // TODO: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;

                    // Cool. Checks out.

                    // Get the actual length of the data, which may be less
                    // than the buffer size.
                    const len = ep_hard.buffer_control.?.read().LENGTH_0;

                    this.controller.on_buffer(ep, ep_hard.data_buffer[0..len]);

                    if (ep.dir == .Out)
                        ep_hard.awaiting_rx = false;
                }

                peripherals.USB.BUFF_STATUS.write_raw(bufbits_init);
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BUFF_STATUS != 0) {
                // Acknowledge by writing the write-one-to-clear status bit.
                peripherals.USB.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
                peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = 0 });

                this.controller.on_bus_reset();
            }
        }

        pub fn init(this: *@This()) void {
            if (chip == .RP2350) {
                peripherals.USB.MAIN_CTRL.modify(.{
                    .PHY_ISO = 0,
                });
            }

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            for (1..device_config.max_endpoints_count) |i| {
                rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .In).?.write_raw(0);
                rp2xxx_endpoints.get_ep_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
            }

            for (0..device_config.max_endpoints_count) |i| {
                rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .In).?.write_raw(0);
                rp2xxx_endpoints.get_buf_ctrl(@enumFromInt(i), .Out).?.write_raw(0);
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

            this.* = .{
                .endpoints = undefined,
                .data_buffer = rp2xxx_buffers.data_buffer,
                .interface = .{ .vtable = &vtable },
                .controller = .init(&this.interface),
            };

            @memset(std.mem.asBytes(&this.endpoints), 0);
            endpoint_open(&this.interface, &.{ .endpoint = .in(.ep0), .max_packet_size = .from(64), .attributes = .{ .transfer_type = .Control, .usage = .data }, .interval = 0 });
            endpoint_open(&this.interface, &.{ .endpoint = .out(.ep0), .max_packet_size = .from(64), .attributes = .{ .transfer_type = .Control, .usage = .data }, .interval = 0 });

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peripherals.USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
        }

        /// Configures a given endpoint to send data (device-to-host, IN) when the host
        /// next asks for it.
        ///
        /// The contents of `buffer` will be _copied_ into USB SRAM, so you can
        /// reuse `buffer` immediately after this returns. No need to wait for the
        /// packet to be sent.
        fn start_tx(
            itf: *usb.DeviceInterface,
            ep_num: EpNum,
            buffer: []const u8,
        ) void {
            const this: *@This() = @fieldParentPtr("interface", itf);

            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(buffer.len() <= 64);
            // You should only be calling this on IN endpoints.
            // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);

            const ep = this.hardware_endpoint_get_by_address(.in(ep_num));
            // wait for controller to give processor ownership of the buffer before writing it.
            // while (ep.buffer_control.?.read().AVAILABLE_0 == 1) {}

            // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
            std.mem.copyForwards(u8, ep.data_buffer[0..buffer.len], buffer);

            // Configure the IN:
            const np: u1 = if (ep.next_pid_1) 1 else 0;

            // The AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            // Write the buffer information to the buffer control register
            ep.buffer_control.?.modify(.{
                .PID_0 = np, // DATA0/1, depending
                .FULL_0 = 1, // We have put data in
                .LENGTH_0 = @as(u10, @intCast(buffer.len)), // There are this many bytes
            });

            // Nop for some clock cycles
            // use volatile so the compiler doesn't optimize the nops away
            asm volatile (
                \\ nop
                \\ nop
                \\ nop
            );

            // Set available bit
            ep.buffer_control.?.modify(.{
                .AVAILABLE_0 = 1, // The data is for the computer to use now
            });

            ep.next_pid_1 = !ep.next_pid_1;
        }

        fn start_rx(itf: *usb.DeviceInterface, ep_num: EpNum, len: usize) void {
            const this: *@This() = @fieldParentPtr("interface", itf);

            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(len <= 64);
            // You should only be calling this on OUT endpoints.
            // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);

            const ep = this.hardware_endpoint_get_by_address(.out(ep_num));

            if (ep.awaiting_rx)
                return;

            // Check which DATA0/1 PID this endpoint is expecting next.
            const np: u1 = if (ep.next_pid_1) 1 else 0;
            // Configure the OUT:
            ep.buffer_control.?.modify(.{
                .PID_0 = np, // DATA0/1 depending
                .FULL_0 = 0, // Buffer is NOT full, we want the computer to fill it
                .AVAILABLE_0 = 1, // It is, however, available to be filled
                .LENGTH_0 = @as(u10, @intCast(len)), // Up tho this many bytes
            });

            // Flip the DATA0/1 PID for the next receive
            ep.next_pid_1 = !ep.next_pid_1;
            ep.awaiting_rx = true;
        }

        /// Returns a received USB setup packet
        ///
        /// Side effect: The setup request status flag will be cleared
        ///
        /// One can assume that this function is only called if the
        /// setup request falg is set.
        fn get_setup_packet() usb.types.SetupPacket {
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

        fn set_address(itf: *usb.DeviceInterface, addr: u7) void {
            const this: *@This() = @fieldParentPtr("interface", itf);
            _ = this;

            peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = addr });
        }

        fn hardware_endpoint_get_by_address(this: *@This(), ep: types.Endpoint) *HardwareEndpoint {
            return &this.endpoints[@intFromEnum(ep.num)][@intFromEnum(ep.dir)];
        }

        fn endpoint_open(itf: *usb.DeviceInterface, desc: *const usb.descriptor.Endpoint) void {
            const this: *@This() = @fieldParentPtr("interface", itf);

            assert(@intFromEnum(desc.endpoint.num) <= device_config.max_endpoints_count);

            const ep = desc.endpoint;
            const ep_hard = this.hardware_endpoint_get_by_address(ep);

            ep_hard.ep_addr = ep;
            ep_hard.max_packet_size = @intCast(desc.max_packet_size.into());
            ep_hard.transfer_type = desc.attributes.transfer_type;
            ep_hard.next_pid_1 = false;
            ep_hard.awaiting_rx = false;

            ep_hard.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep.num, ep.dir);
            ep_hard.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep.num, ep.dir);

            if (ep.num == .ep0) {
                // ep0 has fixed data buffer
                ep_hard.data_buffer = rp2xxx_buffers.ep0_buffer0;
            } else {
                this.endpoint_alloc(ep_hard) catch {};
                endpoint_enable(ep_hard);
            }
        }

        fn endpoint_alloc(this: *@This(), ep: *HardwareEndpoint) !void {
            // round up size to multiple of 64
            var size = try std.math.divCeil(u11, ep.max_packet_size, 64) * 64;
            // double buffered Bulk endpoint
            if (ep.transfer_type == .Bulk) {
                size *= 2;
            }

            std.debug.assert(this.data_buffer.len >= size);

            ep.data_buffer = this.data_buffer[0..size];
            this.data_buffer = this.data_buffer[size..];
        }

        fn endpoint_enable(ep: *HardwareEndpoint) void {
            ep.endpoint_control.?.modify(.{
                .ENABLE = 1,
                .INTERRUPT_PER_BUFF = 1,
                .ENDPOINT_TYPE = @as(EndpointType, @enumFromInt(@intFromEnum(ep.transfer_type))),
                .BUFFER_ADDRESS = rp2xxx_buffers.data_offset(ep.data_buffer),
            });
        }
    };
}
