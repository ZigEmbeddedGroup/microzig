//! USB device implementation
//!
//! Inspired by cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

/// Human Interface Device (HID)
pub const usb = microzig.core.usb;
pub const hid = usb.hid;

const rom = @import("rom.zig");
const resets = @import("resets.zig");

pub const EP0_OUT_IDX = 0;
pub const EP0_IN_IDX = 1;

// +++++++++++++++++++++++++++++++++++++++++++++++++
// User Interface
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// The rp2040 usb device impl
///
/// We create a concrete implementaion by passing a handful
/// of system specific functions to Usb(). Those functions
/// are used by the abstract USB impl of microzig.
pub const Usb = usb.Usb(F);

pub const DeviceConfiguration = usb.DeviceConfiguration;
pub const DeviceDescriptor = usb.DeviceDescriptor;
pub const DescType = usb.DescType;
pub const InterfaceDescriptor = usb.InterfaceDescriptor;
pub const ConfigurationDescriptor = usb.ConfigurationDescriptor;
pub const EndpointDescriptor = usb.EndpointDescriptor;
pub const EndpointConfiguration = usb.EndpointConfiguration;
pub const Dir = usb.Dir;
pub const TransferType = usb.TransferType;

pub const utf8ToUtf16Le = usb.utf8Toutf16Le;

pub var EP0_OUT_CFG: usb.EndpointConfiguration = .{
    .descriptor = &usb.EndpointDescriptor{
        .length = @intCast(u8, @sizeOf(usb.EndpointDescriptor)),
        .descriptor_type = usb.DescType.Endpoint,
        .endpoint_address = usb.EP0_OUT_ADDR,
        .attributes = @enumToInt(usb.TransferType.Control),
        .max_packet_size = 64,
        .interval = 0,
    },
    .endpoint_control_index = null,
    .buffer_control_index = 1,
    .data_buffer_index = 0,
    .next_pid_1 = false,
};

