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
        ep_out: types.Endpoint.Num,
        line_coding: LineCoding align(4),

        rx: FIFO = .empty,
        tx: FIFO = .empty,

        epin_buf: [options.max_packet_size]u8 = undefined,

        pub fn available(self: *@This()) usize {
            return self.rx.get_readable_len();
        }

        pub fn read(self: *@This(), dst: []u8) usize {
            const read_count = self.rx.read(dst);
            self.prep_out_transaction();
            return read_count;
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
            return len;
        }

        fn prep_out_transaction(self: *@This()) void {
            if (self.rx.get_writable_len() >= options.max_packet_size) {
                // Let endpoint know that we are ready for next packet
                self.device.start_rx(self.ep_out, options.max_packet_size);
            }
        }

        pub fn init(desc: *const Descriptor, device: *usb.DeviceInterface) @This() {
            return .{
                .device = device,
                .ep_notif = desc.ep_notifi.endpoint.num,
                .ep_in = desc.ep_in.endpoint.num,
                .ep_out = desc.ep_out.endpoint.num,
                .line_coding = .{
                    .bit_rate = 115200,
                    .stop_bits = 0,
                    .parity = 0,
                    .data_bits = 8,
                },
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

        pub fn transfer(self: *@This(), ep: types.Endpoint, data: []u8) void {
            if (ep == types.Endpoint.out(self.ep_out)) {
                self.rx.write(data) catch {};
                self.prep_out_transaction();
            }

            if (ep == types.Endpoint.in(self.ep_in)) {
                if (self.write_flush() == 0) {
                    // If there is no data left, a empty packet should be sent if
                    // data len is multiple of EP Packet size and not zero
                    if (self.tx.get_readable_len() == 0 and data.len > 0 and data.len == options.max_packet_size) {
                        self.device.start_tx(self.ep_in, &.{});
                    }
                }
            }
        }
    };
}
