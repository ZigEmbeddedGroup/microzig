const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const EP_Num = usb.types.Endpoint.Num;
const log = std.log.scoped(.usb_cdc);

pub const ManagementRequestType = enum(u8) {
    SetCommFeature = 0x02,
    GetCommFeature = 0x03,
    ClearCommFeature = 0x04,
    SetAuxLineState = 0x10,
    SetHookState = 0x11,
    PulseSetup = 0x12,
    SendPulse = 0x13,
    SetPulseTime = 0x14,
    RingAuxJack = 0x15,
    SetLineCoding = 0x20,
    GetLineCoding = 0x21,
    SetControlLineState = 0x22,
    SendBreak = 0x23,
    SetRingerParams = 0x30,
    GetRingerParams = 0x31,
    SetOperationParams = 0x32,
    GetOperationParams = 0x33,
    SetLineParams = 0x34,
    GetLineParams = 0x35,
    DialDigits = 0x36,
    _,
};

pub const LineCoding = extern struct {
    pub const StopBits = enum(u8) { @"1" = 0, @"1.5" = 1, @"2" = 2, _ };
    pub const Parity = enum(u8) {
        none = 0,
        odd = 1,
        even = 2,
        mark = 3,
        space = 4,
        _,
    };

    bit_rate: usb.types.U32_Le,
    stop_bits: StopBits,
    parity: Parity,
    data_bits: u8,

    pub const init: @This() = .{
        .bit_rate = 115200,
        .stop_bits = 0,
        .parity = 0,
        .data_bits = 8,
    };
};

pub const Descriptor = extern struct {
    const desc = usb.descriptor;

    itf_assoc: desc.InterfaceAssociation,
    itf_notifi: desc.Interface,
    cdc_header: desc.cdc.Header,
    cdc_call_mgmt: desc.cdc.CallManagement,
    cdc_acm: desc.cdc.AbstractControlModel,
    cdc_union: desc.cdc.Union,
    ep_notifi: desc.Endpoint,
    itf_data: desc.Interface,
    ep_out: desc.Endpoint,
    ep_in: desc.Endpoint,

    const Strings = struct {
        itf_notifi: []const u8 = "",
        itf_data: []const u8 = "",
    };

    pub fn create(
        alloc: *usb.DescriptorAllocator,
        max_supported_packet_size: usb.types.Len,
        strings: Strings,
    ) usb.DescriptorCreateResult(@This()) {
        const itf_notifi = alloc.next_itf();
        const itf_data = alloc.next_itf();
        return .{
            .descriptor = .{
                .itf_assoc = .{
                    .first_interface = itf_notifi,
                    .interface_count = 2,
                    .function_class = 2,
                    .function_subclass = 2,
                    .function_protocol = 0,
                    .function = 0,
                },
                .itf_notifi = .{
                    .interface_number = itf_notifi,
                    .alternate_setting = 0,
                    .num_endpoints = 1,
                    .interface_triple = .from(.CDC, .Abstract, .NoneRequired),
                    .interface_s = alloc.string(strings.itf_notifi),
                },
                .cdc_header = .{ .bcd_cdc = .from(1, 20) },
                .cdc_call_mgmt = .{
                    .capabilities = .none,
                    .data_interface = itf_data,
                },
                .cdc_acm = .{
                    .capabilities = .{
                        .comm_feature = false,
                        .send_break = false,
                        // Line coding requests get sent regardless of this bit
                        .line_coding = true,
                        .network_connection = false,
                    },
                },
                .cdc_union = .{
                    .master_interface = itf_notifi,
                    .slave_interface_0 = itf_data,
                },
                .ep_notifi = .interrupt(alloc.next_ep(.In), 8, 16),
                .itf_data = .{
                    .interface_number = itf_data,
                    .alternate_setting = 0,
                    .num_endpoints = 2,
                    .interface_triple = .from(.CDC_Data, .Unused, .NoneRequired),
                    .interface_s = alloc.string(strings.itf_data),
                },
                .ep_out = .bulk(alloc.next_ep(.Out), max_supported_packet_size),
                .ep_in = .bulk(alloc.next_ep(.In), max_supported_packet_size),
            },
            .alloc_bytes = 2 * max_supported_packet_size,
        };
    }
};

pub const handlers: usb.DriverHadlers(@This()) = .{
    .ep_notifi = on_notifi_ready,
    .ep_out = on_rx,
    .ep_in = on_tx_ready,
};

