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
    ep_in_notif: types.Endpoint.Num = .ep0,
    ep_in: types.Endpoint.Num = .ep0,
    ep_out: types.Endpoint.Num = .ep0,
    awaiting_data: bool = false,

    line_coding: LineCoding = .init,

    rx_buf: ?[]const u8 = null,
    tx_buf: ?[]u8 = null,

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
    pub fn init(device: usb.DeviceInterface, desc: *const Descriptor) @This() {
        device.signal_rx_ready(desc.ep_out.endpoint.num, std.math.maxInt(usize));
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

    /// On bus reset, this function is called followed by init().
    pub fn deinit(_: *@This()) void {}

    /// How many bytes in rx buffer?
    pub fn available(this: *@This()) usize {
        return if (this.rx_buf) |rx| rx.len else 0;
    }

    /// Read data from rx buffer into dst.
    pub fn read(this: *@This(), device: usb.DeviceInterface, dst: []u8) usize {
        if (this.rx_buf) |rx| {
            const len = @min(rx.len, dst.len);
            std.mem.copyForwards(u8, dst[0..len], rx[0..len]);
            if (len < rx.len)
                this.rx_buf = rx[len..]
            else {
                device.signal_rx_ready(this.ep_out, std.math.maxInt(usize));
                this.rx_buf = null;
            }
            return len;
        } else return 0;
    }

    /// Write data from src into tx buffer.
    pub fn write(this: *@This(), src: []const u8) usize {
        if (this.tx_buf) |tx| {
            const len = @min(tx.len, src.len);
            std.mem.copyForwards(u8, tx[0..len], src[0..len]);
            this.tx_buf = tx[len..];
            return len;
        } else return 0;
    }

    /// Submit tx buffer to the device.
    pub fn flush(this: *@This(), device: usb.DeviceInterface) void {
        if (this.tx_buf) |tx| {
            defer this.tx_buf = null;
            device.submit_tx_buffer(this.ep_in, tx.ptr);
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
    }

    pub fn on_data_rx(this: *@This(), data: []const u8) void {
        this.rx_buf = data;
    }
};
