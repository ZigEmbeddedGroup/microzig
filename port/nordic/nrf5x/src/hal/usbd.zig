//! USB device implementation
//!
//! References:
//! * RP2XXX HAL (port/raspberrypi/rp2xxx/src/hal/usb.zig)
//! * https://github.com/nrf-rs/nrf-usbd

const std = @import("std");
const log = std.log.scoped(.usb_dev);
const microzig = @import("microzig");
const cpu = microzig.cpu;
const peripherals = microzig.chip.peripherals;
const usb = microzig.core.usb;

const errata = @import("./usbd/errata.zig");

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Code
// +++++++++++++++++++++++++++++++++++++++++++++++++

const MAX_PACKET_SIZE = 64;
const NUM_EP = 8;
const EP0_IN_STATUS_TIMEOUT_FRAMES: u11 = 5;

const PowerState = union(enum) {
    detached,
    enabling,
    waiting_pwrrdy,
    connected,
};

const EP0_State = struct {
    direction: usb.types.Dir = .Out,
    remaining_size: u16 = 0,
    in_pending: bool = false,
    in_start_frame: u11 = 0,
};

const EP_Config = struct {
    max_packet_size: u16 = MAX_PACKET_SIZE,
};

pub const USBD = struct {
    power: PowerState = .detached,

    bufs_in: [NUM_EP][MAX_PACKET_SIZE]u8 align(4) = @splat(@splat(0)),
    bufs_out: [NUM_EP][MAX_PACKET_SIZE]u8 align(4) = @splat(@splat(0)),
    eps_in: [NUM_EP]EP_Config = @splat(.{}),
    eps_out: [NUM_EP]EP_Config = @splat(.{}),
    ep0_state: EP0_State = .{},

    interface: usb.DeviceInterface,

    pub const max_supported_packet_size = MAX_PACKET_SIZE;
    pub const max_supported_bcd_usb: usb.types.Version = .v1_10;
    pub const default_vendor_id: usb.Config.IdStringPair = .{ .id = 0x1209, .str = "pid.codes" };
    pub const default_product_id: usb.Config.IdStringPair = .{ .id = 0x0001, .str = "nRF5x test device" };

    const vtable: usb.DeviceInterface.VTable = .{
        .ep_writev = ep_writev,
        .ep_readv = ep_readv,
        .ep_listen = ep_listen,
        .ep_open = ep_open,
        .set_address = set_address,
    };

    const Self = @This();

    pub fn init() Self {
        peripherals.USBD.USBPULLUP.write_raw(0);
        peripherals.USBD.ENABLE.write_raw(0);
        peripherals.USBD.EPINEN.write_raw(0x01); // only EP0 IN by default
        peripherals.USBD.EPOUTEN.write_raw(0x01); // only EP0 OUT by default
        peripherals.USBD.EVENTCAUSE.write_raw(0xFFFFFFFF); // W1C all
        peripherals.USBD.EPSTATUS.write_raw(0xFFFFFFFF); // W1C all
        peripherals.USBD.EPDATASTATUS.write_raw(0xFFFFFFFF); // W1C all
        peripherals.USBD.EVENTS_USBRESET.write_raw(0);
        peripherals.USBD.EVENTS_EP0SETUP.write_raw(0);
        peripherals.USBD.EVENTS_EP0DATADONE.write_raw(0);
        peripherals.USBD.EVENTS_EPDATA.write_raw(0);
        peripherals.USBD.EVENTS_USBEVENT.write_raw(0);
        for (0..8) |i| {
            peripherals.USBD.EVENTS_ENDEPIN[i].write_raw(0);
            peripherals.USBD.EVENTS_ENDEPOUT[i].write_raw(0);
            peripherals.USBD.EPIN[i].PTR.write_raw(0);
            peripherals.USBD.EPIN[i].MAXCNT.write_raw(0);
            peripherals.USBD.EPOUT[i].PTR.write_raw(0);
            peripherals.USBD.EPOUT[i].MAXCNT.write_raw(0);
        }
        return .{
            .interface = .{ .vtable = &vtable },
        };
    }

    pub fn poll(self: *Self, controller: anytype) void {
        comptime usb.validate_controller(@TypeOf(controller));

        if (self.power != .detached and peripherals.POWER.USBREGSTATUS.read().VBUSDETECT == .NoVbus) {
            self.teardown();
            self.power = .detached;
            return;
        }

        switch (self.power) {
            .detached => {
                if (peripherals.POWER.USBREGSTATUS.read().VBUSDETECT == .VbusPresent) {
                    errata.pre_enable();
                    peripherals.USBD.ENABLE.write_raw(1);
                    self.power = .enabling;
                }
            },
            .enabling => {
                if (peripherals.USBD.EVENTCAUSE.read().READY == .Ready) {
                    peripherals.USBD.EVENTCAUSE.write(.{ .READY = .Ready }); // W1C
                    peripherals.USBD.EVENTS_USBEVENT.write_raw(0);
                    errata.post_enable();
                    self.power = .waiting_pwrrdy;
                }
            },
            .waiting_pwrrdy => {
                if (peripherals.POWER.USBREGSTATUS.read().OUTPUTRDY == .Ready) {
                    peripherals.USBD.USBPULLUP.write_raw(1);
                    self.power = .connected;
                }
            },
            .connected => {
                // Bus reset
                if (peripherals.USBD.EVENTS_USBRESET.raw != 0) {
                    peripherals.USBD.EVENTS_USBRESET.write_raw(0);

                    self.reset();
                    controller.on_bus_reset(&self.interface);
                    return;
                }

                // SETUP packet captured by hardware
                if (peripherals.USBD.EVENTS_EP0SETUP.raw != 0) {
                    peripherals.USBD.EVENTS_EP0SETUP.write_raw(0);
                    // Aborted control transfer: drop stale DATADONE so it can't
                    // trigger on_buffer for the next transfer.
                    peripherals.USBD.EVENTS_EP0DATADONE.write_raw(0);
                    self.ep0_state.in_pending = false;

                    const setup: usb.types.SetupPacket = .{
                        .request_type = @bitCast(@as(u8, @intCast(peripherals.USBD.BMREQUESTTYPE.raw))),
                        .request = @intCast(peripherals.USBD.BREQUEST.raw),
                        .value = .from(@as(u16, @intCast(peripherals.USBD.WVALUEH.raw)) << 8 | @as(u16, @intCast(peripherals.USBD.WVALUEL.raw))),
                        .index = .from(@as(u16, @intCast(peripherals.USBD.WINDEXH.raw)) << 8 | @as(u16, @intCast(peripherals.USBD.WINDEXL.raw))),
                        .length = .from(@as(u16, @intCast(peripherals.USBD.WLENGTHH.raw)) << 8 | @as(u16, @intCast(peripherals.USBD.WLENGTHL.raw))),
                    };
                    self.ep0_state.direction = switch (peripherals.USBD.BMREQUESTTYPE.read().DIRECTION) {
                        .HostToDevice => .Out,
                        .DeviceToHost => .In,
                    };
                    self.ep0_state.remaining_size = setup.length.into();
                    controller.on_setup_req(&self.interface, &setup);
                }

                // EP0 data-phase completions
                if (peripherals.USBD.EVENTS_EP0DATADONE.raw != 0) {
                    // Here nrf-usbd doesn't clear OUT events
                    // (https://github.com/nrf-rs/nrf-usbd/blob/main/src/usbd.rs#L683)
                    // But this case is not handled in the controller yet
                    peripherals.USBD.EVENTS_EP0DATADONE.write_raw(0);
                    self.ep0_state.in_pending = false;
                    switch (self.ep0_state.direction) {
                        .In => controller.on_buffer(&self.interface, .in(.ep0)),
                        // Control-OUT with data-phase is unhandled in the controller
                        .Out => peripherals.USBD.TASKS_EP0STATUS.write_raw(1),
                    }
                }

                // Data-endpoint completions
                if (peripherals.USBD.EVENTS_EPDATA.raw != 0) {
                    peripherals.USBD.EVENTS_EPDATA.write_raw(0);
                    const status = peripherals.USBD.EPDATASTATUS.raw;
                    peripherals.USBD.EPDATASTATUS.write_raw(status); // W1C handled bits
                    // Calling on_buffer() for each set bit
                    // IN endpoints (bits 1-7)
                    var status_in = status >> 1;
                    inline for (1..8) |i| {
                        if (status_in == 0) break;
                        if (status_in & 1 == 1) controller.on_buffer(&self.interface, .in(@enumFromInt(i)));
                        status_in >>= 1;
                    }
                    // OUT endpoints (bits 17-23)
                    var status_out = status >> 17;
                    inline for (1..8) |i| {
                        if (status_out == 0) break;
                        if (status_out & 1 == 1) controller.on_buffer(&self.interface, .out(@enumFromInt(i)));
                        status_out >>= 1;
                    }
                }

                // TODO: Implement `Suspend`
                if (peripherals.USBD.EVENTCAUSE.read().SUSPEND == .Detected) {
                    peripherals.USBD.EVENTCAUSE.write(.{ .SUSPEND = .Detected });
                    peripherals.USBD.EVENTS_USBEVENT.write_raw(0);
                }

                // TODO: Implement `Resume`
                if (peripherals.USBD.EVENTCAUSE.read().RESUME == .Detected) {
                    peripherals.USBD.EVENTCAUSE.write(.{ .RESUME = .Detected });
                    peripherals.USBD.EVENTS_USBEVENT.write_raw(0);
                }

                // TODO: ISO endpoints

                // EP0 IN data stage:
                // Host may jump to the status stage without acknowledging the data transfer
                // so the EP0DATADONE_EP0STATUS short may never fire and device will keep
                // NAKing the OUT tokens.
                // HACK: trigger status stage if the IN transfer is not acknowledged after a few frames
                if (self.ep0_state.in_pending) {
                    const now = peripherals.USBD.FRAMECNTR.read().FRAMECNTR;
                    if ((now -% self.ep0_state.in_start_frame) >= EP0_IN_STATUS_TIMEOUT_FRAMES) {
                        peripherals.USBD.TASKS_EP0STATUS.write_raw(1);
                        peripherals.USBD.EVENTS_EP0DATADONE.write_raw(0);
                        self.ep0_state.in_pending = false;
                    }
                }
            },
        }
    }

    fn teardown(_: *Self) void {
        // Upon VBUS removal detection, it is recommended to
        // let on-going EasyDMA transfers finish before disabling USBD
        //
        // But in this case it won't happen because
        // we busywait for ENDEP* with interrupts disabled
        peripherals.USBD.USBPULLUP.write_raw(0);
        peripherals.USBD.ENABLE.write_raw(0);
    }

    fn reset(self: *Self) void {
        peripherals.USBD.EPDATASTATUS.write_raw(0xFFFFFFFF); // W1C all
        peripherals.USBD.EPSTATUS.write_raw(0xFFFFFFFF); // W1C all
        peripherals.USBD.EVENTS_EP0SETUP.write_raw(0);
        peripherals.USBD.EVENTS_EP0DATADONE.write_raw(0);
        peripherals.USBD.EVENTS_EPDATA.write_raw(0);
        peripherals.USBD.SHORTS.write(.{ .EP0DATADONE_EP0STATUS = .Disabled });
        peripherals.USBD.EPINEN.write_raw(0x01); // only EP0 IN
        peripherals.USBD.EPOUTEN.write_raw(0x01); // only EP0 OUT

        for (1..NUM_EP) |i| {
            // NOTE: Data endpoints are automatically disabled on reset
            peripherals.USBD.EPIN[i].PTR.write_raw(0);
            peripherals.USBD.EPIN[i].MAXCNT.write_raw(0);
            peripherals.USBD.EPOUT[i].PTR.write_raw(0);
            peripherals.USBD.EPOUT[i].MAXCNT.write_raw(0);

            // When first enabled, bulk/interrupt endpoints
            // will return NAK until 0 is written to SIZE.EPOUT[n]
            peripherals.USBD.SIZE.EPOUT[i].write_raw(0);
        }

        self.eps_in = @splat(.{});
        self.eps_out = @splat(.{});
        self.ep0_state = .{};
    }

    fn ep_writev(
        itf: *usb.DeviceInterface,
        ep_num: usb.types.Endpoint.Num,
        data: []const []const u8,
    ) usb.types.Len {
        const self: *Self = @fieldParentPtr("interface", itf);
        log.debug("ep_writev {t}: ({} bytes) {X} ({s})", .{ ep_num, data[0].len, data[0], data[0] });

        if (data[0].len == 0) {
            if (ep_num == .ep0) peripherals.USBD.TASKS_EP0STATUS.write_raw(1);
            return 0;
        }

        const i = @intFromEnum(ep_num);
        const scratch = &self.bufs_in[i];
        const scratch_cap = @min(self.eps_in[i].max_packet_size, scratch.len);
        var scratch_slice: []align(1) u8 = scratch[0..scratch_cap];

        for (data) |src| {
            const len = @min(src.len, scratch_slice.len);
            @memcpy(scratch_slice[0..len], src[0..len]);
            scratch_slice = scratch_slice[len..];
        }

        const len: usb.types.Len = @intCast(scratch_cap - scratch_slice.len);

        // Prepare DMA transfer
        peripherals.USBD.EPIN[i].PTR.write_raw(@intFromPtr(scratch));
        peripherals.USBD.EPIN[i].MAXCNT.write_raw(len);

        if (ep_num == .ep0) {
            // EPIN0: a short packet (len < max_packet_size) indicates the end of the data
            // stage and must be followed by us responding with an ACK token to an OUT token
            // sent from the host (AKA the status stage)
            // Also handle the case when it's the last packet with size 64
            self.ep0_state.remaining_size -|= len;
            const is_short_packet = len < self.eps_in[0].max_packet_size;
            const is_last_packet = is_short_packet or self.ep0_state.remaining_size == 0;
            if (is_last_packet) {
                peripherals.USBD.SHORTS.write(.{ .EP0DATADONE_EP0STATUS = .Enabled });
            } else {
                peripherals.USBD.SHORTS.write(.{ .EP0DATADONE_EP0STATUS = .Disabled });
            }

            // Saving current frame counter to start the timeout that will trigger
            // status stage if the IN transfer is not acknowledged after a few frames
            self.ep0_state.in_start_frame = peripherals.USBD.FRAMECNTR.read().FRAMECNTR;
            self.ep0_state.in_pending = true;
        }

        // Start DMA
        const was_enabled = cpu.interrupt.is_enabled(.USBD);
        defer if (was_enabled) cpu.interrupt.enable(.USBD);
        peripherals.USBD.TASKS_STARTEPIN[i].write_raw(1);
        while (peripherals.USBD.EVENTS_ENDEPIN[i].raw != 1) {}
        peripherals.USBD.EVENTS_ENDEPIN[i].write_raw(0);

        return len;
    }

    fn ep_readv(
        itf: *usb.DeviceInterface,
        ep_num: usb.types.Endpoint.Num,
        data: []const []u8,
    ) usb.types.Len {
        var total_len: usize = data[0].len;
        for (data[1..]) |d| total_len += d.len;
        log.debug("ep_readv {t}: ({} bytes)", .{ ep_num, total_len });

        const self: *Self = @fieldParentPtr("interface", itf);
        const i = @intFromEnum(ep_num);
        const size = peripherals.USBD.SIZE.EPOUT[i].raw;

        const scratch_buf = &self.bufs_out[i];

        // Prepare DMA transfer
        peripherals.USBD.EPOUT[i].PTR.write_raw(@intFromPtr(scratch_buf));
        peripherals.USBD.EPOUT[i].MAXCNT.write_raw(size);

        // Start DMA
        const was_enabled = cpu.interrupt.is_enabled(.USBD);
        defer if (was_enabled) cpu.interrupt.enable(.USBD);
        peripherals.USBD.TASKS_STARTEPOUT[i].write_raw(1);
        while (peripherals.USBD.EVENTS_ENDEPOUT[i].raw != 1) {}
        peripherals.USBD.EVENTS_ENDEPOUT[i].write_raw(0);

        var scratch_slice: []align(1) u8 = scratch_buf[0..size];

        for (data) |dst| {
            const len = @min(dst.len, scratch_slice.len);
            @memcpy(dst[0..len], scratch_slice[0..len]);
            scratch_slice = scratch_slice[len..];
            if (scratch_slice.len == 0)
                return @intCast(size);
        }

        log.warn("discarding rx data on ep {t}, {} bytes received", .{ ep_num, size });
        return @intCast(size - scratch_slice.len);
    }

    fn ep_listen(
        _: *usb.DeviceInterface,
        ep_num: usb.types.Endpoint.Num,
        len: usb.types.Len,
    ) void {
        log.debug("ep_listen {t}: ({} bytes)", .{ ep_num, len });

        if (ep_num == .ep0) {
            peripherals.USBD.TASKS_EP0RCVOUT.write_raw(1);
        }
    }

    fn ep_open(itf: *usb.DeviceInterface, desc: *const usb.descriptor.Endpoint) void {
        const self: *Self = @fieldParentPtr("interface", itf);
        const ep = desc.endpoint;
        const i = @intFromEnum(ep.num);
        const mask: u32 = @as(u32, 1) << i;
        switch (ep.dir) {
            .In => {
                self.eps_in[i].max_packet_size = desc.max_packet_size.into();
                peripherals.USBD.EPINEN.write_raw(peripherals.USBD.EPINEN.raw | mask);
            },
            .Out => {
                self.eps_out[i].max_packet_size = desc.max_packet_size.into();
                peripherals.USBD.EPOUTEN.write_raw(peripherals.USBD.EPOUTEN.raw | mask);
            },
        }

        const attr = desc.attributes;
        log.debug(
            "ep_open {t} {t}: {{ type: {t}, sync: {t}, usage: {t}, size: {} }}",
            .{ ep.num, ep.dir, attr.transfer_type, attr.synchronisation, attr.usage, desc.max_packet_size.into() },
        );
    }

    /// No-op: the peripheral handles this
    fn set_address(_: *usb.DeviceInterface, _: u7) void {}
};
