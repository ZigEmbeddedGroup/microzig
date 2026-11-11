const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_ctrl);

pub const descriptor = @import("usb/descriptor.zig");
pub const drivers = struct {
    pub const CDC = @import("usb/drivers/CDC.zig");
    pub const EchoExample = @import("usb/drivers/EchoExample.zig");
    pub const HID_Interrupt = @import("usb/drivers/HID.zig");
};
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";
pub const nak: ?[]const u8 = null;

/// Helper struct for endpoint allocation for drivers.
/// Also deduplicates static strings.
pub const DescriptorAllocator = struct {
    next_ep_num: [2]u8,
    next_itf_num: u8,
    unique_endpoints: bool,
    strings: []const []const u8,

    pub fn init(unique_endpoints: bool, strings: []const []const u8) @This() {
        return .{
            .next_ep_num = @splat(1),
            .next_itf_num = 0,
            .unique_endpoints = unique_endpoints,
            .strings = strings,
        };
    }

    pub fn next_ep(self: *@This(), dir: types.Dir) types.Endpoint {
        const idx: u1 = @backingInt(dir);
        const ret = self.next_ep_num[idx];
        self.next_ep_num[idx] += 1;
        if (self.unique_endpoints)
            self.next_ep_num[idx ^ 1] += 1;
        return .{ .dir = dir, .num = @fromBackingInt(ret) };
    }

    pub fn next_itf(self: *@This()) u8 {
        defer self.next_itf_num += 1;
        return self.next_itf_num;
    }

    pub fn string(self: *@This(), str: []const u8) u8 {
        self.strings, const ret = dedup_string(self.strings, str);
        return ret;
    }

    pub fn to_const(self: *DescriptorAllocator) DescriptorAllocator {
        defer self.* = undefined;
        return self.*;
    }
};

/// Wraps a Descriptor type. Returned by the `create` method of the Descriptor.
pub fn DescriptorCreateResult(Descriptor: type) type {
    return struct {
        descriptor: Descriptor,
        /// If not null, a slice of this length will be passed
        /// to driver's init function.
        alloc_bytes: ?usize = null,
        /// Null means natural alignment
        alloc_align: ?usize = null,
    };
}

