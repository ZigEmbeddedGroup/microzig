const types = @import("types.zig");
const descriptor = @import("descriptor.zig");
const hid = @import("hid.zig");
const cdc = @import("cdc.zig");

pub const DescriptorsConfigTemplates = struct {
    pub const config_descriptor_len = 9;

    pub fn config_descriptor(config_num: u8, interfaces_num: u8, string_index: u8, total_len: u16, attributes: u8, max_power_ma: u9) []const u8 {
        const desc1 = descriptor.Configuration{
            .total_length = .from(total_len),
            .num_interfaces = interfaces_num,
            .configuration_value = config_num,
            .configuration_s = string_index,
            .attributes = @bitCast(0b01000000 | attributes),
            .max_current = .from_ma(max_power_ma),
        };
        return @ptrCast(&desc1);
    }

    pub const hid_in_out_descriptor_len = 9 + 9 + 7 + 7;

    pub fn hid_in_out_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_out_address: types.Endpoint, endpoint_in_address: types.Endpoint, endpoint_size: u16, endpoint_interval: u8) []const u8 {
        const ret: extern struct { d1: descriptor.Interface, d2: hid.HidDescriptor, d3: descriptor.Endpoint, d4: descriptor.Endpoint } = .{
            .d1 = .{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index },
            .d2 = .{ .bcd_hid = .from(0x0111), .country_code = 0, .num_descriptors = 1, .report_length = .from(report_desc_len) },
            .d3 = .{ .endpoint = endpoint_out_address, .attributes = .{ .transfer_type = types.TransferType.Interrupt, .usage = .data }, .max_packet_size = .from(endpoint_size), .interval = endpoint_interval },
            .d4 = .{ .endpoint = endpoint_in_address, .attributes = .{ .transfer_type = types.TransferType.Interrupt, .usage = .data }, .max_packet_size = .from(endpoint_size), .interval = endpoint_interval },
        };
        return @ptrCast(&ret);
    }
};
