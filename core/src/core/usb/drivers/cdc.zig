const std = @import("std");
const usb = @import("../../usb.zig");
const descriptor = usb.descriptor;
const types = usb.types;

const utilities = @import("../../../utilities.zig");

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

pub const Options = struct {
    max_packet_size: u16,
};

pub fn CdcClassDriver(options: Options) type {
    const FIFO = utilities.CircularBuffer(u8, options.max_packet_size);

    return struct {
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

            pub fn create(
                first_interface: u8,
                first_string: u8,
                first_endpoint_in: u4,
                first_endpoint_out: u4,
            ) @This() {
                const endpoint_notifi_size = 8;
                return .{
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
                        .interface_s = first_string,
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
                        .endpoint = .in(@enumFromInt(first_endpoint_in)),
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
                        .endpoint = .out(@enumFromInt(first_endpoint_out)),
                        .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                        .max_packet_size = .from(options.max_packet_size),
                        .interval = 0,
                    },
                    .ep_in = .{
                        .endpoint = .in(@enumFromInt(first_endpoint_in + 1)),
                        .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                        .max_packet_size = .from(options.max_packet_size),
                        .interval = 0,
                    },
                };
            }
        };

        device: *usb.DeviceInterface,
        ep_notif: types.Endpoint.Num,
        ep_in: types.Endpoint.Num,
        line_coding: LineCoding align(4),

        /// OUT endpoint on which there is data ready to be read,
        /// or .ep0 when no data is available.
        ep_out: types.Endpoint.Num,
        rx_data: [options.max_packet_size]u8,
        rx_seek: types.Len,
        rx_end: types.Len,

        tx: FIFO,

        last_len: types.Len,

        epin_buf: [options.max_packet_size]u8 = undefined,

        pub fn available(self: *@This()) usize {
            return self.rx.get_readable_len();
        }

        pub fn read(self: *@This(), dst: []u8) usize {
            const len = @min(dst.len, self.rx_end - self.rx_seek);
            @memcpy(dst[0..len], self.rx_data[self.rx_seek..][0..len]);
            self.rx_seek += len;

            if (self.rx_seek != self.rx_end) return len;

            // request more data
            const ep_out = @atomicLoad(types.Endpoint.Num, &self.ep_out, .acquire);
            if (ep_out != .ep0) {
                self.rx_end = self.device.ep_readv(ep_out, &.{&self.rx_data});
                self.rx_seek = 0;
                self.device.ep_listen(ep_out, options.max_packet_size);
            }

            return len;
        }

        pub fn write(self: *@This(), data: []const u8) []const u8 {
            const write_count = @min(self.tx.get_writable_len(), data.len);

            if (write_count > 0) {
                self.tx.write_assume_capacity(data[0..write_count]);
            } else {
                return data[0..];
            }

            if (self.tx.get_writable_len() == 0) {
                _ = self.write_flush();
            }

            return data[write_count..];
        }

        pub fn write_flush(self: *@This()) usize {
            if (self.tx.get_readable_len() == 0) {
                return 0;
            }
            const len = self.tx.read(&self.epin_buf);
            self.device.start_tx(self.ep_in, self.epin_buf[0..len]);
            self.last_len = @intCast(len);
            return len;
        }

        pub fn init(desc: *const Descriptor, device: *usb.DeviceInterface) @This() {
            defer device.ep_listen(desc.ep_out.endpoint.num, options.max_packet_size);
            return .{
                .device = device,
                .ep_notif = desc.ep_notifi.endpoint.num,
                .ep_in = desc.ep_in.endpoint.num,
                .line_coding = .{
                    .bit_rate = 115200,
                    .stop_bits = 0,
                    .parity = 0,
                    .data_bits = 8,
                },

                .rx_data = undefined,
                .rx_seek = 0,
                .rx_end = 0,
                .ep_out = .ep0,

                .tx = .empty,
                .last_len = 0,
            };
        }

        pub fn class_control(self: *@This(), stage: types.ControlStage, setup: *const types.SetupPacket) ?[]const u8 {
            if (std.meta.intToEnum(ManagementRequestType, setup.request)) |request| {
                if (stage == .Setup) switch (request) {
                    .SetLineCoding => return usb.ack, // HACK, we should handle data phase somehow to read sent line_coding
                    .GetLineCoding => return std.mem.asBytes(&self.line_coding),
                    .SetControlLineState => {
                        // const DTR_BIT = 1;
                        // self.is_ready = (setup.value & DTR_BIT) != 0;
                        // self.line_state = @intCast(setup.value & 0xFF);
                        return usb.ack;
                    },
                    .SendBreak => return usb.ack,
                };
            } else |_| {}

            return usb.nak;
        }

        pub fn on_rx(self: *@This(), ep_num: types.Endpoint.Num) void {
            @atomicStore(types.Endpoint.Num, &self.ep_out, ep_num, .release);
        }

        pub fn on_tx_ready(self: *@This(), ep_num: types.Endpoint.Num) void {
            if (ep_num != self.ep_in) return;

            if (self.write_flush() == 0) {
                // If there is no data left, a empty packet should be sent if
                // data len is multiple of EP Packet size and not zero
                if (self.tx.get_readable_len() == 0 and self.last_len == options.max_packet_size) {
                    self.device.start_tx(self.ep_in, usb.ack);
                    self.last_len = 0;
                }
            }
        }
    };
}
