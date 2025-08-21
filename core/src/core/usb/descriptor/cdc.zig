const assert = @import("std").debug.assert;
const Type = @import("../descriptor.zig").Type;
const types = @import("../types.zig");

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

    pub fn serialize(this: *const @This()) *const [@sizeOf(@This())]u8 {
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

    pub fn serialize(this: *const @This()) *const [@sizeOf(@This())]u8 {
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
    // Subtype of this descriptor, must be `AbstractControlModel`.
    descriptor_subtype: SubType = .AbstractControlModel,
    // Capabilities. Should be 0x02 for use as a serial device.
    capabilities: u8,

    pub fn serialize(this: *const @This()) *const [@sizeOf(@This())]u8 {
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

    pub fn serialize(this: *const @This()) *const [@sizeOf(@This())]u8 {
        return @bitCast(this);
    }
};
