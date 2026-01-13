const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb);

pub const descriptor = @import("usb/descriptor.zig");
pub const drivers = struct {
    pub const cdc = @import("usb/drivers/cdc.zig");
    pub const echo = @import("usb/drivers/example.zig");
    pub const hid = @import("usb/drivers/hid.zig");
};
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";
pub const nak: ?[]const u8 = null;

pub const DescriptorAllocator = struct {
    next_ep_num: [2]u8,
    next_itf_num: u8,
    unique_endpoints: bool,

    pub fn init(unique_endpoints: bool) @This() {
        return .{
            .next_ep_num = @splat(1),
            .next_itf_num = 0,
            .unique_endpoints = unique_endpoints,
        };
    }

    pub fn next_ep(self: *@This(), dir: types.Dir) types.Endpoint {
        const idx: u1 = @intFromEnum(dir);
        const ret = self.next_ep_num[idx];
        self.next_ep_num[idx] += 1;
        if (self.unique_endpoints)
            self.next_ep_num[idx ^ 1] += 1;
        return .{ .dir = dir, .num = @enumFromInt(ret) };
    }

    pub fn next_itf(self: *@This()) u8 {
        defer self.next_itf_num += 1;
        return self.next_itf_num;
    }
};

/// USB Device interface
/// Any device implementation used with DeviceController must implement those functions
pub const DeviceInterface = struct {
    pub const VTable = struct {
        ep_writev: *const fn (*DeviceInterface, types.Endpoint.Num, []const []const u8) types.Len,
        ep_readv: *const fn (*DeviceInterface, types.Endpoint.Num, []const []u8) types.Len,
        ep_listen: *const fn (*DeviceInterface, types.Endpoint.Num, types.Len) void,
        ep_open: *const fn (*DeviceInterface, *const descriptor.Endpoint) void,
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
    /// After being called it may not be called again until a packet is received.
    pub fn ep_listen(self: *@This(), ep_num: types.Endpoint.Num, len: types.Len) void {
        return self.vtable.ep_listen(self, ep_num, len);
    }

    /// Opens an endpoint according to the descriptor. Note that if the endpoint
    /// direction is IN this may call the controller's `on_buffer` function,
    /// so driver initialization must be done before this function is called
    /// on IN endpoint descriptors.
    pub fn ep_open(self: *@This(), desc: *const descriptor.Endpoint) void {
        return self.vtable.ep_open(self, desc);
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
    /// Only use either IN or OUT on each endpoint. Useful for debugging.
    /// Realistically, it should only be turned off if you are exhausting
    /// the 15 endpoint limit.
    unique_endpoints: bool = true,
    /// Device specific, either 8, 16, 32 or 64.
    max_supported_packet_size: types.Len,
};

pub fn validate_controller(T: type) void {
    comptime {
        const info = @typeInfo(T);
        if (info != .pointer or info.pointer.is_const or info.pointer.size != .one)
            @compileError("Expected a mutable pointer to the usb controller, got: " ++ @typeName(T));
        const Controller = info.pointer.child;
        _ = Controller;
        // More checks
    }
}

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
            const max_psize = config.max_supported_packet_size;
            assert(max_psize == 8 or max_psize == 16 or max_psize == 32 or max_psize == 64);

            var alloc: DescriptorAllocator = .init(config.unique_endpoints);
            var next_string = 4;

            var size = @sizeOf(descriptor.Configuration);
            var fields: [driver_fields.len + 1]std.builtin.Type.StructField = undefined;

            for (driver_fields, 1..) |drv, i| {
                const payload = drv.type.Descriptor.create(&alloc, next_string, max_psize);
                const Payload = @TypeOf(payload);
                size += @sizeOf(Payload);

                for (@typeInfo(Payload).@"struct".fields) |fld| {
                    const desc = @field(payload, fld.name);
                    switch (fld.type) {
                        descriptor.Interface => {
                            if (desc.interface_s != 0)
                                next_string += 1;
                        },
                        descriptor.Endpoint,
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

                fields[i] = .{
                    .name = drv.name,
                    .type = Payload,
                    .default_value_ptr = &payload,
                    .is_comptime = false,
                    .alignment = 1,
                };
            }

            if (next_string != config.string_descriptors.len)
                @compileError(std.fmt.comptimePrint(
                    "expected {} string descriptros, got {}",
                    .{ next_string, config.string_descriptors.len },
                ));

            const desc_cfg: descriptor.Configuration = .{
                .total_length = .from(size),
                .num_interfaces = alloc.next_itf_num,
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

        const handlers = blk: {
            const Handler = struct {
                driver: []const u8,
                function: []const u8,
            };

            var ret: struct { In: [16]Handler, Out: [16]Handler, itf: []const DriverEnum } = .{
                .In = @splat(.{ .driver = "", .function = "" }),
                .Out = @splat(.{ .driver = "", .function = "" }),
                .itf = &.{},
            };
            var itf_handlers = ret.itf;
            for (driver_fields) |fld_drv| {
                const cfg = @field(config_descriptor, fld_drv.name);
                const fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;

                const itf0 = @field(cfg, fields[0].name);
                const itf_start, const itf_count = if (fields[0].type == descriptor.InterfaceAssociation)
                    .{ itf0.first_interface, itf0.interface_count }
                else
                    .{ itf0.interface_number, 1 };

                if (itf_start != itf_handlers.len)
                    @compileError("interface numbering mismatch");

                itf_handlers = itf_handlers ++ &[1]DriverEnum{@field(DriverEnum, fld_drv.name)} ** itf_count;

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
            ret.itf = itf_handlers;
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
                .Device => self.process_setup_request(device_itf, setup),
                .Interface => switch (@as(u8, @truncate(setup.index.into()))) {
                    inline else => |itf_num| if (itf_num < handlers.itf.len) {
                        const drv = handlers.itf[itf_num];
                        self.driver_last = drv;
                        self.driver_class_control(device_itf, drv, .Setup, setup);
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

            const handler = comptime @field(handlers, @tagName(ep.dir))[@intFromEnum(ep.num)];

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
        pub fn on_bus_reset(self: *@This(), device_itf: *DeviceInterface) void {
            if (config.debug) log.info("bus reset", .{});

            self.process_set_config(device_itf, 0);

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
                        self.send_cmd_response(device_itf, response, setup.length.into());
                },
            };
        }

        fn process_setup_request(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) void {
            switch (setup.request_type.type) {
                .Class => {
                    //const itfIndex = setup.index & 0x00ff;
                    log.info("Device.Class", .{});
                },
                .Standard => {
                    switch (std.meta.intToEnum(types.SetupRequest, setup.request) catch return) {
                        .SetAddress => {
                            if (config.debug) log.info("    SetAddress: {}", .{self.new_address.?});
                            self.new_address = @truncate(setup.value.into());
                            device_itf.ep_ack(.ep0);
                        },
                        .SetConfiguration => {
                            if (config.debug) log.info("    SetConfiguration", .{});
                            self.process_set_config(device_itf, setup.value.into());
                            device_itf.ep_ack(.ep0);
                        },
                        .GetDescriptor => {
                            const descriptor_type = std.meta.intToEnum(descriptor.Type, setup.value.into() >> 8) catch null;
                            if (descriptor_type) |dt| {
                                self.process_get_descriptor(device_itf, setup, dt);
                            }
                        },
                        .SetFeature => {
                            if (std.meta.intToEnum(types.FeatureSelector, setup.value.into() >> 8)) |feat| {
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

        fn process_get_descriptor(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket, descriptor_type: descriptor.Type) void {
            switch (descriptor_type) {
                .Device => {
                    if (config.debug) log.info("        Device", .{});

                    self.send_cmd_response(device_itf, @ptrCast(&config.device_descriptor), setup.length.into());
                },
                .Configuration => {
                    if (config.debug) log.info("        Config", .{});

                    self.send_cmd_response(device_itf, @ptrCast(&config_descriptor), setup.length.into());
                },
                .String => {
                    if (config.debug) log.info("        String", .{});
                    // String descriptor index is in bottom 8 bits of
                    // `value`.
                    const i: u8 = @truncate(setup.value.into());
                    if (i >= config.string_descriptors.len)
                        log.warn("host requested invalid string descriptor {}", .{i})
                    else
                        self.send_cmd_response(
                            device_itf,
                            config.string_descriptors[i].data,
                            setup.length.into(),
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
                    self.send_cmd_response(device_itf, @ptrCast(qualifier), setup.length.into());
                },
                else => {},
            }
        }

        fn process_set_config(self: *@This(), device_itf: *DeviceInterface, cfg_num: u16) void {
            if (cfg_num == self.cfg_num) return;

            if (self.driver_data) |data_old| {
                _ = data_old;
                // deinitialize drivers
            }

            self.cfg_num = cfg_num;
            if (cfg_num == 0) {
                self.driver_data = null;
                return;
            }

            // We support just one config for now so ignore config index
            self.driver_data = @as(config0.Drivers, undefined);
            inline for (driver_fields) |fld_drv| {
                const cfg = @field(config_descriptor, fld_drv.name);
                const desc_fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;

                // Open OUT endpoint first so that the driver can call ep_listen in init
                inline for (desc_fields) |fld| {
                    const desc = &@field(cfg, fld.name);
                    if (comptime fld.type == descriptor.Endpoint and desc.endpoint.dir == .Out)
                        device_itf.ep_open(desc);
                }

                @field(self.driver_data.?, fld_drv.name).init(&cfg, device_itf);

                // Open IN endpoint last so that callbacks can happen
                inline for (desc_fields) |fld| {
                    const desc = &@field(cfg, fld.name);
                    if (comptime fld.type == descriptor.Endpoint and desc.endpoint.dir == .In)
                        device_itf.ep_open(desc);
                }
            }
        }
    };
}
