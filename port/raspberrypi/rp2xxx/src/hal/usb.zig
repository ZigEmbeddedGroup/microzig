//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");
const assert = std.debug.assert;
const enumFromInt = std.meta.intToEnum;

const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;
const peri_dpram = microzig.chip.peripherals.USB_DPRAM;
const peri_usb = microzig.chip.peripherals.USB;
const usb = microzig.core.usb;

const resets = @import("resets.zig");

pub const RP2XXX_MAX_ENDPOINTS_COUNT = 16;

pub const Config = struct {
    synchronization_nops: comptime_int = 3,
    dpram_allocator: type = DpramAllocatorBump,
    Controller: type,
    // swap_dpdm: bool = false,
};

pub const default = struct {
    pub const strings: usb.Strings = .{
        .manufacturer = "Raspberry Pi",
        .product = "Pico Test Device",
        .serial = "someserial",
    };
    pub const vid: u16 = 0x2E8A;
    pub const pid: u16 = 0x000a;
    pub const transfer_size = 64;
};

const Endpoint = usb.types.Endpoint;
const EpCtrl = @TypeOf(peri_dpram.EP1_IN_CONTROL);
const BufCtrl = @TypeOf(peri_dpram.EP0_IN_BUFFER_CONTROL);

const dpram_size = 4096;
pub const DpramBuffer = struct {
    const chunk_len = 1 << Index.ignored_lsbs;
    const start_align = chunk_len;

    const Chunk = struct { data: [chunk_len]u8 align(start_align) = undefined };

    const memory_raw: *[dpram_size / chunk_len]Chunk =
        @alignCast(@volatileCast(@ptrCast(peri_dpram)));

    pub const Len =
        std.meta.Int(.unsigned, std.math.log2_int_ceil(u16, dpram_size));

    pub const Index = enum(Len) {
        const ignored_lsbs = 6;

        invalid = 0,
        ep0buf0 = (0x100 >> ignored_lsbs),
        ep0buf1,
        data_start,
        _,

        fn from_reg(reg: EpCtrl.underlying_type) @This() {
            return @enumFromInt(@shrExact(reg.BUFFER_ADDRESS, ignored_lsbs));
        }

        fn to_u16(this: @This()) u16 {
            return @as(u16, @intFromEnum(this)) << ignored_lsbs;
        }

        fn start(this: @This()) [*]align(start_align) u8 {
            return @ptrCast(&memory_raw[@intFromEnum(this)]);
        }
    };
};