/// USB Device interface
/// Any device implementation used with DeviceController must implement these functions
pub const DeviceInterface = struct {
    pub const VTable = struct {
        ep_writev: *const fn (*DeviceInterface, types.Endpoint.Num, []const []const u8) types.PacketLength,
        ep_readv: *const fn (*DeviceInterface, types.Endpoint.Num, []const []u8) types.PacketLength,
        ep_listen: *const fn (*DeviceInterface, types.Endpoint.Num, types.PacketLength) void,
        ep_open: *const fn (*DeviceInterface, *const descriptor.Endpoint) void,
        set_address: *const fn (*DeviceInterface, u7) void,
    };

    vtable: *const VTable,

    /// Called by drivers to send a packet.
    pub fn ep_writev(self: *@This(), ep_num: types.Endpoint.Num, data: []const []const u8) types.PacketLength {
        return self.vtable.ep_writev(self, ep_num, data);
    }

    /// Send ack on given IN endpoint.
    pub fn ep_ack(self: *@This(), ep_num: types.Endpoint.Num) void {
        assert(0 == self.ep_writev(ep_num, &.{ack}));
    }

    /// Called by drivers to retrieve a received packet.
    /// Must be called exactly once for each packet.
    /// Buffers in `data` must collectively be long enough to fit the whole packet.
    pub fn ep_readv(self: *@This(), ep_num: types.Endpoint.Num, data: []const []u8) types.PacketLength {
        return self.vtable.ep_readv(self, ep_num, data);
    }

    /// Called by drivers to report readiness to receive up to `len` bytes.
    /// After being called it may not be called again until a packet is received.
    pub fn ep_listen(self: *@This(), ep_num: types.Endpoint.Num, len: types.PacketLength) void {
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

pub fn DriverHandlers(Driver: type, Runtime: type) type {
    var field_names: []const [:0]const u8 = &.{};

    const info = @typeInfo(Driver.Descriptor).@"struct";
    for (info.field_names, info.field_types) |field_name, field_type| switch (field_type) {
        descriptor.Endpoint => field_names = field_names ++ .{field_name},
        else => {},
    };

    return @Struct(.auto, null, field_names, &@splat(EndpointHandler(Runtime)), &@splat(.{}));
}

pub const Options = struct {
    pub const IdStringPair = struct {
        id: u16,
        str: []const u8,
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
    max_supported_packet_size: types.PacketLength,
};

pub const ConfigurationOptions = struct {
    attributes: descriptor.Configuration.Attributes,
    max_current_ma: u9,
    name: []const u8 = "",
    /// Only use either IN or OUT on each endpoint. Useful for debugging.
    /// Realistically, it should only be turned off if you are exhausting
    /// the 15 endpoint limit.
    unique_endpoints: bool = true,
};

pub fn Configuration(
    options: ConfigurationOptions,
    Drivers: type,
    driver_args: blk: {
        const info = @typeInfo(Drivers).@"struct";
        const count = info.field_names.len;
        var field_names: [count][:0]const u8 = undefined;
        var field_types: [count]type = undefined;
        for (info.field_names, info.field_types, 0..) |field_name, field_type, i| {
            // Collect field names
            field_names[i] = field_name;
            // Collect the type info  for the Descriptor.create function parameter
            const param_types = @typeInfo(@TypeOf(field_type.Descriptor.create)).@"fn".param_types;
            // Ensure it takes 3 parameters
            assert(param_types.len == 3);
            // The first must be a DescriptorAllocator
            assert(param_types[0] == *DescriptorAllocator);
            // The second is usb.types.PacketLength
            assert(param_types[1] == types.PacketLength);
            // And save the type of the third
            field_types[i] = param_types[2].?;
        }
        break :blk @Struct(.auto, null, &field_names, &field_types, &@splat(.{}));
    },
) type {
    return struct {
        const DriverName = []const u8;

        Descriptor: type,
        DriverAlloc: type,
        drivers_ep: [2][16]?DriverName,
        HandlersEp: type,
        handlers_itf: []const DriverName,
        RuntimeData: type,

        pub fn create(max_psize: types.PacketLength, strings: []const []const u8) struct { @This(), []const []const u8 } {
            var alloc = DescriptorAllocator.init(options.unique_endpoints, strings);
            const configuration_s = alloc.string(options.name);
            const driver_info = @typeInfo(Drivers).@"struct";

            var field_names: [driver_info.field_names.len][:0]const u8 = undefined;
            var desc_field_types: [driver_info.field_names.len]type = undefined;
            var runtime_field_types: [driver_info.field_names.len]type = undefined;
            var field_attrs: [driver_info.field_names.len]std.builtin.Type.Struct.FieldAttributes = undefined;
            var ep_handler_types: [2][16]type = @splat(@splat(void));
            var ep_handler_names: [2][16][:0]const u8 = undefined;
            var ep_handler_drivers: [2][16]?usize = @splat(@splat(null));
            var handlers_itf: []const DriverName = &.{};
            var driver_alloc_names: []const [:0]const u8 = &.{};
            var driver_alloc_types: []const type = &.{};
            var driver_alloc_attrs: []const std.builtin.Type.Struct.FieldAttributes = &.{};

            for (driver_info.field_names, driver_info.field_types, 0..) |driver_field_name, DriverType, drv_id| {
                runtime_field_types[drv_id] = if (@hasField(DriverType, "generic_runtime"))
                    DriverType.Runtime(@field(driver_args, driver_field_name).generic_runtime)
                else
                    DriverType.Runtime;

                // Get descriptor type for the current driver
                const Descriptors = DriverType.Descriptor;
                // Call the create method on the descriptor, which wraps it with the allow stuff.
                const result = Descriptors.create(&alloc, max_psize, @field(driver_args, driver_field_name));
                // Get the descriptor instance from the result.
                const descriptors = result.descriptor;

                // If the driver requests memory, then collect the names, types, and attrs
                if (result.alloc_bytes) |len| {
                    driver_alloc_names = driver_alloc_names ++ &[_][:0]const u8{driver_field_name};
                    driver_alloc_types = driver_alloc_types ++ &[_]type{[len]u8};
                    driver_alloc_attrs = driver_alloc_attrs ++ &[_]std.builtin.Type.Struct.FieldAttributes{.{ .@"align" = result.alloc_align }};
                } else {
                    assert(result.alloc_align == null);
                }

                assert(@alignOf(Descriptors) == 1);

                // Collect handler types, names, and drivers, to later be bound to the appropriate
                // endpoints
                const info = @typeInfo(Descriptors).@"struct";
                for (info.field_names, info.field_types, 0..) |field_name, field_type, desc_num| {
                    const desc = @field(descriptors, field_name);

                    // Determine which interface numbers this driver owns. If it is an
                    // InterfaceAssociation, then use the interface count. If it is an Interface,
                    // then the driver owns just that one interface.
                    if (desc_num == 0) {
                        const itf_start, const itf_count = switch (field_type) {
                            descriptor.InterfaceAssociation => .{ desc.first_interface, desc.interface_count },
                            descriptor.Interface => .{ desc.interface_number, 1 },
                            else => |T| @compileError(
                                "Expected first descriptor of driver " ++
                                    @typeName(DriverType) ++
                                    " to be of type Interface or InterfaceAssociation descriptor, got: " ++
                                    @typeName(T),
                            ),
                        };
                        if (itf_start != handlers_itf.len)
                            @compileError("interface numbering mismatch");

                        handlers_itf = handlers_itf ++ @as([itf_count]DriverName, @splat(driver_field_name));
                    }

                    switch (field_type) {
                        // Register handler for endpoints
                        descriptor.Endpoint => {
                            const ep_dir = @backingInt(desc.endpoint.dir);
                            const ep_num = @backingInt(desc.endpoint.num);

                            if (ep_handler_types[ep_dir][ep_num] != void)
                                @compileError(std.fmt.comptimePrint(
                                    "ep{} {t}: multiple handlers: {s} and {s}",
                                    .{ ep_num, desc.endpoint.dir, ep_handler_drivers[ep_dir][ep_num], driver_field_name },
                                ));

                            ep_handler_types[ep_dir][ep_num] = EndpointHandler(runtime_field_types[drv_id]);
                            ep_handler_drivers[ep_dir][ep_num] = drv_id;
                            ep_handler_names[ep_dir][ep_num] = field_name;
                        },
                        // Interface association must be first
                        descriptor.InterfaceAssociation => assert(desc_num == 0),
                        else => {},
                    }
                }
                field_names[drv_id] = driver_field_name;
                desc_field_types[drv_id] = Descriptors;
                field_attrs[drv_id] = .{ .default_value_ptr = &descriptors };
            }

            // Finally, bind the handler functions based on the data collected above.
            // Create a tuple with the appropriate types
            const ep_handlers_types: [2]type = .{ @Tuple(&ep_handler_types[0]), @Tuple(&ep_handler_types[1]) };
            var ep_handlers: @Tuple(&ep_handlers_types) = undefined;
            // Iterate over all IN and OUT endpoints and bind the handler for any that are set.
            for (&ep_handler_types, &ep_handler_names, &ep_handler_drivers, 0..) |htypes, hnames, hdrivers, dir| {
                for (&htypes, &hnames, &hdrivers, 0..) |T, name, drv_id, ep| {
                    if (T != void)
                        ep_handlers[dir][ep] = @field(runtime_field_types[drv_id.?].handlers, name);
                }
            }

            // alloc is invalidated after this point. It will cause a compile error if accessed.
            const const_alloc = alloc.to_const();
            const const_ep_handlers = ep_handlers;

            const DriverConfig = @Struct(.@"extern", null, &field_names, &desc_field_types, &field_attrs);
            const Descriptor = extern struct {
                first: descriptor.Configuration = .{
                    .total_length = .from(@sizeOf(descriptor.Configuration) + @sizeOf(DriverConfig)),
                    .num_interfaces = const_alloc.next_itf_num,
                    .configuration_value = 1,
                    .configuration_s = configuration_s,
                    .attributes = options.attributes,
                    .max_current = .from_ma(options.max_current_ma),
                },
                drv: DriverConfig = .{},
            };

            std.testing.expectEqual(
                (Descriptor{}).first.total_length.native(),
                @sizeOf(Descriptor),
            ) catch unreachable;

            const idx_in = @backingInt(types.Dir.in);
            const idx_out = @backingInt(types.Dir.out);
            return .{
                .{
                    .Descriptor = Descriptor,
                    .DriverAlloc = @Struct(
                        .auto,
                        null,
                        driver_alloc_names,
                        driver_alloc_types[0..driver_alloc_attrs.len],
                        driver_alloc_attrs[0..driver_alloc_attrs.len],
                    ),
                    .drivers_ep = blk: {
                        var ret: @FieldType(@This(), "drivers_ep") = undefined;
                        for (&ret, ep_handler_drivers) |*dstv, srcv| {
                            for (dstv, srcv) |*dst, src_opt| {
                                dst.* = if (src_opt) |src| field_names[src] else null;
                            }
                        }
                        break :blk ret;
                    },
                    .HandlersEp = struct {
                        in: ep_handlers_types[idx_in] = const_ep_handlers[idx_in],
                        out: ep_handlers_types[idx_out] = const_ep_handlers[idx_out],
                    },
                    .handlers_itf = handlers_itf,
                    .RuntimeData = @Struct(.auto, null, &field_names, &runtime_field_types, &@splat(.{})),
                },
                const_alloc.strings,
            };
        }

        pub fn init(comptime self: @This(), device_itf: *DeviceInterface, driver_data: *self.RuntimeData, driver_alloc: anytype, comptime config_descriptor: anytype) void {
            inline for (@typeInfo(self.RuntimeData).@"struct".field_names) |driver_field_name| {
                const cfg = @field(config_descriptor.drv, driver_field_name);
                const desc_info = @typeInfo(@TypeOf(cfg)).@"struct";

                // Open OUT endpoint first so that the driver can call ep_listen in init
                inline for (desc_info.field_names, desc_info.field_types) |field_name, field_type| {
                    const desc = &@field(cfg, field_name);
                    if (comptime field_type == descriptor.Endpoint and desc.endpoint.dir == .out)
                        device_itf.ep_open(desc);
                }

                const drv = &@field(driver_data, driver_field_name);
                // Don't pass empty slices around
                if (@hasField(@TypeOf(driver_alloc.*), driver_field_name))
                    drv.init(&cfg, device_itf, &@field(driver_alloc, driver_field_name))
                else
                    drv.init(&cfg, device_itf);

                // Open IN endpoint last so that callbacks can happen
                inline for (desc_info.field_names, desc_info.field_types) |field_name, field_type| {
                    const desc = &@field(cfg, field_name);
                    if (comptime field_type == descriptor.Endpoint and desc.endpoint.dir == .in)
                        device_itf.ep_open(desc);
                }
            }
        }

        pub fn deinit(comptime self: @This(), device_itf: *DeviceInterface, driver_data: *self.RuntimeData) void {
            _ = device_itf;
            _ = driver_data;
            // deinitialize drivers
        }
    };
}

pub fn validate_controller(T: type) void {
    comptime {
        const info = @typeInfo(T);
        if (info != .pointer or info.pointer.attrs.@"const" or info.pointer.size != .one)
            @compileError("Expected a mutable pointer to the usb controller, got: " ++ @typeName(T));
        const Controller = info.pointer.child;
        _ = Controller;
        // More checks
    }
}

/// USB device controller
///
/// Responds to host requests and dispatches to the appropriate drivers.
/// When this type is build (at comptime), it builds descriptor and handler tables based on the
/// provided options.
pub fn DeviceController(options: Options, Configurations: []const type) type {
    // Currently only a single configuration is supported.
    std.debug.assert(Configurations.len == 1);

    return struct {
        /// This parses the drivers' descriptors and creates:
        /// * the configuration descriptor
        /// * table of handlers for endpoints
        /// * table of handlers for interfaces
        const descriptor_parse_result = blk: {
            const max_psize = options.max_supported_packet_size;
            assert(max_psize >= 8);
            assert(std.math.isPowerOfTwo(max_psize));

            var strings: []const []const u8 = &.{};
            strings, const manufacturer_s = dedup_string(strings, options.vendor.str);
            strings, const product_s = dedup_string(strings, options.product.str);
            strings, const serial_s = dedup_string(strings, options.serial);

            const desc_device: descriptor.Device = .{
                .bcd_usb = options.bcd_usb,
                .device_triple = options.device_triple,
                .max_packet_size0 = @min(options.max_supported_packet_size, 64),
                .vendor = .from(options.vendor.id),
                .product = .from(options.product.id),
                .bcd_device = options.bcd_device,
                .manufacturer_s = manufacturer_s,
                .product_s = product_s,
                .serial_s = serial_s,
                .num_configurations = Configurations.len,
            };

            var configs: @Tuple(Configurations) = undefined;
            for (0..Configurations.len) |i|
                configs[i], strings = Configurations[i].create(max_psize, strings);

            var desc_string: []const descriptor.String = &.{.from_lang(options.language)};
            for (strings) |s|
                desc_string = desc_string ++ [1]descriptor.String{.from_str(s)};

            break :blk .{
                .device_descriptor = desc_device,
                .string_descriptors = desc_string,
                .configurations = configs,
            };
        };

        const device_descriptor = descriptor_parse_result.device_descriptor;
        const string_descriptors = descriptor_parse_result.string_descriptors;
        const configurations = descriptor_parse_result.configurations;

        const config_descriptor = configurations[0].Descriptor{};
        const handlers_itf = configurations[0].handlers_itf;
        const handlers_ep = configurations[0].HandlersEp{};
        const drivers_ep = configurations[0].drivers_ep;
        const DriverAlloc = configurations[0].DriverAlloc;
        const RuntimeData = configurations[0].RuntimeData;

        /// If not zero, change the device address at the next opportunity.
        /// Necessary because when the host sets the device address,
        /// the acknowledgement step must use the _old_ address.
        new_address: u8,
        /// 0 - no config set
        cfg_num: u16,
        /// Ep0 data waiting to be sent
        tx_slice: ?[]const u8,
        /// Driver state
        driver_data: ?RuntimeData,
        /// Additional driver allocations (size is comptime-known)
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
        pub fn drivers(self: *@This()) ?*RuntimeData {
            return if (self.driver_data) |*ret| ret else null;
        }

        /// Called by the device implementation when a setup request has been received.
        pub fn on_setup_req(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) void {
            log.debug("on_setup_req", .{});

            const ret = switch (setup.request_type.recipient) {
                .device => self.process_device_setup(device_itf, setup),
                .interface => self.process_interface_setup(setup),
                else => nak,
            };
            if (ret) |data| {
                if (data.len == 0)
                    device_itf.ep_ack(.ep0)
                else {
                    const limited = data[0..@min(data.len, setup.length.native())];
                    const len = device_itf.ep_writev(.ep0, &.{limited});
                    assert(len <= device_descriptor.max_packet_size0);
                    self.tx_slice = limited[len..];
                }
            }
        }

        /// Called by the device implementation when a packet has been sent or received.
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, comptime ep: types.Endpoint) void {
            log.debug("on_buffer {t} {t}", .{ ep.num, ep.dir });

            const driver_opt = comptime drivers_ep[@backingInt(ep.dir)][@backingInt(ep.num)];
            const handler = comptime @field(handlers_ep, @tagName(ep.dir))[@backingInt(ep.num)];

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

                        // W could call an ACK phase callback here,
                        // but none of the drivers so far need it.
                    }
                }
            } else if (comptime ep == types.Endpoint.out(.ep0))
                log.warn("Unhandled packet on ep0 Out", .{});

            if (comptime driver_opt) |driver| {
                handler(&@field(self.driver_data.?, driver), ep.num);
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
                .standard => {
                    const request: types.SetupRequest = @fromBackingInt(setup.request);
                    log.debug("Device setup: {any}", .{request});
                    switch (request) {
                        .get_status => {
                            const attr = config_descriptor.first.attributes;
                            const status: types.DeviceStatus = comptime .create(attr.self_powered, false);
                            return std.mem.asBytes(&status);
                        },
                        .set_address => self.new_address = @truncate(setup.value.native()),
                        .set_configuration => self.process_set_config(device_itf, setup.value.native()),
                        .get_descriptor => return get_descriptor(setup.value.native()),
                        .set_feature => {
                            const feature: types.FeatureSelector = @fromBackingInt(@intCast(setup.value.native() >> 8));
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
            const itf_num: u8 = @truncate(setup.index.native());
            switch (itf_num) {
                inline else => |itf| if (comptime itf < handlers_itf.len) {
                    const drv = handlers_itf[itf];
                    return @field(self.driver_data.?, drv).class_request(setup);
                } else {
                    log.warn("Interface index ({}) out of range ({})", .{ itf_num, handlers_itf.len });
                    return nak;
                },
            }
        }

        // Return the appropriate descriptor type as determined by the top 8 bits of the value.
        fn get_descriptor(value: u16) ?[]const u8 {
            const asBytes = std.mem.asBytes;
            const desc_type: descriptor.Type = @fromBackingInt(@intCast(value >> 8));
            const desc_idx: u8 = @truncate(value);
            log.debug("Request for {any} descriptor {}", .{ desc_type, desc_idx });
            return switch (desc_type) {
                .device => asBytes(&device_descriptor),
                .device_qualifier => asBytes(comptime &device_descriptor.qualifier()),
                .configuration => asBytes(&config_descriptor),
                .string => if (desc_idx < string_descriptors.len)
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

            if (self.driver_data) |*data_old|
                configurations[0].deinit(device_itf, data_old);

            self.cfg_num = cfg_num;
            if (cfg_num == 0)
                self.driver_data = null
            else {
                // We support just one config for now so ignore config index
                self.driver_data = @as(RuntimeData, undefined);
                configurations[0].init(device_itf, &self.driver_data.?, &self.driver_alloc, config_descriptor);
            }
        }
    };
}

fn dedup_string(
    comptime strings: []const []const u8,
    comptime new: []const u8,
) struct { []const []const u8, u8 } {
    if (new.len == 0)
        return .{ strings, 0 };
    // deduplicate
    for (strings, 1..) |s, i| {
        if (std.mem.eql(u8, s, new))
            return .{ strings, i };
    }
    const new_strings = strings ++ .{new};
    return .{ new_strings, @intCast(new_strings.len) };
}
