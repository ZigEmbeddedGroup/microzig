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

pub const Options = struct {
    max_packet_size: u16,
};

pub fn CdcClassDriver(options: Options) type {
    return struct {
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

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                first_string: u8,
                max_supported_packet_size: usb.types.Len,
            ) @This() {
                const itf_notifi = alloc.next_itf();
                const itf_data = alloc.next_itf();
                return .{
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
                        .interface_s = first_string,
                    },
                    .cdc_header = .{ .bcd_cdc = .from(0x0120) },
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
                    .ep_notifi = .interrupt(alloc.next_ep(.In), 16, 16),
                    .itf_data = .{
                        .interface_number = itf_data,
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_triple = .from(.CDC_Data, .Unused, .NoneRequired),
                        .interface_s = 0,
                    },
                    .ep_out = .bulk(alloc.next_ep(.Out), max_supported_packet_size),
                    .ep_in = .bulk(alloc.next_ep(.In), max_supported_packet_size),
                };
            }
        };

        pub const handlers = .{
            .ep_notifi = "on_notifi_ready",
            .ep_out = "on_rx",
            .ep_in = "on_tx_ready",
        };

        device: *usb.DeviceInterface,
        ep_notifi: EP_Num,
        line_coding: LineCoding align(4),

        /// OUT endpoint on which there is data ready to be read,
        /// or .ep0 when no data is available.
        ep_out: EP_Num,
        rx_data: [options.max_packet_size]u8,
        rx_seek: usb.types.Len,
        rx_end: usb.types.Len,

        /// IN endpoint where data can be sent,
        /// or .ep0 when data is being sent.
        ep_in: EP_Num,
        tx_data: [options.max_packet_size]u8,
        tx_end: usb.types.Len,

        pub fn available(self: *@This()) usb.types.Len {
            return self.rx_end - self.rx_seek;
        }

        pub fn read(self: *@This(), dst: []u8) usize {
            const len = @min(dst.len, self.rx_end - self.rx_seek);
            @memcpy(dst[0..len], self.rx_data[self.rx_seek..][0..len]);
            self.rx_seek += len;

            if (self.available() > 0) return len;

            // request more data
            const ep_out = @atomicLoad(EP_Num, &self.ep_out, .seq_cst);
            if (ep_out != .ep0) {
                self.rx_end = self.device.ep_readv(ep_out, &.{&self.rx_data});
                self.rx_seek = 0;
                @atomicStore(EP_Num, &self.ep_out, .ep0, .seq_cst);
                self.device.ep_listen(ep_out, options.max_packet_size);
            }

            return len;
        }

        pub fn write(self: *@This(), data: []const u8) usize {
            const len = @min(self.tx_data.len - self.tx_end, data.len);

            if (len == 0) return 0;

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

            const ep_in = @atomicLoad(EP_Num, &self.ep_in, .seq_cst);
            if (ep_in == .ep0)
                return false;

            @atomicStore(EP_Num, &self.ep_in, .ep0, .seq_cst);

            assert(self.tx_end == self.device.ep_writev(ep_in, &.{self.tx_data[0..self.tx_end]}));
            self.tx_end = 0;
            return true;
        }

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface) void {
            self.* = .{
                .device = device,
                .ep_notifi = desc.ep_notifi.endpoint.num,
                .line_coding = .{
                    .bit_rate = .from(115200),
                    .stop_bits = .@"1",
                    .parity = .none,
                    .data_bits = 8,
                },

                .ep_out = .ep0,
                .rx_data = undefined,
                .rx_seek = 0,
                .rx_end = 0,

                .ep_in = desc.ep_in.endpoint.num,
                .tx_data = undefined,
                .tx_end = 0,
            };
            device.ep_listen(desc.ep_out.endpoint.num, options.max_packet_size);
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
            assert(.ep0 == @atomicLoad(EP_Num, &self.ep_out, .seq_cst));
            @atomicStore(EP_Num, &self.ep_out, ep_num, .seq_cst);
        }

        pub fn on_tx_ready(self: *@This(), ep_num: EP_Num) void {
            assert(.ep0 == @atomicLoad(EP_Num, &self.ep_in, .seq_cst));
            @atomicStore(EP_Num, &self.ep_in, ep_num, .seq_cst);
        }

        pub fn on_notifi_ready(self: *@This(), ep_num: EP_Num) void {
            assert(.ep0 == @atomicLoad(EP_Num, &self.ep_notifi, .seq_cst));
            @atomicStore(EP_Num, &self.ep_notifi, ep_num, .seq_cst);
        }
    };
}