pub const DpramAllocatorBump = struct {
    // First 0x100 bytes contain control registers and first 2 buffers are for endpoint 0.
    var top: DpramBuffer.Index = .data_start;

    fn alloc(len: DpramBuffer.Len) error{OutOfBufferMemory}!DpramBuffer.Index {
        if (top == .invalid) return error.OutOfBufferMemory;

        const next, const ovf = @addWithOverflow(len, @intFromEnum(top));
        if (ovf != 0 and next != 0)
            return error.OutOfBufferMemory;

        const ret: DpramBuffer.Index = @enumFromInt(next);
        defer top = ret;
        return ret;
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
pub fn Usb(comptime config: Config) type {
    return struct {
        pub const interface_vtable: usb.DeviceInterface.Vtable = .{
            .task = &task,
            .control_transfer = &control_transfer,
            .signal_rx_ready = &signal_rx_ready,
            .submit_tx_buffer = &submit_tx_buffer,
            .endpoint_open = &endpoint_open,
        };

        pub const max_endpoints_count = RP2XXX_MAX_ENDPOINTS_COUNT;
        pub const bcd_usb = 0x02_00;
        pub const id = config.id;

        pub const HardwareEndpoint = packed struct(u5) {
            const ep_ctrl_all: *volatile [2 * (max_endpoints_count - 1)]EpCtrl =
                @ptrCast(&peri_dpram.EP1_IN_CONTROL);

            const buf_ctrl_all: *volatile [2 * (max_endpoints_count)]BufCtrl =
                @ptrCast(&peri_dpram.EP0_IN_BUFFER_CONTROL);

            is_out: bool,
            num: Endpoint.Num,

            inline fn to_idx(this: @This()) u5 {
                return @bitCast(this);
            }

            fn in(num: Endpoint.Num) @This() {
                return .{ .num = num, .is_out = false };
            }

            fn out(num: Endpoint.Num) @This() {
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
                const buf: DpramBuffer.Index = if (this.ep_ctrl()) |reg|
                    .from_reg(reg.read())
                else
                    .ep0buf0;
                return buf.start()[0..DpramBuffer.chunk_len];
            }

            fn len(this: @This()) u16 {
                return this.buf_ctrl().read().LENGTH_0;
            }
        };

        const State = union(enum) {
            sending: []const u8, // Slice of data left to be sent.
            no_buffer: ?u7, // Optionally a new address.
            ready: []u8, // Buffer for next transaction. Always empty if available.
            waiting_ack, // Host is expected to send an ACK.
        };

        state: State,
        controller: config.Controller,

        pub fn interface(this: *@This()) usb.DeviceInterface {
            return .{
                .ptr = this,
                .vtable = &interface_vtable,
            };
        }

        pub fn init() @This() {
            if (chip == .RP2350)
                peri_usb.MAIN_CTRL.modify(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            peri_dpram.SETUP_PACKET_LOW.write_raw(0);
            peri_dpram.SETUP_PACKET_HIGH.write_raw(0);

            for (HardwareEndpoint.ep_ctrl_all) |*ep_ctrl|
                ep_ctrl.write_raw(0);
            for (HardwareEndpoint.buf_ctrl_all) |*buf_ctrl|
                buf_ctrl.write_raw(0);

            // Mux the controller to the onboard USB PHY. I was surprised that there are
            // alternatives to this, but, there are.
            peri_usb.USB_MUXING.modify(.{
                .TO_PHY = 1,
                // This bit is also set in the SDK example, without any discussion. It's
                // undocumented (being named does not count as being documented).
                .SOFTCON = 1,
            });

            // Force VBUS detect. Not all RP2040 boards wire up VBUS detect, which would
            // let us detect being plugged into a host (the Pi Pico, to its credit,
            // does). For maximum compatibility, we'll set the hardware to always
            // pretend VBUS has been detected.
            peri_usb.USB_PWR.modify(.{
                .VBUS_DETECT = 1,
                .VBUS_DETECT_OVERRIDE_EN = 1,
            });

            // Enable controller in device mode.
            peri_usb.MAIN_CTRL.modify(.{
                .CONTROLLER_EN = 1,
                .HOST_NDEVICE = 0,
            });

            // Request to have an interrupt (which really just means setting a bit in
            // the `buff_status` register) every time a buffer moves through EP0.
            peri_usb.SIE_CTRL.modify(.{ .EP0_INT_1BUF = 1 });

            // Enable interrupts (bits set in the `ints` register) for other conditions
            // we use:
            peri_usb.INTE.modify(.{
                // A buffer is done
                .BUFF_STATUS = 1,
                // The host has reset us
                .BUS_RESET = 1,
                // We've gotten a setup request on EP0
                .SETUP_REQ = 1,
            });

            var this: @This() = .{
                .state = .{ .no_buffer = null },
                .controller = .init(),
            };

            if (this.interface().endpoint_open(.in(.ep0), .Control, 0) catch unreachable) |tx|
                this.state = .{ .ready = tx };

            _ = this.interface().endpoint_open(.out(.ep0), .Control, 0) catch unreachable;

            // Present full-speed device by enabling pullup on DP. This is the point
            // where the host will notice our presence.
            peri_usb.SIE_CTRL.modify(.{ .PULLUP_EN = 1 });
            return this;
        }

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

        fn control_transfer(ptr: *anyopaque, data: []const u8) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            switch (this.state) {
                .sending => |residual| {
                    std.log.err("residual data: {any}", .{residual});
                    this.state = .{ .sending = data };
                },
                .no_buffer => |new_address| {
                    if (new_address) |_|
                        std.log.err("missed address change!", .{});
                    this.state = .{ .sending = data };
                },
                .ready => |tx_buf| this.ep0_send(tx_buf, data),
                .waiting_ack => unreachable,
            }
        }

        fn process_setup(this: *@This(), tx_buf: []u8) void {
            // Copy the setup packet out of its dedicated buffer at the base of
            // USB SRAM. The PAC models this buffer as two 32-bit registers.
            const setup: usb.types.SetupPacket = @bitCast([2]u32{
                peri_dpram.SETUP_PACKET_LOW.raw,
                peri_dpram.SETUP_PACKET_HIGH.raw,
            });

            // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
            // to an IN on EP0 needs to use PID DATA1.
            peri_dpram.EP0_IN_BUFFER_CONTROL.modify(.{ .PID_0 = 0 });

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
                        .SetConfiguration => this.controller.set_configuration(this.interface(), &setup),
                        .GetDescriptor => if (config.Controller.get_descriptor(&setup)) |desc|
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

        // fn ep0_handler(this: *@This(), ep: HardwareEndpoint, buf: []u8) usb.PacketUnhandled!void {}

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        pub fn task(ptr: *anyopaque) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            const ints = peri_usb.INTS.read();
            const SieStatus = @TypeOf(peri_usb.SIE_STATUS).underlying_type;

            switch (this.state) {
                .ready => |tx_buf| if (ints.SETUP_REQ != 0) {
                    // Clear the status flag (write one to clear)
                    var sie_status: SieStatus = @bitCast(@as(u32, 0));
                    sie_status.SETUP_REC = 1;
                    peri_usb.SIE_STATUS.write(sie_status);
                    this.process_setup(tx_buf);
                },
                else => {},
            }
            if (ints.BUFF_STATUS != 0) {
                const unhandled_initial = peri_usb.BUFF_STATUS.raw;
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
                                    peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });

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
                        this.controller.on_data_rx(this.interface(), ep.num, buf[0..ep.len()])
                    else
                        this.controller.on_tx_ready(this.interface(), ep.num, buf);

                    result catch {
                        std.log.warn("unhandled usb packet: ep{}{s}", .{ ep.num, if (ep.is_out) "out" else "in" });
                        if (ep.is_out)
                            std.log.warn("{any}", .{buf[0..ep.len()]});
                    };
                }
                peri_usb.BUFF_STATUS.write_raw(unhandled_initial);
            }

            if (ints.BUS_RESET != 0) {
                this.controller.deinit();
                this.controller = .init();

                var sie_status: SieStatus = @bitCast(@as(u32, 0));
                sie_status.BUS_RESET = 1;
                peri_usb.SIE_STATUS.write(sie_status);
                peri_usb.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = 0 });
            }
        }

        pub fn submit_tx_buffer(_: *anyopaque, ep_in: Endpoint.Num, buffer_end: [*]const u8) void {
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

        pub fn signal_rx_ready(_: *anyopaque, ep_out: Endpoint.Num, len: usize) void {
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

        pub fn endpoint_open(
            _: *anyopaque,
            ep: Endpoint,
            transfer_type: usb.types.TransferType,
            buf_size_hint: usize,
        ) error{OutOfBufferMemory}!?[]u8 {
            _ = buf_size_hint;

            const ep_hard: HardwareEndpoint = .{
                .num = ep.num,
                .is_out = ep.dir == .Out,
            };

            assert(ep.num.to_int() < max_endpoints_count);

            const start = if (ep.num != .ep0) blk: {
                const buf = try config.dpram_allocator.alloc(1);
                var ep_ctrl = ep_hard.ep_ctrl().?;
                var rmw = ep_ctrl.read();
                rmw.ENABLE = 1;
                rmw.INTERRUPT_PER_BUFF = 1;
                rmw.ENDPOINT_TYPE = @enumFromInt(transfer_type.as_number());
                rmw.BUFFER_ADDRESS = buf.to_u16();
                ep_ctrl.write(rmw);
                break :blk buf.start();
            } else DpramBuffer.Index.ep0buf0.start();

            return start[0..default.transfer_size];
        }
    };
}
