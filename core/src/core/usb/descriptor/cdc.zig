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
    bcd_cdc: types.Version = .v1_10,
};

pub const CallManagement = extern struct {
    pub const Capabilities = packed struct(u8) {
        handles_call_mgmt: bool,
        call_mgmt_over_data: bool,
        reserved: u6 = 0,

        pub const none: @This() = .{
            .handles_call_mgmt = false,
            .call_mgmt_over_data = false,
        };
    };

    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    length: u8 = @sizeOf(@This()),
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: Type = .CsInterface,
    // Subtype of this descriptor, must be `CallManagement`.
    descriptor_subtype: SubType = .CallManagement,
    // Capabilities. Should be 0x00 for use as a serial device.
    capabilities: Capabilities,
    // Data interface number.
    data_interface: u8,
};

pub const AbstractControlModel = extern struct {
    pub const Capabilities = packed struct(u8) {
        /// Device supports the request combination of Set_Comm_Feature,
        /// Clear_Comm_Feature, and Get_Comm_Feature
        comm_feature: bool,
        /// Device supports the request combination of
        /// Set_Line_Coding, Set_Control_Line_State, Get_Line_Coding,
        /// and the notification Serial_State
        line_coding: bool,
        /// Device supports the request Send_Break
        send_break: bool,
        /// Device supports the notification Network_Connection
        network_connection: bool,
        reserved: u4 = 0,
    };

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
    capabilities: Capabilities,
};

pub const Union = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 5);
    }

    length: u8 = @sizeOf(@This()),
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
};
