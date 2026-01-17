const std = @import("std");
const assert = std.debug.assert;

pub const ClassSubclassProtocol = extern struct {
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

        pub fn Subclass(self: @This()) type {
            return @field(ClassSubclassProtocol.Subclass, @tagName(self));
        }

        pub fn Protocol(self: @This()) type {
            return @field(ClassSubclassProtocol.Protocol, @tagName(self));
        }
    };

    pub const Subclass = struct {
        pub const Default = enum(u8) {
            Unspecified = 0x00,
            VendorSpecific = 0xFF,
            _,
        };

        pub const Unspecified = Default;
        pub const Audio = Default;

        pub const Cdc = enum(u8) {
            Unspecified = 0x00,
            VendorSpecific = 0xFF,
            /// Direct Line Control Model
            DirectLine = 0x01,
            /// Abstract Control Model
            Abstract = 0x02,
            /// Telephone Control Model
            Telephone = 0x03,
            /// Multi-Channel Control Model
            MultChannel = 0x04,
            /// CAPI Control Model
            CAPI = 0x05,
            /// Ethernet Networking Control Model
            Ethernet = 0x06,
            /// ATM Networking Control Model
            ATM_Networking = 0x07,
            /// Wireless Handset Control Model
            WirelessHeadest = 0x08,
            /// Device Management
            DeviceManagement = 0x09,
            /// Mobile Direct Line Model
            MobileDirect = 0x0A,
            /// OBEX
            OBEX = 0x0B,
            /// Ethernet Emulation Model
            EthernetEmulation = 0x0C,
            /// Network Control Model
            Network = 0x0D,
            _,
        };

        pub const Hid = enum(u8) {
            Unspecified = 0x00,
            VendorSpecific = 0xFF,
            ///
            Boot = 0x01,
            _,
        };

        pub const Physical = Default;
        pub const Image = Default;
        pub const Printer = Default;

        pub const MassStorage = enum(u8) {
            /// SCSI command set not reported. De facto use.
            Unspecified = 0x00,
            /// Allocated by USB-IF for RBC. RBC is defined outside of USB.
            RBC = 0x01,
            /// Allocated by USB-IF for MMC-5 (ATAPI). MMC-5 is defined outside of USB.
            MMC_5 = 0x02,
            /// Obsolete. Was QIC-157
            QIC_157 = 0x03,
            /// Specifies how to interface Floppy Disk Drives to USB
            UFI = 0x04,
            /// Obsolete. Was SFF-8070i
            SFF_8070i = 0x05,
            /// SCSI transparent command set. Allocated by USB-IF for SCSI. SCSI standards are defined outside of USB.
            SCSI = 0x06,
            /// LSDFS. specifies how host has to negotiate access before trying SCSI
            LSD_FS = 0x07,
            /// Allocated by USB-IF for IEEE 1667. IEEE 1667 is defined outside of USB.
            IEEE_1667 = 0x08,
            /// Specific to device vendor. De facto use
            VendorSpecific = 0xFF,
            _,
        };

        pub const Hub = Default;

        pub const CdcData = enum(u8) {
            Unused = 0,
            VendorSpecific = 0xFF,
            _,
        };

        pub const SmartCard = Default;
        pub const ContentSecurity = Default;
        pub const Video = Default;
        pub const PersonalHealthcare = Default;
        pub const AudioVideoDevice = Default;
        pub const BillboardDevice = Default;
        pub const USBTypeCBridge = Default;
        pub const USBBulkDisplayProtocol = Default;
        pub const MCTPoverUSBProtocolEndpoint = Default;
        pub const I3C = Default;
        pub const DiagnosticDevice = Default;
        pub const WirelessController = Default;
        pub const Miscellaneous = Default;
        pub const ApplicationSpecific = Default;
        pub const VendorSpecific = Default;
    };

    pub const Protocol = struct {
        pub const Default = enum(u8) {
            NoneRequired = 0x00,
            VendorSpecific = 0xFF,
            _,
        };

        pub const Unspecified = Default;
        pub const Audio = Default;

        pub const Cdc = enum(u8) {
            /// USB specification No class specific protocol required
            NoneRequired = 0x00,
            /// ITU-T V.250 AT Commands: V.250 etc
            AT_ITU_T_V_250 = 0x01,
            /// PCCA-101 AT Commands defined by PCCA-101
            AT_PCCA_101 = 0x02,
            /// PCCA-101 AT Commands defined by PCCA-101 & Annex O
            AT_PCCA_101_O = 0x03,
            /// GSM 7.07 AT Commands defined by GSM 07.07
            AT_GSM_7_07 = 0x04,
            /// 3GPP 27.07 AT Commands defined by 3GPP 27.007
            AT_3GPP_27_07 = 0x05,
            /// C-S0017-0 AT Commands defined by TIA for CDMA
            AT_C_S0017_0 = 0x06,
            /// USB EEM Ethernet Emulation module
            USB_EEM = 0x07,
            /// External Protocol: Commands defined by Command Set Functional Descriptor
            External = 0xFE,
            /// USB Specification Vendor-specific
            VendorSpecific = 0xFF,
            _,
        };

        pub const Hid = enum(u8) {
            NoneRequired = 0x00,
            VendorSpecific = 0xFF,
            ///
            Boot = 0x01,
            _,
        };

        pub const Physical = Default;
        pub const Image = Default;
        pub const Printer = Default;

        pub const MassStorage = enum(u8) {
            /// USB Mass Storage Class Control/Bulk/Interrupt (CBI) Transport with command completion interrupt
            CBI_with_interrupt = 0x00,
            /// USB Mass Storage Class Control/Bulk/Interrupt (CBI) Transport with no command completion interrupt
            CBI_no_interrupt = 0x01,
            /// USB Mass Storage Class Bulk-Only (BBB) Transport
            BulkOnly = 0x50,
            /// Allocated by USB-IF for UAS. UAS is defined outside of USB.
            UAS = 0x62,
            /// Specific to device vendor De facto use
            VendorSpecific = 0xFF,
            _,
        };

        pub const Hub = Default;

        pub const CdcData = enum(u8) {
            NoneRequired = 0,
            VendorSpecific = 0xFF,
            /// Network Transfer Block
            NetworkTransferBlock = 0x01,
            /// Physical interface protocol for ISDN BRI
            ISDN_BRI = 0x30,
            /// HDLC
            HDLC = 0x31,
            /// Transparent
            Transparent = 0x32,
            /// Management protocol for Q.921 data link protocol
            Management_Q_921 = 0x50,
            /// Data link protocol for Q.931
            DataLink_Q_931 = 0x51,
            /// TEI-multiplexor for Q.921 data link protocol
            TEI_Multiplexor_Q_921 = 0x52,
            /// Data compression procedures
            DataCompressionProcedures = 0x90,
            /// Euro-ISDN protocol control
            Euro_ISDN = 0x91,
            /// V.24 rate adaptation to ISDN
            RateAdaptation_V_24 = 0x92,
            /// CAPI Commands
            CAPI = 0x93,
            /// Host based driver. Note: This protocol code should only be used
            /// in messages between host and device to identify the host driver
            /// portion of a protocol stack.
            HostBasedDriver = 0xFD,
            /// CDC Specification The protocol(s) are described using a Protocol
            /// Unit Functional Descriptors on Communications Class Interface
            SpecifiedIn_PUF_Descriptor = 0xFE,
            _,
        };

        pub const SmartCard = Default;
        pub const ContentSecurity = Default;
        pub const Video = Default;
        pub const PersonalHealthcare = Default;
        pub const AudioVideoDevice = Default;
        pub const BillboardDevice = Default;
        pub const USBTypeCBridge = Default;
        pub const USBBulkDisplayProtocol = Default;
        pub const MCTPoverUSBProtocolEndpoint = Default;
        pub const I3C = Default;
        pub const DiagnosticDevice = Default;
        pub const WirelessController = Default;
        pub const Miscellaneous = Default;
        pub const ApplicationSpecific = Default;
        pub const VendorSpecific = Default;
    };

    /// Class code, distinguishing the type of interface.
    class: ClassCode,
    /// Interface subclass code, refining the class of interface.
    subclass: u8,
    /// Protocol within the interface class/subclass.
    protocol: u8,

    pub const unspecified: @This() =
        .from(.Unspecified, .Unspecified, .NoneRequired);

    pub const vendor_specific: @This() =
        .from(.VendorSpecific, .VendorSpecific, .VendorSpecific);

    pub fn from(
        comptime class: ClassCode,
        subclass: class.Subclass(),
        protocol: class.Protocol(),
    ) @This() {
        return .{
            .class = class,
            .subclass = @intFromEnum(subclass),
            .protocol = @intFromEnum(protocol),
        };
    }
};

