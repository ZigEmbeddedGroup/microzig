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
const log = std.log.scoped(.usb);

pub const cdc = @import("usb/cdc.zig");
pub const descriptor = @import("usb/descriptor.zig");
pub const hid = @import("usb/hid.zig");
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";

pub const DeviceInterface = struct {
    fn_endpoint_transfer: *const fn (ep_addr: types.Endpoint, data: []const u8) void,

    pub fn endpoint_transfer(this: @This(), ep_addr: types.Endpoint, data: []const u8) void {
        return this.fn_endpoint_transfer(ep_addr, data);
    }
};

pub const Config = struct {
    device_descriptor: descriptor.Device,
    lang_descriptor: descriptor.Language,
    string_descriptors: []const descriptor.String,
    Drivers: type,

    fn fuse_strings(comptime this: *const @This()) []const []const u8 {
        comptime var ret: []const []const u8 = &.{@ptrCast(&this.lang_descriptor)};
        inline for (this.string_descriptors) |str|
            ret = ret ++ .{str.data};
        return ret;
    }
};

/// Create a USB device controller
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
pub fn DeviceController(comptime f: anytype, config_descriptor: anytype, config: Config) type {
    return struct {
        const driver_fields = @typeInfo(config.Drivers).@"struct".fields;
        const DriverEnum = std.meta.FieldEnum(config.Drivers);

        pub const init: @This() = .{
            .new_address = null,
            .cfg_num = 0,
            .tx_slice = "",
            .setup_packet = undefined,
            .driver = null,
            .driver_data = null,
        };

        // When the host gives us a new address, we can't just slap it into
        // registers right away, because we have to do an acknowledgement step using
        // our _old_ address.
        new_address: ?u8,
        // 0 - no config set
        cfg_num: u16,
        // descriptor info waiting to be sent
        tx_slice: []const u8,
        // Last setup packet request
        setup_packet: types.SetupPacket,
        // Class driver associated with last setup request if any
        driver: ?DriverEnum,
        // Driver state
        driver_data: ?config.Drivers,

        pub const max_packet_size = if (f.high_speed) 512 else 64;

        /// Command response utility function that can split long data in multiple packets
        fn send_cmd_response(this: *@This(), data: []const u8, expected_max_length: u16) void {
            this.tx_slice = data[0..@min(data.len, expected_max_length)];
            f.usb_start_tx(.ep0, data[0..@min(max_packet_size, this.tx_slice.len)]);
        }

        pub fn init_device(this: *@This()) void {
            _ = this;
            f.usb_init_device();
        }

        pub fn drivers(this: *@This()) ?*config.Drivers {
            return if (this.driver_data) |*ret| ret else null;
        }

        fn device_endpoint_transfer(ep: types.Endpoint, data: []const u8) void {
            switch (ep.dir) {
                .In => f.usb_start_tx(ep.num, data),
                .Out => f.usb_start_rx(ep.num, max_packet_size),
            }
        }

        fn driver_class_control(this: *@This(), driver: DriverEnum, stage: types.ControlStage, setup: *const types.SetupPacket) void {
            return switch (driver) {
                inline else => |d| {
                    const drv = &@field(this.driver_data.?, @tagName(d));
                    if (drv.class_control(stage, setup)) |response|
                        this.send_cmd_response(response, setup.length);
                },
            };
        }

        fn get_setup_packet(this: *@This()) types.SetupPacket {
            const setup = f.get_setup_packet();
            this.setup_packet = setup;
            this.driver = null;
            return setup;
        }

        fn process_setup_request(this: *@This(), setup: *const types.SetupPacket, debug: bool) !void {
            switch (setup.request_type.type) {
                .Class => {
                    //const itfIndex = setup.index & 0x00ff;
                    log.info("Device.Class", .{});
                },
                .Standard => {
                    switch (std.meta.intToEnum(types.SetupRequest, setup.request) catch return) {
                        .SetAddress => {
                            this.new_address = @as(u8, @intCast(setup.value & 0xff));
                            f.usb_start_tx(.ep0, ack);
                            if (debug) log.info("    SetAddress: {}", .{this.new_address.?});
                        },
                        .SetConfiguration => {
                            if (debug) log.info("    SetConfiguration", .{});
                            if (this.cfg_num != setup.value) {
                                this.cfg_num = setup.value;

                                if (this.cfg_num > 0) {
                                    try this.process_set_config(this.cfg_num - 1);
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
                                try this.process_get_descriptor(setup, dt, debug);
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

        fn process_get_descriptor(this: *@This(), setup: *const types.SetupPacket, descriptor_type: descriptor.Type, debug: bool) !void {
            switch (descriptor_type) {
                .Device => {
                    if (debug) log.info("        Device", .{});

                    this.send_cmd_response(@ptrCast(&config.device_descriptor), setup.length);
                },
                .Configuration => {
                    if (debug) log.info("        Config", .{});

                    this.send_cmd_response(@ptrCast(&config_descriptor), setup.length);
                },
                .String => {
                    if (debug) log.info("        String", .{});
                    // String descriptor index is in bottom 8 bits of
                    // `value`.
                    const i: usize = @intCast(setup.value & 0xff);
                    const strings = comptime config.fuse_strings();
                    this.send_cmd_response(strings[i], setup.length);
                },
                .Interface => {
                    if (debug) log.info("        Interface", .{});
                },
                .Endpoint => {
                    if (debug) log.info("        Endpoint", .{});
                },
                .DeviceQualifier => {
                    if (debug) log.info("        DeviceQualifier", .{});
                    // We will just copy parts of the DeviceDescriptor because
                    // the DeviceQualifierDescriptor can be seen as a subset.
                    const qualifier = comptime &config.device_descriptor.qualifier();
                    this.send_cmd_response(@ptrCast(qualifier), setup.length);
                },
                else => {},
            }
        }

        fn process_set_config(this: *@This(), _: u16) !void {
            // TODO: we support just one config for now so ignore config index
            this.driver_data = @as(config.Drivers, undefined);
            inline for (driver_fields, 1..) |fld_drv, cfg_desc_num| {
                const cfg = config_descriptor[cfg_desc_num];
                @field(this.driver_data.?, fld_drv.name) = .init(&cfg, .{
                    .fn_endpoint_transfer = device_endpoint_transfer,
                });

                inline for (@typeInfo(@TypeOf(cfg)).@"struct".fields) |fld| {
                    if (comptime fld.type == descriptor.Endpoint)
                        f.endpoint_open(&@field(cfg, fld.name));
                }
            }
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// This function will return an error if the device hasn't been initialized.
        pub fn task(this: *@This(), debug: bool) void {
            // Check which interrupt flags are set.
            const ints = f.get_interrupts();

            // Setup request received?
            if (ints.SetupReq) {
                if (debug) log.info("setup req", .{});

                const setup = this.get_setup_packet();

                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                // TODO - maybe it can be moved to f.get_setup_packet?
                f.reset_ep0();

                switch (setup.request_type.recipient) {
                    .Device => try this.process_setup_request(&setup, debug),
                    .Interface => switch (@as(u8, @truncate(setup.index))) {
                        inline else => |itf_num| inline for (driver_fields, 1..) |fld_drv, cfg_desc_num| {
                            const cfg = config_descriptor[cfg_desc_num];
                            comptime var fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;

                            const itf_count = if (fields[0].type != descriptor.InterfaceAssociation)
                                1
                            else blk: {
                                defer fields = fields[1..];
                                break :blk @field(cfg, fields[0].name).interface_count;
                            };

                            const itf_start = @field(cfg, fields[0].name).interface_number;

                            if (comptime itf_num >= itf_start and itf_num < itf_start + itf_count) {
                                const drv = @field(DriverEnum, fld_drv.name);
                                this.driver = drv;
                                this.driver_class_control(drv, .Setup, &setup);
                            }
                        },
                    },
                    .Endpoint => {},
                    else => {},
                }
            }

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BuffStatus) {
                if (debug) log.info("buff status", .{});
                var iter = f.get_EPBIter();

                while (iter.next(&iter)) |epb| {
                    if (debug) log.info("    data: {any}", .{epb.buffer});

                    // Perform any required action on the data. For OUT, the `data`
                    // will be whatever was sent by the host. For IN, it's a copy of
                    // whatever we sent.
                    const ep = epb.endpoint_address;
                    switch (ep.num) {
                        .ep0 => if (ep.dir == .In) {
                            if (debug) log.info("    EP0_IN_ADDR", .{});

                            // We use this opportunity to finish the delayed
                            // SetAddress request, if there is one:
                            if (this.new_address) |addr| {
                                // Change our address:
                                f.set_address(@intCast(addr));
                                this.new_address = null;
                            }

                            if (epb.buffer.len > 0 and this.tx_slice.len > 0) {
                                this.tx_slice = this.tx_slice[epb.buffer.len..];

                                const next_data_chunk = this.tx_slice[0..@min(64, this.tx_slice.len)];
                                if (next_data_chunk.len > 0) {
                                    f.usb_start_tx(.ep0, next_data_chunk);
                                } else {
                                    f.usb_start_rx(.ep0, 0);

                                    if (this.driver) |drv|
                                        this.driver_class_control(drv, .Ack, &this.setup_packet);
                                }
                            } else {
                                // Otherwise, we've just finished sending
                                // something to the host. We expect an ensuing
                                // status phase where the host sends us (via EP0
                                // OUT) a zero-byte DATA packet, so, set that
                                // up:
                                f.usb_start_rx(.ep0, 0);

                                if (this.driver) |drv| {
                                    this.driver_class_control(drv, .Ack, &this.setup_packet);
                                }
                            }
                        },
                        inline else => |ep_num| inline for (driver_fields, 1..) |fld_drv, cfg_desc_num| {
                            const cfg = config_descriptor[cfg_desc_num];
                            const fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;
                            inline for (fields) |fld| {
                                const desc = @field(cfg, fld.name);
                                if (comptime fld.type == descriptor.Endpoint and desc.endpoint.num == ep_num) {
                                    if (ep.dir == desc.endpoint.dir)
                                        @field(this.driver_data.?, fld_drv.name).transfer(ep, epb.buffer);
                                }
                            }
                        },
                    }
                    if (ep.dir == .Out)
                        f.endpoint_reset_rx(epb.endpoint_address);
                }
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BusReset) {
                if (debug) log.info("bus reset", .{});

                // Reset the device
                f.bus_reset();

                // Reset our state.
                this.* = .init;
            }
        }
    };
}

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
    /// Get the next available input buffer
    next: *const fn (self: *@This()) ?EPB,
};
