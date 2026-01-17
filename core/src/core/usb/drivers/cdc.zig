const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_cdc);

pub const ManagementRequestType = enum(u8) {
    SetLineCoding = 0x20,
    GetLineCoding = 0x21,
    SetControlLineState = 0x22,
    SendBreak = 0x23,
    _,
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

pub const Options = struct {
    max_packet_size: u16,
};

pub fn CdcClassDriver(options: Options) type {
    return struct {
        pub const Descriptor = extern struct {
            itf_assoc: usb.descriptor.InterfaceAssociation,
            itf_notifi: usb.descriptor.Interface,
            cdc_header: usb.descriptor.cdc.Header,
            cdc_call_mgmt: usb.descriptor.cdc.CallManagement,
            cdc_acm: usb.descriptor.cdc.AbstractControlModel,
            cdc_union: usb.descriptor.cdc.Union,
            ep_notifi: usb.descriptor.Endpoint,
            itf_data: usb.descriptor.Interface,
            ep_out: usb.descriptor.Endpoint,
            ep_in: usb.descriptor.Endpoint,

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
                        .interface_triple = .from(.Cdc, .Abstract, .NoneRequired),
                        .interface_s = first_string,
                    },
                    .cdc_header = .{ .bcd_cdc = .from(0x0120) },
                    .cdc_call_mgmt = .{
                        .capabilities = 0,
                        .data_interface = itf_data,
                    },
                    .cdc_acm = .{ .capabilities = 6 },
                    .cdc_union = .{
                        .master_interface = itf_notifi,
                        .slave_interface_0 = itf_data,
                    },
                    .ep_notifi = .interrupt(alloc.next_ep(.In), 8, 16),
                    .itf_data = .{
                        .interface_number = itf_data,
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_triple = .from(.CdcData, .Unused, .NoneRequired),
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
        ep_notifi: usb.types.Endpoint.Num,
        line_coding: LineCoding align(4),

        /// OUT endpoint on which there is data ready to be read,
        /// or .ep0 when no data is available.
        ep_out: usb.types.Endpoint.Num,
        rx_data: [options.max_packet_size]u8,
        rx_seek: usb.types.Len,
        rx_end: usb.types.Len,

        /// IN endpoint where data can be sent,
        /// or .ep0 when data is being sent.
        ep_in: usb.types.Endpoint.Num,
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
            const ep_out = @atomicLoad(usb.types.Endpoint.Num, &self.ep_out, .seq_cst);
            if (ep_out != .ep0) {
                self.rx_end = self.device.ep_readv(ep_out, &.{&self.rx_data});
                self.rx_seek = 0;
                @atomicStore(usb.types.Endpoint.Num, &self.ep_out, .ep0, .seq_cst);
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

            const ep_in = @atomicLoad(usb.types.Endpoint.Num, &self.ep_in, .seq_cst);
            if (ep_in == .ep0)
                return false;

            @atomicStore(usb.types.Endpoint.Num, &self.ep_in, .ep0, .seq_cst);

            assert(self.tx_end == self.device.ep_writev(ep_in, &.{self.tx_data[0..self.tx_end]}));
            self.tx_end = 0;
            return true;
        }

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface) void {
            self.* = .{
                .device = device,
                .ep_notifi = desc.ep_notifi.endpoint.num,
                .line_coding = .{
                    .bit_rate = 115200,
                    .stop_bits = 0,
                    .parity = 0,
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

        pub fn interface_setup(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            const mgmt_request: ManagementRequestType = @enumFromInt(setup.request);
            log.debug("cdc setup: {t}", .{mgmt_request});

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

        pub fn on_rx(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
            assert(.ep0 == @atomicLoad(usb.types.Endpoint.Num, &self.ep_out, .seq_cst));
            @atomicStore(usb.types.Endpoint.Num, &self.ep_out, ep_num, .seq_cst);
        }

        pub fn on_tx_ready(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
            assert(.ep0 == @atomicLoad(usb.types.Endpoint.Num, &self.ep_in, .seq_cst));
            @atomicStore(usb.types.Endpoint.Num, &self.ep_in, ep_num, .seq_cst);
        }

        pub fn on_notifi_ready(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
            assert(.ep0 == @atomicLoad(usb.types.Endpoint.Num, &self.ep_notifi, .seq_cst));
            @atomicStore(usb.types.Endpoint.Num, &self.ep_notifi, ep_num, .seq_cst);
        }
    };
}
