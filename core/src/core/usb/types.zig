const std = @import("std");
const assert = std.debug.assert;

pub const DescType = enum(u8) {
    Device = 0x01,
    Config = 0x02,
    String = 0x03,
    Interface = 0x04,
    Endpoint = 0x05,
    DeviceQualifier = 0x06,
    InterfaceAssociation = 0x0b,
    CsDevice = 0x21,
    CsConfig = 0x22,
    CsString = 0x23,
    CsInterface = 0x24,
    CsEndpoint = 0x25,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const ClassCode = enum(u8) {
    Unspecified = 0x00,
    Audio = 0x01,
    Cdc = 0x02,
    Hid = 0x03,
    Physical = 0x05,
    Image = 0x06,
    Printer = 0x07,
    MassStorage = 0x08,
    Hub = 0x09,
    CdcData = 0x0A,
    SmartCard = 0x0B,
    ContentSecurity = 0x0D,
    Video = 0x0E,
    PersonalHealthcare = 0x0F,
    AudioVideoDevice = 0x10,
    BillboardDevice = 0x11,
    USBTypeCBridge = 0x12,
    USBBulkDisplayProtocol = 0x13,
    MCTPoverUSBProtocolEndpoint = 0x14,
    I3C = 0x3C,
    DiagnosticDevice = 0xDC,
    WirelessController = 0xE0,
    Miscellaneous = 0xEF,
    ApplicationSpecific = 0xFE,
    VendorSpecific = 0xFF,
};

/// Version of the device descriptor / USB protocol, in binary-coded
/// decimal. This is typically `0x01_10` for USB 1.1.
pub const BcdUsb = extern struct {
    lo: u8,
    hi: u8,

    pub const v1_1: @This() = .{ .hi = 1, .lo = 1 };
    pub const v2_0: @This() = .{ .hi = 2, .lo = 0 };
};

pub const DeviceTriple = extern struct {
    /// Class of device, giving a broad functional area.
    class: ClassCode,
    /// Subclass of device, refining the class.
    subclass: u8,
    /// Protocol within the subclass.
    protocol: u8,
};

/// Types of transfer that can be indicated by the `attributes` field on `EndpointDescriptor`.
pub const TransferType = enum(u2) {
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }

    pub inline fn as_number(self: @This()) u2 {
        return @intFromEnum(self);
    }
};

pub const ControlStage = enum {
    Idle,
    Setup,
    Data,
    Ack,
};

