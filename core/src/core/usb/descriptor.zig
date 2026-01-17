const std = @import("std");
const types = @import("types.zig");
const assert = std.debug.assert;

pub const cdc = @import("descriptor/cdc.zig");
pub const hid = @import("descriptor/hid.zig");

test "descriptor tests" {
    _ = cdc;
    _ = hid;
}

pub const Type = enum(u8) {
    Device = 0x01,
    Configuration = 0x02,
    String = 0x03,
    Interface = 0x04,
    Endpoint = 0x05,
    DeviceQualifier = 0x06,
    InterfaceAssociation = 0x0B,
    BOS = 0x0F,
    CsDevice = 0x21,
    CsConfig = 0x22,
    CsString = 0x23,
    CsInterface = 0x24,
    CsEndpoint = 0x25,
    _,
};

/// Describes a device. This is the most broad description in USB and is
/// typically the first thing the host asks for.
pub const Device = extern struct {
    /// USB Device Qualifier Descriptor
    /// This descriptor is a subset of the DeviceDescriptor
    pub const Qualifier = extern struct {
        comptime {
            assert(@alignOf(@This()) == 1);
            assert(@sizeOf(@This()) == 10);
        }

        length: u8 = @sizeOf(@This()),
        /// Type of this descriptor, must be `DeviceQualifier`.
        descriptor_type: Type = .DeviceQualifier,
        /// Specification version as Binary Coded Decimal
        bcd_usb: types.U16_Le,
        /// Class, subclass and protocol of device.
        device_triple: types.ClassSubclassProtocol,
        /// Maximum unit of data this device can move.
        max_packet_size0: u8,
        /// Number of configurations supported by this device.
        num_configurations: u8,
        /// Reserved for future use; must be 0
        reserved: u8 = 0,
    };

    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 18);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor, must be `Device`.
    descriptor_type: Type = .Device,
    /// Specification version as Binary Coded Decimal
    bcd_usb: types.U16_Le,
    /// Class, subclass and protocol of device.
    device_triple: types.ClassSubclassProtocol,
    /// Maximum length of data this device can move.
    max_packet_size0: u8,
    /// ID of product vendor.
    vendor: types.U16_Le,
    /// ID of product.
    product: types.U16_Le,
    /// Device version number as Binary Coded Decimal.
    bcd_device: types.U16_Le,
    /// Index of manufacturer name in string descriptor table.
    manufacturer_s: u8,
    /// Index of product name in string descriptor table.
    product_s: u8,
    /// Index of serial number in string descriptor table.
    serial_s: u8,
    /// Number of configurations supported by this device.
    num_configurations: u8,

    pub fn qualifier(self: @This()) Qualifier {
        return .{
            .bcd_usb = self.bcd_usb,
            .device_triple = self.device_triple,
            .max_packet_size0 = self.max_packet_size0,
            .num_configurations = self.num_configurations,
        };
    }
};

/// Description of a single available device configuration.
pub const Configuration = extern struct {
    /// Maximum device current consumption.
    pub const MaxCurrent = extern struct {
        multiple_of_2ma: u8,

        pub fn from_ma(ma: u9) @This() {
            return .{ .multiple_of_2ma = @intCast((ma +| 1) >> 1) };
        }
    };

    /// Bit set of device attributes:
    ///
    /// - Bit 7 should be set (indicates that device can be bus powered in USB
    /// 1.0).
    /// - Bit 6 indicates that the device can be self-powered.
    /// - Bit 5 indicates that the device can signal remote wakeup of the host
    /// (like a keyboard).
    /// - The rest are reserved and should be zero.
    pub const Attributes = packed struct(u8) {
        reserved: u5 = 0,
        can_remote_wakeup: bool = false,
        self_powered: bool,
        usb1_bus_powered: bool = true,
    };

    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 9);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor, must be `Configuration`.
    descriptor_type: Type = .Configuration,
    /// Total length of all descriptors in this configuration, concatenated.
    /// This will include this descriptor, plus at least one interface
    /// descriptor, plus each interface descriptor's endpoint descriptors.
    total_length: types.U16_Le,
    /// Number of interface descriptors in this configuration.
    num_interfaces: u8,
    /// Number to use when requesting this configuration via a
    /// `SetConfiguration` request.
    configuration_value: u8,
    /// Index of this configuration's name in the string descriptor table.
    configuration_s: u8,
    /// Bit set of device attributes.
    attributes: Attributes,
    /// Maximum device power consumption in units of 2mA.
    max_current: MaxCurrent,
};

