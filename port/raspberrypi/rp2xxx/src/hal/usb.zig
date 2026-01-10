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
const types = usb.types;
const EpNum = types.Endpoint.Num;

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const Config = struct {
    // Comptime defined supported max endpoints number, can be reduced to save RAM space
    max_endpoints_count: comptime_int = RP2XXX_MAX_ENDPOINTS_COUNT,
    max_interfaces_count: comptime_int = 16,
    sync_noops: comptime_int = 3,
};

const HardwareEndpointData = struct {
    awaiting_rx: bool,
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

        fn get(self: *volatile @This(), dir: types.Dir) *volatile T {
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
pub fn Polled(
    controller_config: usb.Config,
    config: Config,
) type {
    comptime {
        if (config.max_endpoints_count > RP2XXX_MAX_ENDPOINTS_COUNT)
            @compileError("RP2XXX USB endpoints number can't be grater than RP2XXX_MAX_ENDPOINTS_COUNT");
    }

    return struct {
        const vtable: usb.DeviceInterface.VTable = .{
            .start_tx = start_tx,
            .start_rx = start_rx,
            .set_address = set_address,
            .endpoint_open = endpoint_open,
        };

        endpoints: [config.max_endpoints_count][2]HardwareEndpointData,
        data_buffer: []align(64) u8,
        controller: usb.DeviceController(controller_config),
        interface: usb.DeviceInterface,

        pub fn poll(self: *@This()) void {
            // Check which interrupt flags are set.

            const ints = peripherals.USB.INTS.read();

            // Setup request received?
            if (ints.SETUP_REQ != 0) {
                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                buffer_control[0].in.modify(.{ .PID_0 = 0 });

                const setup = get_setup_packet();
                self.controller.on_setup_req(&self.interface, &setup);
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

                    const ep_hard = self.hardware_endpoint_get_by_address(ep);

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
                    const len = buffer_control[@intFromEnum(ep.num)].get(ep.dir).read().LENGTH_0;

                    self.controller.on_buffer(&self.interface, ep, ep_hard.data_buffer[0..len]);

                    if (ep.dir == .Out)
                        ep_hard.awaiting_rx = false;
                }

                peripherals.USB.BUFF_STATUS.write_raw(bufbits_init);
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BUS_RESET != 0) {
                // Acknowledge by writing the write-one-to-clear status bit.
                peripherals.USB.SIE_STATUS.modify(.{ .BUS_RESET = 1 });
                peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = 0 });

                self.controller.on_bus_reset();
            }
        }

        pub fn init() @This() {
            if (chip == .RP2350) {
                peripherals.USB.MAIN_CTRL.modify(.{
                    .PHY_ISO = 0,
                });
            }

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
                .controller = .init,
            };

            @memset(std.mem.asBytes(&self.endpoints), 0);
            endpoint_open(&self.interface, &.{
                .endpoint = .in(.ep0),
                .max_packet_size = .from(64),
                .attributes = .{ .transfer_type = .Control, .usage = .data },
                .interval = 0,
            });
            endpoint_open(&self.interface, &.{
                .endpoint = .out(.ep0),
                .max_packet_size = .from(64),
                .attributes = .{ .transfer_type = .Control, .usage = .data },
                .interval = 0,
            });

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peripherals.USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });

            return self;
        }

        /// Configures a given IN endpoint to send data when the host next asks for it.
        ///
        /// The contents of `buffer` will be _copied_ into USB SRAM, so you can
        /// reuse `buffer` immediately after this returns. No need to wait for the
        /// packet to be sent.
        fn start_tx(
            itf: *usb.DeviceInterface,
            ep_num: EpNum,
            buffer: []const u8,
        ) void {
            const self: *@This() = @fieldParentPtr("interface", itf);

            // It is technically possible to support longer buffers but this demo
            // doesn't bother.
            assert(buffer.len <= 64);

            const bufctrl_ptr = &buffer_control[@intFromEnum(ep_num)].in;
            const ep = self.hardware_endpoint_get_by_address(.in(ep_num));
            // Wait for controller to give processor ownership of the buffer before writing it.
            // This is technically not neccessary, but the usb cdc driver is bugged.
            while (bufctrl_ptr.read().AVAILABLE_0 == 1) {}

            const len = buffer.len;
            switch (chip) {
                .RP2040 => @memcpy(ep.data_buffer[0..len], buffer[0..len]),
                .RP2350 => {
                    const dst: [*]align(4) u32 = @ptrCast(ep.data_buffer.ptr);
                    const src: [*]align(1) const u32 = @ptrCast(buffer.ptr);
                    for (0..len / 4) |i|
                        dst[i] = src[i];
                    for (0..len % 4) |i|
                        ep.data_buffer[len - i - 1] = buffer[len - i - 1];
                },
            }

            var bufctrl = bufctrl_ptr.read();

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
        }

        fn start_rx(itf: *usb.DeviceInterface, ep_num: EpNum, len: usize) void {
            const self: *@This() = @fieldParentPtr("interface", itf);

            // It is technically possible to support longer buffers but this demo doesn't bother.
            assert(len <= 64);

            const bufctrl_ptr = &buffer_control[@intFromEnum(ep_num)].out;
            const ep = self.hardware_endpoint_get_by_address(.out(ep_num));

            // This function should only be called when the buffer is known to be available,
            // but the current driver implementations do not conform to that.
            if (ep.awaiting_rx) return;

            // Configure the OUT:
            var bufctrl = bufctrl_ptr.read();
            bufctrl.PID_0 ^= 1; // Flip DATA0/1
            bufctrl.FULL_0 = 0; // Buffer is NOT full, we want the computer to fill it
            bufctrl.LENGTH_0 = @intCast(len); // Up tho this many bytes

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
            const self: *@This() = @fieldParentPtr("interface", itf);
            _ = self;

            peripherals.USB.ADDR_ENDP.modify(.{ .ADDRESS = addr });
        }

        fn hardware_endpoint_get_by_address(self: *@This(), ep: types.Endpoint) *HardwareEndpointData {
            return &self.endpoints[@intFromEnum(ep.num)][@intFromEnum(ep.dir)];
        }

        fn endpoint_open(itf: *usb.DeviceInterface, desc: *const usb.descriptor.Endpoint) void {
            const self: *@This() = @fieldParentPtr("interface", itf);

            assert(@intFromEnum(desc.endpoint.num) <= config.max_endpoints_count);

            const ep = desc.endpoint;
            const ep_hard = self.hardware_endpoint_get_by_address(ep);

            assert(desc.max_packet_size.into() <= 64);
            ep_hard.awaiting_rx = false;

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
