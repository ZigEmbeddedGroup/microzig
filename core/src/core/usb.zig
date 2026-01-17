const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_ctrl);

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

        /// If not zero, change the device address at the next opportunity.
        /// Necessary because when the host sets the device address,
        /// the acknowledgement step must use the _old_ address.
        new_address: u8,
        /// 0 - no config set
        cfg_num: u16,
        /// Ep0 data waiting to be sent
        tx_slice: ?[]const u8,
        /// Driver state
        driver_data: ?config0.Drivers,

        /// Initial values
        pub const init: @This() = .{
            .new_address = 0,
            .cfg_num = 0,
            .tx_slice = null,
            .driver_data = null,
        };

        /// Returns a pointer to the drivers
        /// or null in case host has not yet configured the device.
        pub fn drivers(self: *@This()) ?*config0.Drivers {
            return if (self.driver_data) |*ret| ret else null;
        }

        /// Called by the device implementation when a setup request has been received.
        pub fn on_setup_req(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) void {
            log.debug("on_setup_req", .{});

            const ret = switch (setup.request_type.recipient) {
                .Device => self.process_device_setup(device_itf, setup),
                .Interface => self.process_interface_setup(setup),
                else => nak,
            };
            if (ret) |data| {
                if (data.len == 0)
                    device_itf.ep_ack(.ep0)
                else {
                    const limited = data[0..@min(data.len, setup.length.into())];
                    const len = device_itf.ep_writev(.ep0, &.{limited});
                    assert(len <= config.device_descriptor.max_packet_size0);
                    self.tx_slice = limited[len..];
                }
            }
        }

        /// Called by the device implementation when a packet has been sent or received.
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, comptime ep: types.Endpoint) void {
            log.debug("on_buffer {t} {t}", .{ ep.num, ep.dir });

            const handler = comptime @field(handlers, @tagName(ep.dir))[@intFromEnum(ep.num)];

            if (comptime ep == types.Endpoint.in(.ep0)) {
                // We use this opportunity to finish the delayed
                // SetAddress request, if there is one:
                if (self.new_address != 0) {
                    device_itf.set_address(@intCast(self.new_address));
                    self.new_address = 0;
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

                        // None of the drivers so far are using the ACK phase
                        // if (self.driver_last) |drv|
                        //     self.driver_class_control(device_itf, drv, .Ack, &self.setup_packet);
                    }
                }
            } else if (comptime ep == types.Endpoint.out(.ep0))
                log.warn("Unhandled packet on ep0 Out", .{});

            if (comptime handler.driver.len != 0) {
                const drv = &@field(self.driver_data.?, handler.driver);
                @field(@FieldType(config0.Drivers, handler.driver), handler.function)(drv, ep.num);
            }
        }

        /// Called by the device implementation on bus reset.
        pub fn on_bus_reset(self: *@This(), device_itf: *DeviceInterface) void {
            log.debug("on_bus_reset", .{});

            self.process_set_config(device_itf, 0);

            // Reset our state.
            self.* = .init;
        }

        // Utility functions

        fn process_device_setup(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) ?[]const u8 {
            switch (setup.request_type.type) {
                .Standard => {
                    const request: types.SetupRequest = @enumFromInt(setup.request);
                    log.debug("Device setup: {t}", .{request});
                    switch (request) {
                        .SetAddress => self.new_address = @truncate(setup.value.into()),
                        .SetConfiguration => self.process_set_config(device_itf, setup.value.into()),
                        .GetDescriptor => return get_descriptor(setup.value.into()),
                        .SetFeature => {
                            const feature: types.FeatureSelector = @enumFromInt(setup.value.into() >> 8);
                            switch (feature) {
                                .DeviceRemoteWakeup, .EndpointHalt => {},
                                // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                                .TestMode => return nak,
                                else => return nak,
                            }
                        },
                        _ => {
                            log.warn("Unsupported standard request: {}", .{setup.request});
                            return nak;
                        },
                    }
                    return ack;
                },
                else => |t| {
                    log.warn("Unhandled device setup request: {t}", .{t});
                    return nak;
                },
            }
        }

        fn process_interface_setup(self: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
            const itf_num: u8 = @truncate(setup.index.into());
            switch (itf_num) {
                inline else => |itf| if (comptime itf < handlers.itf.len) {
                    const drv = handlers.itf[itf];
                    return @field(self.driver_data.?, @tagName(drv)).interface_setup(setup);
                } else {
                    log.warn("Interface index ({}) out of range ({})", .{ itf_num, handlers.itf.len });
                    return nak;
                },
            }
        }

        fn get_descriptor(value: u16) ?[]const u8 {
            const asBytes = std.mem.asBytes;
            const desc_type: descriptor.Type = @enumFromInt(value >> 8);
            const desc_idx: u8 = @truncate(value);
            log.debug("Request for {t} descriptor {}", .{ desc_type, desc_idx });
            return switch (desc_type) {
                .Device => asBytes(&config.device_descriptor),
                .DeviceQualifier => asBytes(comptime &config.device_descriptor.qualifier()),
                .Configuration => asBytes(&config_descriptor),
                .String => if (desc_idx < config.string_descriptors.len)
                    config.string_descriptors[desc_idx].data
                else {
                    log.warn(
                        "Descriptor index ({}) out of range ({})",
                        .{ desc_idx, config.string_descriptors.len },
                    );
                    return nak;
                },
                else => nak,
            };
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
