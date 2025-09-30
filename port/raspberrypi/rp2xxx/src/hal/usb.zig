//! USB device implementation
//!
//! Initial inspiration: cbiffle's Rust [implementation](https://github.com/cbiffle/rp2040-usb-device-in-one-file/blob/main/src/main.rs)

const std = @import("std");
const assert = std.debug.assert;
const enumFromInt = std.meta.intToEnum;

const microzig = @import("microzig");
const USB = microzig.chip.peripherals.USB;
const usb = microzig.core.usb;
const EpNum = usb.types.Endpoint.Num;

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

pub const Config = struct {
    /// How many nops to insert for synchronization with the USB hardware.
    synchronization_nops: comptime_int = 3,
    /// USB controller configuration.
    controller_config: usb.Config,
};

const DualPortRam = extern struct {
    const buffer_len_mult = 64;
    const total_size = 4096;

    const peri = microzig.chip.peripherals.USB_DPRAM;
    const EpCtrl = @TypeOf(peri.EP1_IN_CONTROL);
    const BufCtrl = @TypeOf(peri.EP0_IN_BUFFER_CONTROL);

    setup: usb.types.SetupPacket,
    ep_ctrl_raw: [15][2]EpCtrl,
    buf_ctrl_raw: [16][2]BufCtrl,
    buffer0: [buffer_len_mult]u8,
    buffer1: [buffer_len_mult]u8,

    var alloc_top: u16 = @sizeOf(@This());

    fn ep_open(this: *@This(), ep_num: EpNum, ep_dir: usb.types.Dir, transfer_type: usb.types.TransferType) u16 {
        var reg = this.ep_ctrl(ep_num, ep_dir) orelse
            std.debug.panic("Endpoint 0 should not be opened.", .{});

        const buf_idx = alloc_top;
        alloc_top += buffer_len_mult;
        if (alloc_top > total_size)
            std.debug.panic("USB controller out of memory.", .{});

        reg.write(.{
            .ENABLE = 1,
            .DOUBLE_BUFFERED = 0,
            .INTERRUPT_PER_BUFF = 1,
            .INTERRUPT_PER_DOUBLE_BUFF = 1,
            .ENDPOINT_TYPE = switch (transfer_type) {
                .Control => std.debug.panic("Only endpoint 0 can be a control endpoint.", .{}),
                .Isochronous => std.debug.panic("Isochronous endpoints are not implemented", .{}),
                .Bulk => .bulk,
                .Interrupt => .interrupt,
            },
            .INTERRUPT_ON_STALL = 0,
            .INTERRUPT_ON_NAK = 0,
            .BUFFER_ADDRESS = buf_idx,
        });

        return buf_idx;
    }

    fn ep_ctrl(this: *@This(), num: EpNum, dir: usb.types.Dir) ?*volatile EpCtrl {
        if (std.math.sub(u4, @intFromEnum(num), 1)) |idx|
            return &this.ep_ctrl_raw[idx][@intFromBool(dir == .Out)]
        else |_|
            return null;
    }

    fn buf_ctrl(this: *@This(), num: EpNum, dir: usb.types.Dir) *volatile BufCtrl {
        return &this.buf_ctrl_raw[@intFromEnum(num)][@intFromBool(dir == .Out)];
    }

    // TODO: Double buffered mode?
    fn buffer(this: *@This(), num: EpNum, dir: usb.types.Dir) []u8 {
        if (this.ep_ctrl(num, dir)) |ep| {
            const addr = ep.read().BUFFER_ADDRESS;
            const mem: *[total_size]u8 = @ptrCast(this);
            // TODO: Isochronous endpoints can have other sizes.
            const size = 64;
            return mem[addr .. addr + size];
        } else return &this.buffer0;
    }
};

comptime {
    // Sanity check that offsets match the datasheet.
    assert(@offsetOf(DualPortRam, "ep_ctrl_raw") == 0x8);
    assert(@offsetOf(DualPortRam, "buf_ctrl_raw") == 0x80);
    assert(@offsetOf(DualPortRam, "buffer0") == 0x100);
    assert(@offsetOf(DualPortRam, "buffer1") == 0x140);
    assert(@sizeOf(DualPortRam) == 0x180);
}

