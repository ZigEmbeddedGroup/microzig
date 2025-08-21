const std = @import("std");
const usb = @import("../../usb.zig");

const assert = std.debug.assert;
const descriptor = usb.descriptor;
const Type = descriptor.Type;
const types = usb.types;

pub const SubType = enum(u8) {
    Header = 0x00,
    CallManagement = 0x01,
    AbstractControlModel = 0x02,
    Union = 0x06,
};

pub const Header = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    length: u8 = @sizeOf(@This()),
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: Type = .CsInterface,
    // Subtype of this descriptor, must be `Header`.
    descriptor_subtype: SubType = .Header,
    // USB Class Definitions for Communication Devices Specification release
    // number in binary-coded decimal. Typically 0x01_10.
    bcd_cdc: types.U16Le,

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const CallManagement = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: Type = .CsInterface,
    // Subtype of this descriptor, must be `CallManagement`.
    descriptor_subtype: SubType = .CallManagement,
    // Capabilities. Should be 0x00 for use as a serial device.
    capabilities: u8,
    // Data interface number.
    data_interface: u8,

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const AbstractControlModel = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 4);
    }

    length: u8 = @sizeOf(@This()),
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: Type = .CsInterface,
    // Subtype of this descriptor, must be `ACM`.
    descriptor_subtype: SubType = .AbstractControlModel,
    // Capabilities. Should be 0x02 for use as a serial device.
    capabilities: u8,

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const Union = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: Type = .CsInterface,
    // Subtype of this descriptor, must be `Union`.
    descriptor_subtype: SubType = .Union,
    // The interface number of the communication or data class interface
    // designated as the master or controlling interface for the union.
    master_interface: u8,
    // The interface number of the first slave or associated interface in the
    // union.
    slave_interface_0: u8,

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};

pub const Template = extern struct {
    desc1: descriptor.InterfaceAssociation,
    desc2: descriptor.Interface,
    desc3: Header,
    desc4: CallManagement,
    desc5: AbstractControlModel,
    desc6: Union,
    desc7: descriptor.Endpoint,
    desc8: descriptor.Interface,
    desc9: descriptor.Endpoint,
    desc10: descriptor.Endpoint,

    pub fn create(
        interface_number: u8,
        string_index: u8,
        endpoint_in_notifi: types.Endpoint.Num,
        endpoint_notifi_size: u16,
        endpoint_out: types.Endpoint.Num,
        endpoint_in: types.Endpoint.Num,
        endpoint_size: u16,
    ) @This() {
        const ret: @This() = .{
            .desc1 = .{
                .first_interface = interface_number,
                .interface_count = 2,
                .function_class = 2,
                .function_subclass = 2,
                .function_protocol = 0,
                .function = 0,
            },
            .desc2 = .{
                .interface_number = interface_number,
                .alternate_setting = 0,
                .num_endpoints = 1,
                .interface_class = 2,
                .interface_subclass = 2,
                .interface_protocol = 0,
                .interface_s = string_index,
            },
            .desc3 = .{
                .descriptor_type = .CsInterface,
                .descriptor_subtype = .Header,
                .bcd_cdc = .from(0x0120),
            },
            .desc4 = .{
                .descriptor_type = .CsInterface,
                .descriptor_subtype = .CallManagement,
                .capabilities = 0,
                .data_interface = interface_number + 1,
            },
            .desc5 = .{
                .descriptor_type = .CsInterface,
                .descriptor_subtype = .AbstractControlModel,
                .capabilities = 6,
            },
            .desc6 = .{
                .descriptor_type = .CsInterface,
                .descriptor_subtype = .Union,
                .master_interface = interface_number,
                .slave_interface_0 = interface_number + 1,
            },
            .desc7 = .{
                .endpoint = .in(endpoint_in_notifi),
                .attributes = @intFromEnum(types.TransferType.Interrupt),
                .max_packet_size = .from(endpoint_notifi_size),
                .interval = 16,
            },
            .desc8 = .{
                .interface_number = interface_number + 1,
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_class = 10,
                .interface_subclass = 0,
                .interface_protocol = 0,
                .interface_s = 0,
            },
            .desc9 = .{
                .endpoint = .out(endpoint_out),
                .attributes = @intFromEnum(types.TransferType.Bulk),
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
            .desc10 = .{
                .endpoint = .in(endpoint_in),
                .attributes = @intFromEnum(types.TransferType.Bulk),
                .max_packet_size = .from(endpoint_size),
                .interval = 0,
            },
        };
        @compileLog(ret.serialize());
        @compileLog(ret.serialize(usb.templates.DescriptorsConfigTemplates.cdc_descriptor(interface_number, string_index, endpoint_in_notifi, endpoint_notifi_size, endpoint_out, endpoint_in, endpoint_size)));
        return ret;
    }

    pub fn serialize(this: @This()) [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};
