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
const assert = std.debug.assert;
const log = std.log.scoped(.usb);

pub const cdc = @import("usb/cdc.zig");
pub const descriptor = @import("usb/descriptor.zig");
pub const hid = @import("usb/hid.zig");
pub const types = @import("usb/types.zig");

pub const vendor = @import("usb/vendor.zig");
pub const utils = @import("usb/utils.zig");
pub const templates = @import("usb/templates.zig");

const EpNum = types.Endpoint.Num;

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
        var itf_to_drv: [f.cfg_max_interfaces_count]u8 = @splat(0);
        var ep_to_drv: [f.cfg_max_endpoints_count][2]u8 = @splat(@splat(0));
        pub const max_packet_size = if (f.high_speed) 512 else 64;
        const drvid_invalid = 0xff;

        /// The callbacks passed provided by the caller
        pub const callbacks = f;

        // We'll keep some state in Plain Old Static Local Variables:
        const S = struct {
            var debug_mode = false;
            // When the host gives us a new address, we can't just slap it into
            // registers right away, because we have to do an acknowledgement step using
            // our _old_ address.
            var new_address: ?u8 = null;
            // 0 - no config set
            var cfg_num: u16 = 0;
            // Flag recording whether the host has configured us with a
            // `SetConfiguration` message.
            var configured = false;
            // Flag recording whether we've set up buffer transfers after being
            // configured.
            var started = false;
            // Some scratch space that we'll use for things like preparing string
            // descriptors for transmission.
            var tmp: [128]u8 = @splat(0);
            // Keeps track of sent data from tmp buffer
            var buffer_reader = BufferReader{ .buffer = &.{} };
            // Last setup packet request
            var setup_packet: types.SetupPacket = undefined;
            // Class driver associated with last setup request if any
            var driver: ?*types.UsbClassDriver = null;
        };

        // Command endpoint utilities
        const CmdEndpoint = struct {
            /// Command response utility function that can split long data in multiple packets
            fn send_cmd_response(data: []const u8, expected_max_length: u16) void {
                S.buffer_reader = BufferReader{ .buffer = data[0..@min(data.len, expected_max_length)] };
                const data_chunk = S.buffer_reader.try_peek(64);

                if (data_chunk.len > 0) {
                    f.usb_start_tx(.ep0, data_chunk);
                }
            }

            fn send_cmd_ack() void {
                f.usb_start_tx(.ep0, &.{});
            }
        };

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

            const device_interface = device();
            for (usb_config.?.drivers) |*driver| {
                driver.init(device_interface);
            }
        }

        fn device() types.UsbDevice {
            return .{
                .fn_ready = device_ready,
                .fn_control_transfer = device_control_transfer,
                .fn_control_ack = device_control_ack,
                .fn_endpoint_open = device_endpoint_open,
                .fn_endpoint_transfer = device_endpoint_transfer,
            };
        }

        fn device_ready() bool {
            return S.started;
        }

        fn device_control_transfer(setup: *const types.SetupPacket, data: []const u8) void {
            CmdEndpoint.send_cmd_response(data, setup.length);
        }

        fn device_control_ack(_: *const types.SetupPacket) void {
            CmdEndpoint.send_cmd_ack();
        }

        fn device_endpoint_open(ep_desc: []const u8) void {
            const ep: types.Endpoint = @bitCast(utils.BosConfig.get_data_u8(ep_desc, 2));
            const ep_transfer_type = utils.BosConfig.get_data_u8(ep_desc, 3);
            const ep_max_packet_size = @as(u11, @intCast(utils.BosConfig.get_data_u16(ep_desc, 4) & 0x7FF));

            f.endpoint_open(ep, ep_max_packet_size, std.meta.intToEnum(types.TransferType, ep_transfer_type) catch .Bulk);
        }

        fn device_endpoint_transfer(ep: types.Endpoint, data: []const u8) void {
            switch (ep.dir) {
                .In => f.usb_start_tx(ep.num, data),
                .Out => f.usb_start_rx(ep.num, max_packet_size),
            }
        }

        fn get_driver(drv_idx: u8) ?*types.UsbClassDriver {
            if (drv_idx == drvid_invalid) {
                return null;
            }
            return &usb_config.?.drivers[drv_idx];
        }

        fn get_setup_packet() types.SetupPacket {
            const setup = f.get_setup_packet();
            S.setup_packet = setup;
            S.driver = null;
            return setup;
        }

        fn configuration_reset() void {
            @memset(&itf_to_drv, drvid_invalid);
            @memset(&ep_to_drv, .{ drvid_invalid, drvid_invalid });
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// This function will return an error if the device hasn't been initialized.
        pub fn task(debug: bool) !void {
            if (usb_config == null) return error.UninitializedDevice;

            S.debug_mode = debug;

            // Device Specific Request
            const DeviceRequestProcessor = struct {
                fn process_setup_request(setup: *const types.SetupPacket) !void {
                    switch (setup.request_type.type) {
                        .Class => {
                            //const itfIndex = setup.index & 0x00ff;
                            log.info("Device.Class", .{});
                        },
                        .Standard => {
                            const req = types.SetupRequest.from_u8(setup.request);
                            if (req == null) return;
                            switch (req.?) {
                                .SetAddress => {
                                    S.new_address = @as(u8, @intCast(setup.value & 0xff));
                                    CmdEndpoint.send_cmd_ack();
                                    if (S.debug_mode) log.info("    SetAddress: {}", .{S.new_address.?});
                                },
                                .SetConfiguration => {
                                    if (S.debug_mode) log.info("    SetConfiguration", .{});
                                    const cfg_num = setup.value;
                                    if (S.cfg_num != cfg_num) {
                                        if (S.cfg_num > 0) {
                                            configuration_reset();
                                        }

                                        if (cfg_num > 0) {
                                            try process_set_config(cfg_num - 1);
                                            // TODO: call mount callback if any
                                        } else {
                                            // TODO: call umount callback if any
                                        }
                                    }
                                    S.cfg_num = cfg_num;
                                    S.configured = true;
                                    CmdEndpoint.send_cmd_ack();
                                },
                                .GetDescriptor => {
                                    const descriptor_type = std.meta.intToEnum(descriptor.Type, setup.value >> 8) catch null;
                                    if (descriptor_type) |dt| {
                                        try process_get_descriptor(setup, dt);
                                    }
                                },
                                .SetFeature => {
                                    const feature = types.FeatureSelector.from_u8(@intCast(setup.value >> 8));
                                    if (feature) |feat| {
                                        switch (feat) {
                                            .DeviceRemoteWakeup, .EndpointHalt => CmdEndpoint.send_cmd_ack(),
                                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                                            .TestMode => {},
                                        }
                                    }
                                },
                            }
                        },
                        else => {},
                    }
                }

                fn process_get_descriptor(setup: *const types.SetupPacket, descriptor_type: descriptor.Type) !void {
                    switch (descriptor_type) {
                        .Device => {
                            if (S.debug_mode) log.info("        Device", .{});

                            var bw = BufferWriter{ .buffer = &S.tmp };
                            try bw.write(&usb_config.?.device_descriptor.serialize());

                            CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                        },
                        .Configuration => {
                            if (S.debug_mode) log.info("        Config", .{});

                            var bw = BufferWriter{ .buffer = &S.tmp };
                            try bw.write(usb_config.?.config_descriptor);

                            CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                        },
                        .String => {
                            if (S.debug_mode) log.info("        String", .{});
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

                                    var wb = BufferWriter{ .buffer = &S.tmp };
                                    try wb.write_int(u8, @intCast(len));
                                    try wb.write_int(u8, 0x03);
                                    try wb.write(s);

                                    break :StringBlk wb.get_written_slice();
                                }
                            };

                            CmdEndpoint.send_cmd_response(bytes, setup.length);
                        },
                        .Interface => {
                            if (S.debug_mode) log.info("        Interface", .{});
                        },
                        .Endpoint => {
                            if (S.debug_mode) log.info("        Endpoint", .{});
                        },
                        .DeviceQualifier => {
                            if (S.debug_mode) log.info("        DeviceQualifier", .{});
                            // We will just copy parts of the DeviceDescriptor because
                            // the DeviceQualifierDescriptor can be seen as a subset.
                            const dqd = descriptor.Device.Qualifier{
                                .bcd_usb = usb_config.?.device_descriptor.bcd_usb,
                                .device_triple = usb_config.?.device_descriptor.device_triple,
                                .max_packet_size0 = usb_config.?.device_descriptor.max_packet_size0,
                                .num_configurations = usb_config.?.device_descriptor.num_configurations,
                            };

                            var bw = BufferWriter{ .buffer = &S.tmp };
                            try bw.write(&dqd.serialize());

                            CmdEndpoint.send_cmd_response(bw.get_written_slice(), setup.length);
                        },
                        else => {},
                    }
                }

                fn process_set_config(_: u16) !void {
                    // TODO: we support just one config for now so ignore config index
                    const bos_cfg = usb_config.?.config_descriptor;

                    var curr_bos_cfg = bos_cfg;
                    var curr_drv_idx: u8 = 0;

                    if (utils.BosConfig.try_get_desc_as(descriptor.Configuration, curr_bos_cfg)) |_| {
                        curr_bos_cfg = utils.BosConfig.get_desc_next(curr_bos_cfg);
                    } else {
                        // TODO - error
                        return;
                    }

                    while (curr_bos_cfg.len > 0) : (curr_drv_idx += 1) {
                        var assoc_itf_count: u8 = 1;
                        // New class starts optionally from InterfaceAssociation followed by mandatory Interface
                        if (utils.BosConfig.try_get_desc_as(descriptor.InterfaceAssociation, curr_bos_cfg)) |desc_assoc_itf| {
                            assoc_itf_count = desc_assoc_itf.interface_count;
                            curr_bos_cfg = utils.BosConfig.get_desc_next(curr_bos_cfg);
                        }

                        if (utils.BosConfig.get_desc_type(curr_bos_cfg) != .Interface) {
                            // TODO - error
                            return;
                        }
                        const desc_itf = utils.BosConfig.get_desc_as(descriptor.Interface, curr_bos_cfg);

                        var driver = usb_config.?.drivers[curr_drv_idx];
                        const drv_cfg_len = try driver.open(curr_bos_cfg);

                        for (0..assoc_itf_count) |itf_offset| {
                            const itf_num = desc_itf.interface_number + itf_offset;
                            itf_to_drv[itf_num] = curr_drv_idx;
                        }

                        bind_endpoints_to_driver(curr_bos_cfg[0..drv_cfg_len], curr_drv_idx);
                        curr_bos_cfg = curr_bos_cfg[drv_cfg_len..];
                    }
                }

                fn bind_endpoints_to_driver(drv_bos_cfg: []const u8, drv_idx: u8) void {
                    var curr_bos_cfg = drv_bos_cfg;
                    while (curr_bos_cfg.len > 0) : ({
                        curr_bos_cfg = utils.BosConfig.get_desc_next(curr_bos_cfg);
                    }) {
                        if (utils.BosConfig.try_get_desc_as(descriptor.Endpoint, curr_bos_cfg)) |desc_ep| {
                            ep_to_drv[@intFromEnum(desc_ep.endpoint.num)][@intFromEnum(desc_ep.endpoint.dir)] = drv_idx;
                        }
                    }
                }
            };

            // Class/Interface Specific Request
            const InterfaceRequestProcessor = struct {
                fn process_setup_request(setup: *const types.SetupPacket) !void {
                    const itf: u8 = @intCast(setup.index & 0xFF);
                    var driver = get_driver(itf_to_drv[itf]);
                    if (driver == null) return;
                    S.driver = driver;

                    if (driver.?.class_control(.Setup, setup) == false) {
                        // TODO
                    }
                }
            };

            // Endpoint Specific Request
            const EndpointRequestProcessor = struct {
                fn process_setup_request(_: *const types.SetupPacket) !void {}
            };

            // Check which interrupt flags are set.
            const ints = f.get_interrupts();

            // Setup request received?
            if (ints.SetupReq) {
                if (debug) log.info("setup req", .{});

                const setup = get_setup_packet();

                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                // TODO - maybe it can be moved to f.get_setup_packet?
                f.reset_ep0();

                switch (setup.request_type.recipient) {
                    .Device => try DeviceRequestProcessor.process_setup_request(&setup),
                    .Interface => try InterfaceRequestProcessor.process_setup_request(&setup),
                    .Endpoint => try EndpointRequestProcessor.process_setup_request(&setup),
                    else => {},
                }
            }

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BuffStatus) {
                if (debug) log.info("buff status", .{});
                var iter = f.get_EPBIter(usb_config.?);

                while (iter.next(&iter)) |epb| {
                    if (debug) log.info("    data: {any}", .{epb.buffer});

                    // Perform any required action on the data. For OUT, the `data`
                    // will be whatever was sent by the host. For IN, it's a copy of
                    // whatever we sent.
                    if (epb.endpoint_address.num == .ep0 and epb.endpoint_address.dir == .In) {
                        if (debug) log.info("    EP0_IN_ADDR", .{});

                        const buffer_reader = &S.buffer_reader;

                        // We use this opportunity to finish the delayed
                        // SetAddress request, if there is one:
                        if (S.new_address) |addr| {
                            // Change our address:
                            f.set_address(@intCast(addr));
                        }

                        if (epb.buffer.len > 0 and buffer_reader.get_remaining_bytes_count() > 0) {
                            _ = buffer_reader.try_advance(epb.buffer.len);
                            const next_data_chunk = buffer_reader.try_peek(64);
                            if (next_data_chunk.len > 0) {
                                f.usb_start_tx(.ep0, next_data_chunk);
                            } else {
                                f.usb_start_rx(.ep0, 0);

                                if (S.driver) |driver| {
                                    _ = driver.class_control(.Ack, &S.setup_packet);
                                }
                            }
                        } else {
                            // Otherwise, we've just finished sending
                            // something to the host. We expect an ensuing
                            // status phase where the host sends us (via EP0
                            // OUT) a zero-byte DATA packet, so, set that
                            // up:
                            f.usb_start_rx(.ep0, 0);

                            if (S.driver) |driver| {
                                _ = driver.class_control(.Ack, &S.setup_packet);
                            }
                        }
                    } else {
                        const ep_num = epb.endpoint_address.num;
                        const ep_dir = epb.endpoint_address.dir;
                        if (get_driver(ep_to_drv[@intFromEnum(ep_num)][@intFromEnum(ep_dir)])) |driver| {
                            driver.transfer(epb.endpoint_address, epb.buffer);
                        }
                        if (ep_dir == .Out) {
                            f.endpoint_reset_rx(epb.endpoint_address);
                        }
                    }
                }
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BusReset) {
                if (debug) log.info("bus reset", .{});

                configuration_reset();
                // Reset the device
                f.bus_reset();

                // Reset our state.
                S.new_address = null;
                S.configured = false;
                S.started = false;
                S.buffer_reader = BufferReader{ .buffer = &.{} };
            }

            // If we have been configured but haven't reached this point yet, set up
            // our custom EP OUT's to receive whatever data the host wants to send.
            if (S.configured and !S.started) {
                S.started = true;
            }
        }
    };
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const DeviceConfiguration = struct {
    device_descriptor: *const descriptor.Device,
    config_descriptor: []const u8,
    lang_descriptor: []const u8,
    descriptor_strings: []const []const u8,
    drivers: []types.UsbClassDriver,
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
    endpoint_address: types.Endpoint,
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

    pub const Error = error{EndOfBuffer};

    /// Moves forward write cursor by the provided number of bytes.
    pub fn advance(self: *@This(), bytes: usize) Error!void {
        try self.bound_check(bytes);
        self.advance_unsafe(bytes);
    }

    /// Writes data provided as a slice to the buffer and moves write cursor forward by data size.
    pub fn write(self: *@This(), data: []const u8) Error!void {
        try self.bound_check(data.len);
        defer self.advance_unsafe(data.len);
        @memcpy(self.buffer[self.pos .. self.pos + data.len], data);
    }

    /// Writes an int with respect to the buffer's endianness and moves write cursor forward by int size.
    pub fn write_int(self: *@This(), comptime T: type, value: T) Error!void {
        const size = @divExact(@typeInfo(T).int.bits, 8);
        try self.bound_check(size);
        defer self.advance_unsafe(size);
        std.mem.writeInt(T, self.buffer[self.pos..][0..size], value, self.endian);
    }

    /// Writes an int with respect to the buffer's endianness but skip bound check.
    /// Useful in cases where the bound can be checked once for batch of ints.
    pub fn write_int_unsafe(self: *@This(), comptime T: type, value: T) void {
        const size = @divExact(@typeInfo(T).int.bits, 8);
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
        return self.buffer[self.pos .. self.pos + size];
    }

    /// Attempts to read the given amount of bytes (or less if close to buffer end) without advancing the read cursor.
    pub fn try_peek(self: *@This(), bytes: usize) []const u8 {
        const size = @min(bytes, self.buffer.len - self.pos);
        return self.buffer[self.pos .. self.pos + size];
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
    pub fn utf8_to_utf16_le(comptime s: []const u8) [s.len << 1]u8 {
        const l = s.len << 1;
        var ret: [l]u8 = @splat(0);
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
    try std.testing.expectEqualSlices(u8, "M\x00y\x00 \x00V\x00e\x00n\x00d\x00o\x00r\x00", &UsbUtils.utf8_to_utf16_le("My Vendor"));
    try std.testing.expectEqualSlices(u8, "R\x00a\x00s\x00p\x00b\x00e\x00r\x00r\x00y\x00 \x00P\x00i\x00", &UsbUtils.utf8_to_utf16_le("Raspberry Pi"));
}
