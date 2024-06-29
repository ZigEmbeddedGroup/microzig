const std = @import("std");
const buffers = @import("../buffers.zig");

/// USB primitive types
const types = @import("types.zig");

const BufferWriter = buffers.BufferWriter;
const DescType = types.DescType;

/// Describes an endpoint within an interface
pub const EndpointDescriptor = struct {
    /// Type of this descriptor, must be `Endpoint`.
    descriptor_type: DescType = DescType.Endpoint,
    /// Address of this endpoint, where the bottom 4 bits give the endpoint
    /// number (0..15) and the top bit distinguishes IN (1) from OUT (0).
    endpoint_address: u8,
    /// Endpoint attributes; the most relevant part is the bottom 2 bits, which
    /// control the transfer type using the values from `TransferType`.
    attributes: u8,
    /// Maximum packet size this endpoint can accept/produce.
    max_packet_size: u16,
    /// Interval for polling interrupt/isochronous endpoints (which we don't
    /// currently support) in milliseconds.
    interval: u8,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 7;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u8, self.endpoint_address);
        buff.write_int_unsafe(u8, self.attributes);
        buff.write_int_unsafe(u16, self.max_packet_size);
        buff.write_int_unsafe(u8, self.interval);
    }
};

/// Description of an interface within a configuration.
pub const InterfaceDescriptor = struct {
    /// Type of this descriptor, must be `Interface`.
    descriptor_type: DescType = DescType.Interface,
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

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 9;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u8, self.interface_number);
        buff.write_int_unsafe(u8, self.alternate_setting);
        buff.write_int_unsafe(u8, self.num_endpoints);
        buff.write_int_unsafe(u8, self.interface_class);
        buff.write_int_unsafe(u8, self.interface_subclass);
        buff.write_int_unsafe(u8, self.interface_protocol);
        buff.write_int_unsafe(u8, self.interface_s);
    }
};

/// USB interface association descriptor (IAD) allows the device to group interfaces that belong to a function.
pub const InterfaceAssociationDescriptor = struct {
    // Type of this descriptor, must be `InterfaceAssociation`.
    descriptor_type: DescType = DescType.InterfaceAssociation,
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

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 8;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u8, self.first_interface);
        buff.write_int_unsafe(u8, self.interface_count);
        buff.write_int_unsafe(u8, self.function_class);
        buff.write_int_unsafe(u8, self.function_subclass);
        buff.write_int_unsafe(u8, self.function_protocol);
        buff.write_int_unsafe(u8, self.function);
    }
};

/// Description of a single available device configuration.
pub const ConfigurationDescriptor = struct {
    /// Type of this descriptor, must be `Config`.
    descriptor_type: DescType = DescType.Config,
    /// Total length of all descriptors in this configuration, concatenated.
    /// This will include this descriptor, plus at least one interface
    /// descriptor, plus each interface descriptor's endpoint descriptors.
    total_length: u16,
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

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 9;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u16, self.total_length);
        buff.write_int_unsafe(u8, self.num_interfaces);
        buff.write_int_unsafe(u8, self.configuration_value);
        buff.write_int_unsafe(u8, self.configuration_s);
        buff.write_int_unsafe(u8, self.attributes);
        buff.write_int_unsafe(u8, self.max_power);
    }
};

/// Describes a device. This is the most broad description in USB and is
/// typically the first thing the host asks for.
pub const DeviceDescriptor = struct {
    /// Type of this descriptor, must be `Device`.
    descriptor_type: DescType = DescType.Device,
    /// Version of the device descriptor / USB protocol, in binary-coded
    /// decimal. This is typically `0x01_10` for USB 1.1.
    bcd_usb: u16,
    /// Class of device, giving a broad functional area.
    device_class: u8,
    /// Subclass of device, refining the class.
    device_subclass: u8,
    /// Protocol within the subclass.
    device_protocol: u8,
    /// Maximum unit of data this device can move.
    max_packet_size0: u8,
    /// ID of product vendor.
    vendor: u16,
    /// ID of product.
    product: u16,
    /// Device version number, as BCD again.
    bcd_device: u16,
    /// Index of manufacturer name in string descriptor table.
    manufacturer_s: u8,
    /// Index of product name in string descriptor table.
    product_s: u8,
    /// Index of serial number in string descriptor table.
    serial_s: u8,
    /// Number of configurations supported by this device.
    num_configurations: u8,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 18;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u16, self.bcd_usb);
        buff.write_int_unsafe(u8, self.device_class);
        buff.write_int_unsafe(u8, self.device_subclass);
        buff.write_int_unsafe(u8, self.device_protocol);
        buff.write_int_unsafe(u8, self.max_packet_size0);
        buff.write_int_unsafe(u16, self.vendor);
        buff.write_int_unsafe(u16, self.product);
        buff.write_int_unsafe(u16, self.bcd_device);
        buff.write_int_unsafe(u8, self.manufacturer_s);
        buff.write_int_unsafe(u8, self.product_s);
        buff.write_int_unsafe(u8, self.serial_s);
        buff.write_int_unsafe(u8, self.num_configurations);
    }
};

/// USB Device Qualifier Descriptor
/// This descriptor is mostly the same as the DeviceDescriptor
pub const DeviceQualifierDescriptor = struct {
    /// Type of this descriptor, must be `DeviceQualifier`.
    descriptor_type: DescType = DescType.DeviceQualifier,
    /// Version of the device descriptor / USB protocol, in binary-coded
    /// decimal. This is typically `0x01_10` for USB 1.1.
    bcd_usb: u16,
    /// Class of device, giving a broad functional area.
    device_class: u8,
    /// Subclass of device, refining the class.
    device_subclass: u8,
    /// Protocol within the subclass.
    device_protocol: u8,
    /// Maximum unit of data this device can move.
    max_packet_size0: u8,
    /// Number of configurations supported by this device.
    num_configurations: u8,
    /// Reserved for future use; must be 0
    reserved: u8 = 0,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        const length = 10;
        try buff.bound_check(length);
        buff.write_int_unsafe(u8, length);
        buff.write_int_unsafe(u8, @intFromEnum(self.descriptor_type));
        buff.write_int_unsafe(u16, self.bcd_usb);
        buff.write_int_unsafe(u8, self.device_class);
        buff.write_int_unsafe(u8, self.device_subclass);
        buff.write_int_unsafe(u8, self.device_protocol);
        buff.write_int_unsafe(u8, self.max_packet_size0);
        buff.write_int_unsafe(u8, self.num_configurations);
        buff.write_int_unsafe(u8, self.reserved);
    }
};