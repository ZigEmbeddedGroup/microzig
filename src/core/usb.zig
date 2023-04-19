//! Abstract USB device implementation
//!
//! This can be used to setup a USB device.
//!
//! ## Usage
//!
//! 1. Define the functions (`pub const F = struct { ... }`) required by `Usb()` (see below)
//! 2. Call `pub const device = Usb(F)`
//! 3. Define the device configuration (UsbDeviceConfiguration)
//! 4. Initialize the device in main by calling `usb.init_clk()` and `usb.init_device(device_conf)`
//! 5. Call `usb.task()` to within the main loop

const std = @import("std");

/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");

/// Create a USB device
///
/// # Arguments
///
/// This is a abstract USB device implementation that requires a handful of functions
/// to work correctly:
///
/// * `usb_init_clk() void` - Initialize the USB clock
/// * `usb_init_device(*UsbDeviceConfiguration) - Initialize the USB device controller (e.g. enable interrupts, etc.)
/// * `usb_start_tx(*UsbEndpointConfiguration, []const u8)` - Transmit the given bytes over the specified endpoint
/// * `usb_start_rx(*usb.UsbEndpointConfiguration, n: usize)` - Receive n bytes over the specified endpoint
/// * `get_interrupts() InterruptStatus` - Return which interrupts haven't been handled yet
/// * `get_setup_packet() UsbSetupPacket` - Return the USB setup packet received (called if SetupReq received). Make sure to clear the status flag yourself!
/// * `bus_reset() void` - Called on a bus reset interrupt
/// * `set_address(addr: u7) void` - Set the given address
/// * `get_EPBIter(*const UsbDeviceConfiguration) EPBIter` - Return an endpoint buffer iterator. Each call to next returns an unhandeled endpoint buffer with data. How next is implemented depends on the system.
/// The functions must be grouped under the same name space and passed to the fuction at compile time.
/// The functions will be accessible to the user through the `callbacks` field.
pub fn Usb(comptime f: anytype) type {
    return struct {
        /// The usb configuration set
        var usb_config: ?*UsbDeviceConfiguration = null;
        /// The clock has been initialized [Y/n]
        var clk_init: bool = false;

        /// Index of enpoint buffer 0 out
        pub const EP0_OUT_IDX = 0;
        /// Index of enpoint buffer 0 in
        pub const EP0_IN_IDX = 1;
        /// The callbacks passed provided by the caller
        pub const callbacks = f;

        /// Initialize the USB clock
        pub fn init_clk() void {
            f.usb_init_clk();
            clk_init = true;
        }

        /// Initialize the usb device using the given configuration
        ///
        /// This function will return an error if the clock hasn't been initialized.
        pub fn init_device(device_config: *UsbDeviceConfiguration) !void {
            if (!clk_init) return error.UninitializedClock;

            f.usb_init_device(device_config);
            usb_config = device_config;
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// This function will return an error if the device hasn't been initialized.
        pub fn task(debug: bool) !void {
            if (usb_config == null) return error.UninitializedDevice;

            // We'll keep some state in Plain Old Static Local Variables:
            const S = struct {
                // When the host gives us a new address, we can't just slap it into
                // registers right away, because we have to do an acknowledgement step using
                // our _old_ address.
                var new_address: ?u8 = null;
                // Flag recording whether the host has configured us with a
                // `SetConfiguration` message.
                var configured = false;
                // Flag recording whether we've set up buffer transfers after being
                // configured.
                var started = false;
                // Some scratch space that we'll use for things like preparing string
                // descriptors for transmission.
                var tmp: [64]u8 = .{0} ** 64;
            };

            // Check which interrupt flags are set.
            const ints = f.get_interrupts();

            // Setup request received?
            if (ints.SetupReq) {
                if (debug) std.log.info("setup req", .{});

                // Get the setup request setup packet
                const setup = f.get_setup_packet();

                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                usb_config.?.endpoints[EP0_IN_IDX].next_pid_1 = true;

                // Attempt to parse the request type and request into one of our
                // known enum values, and then inspect them. (These will return None
                // if we get an unexpected numeric value.)
                const reqty = UsbDir.of_endpoint_addr(setup.request_type);
                const req = UsbSetupRequest.from_u8(setup.request);

                if (reqty == UsbDir.Out and req != null and req.? == UsbSetupRequest.SetAddress) {
                    // The new address is in the bottom 8 bits of the setup
                    // packet value field. Store it for use later.
                    S.new_address = @intCast(u8, setup.value & 0xff);
                    // The address will actually get set later, we have
                    // to use address 0 to send a status response.
                    f.usb_start_tx(
                        usb_config.?.endpoints[EP0_IN_IDX], //EP0_IN_CFG,
                        &.{}, // <- see, empty buffer
                    );
                    if (debug) std.log.info("    SetAddress: {}", .{S.new_address.?});
                } else if (reqty == UsbDir.Out and req != null and req.? == UsbSetupRequest.SetConfiguration) {
                    // We only have one configuration, and it doesn't really
                    // mean anything to us -- more of a formality. All we do in
                    // response to this is:
                    S.configured = true;
                    f.usb_start_tx(
                        usb_config.?.endpoints[EP0_IN_IDX], //EP0_IN_CFG,
                        &.{}, // <- see, empty buffer
                    );
                    if (debug) std.log.info("    SetConfiguration", .{});
                } else if (reqty == UsbDir.Out) {
                    // This is sort of a hack, but: if we get any other kind of
                    // OUT, just acknowledge it with the same zero-length status
                    // phase that we use for control transfers that we _do_
                    // understand. This keeps the host from spinning forever
                    // while we NAK.
                    //
                    // This behavior copied shamelessly from the C example.
                    f.usb_start_tx(
                        usb_config.?.endpoints[EP0_IN_IDX], // EP0_IN_CFG,
                        &.{}, // <- see, empty buffer
                    );
                    if (debug) std.log.info("    Just OUT", .{});
                } else if (reqty == UsbDir.In and req != null and req.? == UsbSetupRequest.GetDescriptor) {
                    // Identify the requested descriptor type, which is in the
                    // _top_ 8 bits of value.
                    const descriptor_type = UsbDescType.from_u16(setup.value >> 8);
                    if (debug) std.log.info("    GetDescriptor: {}", .{setup.value >> 8});
                    if (descriptor_type) |dt| {
                        switch (dt) {
                            .Device => {
                                if (debug) std.log.info("        Device", .{});
                                // TODO: this sure looks like a duplicate, but it's
                                // a duplicate that was present in the C
                                // implementation.
                                usb_config.?.endpoints[EP0_IN_IDX].next_pid_1 = true;

                                const dc = usb_config.?.device_descriptor.serialize();
                                std.mem.copy(u8, S.tmp[0..dc.len], &dc);

                                // Configure EP0 IN to send the device descriptor
                                // when it's next asked.
                                f.usb_start_tx(
                                    usb_config.?.endpoints[EP0_IN_IDX],
                                    S.tmp[0..dc.len],
                                );
                            },
                            .Config => {
                                if (debug) std.log.info("        Config", .{});
                                // Config descriptor requests are slightly unusual.
                                // We can respond with just our config descriptor,
                                // but we can _also_ append our interface and
                                // endpoint descriptors to the end, saving some
                                // round trips. We'll choose to do this if the
                                // number of bytes the host will accept (in the
                                // `length` field) is large enough.
                                var used: usize = 0;

                                const cd = usb_config.?.config_descriptor.serialize();
                                std.mem.copy(u8, S.tmp[used .. used + cd.len], &cd);
                                used += cd.len;

                                if (setup.length > used) {
                                    // Do the rest!
                                    //
                                    // This is slightly incorrect because the host
                                    // might have asked for a number of bytes in
                                    // between the size of a config descriptor, and
                                    // the amount we're going to send back. However,
                                    // in practice, the host always asks for either
                                    // (1) the exact size of a config descriptor, or
                                    // (2) 64 bytes, and this all fits in 64 bytes.
                                    const id = usb_config.?.interface_descriptor.serialize();
                                    std.mem.copy(u8, S.tmp[used .. used + id.len], &id);
                                    used += id.len;

                                    // Seems like the host does not bother asking for the
                                    // hid descriptor so we'll just send it with the
                                    // other descriptors.
                                    if (usb_config.?.hid) |hid_conf| {
                                        const hd = hid_conf.hid_descriptor.serialize();
                                        std.mem.copy(u8, S.tmp[used .. used + hd.len], &hd);
                                        used += hd.len;
                                    }

                                    // TODO: depending on the number of endpoints
                                    // this might not fit in 64 bytes -> split message
                                    // into multiple packets
                                    for (usb_config.?.endpoints[2..]) |ep| {
                                        const ed = ep.descriptor.serialize();
                                        std.mem.copy(u8, S.tmp[used .. used + ed.len], &ed);
                                        used += ed.len;
                                    }
                                }

                                // Set up EP0 IN to send the stuff we just composed.
                                f.usb_start_tx(
                                    usb_config.?.endpoints[EP0_IN_IDX],
                                    S.tmp[0..used],
                                );
                            },
                            .String => {
                                if (debug) std.log.info("        String", .{});
                                // String descriptor index is in bottom 8 bits of
                                // `value`.
                                const i = @intCast(usize, setup.value & 0xff);
                                const bytes = StringBlk: {
                                    if (i == 0) {
                                        // Special index 0 requests the language
                                        // descriptor.
                                        break :StringBlk usb_config.?.lang_descriptor;
                                    } else {
                                        // Otherwise, set up one of our strings.
                                        const s = usb_config.?.descriptor_strings[i - 1];
                                        const len = 2 + s.len;

                                        S.tmp[0] = @intCast(u8, len);
                                        S.tmp[1] = 0x03;
                                        std.mem.copy(u8, S.tmp[2..len], s);

                                        break :StringBlk S.tmp[0..len];
                                    }
                                };
                                // Set up EP0 IN to send whichever thing we just
                                // decided on.
                                f.usb_start_tx(
                                    usb_config.?.endpoints[EP0_IN_IDX],
                                    bytes,
                                );
                            },
                            .Interface => {
                                if (debug) std.log.info("        Interface", .{});
                                // We don't expect the host to send this because we
                                // delivered our interface descriptor with the
                                // config descriptor.
                                //
                                // Should probably implement it, though, because
                                // otherwise the host will be unhappy. TODO.
                                //
                                // Note that the C example gets away with ignoring
                                // this.
                            },
                            .Endpoint => {
                                if (debug) std.log.info("        Endpoint", .{});
                                // Same deal as interface descriptors above.
                            },
                            .DeviceQualifier => {
                                if (debug) std.log.info("        DeviceQualifier", .{});
                                // We will just copy parts of the DeviceDescriptor because
                                // the DeviceQualifierDescriptor can be seen as a subset.
                                const dqd = DeviceQualifierDescriptor{
                                    .bcd_usb = usb_config.?.device_descriptor.bcd_usb,
                                    .device_class = usb_config.?.device_descriptor.device_class,
                                    .device_subclass = usb_config.?.device_descriptor.device_subclass,
                                    .device_protocol = usb_config.?.device_descriptor.device_protocol,
                                    .max_packet_size0 = usb_config.?.device_descriptor.max_packet_size0,
                                    .num_configurations = usb_config.?.device_descriptor.num_configurations,
                                };

                                const data = dqd.serialize();
                                std.mem.copy(u8, S.tmp[0..data.len], &data);

                                f.usb_start_tx(
                                    usb_config.?.endpoints[EP0_IN_IDX],
                                    S.tmp[0..data.len],
                                );
                            },
                        }
                    } else {
                        // Maybe the unknown request type is a hid request

                        if (usb_config.?.hid) |hid_conf| {
                            const _hid_desc_type = hid.HidDescType.from_u16(setup.value >> 8);

                            if (_hid_desc_type) |hid_desc_type| {
                                switch (hid_desc_type) {
                                    .Hid => {
                                        if (debug) std.log.info("        HID", .{});

                                        const hd = hid_conf.hid_descriptor.serialize();
                                        std.mem.copy(u8, S.tmp[0..hd.len], &hd);

                                        f.usb_start_tx(
                                            usb_config.?.endpoints[EP0_IN_IDX],
                                            S.tmp[0..hd.len],
                                        );
                                    },
                                    .Report => {
                                        if (debug) std.log.info("        Report", .{});

                                        // The report descriptor is already a (static)
                                        // u8 array, i.e., we can pass it directly
                                        f.usb_start_tx(
                                            usb_config.?.endpoints[EP0_IN_IDX],
                                            hid_conf.report_descriptor,
                                        );
                                    },
                                    .Physical => {
                                        if (debug) std.log.info("        Physical", .{});
                                        // Ignore for now
                                    },
                                }
                            } else {
                                // It's not a valid HID request. This can totally happen
                                // we'll just ignore it for now...
                            }
                        }
                    }
                } else if (reqty == UsbDir.In) {
                    if (debug) std.log.info("    Just IN", .{});
                    // Other IN request. Ignore.
                } else {
                    if (debug) std.log.info("    This is unexpected", .{});
                    // Unexpected request type or request bits. This can totally
                    // happen (yay, hardware!) but is rare in practice. Ignore
                    // it.
                }
            } // <-- END of setup request handling

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BuffStatus) {
                if (debug) std.log.info("buff status", .{});
                var iter = f.get_EPBIter(usb_config.?);

                while (iter.next(&iter)) |epb| {
                    if (debug) std.log.info("    data: {any}", .{epb.buffer});

                    // Perform any required action on the data. For OUT, the `data`
                    // will be whatever was sent by the host. For IN, it's a copy of
                    // whatever we sent.
                    switch (epb.endpoint.descriptor.endpoint_address) {
                        EP0_IN_ADDR => {
                            if (debug) std.log.info("    EP0_IN_ADDR", .{});
                            // We use this opportunity to finish the delayed
                            // SetAddress request, if there is one:
                            if (S.new_address) |addr| {
                                // Change our address:
                                f.set_address(@intCast(u7, addr));
                            } else {
                                // Otherwise, we've just finished sending
                                // something to the host. We expect an ensuing
                                // status phase where the host sends us (via EP0
                                // OUT) a zero-byte DATA packet, so, set that
                                // up:
                                f.usb_start_rx(
                                    usb_config.?.endpoints[EP0_OUT_IDX], // EP0_OUT_CFG,
                                    0,
                                );
                            }
                        },
                        else => {
                            if (debug) std.log.info("    ELSE, ep_addr: {}", .{
                                epb.endpoint.descriptor.endpoint_address & 0x7f,
                            });
                            // Handle user provided endpoints.

                            // Invoke the callback (if the user provides one).
                            if (epb.endpoint.callback) |callback| callback(usb_config.?, epb.buffer);
                        },
                    }
                }
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BusReset) {
                if (debug) std.log.info("bus reset", .{});

                // Reset the device
                f.bus_reset();

                // Reset our state.
                S.new_address = null;
                S.configured = false;
                S.started = false;
            }

            // If we have been configured but haven't reached this point yet, set up
            // our custom EP OUT's to receive whatever data the host wants to send.
            if (S.configured and !S.started) {
                // We can skip the first two endpoints because those are EP0_OUT and EP0_IN
                for (usb_config.?.endpoints[2..]) |ep| {
                    if (UsbDir.of_endpoint_addr(ep.descriptor.endpoint_address) == .Out) {
                        // Hey host! we expect data!
                        f.usb_start_rx(
                            ep,
                            64,
                        );
                    }
                }
                S.started = true;
            }
        }
    };
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Data Types
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// Types of USB descriptor
pub const UsbDescType = enum(u8) {
    Device = 0x01,
    Config = 0x02,
    String = 0x03,
    Interface = 0x04,
    Endpoint = 0x05,
    DeviceQualifier = 0x06,
    //-------- Class Specific Descriptors ----------
    // 0x21 ...

    pub fn from_u16(v: u16) ?@This() {
        return switch (v) {
            1 => @This().Device,
            2 => @This().Config,
            3 => @This().String,
            4 => @This().Interface,
            5 => @This().Endpoint,
            6 => @This().DeviceQualifier,
            else => null,
        };
    }
};

/// Types of transfer that can be indicated by the `attributes` field on
/// `UsbEndpointDescriptor`.
pub const UsbTransferType = enum(u2) {
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3,
};

/// The types of USB SETUP requests that we understand.
pub const UsbSetupRequest = enum(u8) {
    /// Asks the device to send a certain descriptor back to the host. Always
    /// used on an IN request.
    GetDescriptor = 0x06,
    /// Notifies the device that it's being moved to a different address on the
    /// bus. Always an OUT.
    SetAddress = 0x05,
    /// Configures a device by choosing one of the options listed in its
    /// descriptors. Always an OUT.
    SetConfiguration = 0x09,

    pub fn from_u8(request: u8) ?@This() {
        return switch (request) {
            0x06 => UsbSetupRequest.GetDescriptor,
            0x05 => UsbSetupRequest.SetAddress,
            0x09 => UsbSetupRequest.SetConfiguration,
            else => null,
        };
    }
};

/// USB deals in two different transfer directions, called OUT (host-to-device)
/// and IN (device-to-host). In the vast majority of cases, OUT is represented
/// by a 0 byte, and IN by an `0x80` byte.
pub const UsbDir = enum(u8) {
    Out = 0,
    In = 0x80,

    pub inline fn endpoint(self: @This(), num: u8) u8 {
        return num | @enumToInt(self);
    }

    pub inline fn of_endpoint_addr(addr: u8) @This() {
        return if (addr & @enumToInt(@This().In) != 0) @This().In else @This().Out;
    }
};

/// Describes an endpoint within an interface
pub const UsbEndpointDescriptor = packed struct {
    /// Length of this struct, must be 7.
    length: u8,
    /// Type of this descriptor, must be `Endpoint`.
    descriptor_type: UsbDescType,
    /// Address of this endpoint, where the bottom 4 bits give the endpoint
    /// number (0..15) and the top bit distinguishes IN (1) from OUT (0).
    endpoint_address: u8,
    /// Endpoint attributes; the most relevant part is the bottom 2 bits, which
    /// control the transfer type using the values from `UsbTransferType`.
    attributes: u8,
    /// Maximum packet size this endpoint can accept/produce.
    max_packet_size: u16,
    /// Interval for polling interrupt/isochronous endpoints (which we don't
    /// currently support) in milliseconds.
    interval: u8,

    pub fn serialize(self: *const @This()) [7]u8 {
        var out: [7]u8 = undefined;
        out[0] = 7; // length
        out[1] = @enumToInt(self.descriptor_type);
        out[2] = self.endpoint_address;
        out[3] = self.attributes;
        out[4] = @intCast(u8, self.max_packet_size & 0xff);
        out[5] = @intCast(u8, (self.max_packet_size >> 8) & 0xff);
        out[6] = self.interval;
        return out;
    }
};

/// Description of an interface within a configuration.
pub const UsbInterfaceDescriptor = packed struct {
    /// Length of this structure, must be 9.
    length: u8,
    /// Type of this descriptor, must be `Interface`.
    descriptor_type: UsbDescType,
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
        out[0] = 9; // length
        out[1] = @enumToInt(self.descriptor_type);
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

/// Description of a single available device configuration.
pub const UsbConfigurationDescriptor = packed struct {
    /// Length of this structure, must be 9.
    length: u8,
    /// Type of this descriptor, must be `Config`.
    descriptor_type: UsbDescType,
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

    pub fn serialize(self: *const @This()) [9]u8 {
        var out: [9]u8 = undefined;
        out[0] = 9; // length
        out[1] = @enumToInt(self.descriptor_type);
        out[2] = @intCast(u8, self.total_length & 0xff);
        out[3] = @intCast(u8, (self.total_length >> 8) & 0xff);
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
pub const UsbDeviceDescriptor = packed struct {
    /// Length of this structure, must be 18.
    length: u8,
    /// Type of this descriptor, must be `Device`.
    descriptor_type: UsbDescType,
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

    pub fn serialize(self: *const @This()) [18]u8 {
        var out: [18]u8 = undefined;
        out[0] = 18; // length
        out[1] = @enumToInt(self.descriptor_type);
        out[2] = @intCast(u8, self.bcd_usb & 0xff);
        out[3] = @intCast(u8, (self.bcd_usb >> 8) & 0xff);
        out[4] = self.device_class;
        out[5] = self.device_subclass;
        out[6] = self.device_protocol;
        out[7] = self.max_packet_size0;
        out[8] = @intCast(u8, self.vendor & 0xff);
        out[9] = @intCast(u8, (self.vendor >> 8) & 0xff);
        out[10] = @intCast(u8, self.product & 0xff);
        out[11] = @intCast(u8, (self.product >> 8) & 0xff);
        out[12] = @intCast(u8, self.bcd_device & 0xff);
        out[13] = @intCast(u8, (self.bcd_device >> 8) & 0xff);
        out[14] = self.manufacturer_s;
        out[15] = self.product_s;
        out[16] = self.serial_s;
        out[17] = self.num_configurations;
        return out;
    }
};

/// USB Device Qualifier Descriptor
/// This descriptor is mostly the same as the DeviceDescriptor
pub const DeviceQualifierDescriptor = packed struct {
    /// Length of this structure, must be 18.
    length: u8 = 10,
    /// Type of this descriptor, must be `Device`.
    descriptor_type: UsbDescType = UsbDescType.DeviceQualifier,
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

    pub fn serialize(self: *const @This()) [10]u8 {
        var out: [10]u8 = undefined;
        out[0] = 10; // length
        out[1] = @enumToInt(self.descriptor_type);
        out[2] = @intCast(u8, self.bcd_usb & 0xff);
        out[3] = @intCast(u8, (self.bcd_usb >> 8) & 0xff);
        out[4] = self.device_class;
        out[5] = self.device_subclass;
        out[6] = self.device_protocol;
        out[7] = self.max_packet_size0;
        out[8] = self.num_configurations;
        out[9] = self.reserved;
        return out;
    }
};

/// Layout of an 8-byte USB SETUP packet.
pub const UsbSetupPacket = packed struct {
    /// Request type; in practice, this is always either OUT (host-to-device) or
    /// IN (device-to-host), whose values are given in the `UsbDir` enum.
    request_type: u8,
    /// Request. Standard setup requests are in the `UsbSetupRequest` enum.
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

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const UsbEndpointConfiguration = struct {
    descriptor: *const UsbEndpointDescriptor,
    /// Index of this endpoint's control register in the `ep_control` array.
    ///
    /// TODO: this can be derived from the endpoint address, perhaps it should
    /// be.
    endpoint_control_index: ?usize,
    /// Index of this endpoint's buffer control register in the
    /// `ep_buffer_control` array.
    ///
    /// TODO this, too, can be derived.
    buffer_control_index: usize,

    /// Index of this endpoint's data buffer in the array of data buffers
    /// allocated from DPRAM. This can be arbitrary, and endpoints can even
    /// share buffers if you're careful.
    data_buffer_index: usize,

    /// Keeps track of which DATA PID (DATA0/DATA1) is expected on this endpoint
    /// next. If `true`, we're expecting `DATA1`, otherwise `DATA0`.
    next_pid_1: bool,

    /// Optional callback for custom OUT endpoints. This function will be called
    /// if the device receives data on the corresponding endpoint.
    callback: ?*const fn (dc: *UsbDeviceConfiguration, data: []const u8) void = null,
};

pub const UsbDeviceConfiguration = struct {
    device_descriptor: *const UsbDeviceDescriptor,
    interface_descriptor: *const UsbInterfaceDescriptor,
    config_descriptor: *const UsbConfigurationDescriptor,
    lang_descriptor: []const u8,
    descriptor_strings: []const []const u8,
    hid: ?struct {
        hid_descriptor: *const hid.HidDescriptor,
        report_descriptor: []const u8,
    } = null,
    endpoints: [4]*UsbEndpointConfiguration,
};

/// Buffer pointers, once they're prepared and initialized.
pub const Buffers = struct {
    /// Fixed EP0 Buffer0, defined by the hardware
    ep0_buffer0: [*]u8,
    /// Fixed EP0 Buffer1, defined by the hardware and NOT USED in this driver
    ep0_buffer1: [*]u8,
    /// /// Remaining buffer pool
    rest: [16][*]u8,

    /// Gets a buffer corresponding to a `data_buffer_index` in a
    /// `UsbEndpointConfiguration`.
    pub fn get(self: *@This(), i: usize) [*]u8 {
        return switch (i) {
            0 => self.ep0_buffer0,
            1 => self.ep0_buffer1,
            else => self.rest[i - 2],
        };
    }
};

// Handy constants for the endpoints we use here
pub const EP0_IN_ADDR: u8 = UsbDir.In.endpoint(0);
pub const EP0_OUT_ADDR: u8 = UsbDir.Out.endpoint(0);
const EP1_OUT_ADDR: u8 = UsbDir.Out.endpoint(1);
const EP1_IN_ADDR: u8 = UsbDir.In.endpoint(1);
const EP2_IN_ADDR: u8 = UsbDir.In.endpoint(2);

/// USB interrupt status
///
/// __Note__: Available interrupts may change from device to device.
pub const InterruptStatus = struct {
    ///  Host: raised every time the host sends a SOF (Start of Frame)
    BuffStatus: bool = false,
    BusReset: bool = false,
    ///  Set when the device connection state changes
    DevConnDis: bool = false,
    ///  Set when the device suspend state changes
    DevSuspend: bool = false,
    ///  Set when the device receives a resume from the host
    DevResumeFromHost: bool = false,
    /// Setup Request
    SetupReq: bool = false,
};

pub const EPBError = error{
    /// The system has received a buffer event for an unknown endpoint (this is super unlikely)
    UnknownEndpoint,
    /// The buffer is not available (this is super unlikely)
    NotAvailable,
};

/// Element returned by the endpoint buffer iterator (EPBIter)
pub const EPB = struct {
    /// The endpoint the data belongs to
    endpoint: *UsbEndpointConfiguration,
    /// Data buffer
    buffer: []u8,
};

/// Iterator over all input buffers that hold data
pub const EPBIter = struct {
    /// Bitmask of the input buffers to handle
    bufbits: u32,
    /// The last input buffer handled. This can be used to flag the input buffer as handled on the
    /// next call.
    last_bit: ?u32 = null,
    /// Point to the device configuration (to get access to the endpoint buffers defined by the user)
    device_config: *const UsbDeviceConfiguration,
    /// Get the next available input buffer
    next: *const fn (self: *@This()) ?EPB,
};

test "tests" {
    _ = hid;
}
