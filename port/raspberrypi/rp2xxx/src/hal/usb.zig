//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");
const assert = std.debug.assert;
const enumFromInt = std.meta.intToEnum;

const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;
const USB_DPRAM = microzig.chip.peripherals.USB_DPRAM;
const USB = microzig.chip.peripherals.USB;
const usb = microzig.core.usb;
const types = usb.types;

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const default = struct {
    pub const strings: usb.Config.DeviceStrings = .{
        .manufacturer = "Raspberry Pi",
        .product = "Pico Test Device",
        .serial = "00000000",
    };
    pub const vid: u16 = 0x2E8A;
    pub const pid: u16 = 0x000a;
    pub const bcd_usb = 0x02_00;
    pub const transfer_size = 64;
};

const EpNum = usb.types.Endpoint.Num;
const EpCtrl = @TypeOf(USB_DPRAM.EP1_IN_CONTROL);
const BufCtrl = @TypeOf(USB_DPRAM.EP0_IN_BUFFER_CONTROL);

const dpram_buffer_len = 64;
// `@volatileCast` is sound because the USB hardware only modifies the buffers
// after we transfer ownership by accesing a volatile register.
const dpram_buffers: *[4096 / dpram_buffer_len][dpram_buffer_len]u8 = @volatileCast(@ptrCast(USB_DPRAM));
// First 0x100 bytes are registers
const dpram_ep0buf_idx = 0x100 / dpram_buffer_len;

/// Keeps track of how many buffers have been allocated.
pub const DpramAllocatorBump = struct {
    top: u16,

    // First 2 buffers are for endpoint 0.
    const init: @This() = .{ .top = dpram_ep0buf_idx + 2 };

    /// Allocate a new buffer in dpram, `len` is in units of 64 bytes.
    fn alloc(this: *@This(), len: u16) error{OutOfBufferMemory}!u16 {
        const next, const ovf = @addWithOverflow(len, this.top);
        if (ovf != 0 or next > dpram_buffers.len)
            return error.OutOfBufferMemory;

        defer this.top = next;
        return this.top;
    }
};

pub const Config = struct {
    /// How many nops to insert for synchronization with the USB hardware.
    synchronization_nops: comptime_int = 3,
    /// USB controller configuration.
    controller_config: usb.Config,
};

