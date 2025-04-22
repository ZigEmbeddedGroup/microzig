//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)
//! Currently progressing towards adopting the TinyUSB like API

const std = @import("std");

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
    ep_addr: u8,
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

    pub fn get_ep_ctrl(ep_num: u8, ep_dir: types.Dir) ?*EndpointControlMimo {
        if (ep_num == 0) {
            return null;
        } else {
            const dir_index: u8 = if (ep_dir == .In) 0 else 1;
            const ep_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_ENDPOINTS_CTRL_BASE));
            return @ptrCast(&ep_ctrl_base[ep_num - 1][dir_index]);
        }
    }

    pub fn get_buf_ctrl(ep_num: u8, ep_dir: types.Dir) ?*BufferControlMmio {
        const dir_index: u8 = if (ep_dir == .In) 0 else 1;
        const buf_ctrl_base = @as([*][2]u32, @ptrFromInt(USB_DPRAM_BUFFERS_CTRL_BASE));
        return @ptrCast(&buf_ctrl_base[ep_num][dir_index]);
    }
};

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

        /// Initialize the USB clock to 48 MHz
        ///
        /// This requres that the system clock has been set up before hand
        /// using the 12 MHz crystal.
        pub fn usb_init_clk() void {
            // Bring PLL_USB up to 48MHz. PLL_USB is clocked from refclk, which we've
            // already moved over to the 12MHz XOSC. We just need to make it x4 that
            // clock.
            //
            // Configure it:
            //
            // RFDIV = 1
            // FBDIV = 100 => FOUTVC0 = 1200 MHz
            peripherals.PLL_USB.CS.modify(.{ .REFDIV = 1 });
            peripherals.PLL_USB.FBDIV_INT.modify(.{ .FBDIV_INT = 100 });
            peripherals.PLL_USB.PWR.modify(.{ .PD = 0, .VCOPD = 0 });
            // Wait for lock
            while (peripherals.PLL_USB.CS.read().LOCK == 0) {}
            // Set up post dividers to enable output
            //
            // POSTDIV1 = POSTDIV2 = 5
            // PLL_USB FOUT = 1200 MHz / 25 = 48 MHz
            peripherals.PLL_USB.PRIM.modify(.{ .POSTDIV1 = 5, .POSTDIV2 = 5 });
            peripherals.PLL_USB.PWR.modify(.{ .POSTDIVPD = 0 });
            // Switch usbclk to be derived from PLLUSB
            peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .clksrc_pll_usb });

            // We now have the stable 48MHz reference clock required for USB:
        }

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
                rp2xxx_endpoints.get_ep_ctrl(@intCast(i), .In).?.write_raw(0);
                rp2xxx_endpoints.get_ep_ctrl(@intCast(i), .Out).?.write_raw(0);
            }

            for (0..cfg_max_endpoints_count) |i| {
                rp2xxx_endpoints.get_buf_ctrl(@intCast(i), .In).?.write_raw(0);
                rp2xxx_endpoints.get_buf_ctrl(@intCast(i), .Out).?.write_raw(0);
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
            endpoint_open(Endpoint.EP0_IN_ADDR, 64, types.TransferType.Control);
            endpoint_open(Endpoint.EP0_OUT_ADDR, 64, types.TransferType.Control);

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
        pub fn usb_start_tx(
            ep_addr: u8,
            buffer: []const u8,
        ) void {
            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(buffer.len() <= 64);
            // You should only be calling this on IN endpoints.
            // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);

            const ep = hardware_endpoint_get_by_address(ep_addr);

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

        pub fn usb_start_rx(
            ep_addr: u8,
            len: usize,
        ) void {
            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            // TODO: assert!(len <= 64);
            // You should only be calling this on OUT endpoints.
            // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);

            const ep = hardware_endpoint_get_by_address(ep_addr);

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

        pub fn endpoint_reset_rx(ep_addr: u8) void {
            const ep = hardware_endpoint_get_by_address(ep_addr);
            ep.awaiting_rx = false;
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
            var ep = hardware_endpoint_get_by_address(Endpoint.EP0_IN_ADDR);
            ep.next_pid_1 = true;
        }

        fn hardware_endpoint_get_by_address(ep_addr: u8) *HardwareEndpoint {
            const num = Endpoint.num_from_address(ep_addr);
            const dir = Endpoint.dir_from_address(ep_addr);
            return &endpoints[num][dir.as_number()];
        }

        pub fn endpoint_open(ep_addr: u8, max_packet_size: u11, transfer_type: types.TransferType) void {
            const ep_num = Endpoint.num_from_address(ep_addr);
            const ep = hardware_endpoint_get_by_address(ep_addr);

            endpoint_init(ep_addr, max_packet_size, transfer_type);

            if (ep_num != 0) {
                endpoint_alloc(ep) catch {};
                endpoint_enable(ep);
            }
        }

        fn endpoint_init(ep_addr: u8, max_packet_size: u11, transfer_type: types.TransferType) void {
            const ep_num = Endpoint.num_from_address(ep_addr);
            const ep_dir = Endpoint.dir_from_address(ep_addr);

            std.debug.assert(ep_num <= cfg_max_endpoints_count);

            var ep = hardware_endpoint_get_by_address(ep_addr);
            ep.ep_addr = ep_addr;
            ep.max_packet_size = max_packet_size;
            ep.transfer_type = transfer_type;
            ep.next_pid_1 = false;
            ep.awaiting_rx = false;

            ep.buffer_control = rp2xxx_endpoints.get_buf_ctrl(ep_num, ep_dir);
            ep.endpoint_control = rp2xxx_endpoints.get_ep_ctrl(ep_num, ep_dir);

            if (ep_num == 0) {
                // ep0 has fixed data buffer
                ep.data_buffer = rp2xxx_buffers.ep0_buffer0;
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

        /// Iterator over endpoint buffers events
        pub fn get_EPBIter(dc: *const usb.DeviceConfiguration) usb.EPBIter {
            return .{
                .bufbits = peripherals.USB.BUFF_STATUS.raw,
                .device_config = dc,
                .next = next,
            };
        }

        pub fn next(self: *usb.EPBIter) ?usb.EPB {
            if (self.last_bit) |lb| {
                // Acknowledge the last handled buffer
                peripherals.USB.BUFF_STATUS.write_raw(lb);
                self.last_bit = null;
            }
            // All input buffers handled?
            if (self.bufbits == 0) return null;

            // Who's still outstanding? Find their bit index by counting how
            // many LSBs are zero.
            var lowbit_index: u5 = 0;
            while ((self.bufbits >> lowbit_index) & 0x01 == 0) : (lowbit_index += 1) {}
            // Remove their bit from our set.
            const lowbit = @as(u32, @intCast(1)) << lowbit_index;
            self.last_bit = lowbit;
            self.bufbits ^= lowbit;

            // Here we exploit knowledge of the ordering of buffer control
            // registers in the peripheral. Each endpoint has a pair of
            // registers, so we can determine the endpoint number by:
            const epnum = @as(u8, @intCast(lowbit_index >> 1));
            // Of the pair, the IN endpoint comes first, followed by OUT, so
            // we can get the direction by:
            const dir = if (lowbit_index & 1 == 0) usb.types.Dir.In else usb.types.Dir.Out;

            const ep_addr = Endpoint.to_address(epnum, dir);
            // Process the buffer-done event.

            // Process the buffer-done event.
            //
            // Scan the device table to figure out which endpoint struct
            // corresponds to this address. We could use a smarter
            // method here, but in practice, the number of endpoints is
            // small so a linear scan doesn't kill us.

            const ep = hardware_endpoint_get_by_address(ep_addr);

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
            const len = ep.buffer_control.?.read().LENGTH_0;

            // Copy the data from SRAM
            return usb.EPB{
                .endpoint_address = ep_addr,
                .buffer = ep.data_buffer[0..len],
            };
        }
    };
}
