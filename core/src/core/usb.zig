//! Abstract USB device implementation
//!
//! This can be used to setup a USB device.
//!
//! ## Usage
//!
//! 1. Define the functions (`pub const F = struct { ... }`) required by `Usb()` (see below)
//! 2. Call `pub const device = Usb(F)`
//! 3. Define the device configuration (DeviceConfiguration)
//! 4. Initialize the device in main by calling `usb.init_clk()` and `usb.init_device(device_conf)`
//! 5. Call `usb.task()` within the main loop

const std = @import("std");
const buffers = @import("buffers.zig");

/// USB common descriptors
pub const desc = @import("usb/descriptors.zig");
/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");
/// USB Communications Device Class (CDC)
pub const cdc = @import("usb/cdc.zig");

const DescType = desc.DescType;
const BufferReader = buffers.BufferReader;
const BufferWriter = buffers.BufferWriter;

/// Create a USB device
///
/// # Arguments
///
/// This is a abstract USB device implementation that requires a handful of functions
/// to work correctly:
///
/// * `usb_init_clk() void` - Initialize the USB clock
/// * `usb_init_device(*DeviceConfiguration) - Initialize the USB device controller (e.g. enable interrupts, etc.)
/// * `usb_start_tx(*EndpointConfiguration, []const u8)` - Transmit the given bytes over the specified endpoint
/// * `usb_start_rx(*usb.EndpointConfiguration, n: usize)` - Receive n bytes over the specified endpoint
/// * `get_interrupts() InterruptStatus` - Return which interrupts haven't been handled yet
/// * `get_setup_packet() SetupPacket` - Return the USB setup packet received (called if SetupReq received). Make sure to clear the status flag yourself!
/// * `bus_reset() void` - Called on a bus reset interrupt
/// * `set_address(addr: u7) void` - Set the given address
/// * `get_EPBIter(*const DeviceConfiguration) EPBIter` - Return an endpoint buffer iterator. Each call to next returns an unhandeled endpoint buffer with data. How next is implemented depends on the system.
/// The functions must be grouped under the same name space and passed to the fuction at compile time.
/// The functions will be accessible to the user through the `callbacks` field.
pub fn Usb(comptime f: anytype) type {
    return struct {
        /// The usb configuration set
        var usb_config: ?*DeviceConfiguration = null;
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
        pub fn init_device(device_config: *DeviceConfiguration) !void {
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
                var tmp: [128]u8 = .{0} ** 128;
                // Keeps track of sent data from tmp buffer
                var buffer_reader = BufferReader { .buffer = &.{} };
            };
            
            // Command endpoint utilities
            const CmdEndpoint = struct {

                /// Command response utility function that can split long data in multiple packets
                fn send_cmd_response(data: []const u8, expected_max_length: u16) void {
                    const cmd_in_endpoint = usb_config.?.endpoints[EP0_IN_IDX];

                    S.buffer_reader = BufferReader { .buffer = data[0..@min(data.len, expected_max_length)] };
                    const data_chunk = S.buffer_reader.try_peek(cmd_in_endpoint.descriptor.max_packet_size);

                    if (data_chunk.len > 0) {
                        f.usb_start_tx(
                            cmd_in_endpoint,
                            data_chunk
                        );
                    }
                }
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
                const reqty = Dir.of_endpoint_addr(setup.request_type);
                const req = SetupRequest.from_u8(setup.request);

                if (reqty == Dir.Out and req != null and req.? == SetupRequest.SetAddress) {
                    // The new address is in the bottom 8 bits of the setup
                    // packet value field. Store it for use later.
                    S.new_address = @as(u8, @intCast(setup.value & 0xff));
                    // The address will actually get set later, we have
                    // to use address 0 to send a status response.
                    f.usb_start_tx(
                        usb_config.?.endpoints[EP0_IN_IDX], //EP0_IN_CFG,
                        &.{}, // <- see, empty buffer
                    );
                    if (debug) std.log.info("    SetAddress: {}", .{S.new_address.?});
                } else if (reqty == Dir.Out and req != null and req.? == SetupRequest.SetConfiguration) {
                    // We only have one configuration, and it doesn't really
                    // mean anything to us -- more of a formality. All we do in
                    // response to this is:
                    S.configured = true;
                    f.usb_start_tx(
                        usb_config.?.endpoints[EP0_IN_IDX], //EP0_IN_CFG,
                        &.{}, // <- see, empty buffer
                    );
                    if (debug) std.log.info("    SetConfiguration", .{});
                } else if (reqty == Dir.Out) {
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
                } else if (reqty == Dir.In and req != null and req.? == SetupRequest.GetDescriptor) {
                    // Identify the requested descriptor type, which is in the
                    // _top_ 8 bits of value.
                    const descriptor_type = DescType.from_u16(setup.value >> 8);
                    if (debug) std.log.info("    GetDescriptor: {}", .{setup.value >> 8});
                    if (descriptor_type) |dt| {
                        switch (dt) {
                            .Device => {
                                if (debug) std.log.info("        Device", .{});
                                // TODO: this sure looks like a duplicate, but it's
                                // a duplicate that was present in the C
                                // implementation.
                                usb_config.?.endpoints[EP0_IN_IDX].next_pid_1 = true;

                                var bw = BufferWriter { .buffer = &S.tmp };
                                try usb_config.?.device_descriptor.serialize(&bw);

                                CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                            },
                            .Config => {
                                if (debug) std.log.info("        Config", .{});
                                
                                var bw = BufferWriter { .buffer = &S.tmp };
                                for (usb_config.?.config_descriptors) |config| {
                                    try config.serialize(&bw);
                                }

                                CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                            },
                            .String => {
                                if (debug) std.log.info("        String", .{});
                                // String descriptor index is in bottom 8 bits of
                                // `value`.
                                const i: usize = @intCast(setup.value & 0xff);
                                const bytes = StringBlk: {
                                    if (i == 0) {
                                        // Special index 0 requests the language
                                        // descriptor.
                                        break :StringBlk usb_config.?.lang_descriptor;
                                    } else {
                                        // Otherwise, set up one of our strings.
                                        const s = usb_config.?.descriptor_strings[i - 1];
                                        const len = 2 + s.len;

                                        var wb = BufferWriter { .buffer = &S.tmp };
                                        try wb.write_int(u8, @intCast(len));
                                        try wb.write_int(u8, 0x03);
                                        try wb.write(s);

                                        break :StringBlk wb.get_written_slice();
                                    }
                                };
                                
                                CmdEndpoint.send_cmd_response(bytes, setup.length);
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
                                const dqd = desc.DeviceQualifierDescriptor{
                                    .bcd_usb = usb_config.?.device_descriptor.bcd_usb,
                                    .device_class = usb_config.?.device_descriptor.device_class,
                                    .device_subclass = usb_config.?.device_descriptor.device_subclass,
                                    .device_protocol = usb_config.?.device_descriptor.device_protocol,
                                    .max_packet_size0 = usb_config.?.device_descriptor.max_packet_size0,
                                    .num_configurations = usb_config.?.device_descriptor.num_configurations,
                                };

                                var bw = BufferWriter { .buffer = &S.tmp };
                                try dqd.serialize(&bw);

                                CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                            },
                            else => {}
                        }
                    } else {
                        // Maybe the unknown request type is a hid request

                        if (usb_config.?.hid) |hid_conf| {
                            const _hid_desc_type = hid.DescType.from_u16(setup.value >> 8);

                            if (_hid_desc_type) |hid_desc_type| {
                                switch (hid_desc_type) {
                                    .Hid => {
                                        if (debug) std.log.info("        HID", .{});

                                        // Ignore, we are sending it in config descriptor
                                    },
                                    .Report => {
                                        if (debug) std.log.info("        Report", .{});

                                        // The report descriptor is already a (static)
                                        // u8 array, i.e., we can pass it directly
                                        CmdEndpoint.send_cmd_response(hid_conf.report_descriptor, setup.length);
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
                } else if (reqty == Dir.In) {
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
                            
                            const cmd_in_endpoint = usb_config.?.endpoints[EP0_IN_IDX];
                            const buffer_reader = &S.buffer_reader;
                            
                            // We use this opportunity to finish the delayed
                            // SetAddress request, if there is one:
                            if (S.new_address) |addr| {
                                // Change our address:
                                f.set_address(@intCast(addr));
                            }
                            
                            if (epb.buffer.len > 0 and buffer_reader.get_remaining_bytes_count() > 0) {
                                _ = buffer_reader.try_advance(epb.buffer.len);
                                const next_data_chunk = buffer_reader.try_read(cmd_in_endpoint.descriptor.max_packet_size);
                                if (next_data_chunk.len > 0) {
                                    f.usb_start_tx(
                                         cmd_in_endpoint,
                                         next_data_chunk,
                                     );
                                } else {
                                    f.usb_start_rx(
                                        usb_config.?.endpoints[EP0_OUT_IDX], // EP0_OUT_CFG,
                                        0,
                                    );
                                }
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
                S.buffer_reader = BufferReader { .buffer = &.{} };
            }

            // If we have been configured but haven't reached this point yet, set up
            // our custom EP OUT's to receive whatever data the host wants to send.
            if (S.configured and !S.started) {
                // We can skip the first two endpoints because those are EP0_OUT and EP0_IN
                for (usb_config.?.endpoints[2..]) |ep| {
                    if (Dir.of_endpoint_addr(ep.descriptor.endpoint_address) == .Out) {
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

//            -------------------------
//            |    DeviceDescriptor   |
//            -------------------------
//                        |
//                        v
//            -------------------------
//            |   ConfigurationDesc   |
//            -------------------------
//                        |
//                        v
//            -------------------------
//            | InterfaceDescriptor   |
//            -------------------------
//                        |    |
//                        v    ------------------------------
//            -------------------------                     |
//            |  EndpointDescriptor   |                     v
//            -------------------------            ---------------------
//                                                 |   HID Descriptor  |
//                                                 ---------------------

/// Types of transfer that can be indicated by the `attributes` field on
/// `EndpointDescriptor`.
pub const TransferType = enum(u2) {
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3,
};

/// The types of USB SETUP requests that we understand.
pub const SetupRequest = enum(u8) {
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
            0x06 => SetupRequest.GetDescriptor,
            0x05 => SetupRequest.SetAddress,
            0x09 => SetupRequest.SetConfiguration,
            else => null,
        };
    }
};

/// USB deals in two different transfer directions, called OUT (host-to-device)
/// and IN (device-to-host). In the vast majority of cases, OUT is represented
/// by a 0 byte, and IN by an `0x80` byte.
pub const Dir = enum(u8) {
    Out = 0,
    In = 0x80,

    pub inline fn endpoint(self: @This(), num: u8) u8 {
        return num | @intFromEnum(self);
    }

    pub inline fn of_endpoint_addr(addr: u8) @This() {
        return if (addr & @intFromEnum(@This().In) != 0) @This().In else @This().Out;
    }
};

/// Layout of an 8-byte USB SETUP packet.
pub const SetupPacket = extern struct {
    request_type: u8,
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

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const EndpointConfiguration = struct {
    descriptor: *const desc.EndpointDescriptor,
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
    callback: ?*const fn (dc: *DeviceConfiguration, data: []const u8) void = null,
};

pub const DescriptorConfig = union(enum) {
    configuration: *const desc.ConfigurationDescriptor,
    endpoint: *const desc.EndpointDescriptor,
    interface: *const desc.InterfaceDescriptor,
    interface_association: *const desc.InterfaceAssociationDescriptor,
    hid: *const HidDescriptorConfig,
    cdc: *const CdcDescriptorConfig,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const HidDescriptorConfig = union(enum) {
    hid: *const hid.HidDescriptor,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const CdcDescriptorConfig = union(enum) {
    cdc_header: *const cdc.CdcHeaderDescriptor,
    cdc_call_management: *const cdc.CdcCallManagementDescriptor,
    cdc_acm: *const cdc.CdcAcmDescriptor,
    cdc_union: *const cdc.CdcUnionDescriptor,

    pub fn serialize(self: *const @This(), buff: *BufferWriter) BufferWriter.Error!void {
        switch (self.*) {
            inline else => |case| try case.serialize(buff),
        }
    }
};

pub const DescriptorsConfigTemplates = struct {
    pub const config_descriptor_len = 9;

    pub fn config_descriptor(config_num: u8, interfaces_num: u8, string_index: u8, total_len: u16, attributes: u8, max_power_ma: u9) [1]DescriptorConfig {
        return [1]DescriptorConfig {
            .{ .configuration = &.{ .total_length = total_len, .num_interfaces = interfaces_num, .configuration_value = config_num, .configuration_s = string_index, .attributes = 0b01000000 | attributes, .max_power = max_power_ma/2 } }
        };
    }

    pub const cdc_descriptor_len = 8 + 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7;

    pub fn cdc_descriptor(interface_number: u8, string_index: u8, endpoint_notifi_address: u8, endpoint_notifi_size: u16, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16) [10]DescriptorConfig {
        return [10]DescriptorConfig {
            .{ .interface_association = &.{ .first_interface = interface_number, .interface_count = 2, .function_class = 2, .function_subclass = 2, .function_protocol = 0, .function = 0 } },
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 2, .interface_subclass = 2, .interface_protocol = 0, .interface_s = string_index } },
            .{ .cdc = &.{ .cdc_header = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .Header, .bcd_cdc = 0x0120 } } },
            .{ .cdc = &.{ .cdc_call_management = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .CallManagement, .capabilities = 0, .data_interface = interface_number + 1 } } },
            .{ .cdc = &.{ .cdc_acm = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .ACM, .capabilities = 6 } } },
            .{ .cdc = &.{ .cdc_union = &.{ .descriptor_type = .CsInterface, .descriptor_subtype = .Union, .master_interface = interface_number, .slave_interface_0 = interface_number + 1 } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_notifi_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_notifi_size, .interval = 16 } },
            .{ .interface = &.{ .interface_number = interface_number + 1, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 10, .interface_subclass = 0, .interface_protocol = 0, .interface_s = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
        };
    }

    pub const hid_in_descriptor_len = 9 + 9 + 7;

    pub fn hid_in_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_in_address: u8, endpoint_size: u16, endpoint_interval: u16) [3]DescriptorConfig {
        return [3]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 1, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index } },
            .{ .hid = &.{ .hid = &.{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
        };
    }

    pub const hid_inout_descriptor_len = 9 + 9 + 7 + 7;

    pub fn hid_inout_descriptor(interface_number: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16, endpoint_interval: u16) [4]DescriptorConfig {
        return [4]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 3, .interface_subclass = if (boot_protocol > 0) 1 else 0, .interface_protocol = boot_protocol, .interface_s = string_index } },
            .{ .hid = &.{ .hid = &.{ .bcd_hid = 0x0111, .country_code = 0, .num_descriptors = 1, .report_length = report_desc_len } } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Interrupt), .max_packet_size = endpoint_size, .interval = endpoint_interval } },
        };
    }

    pub const vendor_descriptor_len = 9 + 7 + 7;

    pub fn vendor_descriptor(interface_number: u8, string_index: u8, endpoint_out_address: u8, endpoint_in_address: u8, endpoint_size: u16) [3]DescriptorConfig {
        return [3]DescriptorConfig {
            .{ .interface = &.{ .interface_number = interface_number, .alternate_setting = 0, .num_endpoints = 2, .interface_class = 0xff, .interface_subclass = 0, .interface_protocol = 0, .interface_s = string_index } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_out_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
            .{ .endpoint = &.{ .endpoint_address = endpoint_in_address, .attributes = @intFromEnum(TransferType.Bulk), .max_packet_size = endpoint_size, .interval = 0 } },
        };
    }
};

pub const ConfigUtils = struct {
    pub fn get_enpoint_descriptor(comptime endpoint_address: u8, comptime N: usize, array: [N]DescriptorConfig) *const desc.EndpointDescriptor {
        for (array) |config| {
            switch (config) {
                .endpoint => |endpoint| {
                    if (endpoint.endpoint_address == endpoint_address) return endpoint;
                },
                else => {}
            }
        }
        @compileError("Can't find endpoint descriptor");
    }
};

pub const DeviceConfiguration = struct {
    device_descriptor: *const desc.DeviceDescriptor,
    config_descriptors: []const DescriptorConfig,
    lang_descriptor: []const u8,
    descriptor_strings: []const []const u8,
    hid: ?struct {
        report_descriptor: []const u8,
    } = null,
    endpoints: [4]*EndpointConfiguration,
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
    /// `EndpointConfiguration`.
    pub fn get(self: *@This(), i: usize) [*]u8 {
        return switch (i) {
            0 => self.ep0_buffer0,
            1 => self.ep0_buffer1,
            else => self.rest[i - 2],
        };
    }
};

// Handy constants for the endpoints we use here
pub const EP0_IN_ADDR: u8 = Dir.In.endpoint(0);
pub const EP0_OUT_ADDR: u8 = Dir.Out.endpoint(0);
const EP1_OUT_ADDR: u8 = Dir.Out.endpoint(1);
const EP1_IN_ADDR: u8 = Dir.In.endpoint(1);
const EP2_IN_ADDR: u8 = Dir.In.endpoint(2);

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
    endpoint: *EndpointConfiguration,
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
    device_config: *const DeviceConfiguration,
    /// Get the next available input buffer
    next: *const fn (self: *@This()) ?EPB,
};

/// Convert an utf8 into an utf16 (little endian) string
pub fn utf8Toutf16Le(comptime s: []const u8) [s.len << 1]u8 {
    const l = s.len << 1;
    var ret: [l]u8 = .{0} ** l;
    var i: usize = 0;
    while (i < s.len) : (i += 1) {
        ret[i << 1] = s[i];
    }
    return ret;
}

test "tests" {
    _ = hid;
}

test "utf8 to utf16" {
    try std.testing.expectEqualSlices(u8, "M\x00y\x00 \x00V\x00e\x00n\x00d\x00o\x00r\x00", &utf8Toutf16Le("My Vendor"));
    try std.testing.expectEqualSlices(u8, "R\x00a\x00s\x00p\x00b\x00e\x00r\x00r\x00y\x00 \x00P\x00i\x00", &utf8Toutf16Le("Raspberry Pi"));
}
