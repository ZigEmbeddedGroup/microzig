const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_ctrl);

pub const descriptor = @import("usb/descriptor.zig");
pub const drivers = struct {
    pub const CDC = @import("usb/drivers/CDC.zig");
    pub const EchoExample = @import("usb/drivers/EchoExample.zig");
    pub const hid = @import("usb/drivers/hid.zig");
};
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";
pub const nak: ?[]const u8 = null;

/// Meant to make transition to zig 0.16 easier
pub const StructFieldAttributes = struct {
    @"comptime": bool = false,
    @"align": ?usize = null,
    default_value_ptr: ?*const anyopaque = null,
};

/// Meant to make transition to zig 0.16 easier
pub fn Struct(
    comptime layout: std.builtin.Type.ContainerLayout,
    comptime BackingInt: ?type,
    comptime field_names: []const [:0]const u8,
    comptime field_types: *const [field_names.len]type,
    comptime field_attrs: *const [field_names.len]StructFieldAttributes,
) type {
    comptime var fields: []const std.builtin.Type.StructField = &.{};
    for (field_names, field_types, field_attrs) |n, T, a| {
        fields = fields ++ &[1]std.builtin.Type.StructField{.{
            .name = n,
            .type = T,
            .alignment = a.@"align" orelse @alignOf(T),
            .default_value_ptr = a.default_value_ptr,
            .is_comptime = a.@"comptime",
        }};
    }
    return @Type(.{ .@"struct" = .{
        .layout = layout,
        .backing_integer = BackingInt,
        .decls = &.{},
        .fields = fields,
        .is_tuple = false,
    } });
}

const drivers_alias = drivers;

