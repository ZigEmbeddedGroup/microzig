const std = @import("std");
const log = std.log.scoped(.usb);

pub const descriptor = @import("usb/descriptor.zig");
pub const drivers = struct {
    pub const cdc = @import("usb/drivers/cdc.zig");
    pub const hid = @import("usb/drivers/hid.zig");
};
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";
pub const nak: ?[]const u8 = null;

/// USB Device interface
/// Any device implementation used with DeviceController must implement those functions
pub const DeviceInterface = struct {
    pub const VTable = struct {
        start_tx: *const fn (this: *DeviceInterface, ep_num: types.Endpoint.Num, buffer: []const u8) void,
        start_rx: *const fn (this: *DeviceInterface, ep_num: types.Endpoint.Num, len: usize) void,
        endpoint_open: *const fn (this: *DeviceInterface, desc: *const descriptor.Endpoint) void,
        set_address: *const fn (this: *DeviceInterface, addr: u7) void,
    };

    vtable: *const VTable,

    /// Called by drivers to send a packet.
    /// Submitting an empty slice signals an ACK.
    /// If you intend to send ACK, please use the constant `usb.ack`.
    pub fn start_tx(this: *@This(), ep_num: types.Endpoint.Num, buffer: []const u8) void {
        return this.vtable.start_tx(this, ep_num, buffer);
    }

    /// Called by drivers to report readiness to receive up to `len` bytes.
    /// Must be called exactly once before each packet.
    pub fn start_rx(this: *@This(), ep_num: types.Endpoint.Num, len: usize) void {
        return this.vtable.start_rx(this, ep_num, len);
    }

    /// Opens an endpoint according to the descriptor. Note that if the endpoint
    /// direction is IN this may call the controller's `on_buffer` function,
    /// so driver initialization must be done before this function is called
    /// on IN endpoint descriptors.
    pub fn endpoint_open(this: *@This(), desc: *const descriptor.Endpoint) void {
        return this.vtable.endpoint_open(this, desc);
    }

    /// Immediately sets the device address.
    pub fn set_address(this: *@This(), addr: u7) void {
        return this.vtable.set_address(this, addr);
    }
};

pub const Config = struct {
    device_descriptor: descriptor.Device,
    string_descriptors: []const descriptor.String,
    Drivers: type,
    debug: bool = false,
};

