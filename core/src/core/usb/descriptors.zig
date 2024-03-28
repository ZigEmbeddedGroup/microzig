/// Describes a device. This is the most broad description in USB and is
/// typically the first thing the host asks for.
pub const Device = extern struct {
    /// Version of the device descriptor / USB protocol, in binary-coded
    /// decimal. This is typically `0x01_10` for USB 1.1.
    bcdUSB: u16,
    /// Class of device, giving a broad functional area.
    bDeviceClass: u8,
    /// SubClass of device, refining the class.
    bDeviceSubClass: u8,
    /// Protocol within the subclass.
    bDeviceProtocol: u8,
    /// Maximum unit of data this device can move.
    bMaxPacketSize0: u8,
    /// ID of product vendor.
    idVendor: u16,
    /// ID of product.
    idProduct: u16,
    /// Device version number, as BCD again.
    bcdDevice: u16,
    /// Index of manufacturer name in string descriptor table.
    iManufacturer: u8,
    /// Index of product name in string descriptor table.
    iPRoduct: u8,
    /// Index of serial number in string descriptor table.
    iSerialNumber: u8,
    /// Number of configurations supported by this device.
    bNumConfigurations: u8,
};

pub const Interface = extern struct {
    bInterfaceNumber: u8,
    bAlternateSetting: u8,
    bNumEndpoints: u8,
    bInterfaceClass: u8,
    bInterfaceSubClass: u8,
    bInterfaceProtocol: u8,
    iInterface: u8,
};

/// Description of a single available device configuration.
pub const Configuration = extern struct {
    /// Total length of all descriptors in this configuration, concatenated.
    /// This will include this descriptor, plus at least one interface
    /// descriptor, plus each interface descriptor's endpoint descriptors.
    wTotalLength: u16,
    /// Number of interface descriptors in this configuration.
    bNumInterfaces: u8,
    /// Number to use when requesting this configuration via a
    /// `SetConfiguration` request.
    bConfigurationValue: u8,
    /// Index of this configuration's name in the string descriptor table.
    iConfiguration: u8,
    /// Bit set of device attributes:
    ///
    /// - Bit 7 should be set (indicates that device can be bus powered in USB
    /// 1.0).
    /// - Bit 6 indicates that the device can be self-powered.
    /// - Bit 5 indicates that the device can signal remote wakeup of the host
    /// (like a keyboard).
    /// - The rest are reserved and should be zero.
    bmAttributes: u8,
    /// Maximum device power consumption in units of 2mA.
    bMaxPower: u8,
};

pub const InterfaceAssociation = extern struct {
    bFirstInterface: u8,
    bInterfaceCount: u8,
    bFunctionClass: u8,
    bFunctionSubClass: u8,
    bFunctionProtocol: u8,
    iFunction: u8,
};

/// Describes an endpoint within an interface
pub const Endpoint = extern struct {
    /// Address of this endpoint, where the bottom 4 bits give the endpoint
    /// number (0..15) and the top bit distinguishes IN (1) from OUT (0).
    bEndpointAddress: u8,
    /// Endpoint attributes; the most relevant part is the bottom 2 bits, which
    /// control the transfer type using the values from `TransferType`.
    bmAttributes: u8,
    /// Maximum packet size this endpoint can accept/produce.
    wMaxPacketSize: u16,
    /// Interval for polling interrupt/isochronous endpoints (which we don't
    /// currently support) in milliseconds.
    bInterval: u8,
};

pub const BOS = extern struct {
    /// The number of bytes in this descriptor and all of its subordinate
    /// descriptors
    wTotalLength: u16,
    /// The numbre of device capability descriptors subordinate to this BOS
    /// descriptor
    bNumDeviceCaps: u8,

};

pub const Utf16Le = struct {
    bytes: []const u8,
};

/// For string descriptor zero: an array of one or more language identifier
/// codes, for other string descriptors, a unicode UTF-16LE string
pub const String = extern struct {
    string_or_lang: union {
        bSTRING: Utf16Le,
        wLANGID: []const u8,
    };
};