pub fn Usb(comptime config: Config) type {
    return struct {
        pub const interface_vtable: usb.DeviceInterface.Vtable = .{
            .signal_rx_ready = &signal_rx_ready,
            .submit_tx_buffer = &submit_tx_buffer,
            .endpoint_open = &endpoint_open,
        };

        const max_endpoints_count = RP2XXX_MAX_ENDPOINTS_COUNT;

        pub const HardwareEndpoint = packed struct(u5) {
            const ep_ctrl_all: *volatile [2 * (max_endpoints_count - 1)]EpCtrl =
                @ptrCast(&USB_DPRAM.EP1_IN_CONTROL);

            const buf_ctrl_all: *volatile [2 * (max_endpoints_count)]BufCtrl =
                @ptrCast(&USB_DPRAM.EP0_IN_BUFFER_CONTROL);

            is_out: bool,
            num: EpNum,

            inline fn to_idx(this: @This()) u5 {
                return @bitCast(this);
            }

            fn in(num: EpNum) @This() {
                return .{ .num = num, .is_out = false };
            }

            fn out(num: EpNum) @This() {
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
                const buf: u16 = if (this.ep_ctrl()) |reg|
                    @divExact(reg.read().BUFFER_ADDRESS, dpram_buffer_len)
                else
                    dpram_ep0buf_idx;
                return &dpram_buffers[buf];
            }

            fn len(this: @This()) u16 {
                return this.buf_ctrl().read().LENGTH_0;
            }
        };

        const Controller = usb.Controller(blk: {
            var cfg = config.controller_config;
            cfg.strings = cfg.strings orelse default.strings;
            cfg.vid = cfg.vid orelse default.vid;
            cfg.pid = cfg.pid orelse default.pid;
            cfg.bcd_usb = cfg.bcd_usb orelse default.bcd_usb;
            cfg.max_transfer_size = cfg.max_transfer_size orelse default.transfer_size;
            break :blk cfg;
        });

        const State = union(enum) {
            sending: []const u8, // Slice of data left to be sent.
            no_buffer: ?u7, // Optionally a new address.
            ready: []u8, // Buffer for next transaction. Always empty if available.
            waiting_ack, // Host is expected to send an ACK.
        };

        state: State,
        dpram_allocator: DpramAllocatorBump,
        controller: Controller,

        pub fn interface(this: *@This()) usb.DeviceInterface {
            return .{
                .ptr = this,
                .vtable = &interface_vtable,
            };
        }

        /// Initialize USB hardware and request enumertation from USB host.
        pub fn init() @This() {
            if (chip == .RP2350)
                USB.MAIN_CTRL.modify(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            USB_DPRAM.SETUP_PACKET_LOW.write_raw(0);
            USB_DPRAM.SETUP_PACKET_HIGH.write_raw(0);

            for (HardwareEndpoint.ep_ctrl_all) |*ep_ctrl|
                ep_ctrl.write_raw(0);
            for (HardwareEndpoint.buf_ctrl_all) |*buf_ctrl|
                buf_ctrl.write_raw(0);

            // Mux the controller to the onboard USB PHY. I was surprised that there are
            // alternatives to this, but, there are.
            USB.USB_MUXING.modify(.{
                .TO_PHY = 1,
                // This bit is also set in the SDK example, without any discussion. It's
                // undocumented (being named does not count as being documented).
                .SOFTCON = 1,
            });

            // Force VBUS detect. Not all RP2040 boards wire up VBUS detect, which would
            // let us detect being plugged into a host (the Pi Pico, to its credit,
            // does). For maximum compatibility, we'll set the hardware to always
            // pretend VBUS has been detected.
            USB.USB_PWR.modify(.{
                .VBUS_DETECT = 1,
                .VBUS_DETECT_OVERRIDE_EN = 1,
            });

            // Enable controller in device mode.
            USB.MAIN_CTRL.modify(.{
                .CONTROLLER_EN = 1,
                .HOST_NDEVICE = 0,
            });

            // Request to have an interrupt (which really just means setting a bit in
            // the `buff_status` register) every time a buffer moves through EP0.
            USB.SIE_CTRL.modify(.{ .EP0_INT_1BUF = 1 });

            // Enable interrupts (bits set in the `ints` register) for other conditions
            // we use:
            USB.INTE.modify(.{
                // A buffer is done
                .BUFF_STATUS = 1,
                // The host has reset us
                .BUS_RESET = 1,
                // We've gotten a setup request on EP0
                .SETUP_REQ = 1,
            });

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            USB.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });

            return .{
                .state = .{ .ready = &dpram_buffers[dpram_ep0buf_idx] },
                .dpram_allocator = .init,
                .controller = .init,
            };
        }

        /// Helper function that breaks up long strings.
        fn ep0_send(this: *@This(), tx_buf: []u8, data: []const u8) void {
            const len = @min(tx_buf.len, data.len);
            if (len == 0)
                this.state = .{ .no_buffer = null }
            else {
                std.mem.copyForwards(u8, tx_buf, data[0..len]);
                this.state = .{ .sending = data[len..] };
            }
            this.interface().submit_tx_buffer(.ep0, tx_buf.ptr + len);
        }

        /// Called when a setup packet is received.
        fn process_setup(this: *@This(), tx_buf: []u8) void {
            // Copy the setup packet out of its dedicated buffer at the base of
            // USB SRAM. The PAC models this buffer as two 32-bit registers.
            const setup: usb.types.SetupPacket = @bitCast([2]u32{
                USB_DPRAM.SETUP_PACKET_LOW.raw,
                USB_DPRAM.SETUP_PACKET_HIGH.raw,
            });

            // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
            // to an IN on EP0 needs to use PID DATA1.
            USB_DPRAM.EP0_IN_BUFFER_CONTROL.modify(.{ .PID_0 = 0 });

            switch (setup.request_type.recipient) {
                .Device => blk: {
                    if (setup.request_type.type != .Standard) break :blk;
                    switch (enumFromInt(
                        usb.types.SetupRequest,
                        setup.request,
                    ) catch break :blk) {
                        .SetAddress => {
                            this.ep0_send(tx_buf, usb.ACK);
                            this.state = .{ .no_buffer = @intCast(setup.value) };
                        },
                        .SetConfiguration => if (this.controller.set_configuration(this.interface(), &setup))
                            this.ep0_send(tx_buf, usb.ACK),
                        .GetDescriptor => if (Controller.get_descriptor(&setup)) |desc|
                            this.ep0_send(tx_buf, desc),
                        .SetFeature => if (this.controller.set_feature(
                            @intCast(setup.value >> 8),
                            setup.index,
                            true,
                        )) this.ep0_send(tx_buf, usb.ACK),
                    }
                },
                .Interface => if (this.controller.interface_setup(&setup)) |data|
                    this.ep0_send(tx_buf, data),
                else => {},
            }
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        pub fn task(this: *@This()) void {
            const ints = USB.INTS.read();
            const SieStatus = @TypeOf(USB.SIE_STATUS).underlying_type;

            switch (this.state) {
                .ready => |tx_buf| if (ints.SETUP_REQ != 0) {
                    // Clear the status flag (write one to clear)
                    var sie_status: SieStatus = @bitCast(@as(u32, 0));
                    sie_status.SETUP_REC = 1;
                    USB.SIE_STATUS.write(sie_status);
                    this.process_setup(tx_buf);
                },
                else => {},
            }
            if (ints.BUFF_STATUS != 0) {
                const unhandled_initial = USB.BUFF_STATUS.raw;
                var unhandled_pending = unhandled_initial;

                while (std.math.cast(u5, @ctz(unhandled_pending))) |idx| {
                    unhandled_pending &= unhandled_pending -% 1; // Clear lowest bit.
                    const ep: HardwareEndpoint = .{
                        .num = @enumFromInt(idx >> 1),
                        .is_out = (idx & 1) == 1,
                    };
                    const buf = ep.buffer();

                    const result = if (ep.num == .ep0) blk: {
                        switch (this.state) {
                            .sending => |data| {
                                if (ep.is_out) break :blk error.UsbPacketUnhandled;
                                this.ep0_send(buf, data);

                                if (data.len == 0) {
                                    this.interface().signal_rx_ready(.ep0, 0);
                                    this.state = .waiting_ack;
                                }
                            },
                            .no_buffer => |new_address| {
                                if (ep.is_out) break :blk error.UsbPacketUnhandled;
                                // Finish the delayed SetAddress request, if there is one:
                                if (new_address) |addr|
                                    USB.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });

                                this.state = .{ .ready = buf };
                            },
                            .ready => |_| {
                                if (ep.is_out)
                                    std.log.err("Got buffer twice!", .{});
                                break :blk error.UsbPacketUnhandled;
                            },
                            .waiting_ack => {
                                if (ep.is_out) assert(ep.len() == 0);
                                this.state = .{ .ready = buf };
                            },
                        }
                    } else if (ep.is_out)
                        this.controller.on_data_rx(ep.num, buf[0..ep.len()])
                    else
                        this.controller.on_tx_ready(ep.num, buf);

                    result catch {
                        std.log.warn("unhandled usb packet: ep{}{s}", .{ ep.num, if (ep.is_out) "out" else "in" });
                        if (ep.is_out)
                            std.log.warn("{any}", .{buf[0..ep.len()]});
                    };
                }
                USB.BUFF_STATUS.write_raw(unhandled_initial);
            }

            if (ints.BUS_RESET != 0) {
                this.controller.deinit();
                this.controller = .init;
                this.dpram_allocator = .init;

                var sie_status: SieStatus = @bitCast(@as(u32, 0));
                sie_status.BUS_RESET = 1;
                USB.SIE_STATUS.write(sie_status);
                USB.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = 0 });
            }
        }

        /// See interface description.
        pub fn submit_tx_buffer(_: *anyopaque, ep_in: EpNum, buffer_end: [*]const u8) void {
            const ep_hard: HardwareEndpoint = .in(ep_in);
            const buf = ep_hard.buffer();

            // It is technically possible to support longer buffers but this demo doesn't bother.
            const len = buffer_end - buf.ptr;
            if (len > default.transfer_size)
                std.log.err("wrong buffer submitted", .{});

            // Write the buffer information to the buffer control register
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 1; // We have put data in
            rmw.LENGTH_0 = @intCast(len); // There are this many bytes

            // If the CPU is running at a higher clock speed than USB,
            // the AVAILABLE bit in the buffer control register should be set
            // separately to the rest of the data in the buffer control register,
            // so that the rest of the data in the buffer control register is
            // accurate when the AVAILABLE bit is set.

            if (config.synchronization_nops != 0) {
                buf_ctrl.write(rmw);
                asm volatile ("nop\n" ** config.synchronization_nops);
            }

            rmw.AVAILABLE_0 = 1;
            buf_ctrl.write(rmw);
        }

        /// See interface description.
        pub fn signal_rx_ready(_: *anyopaque, ep_out: EpNum, len: usize) void {
            const ep_hard: HardwareEndpoint = .out(ep_out);

            // Configure the OUT:
            const buf_ctrl = ep_hard.buf_ctrl();
            var rmw = buf_ctrl.read();

            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is empty
            rmw.AVAILABLE_0 = 1; // And ready to be filled
            rmw.LENGTH_0 = @intCast(@min(len, default.transfer_size));
            buf_ctrl.write(rmw);
        }

        /// See interface description.
        pub fn endpoint_open(ptr: *anyopaque, desc: *const usb.descriptor.Endpoint) ?[]u8 {
            const this: *@This() = @alignCast(@ptrCast(ptr));

            assert(@intFromEnum(desc.endpoint.num) < max_endpoints_count);

            const ep_hard: HardwareEndpoint = .{
                .num = desc.endpoint.num,
                .is_out = desc.endpoint.dir == .Out,
            };

            const start = if (desc.endpoint.num != .ep0) blk: {
                const buf = this.dpram_allocator.alloc(1) catch
                    std.debug.panic("USB controller out of memory.", .{});
                var ep_ctrl = ep_hard.ep_ctrl().?;
                var rmw = ep_ctrl.read();
                rmw.ENABLE = 1;
                rmw.INTERRUPT_PER_BUFF = 1;
                rmw.ENDPOINT_TYPE = @enumFromInt(desc.attributes.transfer_type.as_number());
                rmw.BUFFER_ADDRESS = buf * dpram_buffer_len;
                ep_ctrl.write(rmw);
                break :blk buf;
            } else dpram_ep0buf_idx;

            return &dpram_buffers[start];
        }
    };
}
