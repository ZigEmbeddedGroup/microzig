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

/// USB primitive types
pub const types = @import("usb/types.zig");
/// USB common descriptors
pub const desc = @import("usb/descriptors.zig");
/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");
/// USB Communications Device Class (CDC)
pub const cdc = @import("usb/cdc.zig");
/// Configuration
pub const config = @import("usb/config.zig");

const DescType = types.DescType;
const Dir = types.Dir;
const SetupRequest = types.SetupRequest;
const BufferReader = buffers.BufferReader;
const BufferWriter = buffers.BufferWriter;
const DeviceConfiguration = config.DeviceConfiguration;
const EndpointConfiguration = config.EndpointConfiguration;

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
                const reqty = setup.request_type.direction;
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
                                for (usb_config.?.config_descriptors) |config_desc| {
                                    try config_desc.serialize(&bw);
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
                        Endpoint.EP0_IN_ADDR => {
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
                    if (Endpoint.dir_from_address(ep.descriptor.endpoint_address) == .Out) {
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


pub const Endpoint = struct {
    pub inline fn to_address(num: u8, dir: Dir) u8 {
        return switch (dir) {
            .Out => num,
            .In => num | Dir.DIR_IN_MASK
        };
    }

    pub inline fn dir_from_address(addr: u8) Dir {
        return if (addr & Dir.DIR_IN_MASK != 0) Dir.In else Dir.Out;
    }

    pub const EP0_IN_ADDR: u8 = to_address(0, .In);
    pub const EP0_OUT_ADDR: u8 = to_address(0, .Out);
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

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


test "tests" {
    _ = hid;
}