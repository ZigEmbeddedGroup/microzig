const types = @import("types.zig");
const descriptor = @import("descriptor.zig");
const hid = @import("hid.zig");
const cdc = @import("cdc.zig");

pub const DescriptorsConfigTemplates = struct {
    pub const config_descriptor_len = 9;

    pub fn config_descriptor(config_num: u8, interfaces_num: u8, string_index: u8, total_len: u16, attributes: u8, max_power_ma: u9) [9]u8 {
        const desc1 = descriptor.Configuration{
            .total_length = .from(total_len),
            .num_interfaces = interfaces_num,
            .configuration_value = config_num,
            .configuration_s = string_index,
            .attributes = @bitCast(0b01000000 | attributes),
            .max_current = .from_ma(max_power_ma),
        };
        return desc1.serialize();
    }

    pub const cdc_descriptor_len = 8 + 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7;

    pub fn cdc_descriptor(interface_number: u8, string_index: u8, endpoint_notifi_address: types.Endpoint, endpoint_notifi_size: u16, endpoint_out_address: types.Endpoint, endpoint_in_address: types.Endpoint, endpoint_size: u16) [cdc_descriptor_len]u8 {
        const desc1 = descriptor.InterfaceAssociation{ .first_interface = interface_number, .interface_count = 2, .function_class = 2, .function_subclass = 2, .function_protocol = 0, .function = 0 };
        const desc2 = descriptor.Interface{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 2, .interface_subclass = 2, .interface_protocol = 0, .interface_s = string_index };
        const desc3 = cdc.CdcHeaderDescriptor{ .descriptor_type = .CsInterface, .descriptor_subtype = .Header, .bcd_cdc = 0x0120 };
        const desc4 = cdc.CdcCallManagementDescriptor{ .descriptor_type = .CsInterface, .descriptor_subtype = .CallManagement, .capabilities = 0, .data_interface = interface_number + 1 };
        const desc5 = cdc.CdcAcmDescriptor{ .descriptor_type = .CsInterface, .descriptor_subtype = .ACM, .capabilities = 6 };
        const desc6 = cdc.CdcUnionDescriptor{ .descriptor_type = .CsInterface, .descriptor_subtype = .Union, .master_interface = interface_number, .slave_interface_0 = interface_number + 1 };
        const desc7 = descriptor.Endpoint{ .endpoint = endpoint_notifi_address, .attributes = .{ .transfer_type = .Interrupt, .usage = .data }, .max_packet_size = .from(endpoint_notifi_size), .interval = 16 };
        const desc8 = descriptor.Interface{ .interface_number = interface_number + 1, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 10, .interface_subclass = 0, .interface_protocol = 0, .interface_s = 0 };
        const desc9 = descriptor.Endpoint{ .endpoint = endpoint_out_address, .attributes = .{ .transfer_type = .Bulk, .usage = .data }, .max_packet_size = .from(endpoint_size), .interval = 0 };
        const desc10 = descriptor.Endpoint{ .endpoint = endpoint_in_address, .attributes = .{ .transfer_type = .Bulk, .usage = .data }, .max_packet_size = .from(endpoint_size), .interval = 0 };
        return desc1.serialize() ++ desc2.serialize() ++ desc3.serialize() ++ desc4.serialize() ++ desc5.serialize() ++ desc6.serialize() ++ desc7.serialize() ++ desc8.serialize() ++ desc9.serialize() ++ desc10.serialize();
    }

    pub const hid_in_descriptor_len = 9 + 9 + 7;

    pub fn hid_in_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_in_address: types.Endpoint, endpoint_size: u16, endpoint_interval: u16) [hid_in_descriptor_len]u8 {
        const desc1 = types.InterfaceDescriptor{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index };
        const desc2 = hid.HidDescriptor{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len };
        const desc3 = types.EndpointDescriptor{ .endpoint = endpoint_in_address, .attributes = @intFromEnum(types.TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval };
        return desc1.serialize() ++ desc2.serialize() ++ desc3.serialize();
    }

    pub const hid_in_out_descriptor_len = 9 + 9 + 7 + 7;

    pub fn hid_in_out_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_out_address: types.Endpoint, endpoint_in_address: types.Endpoint, endpoint_size: u16, endpoint_interval: u16) [hid_in_out_descriptor_len]u8 {
        const desc1 = types.InterfaceDescriptor{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index };
        const desc2 = hid.HidDescriptor{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len };
        const desc3 = types.EndpointDescriptor{ .endpoint = endpoint_out_address, .attributes = @intFromEnum(types.TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval };
        const desc4 = types.EndpointDescriptor{ .endpoint = endpoint_in_address, .attributes = @intFromEnum(types.TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval };
        return desc1.serialize() ++ desc2.serialize() ++ desc3.serialize() ++ desc4.serialize();
    }

    pub const vendor_descriptor_len = 9 + 7 + 7;

    pub fn vendor_descriptor(interface_number: u8, string_index: u8, endpoint_out_address: types.Endpoint, endpoint_in_address: types.Endpoint, endpoint_size: u16) [vendor_descriptor_len]u8 {
        const desc1 = types.InterfaceDescriptor{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 0xff, .interface_subclass = 0, .interface_protocol = 0, .interface_s = string_index };
        const desc2 = types.EndpointDescriptor{ .endpoint = endpoint_out_address, .attributes = @intFromEnum(types.TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 };
        const desc3 = types.EndpointDescriptor{ .endpoint = endpoint_in_address, .attributes = @intFromEnum(types.TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 };
        return desc1.serialize() ++ desc2.serialize() ++ desc3.serialize();
    }
};
