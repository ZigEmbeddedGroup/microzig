const std = @import("std");

pub const DescType = enum(u8) {
    Device               = 0x01,
    Config               = 0x02,
    String               = 0x03,
    Interface            = 0x04,
    Endpoint             = 0x05,
    DeviceQualifier      = 0x06,
    InterfaceAssociation = 0x0b,
    CsDevice             = 0x21,
    CsConfig             = 0x22,
    CsString             = 0x23,
    CsInterface          = 0x24,
    CsEndpoint           = 0x25,

    pub fn from_u16(v: u16) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

/// Types of transfer that can be indicated by the `attributes` field on `EndpointDescriptor`.
pub const TransferType = enum(u2) {
    Control     = 0,
    Isochronous = 1,
    Bulk        = 2,
    Interrupt   = 3,
};

/// The types of USB SETUP requests that we understand.
pub const SetupRequest = enum(u8) {
    GetDescriptor    = 0x06,
    SetAddress       = 0x05,
    SetConfiguration = 0x09,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

/// USB deals in two different transfer directions, called OUT (host-to-device)
/// and IN (device-to-host). In the vast majority of cases, OUT is represented
/// by a 0 byte, and IN by an `0x80` byte.
pub const Dir = enum(u1) {
    Out = 0,
    In  = 1,

    pub const DIR_IN_MASK = 0x80;
};

pub const RequestType = packed struct(u8) {
    recipient: enum(u5) { device, interface, endpoint, other },
    type: enum(u2) { standard, class, vendor, other },
    direction: Dir
};

/// Layout of an 8-byte USB SETUP packet.
pub const SetupPacket = extern struct {
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