pub var EP0_IN_CFG: usb.EndpointConfiguration = .{
    .descriptor = &usb.EndpointDescriptor{
        .length = @intCast(u8, @sizeOf(usb.EndpointDescriptor)),
        .descriptor_type = usb.DescType.Endpoint,
        .endpoint_address = usb.EP0_IN_ADDR,
        .attributes = @enumToInt(usb.TransferType.Control),
        .max_packet_size = 64,
        .interval = 0,
    },
    .endpoint_control_index = null,
    .buffer_control_index = 0,
    .data_buffer_index = 0,
    .next_pid_1 = false,
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
        .ep0_buffer0 = @intToPtr([*]u8, USB_EP0_BUFFER0),
        .ep0_buffer1 = @intToPtr([*]u8, USB_EP0_BUFFER1),
        // We will initialize this comptime in a loop
        .rest = .{
            @intToPtr([*]u8, USB_BUFFERS + (0 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (1 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (2 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (3 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (4 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (5 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (6 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (7 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (8 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (9 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (10 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (11 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (12 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (13 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (14 * BUFFER_SIZE)),
            @intToPtr([*]u8, USB_BUFFERS + (15 * BUFFER_SIZE)),
        },
    };
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// A set of functions required by the abstract USB impl to
/// create a concrete one.
pub const F = struct {
    /// Initialize the USB clock to 48 MHz
    ///
    /// This requres that the system clock has been set up before hand
    /// using the 12 MHz crystal.
    pub fn usb_init_clk() void {
        // Bring PLL_USB up to 48MHz. PLL_USB is clocked from refclk, which we've
        // already moved over to the 12MHz XOSC. We just need to make it x4 that
        // clock.
        //
        // PLL_USB out of reset
        resets.reset(.{ .pll_usb = true });
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

    pub fn usb_init_device(device_config: *usb.DeviceConfiguration) void {
        // Bring USB out of reset
        resets.reset(.{ .usbctrl = true });

        // Clear the control portion of DPRAM. This may not be necessary -- the
        // datasheet is ambiguous -- but the C examples do it, and so do we.
        peripherals.USBCTRL_DPRAM.SETUP_PACKET_LOW.write_raw(0);
        peripherals.USBCTRL_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

        peripherals.USBCTRL_DPRAM.EP1_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP1_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP2_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP2_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP3_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP3_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP4_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP4_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP5_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP5_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP6_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP6_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP7_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP7_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP8_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP8_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP9_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP9_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP10_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP10_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP11_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP11_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP12_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP12_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP13_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP13_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP14_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP14_OUT_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP15_IN_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP15_OUT_CONTROL.write_raw(0);

        peripherals.USBCTRL_DPRAM.EP0_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP0_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP1_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP1_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP2_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP2_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP3_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP3_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP4_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP4_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP5_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP5_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP6_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP6_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP7_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP7_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP8_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP8_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP9_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP9_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP10_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP10_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP11_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP11_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP12_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP12_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP13_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP13_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP14_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP14_OUT_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP15_IN_BUFFER_CONTROL.write_raw(0);
        peripherals.USBCTRL_DPRAM.EP15_OUT_BUFFER_CONTROL.write_raw(0);

        // Mux the controller to the onboard USB PHY. I was surprised that there are
        // alternatives to this, but, there are.
        peripherals.USBCTRL_REGS.USB_MUXING.modify(.{
            .TO_PHY = 1,
            // This bit is also set in the SDK example, without any discussion. It's
            // undocumented (being named does not count as being documented).
            .SOFTCON = 1,
        });

        // Force VBUS detect. Not all RP2040 boards wire up VBUS detect, which would
        // let us detect being plugged into a host (the Pi Pico, to its credit,
        // does). For maximum compatibility, we'll set the hardware to always
        // pretend VBUS has been detected.
        peripherals.USBCTRL_REGS.USB_PWR.modify(.{
            .VBUS_DETECT = 1,
            .VBUS_DETECT_OVERRIDE_EN = 1,
        });

        // Enable controller in device mode.
        peripherals.USBCTRL_REGS.MAIN_CTRL.modify(.{
            .CONTROLLER_EN = 1,
            .HOST_NDEVICE = 0,
        });

        // Request to have an interrupt (which really just means setting a bit in
        // the `buff_status` register) every time a buffer moves through EP0.
        peripherals.USBCTRL_REGS.SIE_CTRL.modify(.{
            .EP0_INT_1BUF = 1,
        });

        // Enable interrupts (bits set in the `ints` register) for other conditions
        // we use:
        peripherals.USBCTRL_REGS.INTE.modify(.{
            // A buffer is done
            .BUFF_STATUS = 1,
            // The host has reset us
            .BUS_RESET = 1,
            // We've gotten a setup request on EP0
            .SETUP_REQ = 1,
        });

        // setup endpoints
        for (device_config.endpoints) |ep| {
            // EP0 doesn't have an endpoint control index; only process the other
            // endpoints here.
            if (ep.endpoint_control_index) |epci| {
                // We need to compute the offset from the base of USB SRAM to the
                // buffer we're choosing, because that's how the peripheral do.
                const buf_base = @ptrToInt(buffers.B.get(ep.data_buffer_index));
                const dpram_base = @ptrToInt(peripherals.USBCTRL_DPRAM);
                // The offset _should_ fit in a u16, but if we've gotten something
                // wrong in the past few lines, a common symptom will be integer
                // overflow producing a Very Large Number,
                const dpram_offset = @intCast(u16, buf_base - dpram_base);

                // Configure the endpoint!
                modify_endpoint_control(epci, .{
                    .ENABLE = 1,
                    // Please set the corresponding bit in buff_status when a
                    // buffer is done, thx.
                    .INTERRUPT_PER_BUFF = 1,
                    // Select bulk vs control (or interrupt as soon as implemented).
                    .ENDPOINT_TYPE = .{ .raw = @intCast(u2, ep.descriptor.attributes) },
                    // And, designate our buffer by its offset.
                    .BUFFER_ADDRESS = dpram_offset,
                });
            }
        }

        // Present full-speed device by enabling pullup on DP. This is the point
        // where the host will notice our presence.
        peripherals.USBCTRL_REGS.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
    }

    /// Configures a given endpoint to send data (device-to-host, IN) when the host
    /// next asks for it.
    ///
    /// The contents of `buffer` will be _copied_ into USB SRAM, so you can
    /// reuse `buffer` immediately after this returns. No need to wait for the
    /// packet to be sent.
    pub fn usb_start_tx(
        ep: *usb.EndpointConfiguration,
        buffer: []const u8,
    ) void {
        // It is technically possible to support longer buffers but this demo
        // doesn't bother.
        // TODO: assert!(buffer.len() <= 64);
        // You should only be calling this on IN endpoints.
        // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::In);

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
            .LENGTH_0 = @intCast(u10, buffer.len), // There are this many bytes
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
        ep: *usb.EndpointConfiguration,
        len: usize,
    ) void {
        // It is technically possible to support longer buffers but this demo
        // doesn't bother.
        // TODO: assert!(len <= 64);
        // You should only be calling this on OUT endpoints.
        // TODO: assert!(UsbDir::of_endpoint_addr(ep.descriptor.endpoint_address) == UsbDir::Out);

        // Check which DATA0/1 PID this endpoint is expecting next.
        const np: u1 = if (ep.next_pid_1) 1 else 0;
        // Configure the OUT:
        modify_buffer_control(ep.buffer_control_index, .{
            .PID_0 = np, // DATA0/1 depending
            .FULL_0 = 0, // Buffer is NOT full, we want the computer to fill it
            .AVAILABLE_0 = 1, // It is, however, available to be filled
            .LENGTH_0 = @intCast(u10, len), // Up tho this many bytes
        });

        // Flip the DATA0/1 PID for the next receive
        ep.next_pid_1 = !ep.next_pid_1;
    }

    /// Check which interrupt flags are set
    pub fn get_interrupts() usb.InterruptStatus {
        const ints = peripherals.USBCTRL_REGS.INTS.read();

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
    pub fn get_setup_packet() usb.SetupPacket {
        // Clear the status flag (write-one-to-clear)
        peripherals.USBCTRL_REGS.SIE_STATUS.modify(.{ .SETUP_REC = 1 });

        // This assumes that the setup packet is arriving on EP0, our
        // control endpoint. Which it should be. We don't have any other
        // Control endpoints.

        // Copy the setup packet out of its dedicated buffer at the base of
        // USB SRAM. The PAC models this buffer as two 32-bit registers,
        // which is, like, not _wrong_ but slightly awkward since it means
        // we can't just treat it as bytes. Instead, copy it out to a byte
        // array.
        var setup_packet: [8]u8 = .{0} ** 8;
        const spl: u32 = peripherals.USBCTRL_DPRAM.SETUP_PACKET_LOW.raw;
        const sph: u32 = peripherals.USBCTRL_DPRAM.SETUP_PACKET_HIGH.raw;
        _ = rom.memcpy(setup_packet[0..4], std.mem.asBytes(&spl));
        _ = rom.memcpy(setup_packet[4..8], std.mem.asBytes(&sph));
        // Reinterpret as setup packet
        return std.mem.bytesToValue(usb.SetupPacket, &setup_packet);
    }

    /// Called on a bus reset interrupt
    pub fn bus_reset() void {
        // Acknowledge by writing the write-one-to-clear status bit.
        peripherals.USBCTRL_REGS.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
        peripherals.USBCTRL_REGS.ADDR_ENDP.modify(.{ .ADDRESS = 0 });
    }

    pub fn set_address(addr: u7) void {
        peripherals.USBCTRL_REGS.ADDR_ENDP.modify(.{ .ADDRESS = addr });
    }

    pub fn get_EPBIter(dc: *const usb.DeviceConfiguration) usb.EPBIter {
        return .{
            .bufbits = peripherals.USBCTRL_REGS.BUFF_STATUS.raw,
            .device_config = dc,
            .next = next,
        };
    }
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Utility functions
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// Check if the corresponding buffer is available
pub fn buffer_available(
    ep: *usb.EndpointConfiguration,
) bool {
    const rbc = read_raw_buffer_control(ep.buffer_control_index);
    // Bit 11 of the EPn_X_BUFFER_CONTROL register represents the AVAILABLE_0 flag
    return ((rbc & 0x400) == 0);
}

pub fn modify_buffer_control(
    i: usize,
    fields: anytype,
) void {
    // haven't found a better way to handle this
    switch (i) {
        0 => peripherals.USBCTRL_DPRAM.EP0_IN_BUFFER_CONTROL.modify(fields),
        1 => peripherals.USBCTRL_DPRAM.EP0_OUT_BUFFER_CONTROL.modify(fields),
        2 => peripherals.USBCTRL_DPRAM.EP1_IN_BUFFER_CONTROL.modify(fields),
        3 => peripherals.USBCTRL_DPRAM.EP1_OUT_BUFFER_CONTROL.modify(fields),
        4 => peripherals.USBCTRL_DPRAM.EP2_IN_BUFFER_CONTROL.modify(fields),
        5 => peripherals.USBCTRL_DPRAM.EP2_OUT_BUFFER_CONTROL.modify(fields),
        6 => peripherals.USBCTRL_DPRAM.EP3_IN_BUFFER_CONTROL.modify(fields),
        7 => peripherals.USBCTRL_DPRAM.EP3_OUT_BUFFER_CONTROL.modify(fields),
        8 => peripherals.USBCTRL_DPRAM.EP4_IN_BUFFER_CONTROL.modify(fields),
        9 => peripherals.USBCTRL_DPRAM.EP4_OUT_BUFFER_CONTROL.modify(fields),
        10 => peripherals.USBCTRL_DPRAM.EP5_IN_BUFFER_CONTROL.modify(fields),
        11 => peripherals.USBCTRL_DPRAM.EP5_OUT_BUFFER_CONTROL.modify(fields),
        12 => peripherals.USBCTRL_DPRAM.EP6_IN_BUFFER_CONTROL.modify(fields),
        13 => peripherals.USBCTRL_DPRAM.EP6_OUT_BUFFER_CONTROL.modify(fields),
        14 => peripherals.USBCTRL_DPRAM.EP7_IN_BUFFER_CONTROL.modify(fields),
        15 => peripherals.USBCTRL_DPRAM.EP7_OUT_BUFFER_CONTROL.modify(fields),
        16 => peripherals.USBCTRL_DPRAM.EP8_IN_BUFFER_CONTROL.modify(fields),
        17 => peripherals.USBCTRL_DPRAM.EP8_OUT_BUFFER_CONTROL.modify(fields),
        18 => peripherals.USBCTRL_DPRAM.EP9_IN_BUFFER_CONTROL.modify(fields),
        19 => peripherals.USBCTRL_DPRAM.EP9_OUT_BUFFER_CONTROL.modify(fields),
        20 => peripherals.USBCTRL_DPRAM.EP10_IN_BUFFER_CONTROL.modify(fields),
        21 => peripherals.USBCTRL_DPRAM.EP10_OUT_BUFFER_CONTROL.modify(fields),
        22 => peripherals.USBCTRL_DPRAM.EP11_IN_BUFFER_CONTROL.modify(fields),
        23 => peripherals.USBCTRL_DPRAM.EP11_OUT_BUFFER_CONTROL.modify(fields),
        24 => peripherals.USBCTRL_DPRAM.EP12_IN_BUFFER_CONTROL.modify(fields),
        25 => peripherals.USBCTRL_DPRAM.EP12_OUT_BUFFER_CONTROL.modify(fields),
        26 => peripherals.USBCTRL_DPRAM.EP13_IN_BUFFER_CONTROL.modify(fields),
        27 => peripherals.USBCTRL_DPRAM.EP13_OUT_BUFFER_CONTROL.modify(fields),
        28 => peripherals.USBCTRL_DPRAM.EP14_IN_BUFFER_CONTROL.modify(fields),
        29 => peripherals.USBCTRL_DPRAM.EP14_OUT_BUFFER_CONTROL.modify(fields),
        30 => peripherals.USBCTRL_DPRAM.EP15_IN_BUFFER_CONTROL.modify(fields),
        31 => peripherals.USBCTRL_DPRAM.EP15_OUT_BUFFER_CONTROL.modify(fields),
        else => {}, // TODO: We'll just ignore it for now
    }
}

pub fn read_raw_buffer_control(
    i: usize,
) u32 {
    // haven't found a better way to handle this
    return switch (i) {
        0 => peripherals.USBCTRL_DPRAM.EP0_IN_BUFFER_CONTROL.raw,
        1 => peripherals.USBCTRL_DPRAM.EP0_OUT_BUFFER_CONTROL.raw,
        2 => peripherals.USBCTRL_DPRAM.EP1_IN_BUFFER_CONTROL.raw,
        3 => peripherals.USBCTRL_DPRAM.EP1_OUT_BUFFER_CONTROL.raw,
        4 => peripherals.USBCTRL_DPRAM.EP2_IN_BUFFER_CONTROL.raw,
        5 => peripherals.USBCTRL_DPRAM.EP2_OUT_BUFFER_CONTROL.raw,
        6 => peripherals.USBCTRL_DPRAM.EP3_IN_BUFFER_CONTROL.raw,
        7 => peripherals.USBCTRL_DPRAM.EP3_OUT_BUFFER_CONTROL.raw,
        8 => peripherals.USBCTRL_DPRAM.EP4_IN_BUFFER_CONTROL.raw,
        9 => peripherals.USBCTRL_DPRAM.EP4_OUT_BUFFER_CONTROL.raw,
        10 => peripherals.USBCTRL_DPRAM.EP5_IN_BUFFER_CONTROL.raw,
        11 => peripherals.USBCTRL_DPRAM.EP5_OUT_BUFFER_CONTROL.raw,
        12 => peripherals.USBCTRL_DPRAM.EP6_IN_BUFFER_CONTROL.raw,
        13 => peripherals.USBCTRL_DPRAM.EP6_OUT_BUFFER_CONTROL.raw,
        14 => peripherals.USBCTRL_DPRAM.EP7_IN_BUFFER_CONTROL.raw,
        15 => peripherals.USBCTRL_DPRAM.EP7_OUT_BUFFER_CONTROL.raw,
        16 => peripherals.USBCTRL_DPRAM.EP8_IN_BUFFER_CONTROL.raw,
        17 => peripherals.USBCTRL_DPRAM.EP8_OUT_BUFFER_CONTROL.raw,
        18 => peripherals.USBCTRL_DPRAM.EP9_IN_BUFFER_CONTROL.raw,
        19 => peripherals.USBCTRL_DPRAM.EP9_OUT_BUFFER_CONTROL.raw,
        20 => peripherals.USBCTRL_DPRAM.EP10_IN_BUFFER_CONTROL.raw,
        21 => peripherals.USBCTRL_DPRAM.EP10_OUT_BUFFER_CONTROL.raw,
        22 => peripherals.USBCTRL_DPRAM.EP11_IN_BUFFER_CONTROL.raw,
        23 => peripherals.USBCTRL_DPRAM.EP11_OUT_BUFFER_CONTROL.raw,
        24 => peripherals.USBCTRL_DPRAM.EP12_IN_BUFFER_CONTROL.raw,
        25 => peripherals.USBCTRL_DPRAM.EP12_OUT_BUFFER_CONTROL.raw,
        26 => peripherals.USBCTRL_DPRAM.EP13_IN_BUFFER_CONTROL.raw,
        27 => peripherals.USBCTRL_DPRAM.EP13_OUT_BUFFER_CONTROL.raw,
        28 => peripherals.USBCTRL_DPRAM.EP14_IN_BUFFER_CONTROL.raw,
        29 => peripherals.USBCTRL_DPRAM.EP14_OUT_BUFFER_CONTROL.raw,
        30 => peripherals.USBCTRL_DPRAM.EP15_IN_BUFFER_CONTROL.raw,
        31 => peripherals.USBCTRL_DPRAM.EP15_OUT_BUFFER_CONTROL.raw,
        else => 0, // TODO: We'll just return 0 for now
    };
}

pub fn modify_endpoint_control(
    epci: usize,
    fields: anytype,
) void {
    // haven't found a better way to handle this
    switch (epci) {
        1 => peripherals.USBCTRL_DPRAM.EP1_IN_CONTROL.modify(fields),
        2 => peripherals.USBCTRL_DPRAM.EP1_OUT_CONTROL.modify(fields),
        3 => peripherals.USBCTRL_DPRAM.EP2_IN_CONTROL.modify(fields),
        4 => peripherals.USBCTRL_DPRAM.EP2_OUT_CONTROL.modify(fields),
        5 => peripherals.USBCTRL_DPRAM.EP3_IN_CONTROL.modify(fields),
        6 => peripherals.USBCTRL_DPRAM.EP3_OUT_CONTROL.modify(fields),
        7 => peripherals.USBCTRL_DPRAM.EP4_IN_CONTROL.modify(fields),
        8 => peripherals.USBCTRL_DPRAM.EP4_OUT_CONTROL.modify(fields),
        9 => peripherals.USBCTRL_DPRAM.EP5_IN_CONTROL.modify(fields),
        10 => peripherals.USBCTRL_DPRAM.EP5_OUT_CONTROL.modify(fields),
        11 => peripherals.USBCTRL_DPRAM.EP6_IN_CONTROL.modify(fields),
        12 => peripherals.USBCTRL_DPRAM.EP6_OUT_CONTROL.modify(fields),
        13 => peripherals.USBCTRL_DPRAM.EP7_IN_CONTROL.modify(fields),
        14 => peripherals.USBCTRL_DPRAM.EP7_OUT_CONTROL.modify(fields),
        15 => peripherals.USBCTRL_DPRAM.EP8_IN_CONTROL.modify(fields),
        16 => peripherals.USBCTRL_DPRAM.EP8_OUT_CONTROL.modify(fields),
        17 => peripherals.USBCTRL_DPRAM.EP9_IN_CONTROL.modify(fields),
        18 => peripherals.USBCTRL_DPRAM.EP9_OUT_CONTROL.modify(fields),
        19 => peripherals.USBCTRL_DPRAM.EP10_IN_CONTROL.modify(fields),
        20 => peripherals.USBCTRL_DPRAM.EP10_OUT_CONTROL.modify(fields),
        21 => peripherals.USBCTRL_DPRAM.EP11_IN_CONTROL.modify(fields),
        22 => peripherals.USBCTRL_DPRAM.EP11_OUT_CONTROL.modify(fields),
        23 => peripherals.USBCTRL_DPRAM.EP12_IN_CONTROL.modify(fields),
        24 => peripherals.USBCTRL_DPRAM.EP12_OUT_CONTROL.modify(fields),
        25 => peripherals.USBCTRL_DPRAM.EP13_IN_CONTROL.modify(fields),
        26 => peripherals.USBCTRL_DPRAM.EP13_OUT_CONTROL.modify(fields),
        27 => peripherals.USBCTRL_DPRAM.EP14_IN_CONTROL.modify(fields),
        28 => peripherals.USBCTRL_DPRAM.EP14_OUT_CONTROL.modify(fields),
        29 => peripherals.USBCTRL_DPRAM.EP15_IN_CONTROL.modify(fields),
        30 => peripherals.USBCTRL_DPRAM.EP15_OUT_CONTROL.modify(fields),
        else => {}, // TODO: We'll just ignore it for now
    }
}

// -----------------------------------------------------------

pub fn next(self: *usb.EPBIter) ?usb.EPB {
    if (self.last_bit) |lb| {
        // Acknowledge the last handled buffer
        peripherals.USBCTRL_REGS.BUFF_STATUS.write_raw(lb);
        self.last_bit = null;
    }
    // All input buffers handled?
    if (self.bufbits == 0) return null;

    // Who's still outstanding? Find their bit index by counting how
    // many LSBs are zero.
    var lowbit_index: u5 = 0;
    while ((self.bufbits >> lowbit_index) & 0x01 == 0) : (lowbit_index += 1) {}
    // Remove their bit from our set.
    const lowbit = @intCast(u32, 1) << lowbit_index;
    self.last_bit = lowbit;
    self.bufbits ^= lowbit;

    // Here we exploit knowledge of the ordering of buffer control
    // registers in the peripheral. Each endpoint has a pair of
    // registers, so we can determine the endpoint number by:
    const epnum = @intCast(u8, lowbit_index >> 1);
    // Of the pair, the IN endpoint comes first, followed by OUT, so
    // we can get the direction by:
    const dir = if (lowbit_index & 1 == 0) usb.Dir.In else usb.Dir.Out;

    const ep_addr = dir.endpoint(epnum);
    // Process the buffer-done event.

    // Process the buffer-done event.
    //
    // Scan the device table to figure out which endpoint struct
    // corresponds to this address. We could use a smarter
    // method here, but in practice, the number of endpoints is
    // small so a linear scan doesn't kill us.
    var endpoint: ?*usb.EndpointConfiguration = null;
    for (self.device_config.endpoints) |ep| {
        if (ep.descriptor.endpoint_address == ep_addr) {
            endpoint = ep;
            break;
        }
    }
    // Buffer event for unknown EP?!
    // TODO: if (endpoint == null) return EPBError.UnknownEndpoint;
    // Read the buffer control register to check status.
    const bc = read_raw_buffer_control(endpoint.?.buffer_control_index);

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
    const epbuffer = buffers.B.get(endpoint.?.data_buffer_index);

    // Get the actual length of the data, which may be less
    // than the buffer size.
    const len = @intCast(usize, bc & 0x3ff);

    // Copy the data from SRAM
    return usb.EPB{
        .endpoint = endpoint.?,
        .buffer = epbuffer[0..len],
    };
}