/// Utf-16 encoded string descriptor
pub const String = struct {
    pub const Language = enum(u16) {
        English = 0x0409,
        _,
    };

    data: []const u8,

    pub fn from_lang(lang: Language) @This() {
        const ret: *const extern struct {
            length: u8 = @sizeOf(@This()),
            descriptor_type: Type = .String,
            lang: types.U16_Le,
        } = comptime &.{ .lang = .from(@intFromEnum(lang)) };
        return .{ .data = @ptrCast(ret) };
    }

    pub fn from_str(comptime string: []const u8) @This() {
        @setEvalBranchQuota(10000);
        const encoded: []const u8 = std.mem.sliceAsBytes(std.unicode.utf8ToUtf16LeStringLiteral(string));
        return .{ .data = &[2]u8{ encoded.len + 2, @intFromEnum(Type.String) } ++ encoded };
    }
};

/// Describes an endpoint within an interface
pub const Endpoint = extern struct {
    pub const Attributes = packed struct(u8) {
        pub const Synchronisation = enum(u2) {
            none = 0,
            asynchronous = 1,
            adaptive = 2,
            synchronous = 3,
        };

        pub const Usage = enum(u2) {
            data = 0,
            feedback = 1,
            implicit_feedback = 2,
            reserved = 3,
        };

        transfer_type: types.TransferType,
        synchronisation: Synchronisation = .none,
        usage: Usage,
        reserved: u2 = 0,
    };

    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 7);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor, must be `Endpoint`.
    descriptor_type: Type = .Endpoint,
    /// Address of this endpoint, where the bottom 4 bits give the endpoint
    /// number (0..15) and the top bit distinguishes IN (1) from OUT (0).
    endpoint: types.Endpoint,
    /// Endpoint attributes; the most relevant part is the bottom 2 bits, which
    /// control the transfer type using the values from `TransferType`.
    attributes: Attributes,
    /// Maximum packet size this endpoint can accept/produce.
    max_packet_size: types.U16_Le,
    /// Interval for polling interrupt/isochronous endpoints (which we don't
    /// currently support) in milliseconds.
    interval: u8,

    pub fn control(ep: types.Endpoint, max_packet_size: types.Len) @This() {
        return .{
            .endpoint = ep,
            .attributes = .{ .transfer_type = .Control, .usage = .data },
            .max_packet_size = .from(max_packet_size),
            .interval = 0, // Unused for bulk endpoints
        };
    }

    pub fn bulk(ep: types.Endpoint, max_packet_size: types.Len) @This() {
        return .{
            .endpoint = ep,
            .attributes = .{ .transfer_type = .Bulk, .usage = .data },
            .max_packet_size = .from(max_packet_size),
            .interval = 0, // Unused for bulk endpoints
        };
    }

    pub fn interrupt(ep: types.Endpoint, max_packet_size: types.Len, poll_interval: u8) @This() {
        return .{
            .endpoint = ep,
            .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
            .max_packet_size = .from(max_packet_size),
            .interval = poll_interval,
        };
    }
};

/// Description of an interface within a configuration.
pub const Interface = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 9);
    }

    length: u8 = @sizeOf(@This()),
    /// Type of this descriptor, must be `Interface`.
    descriptor_type: Type = .Interface,
    /// ID of this interface.
    interface_number: u8,
    /// Allows a single `interface_number` to have several alternate interface
    /// settings, where each alternate increments this field. Normally there's
    /// only one, and `alternate_setting` is zero.
    alternate_setting: u8,
    /// Number of endpoint descriptors in this interface.
    num_endpoints: u8,
    /// Interface class, subclass and protocol.
    interface_triple: types.ClassSubclassProtocol,
    /// Index of interface name within string descriptor table.
    interface_s: u8,
};

/// USB interface association descriptor (IAD) allows the device to group interfaces that belong to a function.
pub const InterfaceAssociation = extern struct {
    comptime {
        assert(@alignOf(@This()) == 1);
        assert(@sizeOf(@This()) == 8);
    }

    length: u8 = @sizeOf(@This()),
    // Type of this descriptor, must be `InterfaceAssociation`.
    descriptor_type: Type = .InterfaceAssociation,
    // First interface number of the set of interfaces that follow this
    // descriptor.
    first_interface: u8,
    // The number of interfaces that follow this descriptor that are considered
    // associated.
    interface_count: u8,
    // The interface class used for associated interfaces.
    function_class: u8,
    // The interface subclass used for associated interfaces.
    function_subclass: u8,
    // The interface protocol used for associated interfaces.
    function_protocol: u8,
    // Index of the string descriptor describing the associated interfaces.
    function: u8,
};

pub const BOS = struct {
    pub const Object = union(enum) {};

    data: []const u8,

    pub fn from(objects: []const Object) @This() {
        const data: []const u8 = "";
        const header: []const u8 = @ptrCast(&extern struct {
            length: u8 = @sizeOf(@This()),
            descriptor_type: Type = .BOS,
            total_length: types.U16_Le = .from(@sizeOf(@This()) + data.len),
            num_descriptors: u8 = @intCast(objects.len),
        }{});
        return .{ .data = header ++ data };
    }
};
