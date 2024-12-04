//! USB device implementation
//!
//! Inspired by cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

/// Human Interface Device (HID)
pub const usb = microzig.core.usb;
pub const types = usb.types;
pub const hid = usb.hid;
pub const cdc = usb.cdc;
pub const vendor = usb.vendor;
pub const templates = usb.templates.DescriptorsConfigTemplates;
pub const utils = usb.UsbUtils;

const rom = @import("rom.zig");
const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const UsbConfig = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: u8 = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: u8 = 16,
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// User Interface
// +++++++++++++++++++++++++++++++++++++++++++++++++

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

pub const utf8ToUtf16Le = usb.utf8Toutf16Le;

const HardwareEndpoint = struct {
    configured: bool,
    ep_addr: u8,
    next_pid_1: bool,
    max_packet_size: u16,
    transfer_type: types.TransferType,
    endpoint_control_index: usize,
    buffer_control_index: usize,
    data_buffer_index: usize,
    awaiting_rx: bool,
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Reference to endpoint buffers
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// USB data buffers
pub const buffers = struct {
    // Address 0x100-0xfff (3840 bytes) can be used for data buffers.
    const USBDPRAM_BASE = 0x50100100;
    // Data buffers are 64 bytes long as this is the max normal packet size
    const BUFFER_SIZE = 64;
    /// EP0 buffer 0 (shared between in and out)
    const USB_EP0_BUFFER0 = USBDPRAM_BASE;
    /// Optional EP0 buffer 1
    const USB_EP0_BUFFER1 = USBDPRAM_BASE + BUFFER_SIZE;
    /// Data buffers
    const USB_BUFFERS = USBDPRAM_BASE + (2 * BUFFER_SIZE);

    /// Mapping to the different data buffers in DPSRAM
    pub var B: usb.Buffers = .{
        .ep0_buffer0 = @as([*]u8, @ptrFromInt(USB_EP0_BUFFER0)),
        .ep0_buffer1 = @as([*]u8, @ptrFromInt(USB_EP0_BUFFER1)),
        // We will initialize this comptime in a loop
        .rest = .{
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (0 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (1 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (2 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (3 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (4 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (5 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (6 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (7 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (8 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (9 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (10 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (11 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (12 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (13 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (14 * BUFFER_SIZE))),
            @as([*]u8, @ptrFromInt(USB_BUFFERS + (15 * BUFFER_SIZE))),
        },
    };
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
            peripherals.CLOCKS.CLK_USB_CTRL.modify(.{ .AUXSRC = .{ .value = .clksrc_pll_usb } });

            // We now have the stable 48MHz reference clock required for USB:
        }

        pub fn usb_init_device(_: *usb.DeviceConfiguration) void {
            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peripherals.USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            peripherals.USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            peripherals.USB_DPRAM.EP1_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP1_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP2_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP2_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP3_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP3_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP4_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP4_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP5_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP5_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP6_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP6_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP7_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP7_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP8_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP8_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP9_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP9_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP10_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP10_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP11_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP11_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP12_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP12_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP13_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP13_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP14_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP14_OUT_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP15_IN_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP15_OUT_CONTROL.write_raw(0);

            peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP0_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP1_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP1_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP2_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP2_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP3_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP3_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP4_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP4_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP5_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP5_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP6_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP6_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP7_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP7_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP8_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP8_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP9_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP9_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP10_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP10_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP11_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP11_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP12_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP12_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP13_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP13_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP14_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP14_OUT_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP15_IN_BUFFER_CONTROL.write_raw(0);
            peripherals.USB_DPRAM.EP15_OUT_BUFFER_CONTROL.write_raw(0);

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
            endpoint_init(Endpoint.EP0_IN_ADDR, 64, types.TransferType.Control);
            endpoint_init(Endpoint.EP0_OUT_ADDR, 64, types.TransferType.Control);

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

            // Copy the given data into the corresponding ep buffer
            const epbuffer = buffers.B.get(ep.data_buffer_index);
            _ = rom.memcpy(epbuffer[0..buffer.len], buffer);

            // Configure the IN:
            const np: u1 = if (ep.next_pid_1) 1 else 0;

            // The AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            // Write the buffer information to the buffer control register
            modify_buffer_control(ep.buffer_control_index, .{
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
            modify_buffer_control(ep.buffer_control_index, .{
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
            modify_buffer_control(ep.buffer_control_index, .{
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
            var setup_packet: [8]u8 = .{0} ** 8;
            const spl: u32 = peripherals.USB_DPRAM.SETUP_PACKET_LOW.raw;
            const sph: u32 = peripherals.USB_DPRAM.SETUP_PACKET_HIGH.raw;
            _ = rom.memcpy(setup_packet[0..4], std.mem.asBytes(&spl));
            _ = rom.memcpy(setup_packet[4..8], std.mem.asBytes(&sph));
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

        pub fn get_EPBIter(dc: *const usb.DeviceConfiguration) usb.EPBIter {
            return .{
                .bufbits = peripherals.USB.BUFF_STATUS.raw,
                .device_config = dc,
                .next = next,
            };
        }

        fn hardware_endpoint_get_by_address(ep_addr: u8) *HardwareEndpoint {
            const num = Endpoint.num_from_address(ep_addr);
            const dir = Endpoint.dir_from_address(ep_addr);
            return &endpoints[num][dir.as_number()];
        }

        pub fn endpoint_init(ep_addr: u8, max_packet_size: u16, transfer_type: types.TransferType) void {
            const ep_num = Endpoint.num_from_address(ep_addr);
            const ep_dir = Endpoint.dir_from_address(ep_addr);

            std.debug.assert(ep_num <= cfg_max_endpoints_count);

            var ep = hardware_endpoint_get_by_address(ep_addr);
            ep.ep_addr = ep_addr;
            ep.max_packet_size = max_packet_size;
            ep.transfer_type = transfer_type;
            ep.next_pid_1 = false;
            ep.awaiting_rx = false;

            ep.buffer_control_index = 2 * ep_num + ep_dir.as_number_reversed();

            if (ep_num == 0) {
                ep.data_buffer_index = 0;
                ep.endpoint_control_index = 0;
            } else {
                // TODO - some other way to deal with it
                ep.data_buffer_index = 2 * ep_num + ep_dir.as_number();
                ep.endpoint_control_index = 2 * ep_num - ep_dir.as_number();
                endpoint_alloc(ep, transfer_type);
            }
        }

        fn endpoint_alloc(ep: *HardwareEndpoint, transfer_type: TransferType) void {
            const buf_base = @intFromPtr(buffers.B.get(ep.data_buffer_index));
            const dpram_base = @intFromPtr(peripherals.USB_DPRAM);
            // The offset _should_ fit in a u16, but if we've gotten something
            // wrong in the past few lines, a common symptom will be integer
            // overflow producing a Very Large Number,
            const dpram_offset = @as(u16, @intCast(buf_base - dpram_base));

            // Configure the endpoint!
            modify_endpoint_control(ep.endpoint_control_index, .{
                .ENABLE = 1,
                // Please set the corresponding bit in buff_status when a
                // buffer is done, thx.
                .INTERRUPT_PER_BUFF = 1,
                // Select bulk vs control (or interrupt as soon as implemented).
                .ENDPOINT_TYPE = .{ .raw = transfer_type.as_number() },
                // And, designate our buffer by its offset.
                .BUFFER_ADDRESS = dpram_offset,
            });
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

            const endpoint = hardware_endpoint_get_by_address(ep_addr);

            // Buffer event for unknown EP?!
            // TODO: if (endpoint == null) return EPBError.UnknownEndpoint;
            // Read the buffer control register to check status.
            const bc = read_raw_buffer_control(endpoint.buffer_control_index);

            // We should only get here if we've been notified that
            // the buffer is ours again. This is indicated by the hw
            // _clearing_ the AVAILABLE bit.
            //
            // This ensures that we can return a shared reference to
            // the databuffer contents without races.
            // TODO: if ((bc & (1 << 10)) == 1) return EPBError.NotAvailable;

            // Cool. Checks out.

            // Get a pointer to the buffer in USB SRAM. This is the
            // buffer _contents_. See the safety comments below.
            const epbuffer = buffers.B.get(endpoint.data_buffer_index);

            // Get the actual length of the data, which may be less
            // than the buffer size.
            const len = @as(usize, @intCast(bc & 0x3ff));

            // Copy the data from SRAM
            return usb.EPB{
                .endpoint_address = ep_addr,
                .buffer = epbuffer[0..len],
            };
        }
    };
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Utility functions
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub fn modify_buffer_control(
    i: usize,
    fields: anytype,
) void {
    // haven't found a better way to handle this
    switch (i) {
        0 => peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL.modify(fields),
        1 => peripherals.USB_DPRAM.EP0_OUT_BUFFER_CONTROL.modify(fields),
        2 => peripherals.USB_DPRAM.EP1_IN_BUFFER_CONTROL.modify(fields),
        3 => peripherals.USB_DPRAM.EP1_OUT_BUFFER_CONTROL.modify(fields),
        4 => peripherals.USB_DPRAM.EP2_IN_BUFFER_CONTROL.modify(fields),
        5 => peripherals.USB_DPRAM.EP2_OUT_BUFFER_CONTROL.modify(fields),
        6 => peripherals.USB_DPRAM.EP3_IN_BUFFER_CONTROL.modify(fields),
        7 => peripherals.USB_DPRAM.EP3_OUT_BUFFER_CONTROL.modify(fields),
        8 => peripherals.USB_DPRAM.EP4_IN_BUFFER_CONTROL.modify(fields),
        9 => peripherals.USB_DPRAM.EP4_OUT_BUFFER_CONTROL.modify(fields),
        10 => peripherals.USB_DPRAM.EP5_IN_BUFFER_CONTROL.modify(fields),
        11 => peripherals.USB_DPRAM.EP5_OUT_BUFFER_CONTROL.modify(fields),
        12 => peripherals.USB_DPRAM.EP6_IN_BUFFER_CONTROL.modify(fields),
        13 => peripherals.USB_DPRAM.EP6_OUT_BUFFER_CONTROL.modify(fields),
        14 => peripherals.USB_DPRAM.EP7_IN_BUFFER_CONTROL.modify(fields),
        15 => peripherals.USB_DPRAM.EP7_OUT_BUFFER_CONTROL.modify(fields),
        16 => peripherals.USB_DPRAM.EP8_IN_BUFFER_CONTROL.modify(fields),
        17 => peripherals.USB_DPRAM.EP8_OUT_BUFFER_CONTROL.modify(fields),
        18 => peripherals.USB_DPRAM.EP9_IN_BUFFER_CONTROL.modify(fields),
        19 => peripherals.USB_DPRAM.EP9_OUT_BUFFER_CONTROL.modify(fields),
        20 => peripherals.USB_DPRAM.EP10_IN_BUFFER_CONTROL.modify(fields),
        21 => peripherals.USB_DPRAM.EP10_OUT_BUFFER_CONTROL.modify(fields),
        22 => peripherals.USB_DPRAM.EP11_IN_BUFFER_CONTROL.modify(fields),
        23 => peripherals.USB_DPRAM.EP11_OUT_BUFFER_CONTROL.modify(fields),
        24 => peripherals.USB_DPRAM.EP12_IN_BUFFER_CONTROL.modify(fields),
        25 => peripherals.USB_DPRAM.EP12_OUT_BUFFER_CONTROL.modify(fields),
        26 => peripherals.USB_DPRAM.EP13_IN_BUFFER_CONTROL.modify(fields),
        27 => peripherals.USB_DPRAM.EP13_OUT_BUFFER_CONTROL.modify(fields),
        28 => peripherals.USB_DPRAM.EP14_IN_BUFFER_CONTROL.modify(fields),
        29 => peripherals.USB_DPRAM.EP14_OUT_BUFFER_CONTROL.modify(fields),
        30 => peripherals.USB_DPRAM.EP15_IN_BUFFER_CONTROL.modify(fields),
        31 => peripherals.USB_DPRAM.EP15_OUT_BUFFER_CONTROL.modify(fields),
        else => {}, // TODO: We'll just ignore it for now
    }
}

pub fn read_raw_buffer_control(
    i: usize,
) u32 {
    // haven't found a better way to handle this
    return switch (i) {
        0 => peripherals.USB_DPRAM.EP0_IN_BUFFER_CONTROL.raw,
        1 => peripherals.USB_DPRAM.EP0_OUT_BUFFER_CONTROL.raw,
        2 => peripherals.USB_DPRAM.EP1_IN_BUFFER_CONTROL.raw,
        3 => peripherals.USB_DPRAM.EP1_OUT_BUFFER_CONTROL.raw,
        4 => peripherals.USB_DPRAM.EP2_IN_BUFFER_CONTROL.raw,
        5 => peripherals.USB_DPRAM.EP2_OUT_BUFFER_CONTROL.raw,
        6 => peripherals.USB_DPRAM.EP3_IN_BUFFER_CONTROL.raw,
        7 => peripherals.USB_DPRAM.EP3_OUT_BUFFER_CONTROL.raw,
        8 => peripherals.USB_DPRAM.EP4_IN_BUFFER_CONTROL.raw,
        9 => peripherals.USB_DPRAM.EP4_OUT_BUFFER_CONTROL.raw,
        10 => peripherals.USB_DPRAM.EP5_IN_BUFFER_CONTROL.raw,
        11 => peripherals.USB_DPRAM.EP5_OUT_BUFFER_CONTROL.raw,
        12 => peripherals.USB_DPRAM.EP6_IN_BUFFER_CONTROL.raw,
        13 => peripherals.USB_DPRAM.EP6_OUT_BUFFER_CONTROL.raw,
        14 => peripherals.USB_DPRAM.EP7_IN_BUFFER_CONTROL.raw,
        15 => peripherals.USB_DPRAM.EP7_OUT_BUFFER_CONTROL.raw,
        16 => peripherals.USB_DPRAM.EP8_IN_BUFFER_CONTROL.raw,
        17 => peripherals.USB_DPRAM.EP8_OUT_BUFFER_CONTROL.raw,
        18 => peripherals.USB_DPRAM.EP9_IN_BUFFER_CONTROL.raw,
        19 => peripherals.USB_DPRAM.EP9_OUT_BUFFER_CONTROL.raw,
        20 => peripherals.USB_DPRAM.EP10_IN_BUFFER_CONTROL.raw,
        21 => peripherals.USB_DPRAM.EP10_OUT_BUFFER_CONTROL.raw,
        22 => peripherals.USB_DPRAM.EP11_IN_BUFFER_CONTROL.raw,
        23 => peripherals.USB_DPRAM.EP11_OUT_BUFFER_CONTROL.raw,
        24 => peripherals.USB_DPRAM.EP12_IN_BUFFER_CONTROL.raw,
        25 => peripherals.USB_DPRAM.EP12_OUT_BUFFER_CONTROL.raw,
        26 => peripherals.USB_DPRAM.EP13_IN_BUFFER_CONTROL.raw,
        27 => peripherals.USB_DPRAM.EP13_OUT_BUFFER_CONTROL.raw,
        28 => peripherals.USB_DPRAM.EP14_IN_BUFFER_CONTROL.raw,
        29 => peripherals.USB_DPRAM.EP14_OUT_BUFFER_CONTROL.raw,
        30 => peripherals.USB_DPRAM.EP15_IN_BUFFER_CONTROL.raw,
        31 => peripherals.USB_DPRAM.EP15_OUT_BUFFER_CONTROL.raw,
        else => 0, // TODO: We'll just return 0 for now
    };
}

pub fn modify_endpoint_control(
    epci: usize,
    fields: anytype,
) void {
    // haven't found a better way to handle this
    switch (epci) {
        1 => peripherals.USB_DPRAM.EP1_IN_CONTROL.modify(fields),
        2 => peripherals.USB_DPRAM.EP1_OUT_CONTROL.modify(fields),
        3 => peripherals.USB_DPRAM.EP2_IN_CONTROL.modify(fields),
        4 => peripherals.USB_DPRAM.EP2_OUT_CONTROL.modify(fields),
        5 => peripherals.USB_DPRAM.EP3_IN_CONTROL.modify(fields),
        6 => peripherals.USB_DPRAM.EP3_OUT_CONTROL.modify(fields),
        7 => peripherals.USB_DPRAM.EP4_IN_CONTROL.modify(fields),
        8 => peripherals.USB_DPRAM.EP4_OUT_CONTROL.modify(fields),
        9 => peripherals.USB_DPRAM.EP5_IN_CONTROL.modify(fields),
        10 => peripherals.USB_DPRAM.EP5_OUT_CONTROL.modify(fields),
        11 => peripherals.USB_DPRAM.EP6_IN_CONTROL.modify(fields),
        12 => peripherals.USB_DPRAM.EP6_OUT_CONTROL.modify(fields),
        13 => peripherals.USB_DPRAM.EP7_IN_CONTROL.modify(fields),
        14 => peripherals.USB_DPRAM.EP7_OUT_CONTROL.modify(fields),
        15 => peripherals.USB_DPRAM.EP8_IN_CONTROL.modify(fields),
        16 => peripherals.USB_DPRAM.EP8_OUT_CONTROL.modify(fields),
        17 => peripherals.USB_DPRAM.EP9_IN_CONTROL.modify(fields),
        18 => peripherals.USB_DPRAM.EP9_OUT_CONTROL.modify(fields),
        19 => peripherals.USB_DPRAM.EP10_IN_CONTROL.modify(fields),
        20 => peripherals.USB_DPRAM.EP10_OUT_CONTROL.modify(fields),
        21 => peripherals.USB_DPRAM.EP11_IN_CONTROL.modify(fields),
        22 => peripherals.USB_DPRAM.EP11_OUT_CONTROL.modify(fields),
        23 => peripherals.USB_DPRAM.EP12_IN_CONTROL.modify(fields),
        24 => peripherals.USB_DPRAM.EP12_OUT_CONTROL.modify(fields),
        25 => peripherals.USB_DPRAM.EP13_IN_CONTROL.modify(fields),
        26 => peripherals.USB_DPRAM.EP13_OUT_CONTROL.modify(fields),
        27 => peripherals.USB_DPRAM.EP14_IN_CONTROL.modify(fields),
        28 => peripherals.USB_DPRAM.EP14_OUT_CONTROL.modify(fields),
        29 => peripherals.USB_DPRAM.EP15_IN_CONTROL.modify(fields),
        30 => peripherals.USB_DPRAM.EP15_OUT_CONTROL.modify(fields),
        else => {}, // TODO: We'll just ignore it for now
    }
}
