//! Abstract USB device implementation
//!
//! This can be used to setup a USB device.
//!
//! ## Usage
//!
//! 1. Define the functions (`pub const F = struct { ... }`) required by `Usb()` (see below)
//! 2. Call `pub const device = Usb(F)`
//! 3. Define the device configuration (DeviceConfiguration)
//! 4. Initialize the device in main by calling `usb.init_device(device_conf)`
//! 5. Call `usb.task()` within the main loop

const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const log = std.log.scoped(.usb);

pub const cdc = @import("usb/cdc.zig");
pub const descriptor = @import("usb/descriptor.zig");
pub const hid = @import("usb/hid.zig");
pub const types = @import("usb/types.zig");

const EpNum = types.Endpoint.Num;

const ack: []const u8 = "";

/// Create a USB device
///
/// # Arguments
///
/// This is a abstract USB device implementation that requires a handful of functions
/// to work correctly:
///
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
pub fn Usb(comptime f: anytype, config_descriptor: anytype) type {
    return struct {
        const DrvId = enum(u8) { invalid = 0xFF, _ };

        /// The usb configuration set
        var usb_config: ?*const DeviceConfiguration = null;
        var itf_to_drv: [f.cfg_max_interfaces_count]DrvId = @splat(.invalid);
        var ep_to_drv: [f.cfg_max_endpoints_count][2]DrvId = @splat(@splat(.invalid));
        var debug_mode = false;
        // When the host gives us a new address, we can't just slap it into
        // registers right away, because we have to do an acknowledgement step using
        // our _old_ address.
        var new_address: ?u8 = null;
        // 0 - no config set
        var cfg_num: u16 = 0;
        // descriptor info waiting to be sent
        var tx_slice: []const u8 = "";
        // Last setup packet request
        var setup_packet: types.SetupPacket = undefined;
        // Class driver associated with last setup request if any
        var driver: ?*const types.UsbClassDriver = null;

        pub const max_packet_size = if (f.high_speed) 512 else 64;

        /// The callbacks passed provided by the caller
        pub const callbacks = f;

        // Command endpoint utilities
        const CmdEndpoint = struct {
            /// Command response utility function that can split long data in multiple packets
            fn send_cmd_response(data: []const u8, expected_max_length: u16) void {
                tx_slice = data[0..@min(data.len, expected_max_length)];
                const data_chunk = tx_slice[0..@min(64, tx_slice.len)];

                if (data_chunk.len > 0) {
                    f.usb_start_tx(.ep0, data_chunk);
                }
            }
        };

        /// Initialize the usb device using the given configuration
        ///
        /// This function will return an error if the clock hasn't been initialized.
        pub fn init_device(device_config: *const DeviceConfiguration) void {
            f.usb_init_device(device_config);
            usb_config = device_config;

            const device_interface = device();
            for (usb_config.?.drivers) |*drv| {
                drv.init(device_interface);
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
            return cfg_num != 0;
        }

        fn device_control_transfer(setup: *const types.SetupPacket, data: []const u8) void {
            CmdEndpoint.send_cmd_response(data, setup.length);
        }

        fn device_control_ack(_: *const types.SetupPacket) void {
            f.usb_start_tx(.ep0, ack);
        }

        fn device_endpoint_open(ep: *const descriptor.Endpoint) void {
            f.endpoint_open(ep.endpoint, @intCast(ep.max_packet_size.into()), ep.attributes.transfer_type);
        }

        fn device_endpoint_transfer(ep: types.Endpoint, data: []const u8) void {
            switch (ep.dir) {
                .In => f.usb_start_tx(ep.num, data),
                .Out => f.usb_start_rx(ep.num, max_packet_size),
            }
        }

        fn get_driver(drv_idx: DrvId) ?*const types.UsbClassDriver {
            return switch (drv_idx) {
                .invalid => null,
                else => &usb_config.?.drivers[@intFromEnum(drv_idx)],
            };
        }

        fn get_setup_packet() types.SetupPacket {
            const setup = f.get_setup_packet();
            setup_packet = setup;
            driver = null;
            return setup;
        }

        fn configuration_reset() void {
            itf_to_drv = @splat(.invalid);
            ep_to_drv = @splat(@splat(.invalid));
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// This function will return an error if the device hasn't been initialized.
        pub fn task(debug: bool) !void {
            if (usb_config == null) return error.UninitializedDevice;

            debug_mode = debug;

            // Device Specific Request
            const DeviceRequestProcessor = struct {
                fn process_setup_request(setup: *const types.SetupPacket) !void {
                    switch (setup.request_type.type) {
                        .Class => {
                            //const itfIndex = setup.index & 0x00ff;
                            log.info("Device.Class", .{});
                        },
                        .Standard => {
                            switch (std.meta.intToEnum(types.SetupRequest, setup.request) catch return) {
                                .SetAddress => {
                                    new_address = @as(u8, @intCast(setup.value & 0xff));
                                    f.usb_start_tx(.ep0, ack);
                                    if (debug_mode) log.info("    SetAddress: {}", .{new_address.?});
                                },
                                .SetConfiguration => {
                                    if (debug_mode) log.info("    SetConfiguration", .{});
                                    if (cfg_num != setup.value) {
                                        cfg_num = setup.value;

                                        if (cfg_num > 0) {
                                            configuration_reset();
                                        }

                                        if (cfg_num > 0) {
                                            try process_set_config(cfg_num - 1);
                                            // TODO: call mount callback if any
                                        } else {
                                            // TODO: call umount callback if any
                                        }
                                    }
                                    f.usb_start_tx(.ep0, ack);
                                },
                                .GetDescriptor => {
                                    const descriptor_type = std.meta.intToEnum(descriptor.Type, setup.value >> 8) catch null;
                                    if (descriptor_type) |dt| {
                                        try process_get_descriptor(setup, dt);
                                    }
                                },
                                .SetFeature => {
                                    if (std.meta.intToEnum(types.FeatureSelector, setup.value >> 8)) |feat| {
                                        switch (feat) {
                                            .DeviceRemoteWakeup, .EndpointHalt => f.usb_start_tx(.ep0, ack),
                                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                                            .TestMode => {},
                                        }
                                    } else |_| {}
                                },
                            }
                        },
                        else => {},
                    }
                }

                fn process_get_descriptor(setup: *const types.SetupPacket, descriptor_type: descriptor.Type) !void {
                    switch (descriptor_type) {
                        .Device => {
                            if (debug_mode) log.info("        Device", .{});

                            CmdEndpoint.send_cmd_response(@ptrCast(usb_config.?.device_descriptor), setup.length);
                        },
                        .Configuration => {
                            if (debug_mode) log.info("        Config", .{});

                            CmdEndpoint.send_cmd_response(@ptrCast(&config_descriptor), setup.length);
                        },
                        .String => {
                            if (debug_mode) log.info("        String", .{});
                            // String descriptor index is in bottom 8 bits of
                            // `value`.
                            const i: usize = @intCast(setup.value & 0xff);

                            CmdEndpoint.send_cmd_response(usb_config.?.descriptor_strings[i], setup.length);
                        },
                        .Interface => {
                            if (debug_mode) log.info("        Interface", .{});
                        },
                        .Endpoint => {
                            if (debug_mode) log.info("        Endpoint", .{});
                        },
                        .DeviceQualifier => {
                            if (debug_mode) log.info("        DeviceQualifier", .{});
                            // We will just copy parts of the DeviceDescriptor because
                            // the DeviceQualifierDescriptor can be seen as a subset.
                            CmdEndpoint.send_cmd_response(@ptrCast(&usb_config.?.device_qualifier_descriptor), setup.length);
                        },
                        else => {},
                    }
                }

                fn process_set_config(_: u16) !void {
                    // TODO: we support just one config for now so ignore config index
                    assert(@TypeOf(config_descriptor[0]) == descriptor.Configuration);
                    const fields_top = @typeInfo(@TypeOf(config_descriptor)).@"struct".fields;

                    inline for (0..fields_top.len - 1) |curr_drv_idx| {
                        const cfg = config_descriptor[curr_drv_idx + 1];
                        comptime var fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;

                        const assoc_itf_count = if (fields[0].type != descriptor.InterfaceAssociation)
                            1
                        else blk: {
                            defer fields = fields[1..];
                            break :blk @field(cfg, fields[0].name).interface_count;
                        };

                        const desc_itf: descriptor.Interface = @field(cfg, fields[0].name);

                        var drv = usb_config.?.drivers[curr_drv_idx];
                        try drv.open(&cfg);

                        for (0..assoc_itf_count) |itf_offset| {
                            const itf_num = desc_itf.interface_number + itf_offset;
                            itf_to_drv[itf_num] = @enumFromInt(curr_drv_idx);
                        }

                        inline for (fields[1..]) |fld|
                            if (fld.type == descriptor.Endpoint) {
                                const desc_ep: descriptor.Endpoint = @field(cfg, fld.name);
                                ep_to_drv[@intFromEnum(desc_ep.endpoint.num)][@intFromEnum(desc_ep.endpoint.dir)] = @enumFromInt(curr_drv_idx);
                            };
                    }
                }
            };

            // Class/Interface Specific Request
            const InterfaceRequestProcessor = struct {
                fn process_setup_request(setup: *const types.SetupPacket) !void {
                    const itf: u8 = @intCast(setup.index & 0xFF);
                    driver = get_driver(itf_to_drv[itf]) orelse return;

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

                        // We use this opportunity to finish the delayed
                        // SetAddress request, if there is one:
                        if (new_address) |addr| {
                            // Change our address:
                            f.set_address(@intCast(addr));
                        }

                        if (epb.buffer.len > 0 and tx_slice.len > 0) {
                            tx_slice = tx_slice[epb.buffer.len..];

                            const next_data_chunk = tx_slice[0..@min(64, tx_slice.len)];
                            if (next_data_chunk.len > 0) {
                                f.usb_start_tx(.ep0, next_data_chunk);
                            } else {
                                f.usb_start_rx(.ep0, 0);

                                if (driver) |drv| {
                                    _ = drv.class_control(.Ack, &setup_packet);
                                }
                            }
                        } else {
                            // Otherwise, we've just finished sending
                            // something to the host. We expect an ensuing
                            // status phase where the host sends us (via EP0
                            // OUT) a zero-byte DATA packet, so, set that
                            // up:
                            f.usb_start_rx(.ep0, 0);

                            if (driver) |drv| {
                                _ = drv.class_control(.Ack, &setup_packet);
                            }
                        }
                    } else {
                        const ep_num = epb.endpoint_address.num;
                        const ep_dir = epb.endpoint_address.dir;
                        if (get_driver(ep_to_drv[@intFromEnum(ep_num)][@intFromEnum(ep_dir)])) |drv| {
                            drv.transfer(epb.endpoint_address, epb.buffer);
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
                new_address = null;
                cfg_num = 0;
                tx_slice = "";
            }
        }
    };
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

pub const DeviceConfiguration = struct {
    device_descriptor: *const descriptor.Device,
    device_qualifier_descriptor: *const descriptor.Device.Qualifier,
    descriptor_strings: []const []const u8,
    drivers: []const types.UsbClassDriver,

    pub fn from(
        comptime device_descriptor: *const descriptor.Device,
        lang_descriptor: descriptor.Language,
        comptime descriptor_strings: []const descriptor.String,
        drivers: []types.UsbClassDriver,
    ) @This() {
        comptime var strings: []const []const u8 = &.{@ptrCast(&lang_descriptor)};

        inline for (descriptor_strings) |str|
            strings = strings ++ .{str.data};

        return .{
            .device_descriptor = device_descriptor,
            .device_qualifier_descriptor = comptime &device_descriptor.qualifier(),
            .descriptor_strings = strings,
            .drivers = drivers,
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