device: *usb.DeviceInterface,
descriptor: *const Descriptor,
line_coding: LineCoding align(4),
notifi_ready: std.atomic.Value(bool),

rx_data: []u8,
rx_seek: usb.types.Len,
rx_end: usb.types.Len,
rx_ready: std.atomic.Value(bool),

tx_data: []u8,
tx_end: usb.types.Len,
tx_ready: std.atomic.Value(bool),

pub fn available(self: *@This()) usb.types.Len {
    return self.rx_end - self.rx_seek;
}

pub fn read(self: *@This(), dst: []u8) usize {
    const len = @min(dst.len, self.rx_end - self.rx_seek);
    @memcpy(dst[0..len], self.rx_data[self.rx_seek..][0..len]);
    self.rx_seek += len;

    if (self.available() > 0) return len;

    // request more data
    if (self.rx_ready.load(.seq_cst)) {
        const ep_out = self.descriptor.ep_out.endpoint.num;
        self.rx_ready.store(false, .seq_cst);
        self.rx_end = self.device.ep_readv(ep_out, &.{self.rx_data});
        self.rx_seek = 0;
        self.device.ep_listen(ep_out, @intCast(self.rx_data.len));
    }

    return len;
}

pub fn write(self: *@This(), data: []const u8) usize {
    const len = @min(self.tx_data.len - self.tx_end, data.len);

    @memcpy(self.tx_data[self.tx_end..][0..len], data[0..len]);
    self.tx_end += @intCast(len);

    if (self.tx_end == self.tx_data.len)
        _ = self.flush();

    return len;
}

/// Returns true if flush operation succeded.
pub fn flush(self: *@This()) bool {
    if (self.tx_end == 0)
        return true;

    if (!self.tx_ready.load(.seq_cst))
        return false;
    self.tx_ready.store(false, .seq_cst);

    assert(self.tx_end == self.device.ep_writev(
        self.descriptor.ep_in.endpoint.num,
        &.{self.tx_data[0..self.tx_end]},
    ));
    self.tx_end = 0;
    return true;
}

pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface, data: []u8) void {
    const len_half = @divExact(data.len, 2);
    assert(len_half == desc.ep_in.max_packet_size.into());
    assert(len_half == desc.ep_out.max_packet_size.into());
    self.* = .{
        .device = device,
        .descriptor = desc,
        .line_coding = .{
            .bit_rate = .from(115200),
            .stop_bits = .@"1",
            .parity = .none,
            .data_bits = 8,
        },
        .notifi_ready = .init(true),

        .rx_data = data[0..len_half],
        .rx_seek = 0,
        .rx_end = 0,
        .rx_ready = .init(false),

        .tx_data = data[len_half..],
        .tx_end = 0,
        .tx_ready = .init(true),
    };
    device.ep_listen(desc.ep_out.endpoint.num, @intCast(self.rx_data.len));
}

pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
    const mgmt_request: ManagementRequestType = @enumFromInt(setup.request);
    log.debug("cdc setup: {any} {} {}", .{ mgmt_request, setup.length.into(), setup.value.into() });

    return switch (mgmt_request) {
        .SetLineCoding => usb.ack, // we should handle data phase somehow to read sent line_coding
        .GetLineCoding => std.mem.asBytes(&self.line_coding),
        .SetControlLineState => blk: {
            // const DTR_BIT = 1;
            // self.is_ready = (setup.value & DTR_BIT) != 0;
            // self.line_state = @intCast(setup.value & 0xFF);
            break :blk usb.ack;
        },
        .SendBreak => usb.ack,
        else => usb.nak,
    };
}

pub fn on_rx(self: *@This(), ep_num: EP_Num) void {
    if (self.rx_ready.load(.seq_cst))
        log.warn("{s}({t}) called before buffer was consumed", .{ "on_rx", ep_num });
    self.rx_ready.store(true, .seq_cst);
}

pub fn on_tx_ready(self: *@This(), ep_num: EP_Num) void {
    if (self.tx_ready.load(.seq_cst))
        log.warn("{s}({t}) called before buffer was consumed", .{ "on_tx_ready", ep_num });
    self.tx_ready.store(true, .seq_cst);
}

pub fn on_notifi_ready(self: *@This(), ep_num: EP_Num) void {
    if (self.notifi_ready.load(.seq_cst))
        log.warn("{s}({t}) called before buffer was consumed", .{ "on_notifi_ready", ep_num });
    self.notifi_ready.store(true, .seq_cst);
}
