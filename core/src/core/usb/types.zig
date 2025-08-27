const std = @import("std");
const assert = std.debug.assert;

/// Class of device, giving a broad functional area.
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
    _,
};

/// Types of transfer that can be indicated by the `attributes` field on `EndpointDescriptor`.
pub const TransferType = enum(u2) {
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3,

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
    // There are up to 15 endpoints for each direction.
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
    };

    num: Num,
    _padding: u3 = 0,
    dir: Dir,

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

    const Recipient = enum(u5) {
        Device,
        Interface,
        Endpoint,
        Other,
        _, // Reserved
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

pub const U16Le = extern struct {
    lo: u8,
    hi: u8,

    pub fn from(val: u16) @This() {
        return .{
            .lo = @truncate(val),
            .hi = @intCast(val >> 8),
        };
    }

    pub fn into(this: @This()) u16 {
        return (@as(u16, this.hi) << 8) | @as(u16, this.lo);
    }
};
