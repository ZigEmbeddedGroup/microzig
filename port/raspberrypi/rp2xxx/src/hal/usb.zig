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

pub const Config = struct {
    /// How many nops to insert for synchronization with the USB hardware.
    synchronization_nops: comptime_int = 3,
    /// USB controller configuration.
    controller_config: usb.Config,
};

const DualPortRam = extern struct {
    const buffer_len_mult = 64;
    const total_size = 4096;

    setup: types.SetupPacket,
    ep_ctrl_raw: [15][2]EpCtrl,
    buf_ctrl_raw: [16][2]BufCtrl,
    buffer0: [buffer_len_mult]u8,
    buffer1: [buffer_len_mult]u8,

    var alloc_top: u16 = @sizeOf(@This());

    fn ep_open(this: *@This(), ep_num: EpNum, ep_dir: types.Dir, transfer_type: types.TransferType) u16 {
        if (ep_num == .ep0)
            std.debug.panic("Endpoint 0 should not be opened.", .{});
        if (transfer_type == .Control)
            std.debug.panic("Only endpoint 0 can be a control endpoint.", .{});
        if (transfer_type == .Isochronous)
            std.debug.panic("Isochronous endpoints are not implemented", .{});

        const buf_idx = alloc_top;
        alloc_top += buffer_len_mult;
        if (alloc_top > total_size)
            std.debug.panic("USB controller out of memory.", .{});

        var reg = this.ep_ctrl(ep_num, ep_dir).?;
        var rmw = reg.read();
        rmw.ENABLE = 1;
        rmw.INTERRUPT_PER_BUFF = 1;
        rmw.ENDPOINT_TYPE = @enumFromInt(transfer_type.as_number());
        // The datasheet claims bits 0 throigh 5 are ignored, but it is not the case in practice.
        rmw.BUFFER_ADDRESS = buf_idx;
        reg.write(rmw);
        return buf_idx;
    }

    fn ep_ctrl(this: *@This(), num: EpNum, dir: types.Dir) ?*volatile EpCtrl {
        if (std.math.sub(u4, @intFromEnum(num), 1)) |idx|
            return &this.ep_ctrl_raw[idx][@intFromBool(dir == .Out)]
        else |_|
            return null;
    }

    fn buf_ctrl(this: *@This(), num: EpNum, dir: types.Dir) *volatile BufCtrl {
        return &this.buf_ctrl_raw[@intFromEnum(num)][@intFromBool(dir == .Out)];
    }

    // TODO: Double buffered mode?
    fn buffer(this: *@This(), num: EpNum, dir: types.Dir) []u8 {
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
    assert(@offsetOf(DualPortRam, "buf_ctrl_raw") == 0x80);
    assert(@offsetOf(DualPortRam, "buffer0") == 0x100);
}

// `@volatileCast` is sound because the USB hardware only modifies the buffers
// after we transfer ownership by accesing a volatile register.
const dpram: *DualPortRam = @ptrCast(@volatileCast(USB_DPRAM));

pub fn Usb(comptime config: Config) type {
    return struct {
        pub const interface_vtable: usb.DeviceInterface.Vtable = .{
            .writev = &writev,
            .stream = &stream,
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
            const dpram_data: *volatile [0x100 / @sizeOf(u32)]u32 = @ptrCast(USB_DPRAM);
            @memset(dpram_data, 0);

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
                .state = .{ .ready = &dpram.buffer0 },
                .controller = .init,
            };
        }

        /// Helper function that breaks up long strings.
        fn ep0_send(this: *@This(), tx_buf: []u8, data: []const u8) void {
            const len = @min(tx_buf.len, data.len);
            if (len == 0)
                this.state = .{ .no_buffer = null }
            else {
                std.mem.copyForwards(u8, tx_buf[0..len], data[0..len]);
                this.state = .{ .sending = data[len..] };
            }
            submit_buffer_in(.ep0, @intCast(len));
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
                        .SetConfiguration => if (this.controller.set_configuration(this, &setup))
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

        /// Polls the device for events. Not thread safe, this must be called
        /// from the same thread that interacts with all the drivers.
        pub fn poll(this: *@This()) void {
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
                const unhandled = USB.BUFF_STATUS.raw;

                for (0..16) |ep_num_usize| {
                    const shamt: u5 = @intCast(2 * ep_num_usize);
                    if (unhandled & (@as(u32, 1) << shamt) == 0) continue;

                    const ep_num: EpNum = @enumFromInt(ep_num_usize);
                    // const buf_ctrl = dpram.buf_ctrl(ep_num, .In).read();
                    const buf = dpram.buffer(ep_num, .In);

                    const result = if (ep_num == .ep0) blk: {
                        switch (this.state) {
                            .sending => |data| {
                                this.ep0_send(buf, data);

                                if (data.len == 0) {
                                    listen(.ep0, 0);
                                    this.state = .waiting_ack;
                                }
                            },
                            .no_buffer => |new_address| {
                                // Finish the delayed SetAddress request, if there is one:
                                if (new_address) |addr|
                                    USB.ADDR_ENDP.write(.{ .ENDPOINT = 0, .ADDRESS = addr });

                                this.state = .{ .ready = buf };
                            },
                            .ready => |_| break :blk error.UsbPacketUnhandled,
                            .waiting_ack => this.state = .{ .ready = buf },
                        }
                    } else continue;

                    result catch
                        std.log.warn("unhandled usb packet: ep{}in", .{ep_num});
                }

                for (0..16) |ep_num_usize| {
                    const shamt: u5 = @intCast(2 * ep_num_usize);
                    if (unhandled & (@as(u32, 2) << shamt) == 0) continue;

                    const ep_num: EpNum = @enumFromInt(ep_num_usize);
                    const buf_ctrl = dpram.buf_ctrl(ep_num, .Out).read();
                    const buf = dpram.buffer(ep_num, .Out);

                    const result = if (ep_num == .ep0) blk: {
                        switch (this.state) {
                            .sending => |_| break :blk error.UsbPacketUnhandled,
                            .no_buffer => |_| break :blk error.UsbPacketUnhandled,
                            .ready => |_| {
                                std.log.err("Got buffer twice!", .{});
                                break :blk error.UsbPacketUnhandled;
                            },
                            .waiting_ack => {
                                assert(buf_ctrl.LENGTH_0 == 0);
                                this.state = .{ .ready = buf };
                            },
                        }
                    } else continue;

                    result catch {
                        std.log.warn("unhandled usb packet: ep{}out", .{ep_num});
                        std.log.warn("{any}", .{buf[0..dpram.buf_ctrl(ep_num, .Out).read().LENGTH_0]});
                    };
                }

                USB.BUFF_STATUS.write_raw(unhandled);
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

        fn submit_buffer_in(ep_in: EpNum, len: u16) void {
            // Write the buffer information to the buffer control register
            const buf_ctrl = dpram.buf_ctrl(ep_in, .In);
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
        pub fn writev(_: *anyopaque, ep_in: EpNum, buffers: []const []const u8) usize {
            const buf_ctrl = dpram.buf_ctrl(ep_in, .In);
            const rmw = buf_ctrl.read();
            if (rmw.FULL_0 != 0) return 0;

            // It is technically possible to support longer buffers but this demo doesn't bother.
            const buf = dpram.buffer(ep_in, .In);
            const len = @min(buf.len, buffers[0].len);
            std.mem.copyForwards(u8, buf[0..len], buffers[0][0..len]);

            submit_buffer_in(ep_in, @intCast(len));

            return len;
        }

        pub fn stream(_: *anyopaque, ep_out: EpNum, w: *std.Io.Writer, limit: std.Io.Limit) usize {
            const dst = limit.slice(w.unusedCapacitySlice());
            if (dst.len == 0) return 0;

            const buf_ctrl = dpram.buf_ctrl(ep_out, .Out);
            var rmw = buf_ctrl.read();
            if (rmw.AVAILABLE_0 == 1) return 0;

            const buffer = dpram.buffer(ep_out, .Out);
            const src = buffer[rmw.LENGTH_1..rmw.LENGTH_0];

            const len = @min(src.len, dst.len);
            std.mem.copyForwards(u8, dst[0..len], src[0..len]);

            if (src.len < dst.len)
                listen(ep_out, @intCast(dst.len - src.len))
            else {
                rmw.FULL_0 = 0;
                rmw.LENGTH_1 += @intCast(len);
                buf_ctrl.write(rmw);
            }
            return len;
        }

        /// See interface description.
        pub fn listen(ep_out: EpNum, len: u16) void {
            // Configure the OUT:
            const buf_ctrl = dpram.buf_ctrl(ep_out, .Out);
            var rmw = buf_ctrl.read();

            rmw.PID_0 ^= 1; // Flip DATA0/1
            rmw.FULL_0 = 0; // Buffer is empty
            rmw.AVAILABLE_0 = 1; // And ready to be filled
            rmw.LENGTH_1 = 0;
            rmw.LENGTH_0 = @min(len, default.transfer_size);
            buf_ctrl.write(rmw);
        }

        pub fn open_in(_: *@This(), ep_num: EpNum, transfer_type: types.TransferType) void {
            _ = dpram.ep_open(ep_num, .In, transfer_type);
        }

        pub fn open_out(_: *@This(), ep_num: EpNum, transfer_type: types.TransferType) void {
            _ = dpram.ep_open(ep_num, .Out, transfer_type);
        }
    };
}
