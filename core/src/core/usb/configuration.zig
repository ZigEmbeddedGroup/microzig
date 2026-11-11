const std = @import("std");
const usb = @import("../usb.zig");

const assert = std.debug.assert;
const descriptor = usb.descriptor;
const types = usb.types;

pub const Options = struct {
    attributes: descriptor.Configuration.Attributes,
    max_current_ma: u9,
    name: []const u8 = "",
    /// Only use either IN or OUT on each endpoint. Useful for debugging.
    /// Realistically, it should only be turned off if you are exhausting
    /// the 15 endpoint limit.
    unique_endpoints: bool = true,
};

pub fn Create(
    options: Options,
    driver_config: anytype,
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
            var alloc = usb.DescriptorAllocator.init(options.unique_endpoints, strings);
            const configuration_s = alloc.string(options.name);
            const driver_info = @typeInfo(@TypeOf(driver_config)).@"struct";
            const driver_field_names = driver_info.field_names;

            var desc_field_types: [driver_field_names.len]type = undefined;
            var runtime_field_types: [driver_field_names.len]type = undefined;
            var field_attrs: [driver_field_names.len]std.builtin.Type.Struct.FieldAttributes = undefined;
            var ep_handler_types: [2][16]type = @splat(@splat(void));
            var ep_handler_names: [2][16][:0]const u8 = undefined;
            var ep_handler_drivers: [2][16]?usize = @splat(@splat(null));
            var handlers_itf: []const DriverName = &.{};
            var driver_alloc_names: []const [:0]const u8 = &.{};
            var driver_alloc_types: []const type = &.{};
            var driver_alloc_attrs: []const std.builtin.Type.Struct.FieldAttributes = &.{};

            for (driver_field_names, driver_info.field_types, 0..) |driver_field_name, DriverType, drv_id| {
                const drv = @field(driver_config, driver_field_name);

                // Get descriptor type for the current driver
                // Call the create method on the descriptor, which wraps it with the allow stuff.
                const result = drv.create_descriptor(&alloc, max_psize);
                const Descriptor = @TypeOf(result.descriptor);

                // If the driver requests memory, then collect the names, types, and attrs
                const Runtime = switch (@typeInfo(@TypeOf(DriverType.Runtime))) {
                    .@"fn" => drv.Runtime(),
                    else => DriverType.Runtime,
                };
                runtime_field_types[drv_id] = Runtime;

                if (result.alloc_bytes) |len| {
                    driver_alloc_names = driver_alloc_names ++ &[_][:0]const u8{driver_field_name};
                    driver_alloc_types = driver_alloc_types ++ &[_]type{[len]u8};
                    driver_alloc_attrs = driver_alloc_attrs ++ &[_]std.builtin.Type.Struct.FieldAttributes{.{ .@"align" = result.alloc_align }};
                } else {
                    assert(result.alloc_align == null);
                }

                assert(@alignOf(Descriptor) == 1);

                // Collect handler types, names, and drivers, to later be bound to the appropriate
                // endpoints
                const info = @typeInfo(Descriptor).@"struct";
                for (info.field_names, info.field_types, 0..) |field_name, field_type, desc_num| {
                    const desc = @field(result.descriptor, field_name);

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

                            ep_handler_types[ep_dir][ep_num] = usb.EndpointHandler(runtime_field_types[drv_id]);
                            ep_handler_drivers[ep_dir][ep_num] = drv_id;
                            ep_handler_names[ep_dir][ep_num] = field_name;
                        },
                        // Interface association must be first
                        descriptor.InterfaceAssociation => assert(desc_num == 0),
                        else => {},
                    }
                }
                desc_field_types[drv_id] = Descriptor;
                field_attrs[drv_id] = .{ .default_value_ptr = &result.descriptor };
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

            const DriverConfig = @Struct(
                .@"extern",
                null,
                driver_field_names,
                &desc_field_types,
                &field_attrs,
            );

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
                                dst.* = if (src_opt) |src| driver_field_names[src] else null;
                            }
                        }
                        break :blk ret;
                    },
                    .HandlersEp = struct {
                        in: ep_handlers_types[idx_in] = const_ep_handlers[idx_in],
                        out: ep_handlers_types[idx_out] = const_ep_handlers[idx_out],
                    },
                    .handlers_itf = handlers_itf,
                    .RuntimeData = @Struct(
                        .auto,
                        null,
                        driver_field_names,
                        &runtime_field_types,
                        &@splat(.{}),
                    ),
                },
                const_alloc.strings,
            };
        }

        pub fn init(comptime self: @This(), device_itf: *usb.DeviceInterface, driver_data: *self.RuntimeData, driver_alloc: anytype, comptime config_descriptor: anytype) void {
            inline for (@typeInfo(self.RuntimeData).@"struct".field_names) |driver_field_name| {
                const cfg = @field(config_descriptor.drv, driver_field_name);
                const desc_info = @typeInfo(@TypeOf(cfg)).@"struct";

                // Open OUT endpoint first so that the driver can call ep_listen in init
                inline for (desc_info.field_names, desc_info.field_types) |field_name, field_type| {
                    const desc = &@field(cfg, field_name);
                    if (comptime field_type == descriptor.Endpoint and desc.endpoint.dir == .out)
                        device_itf.ep_open(desc);
                }

                const drv = @field(driver_config, driver_field_name);
                const runtime = &@field(driver_data, driver_field_name);
                // Don't pass empty slices around
                if (@hasField(@TypeOf(driver_alloc.*), driver_field_name))
                    drv.init_runtime(cfg, runtime, device_itf, &@field(driver_alloc, driver_field_name))
                else
                    drv.init_runtime(cfg, runtime, device_itf);

                // Open IN endpoint last so that callbacks can happen
                inline for (desc_info.field_names, desc_info.field_types) |field_name, field_type| {
                    const desc = &@field(cfg, field_name);
                    if (comptime field_type == descriptor.Endpoint and desc.endpoint.dir == .in)
                        device_itf.ep_open(desc);
                }
            }
        }

        pub fn deinit(comptime self: @This(), device_itf: *usb.DeviceInterface, driver_data: *self.RuntimeData) void {
            _ = device_itf;
            _ = driver_data;
            // deinitialize drivers
        }
    };
}