/// Types of transfer that can be indicated by the `attributes` field on `EndpointDescriptor`.
pub const TransferType = enum(u2) {
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3,
};

/// The types of USB SETUP requests that we understand.
pub const SetupRequest = enum(u8) {
    SetFeature = 0x03,
    SetAddress = 0x05,
    GetDescriptor = 0x06,
    SetConfiguration = 0x09,
    _,
};

pub const FeatureSelector = enum(u8) {
    EndpointHalt = 0x00,
    DeviceRemoteWakeup = 0x01,
    TestMode = 0x02,
    // The remaining features only apply to OTG devices.
    _,
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
    value: U16_Le,
    index: U16_Le,
    /// If data will be transferred after this request (in the direction given
    /// by `request_type`), this gives the number of bytes (OUT) or maximum
    /// number of bytes (IN).
    length: U16_Le,
};

/// Represents packet length.
pub const Len = u11;

/// u16 value, little endian regardless of native endianness.
pub const U16_Le = extern struct {
    value_le: u16 align(1),

    pub fn from(val: u16) @This() {
        return .{ .value_le = std.mem.nativeToLittle(u16, val) };
    }

    pub fn into(self: @This()) u16 {
        return std.mem.littleToNative(u16, self.value_le);
    }
};

/// u32 value, little endian regardless of native endianness.
pub const U32_Le = extern struct {
    value_le: u32 align(1),

    pub fn from(val: u32) @This() {
        return .{ .value_le = std.mem.nativeToLittle(u32, val) };
    }

    pub fn into(self: @This()) u32 {
        return std.mem.littleToNative(u32, self.value_le);
    }
};