/// USB device controller
///
/// This code handles usb enumeration and configuration and routes packets to drivers.
///
/// # Arguments
///
/// * `config_descriptor` - result of `microzig.core.usb.descriptor.Configuration.create`
/// * `config` - rest of descriptors and some options
///
pub fn DeviceController(config_descriptor: anytype, config: Config) type {
    return struct {
        const driver_fields = @typeInfo(config.Drivers).@"struct".fields;
        const DriverEnum = std.meta.FieldEnum(config.Drivers);

        /// When the host sets the device address, the acknowledgement
        /// step must use the _old_ address.
        new_address: ?u8,
        /// 0 - no config set
        cfg_num: u16,
        /// Ep0 data waiting to be sent
        tx_slice: []const u8,
        /// Last setup packet request
        setup_packet: types.SetupPacket,
        /// Class driver associated with last setup request if any
        driver_last: ?DriverEnum,
        /// Driver state
        driver_data: ?config.Drivers,
        /// Device implementation
        device_itf: *DeviceInterface,

        pub fn init(device_itf: *DeviceInterface) @This() {
            return .{
                .new_address = null,
                .cfg_num = 0,
                .tx_slice = "",
                .setup_packet = undefined,
                .driver_last = null,
                .driver_data = null,
                .device_itf = device_itf,
            };
        }

        /// Returns a pointer to the drivers
        /// or null in case host has not yet configured the device.
        pub fn drivers(this: *@This()) ?*config.Drivers {
            return if (this.driver_data) |*ret| ret else null;
        }

        /// Called by the device implementation when a setup request has been received.
        pub fn on_setup_req(this: *@This(), setup: *const types.SetupPacket) void {
            if (config.debug) log.info("setup req", .{});

            this.setup_packet = setup.*;
            this.driver_last = null;

            switch (setup.request_type.recipient) {
                .Device => try this.process_setup_request(setup),
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
                            this.driver_last = drv;
                            this.driver_class_control(drv, .Setup, setup);
                        }
                    },
                },
                .Endpoint => {},
                else => {},
            }
        }

        /// Called by the device implementation when a packet has been received.
        pub fn on_buffer(this: *@This(), ep: types.Endpoint, buffer: []u8) void {
            if (config.debug) log.info("buff status", .{});

            if (config.debug) log.info("    data: {any}", .{buffer});

            // Perform any required action on the data. For OUT, the `data`
            // will be whatever was sent by the host. For IN, it's a copy of
            // whatever we sent.
            switch (ep.num) {
                .ep0 => if (ep.dir == .In) {
                    if (config.debug) log.info("    EP0_IN_ADDR", .{});

                    // We use this opportunity to finish the delayed
                    // SetAddress request, if there is one:
                    if (this.new_address) |addr| {
                        // Change our address:
                        this.device_itf.set_address(@intCast(addr));
                        this.new_address = null;
                    }

                    if (buffer.len > 0 and this.tx_slice.len > 0) {
                        this.tx_slice = this.tx_slice[buffer.len..];

                        const next_data_chunk = this.tx_slice[0..@min(64, this.tx_slice.len)];
                        if (next_data_chunk.len > 0) {
                            this.device_itf.start_tx(.ep0, next_data_chunk);
                        } else {
                            this.device_itf.start_rx(.ep0, 0);

                            if (this.driver_last) |drv|
                                this.driver_class_control(drv, .Ack, &this.setup_packet);
                        }
                    } else {
                        // Otherwise, we've just finished sending
                        // something to the host. We expect an ensuing
                        // status phase where the host sends us (via EP0
                        // OUT) a zero-byte DATA packet, so, set that
                        // up:
                        this.device_itf.start_rx(.ep0, 0);

                        if (this.driver_last) |drv|
                            this.driver_class_control(drv, .Ack, &this.setup_packet);
                    }
                },
                inline else => |ep_num| inline for (driver_fields, 1..) |fld_drv, cfg_desc_num| {
                    const cfg = config_descriptor[cfg_desc_num];
                    const fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;
                    inline for (fields) |fld| {
                        const desc = @field(cfg, fld.name);
                        if (comptime fld.type == descriptor.Endpoint and desc.endpoint.num == ep_num) {
                            if (ep.dir == desc.endpoint.dir)
                                @field(this.driver_data.?, fld_drv.name).transfer(ep, buffer);
                        }
                    }
                },
            }
        }

        /// Called by the device implementation on bus reset.
        pub fn on_bus_reset(this: *@This()) void {
            if (config.debug) log.info("bus reset", .{});

            // Reset our state.
            this.* = .init(this.device_itf);
        }

        // Utility functions

        /// Command response utility function that can split long data in multiple packets
        fn send_cmd_response(this: *@This(), data: []const u8, expected_max_length: u16) void {
            this.tx_slice = data[0..@min(data.len, expected_max_length)];
            const len = @min(config.device_descriptor.max_packet_size0, this.tx_slice.len);
            this.device_itf.start_tx(.ep0, data[0..len]);
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

        fn process_setup_request(this: *@This(), setup: *const types.SetupPacket) !void {
            switch (setup.request_type.type) {
                .Class => {
                    //const itfIndex = setup.index & 0x00ff;
                    log.info("Device.Class", .{});
                },
                .Standard => {
                    switch (std.meta.intToEnum(types.SetupRequest, setup.request) catch return) {
                        .SetAddress => {
                            this.new_address = @as(u8, @intCast(setup.value & 0xff));
                            this.device_itf.start_tx(.ep0, ack);
                            if (config.debug) log.info("    SetAddress: {}", .{this.new_address.?});
                        },
                        .SetConfiguration => {
                            if (config.debug) log.info("    SetConfiguration", .{});
                            if (this.cfg_num != setup.value) {
                                this.cfg_num = setup.value;

                                if (this.cfg_num > 0) {
                                    try this.process_set_config(this.cfg_num - 1);
                                    // TODO: call mount callback if any
                                } else {
                                    // TODO: call umount callback if any
                                }
                            }
                            this.device_itf.start_tx(.ep0, ack);
                        },
                        .GetDescriptor => {
                            const descriptor_type = std.meta.intToEnum(descriptor.Type, setup.value >> 8) catch null;
                            if (descriptor_type) |dt| {
                                try this.process_get_descriptor(setup, dt);
                            }
                        },
                        .SetFeature => {
                            if (std.meta.intToEnum(types.FeatureSelector, setup.value >> 8)) |feat| {
                                switch (feat) {
                                    .DeviceRemoteWakeup, .EndpointHalt => this.device_itf.start_tx(.ep0, ack),
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

        fn process_get_descriptor(this: *@This(), setup: *const types.SetupPacket, descriptor_type: descriptor.Type) !void {
            switch (descriptor_type) {
                .Device => {
                    if (config.debug) log.info("        Device", .{});

                    this.send_cmd_response(@ptrCast(&config.device_descriptor), setup.length);
                },
                .Configuration => {
                    if (config.debug) log.info("        Config", .{});

                    this.send_cmd_response(@ptrCast(&config_descriptor), setup.length);
                },
                .String => {
                    if (config.debug) log.info("        String", .{});
                    // String descriptor index is in bottom 8 bits of
                    // `value`.
                    const i: usize = @intCast(setup.value & 0xff);
                    if (i >= config.string_descriptors.len)
                        log.warn("host requested invalid string descriptor {}", .{i})
                    else
                        this.send_cmd_response(
                            config.string_descriptors[i].data,
                            setup.length,
                        );
                },
                .Interface => {
                    if (config.debug) log.info("        Interface", .{});
                },
                .Endpoint => {
                    if (config.debug) log.info("        Endpoint", .{});
                },
                .DeviceQualifier => {
                    if (config.debug) log.info("        DeviceQualifier", .{});
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
                @field(this.driver_data.?, fld_drv.name) = .init(&cfg, this.device_itf);

                inline for (@typeInfo(@TypeOf(cfg)).@"struct".fields) |fld| {
                    if (comptime fld.type == descriptor.Endpoint)
                        this.device_itf.endpoint_open(&@field(cfg, fld.name));
                }
            }
        }
    };
}
