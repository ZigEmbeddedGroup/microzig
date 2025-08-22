const std = @import("std");
const enumFromInt = std.meta.intToEnum;

const usb = @import("../usb.zig");
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

pub const Descriptor = extern struct {
    desc1: descriptor.InterfaceAssociation,
    desc2: descriptor.Interface,
    desc3: descriptor.cdc.Header,
    desc4: descriptor.cdc.CallManagement,
    desc5: descriptor.cdc.AbstractControlModel,
    desc6: descriptor.cdc.Union,
    ep_notifi: descriptor.Endpoint,
    desc8: descriptor.Interface,
    ep_out: descriptor.Endpoint,
    ep_in: descriptor.Endpoint,

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

    pub fn config_descriptor(first_interface: u8, string_ids: anytype, endpoints: anytype) Descriptor {
        const endpoint_notifi_size = 8;
        const endpoint_size = 64;
        return .{
            .desc1 = .{
                .first_interface = first_interface,
                .interface_count = 2,
                .function_class = 2,
                .function_subclass = 2,
                .function_protocol = 0,
                .function = 0,
            },
            .desc2 = .{
                .interface_number = first_interface,
                .alternate_setting = 0,
                .num_endpoints = 1,
                .interface_class = 2,
                .interface_subclass = 2,
                .interface_protocol = 0,
                .interface_s = string_ids.name,
            },
            .desc3 = .{ .bcd_cdc = .from(0x0120) },
            .desc4 = .{
                .capabilities = 0,
                .data_interface = first_interface + 1,
            },
            .desc5 = .{ .capabilities = 6 },
            .desc6 = .{
                .master_interface = first_interface,
                .slave_interface_0 = first_interface + 1,
            },
            .ep_notifi = .{
                .endpoint = .in(endpoints.notifi),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = .from(endpoint_notifi_size),
                .interval = 16,
            },
            .desc8 = .{
                .interface_number = first_interface + 1,
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_class = 10,
                .interface_subclass = 0,
                .interface_protocol = 0,
                .interface_s = 0,
            },
            .ep_out = .{
                .endpoint = .out(endpoints.data),
                .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
            .ep_in = .{
                .endpoint = .in(endpoints.data),
                .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
        };
    }

    /// This function is called when the host chooses a configuration that contains this driver.
    pub fn init(controller: usb.DeviceInterface, desc: *const Descriptor) @This() {
        controller.signal_rx_ready(desc.ep_out.endpoint.num, std.math.maxInt(usize));
        return .{
            .line_coding = .init,
            .awaiting_data = false,
            .rx_buf = null,
            .tx_buf = null,
            .ep_in_notif = desc.ep_notifi.endpoint.num,
            .ep_out = desc.ep_out.endpoint.num,
            .ep_in = desc.ep_in.endpoint.num,
        };
    }

    pub fn available(this: *@This()) usize {
        return if (this.rx_buf) |rx| rx.len else 0;
    }

    pub fn read(this: *@This(), controller: usb.DeviceInterface, dst: []u8) usize {
        if (this.rx_buf) |rx| {
            const len = @min(rx.len, dst.len);
            // TODO: please fixme: https://github.com/ZigEmbeddedGroup/microzig/issues/452
            std.mem.copyForwards(u8, dst, rx[0..len]);
            if (len < rx.len)
                this.rx_buf = rx[len..]
            else {
                controller.signal_rx_ready(this.ep_out, std.math.maxInt(usize));
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

    pub fn flush(this: *@This(), controller: usb.DeviceInterface) void {
        if (this.tx_buf) |tx| {
            defer this.tx_buf = null;
            controller.submit_tx_buffer(this.ep_in, tx.ptr);
        }
    }

    pub fn writeAll(this: *@This(), controller: usb.DeviceInterface, data: []const u8) void {
        var offset: usize = 0;
        while (offset < data.len) {
            offset += this.write(data[offset..]);
            // TODO: Interrupt-safe.
            this.flush(controller);
            controller.task();
        }
    }

    pub fn interface_setup(ptr: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
        var this: *@This() = @ptrCast(@alignCast(ptr));

        return if (enumFromInt(
            ManagementRequestType,
            setup.request,
        )) |request| switch (request) {
            .SetLineCoding => usb.ACK,
            .GetLineCoding => {
                const data = std.mem.asBytes(&this.line_coding);
                return data[0..@min(@sizeOf(LineCoding), setup.length)];
            },
            .SetControlLineState => usb.ACK,
            .SendBreak => usb.ACK,
        } else |_| usb.ACK;
    }

    pub fn on_tx_ready(ptr: *@This(), _: usb.DeviceInterface, data: []u8) void {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        this.tx_buf = data;
    }

    pub fn on_data_rx(ptr: *@This(), _: usb.DeviceInterface, data: []const u8) void {
        var this: *@This() = @ptrCast(@alignCast(ptr));
        this.rx_buf = data;
    }
};
