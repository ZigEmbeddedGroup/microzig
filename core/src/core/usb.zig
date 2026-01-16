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
        start_tx: *const fn (self: *DeviceInterface, ep_num: types.Endpoint.Num, buffer: []const u8) void,
        start_rx: *const fn (self: *DeviceInterface, ep_num: types.Endpoint.Num, len: usize) void,
        endpoint_open: *const fn (self: *DeviceInterface, desc: *const descriptor.Endpoint) void,
        set_address: *const fn (self: *DeviceInterface, addr: u7) void,
    };

    vtable: *const VTable,

    /// Called by drivers to send a packet.
    /// Submitting an empty slice signals an ACK.
    /// If you intend to send ACK, please use the constant `usb.ack`.
    pub fn start_tx(self: *@This(), ep_num: types.Endpoint.Num, buffer: []const u8) void {
        return self.vtable.start_tx(self, ep_num, buffer);
    }

    /// Called by drivers to report readiness to receive up to `len` bytes.
    /// Must be called exactly once before each packet.
    pub fn start_rx(self: *@This(), ep_num: types.Endpoint.Num, len: usize) void {
        return self.vtable.start_rx(self, ep_num, len);
    }

    /// Opens an endpoint according to the descriptor. Note that if the endpoint
    /// direction is IN this may call the controller's `on_buffer` function,
    /// so driver initialization must be done before this function is called
    /// on IN endpoint descriptors.
    pub fn endpoint_open(self: *@This(), desc: *const descriptor.Endpoint) void {
        return self.vtable.endpoint_open(self, desc);
    }

    /// Immediately sets the device address.
    pub fn set_address(self: *@This(), addr: u7) void {
        return self.vtable.set_address(self, addr);
    }
};

pub const Config = struct {
    pub const Configuration = struct {
        num: u8,
        configuration_s: u8,
        attributes: descriptor.Configuration.Attributes,
        max_current_ma: u9,
        Drivers: type,
    };

    device_descriptor: descriptor.Device,
    string_descriptors: []const descriptor.String,
    debug: bool = false,
    /// Currently only a single configuration is supported.
    configurations: []const Configuration,
};

