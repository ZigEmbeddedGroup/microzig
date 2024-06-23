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
const builtin = @import("builtin");

/// USB primitive types
pub const types = @import("usb/types.zig");
/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");
pub const templates = @import("usb/templates.zig");


const DescType = types.DescType;
const Dir = types.Dir;
const SetupRequest = types.SetupRequest;

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
                    const cmd_in_endpoint = usb_config.?.endpoints[Endpoint.EP0_IN_IDX];

                    S.buffer_reader = BufferReader { .buffer = data[0..@min(data.len, expected_max_length)] };
                    const data_chunk = S.buffer_reader.try_peek(cmd_in_endpoint.descriptor.max_packet_size);

                    if (data_chunk.len > 0) {
                        f.usb_start_tx(
                            cmd_in_endpoint,
                            data_chunk
                        );
                    }
                }

                fn send_cmd_ack() void {
                    f.usb_start_tx(
                        usb_config.?.endpoints[Endpoint.EP0_IN_IDX],
                        &.{},
                    );
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
                usb_config.?.endpoints[Endpoint.EP0_IN_IDX].next_pid_1 = true;

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
                    CmdEndpoint.send_cmd_ack();
                    if (debug) std.log.info("    SetAddress: {}", .{S.new_address.?});
                } else if (reqty == Dir.Out and req != null and req.? == SetupRequest.SetConfiguration) {
                    // We only have one configuration, and it doesn't really
                    // mean anything to us -- more of a formality. All we do in
                    // response to this is:
                    S.configured = true;
                    CmdEndpoint.send_cmd_ack();
                    if (debug) std.log.info("    SetConfiguration", .{});
                } else if (reqty == Dir.Out) {
                    // This is sort of a hack, but: if we get any other kind of
                    // OUT, just acknowledge it with the same zero-length status
                    // phase that we use for control transfers that we _do_
                    // understand. This keeps the host from spinning forever
                    // while we NAK.
                    //
                    // This behavior copied shamelessly from the C example.
                    CmdEndpoint.send_cmd_ack();
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
                                usb_config.?.endpoints[Endpoint.EP0_IN_IDX].next_pid_1 = true;

                                var bw = BufferWriter { .buffer = &S.tmp };
                                try bw.write(&usb_config.?.device_descriptor.serialize());

                                CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                            },
                            .Config => {
                                if (debug) std.log.info("        Config", .{});
                                
                                var bw = BufferWriter { .buffer = &S.tmp };
                                try bw.write(usb_config.?.config_descriptor);

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
                                const dqd = types.DeviceQualifierDescriptor{
                                    .bcd_usb = usb_config.?.device_descriptor.bcd_usb,
                                    .device_class = usb_config.?.device_descriptor.device_class,
                                    .device_subclass = usb_config.?.device_descriptor.device_subclass,
                                    .device_protocol = usb_config.?.device_descriptor.device_protocol,
                                    .max_packet_size0 = usb_config.?.device_descriptor.max_packet_size0,
                                    .num_configurations = usb_config.?.device_descriptor.num_configurations,
                                };

                                var bw = BufferWriter { .buffer = &S.tmp };
                                try bw.write(&dqd.serialize());

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
                            
                            const cmd_in_endpoint = usb_config.?.endpoints[Endpoint.EP0_IN_IDX];
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
                                        usb_config.?.endpoints[Endpoint.EP0_OUT_IDX], // EP0_OUT_CFG,
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
                                    usb_config.?.endpoints[Endpoint.EP0_OUT_IDX], // EP0_OUT_CFG,
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

    pub const EP0_OUT_IDX = 0;
    pub const EP0_IN_IDX = 1;

    pub const EP0_IN_ADDR: u8 = to_address(0, .In);
    pub const EP0_OUT_ADDR: u8 = to_address(0, .Out);
};

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const EndpointConfiguration = struct {
    descriptor: *const types.EndpointDescriptor,
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

pub const DeviceConfiguration = struct {
    device_descriptor: *const types.DeviceDescriptor,
    config_descriptor: []const u8,
    lang_descriptor: []const u8,
    descriptor_strings: []const []const u8,
    hid: ?struct {
        report_descriptor: []const u8,
    } = null,
    endpoints: [2]*EndpointConfiguration,
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

const BufferWriter = struct {
    buffer: []u8,
    pos: usize = 0,
    endian: std.builtin.Endian = builtin.cpu.arch.endian(),

    pub const Error = error{ EndOfBuffer };

    /// Moves forward write cursor by the provided number of bytes.
    pub fn advance(self: *@This(), bytes: usize) Error!void {
        try self.bound_check(bytes);
        self.advance_unsafe(bytes);
    }

    /// Writes data provided as a slice to the buffer and moves write cursor forward by data size.
    pub fn write(self: *@This(), data: []const u8) Error!void {
        try self.bound_check(data.len);
        defer self.advance_unsafe(data.len);
        @memcpy(self.buffer[self.pos..self.pos + data.len], data);
    }

    /// Writes an int with respect to the buffer's endianness and moves write cursor forward by int size.
    pub fn write_int(self: *@This(), comptime T: type, value: T) Error!void {
        const size = @divExact(@typeInfo(T).Int.bits, 8);
        try self.bound_check(size);
        defer self.advance_unsafe(size);
        std.mem.writeInt(T, self.buffer[self.pos..][0..size], value, self.endian);
    }

    /// Writes an int with respect to the buffer's endianness but skip bound check.
    /// Useful in cases where the bound can be checked once for batch of ints.
    pub fn write_int_unsafe(self: *@This(), comptime T: type, value: T) void {
        const size = @divExact(@typeInfo(T).Int.bits, 8);
        defer self.advance_unsafe(size);
        std.mem.writeInt(T, self.buffer[self.pos..][0..size], value, self.endian);
    }

    /// Returns a slice of the internal buffer containing the written data.
    pub fn get_written_slice(self: *const @This()) []const u8 {
        return self.buffer[0..self.pos];
    }

    /// Performs a buffer bound check against the current cursor position and the provided number of bytes to check forward.
    pub fn bound_check(self: *const @This(), bytes: usize) Error!void {
        if (self.pos + bytes > self.buffer.len) return error.EndOfBuffer;
    }

    fn advance_unsafe(self: *@This(), bytes: usize) void {
        self.pos += bytes;
    }
};

const BufferReader = struct {
    buffer: []const u8,
    pos: usize = 0,
    endian: std.builtin.Endian = builtin.cpu.arch.endian(),

    /// Attempts to move read cursor forward by the specified number of bytes.
    /// Returns the actual number of bytes advanced, up to the specified number.
    pub fn try_advance(self: *@This(), bytes: usize) usize {
        const size = @min(bytes, self.buffer.len - self.pos);
        self.advance_unsafe(size);
        return size;
    }

    /// Attempts to read the given amount of bytes (or less if close to buffer end) and advances the read cursor.
    pub fn try_read(self: *@This(), bytes: usize) []const u8 {
        const size = @min(bytes, self.buffer.len - self.pos);
        defer self.advance_unsafe(size);
        return self.buffer[self.pos..self.pos + size];
    }

    /// Attempts to read the given amount of bytes (or less if close to buffer end) without advancing the read cursor.
    pub fn try_peek(self: *@This(), bytes: usize) []const u8 {
        const size = @min(bytes, self.buffer.len - self.pos);
        return self.buffer[self.pos..self.pos + size];
    }

    /// Returns the number of bytes remaining from the current read cursor position to the end of the underlying buffer.
    pub fn get_remaining_bytes_count(self: *const @This()) usize {
        return self.buffer.len - self.pos;
    }

    fn advance_unsafe(self: *@This(), bytes: usize) void {
        self.pos += bytes;
    }
};

pub const UsbUtils = struct {
    /// Convert an utf8 into an utf16 (little endian) string
    pub fn utf8ToUtf16Le(comptime s: []const u8) [s.len << 1]u8 {
        const l = s.len << 1;
        var ret: [l]u8 = .{0} ** l;
        var i: usize = 0;
        while (i < s.len) : (i += 1) {
            ret[i << 1] = s[i];
        }
        return ret;
    }
};

test "tests" {
    _ = hid;
}

test "utf8 to utf16" {
    try std.testing.expectEqualSlices(u8, "M\x00y\x00 \x00V\x00e\x00n\x00d\x00o\x00r\x00", &UsbUtils.utf8Toutf16Le("My Vendor"));
    try std.testing.expectEqualSlices(u8, "R\x00a\x00s\x00p\x00b\x00e\x00r\x00r\x00y\x00 \x00P\x00i\x00", &UsbUtils.utf8Toutf16Le("Raspberry Pi"));
}
