const std = @import("std");

const usb = @import("../usb.zig");
const bos = usb.utils.BosConfig;
const descriptor = usb.descriptor;
const types = usb.types;

pub const ManagementRequestType = enum(u8) {
    SetLineCoding = 0x20,
    GetLineCoding = 0x21,
    SetControlLineState = 0x22,
    SendBreak = 0x23,
};

pub const LineCoding = extern struct {
    bit_rate: u32 align(1),
    stop_bits: u8,
    parity: u8,
    data_bits: u8,

    pub const init: @This() = .{
        .bit_rate = 115200,
        .stop_bits = 0,
        .parity = 0,
        .data_bits = 8,
    };

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const CdcClassDriver = struct {
    pub const num_interfaces = 2;
    const max_packet_size = 64;

    ep_in_notif: types.Endpoint.Num = .ep0,
    ep_in: types.Endpoint.Num = .ep0,
    ep_out: types.Endpoint.Num = .ep0,
    awaiting_data: bool = false,

    line_coding: LineCoding = .init,

    rx_buf: ?[]const u8 = null,
    tx_buf: ?[]u8 = null,

    pub fn config_descriptor(string_ids: anytype, endpoints: anytype) []const u8 {
        return &usb.templates.DescriptorsConfigTemplates.cdc_descriptor(
            0,
            string_ids.name,
            endpoints.notifi,
            8,
            endpoints.data,
            endpoints.data,
            64,
        );
    }

    /// This function is called when the host chooses a configuration that contains this driver.
    pub fn mount(ptr: *@This(), controller: usb.ControllerInterface) void {
        _ = controller;
        var this: *@This() = @ptrCast(@alignCast(ptr));
        this.line_coding = .init;
        this.awaiting_data = false;
        this.rx_buf = null;
        this.tx_buf = null;
    }

    pub fn available(this: *@This()) usize {
        return if (this.rx_buf) |rx| rx.len else 0;
    }

    pub fn read(this: *@This(), controller: usb.ControllerInterface, dst: []u8) usize {
        if (this.rx_buf) |rx| {
            const len = @min(rx.len, dst.len);
            // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
            std.mem.copyForwards(u8, dst, rx[0..len]);
            if (len < rx.len)
                this.rx_buf = rx[len..]
            else {
                controller.endpoint_rx(this.ep_out, max_packet_size);
                this.rx_buf = null;
            }
            return len;
        } else return 0;
    }

    pub fn write(this: *@This(), src: []const u8) usize {
        if (this.tx_buf) |tx| {
            const len = @min(tx.len, src.len);
            // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
            std.mem.copyForwards(u8, tx, src[0..len]);
            this.tx_buf = tx[len..];
            return len;
        } else return 0;
    }

    pub fn flush(this: *@This(), controller: usb.ControllerInterface) void {
        if (this.tx_buf) |tx| {
            defer this.tx_buf = null;
            controller.submit_tx_buffer(this.ep_in, tx.ptr);
        }
    }

    pub fn writeAll(this: *@This(), controller: usb.ControllerInterface, data: []const u8) void {
        var offset: usize = 0;
        while (offset < data.len) {
            offset += this.write(data[offset..]);
            // TODO: Interrupt-safe.
            this.flush(controller);
            controller.task();
        }
    }

    fn open(ptr: *anyopaque, controller: usb.ControllerInterface, cfg: []const u8) anyerror!usize {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        var curr_cfg = cfg;

        if (bos.try_get_desc_as(descriptor.Interface, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class != @intFromEnum(types.ClassCode.Cdc))
                return error.UnsupportedInterfaceClassType;
            if (desc_itf.interface_subclass != @intFromEnum(descriptor.cdc.SubType.AbstractControlModel))
                return error.UnsupportedInterfaceSubClassType;
        } else return error.ExpectedInterfaceDescriptor;

        curr_cfg = bos.get_desc_next(curr_cfg);

        while (curr_cfg.len > 0 and bos.get_desc_type(curr_cfg) == @intFromEnum(descriptor.Type.CsInterface)) {
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(descriptor.Endpoint, curr_cfg)) |desc_ep| {
            std.debug.assert(desc_ep.endpoint.dir == .In);
            this.ep_in_notif = desc_ep.endpoint.num;
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(descriptor.Interface, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class == @intFromEnum(types.ClassCode.CdcData)) {
                curr_cfg = bos.get_desc_next(curr_cfg);
                for (0..2) |_| {
                    if (bos.try_get_desc_as(descriptor.Endpoint, curr_cfg)) |desc_ep| {
                        switch (desc_ep.endpoint.dir) {
                            .In => this.ep_in = desc_ep.endpoint.num,
                            .Out => this.ep_out = desc_ep.endpoint.num,
                        }
                        this.tx_buf = try controller.endpoint_open(curr_cfg[0..desc_ep.length]);
                        curr_cfg = bos.get_desc_next(curr_cfg);
                    }
                }
            }
        }
        controller.endpoint_rx(this.ep_out, max_packet_size);

        return cfg.len - curr_cfg.len;
    }

    fn class_control(ptr: *anyopaque, controller: usb.ControllerInterface, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        if (stage != .Setup) return true;

        if (std.meta.intToEnum(ManagementRequestType, setup.request)) |request| switch (request) {
            .SetLineCoding => controller.control_ack(),
            .GetLineCoding => controller.control_transfer(std.mem.asBytes(&this.line_coding)[0..@min(@sizeOf(LineCoding), setup.length)]),
            .SetControlLineState => controller.control_ack(),
            .SendBreak => controller.control_ack(),
        } else |_| {}

        return true;
    }

    fn on_tx_ready(ptr: *anyopaque, _: usb.ControllerInterface, data: []u8) void {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        this.tx_buf = data;
    }

    fn on_data_rx(ptr: *anyopaque, _: usb.ControllerInterface, data: []const u8) void {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        this.rx_buf = data;
    }

    pub fn driver(this: *@This()) usb.DriverInterface {
        return .{
            .ptr = this,
            .vtable = comptime &.{
                .open = &open,
                .class_control = &class_control,
                .on_tx_ready = &on_tx_ready,
                .on_data_rx = &on_data_rx,
            },
        };
    }
};
