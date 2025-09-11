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
};

pub const Descriptor = extern struct {
    itf_assoc: descriptor.InterfaceAssociation,
    itf_notifi: descriptor.Interface,
    cdc_header: descriptor.cdc.Header,
    cdc_call_mgmt: descriptor.cdc.CallManagement,
    cdc_acm: descriptor.cdc.AbstractControlModel,
    cdc_union: descriptor.cdc.Union,
    ep_notifi: descriptor.Endpoint,
    itf_data: descriptor.Interface,
    ep_out: descriptor.Endpoint,
    ep_in: descriptor.Endpoint,

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const CdcClassDriver = struct {
    ep_in_notif: types.Endpoint.Num,
    ep_in: types.Endpoint.Num,
    ep_out: types.Endpoint.Num,
    awaiting_data: bool,

    line_coding: LineCoding,

    rx_buf: [64]u8,
    rx_seek: u16,
    rx_end: u16,
    tx_buf: ?[]u8,
    tx_end: u16,

    pub fn info(first_interface: u8, string_ids: anytype, endpoints: anytype) usb.DriverInfo(@This(), Descriptor) {
        const endpoint_notifi_size = 8;
        const endpoint_size = 64;
        return .{
            .interface_handlers = &.{
                .{ .itf = first_interface, .func = interface_setup },
                .{ .itf = first_interface + 1, .func = interface_setup },
            },
            .endpoint_in_handlers = &.{
                .{ .ep_num = endpoints.data, .func = on_tx_ready },
            },
            .endpoint_out_handlers = &.{
                .{ .ep_num = endpoints.data, .func = on_data_rx },
            },
            .descriptors = .{
                .itf_assoc = .{
                    .first_interface = first_interface,
                    .interface_count = 2,
                    .function_class = 2,
                    .function_subclass = 2,
                    .function_protocol = 0,
                    .function = 0,
                },
                .itf_notifi = .{
                    .interface_number = first_interface,
                    .alternate_setting = 0,
                    .num_endpoints = 1,
                    .interface_class = 2,
                    .interface_subclass = 2,
                    .interface_protocol = 0,
                    .interface_s = string_ids.name,
                },
                .cdc_header = .{ .bcd_cdc = .from(0x0120) },
                .cdc_call_mgmt = .{
                    .capabilities = 0,
                    .data_interface = first_interface + 1,
                },
                .cdc_acm = .{ .capabilities = 6 },
                .cdc_union = .{
                    .master_interface = first_interface,
                    .slave_interface_0 = first_interface + 1,
                },
                .ep_notifi = .{
                    .endpoint = .in(endpoints.notifi),
                    .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                    .max_packet_size = .from(endpoint_notifi_size),
                    .interval = 16,
                },
                .itf_data = .{
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
            },
        };
    }

    /// This function is called when the host chooses a configuration that contains this driver.
    pub fn init(this: *@This(), device: usb.DeviceInterface, desc: *const Descriptor) void {
        this.* = .{
            .line_coding = .init,
            .awaiting_data = false,
            .rx_buf = @splat(0),
            .rx_seek = 0,
            .rx_end = 0,
            .tx_buf = null,
            .tx_end = 0,
            .ep_in_notif = desc.ep_notifi.endpoint.num,
            .ep_out = desc.ep_out.endpoint.num,
            .ep_in = desc.ep_in.endpoint.num,
        };
        device.listen(desc.ep_out.endpoint.num, this.rx_buf.len);
    }

    /// On bus reset, this function is called followed by init().
    pub fn deinit(_: *@This()) void {}

    /// How many bytes in rx buffer?
    pub fn available(this: *@This()) usize {
        return this.rx_end - this.rx_seek;
    }

    /// Read data from rx buffer into dst.
    pub fn read(this: *@This(), device: usb.DeviceInterface, dst: []u8) usize {
        const len = @min(dst.len, this.rx_end - this.rx_seek);
        @memcpy(dst[0..len], this.rx_buf[this.rx_seek .. this.rx_seek + len]);
        this.rx_seek += len;
        if (len != 0 and this.rx_seek == this.rx_end)
            device.listen(this.ep_out, this.rx_buf.len);
        return len;
    }

    /// Write data from src into tx buffer.
    pub fn write(this: *@This(), src: []const u8) usize {
        if (this.tx_buf) |tx| {
            const avail = tx[this.tx_end..];
            const len = @min(avail.len, src.len);
            std.mem.copyForwards(u8, avail[0..len], src[0..len]);
            this.tx_end += @intCast(len);
            return len;
        } else return 0;
    }

    /// Submit tx buffer to the device.
    pub fn flush(this: *@This(), device: usb.DeviceInterface) void {
        if (this.tx_buf) |tx| {
            if (this.tx_end != device.writev(this.ep_in, &.{tx[0..this.tx_end]}))
                std.debug.panic("not flushed", .{});
            this.tx_buf = null;
            this.tx_end = 0;
        }
    }

    /// Callback for setup packets.
    pub fn interface_setup(this: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
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

    pub fn on_tx_ready(this: *@This(), data: []u8) void {
        this.tx_buf = data;
        this.tx_end = 0;
    }

    pub fn on_data_rx(this: *@This(), data: []const u8) void {
        if (this.rx_seek != this.rx_end)
            std.log.err("RX buffer overwrite", .{});
        this.rx_seek = 0;
        this.rx_end = @intCast(data.len);
        std.mem.copyForwards(u8, this.rx_buf[0..data.len], data);
    }
};
