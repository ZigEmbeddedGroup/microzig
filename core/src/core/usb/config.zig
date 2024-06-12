const std = @import("std");
const buffers = @import("../buffers.zig");

/// USB primitive types
const prim = @import("primitives.zig");
/// USB common descriptors
const desc = @import("descriptors.zig");
/// USB Human Interface Device (HID)
const hid = @import("hid.zig");
/// USB Communications Device Class (CDC)
const cdc = @import("cdc.zig");

const BufferWriter = buffers.BufferWriter;
const TransferType = prim.TransferType;

pub const EndpointConfiguration = struct {
    descriptor: *const desc.EndpointDescriptor,
    /// Index of this endpoint's control register in the `ep_control` array.
    ///
    /// TODO: this can be derived from the endpoint address, perhaps it should
    /// be.
    endpoint_control_index: ?usize,
    /// Index of this endpoint's buffer control register in the
    /// `ep_buffer_control` array.
    ///
    /// TODO this, too, can be derived.
    buffer_control_index: usize,

    /// Index of this endpoint's data buffer in the array of data buffers
    /// allocated from DPRAM. This can be arbitrary, and endpoints can even
    /// share buffers if you're careful.
    data_buffer_index: usize,

    /// Keeps track of which DATA PID (DATA0/DATA1) is expected on this endpoint
    /// next. If `true`, we're expecting `DATA1`, otherwise `DATA0`.
    next_pid_1: bool,

    /// Optional callback for custom OUT endpoints. This function will be called
    /// if the device receives data on the corresponding endpoint.
    callback: ?*const fn (dc: *DeviceConfiguration, data: []const u8) void = null,
};

pub const DescriptorConfig = union(enum) {
    configuration: *const desc.ConfigurationDescriptor,
    endpoint: *const desc.EndpointDescriptor,
    interface: *const desc.InterfaceDescriptor,
    interface_association: *const desc.InterfaceAssociationDescriptor,
    hid: *const HidDescriptorConfig,
    cdc: *const CdcDescriptorConfig,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const HidDescriptorConfig = union(enum) {
    hid: *const hid.HidDescriptor,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const CdcDescriptorConfig = union(enum) {
    cdc_header: *const cdc.CdcHeaderDescriptor,
    cdc_call_management: *const cdc.CdcCallManagementDescriptor,
    cdc_acm: *const cdc.CdcAcmDescriptor,
    cdc_union: *const cdc.CdcUnionDescriptor,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const DescriptorsConfigTemplates = struct {
    pub const config_descriptor_len = 9;

    pub fn config_descriptor(config_num: u8, interfaces_num: u8, string_index: u8, total_len: u16, attributes: u8, max_power_ma: u9) [1]DescriptorConfig {
        return [1]DescriptorConfig {
            .{ .configuration = &.{ .total_length = total_len, .num_interfaces = interfaces_num, .configuration_value = config_num, .configuration_s = string_index, .attributes = 0b01000000 | attributes, .max_power = max_power_ma/2 } }
        };
    }

    pub const cdc_descriptor_len = 8 + 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7;

    pub fn cdc_descriptor(interface_number: u8, string_index: u8, endpoint_notifi_address: u8, endpoint_notifi_size: u16, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16) [10]DescriptorConfig {
        return [10]DescriptorConfig {
            .{ .interface_association = &.{ .first_interface = interface_number, .interface_count = 2, .function_class = 2, .function_subclass = 2, .function_protocol = 0, .function = 0 } },
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 2, .interface_subclass = 2, .interface_protocol = 0, .interface_s = string_index } },
            .{ .cdc = &.{ .cdc_header = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .Header, .bcd_cdc = 0x0120 } } },
            .{ .cdc = &.{ .cdc_call_management = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .CallManagement, .capabilities = 0, .data_interface = interface_number + 1 } } },
            .{ .cdc = &.{ .cdc_acm = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .ACM, .capabilities = 6 } } },
            .{ .cdc = &.{ .cdc_union = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .Union, .master_interface = interface_number, .slave_interface_0 = interface_number + 1 } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_notifi_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_notifi_size, .interval = 16 } },
            .{ .interface = &.{ .interface_number = interface_number + 1, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 10, .interface_subclass = 0, .interface_protocol = 0, .interface_s = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
        };
    }

    pub const hid_in_descriptor_len = 9 + 9 + 7;

    pub fn hid_in_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_in_address: u8, endpoint_size: u16, endpoint_interval: u16) [3]DescriptorConfig {
        return [3]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index } },
            .{ .hid = &.{ .hid = &.{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
        };
    }

    pub const hid_inout_descriptor_len = 9 + 9 + 7 + 7;

    pub fn hid_inout_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16, endpoint_interval: u16) [4]DescriptorConfig {
        return [4]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index } },
            .{ .hid = &.{ .hid = &.{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
        };
    }

    pub const vendor_descriptor_len = 9 + 7 + 7;

    pub fn vendor_descriptor(interface_number: u8, string_index: u8, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16) [3]DescriptorConfig {
        return [3]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 0xff, .interface_subclass = 0, .interface_protocol = 0, .interface_s = string_index } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
        };
    }
};

pub const ConfigUtils = struct {
    /// Get endpoint descriptor from array of configuration descriptors by endpoint address
    pub fn get_enpoint_descriptor(comptime endpoint_address: u8, comptime N: usize, array: [N]DescriptorConfig) *const desc.EndpointDescriptor {
        for (array) |config| {
            switch (config) {
                .endpoint => |endpoint| {
                    if (endpoint.endpoint_address == endpoint_address) return endpoint;
                },
                else => {}
            }
        }
        @compileError("Can't find endpoint descriptor");
    }

    /// Convert an utf8 into an utf16 (little endian) string
    pub fn utf8ToUtf16Le(comptime s: []const u8) [s.len << 1]u8 {
        const l = s.len << 1;
        var ret: [l]u8 = .{0} ** l;
        var i: usize = 0;
        while (i < s.len) : (i += 1) {
            ret[i << 1] = s[i];
        }
        return ret;
    }
};

pub const DeviceConfiguration = struct {
    device_descriptor: *const desc.DeviceDescriptor,
    config_descriptors: []const DescriptorConfig,
    lang_descriptor: []const u8,
    descriptor_strings: []const []const u8,
    hid: ?struct {
        report_descriptor: []const u8,
    } = null,
    endpoints: [4]*EndpointConfiguration,
};

test "utf8 to utf16" {
    try std.testing.expectEqualSlices(u8, "M\x00y\x00 \x00V\x00e\x00n\x00d\x00o\x00r\x00", &ConfigUtils.utf8Toutf16Le("My Vendor"));
    try std.testing.expectEqualSlices(u8, "R\x00a\x00s\x00p\x00b\x00e\x00r\x00r\x00y\x00 \x00P\x00i\x00", &ConfigUtils.utf8Toutf16Le("Raspberry Pi"));
}
