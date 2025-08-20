const std = @import("std");

const usb = @import("../usb.zig");
const types = usb.types;

const DescType = types.DescType;
const bos = usb.utils.BosConfig;

pub const DescSubType = enum(u8) {
    Header = 0x00,
    CallManagement = 0x01,
    ACM = 0x02,
    Union = 0x06,

    pub fn from_u16(v: u16) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const CdcManagementRequestType = enum(u8) {
    SetLineCoding = 0x20,
    GetLineCoding = 0x21,
    SetControlLineState = 0x22,
    SendBreak = 0x23,
};

pub const CdcCommSubClassType = enum(u8) {
    AbstractControlModel = 2,
};

pub const CdcHeaderDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `Header`.
    descriptor_subtype: DescSubType = DescSubType.Header,
    // USB Class Definitions for Communication Devices Specification release
    // number in binary-coded decimal. Typically 0x01_10.
    bcd_cdc: u16 align(1),

    pub fn serialize(this: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(this.descriptor_type);
        out[2] = @intFromEnum(this.descriptor_subtype);
        out[3] = @intCast(this.bcd_cdc & 0xff);
        out[4] = @intCast((this.bcd_cdc >> 8) & 0xff);
        return out;
    }
};

pub const CdcCallManagementDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `CallManagement`.
    descriptor_subtype: DescSubType = DescSubType.CallManagement,
    // Capabilities. Should be 0x00 for use as a serial device.
    capabilities: u8,
    // Data interface number.
    data_interface: u8,

    pub fn serialize(this: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(this.descriptor_type);
        out[2] = @intFromEnum(this.descriptor_subtype);
        out[3] = this.capabilities;
        out[4] = this.data_interface;
        return out;
    }
};

pub const CdcAcmDescriptor = extern struct {
    length: u8 = 4,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `ACM`.
    descriptor_subtype: DescSubType = DescSubType.ACM,
    // Capabilities. Should be 0x02 for use as a serial device.
    capabilities: u8,

    pub fn serialize(this: *const @This()) [4]u8 {
        var out: [4]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(this.descriptor_type);
        out[2] = @intFromEnum(this.descriptor_subtype);
        out[3] = this.capabilities;
        return out;
    }
};

pub const CdcUnionDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `Union`.
    descriptor_subtype: DescSubType = DescSubType.Union,
    // The interface number of the communication or data class interface
    // designated as the master or controlling interface for the union.
    master_interface: u8,
    // The interface number of the first slave or associated interface in the
    // union.
    slave_interface_0: u8,

    pub fn serialize(this: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(this.descriptor_type);
        out[2] = @intFromEnum(this.descriptor_subtype);
        out[3] = this.master_interface;
        out[4] = this.slave_interface_0;
        return out;
    }
};

pub const CdcLineCoding = extern struct {
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
};

pub const CdcClassDriver = struct {
    const max_packet_size = 64;
    const fifo = std.fifo.LinearFifo(
        u8,
        std.fifo.LinearFifoBufferType{ .Static = max_packet_size },
    );

    ep_in_notif: types.Endpoint.Num = .ep0,
    ep_in: types.Endpoint.Num = .ep0,
    ep_out: types.Endpoint.Num = .ep0,
    awaiting_data: bool = false,

    line_coding: CdcLineCoding = .init,

    rx_buf: ?[]const u8 = null,
    tx_buf: ?[]u8 = null,

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

        if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class != @intFromEnum(types.ClassCode.Cdc))
                return error.UnsupportedInterfaceClassType;
            if (desc_itf.interface_subclass != @intFromEnum(CdcCommSubClassType.AbstractControlModel))
                return error.UnsupportedInterfaceSubClassType;
        } else return error.ExpectedInterfaceDescriptor;

        curr_cfg = bos.get_desc_next(curr_cfg);

        while (curr_cfg.len > 0 and bos.get_desc_type(curr_cfg) == @intFromEnum(DescType.CsInterface)) {
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
            std.debug.assert(desc_ep.endpoint.dir == .In);
            this.ep_in_notif = desc_ep.endpoint.num;
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class == @intFromEnum(types.ClassCode.CdcData)) {
                curr_cfg = bos.get_desc_next(curr_cfg);
                for (0..2) |_| {
                    if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
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

        if (std.meta.intToEnum(CdcManagementRequestType, setup.request)) |request| switch (request) {
            .SetLineCoding => controller.control_ack(),
            .GetLineCoding => controller.control_transfer(std.mem.asBytes(&this.line_coding)[0..@min(@sizeOf(CdcLineCoding), setup.length)]),
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