// `@volatileCast` is sound because the USB hardware only modifies the buffers
// after we transfer ownership by accesing a volatile register.
const dpram: *DualPortRam = @ptrCast(@volatileCast(DualPortRam.peri));

pub fn Usb(comptime config: Config) type {
    return struct {
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
            ready,
            waiting_ack, // Host is expected to send an ACK.
        };

        state: State,
        controller: Controller,

        pub fn interface(this: *@This()) usb.DeviceInterface {
            return .{
                .ptr = this,
                .transfer = &transfer,
            };
        }

        /// Initialize USB hardware and request enumertation from USB host.
        pub fn init() @This() {
            const chip = microzig.hal.compatibility.chip;

            if (chip == .RP2350)
                USB.MAIN_CTRL.modify(.{ .PHY_ISO = 0 });

            // Clear the control portion of DPRAM. This may not be necessary -- the
            // datasheet is ambiguous -- but the C examples do it, and so do we.
            dpram.* = .{
                .setup = @bitCast(@as(u64, 0)),
                .ep_ctrl_raw = @splat(@bitCast(@as(u64, 0))),
                .buf_ctrl_raw = @splat(@bitCast(@as(u64, 0))),
                .buffer0 = undefined,
                .buffer1 = undefined,
            };

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
                .state = .ready,
                .controller = .init,
            };
        }

        /// Called when a setup packet is received.
        fn process_setup(this: *@This()) ?[]const u8 {
            // Copy the setup packet out of its dedicated buffer at the base of USB SRAM.
            const setup = dpram.setup;

            std.log.info("setup: {any}", .{setup});

            // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
            // to an IN on EP0 needs to use PID DATA1.
            dpram.buf_ctrl(.ep0, .In).modify(.{ .PID_0 = 0 });

            switch (setup.request_type.recipient) {
                .Device => blk: {
                    if (setup.request_type.type != .Standard) break :blk;
                    switch (enumFromInt(
                        usb.types.SetupRequest,
                        setup.request,
                    ) catch break :blk) {
                        .SetAddress => {
                            this.state = .{ .no_buffer = @intCast(setup.value) };
                            return usb.ACK;
                        },
                        .SetConfiguration => if (this.controller.set_configuration(this, &setup))
                            return usb.ACK,
                        .GetDescriptor => if (Controller.get_descriptor(&setup)) |desc|
                            return desc,
                        .SetFeature => if (this.controller.set_feature(
                            @intCast(setup.value >> 8),
                            setup.index,
                            true,
                        )) return usb.ACK,
                    }
                },
                .Interface => if (this.controller.interface_setup(&setup)) |data|
                    return data,
                else => {},
            }
            return usb.NAK;
        }

        /// Polls the device for events. Not thread safe, this must be called
        /// from the same thread that interacts with all the drivers.
        pub fn poll(this: *@This()) void {
            const ints = USB.INTS.read();
            const SieStatus = @TypeOf(USB.SIE_STATUS).underlying_type;

            switch (this.state) {
                .ready => |_| if (ints.SETUP_REQ != 0) {
                    // Clear the status flag (write one to clear)
                    var sie_status: SieStatus = @bitCast(@as(u32, 0));
                    sie_status.SETUP_REC = 1;
                    USB.SIE_STATUS.write(sie_status);
                    if (this.process_setup()) |data| {
                        std.log.info("setup response: '{}' {}", .{ data.len, dpram.buf_ctrl(.ep0, .In).read().AVAILABLE_0 });
                        const len = this.interface().write_buffered(data, .ep0, true).?;

                        if (len != 0) {
                            this.state = .{ .sending = data[len..] };
                        } else if (this.state != .no_buffer) {
                            this.state = .{ .no_buffer = null };
                        }
                    }
                },
                else => {},
            }
            if (ints.BUFF_STATUS != 0)
                USB.BUFF_STATUS.write(USB.BUFF_STATUS.read());

            const buf_ctrl_in = dpram.buf_ctrl(.ep0, .In).read();
            switch (this.state) {
                .sending => |data| if (this.interface().write_buffered(data, .ep0, true)) |len| {
                    if (len != 0)
                        this.state = .{ .sending = data[len..] }
                    else {
                        // TODO: Check return value.
                        // _ = this.interface().read_exact("", .ep0, 0);
                        listen(.ep0, 0);
                        this.state = .waiting_ack;
                    }
                },
                .no_buffer => |new_address| if (buf_ctrl_in.AVAILABLE_0 == 0) {
                    // Finish the delayed SetAddress request, if there is one:
                    if (new_address) |addr|
                        USB.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });
                    this.state = .ready;
                },
                .ready => {},
                .waiting_ack => if (buf_ctrl_in.AVAILABLE_0 == 0) {
                    this.state = .ready;
                } else if (this.interface().read_exact("", .ep0, null)) |len| {
                    assert(len == 0);
                    this.state = .ready;
                },
            }

            if (ints.BUS_RESET != 0) {
                this.controller.deinit();
                this.controller = .init;

                var sie_status: SieStatus = @bitCast(@as(u32, 0));
                sie_status.BUS_RESET = 1;
                USB.SIE_STATUS.write(sie_status);
                USB.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = 0 });
            }
        }

        fn submit_buffer_in(ep_in: EpNum, len: u10) void {
            // Write the buffer information to the buffer control register
            const buf_ctrl = dpram.buf_ctrl(ep_in, .In);
            var rmw = buf_ctrl.read();
            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 1; // We have put data in
            rmw.LENGTH_0 = len; // There are this many bytes

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
        pub fn transfer(ptr: *anyopaque, opts: usb.DeviceInterface.Options, ep_num: EpNum, df: bool) ?u16 {
            const this: *@This() = @ptrCast(@alignCast(ptr));
            _ = this;

            const buf_ctrl = dpram.buf_ctrl(ep_num, opts);
            var rmw = buf_ctrl.read();
            if (rmw.AVAILABLE_0 == 1) return null;

            const buffer = dpram.buffer(ep_num, opts);
            const avail = switch (opts) {
                .Out => buffer[if (rmw.FULL_0 == 1) 0 else rmw.LENGTH_1..rmw.LENGTH_0],
                .In => buffer[if (rmw.FULL_0 == 0) 0 else rmw.LENGTH_0..],
            };

            if (df and buffer.ptr != avail.ptr)
                std.debug.panic("residual {any} data on {any}: {}", .{ opts, ep_num, if (opts == .In) rmw.LENGTH_0 else rmw.LENGTH_1 });

            const len = @min(avail.len, opts.len());
            rmw.FULL_0 = @intFromEnum(opts);

            switch (opts) {
                .Out => |out| {
                    if (df and len != avail.len)
                        std.debug.panic("could not read full packet on {any} {} {}", .{ ep_num, len, avail.len });

                    std.mem.copyForwards(u8, out.data[0..len], avail[0..len]);

                    if (len == avail.len and out.listen != null)
                        listen(ep_num, out.listen.?)
                    else {
                        rmw.LENGTH_1 = @intCast(avail.ptr - buffer.ptr + len);
                        buf_ctrl.write(rmw);
                    }
                },
                .In => |in| {
                    if (df and len != in.data.len)
                        std.debug.panic("could not send full packet on {any}", .{ep_num});

                    std.mem.copyForwards(u8, avail[0..len], in.data[0..len]);

                    rmw.LENGTH_0 = @intCast(avail.ptr - buffer.ptr + len);
                    if (df or len == avail.len or in.flush)
                        submit_buffer_in(ep_num, rmw.LENGTH_0)
                    else {
                        buf_ctrl.write(rmw);
                    }
                },
            }
            return @intCast(len);
        }

        /// See interface description.
        pub fn listen(ep_out: EpNum, len: u16) void {
            // Configure the OUT:
            const buf_ctrl = dpram.buf_ctrl(ep_out, .Out);
            var rmw = buf_ctrl.read();

            if (rmw.AVAILABLE_0 == 1) return;

            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is empty
            rmw.AVAILABLE_0 = 1; // And ready to be filled
            rmw.LENGTH_1 = 0;
            rmw.LENGTH_0 = @min(len, default.transfer_size);
            buf_ctrl.write(rmw);
        }

        pub fn open_in(_: *@This(), ep_num: EpNum, transfer_type: usb.types.TransferType) void {
            _ = dpram.ep_open(ep_num, .In, transfer_type);
        }

        pub fn open_out(_: *@This(), ep_num: EpNum, transfer_type: usb.types.TransferType) void {
            _ = dpram.ep_open(ep_num, .Out, transfer_type);
        }
    };
}