pub const DescriptorAllocator = struct {
    next_ep_num: [2]u8,
    next_itf_num: u8,
    unique_endpoints: bool,
    strings: []const []const u8,

    pub fn init(unique_endpoints: bool) @This() {
        return .{
            .next_ep_num = @splat(1),
            .next_itf_num = 0,
            .unique_endpoints = unique_endpoints,
            .strings = &.{},
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

    pub fn string(self: *@This(), str: []const u8) u8 {
        if (str.len == 0) return 0;
        // deduplicate
        for (self.strings, 1..) |s, i| {
            if (std.mem.eql(u8, s, str))
                return i;
        }

        self.strings = self.strings ++ .{str};
        return @intCast(self.strings.len);
    }

    pub fn string_descriptors(self: @This(), lang: descriptor.String.Language) []const descriptor.String {
        var ret: []const descriptor.String = &.{.from_lang(lang)};
        for (self.strings) |s|
            ret = ret ++ [1]descriptor.String{.from_str(s)};
        return ret;
    }
};

pub fn DescriptorCreateResult(Descriptor: type) type {
    return struct {
        descriptor: Descriptor,
        alloc_bytes: usize = 0,
        alloc_align: ?usize = null,
    };
}

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

pub fn EndpointHandler(Driver: type) type {
    return fn (*Driver, types.Endpoint.Num) void;
}

pub fn DriverHadlers(Driver: type) type {
    var field_names: []const [:0]const u8 = &.{};

    const desc_fields = @typeInfo(Driver.Descriptor).@"struct".fields;
    for (desc_fields) |fld| switch (fld.type) {
        descriptor.Endpoint => field_names = field_names ++ .{fld.name},
        else => {},
    };

    return Struct(
        .auto,
        null,
        field_names,
        &@splat(EndpointHandler(Driver)),
        &@splat(.{}),
    );
}

pub const Config = struct {
    pub const IdStringPair = struct {
        id: u16,
        str: []const u8,
    };

    pub const Configuration = struct {
        name: []const u8 = "",
        attributes: descriptor.Configuration.Attributes,
        max_current_ma: u9,
        Drivers: type,

        pub fn Args(self: @This()) type {
            const fields = @typeInfo(self.Drivers).@"struct".fields;
            var field_names: [fields.len][:0]const u8 = undefined;
            var field_types: [fields.len]type = undefined;
            for (fields, 0..) |fld, i| {
                field_names[i] = fld.name;
                const params = @typeInfo(@TypeOf(fld.type.Descriptor.create)).@"fn".params;
                assert(params.len == 3);
                assert(params[0].type == *DescriptorAllocator);
                assert(params[1].type == types.Len);
                field_types[i] = params[2].type.?;
            }
            return Struct(.auto, null, &field_names, &field_types, &@splat(.{}));
        }
    };

    /// Usb specification version.
    bcd_usb: types.Version,
    /// Class, subclass and protocol of this device.
    device_triple: types.ClassSubclassProtocol,
    /// Vendor id and string
    vendor: IdStringPair,
    /// Product id and string.
    product: IdStringPair,
    /// Device version.
    bcd_device: types.Version,
    /// String descriptor 0.
    language: descriptor.String.Language = .English,
    /// Serial number string.
    serial: []const u8,
    /// Largest packet length the hardware supports. Must be a power of 2 and at least 8.
    max_supported_packet_size: types.Len,
    /// Currently only a single configuration is supported.
    configurations: []const Configuration,
    /// Only use either IN or OUT on each endpoint. Useful for debugging.
    /// Realistically, it should only be turned off if you are exhausting
    /// the 15 endpoint limit.
    unique_endpoints: bool = true,

    pub fn DriverArgs(self: @This()) type {
        var field_types: [self.configurations.len]type = undefined;
        for (self.configurations, &field_types) |cfg, *dst|
            dst.* = cfg.Args();
        return std.meta.Tuple(&field_types);
    }
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
pub fn DeviceController(config: Config, driver_args: config.DriverArgs()) type {
    std.debug.assert(config.configurations.len == 1);

    return struct {
        const config0 = config.configurations[0];
        const driver_fields = @typeInfo(config0.Drivers).@"struct".fields;
        const DriverEnum = std.meta.FieldEnum(config0.Drivers);

        /// This parses the drivers' descriptors and creates:
        /// * the configuration descriptor (currently only one configuration is supported)
        /// * table of handlers for endpoints
        /// * table of handlers for interfaces
        const descriptor_parse_result = blk: {
            const max_psize = config.max_supported_packet_size;
            assert(max_psize >= 8);
            assert(std.math.isPowerOfTwo(max_psize));

            var alloc: DescriptorAllocator = .init(config.unique_endpoints);

            const desc_device: descriptor.Device = .{
                .bcd_usb = config.bcd_usb,
                .device_triple = config.device_triple,
                .max_packet_size0 = @max(config.max_supported_packet_size, 64),
                .vendor = .from(config.vendor.id),
                .product = .from(config.product.id),
                .bcd_device = config.bcd_device,
                .manufacturer_s = alloc.string(config.vendor.str),
                .product_s = alloc.string(config.product.str),
                .serial_s = alloc.string(config.serial),
                .num_configurations = config.configurations.len,
            };
            const configuration_s = alloc.string(config0.name);

            var size = @sizeOf(descriptor.Configuration);
            var field_names: [driver_fields.len][:0]const u8 = undefined;
            var field_types: [field_names.len]type = undefined;
            var field_attrs: [field_names.len]StructFieldAttributes = undefined;
            var ep_handler_types: [2][16]type = @splat(@splat(void));
            var ep_handler_names: [2][16][:0]const u8 = undefined;
            var ep_handler_drivers: [2][16]?usize = @splat(@splat(null));
            var itf_handlers: []const DriverEnum = &.{};
            var driver_alloc_types: [driver_fields.len]type = undefined;
            var driver_alloc_attrs: [driver_fields.len]StructFieldAttributes = @splat(.{});

            for (driver_fields, 0..) |drv, drv_id| {
                const Descriptors = drv.type.Descriptor;
                const result = Descriptors.create(&alloc, max_psize, @field(driver_args[0], drv.name));
                const descriptors = result.descriptor;

                driver_alloc_types[drv_id] = [result.alloc_bytes]u8;
                driver_alloc_attrs[drv_id].@"align" = result.alloc_align;

                assert(@alignOf(Descriptors) == 1);
                size += @sizeOf(Descriptors);

                for (@typeInfo(Descriptors).@"struct".fields, 0..) |fld, desc_num| {
                    const desc = @field(descriptors, fld.name);

                    if (desc_num == 0) {
                        const itf_start, const itf_count = switch (fld.type) {
                            descriptor.InterfaceAssociation => .{ desc.first_interface, desc.interface_count },
                            descriptor.Interface => .{ desc.interface_number, 1 },
                            else => |T| @compileError(
                                "Expected first descriptor of driver " ++
                                    @typeName(drv.type) ++
                                    " to be of type Interface or InterfaceAssociation descriptor, got: " ++
                                    @typeName(T),
                            ),
                        };
                        if (itf_start != itf_handlers.len)
                            @compileError("interface numbering mismatch");
                        itf_handlers = itf_handlers ++ &[1]DriverEnum{@field(DriverEnum, drv.name)} ** itf_count;
                    }

                    switch (fld.type) {
                        descriptor.Endpoint => {
                            const ep_dir = @intFromEnum(desc.endpoint.dir);
                            const ep_num = @intFromEnum(desc.endpoint.num);

                            if (ep_handler_types[ep_dir][ep_num] != void)
                                @compileError(std.fmt.comptimePrint(
                                    "ep{} {t}: multiple handlers: {s} and {s}",
                                    .{ ep_num, desc.endpoint.dir, ep_handler_drivers[ep_dir][ep_num], drv.name },
                                ));

                            ep_handler_types[ep_dir][ep_num] = EndpointHandler(drv.type);
                            ep_handler_drivers[ep_dir][ep_num] = drv_id;
                            ep_handler_names[ep_dir][ep_num] = fld.name;
                        },
                        descriptor.InterfaceAssociation => assert(desc_num == 0),
                        else => {},
                    }
                }
                field_names[drv_id] = drv.name;
                field_types[drv_id] = Descriptors;
                field_attrs[drv_id] = .{ .default_value_ptr = &descriptors };
            }

            const Tuple = std.meta.Tuple;
            const ep_handlers_types: [2]type = .{ Tuple(&ep_handler_types[0]), Tuple(&ep_handler_types[1]) };
            var ep_handlers: Tuple(&ep_handlers_types) = undefined;
            for (&ep_handler_types, &ep_handler_names, &ep_handler_drivers, 0..) |htypes, hnames, hdrivers, dir| {
                for (&htypes, &hnames, &hdrivers, 0..) |T, name, drv_id, ep| {
                    if (T != void)
                        ep_handlers[dir][ep] = @field(driver_fields[drv_id.?].type.handlers, name);
                }
            }

            const DriverConfig = Struct(.@"extern", null, &field_names, &field_types, &field_attrs);
            const idx_in = @intFromEnum(types.Dir.In);
            const idx_out = @intFromEnum(types.Dir.Out);
            break :blk .{
                .device_descriptor = desc_device,
                .config_descriptor = extern struct {
                    first: descriptor.Configuration = .{
                        .total_length = .from(size),
                        .num_interfaces = alloc.next_itf_num,
                        .configuration_value = 1,
                        .configuration_s = configuration_s,
                        .attributes = config0.attributes,
                        .max_current = .from_ma(config0.max_current_ma),
                    },
                    drv: DriverConfig = .{},
                }{},
                .string_descriptors = alloc.string_descriptors(config.language),
                .handlers_itf = itf_handlers,
                .handlers_ep = struct {
                    In: ep_handlers_types[idx_in] = ep_handlers[idx_in],
                    Out: ep_handlers_types[idx_out] = ep_handlers[idx_out],
                }{},
                .drivers_ep = ep_handler_drivers,
                .DriverAlloc = Struct(.auto, null, &field_names, &driver_alloc_types, &driver_alloc_attrs),
            };
        };

        const config_descriptor = descriptor_parse_result.config_descriptor;
        const device_descriptor = descriptor_parse_result.device_descriptor;
        const string_descriptors = descriptor_parse_result.string_descriptors;
        const handlers_itf = descriptor_parse_result.handlers_itf;
        const handlers_ep = .{
            .han = descriptor_parse_result.handlers_ep,
            .drv = descriptor_parse_result.drivers_ep,
        };
        const DriverAlloc = descriptor_parse_result.DriverAlloc;

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
        ///
        driver_alloc: DriverAlloc,

        /// Initial values
        pub const init: @This() = .{
            .new_address = 0,
            .cfg_num = 0,
            .tx_slice = null,
            .driver_data = null,
            .driver_alloc = undefined,
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
                    assert(len <= device_descriptor.max_packet_size0);
                    self.tx_slice = limited[len..];
                }
            }
        }

        /// Called by the device implementation when a packet has been sent or received.
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, comptime ep: types.Endpoint) void {
            log.debug("on_buffer {t} {t}", .{ ep.num, ep.dir });

            const driver_opt = comptime handlers_ep.drv[@intFromEnum(ep.dir)][@intFromEnum(ep.num)];
            const handler = comptime @field(handlers_ep.han, @tagName(ep.dir))[@intFromEnum(ep.num)];

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

            if (comptime driver_opt) |driver| {
                handler(&@field(self.driver_data.?, driver_fields[driver].name), ep.num);
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
                    log.debug("Device setup: {any}", .{request});
                    switch (request) {
                        .GetStatus => {
                            const attr = config_descriptor.first.attributes;
                            const status: types.DeviceStatus = comptime .create(attr.self_powered, false);
                            return std.mem.asBytes(&status);
                        },
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
                        else => {
                            log.warn("Unsupported standard request: {}", .{setup.request});
                            return nak;
                        },
                    }
                    return ack;
                },
                else => |t| {
                    log.warn("Unhandled device setup request: {any}", .{t});
                    return nak;
                },
            }
        }

        fn process_interface_setup(self: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
            const itf_num: u8 = @truncate(setup.index.into());
            switch (itf_num) {
                inline else => |itf| if (comptime itf < handlers_itf.len) {
                    const drv = handlers_itf[itf];
                    return @field(self.driver_data.?, @tagName(drv)).class_request(setup);
                } else {
                    log.warn("Interface index ({}) out of range ({})", .{ itf_num, handlers_itf.len });
                    return nak;
                },
            }
        }

        fn get_descriptor(value: u16) ?[]const u8 {
            const asBytes = std.mem.asBytes;
            const desc_type: descriptor.Type = @enumFromInt(value >> 8);
            const desc_idx: u8 = @truncate(value);
            log.debug("Request for {any} descriptor {}", .{ desc_type, desc_idx });
            return switch (desc_type) {
                .Device => asBytes(&device_descriptor),
                .DeviceQualifier => asBytes(comptime &device_descriptor.qualifier()),
                .Configuration => asBytes(&config_descriptor),
                .String => if (desc_idx < string_descriptors.len)
                    string_descriptors[desc_idx].data
                else {
                    log.warn(
                        "Descriptor index ({}) out of range ({})",
                        .{ desc_idx, string_descriptors.len },
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
                const cfg = @field(config_descriptor.drv, fld_drv.name);
                const desc_fields = @typeInfo(@TypeOf(cfg)).@"struct".fields;

                // Open OUT endpoint first so that the driver can call ep_listen in init
                inline for (desc_fields) |fld| {
                    const desc = &@field(cfg, fld.name);
                    if (comptime fld.type == descriptor.Endpoint and desc.endpoint.dir == .Out)
                        device_itf.ep_open(desc);
                }

                @field(self.driver_data.?, fld_drv.name).init(
                    &cfg,
                    device_itf,
                    &@field(self.driver_alloc, fld_drv.name),
                );

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
