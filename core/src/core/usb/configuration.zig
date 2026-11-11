const std = @import("std");
const usb = @import("../usb.zig");

const assert = std.debug.assert;
const descriptor = usb.descriptor;

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
    // Descriptor and EndpointHandlers are passed the default value of a struct,
    // because zig does not support `anytype` in structs.
    return struct {
        const DriverName = []const u8;

        Descriptor: type,
        DriverAlloc: type,
        RuntimeData: type,

        endpoint2driver: [2][16]DriverName,
        EndpointHandlers: type,
        interface2driver: []const DriverName,

        pub fn create(device_capabilities: usb.DeviceCapabilities, strings: []const []const u8) struct { @This(), []const []const u8 } {
            var alloc = usb.DescriptorAllocator.init(options.unique_endpoints, strings);
            const configuration_s = alloc.string(options.name);
            const driver_names = @typeInfo(@TypeOf(driver_config)).@"struct".field_names;

            var endpoint2driver: [2][16]DriverName = @splat(@splat(""));
            var interface2driver: []const DriverName = &.{};

            // RuntimeData
            var runtime_field_types: [driver_names.len]type = undefined;

            // Descriptor
            var desc_field_types: [driver_names.len]type = undefined;
            var desc_field_attrs: [driver_names.len]std.builtin.Type.Struct.FieldAttributes = undefined;

            // EndpointHandlers
            var ep_handler_types: [2][16]type = @splat(@splat(void));
            var ep_handler_names: [2][16][:0]const u8 = undefined;

            // DriverAlloc
            var driver_alloc_types: [driver_names.len]type = undefined;
            var driver_alloc_attrs: [driver_names.len]std.builtin.Type.Struct.FieldAttributes = undefined;

            for (
                driver_names,
                &runtime_field_types,
                &desc_field_types,
                &desc_field_attrs,
                &driver_alloc_types,
                &driver_alloc_attrs,
            ) |
                driver_field_name,
                *Runtime,
                *Descriptor,
                *desc_attr,
                *driver_alloc_type,
                *driver_alloc_attr,
            | {
                // Get type information for the current driver
                const drv = @field(driver_config, driver_field_name);
                const driver_data = drv.driver_info(device_capabilities, &alloc);
                Descriptor.* = @TypeOf(driver_data.descriptor);
                assert(@alignOf(Descriptor.*) == 1);
                Runtime.* = driver_data.Runtime;
                desc_attr.* = .{ .default_value_ptr = &driver_data.descriptor };
                driver_alloc_type.* = driver_data.Alloc;
                driver_alloc_attr.* = driver_data.alloc_attrs;

                // Collect handler types, names, and drivers, to later be bound to the appropriate
                // endpoints
                const desc_info = @typeInfo(Descriptor.*).@"struct";
                for (desc_info.field_names, desc_info.field_types, 0..) |desc_field_name, DescriptorField, desc_num| {
                    const desc = @field(driver_data.descriptor, desc_field_name);

                    // Determine which interface numbers this driver owns. If it is an
                    // InterfaceAssociation, then use the interface count. If it is an Interface,
                    // then the driver owns just that one interface.
                    if (desc_num == 0) {
                        const itf_start, const itf_count = switch (DescriptorField) {
                            descriptor.InterfaceAssociation => .{ desc.first_interface, desc.interface_count },
                            descriptor.Interface => .{ desc.interface_number, 1 },
                            else => |T| @compileError(
                                "Expected first descriptor of driver " ++
                                    @typeName(@TypeOf(drv)) ++
                                    " to be of type Interface or InterfaceAssociation descriptor, got: " ++
                                    @typeName(T),
                            ),
                        };
                        if (itf_start != interface2driver.len)
                            @compileError("interface numbering mismatch");

                        interface2driver = interface2driver ++ @as([itf_count]DriverName, @splat(driver_field_name));
                    }

                    switch (DescriptorField) {
                        // Register handler for endpoints
                        descriptor.Endpoint => {
                            const ep_dir = @backingInt(desc.endpoint.dir);
                            const ep_num = @backingInt(desc.endpoint.num);

                            if (endpoint2driver[ep_dir][ep_num].len != 0)
                                @compileError(std.fmt.comptimePrint(
                                    "ep{} {t}: multiple handlers: {s} and {s}",
                                    .{ ep_num, desc.endpoint.dir, endpoint2driver[ep_dir][ep_num], driver_field_name },
                                ));

                            endpoint2driver[ep_dir][ep_num] = driver_field_name;
                            ep_handler_names[ep_dir][ep_num] = desc_field_name;
                            ep_handler_types[ep_dir][ep_num] = usb.EndpointHandler(Runtime.*);
                        },
                        // Interface association must be first
                        descriptor.InterfaceAssociation => assert(desc_num == 0),
                        else => {},
                    }
                }
            }

            const RuntimeData = @Struct(
                .auto,
                null,
                driver_names,
                &runtime_field_types,
                &@splat(.{}),
            );

            // Finally, bind the handler functions based on the data collected above.
            // Create a tuple with the appropriate types
            const ep_handlers_types: [2]type = .{ @Tuple(&ep_handler_types[0]), @Tuple(&ep_handler_types[1]) };
            var ep_handlers: @Tuple(&ep_handlers_types) = undefined;
            // Iterate over all IN and OUT endpoints and bind the handler for any that are set.
            for (&ep_handlers, &ep_handler_names, &ep_handler_types, &endpoint2driver) |*handlers, *names, *types, *drivers| {
                for (handlers, names, types, drivers) |*handler, name, Type, driver| {
                    if (Type != void)
                        handler.* = @field(@FieldType(RuntimeData, driver).handlers, name);
                }
            }

            // alloc is invalidated after this point. It will cause a compile error if accessed.
            const const_alloc = alloc.to_const();
            const const_ep_handlers = ep_handlers;

            const DriverConfig = @Struct(
                .@"extern",
                null,
                driver_names,
                &desc_field_types,
                &desc_field_attrs,
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

            const idx_in = @backingInt(usb.types.Dir.in);
            const idx_out = @backingInt(usb.types.Dir.out);
            return .{
                .{
                    .Descriptor = Descriptor,
                    .DriverAlloc = @Struct(
                        .auto,
                        null,
                        driver_names,
                        &driver_alloc_types,
                        &driver_alloc_attrs,
                    ),
                    .endpoint2driver = endpoint2driver,
                    .EndpointHandlers = struct {
                        in: ep_handlers_types[idx_in] = const_ep_handlers[idx_in],
                        out: ep_handlers_types[idx_out] = const_ep_handlers[idx_out],
                    },
                    .interface2driver = interface2driver,
                    .RuntimeData = RuntimeData,
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
                const alloc = &@field(driver_alloc, driver_field_name);
                // Don't pass *void around
                if (@TypeOf(alloc) != *void)
                    runtime.init(drv, &cfg, device_itf, alloc)
                else
                    runtime.init(drv, &cfg, device_itf);

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
