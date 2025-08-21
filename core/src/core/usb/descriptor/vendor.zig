const assert = @import("std").debug.assert;
const descriptor = @import("../descriptor.zig");
const types = @import("../types.zig");

/// Not sure what this was supposed to be, but I am keeping it for now.
pub const Vendor = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    desc1: descriptor.Interface,
    desc2: descriptor.Endpoint,
    desc3: descriptor.Endpoint,

    pub fn create(
        interface_number: u8,
        string_index: u8,
        endpoint_out: types.Endpoint.Num,
        endpoint_in: types.Endpoint.Num,
        endpoint_size: u16,
    ) @This() {
        return .{
            .desc1 = .{
                .interface_number = interface_number,
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_class = 0xff,
                .interface_subclass = 0,
                .interface_protocol = 0,
                .interface_s = string_index,
            },
            .desc2 = .{
                .endpoint = .out(endpoint_out),
                .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
            .desc3 = .{
                .endpoint = .in(endpoint_in),
                .attributes = .{ .transfer_type = .Bulk, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
        };
    }

    pub fn serialize(this: *const @This()) *const [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};