/// USB device controller
///
/// This code handles usb enumeration and configuration and routes packets to drivers.
pub fn DeviceController(config: Config) type {
    std.debug.assert(config.configurations.len == 1);

    return struct {
        const config0 = config.configurations[0];
        const driver_fields = @typeInfo(config0.Drivers).@"struct".fields;
        const DriverEnum = std.meta.FieldEnum(config0.Drivers);
        const config_descriptor = blk: {
            var num_interfaces = 0;
            var num_strings = 4;
            var num_ep_in = 1;
            var num_ep_out = 1;

            var size = @sizeOf(descriptor.Configuration);
            var field_names: [driver_fields.len + 1][]const u8 = undefined;
            var field_types: [driver_fields.len + 1]type = undefined;
            var field_attrs: [driver_fields.len + 1]std.builtin.Type.StructField.Attributes = undefined;
            for (driver_fields, 1..) |drv, i| {
                const payload = drv.type.Descriptor.create(num_interfaces, num_strings, num_ep_in, num_ep_out);
                const Payload = @TypeOf(payload);
                size += @sizeOf(Payload);

                field_names[i] = drv.name;
                field_types[i] = Payload;
                field_attrs[i] = .{
                    .default_value_ptr = &payload,
                    .alignment = 1,
                };

                for (@typeInfo(Payload).@"struct".fields) |fld| {
                    const desc = @field(payload, fld.name);
                    switch (fld.type) {
                        descriptor.Interface => {
                            num_interfaces += 1;
                            if (desc.interface_s != 0)
                                num_strings += 1;
                        },
                        descriptor.Endpoint => switch (desc.endpoint.dir) {
                            .In => num_ep_in += 1,
                            .Out => num_ep_out += 1,
                        },
                        descriptor.InterfaceAssociation,
                        descriptor.cdc.Header,
                        descriptor.cdc.CallManagement,
                        descriptor.cdc.AbstractControlModel,
                        descriptor.cdc.Union,
                        descriptor.hid.Hid,
                        => {},
                        else => @compileLog(fld),
                    }
                }
            }

            const desc_cfg: descriptor.Configuration = .{
                .total_length = .from(size),
                .num_interfaces = num_interfaces,
                .configuration_value = config0.num,
                .configuration_s = config0.configuration_s,
                .attributes = config0.attributes,
                .max_current = .from_ma(config0.max_current_ma),
            };

            field_names[0] = "__configuration_descriptor";
            field_types[0] = descriptor.Configuration;
            field_attrs[0] = .{
                .default_value_ptr = &desc_cfg,
                .alignment = 1,
            };

            break :blk @Struct(.auto, null, &field_names, &field_types, &field_attrs);
        };

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
        driver_data: ?config0.Drivers,

        /// Initial values
        pub const init: @This() = .{
            .new_address = null,
            .cfg_num = 0,
            .tx_slice = "",
            .setup_packet = undefined,
            .driver_last = null,
            .driver_data = null,
        };

        /// Returns a pointer to the drivers
        /// or null in case host has not yet configured the device.
        pub fn drivers(self: *@This()) ?*config0.Drivers {
            return if (self.driver_data) |*ret| ret else null;
        }

        /// Called by the device implementation when a setup request has been received.
        pub fn on_setup_req(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) void {
            if (config.debug) log.info("setup req", .{});

            self.setup_packet = setup.*;
            self.driver_last = null;

            switch (setup.request_type.recipient) {
                .Device => try self.process_setup_request(device_itf, setup),
                .Interface => switch (@as(u8, @truncate(setup.index))) {
                    inline else => |itf_num| inline for (driver_fields) |fld_drv| {
                        const cfg = @field(config_descriptor, fld_drv.name);
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
                            self.driver_last = drv;
                            self.driver_class_control(device_itf, drv, .Setup, setup);
                        }
                    },
                },
                .Endpoint => {},
                else => {},
            }
        }

        /// Called by the device implementation when a packet has been sent or received.
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, ep: types.Endpoint, buffer: []u8) void {
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
                    if (self.new_address) |addr| {
                        // Change our address:
                        device_itf.set_address(@intCast(addr));
                        self.new_address = null;
                    }

                    if (buffer.len > 0 and self.tx_slice.len > 0) {
                        self.tx_slice = self.tx_slice[buffer.len..];

                        const next_data_chunk = self.tx_slice[0..@min(64, self.tx_slice.len)];
                        if (next_data_chunk.len > 0) {
                            device_itf.start_tx(.ep0, next_data_chunk);
                        } else {
                            device_itf.start_rx(.ep0, 0);

                            if (self.driver_last) |drv|
                                self.driver_class_control(device_itf, drv, .Ack, &self.setup_packet);
                        }
                    } else {
                        // Otherwise, we've just finished sending
                        // something to the host. We expect an ensuing
                        // status phase where the host sends us (via EP0
                        // OUT) a zero-byte DATA packet, so, set that
                        // up:
                        device_itf.start_rx(.ep0, 0);

                        if (self.driver_last) |drv|
                            self.driver_class_control(device_itf, drv, .Ack, &self.setup_packet);
                    }
                },
                inline else => |ep_num| inline for (driver_fields) |fld_drv| {
                    const cfg = @field(config_descriptor, fld_drv.name);
                    const fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;
                    inline for (fields) |fld| {
                        const desc = @field(cfg, fld.name);
                        if (comptime fld.type == descriptor.Endpoint and desc.endpoint.num == ep_num) {
                            if (ep.dir == desc.endpoint.dir)
                                @field(self.driver_data.?, fld_drv.name).transfer(ep, buffer);
                        }
                    }
                },
            }
        }

        /// Called by the device implementation on bus reset.
        pub fn on_bus_reset(self: *@This()) void {
            if (config.debug) log.info("bus reset", .{});

            // Reset our state.
            self.* = .init;
        }

        // Utility functions

        /// Command response utility function that can split long data in multiple packets
        fn send_cmd_response(self: *@This(), device_itf: *DeviceInterface, data: []const u8, expected_max_length: u16) void {
            self.tx_slice = data[0..@min(data.len, expected_max_length)];
            const len = @min(config.device_descriptor.max_packet_size0, self.tx_slice.len);
            device_itf.start_tx(.ep0, data[0..len]);
        }

        fn driver_class_control(self: *@This(), device_itf: *DeviceInterface, driver: DriverEnum, stage: types.ControlStage, setup: *const types.SetupPacket) void {
            return switch (driver) {
                inline else => |d| {
                    const drv = &@field(self.driver_data.?, @tagName(d));
                    if (drv.class_control(stage, setup)) |response|
                        self.send_cmd_response(device_itf, response, setup.length);
                },
            };
        }

        fn process_setup_request(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) !void {
            switch (setup.request_type.type) {
                .Class => {
                    //const itfIndex = setup.index & 0x00ff;
                    log.info("Device.Class", .{});
                },
                .Standard => {
                    switch (std.meta.intToEnum(types.SetupRequest, setup.request) catch return) {
                        .SetAddress => {
                            self.new_address = @as(u8, @intCast(setup.value & 0xff));
                            device_itf.start_tx(.ep0, ack);
                            if (config.debug) log.info("    SetAddress: {}", .{self.new_address.?});
                        },
                        .SetConfiguration => {
                            if (config.debug) log.info("    SetConfiguration", .{});
                            if (self.cfg_num != setup.value) {
                                self.cfg_num = setup.value;

                                if (self.cfg_num > 0) {
                                    try self.process_set_config(device_itf, self.cfg_num - 1);
                                    // TODO: call mount callback if any
                                } else {
                                    // TODO: call umount callback if any
                                }
                            }
                            device_itf.start_tx(.ep0, ack);
                        },
                        .GetDescriptor => {
                            const descriptor_type = std.meta.intToEnum(descriptor.Type, setup.value >> 8) catch null;
                            if (descriptor_type) |dt| {
                                try self.process_get_descriptor(device_itf, setup, dt);
                            }
                        },
                        .SetFeature => {
                            if (std.meta.intToEnum(types.FeatureSelector, setup.value >> 8)) |feat| {
                                switch (feat) {
                                    .DeviceRemoteWakeup, .EndpointHalt => device_itf.start_tx(.ep0, ack),
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

        fn process_get_descriptor(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket, descriptor_type: descriptor.Type) !void {
            switch (descriptor_type) {
                .Device => {
                    if (config.debug) log.info("        Device", .{});

                    self.send_cmd_response(device_itf, @ptrCast(&config.device_descriptor), setup.length);
                },
                .Configuration => {
                    if (config.debug) log.info("        Config", .{});

                    self.send_cmd_response(device_itf, @ptrCast(&config_descriptor), setup.length);
                },
                .String => {
                    if (config.debug) log.info("        String", .{});
                    // String descriptor index is in bottom 8 bits of
                    // `value`.
                    const i: usize = @intCast(setup.value & 0xff);
                    if (i >= config.string_descriptors.len)
                        log.warn("host requested invalid string descriptor {}", .{i})
                    else
                        self.send_cmd_response(
                            device_itf,
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
                    self.send_cmd_response(device_itf, @ptrCast(qualifier), setup.length);
                },
                else => {},
            }
        }

        fn process_set_config(self: *@This(), device_itf: *DeviceInterface, _: u16) !void {
            // TODO: we support just one config for now so ignore config index
            self.driver_data = @as(config0.Drivers, undefined);
            inline for (driver_fields) |fld_drv| {
                const cfg = @field(config_descriptor, fld_drv.name);
                @field(self.driver_data.?, fld_drv.name) = .init(&cfg, device_itf);

                inline for (@typeInfo(@TypeOf(cfg)).@"struct".fields) |fld| {
                    if (comptime fld.type == descriptor.Endpoint)
                        device_itf.endpoint_open(&@field(cfg, fld.name));
                }
            }
        }
    };
}