/// The types of USB SETUP requests that we understand.
pub const SetupRequest = enum(u8) {
    SetFeature = 0x03,
    SetAddress = 0x05,
    GetDescriptor = 0x06,
    SetConfiguration = 0x09,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const FeatureSelector = enum(u8) {
    EndpointHalt = 0x00,
    DeviceRemoteWakeup = 0x01,
    TestMode = 0x02,
    // The remaining features only apply to OTG devices.

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

/// USB deals in two different transfer directions, called OUT (host-to-device)
/// and IN (device-to-host). In the vast majority of cases, OUT is represented
/// by a 0 byte, and IN by an `0x80` byte.
pub const Dir = enum(u1) {
    Out = 0,
    In = 1,
};

pub const Endpoint = packed struct(u8) {
    // There are up to 15 endpoints for eqch direction.
    pub const Num = enum(u4) {
        ep0 = 0,
        ep1,
        ep2,
        ep3,
        ep4,
        ep5,
        ep6,
        ep7,
        ep8,
        ep9,
        ep10,
        ep11,
        ep12,
        ep13,
        ep14,
        ep15,

        pub fn from_int(int: u4) @This() {
            return @enumFromInt(int);
        }

        pub fn to_int(this: @This()) u4 {
            return @intFromEnum(this);
        }
    };

    num: Num,
    _padding: u3 = 0,
    dir: Dir,

    pub inline fn to_address(this: @This()) u8 {
        return @bitCast(this);
    }

    pub inline fn from_address(addr: u8) @This() {
        return @bitCast(addr & 0x8F);
    }

    pub inline fn out(num: Num) @This() {
        return .{ .num = num, .dir = .Out };
    }

    pub inline fn in(num: Num) @This() {
        return .{ .num = num, .dir = .In };
    }
};

pub const RequestType = packed struct(u8) {
    recipient: Recipient,
    type: Type,
    direction: Dir,

    const Type = enum(u2) {
        Standard,
        Class,
        Vendor,
        Other,
    };

    /// RequestType is created from raw bytes using std.mem.bytesToValue, we need to support all potential values if we don't want to crash such conversion
    const Recipient = enum(u5) {
        Device,
        Interface,
        Endpoint,
        Other,
        Reserved1,
        Reserved2,
        Reserved3,
        Reserved4,
        Reserved5,
        Reserved6,
        Reserved7,
        Reserved8,
        Reserved9,
        Reserved10,
        Reserved11,
        Reserved12,
        Reserved13,
        Reserved14,
        Reserved15,
        Reserved16,
        Reserved17,
        Reserved18,
        Reserved19,
        Reserved20,
        Reserved21,
        Reserved22,
        Reserved23,
        Reserved24,
        Reserved25,
        Reserved26,
        Reserved27,
        Reserved28,
    };
};

/// Layout of an 8-byte USB SETUP packet.
pub const SetupPacket = extern struct {
    /// Request metadata: recipient, type, direction.
    request_type: RequestType,
    /// Request. Standard setup requests are in the `SetupRequest` enum.
    /// Devices can extend this with additional types as long as they don't
    /// conflict.
    request: u8,
    /// A simple argument of up to 16 bits, specific to the request.
    value: u16,
    /// Not used in the requests we support.
    index: u16,
    /// If data will be transferred after this request (in the direction given
    /// by `request_type`), this gives the number of bytes (OUT) or maximum
    /// number of bytes (IN).
    length: u16,
};

/// Describes an endpoint within an interface
pub const EndpointDescriptor = extern struct {
    pub const const_descriptor_type = DescType.Endpoint;

    length: u8 = 7,
    /// Type of this descriptor, must be `Endpoint`.
    descriptor_type: DescType = const_descriptor_type,
    /// Address of this endpoint, where the bottom 4 bits give the endpoint
    /// number (0..15) and the top bit distinguishes IN (1) from OUT (0).
    endpoint: Endpoint,
    /// Endpoint attributes; the most relevant part is the bottom 2 bits, which
    /// control the transfer type using the values from `TransferType`.
    attributes: u8,
    /// Maximum packet size this endpoint can accept/produce.
    max_packet_size: u16 align(1),
    /// Interval for polling interrupt/isochronous endpoints (which we don't
    /// currently support) in milliseconds.
    interval: u8,

    pub fn serialize(self: *const @This()) [7]u8 {
        var out: [7]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = self.endpoint.to_address();
        out[3] = self.attributes;
        out[4] = @intCast(self.max_packet_size & 0xff);
        out[5] = @intCast((self.max_packet_size >> 8) & 0xff);
        out[6] = self.interval;
        return out;
    }
};

/// Description of an interface within a configuration.
pub const InterfaceDescriptor = extern struct {
    pub const const_descriptor_type = DescType.Interface;

    length: u8 = 9,
    /// Type of this descriptor, must be `Interface`.
    descriptor_type: DescType = const_descriptor_type,
    /// ID of this interface.
    interface_number: u8,
    /// Allows a single `interface_number` to have several alternate interface
    /// settings, where each alternate increments this field. Normally there's
    /// only one, and `alternate_setting` is zero.
    alternate_setting: u8,
    /// Number of endpoint descriptors in this interface.
    num_endpoints: u8,
    /// Interface class code, distinguishing the type of interface.
    interface_class: u8,
    /// Interface subclass code, refining the class of interface.
    interface_subclass: u8,
    /// Protocol within the interface class/subclass.
    interface_protocol: u8,
    /// Index of interface name within string descriptor table.
    interface_s: u8,

    pub fn serialize(self: *const @This()) [9]u8 {
        var out: [9]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = self.interface_number;
        out[3] = self.alternate_setting;
        out[4] = self.num_endpoints;
        out[5] = self.interface_class;
        out[6] = self.interface_subclass;
        out[7] = self.interface_protocol;
        out[8] = self.interface_s;
        return out;
    }
};

/// USB interface association descriptor (IAD) allows the device to group interfaces that belong to a function.
pub const InterfaceAssociationDescriptor = extern struct {
    pub const const_descriptor_type = DescType.InterfaceAssociation;

    length: u8 = 8,
    // Type of this descriptor, must be `InterfaceAssociation`.
    descriptor_type: DescType = const_descriptor_type,
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

    pub fn serialize(self: *const @This()) [8]u8 {
        var out: [8]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = self.first_interface;
        out[3] = self.interface_count;
        out[4] = self.function_class;
        out[5] = self.function_subclass;
        out[6] = self.function_protocol;
        out[7] = self.function;
        return out;
    }
};

/// Description of a single available device configuration.
pub const ConfigurationDescriptor = extern struct {
    pub const const_descriptor_type = DescType.Config;

    length: u8 = 9,
    /// Type of this descriptor, must be `Config`.
    descriptor_type: DescType = const_descriptor_type,
    /// Total length of all descriptors in this configuration, concatenated.
    /// This will include this descriptor, plus at least one interface
    /// descriptor, plus each interface descriptor's endpoint descriptors.
    total_length: u16 align(1),
    /// Number of interface descriptors in this configuration.
    num_interfaces: u8,
    /// Number to use when requesting this configuration via a
    /// `SetConfiguration` request.
    configuration_value: u8,
    /// Index of this configuration's name in the string descriptor table.
    configuration_s: u8,
    /// Bit set of device attributes:
    ///
    /// - Bit 7 should be set (indicates that device can be bus powered in USB
    /// 1.0).
    /// - Bit 6 indicates that the device can be self-powered.
    /// - Bit 5 indicates that the device can signal remote wakeup of the host
    /// (like a keyboard).
    /// - The rest are reserved and should be zero.
    attributes: u8,
    /// Maximum device power consumption in units of 2mA.
    max_power: u8,

    pub fn serialize(self: *const @This()) [9]u8 {
        var out: [9]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intCast(self.total_length & 0xff);
        out[3] = @intCast((self.total_length >> 8) & 0xff);
        out[4] = self.num_interfaces;
        out[5] = self.configuration_value;
        out[6] = self.configuration_s;
        out[7] = self.attributes;
        out[8] = self.max_power;
        return out;
    }
};

/// Describes a device. This is the most broad description in USB and is
/// typically the first thing the host asks for.
pub const DeviceDescriptor = extern struct {
    length: u8 = 18,
    /// Type of this descriptor, must be `Device`.
    descriptor_type: DescType = .Device,
    bcd_usb: BcdUsb,
    device_triple: DeviceTriple,
    /// Maximum unit of data this device can move.
    max_packet_size0: u8,
    /// ID of product vendor.
    vendor: u16 align(1),
    /// ID of product.
    product: u16 align(1),
    /// Device version number, as BCD again.
    bcd_device: u16 align(1),
    /// Index of manufacturer name in string descriptor table.
    manufacturer_s: u8,
    /// Index of product name in string descriptor table.
    product_s: u8,
    /// Index of serial number in string descriptor table.
    serial_s: u8,
    /// Number of configurations supported by this device.
    num_configurations: u8,

    pub fn serialize(self: *const @This()) [18]u8 {
        var out: [18]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = self.bcd_usb.lo;
        out[3] = self.bcd_usb.hi;
        out[4] = @intFromEnum(self.device_triple.class);
        out[5] = self.device_triple.subclass;
        out[6] = self.device_triple.protocol;
        out[7] = self.max_packet_size0;
        out[8] = @intCast(self.vendor & 0xff);
        out[9] = @intCast((self.vendor >> 8) & 0xff);
        out[10] = @intCast(self.product & 0xff);
        out[11] = @intCast((self.product >> 8) & 0xff);
        out[12] = @intCast(self.bcd_device & 0xff);
        out[13] = @intCast((self.bcd_device >> 8) & 0xff);
        out[14] = self.manufacturer_s;
        out[15] = self.product_s;
        out[16] = self.serial_s;
        out[17] = self.num_configurations;
        return out;
    }
};

/// USB Device Qualifier Descriptor
/// This descriptor is mostly the same as the DeviceDescriptor
pub const DeviceQualifierDescriptor = extern struct {
    pub const const_descriptor_type = DescType.DeviceQualifier;

    length: u8 = 10,
    /// Type of this descriptor, must be `Device`.
    descriptor_type: DescType = const_descriptor_type,
    bcd_usb: BcdUsb,
    device_triple: DeviceTriple,
    /// Maximum unit of data this device can move.
    max_packet_size0: u8,
    /// Number of configurations supported by this device.
    num_configurations: u8,
    /// Reserved for future use; must be 0
    reserved: u8 = 0,

    pub fn serialize(self: *const @This()) [10]u8 {
        var out: [10]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = self.bcd_usb.lo;
        out[3] = self.bcd_usb.hi;
        out[4] = @intFromEnum(self.device_triple.class);
        out[5] = self.device_triple.subclass;
        out[6] = self.device_triple.protocol;
        out[7] = self.max_packet_size0;
        out[8] = self.num_configurations;
        out[9] = self.reserved;
        return out;
    }
};

pub const DriverErrors = error{
    ExpectedInterfaceDescriptor,
    UnsupportedInterfaceClassType,
    UnsupportedInterfaceSubClassType,
    UnexpectedDescriptor,
};
