const std = @import("std");
const assert = std.debug.assert;
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
        ep_writev: *const fn (*DeviceInterface, types.Endpoint.Num, []const []const u8) types.Len,
        ep_readv: *const fn (*DeviceInterface, types.Endpoint.Num, []const []u8) types.Len,
        ep_listen: *const fn (*DeviceInterface, types.Endpoint.Num, types.Len) void,
        endpoint_open: *const fn (*DeviceInterface, *const descriptor.Endpoint) void,
        set_address: *const fn (*DeviceInterface, u7) void,
    };

    vtable: *const VTable,

    /// Called by drivers to send a packet.
    pub fn ep_writev(self: *@This(), ep_num: types.Endpoint.Num, data: []const []const u8) types.Len {
        return self.vtable.ep_writev(self, ep_num, data);
    }

    /// Send ack on given IN endpoint.
    pub fn ep_ack(self: *@This(), ep_num: types.Endpoint.Num) void {
        assert(0 == self.ep_writev(ep_num, &.{ack}));
    }

    /// Called by drivers to retrieve a received packet.
    /// Must be called exactly once for each packet.
    /// Buffers in `data` must collectively be long enough to fit the whole packet.
    pub fn ep_readv(self: *@This(), ep_num: types.Endpoint.Num, data: []const []u8) types.Len {
        return self.vtable.ep_readv(self, ep_num, data);
    }

    /// Called by drivers to report readiness to receive up to `len` bytes.
    pub fn ep_listen(self: *@This(), ep_num: types.Endpoint.Num, len: types.Len) void {
        return self.vtable.ep_listen(self, ep_num, len);
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

const Handler = struct {
    driver: []const u8,
    function: []const u8,
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
            var fields: [driver_fields.len + 1]std.builtin.Type.StructField = undefined;

            for (driver_fields, 1..) |drv, i| {
                const payload = drv.type.Descriptor.create(num_interfaces, num_strings, num_ep_in, num_ep_out);
                const Payload = @TypeOf(payload);
                size += @sizeOf(Payload);

                fields[i] = .{
                    .name = drv.name,
                    .type = Payload,
                    .default_value_ptr = &payload,
                    .is_comptime = false,
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

            fields[0] = .{
                .name = "__configuration_descriptor",
                .type = descriptor.Configuration,
                .default_value_ptr = &desc_cfg,
                .is_comptime = false,
                .alignment = 1,
            };

            break :blk @Type(.{ .@"struct" = .{
                .decls = &.{},
                .fields = &fields,
                .is_tuple = false,
                .layout = .auto,
            } }){};
        };

        const endpoint_handlers = blk: {
            var ret: struct { In: [16]Handler, Out: [16]Handler } = .{
                .In = @splat(.{ .driver = "", .function = "" }),
                .Out = @splat(.{ .driver = "", .function = "" }),
            };
            for (driver_fields) |fld_drv| {
                const cfg = @field(config_descriptor, fld_drv.name);
                const fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;
                for (fields) |fld| {
                    if (fld.type != descriptor.Endpoint) continue;
                    const desc: descriptor.Endpoint = @field(cfg, fld.name);
                    const ep_num = @intFromEnum(desc.endpoint.num);
                    const handler = &@field(ret, @tagName(desc.endpoint.dir))[ep_num];
                    const function = @field(fld_drv.type.handlers, fld.name);
                    if (handler.driver.len != 0 or handler.function.len != 0)
                        @compileError(std.fmt.comptimePrint(
                            "ep{} {t}: multiple handlers: {s}.{s} and {s}.{s}",
                            .{ ep_num, desc.endpoint.dir, handler.driver, handler.function, fld_drv.name, function },
                        ));
                    handler.* = .{
                        .driver = fld_drv.name,
                        .function = function,
                    };
                }
            }
            break :blk ret;
        };

        /// When the host sets the device address, the acknowledgement
        /// step must use the _old_ address.
        new_address: ?u8,
        /// 0 - no config set
        cfg_num: u16,
        /// Ep0 data waiting to be sent
        tx_slice: ?[]const u8,
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
            .tx_slice = null,
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
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, comptime ep: types.Endpoint, buffer: []u8) void {
            if (config.debug) log.info("buff status", .{});
            if (config.debug) log.info("    data: {any}", .{buffer});

            const handler = comptime @field(endpoint_handlers, @tagName(ep.dir))[@intFromEnum(ep.num)];

            if (comptime ep == types.Endpoint.in(.ep0)) {
                if (config.debug) log.info("    EP0_IN_ADDR", .{});

                // We use this opportunity to finish the delayed
                // SetAddress request, if there is one:
                if (self.new_address) |addr| {
                    // Change our address:
                    device_itf.set_address(@intCast(addr));
                    self.new_address = null;
                }

                if (self.tx_slice) |slice| {
                    if (slice.len > 0) {
                        const len = device_itf.ep_writev(.ep0, &.{slice});
                        self.tx_slice = slice[len..];
                    } else {
                        // Otherwise, we've just finished sending tx_slice.
                        // We expect an ensuing status phase where the host
                        // sends us a zero-byte DATA packet via EP0 OUT.
                        // device_itf.ep_listen(.ep0, 0);
                        self.tx_slice = null;

                        if (self.driver_last) |drv|
                            self.driver_class_control(device_itf, drv, .Ack, &self.setup_packet);
                    }
                }
            } else if (comptime ep == types.Endpoint.out(.ep0)) {
                log.info("ep0_out {}", .{buffer.len});
            }
            if (comptime handler.driver.len != 0) {
                const drv = &@field(self.driver_data.?, handler.driver);
                @field(@FieldType(config0.Drivers, handler.driver), handler.function)(drv, ep.num);
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
            const limited = data[0..@min(data.len, expected_max_length)];
            const len = device_itf.ep_writev(.ep0, &.{limited});
            assert(len <= config.device_descriptor.max_packet_size0);
            self.tx_slice = limited[len..];
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
                            device_itf.ep_ack(.ep0);
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
                            device_itf.ep_ack(.ep0);
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
                                    .DeviceRemoteWakeup, .EndpointHalt => device_itf.ep_ack(.ep0),
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
