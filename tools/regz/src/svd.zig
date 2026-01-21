const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const xml = @import("xml.zig");
const Arch = @import("arch.zig").Arch;

const Database = @import("Database.zig");
const Access = Database.Access;
const StructID = Database.StructID;
const DeviceID = Database.DeviceID;
const PeripheralID = Database.PeripheralID;
const RegisterID = Database.RegisterID;
const EnumID = Database.EnumID;

const log = std.log.scoped(.svd);

// svd specific context to hold extra state
const Context = struct {
    db: *Database,
    arena: ArenaAllocator,
    register_props: std.AutoArrayHashMapUnmanaged(RegisterPropertiesParent, RegisterProperties) = .{},
    derived_peripherals: std.AutoArrayHashMapUnmanaged(xml.Node, []const u8) = .{},

    fn deinit(ctx: *Context) void {
        ctx.register_props.deinit(ctx.db.gpa);
        ctx.arena.deinit();
    }

    fn derive_register_properties_from(
        ctx: *Context,
        node: xml.Node,
        from: RegisterPropertiesParent,
    ) !RegisterProperties {
        const register_props = try RegisterProperties.parse(node);
        var base_register_props = ctx.register_props.get(from) orelse unreachable;
        inline for (@typeInfo(RegisterProperties).@"struct".fields) |field| {
            if (@field(register_props, field.name)) |value|
                @field(base_register_props, field.name) = value;
        }

        return base_register_props;
    }
};

const svd_boolean = std.StaticStringMap(bool).initComptime(.{
    .{ "true", true },
    .{ "1", true },
    .{ "false", false },
    .{ "0", false },
});

pub fn parse_bool(str: []const u8) !bool {
    return svd_boolean.get(str) orelse error.InvalidSvdBoolean;
}

pub fn load_into_db(db: *Database, doc: xml.Doc) !void {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();
    const root = try doc.get_root_element();

    const name = root.get_value("name") orelse return error.MissingDeviceName;
    const description = root.get_value("description");
    const arch: Arch = blk: {
        var cpu_it = root.iterate(&.{}, &.{"cpu"});
        if (cpu_it.next()) |cpu| {
            if (cpu.get_value("name")) |cpu_name| {
                break :blk arch_from_str(cpu_name);
            }
        }

        break :blk .unknown;
    };

    const device_id = try db.create_device(.{
        .name = name,
        .description = description,
        .arch = arch,
    });

    if (root.get_value("licenseText")) |license|
        try db.add_device_property(device_id, .{ .key = "license", .value = license });

    // vendor
    // vendorID
    // series
    // version
    // headerSystemFilename
    // headerDefinitionPrefix
    // addressUnitBits
    // width
    // registerPropertiesGroup
    // peripherals
    // vendorExtensions

    var cpu_it = root.iterate(&.{}, &.{"cpu"});
    if (cpu_it.next()) |cpu| {
        const required_properties: []const []const u8 = &.{
            "name",
            "revision",
            "endian",
            "nvicPrioBits",
        };

        const optional_properties: []const []const u8 = &.{
            "vendorSystickConfig",
            "mpuPresent",
            "fpuPresent",
            "dspPresent",
            "icachePresent",
            "dcachePresent",
            "itcmPresent",
            "dtcmPresent",
            "vtorPresent",
            "deviceNumInterrupts",
            "fpuDP",
            "sauNumRegions",
            "sauRegionsConfig",
        };

        for (required_properties) |property| {
            const value = cpu.get_value(property) orelse {
                log.err("missing cpu property: {s}", .{property});
                return error.MissingRequiredProperty;
            };

            const property_name = try std.mem.join(
                arena.allocator(),
                ".",
                &.{ "cpu", property },
            );
            try db.add_device_property(device_id, .{
                .key = property_name,
                .value = value,
            });
        }

        for (optional_properties) |property| {
            if (cpu.get_value(property)) |value| {
                const property_name = try std.mem.join(arena.allocator(), ".", &.{ "cpu", property });
                try db.add_device_property(device_id, .{
                    .key = property_name,
                    .value = value,
                });
            }
        }
    }

    if (cpu_it.next() != null)
        log.warn("there are multiple CPUs", .{});

    var ctx = Context{
        .db = db,
        .arena = std.heap.ArenaAllocator.init(db.gpa),
    };
    defer ctx.deinit();

    const register_props = try RegisterProperties.parse(root);
    try ctx.register_props.put(db.gpa, .{ .device = device_id }, register_props);

    var peripheral_it = root.iterate(&.{"peripherals"}, &.{"peripheral"});
    while (peripheral_it.next()) |peripheral_node|
        load_peripheral(&ctx, peripheral_node, device_id) catch |err|
            log.warn("failed to load peripheral: {}", .{err});

    try derive_peripherals(&ctx, device_id);
}

fn derive_peripherals(ctx: *Context, device_id: DeviceID) !void {
    for (ctx.derived_peripherals.keys(), ctx.derived_peripherals.values()) |node, derived_from| {
        if (node.get_value("registers") != null)
            continue;

        const peripheral_id = try ctx.db.get_peripheral_by_name(derived_from) orelse return error.MissingPeripheral;
        const struct_id = try ctx.db.get_peripheral_struct(peripheral_id);

        // count is applied to the specific instance
        // size is applied to the type
        const count: ?u64 = blk: {
            const dim_elements = try DimElements.parse(ctx, node);
            if (dim_elements) |elements| {
                // peripherals can't have dimIndex set according to the spec
                if (elements.dim_index != null)
                    return error.Malformed;

                if (elements.dim_name != null)
                    return error.TodoDimElementsExtended;

                break :blk elements.dim;
            }

            break :blk null;
        };

        _ = try ctx.db.create_device_peripheral(device_id, .{
            .name = node.get_value("name") orelse return error.PeripheralMissingName,
            .description = node.get_value("description"),
            .struct_id = struct_id,
            .count = count,
            .offset_bytes = if (node.get_value("baseAddress")) |base_address|
                try std.fmt.parseInt(u64, base_address, 0)
            else
                return error.PeripheralMissingBaseAddress,
        });
    }
}

fn arch_from_str(str: []const u8) Arch {
    return if (std.mem.eql(u8, "CM0", str))
        .cortex_m0
    else if (std.mem.eql(u8, "CM0PLUS", str))
        .cortex_m0plus
    else if (std.mem.eql(u8, "CM0+", str))
        .cortex_m0plus
    else if (std.mem.eql(u8, "CM1", str))
        .cortex_m1
    else if (std.mem.eql(u8, "SC000", str))
        .sc000
    else if (std.mem.eql(u8, "CM23", str))
        .cortex_m23
    else if (std.mem.eql(u8, "CM3", str))
        .cortex_m3
    else if (std.mem.eql(u8, "CM33", str))
        .cortex_m33
    else if (std.mem.eql(u8, "CM35P", str))
        .cortex_m35p
    else if (std.mem.eql(u8, "CM55", str))
        .cortex_m55
    else if (std.mem.eql(u8, "SC300", str))
        .sc300
    else if (std.mem.eql(u8, "CM4", str))
        .cortex_m4
    else if (std.mem.eql(u8, "CM7", str))
        .cortex_m7
    else if (std.mem.eql(u8, "ARMV8MML", str))
        .arm_v81_mml
    else if (std.mem.eql(u8, "ARMV8MBL", str))
        .arm_v8_mbl
    else if (std.mem.eql(u8, "ARMV81MML", str))
        .arm_v8_mml
    else if (std.mem.eql(u8, "CA5", str))
        .cortex_a5
    else if (std.mem.eql(u8, "CA7", str))
        .cortex_a7
    else if (std.mem.eql(u8, "CA8", str))
        .cortex_a8
    else if (std.mem.eql(u8, "CA9", str))
        .cortex_a9
    else if (std.mem.eql(u8, "CA15", str))
        .cortex_a15
    else if (std.mem.eql(u8, "CA17", str))
        .cortex_a17
    else if (std.mem.eql(u8, "CA53", str))
        .cortex_a53
    else if (std.mem.eql(u8, "CA57", str))
        .cortex_a57
    else if (std.mem.eql(u8, "CA72", str))
        .cortex_a72
    else if (std.mem.eql(u8, "QINGKEV2", str))
        .qingke_v2
    else if (std.mem.eql(u8, "QINGKEV3", str))
        .qingke_v3
    else if (std.mem.eql(u8, "QINGKEV4", str))
        .qingke_v4
    else
        .unknown;
}

pub fn load_peripheral(ctx: *Context, node: xml.Node, device_id: DeviceID) !void {
    const db = ctx.db;

    // load interrupts regardless of the fact that the peripheral is derived
    var interrupt_it = node.iterate(&.{}, &.{"interrupt"});
    while (interrupt_it.next()) |interrupt_node|
        try load_interrupt(db, interrupt_node, device_id);

    if (node.get_attribute("derivedFrom")) |derived_from| {
        try ctx.derived_peripherals.put(ctx.arena.allocator(), node, derived_from);
        return;
    }

    // count is applied to the specific instance
    // size is applied to the type
    const count: ?u64, const size_bytes: ?u64 = blk: {
        const dim_elements = try DimElements.parse(ctx, node);
        if (dim_elements) |elements| {
            // peripherals can't have dimIndex set according to the spec
            if (elements.dim_index != null)
                return error.Malformed;

            if (elements.dim_name != null)
                return error.TodoDimElementsExtended;

            if (elements.resolve() != .array) {
                return error.InvalidPeripheralDimType;
            }

            break :blk .{ elements.dim, elements.dim_increment };
        }

        break :blk .{ null, null };
    };

    const name = try get_name_without_suffix(node, "[%s]");
    const peripheral_id = try db.create_peripheral(.{ .name = name, .description = node.get_value("description"), .size_bytes = size_bytes });
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const instance_id = try db.create_device_peripheral(device_id, .{
        .name = name,
        .description = node.get_value("description"),
        .struct_id = struct_id,
        .count = count,
        .offset_bytes = if (node.get_value("baseAddress")) |base_address|
            try std.fmt.parseInt(u64, base_address, 0)
        else
            return error.PeripheralMissingBaseAddress,
    });
    _ = instance_id;

    //if (node.get_value("version")) |version|
    //    try db.add_version(instance_id, version);

    const register_props = try ctx.derive_register_properties_from(node, .{ .device = device_id });
    try ctx.register_props.put(db.gpa, .{ .@"struct" = struct_id }, register_props);

    var register_it = node.iterate(&.{"registers"}, &.{"register"});
    while (register_it.next()) |register_node|
        load_register(ctx, register_node, struct_id) catch |err| {
            const periph_name = node.get_value("name") orelse "EMPTY";
            const reg_name = register_node.get_value("name") orelse "EMPTY";
            log.warn("failed to load register: {s}.{s}: {}", .{ periph_name, reg_name, err });
        };

    var cluster_it = node.iterate(&.{"registers"}, &.{"cluster"});
    while (cluster_it.next()) |cluster_node| {
        load_cluster(ctx, cluster_node, struct_id) catch |err|
            log.warn("failed to load cluster: {}", .{err});
    }

    // alternatePeripheral
    // groupName
    // prependToName
    // appendToName
    // headerStructName
    // disableCondition
    // addressBlock
}

fn load_interrupt(db: *Database, node: xml.Node, device_id: DeviceID) !void {
    const name = node.get_value("name") orelse return error.MissingInterruptName;
    const value_str = node.get_value("value") orelse return error.MissingInterruptIndex;
    const value = std.fmt.parseInt(i32, value_str, 0) catch |err| {
        log.warn("failed to parse value '{s}' of interrupt '{s}'", .{
            value_str,
            name,
        });
        return err;
    };

    _ = try db.create_interrupt(device_id, .{
        .name = name,
        .description = node.get_value("description"),
        .idx = value,
    });
}

fn load_cluster(
    ctx: *Context,
    node: xml.Node,
    parent: StructID,
) !void {
    // Note that dimable identifier type means that it can include a %s in the name, it's a copy of a previous identifier
    const name = node.get_value("name") orelse return error.MissingClusterName;
    const description = node.get_value("description");
    const address_offset_str = node.get_value("addressOffset") orelse return error.MissingClusterOffset;
    const alternate_cluster = node.get_value("alternateCluster");
    if (alternate_cluster != null)
        return error.TodoAlternateCluster;

    const derived_from = node.get_attribute("derivedFrom");
    if (derived_from != null)
        return error.TodoClusterDerivation;

    const struct_id = try ctx.db.create_struct(.{});
    if (try DimElements.parse(ctx, node)) |elements| switch (elements.resolve()) {
        .array => |array| try ctx.db.add_nested_struct_field(parent, .{
            .name = name[0 .. name.len - "[%s]".len],
            .struct_id = struct_id,
            .description = description,
            .offset_bytes = try std.fmt.parseInt(u32, address_offset_str, 0),
            .count = array.count,
            .size_bytes = array.increment,
        }),
        .list => |list| {
            const expanded = try list.expand(ctx.arena.allocator());
            for (expanded, 0..) |identifier, i| {
                const formatted_name = try std.mem.replaceOwned(u8, ctx.arena.allocator(), name, "%s", identifier);
                try ctx.db.add_nested_struct_field(parent, .{
                    .name = formatted_name,
                    .struct_id = struct_id,
                    .description = description,
                    .offset_bytes = i * list.increment,
                });
            }
        },
    } else {
        try ctx.db.add_nested_struct_field(parent, .{
            .name = name,
            .struct_id = struct_id,
            .description = description,
            .offset_bytes = try std.fmt.parseInt(u32, address_offset_str, 0),
        });
    }

    const register_props = try ctx.derive_register_properties_from(node, .{ .@"struct" = parent });
    try ctx.register_props.put(ctx.db.gpa, .{ .@"struct" = struct_id }, register_props);

    var register_it = node.iterate(&.{}, &.{"register"});
    while (register_it.next()) |register_node|
        try load_register(ctx, register_node, struct_id);

    var cluster_it = node.iterate(&.{}, &.{"cluster"});
    while (cluster_it.next()) |cluster_node|
        try load_cluster(ctx, cluster_node, struct_id);

    log.debug("loaded cluster name: {s} description={?s} offset={s}", .{ name, description, address_offset_str });
}

fn get_name_without_suffix(node: xml.Node, suffix: []const u8) ![]const u8 {
    return if (node.get_value("name")) |name|
        if (std.mem.endsWith(u8, name, suffix))
            name[0 .. name.len - suffix.len]
        else
            name
    else
        error.MissingName;
}

fn load_register(
    ctx: *Context,
    node: xml.Node,
    parent: StructID,
) !void {
    const dim_element = DimElements.parse(ctx, node);

    if (try dim_element) |elements| {
        try load_register_with_dim_element_group(ctx, node, parent, elements);
    } else {
        try load_single_register(ctx, node, parent);
    }

    if (node.get_attribute("derivedFrom")) |_|
        return error.TODO_DerivedRegister;
}

fn load_register_with_dim_element_group(ctx: *Context, node: xml.Node, parent: StructID, dim_elements: DimElements) !void {
    const db = ctx.db;
    const name = node.get_value("name") orelse return error.MissingRegisterName;
    const register_props = try ctx.derive_register_properties_from(node, .{ .@"struct" = parent });
    const size = register_props.size orelse return error.MissingRegisterSize;
    const address_offset_string = node.get_value("addressOffset") orelse return error.MissingRegisterOffset;
    const address_offset = try std.fmt.parseUnsigned(usize, address_offset_string, 0);

    // Array type needs only one entry in db with set count, list type should be each register as a separate entry
    const count = if (dim_elements.resolve() == .list) dim_elements.dim else 1;

    for (0..count) |i| {
        const register_id = try db.create_register(parent, .{
            .name = switch (dim_elements.resolve()) {
                .array => name[0 .. name.len - 4],
                .list => blk: {
                    const replacement = try dim_elements.dim_index_value(ctx, i);
                    const new_name = try std.mem.replaceOwned(u8, ctx.arena.allocator(), name, "%s", replacement);
                    break :blk try std.fmt.allocPrintSentinel(ctx.arena.allocator(), "{s}", .{new_name}, 0);
                },
            },
            .description = node.get_value("description"),
            .offset_bytes = switch (dim_elements.resolve()) {
                .array => address_offset,
                .list => (address_offset + (i * dim_elements.dim_increment)),
            },
            .size_bits = size,
            .count = if (dim_elements.resolve() == .array) dim_elements.dim else null,
            .access = register_props.access orelse .read_write,
            .reset_mask = register_props.reset_mask,
            .reset_value = register_props.reset_value,
        });

        var field_it = node.iterate(&.{"fields"}, &.{"field"});
        while (field_it.next()) |field_node|
            load_field(ctx, field_node, register_id, &register_props) catch |err| {
                const reg_name = node.get_value("name") orelse "EMPTY";
                const field_name = field_node.get_value("name") orelse "EMPTY";
                log.warn("failed to load field {s}.{s}: {}", .{ reg_name, field_name, err });
            };
    }
}

fn load_single_register(ctx: *Context, node: xml.Node, parent: StructID) !void {
    const db = ctx.db;
    const name = node.get_value("name") orelse return error.MissingRegisterName;
    const register_props = try ctx.derive_register_properties_from(node, .{ .@"struct" = parent });
    const size = register_props.size orelse return error.MissingRegisterSize;

    const register_id = try db.create_register(parent, .{
        .name = if (std.mem.endsWith(u8, name, "[%s]"))
            name[0 .. name.len - 4]
        else
            try std.mem.replaceOwned(u8, ctx.arena.allocator(), name, "%s", ""),
        .description = node.get_value("description"),
        .offset_bytes = if (node.get_value("addressOffset")) |offset_str|
            try std.fmt.parseUnsigned(usize, offset_str, 0)
        else
            return error.MissingRegisterOffset,
        .size_bits = size,
        .count = null,
        .access = register_props.access orelse .read_write,
        .reset_mask = register_props.reset_mask,
        .reset_value = register_props.reset_value,
    });

    var field_it = node.iterate(&.{"fields"}, &.{"field"});
    while (field_it.next()) |field_node|
        load_field(ctx, field_node, register_id, &register_props) catch |err| {
            const reg_name = node.get_value("name") orelse "EMPTY";
            const field_name = field_node.get_value("name") orelse "EMPTY";
            log.warn("failed to load field {s}.{s}: {}", .{ reg_name, field_name, err });
        };
}

fn load_field(ctx: *Context, node: xml.Node, register_id: RegisterID, props: *const RegisterProperties) !void {
    const db = ctx.db;
    const bit_range = try BitRange.parse(node);
    const dim_elements = try DimElements.parse(ctx, node);
    const count: ?u16 = if (dim_elements) |elements| count: {
        if (elements.dim_name != null)
            return error.TodoDimElementsExtended;

        break :count @intCast(elements.dim);
    } else null;

    if (node.get_attribute("derivedFrom")) |derived_from| {
        _ = derived_from;
        return error.TODO_DerivedRegisterFields;
    }

    const enum_id: ?EnumID = if (node.find_child(&.{"enumeratedValues"})) |enum_values_node|
        try load_enumerated_values(ctx, enum_values_node, @intCast(bit_range.width))
    else
        null;

    const access = if (node.get_value("access")) |access_str|
        parse_access(access_str) catch blk: {
            log.warn("Failed to parse access string '{s}', it must be one of 'read-value', 'write-only', 'read-write', 'writeOnce', or 'read-writeOnce', defaulting to 'read-write'", .{access_str});
            break :blk .read_write;
        }
    else
        props.access;

    for (0..count orelse 1) |i| {
        try db.add_register_field(register_id, .{
            .name = if (dim_elements) |elements| blk: {
                break :blk switch (elements.resolve()) {
                    // A bit-field has a name that is unique within the register, cannot use array for fields
                    .array => return error.FieldDimMalformed,
                    .list => listblk: {
                        const replacement = try elements.dim_index_value(ctx, i);
                        const new_name = try std.mem.replaceOwned(u8, ctx.arena.allocator(), node.get_value("name").?, "%s", replacement);
                        break :listblk try std.fmt.allocPrintSentinel(ctx.arena.allocator(), "{s}", .{new_name}, 0);
                    },
                };
            } else try get_name_without_suffix(node, "%s"),
            .description = node.get_value("description"),
            .size_bits = @intCast(bit_range.width),
            .offset_bits = @intCast(bit_range.offset),
            .enum_id = enum_id,
            .access = access,
        });
    }
}

fn load_enumerated_values(ctx: *Context, node: xml.Node, enum_size_bits: u8) !EnumID {
    const enum_id = try ctx.db.create_enum(null, .{
        .name = node.get_value("name"),
        .size_bits = enum_size_bits,
    });

    var value_it = node.iterate(&.{}, &.{"enumeratedValue"});
    while (value_it.next()) |value_node|
        try load_enumerated_value(ctx, value_node, enum_id);

    return enum_id;
}

fn load_enumerated_value(ctx: *Context, node: xml.Node, enum_id: EnumID) !void {
    const db = ctx.db;

    const value = v: {
        if (node.get_value("value")) |value_str| {
            if (value_str.len == 0) return error.EnumFieldMalformed;
            if (value_str[0] == '#') {
                if (value_str.len <= 1) return error.EnumFieldMalformed;
                // A preceeding '#' indicates binary format per spec
                break :v try std.fmt.parseInt(u32, value_str[1..], 2);
            } else {
                break :v try std.fmt.parseInt(u32, value_str, 0);
            }
        } else if (node.get_value("isDefault")) |is_default_str| {
            if (is_default_str.len == 0) return error.EnumFieldMalformed;
            if (try parse_bool(is_default_str)) return else return error.EnumFieldMalformed;
        } else {
            return error.EnumFieldMissingValue;
        }
    };

    try db.add_enum_field(enum_id, .{
        .name = if (node.get_value("name")) |name|
            if (std.mem.eql(u8, "_", name))
                return error.InvalidEnumFieldName
            else
                name
        else
            return error.EnumFieldMissingName,
        .description = node.get_value("description"),
        .value = value,
    });
}

pub const Revision = struct {
    release: u64,
    part: u64,

    fn parse(str: []const u8) !Revision {
        if (!std.mem.startsWith(u8, str, "r"))
            return error.Malformed;

        const p_index = std.mem.indexOf(u8, str, "p") orelse return error.Malformed;
        return Revision{
            .release = try std.fmt.parseInt(u64, str[1..p_index], 10),
            .part = try std.fmt.parseInt(u64, str[p_index + 1 ..], 10),
        };
    }
};

pub const Endian = enum {
    little,
    big,
    selectable,
    other,
};

pub const DataType = enum {
    uint8_t,
    uint16_t,
    uint32_t,
    uint64_t,
    int8_t,
    int16_t,
    int32_t,
    int64_t,
    @"uint8_t *",
    @"uint16_t *",
    @"uint32_t *",
    @"uint64_t *",
    @"int8_t *",
    @"int16_t *",
    @"int32_t *",
    @"int64_t *",
};

/// pattern: ((%s)|(%s)[_A-Za-z]{1}[_A-Za-z0-9]*)|([_A-Za-z]{1}[_A-Za-z0-9]*(\[%s\])?)|([_A-Za-z]{1}[_A-Za-z0-9]*(%s)?[_A-Za-z0-9]*)
///
/// The dimable identifier optionally has a %s to format where the id should
/// go, it may also be surrounded by []
pub const DimableIdentifier = struct {
    name: []const u8,
    pos: u32,
};

/// pattern: [0-9]+\-[0-9]+|[A-Z]-[A-Z]|[_0-9a-zA-Z]+(,\s*[_0-9a-zA-Z]+)+
pub const DimIndex = struct {};

const DimType = enum {
    array,
    list,
};

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectError = std.testing.expectError;
const expectEqualStrings = std.testing.expectEqualStrings;

test "svd.Revision.parse" {
    try expectEqual(Revision{
        .release = 1,
        .part = 2,
    }, try Revision.parse("r1p2"));

    try expectEqual(Revision{
        .release = 50,
        .part = 100,
    }, try Revision.parse("r50p100"));

    try expectError(error.Malformed, Revision.parse("p"));
    try expectError(error.Malformed, Revision.parse("r"));
    try expectError(error.InvalidCharacter, Revision.parse("rp"));
    try expectError(error.InvalidCharacter, Revision.parse("r1p"));
    try expectError(error.InvalidCharacter, Revision.parse("rp2"));
}

// dimElementGroup specifies the number of array elements (dim), the
// address offset between to consecutive array elements and an a comma
// seperated list of strings being used for identifying each element in
// the array -->
const DimElements = struct {
    dim: u64,
    /// Specify the address increment, in Bytes, between two registers.
    dim_increment: u64,

    /// dimIndexType specifies the subset and sequence of characters used for specifying the sequence of indices in register arrays -->
    /// pattern: [0-9]+\-[0-9]+|[A-Z]-[A-Z]|[_0-9a-zA-Z]+(,\s*[_0-9a-zA-Z]+)+
    /// - [0-9]+\-[0-9]+
    /// - [A-Z]-[A-Z]
    /// - [_0-9a-zA-Z]+(,\s*[_0-9a-zA-Z]+)+
    dim_index: ?[]const u8 = null,
    dim_name: ?[]const u8 = null,

    pub fn format(elements: DimElements, writer: *std.Io.Writer) !void {
        try writer.print("type={} dim={} dim_increment={} dim_index={?s} dim_name={?s}", .{
            elements.type,
            elements.dim,
            elements.dim_increment,
            elements.dim_index,
            elements.dim_name,
        });
    }

    const Array = struct {
        count: u64,
        increment: u64,
    };

    const List = struct {
        count: u64,
        increment: u64,
        pattern: []const u8,

        fn expand(list: *const List, gpa: Allocator) ![]const []const u8 {
            var ret: std.ArrayList([]const u8) = .{};
            defer ret.deinit(gpa);

            if (std.mem.indexOf(u8, list.pattern, "-")) |dash_idx| {
                const begin_str = list.pattern[0..dash_idx];
                const end_str = list.pattern[dash_idx + 1 ..];

                if (begin_str.len == 1 and std.ascii.isUpper(begin_str[0])) {
                    if (end_str.len != 1 or !std.ascii.isUpper(end_str[0]))
                        return error.InvalidRange;

                    const begin = begin_str[0];
                    const end = end_str[0];
                    if (end < begin)
                        return error.InvalidRange;

                    for (begin..end + 1) |c| {
                        const identifier = try std.fmt.allocPrint(gpa, "{c}", .{@as(u8, @intCast(c))});
                        try ret.append(gpa, identifier);
                    }
                } else {
                    const begin = try std.fmt.parseInt(u32, begin_str, 0);
                    const end = try std.fmt.parseInt(u32, end_str, 0);
                    if (end < begin)
                        return error.InvalidRange;

                    for (begin..end + 1) |n| {
                        const identifier = try std.fmt.allocPrint(gpa, "{}", .{n});
                        try ret.append(gpa, identifier);
                    }
                }
            } else {
                var it = std.mem.tokenizeAny(u8, list.pattern, ", \t\r\n");
                while (it.next()) |identifier| {
                    const copy = try gpa.dupe(u8, identifier);
                    try ret.append(gpa, copy);
                }
            }

            return ret.toOwnedSlice(gpa);
        }
    };

    const Resolved = union(enum) {
        array: Array,
        list: List,
    };

    fn resolve(elements: *const DimElements) Resolved {
        return if (elements.dim_index) |dim_index| .{
            .list = .{
                .count = elements.dim,
                .increment = elements.dim_increment,
                .pattern = dim_index,
            },
        } else .{
            .array = .{
                .count = elements.dim,
                .increment = elements.dim_increment,
            },
        };
    }

    fn parse(ctx: *Context, node: xml.Node) !?DimElements {
        const dim_increment = if (node.get_value("dimIncrement")) |dim_increment_str|
            try std.fmt.parseInt(u64, dim_increment_str, 0)
        else
            null;
        const dim = if (node.get_value("dim")) |dim_str|
            try std.fmt.parseInt(u64, dim_str, 0)
        else
            null;
        var dim_index = node.get_value("dimIndex");

        // if "dimIncrement" exists, "dim" becomes a mandatory field
        if (dim_increment != null and dim == null) {
            return error.DimElementGroupMalformed;
        } else if (dim_increment == null and dim == null) {
            // dim element group is an optional type
            return null;
        }

        const name = node.get_value("name").?; // Not a dim element!
        // By default, the index is a decimal value starting with 0 for the first register.
        // Initialize dim_index to range [0-dim] (inclusive) if the node does not exist
        const is_array_type = std.mem.endsWith(u8, name, "[%s]");
        const is_list_type = std.mem.containsAtLeast(u8, name, 1, "%s");

        if (!is_array_type and !is_list_type) {
            return error.NameFieldMalformed;
        }

        if (dim_index == null and !is_array_type and is_list_type) {
            const buf = try ctx.arena.allocator().allocSentinel(u8, 16, 0);
            @memset(buf, 0);
            // dim index range is with
            dim_index = try std.fmt.bufPrintZ(buf, "0-{d}", .{dim.? - 1});
        }

        if (node.get_value("dimArrayIndex") != null) {
            std.log.warn("TODO: dimArrayIndex", .{});
        }

        return DimElements{
            .dim = dim.?,
            .dim_increment = dim_increment.?,
            .dim_index = dim_index,
            .dim_name = node.get_value("dimName"),
        };
    }

    fn dim_index_value(self: DimElements, ctx: *Context, index: usize) ![]const u8 {
        if (std.mem.containsAtLeastScalar(u8, self.dim_index.?, 1, '-')) {
            return try self.dim_index_value_range(ctx, index);
        } else if (std.mem.containsAtLeastScalar(u8, self.dim_index.?, 1, ',')) {
            return try self.dim_index_value_csv(ctx, index);
        } else return error.DimIndexInvalid;
    }

    fn dim_index_value_range(self: DimElements, ctx: *Context, index: usize) ![]const u8 {
        var iter = std.mem.splitScalar(u8, self.dim_index.?, '-');
        const start_index = iter.next().?;
        const parse_start = std.fmt.parseInt(usize, start_index, 0);
        if (parse_start) |start| {
            return try std.fmt.allocPrintSentinel(ctx.arena.allocator(), "{d}", .{start + index}, 0);
        } else |_| {
            if (start_index.len == 1 and std.ascii.isAlphabetic(start_index[0])) {
                return std.fmt.allocPrintSentinel(ctx.arena.allocator(), "{c}", .{start_index[0] + @as(u8, @truncate(index))}, 0);
            }
            return error.DimIndexInvalid;
        }
    }

    fn dim_index_value_csv(self: DimElements, ctx: *Context, index: usize) ![]const u8 {
        var iter = std.mem.splitScalar(u8, self.dim_index.?, ',');
        var iter_value: ?[]const u8 = iter.first();
        for (0..index) |_| {
            iter_value = iter.next().?;
            if (iter_value == null)
                return error.DimIndexCsvValueMissing;
        }
        const start_index = iter_value.?;
        const parse_start = std.fmt.parseInt(usize, start_index, 0);
        if (parse_start) |start| {
            return try std.fmt.allocPrintSentinel(ctx.arena.allocator(), "{d}", .{start}, 0);
        } else |_| {
            if (start_index.len == 1 and std.ascii.isAlphabetic(start_index[0])) {
                return start_index;
            }
            return error.DimIndexInvalid;
        }
    }
};

const BitRange = struct {
    offset: u64,
    width: u64,

    fn parse(node: xml.Node) !BitRange {
        const lsb_opt = node.get_value("lsb");
        const msb_opt = node.get_value("msb");

        if (lsb_opt != null and msb_opt != null) {
            const lsb = try std.fmt.parseInt(u8, lsb_opt.?, 0);
            const msb = try std.fmt.parseInt(u8, msb_opt.?, 0);

            if (msb < lsb)
                return error.InvalidRange;

            return BitRange{
                .offset = lsb,
                .width = msb - lsb + 1,
            };
        }

        const bit_offset_opt = node.get_value("bitOffset");
        const bit_width_opt = node.get_value("bitWidth");
        if (bit_offset_opt != null and bit_width_opt != null) {
            const offset = try std.fmt.parseInt(u8, bit_offset_opt.?, 0);
            const width = try std.fmt.parseInt(u8, bit_width_opt.?, 0);

            return BitRange{
                .offset = offset,
                .width = width,
            };
        }

        const bit_range_opt = node.get_value("bitRange");
        if (bit_range_opt) |bit_range_str| {
            var it = std.mem.tokenizeAny(u8, bit_range_str, "[:]");
            const msb = try std.fmt.parseInt(u8, it.next() orelse return error.NoMsb, 0);
            const lsb = try std.fmt.parseInt(u8, it.next() orelse return error.NoLsb, 0);

            if (msb < lsb)
                return error.InvalidRange;

            return BitRange{
                .offset = lsb,
                .width = msb - lsb + 1,
            };
        }

        return error.InvalidRange;
    }
};

// can only be one of these
const Protection = enum {
    secure,
    non_secure,
    privileged,
};

pub const RegisterPropertiesParent = union(enum) {
    device: DeviceID,
    @"struct": StructID,
};

const RegisterProperties = struct {
    size: ?u64,
    access: ?Access,
    protection: ?Protection,
    reset_value: ?u64,
    reset_mask: ?u64,

    fn parse(node: xml.Node) !RegisterProperties {
        return RegisterProperties{
            .size = if (node.get_value("size")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
            .access = if (node.get_value("access")) |access_str|
                parse_access(access_str) catch blk: {
                    log.warn("Failed to parse access string '{s}', it must be one of 'read-only'," ++
                        "'write-only', 'write', 'read-write', 'writeOnce', or 'read-writeOnce', " ++
                        "defaulting to 'read-write'", .{access_str});
                    break :blk .read_write;
                }
            else
                null,
            .protection = null,
            .reset_value = if (node.get_value("resetValue")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
            .reset_mask = if (node.get_value("resetMask")) |size_str|
                try std.fmt.parseInt(u64, size_str, 0)
            else
                null,
        };
    }
};

fn parse_access(str: []const u8) !Access {
    return if (std.ascii.eqlIgnoreCase("read-only", str))
        Access.read_only
    else if (std.ascii.eqlIgnoreCase("write-only", str))
        Access.write_only
    else if (std.ascii.eqlIgnoreCase("write", str))
        Access.write_only
    else if (std.ascii.eqlIgnoreCase("read-write", str))
        Access.read_write
    else if (std.ascii.eqlIgnoreCase("writeOnce", str))
        Access.write_once
    else if (std.ascii.eqlIgnoreCase("read-writeOnce", str))
        Access.read_write_once
    else blk: {
        log.warn("invalid access type: '{s}'", .{str});
        break :blk error.UnknownAccessType;
    };
}

test "svd.device register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    try db.backup("device_register_properties.regz");

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    _ = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");
    try expectEqual(32, register.size_bits);
    try expectEqual(.read_only, register.access);
    try expectEqual(0, register.reset_value);
    try expectEqual(0xFFFFFFFF, register.reset_mask);
}

test "svd.peripheral register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <size>16</size>
        \\      <access>write-only</access>
        \\      <resetValue>0x0001</resetValue>
        \\      <resetMask>0xffff</resetMask>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    _ = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    try expectEqual(16, register.size_bits);
    try expectEqual(.write_only, register.access);
    try expectEqual(1, register.reset_value);
    try expectEqual(0xFFFF, register.reset_mask);
}

test "svd.register register properties" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <size>16</size>
        \\      <access>write-only</access>
        \\      <resetValue>0x0001</resetValue>
        \\      <resetMask>0xffff</resetMask>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <size>8</size>
        \\          <access>read-write</access>
        \\          <resetValue>0x0002</resetValue>
        \\          <resetMask>0xff</resetMask>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    _ = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    try expectEqual(8, register.size_bits);
    try expectEqual(.read_write, register.access);
    try expectEqual(2, register.reset_value);
    try expectEqual(0xFF, register.reset_mask);
}

test "svd.register with fields" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    _ = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    const field = try db.get_register_field_by_name(arena.allocator(), register.id, "TEST_FIELD");
    try expectEqual(8, field.size_bits);
    try expectEqual(0, field.offset_bits);
}

test "svd.field with enum value" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\              <enumeratedValues>
        \\                <name>TEST_ENUM</name>
        \\                <enumeratedValue>
        \\                  <name>TEST_ENUM_FIELD1</name>
        \\                  <value>0</value>
        \\                  <description>test enum field 1</description>
        \\                </enumeratedValue>
        \\                <enumeratedValue>
        \\                  <name>TEST_ENUM_FIELD2</name>
        \\                  <value>1</value>
        \\                  <description>test enum field 2</description>
        \\                </enumeratedValue>
        \\              </enumeratedValues>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    const fields = try db.get_register_fields(arena.allocator(), register.id, .{ .distinct = false });
    try expectEqual(1, fields.len);

    const field = fields[0];
    try expect(field.enum_id != null);

    // enum
    const e = try db.get_enum(arena.allocator(), field.enum_id.?);
    try expectEqual(8, e.size_bits);

    const enum_fields = try db.get_enum_fields(arena.allocator(), e.id, .{});
    try expectEqualStrings("TEST_ENUM_FIELD1", enum_fields[0].name);
    try expectEqual(0, enum_fields[0].value);
    try expectEqualStrings("test enum field 1", enum_fields[0].description.?);

    try expectEqualStrings("TEST_ENUM_FIELD2", enum_fields[1].name);
    try expectEqual(1, enum_fields[1].value);
    try expectEqualStrings("test enum field 2", enum_fields[1].description.?);
}

test "svd.peripheral with dimElementGroup" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL[%s]</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <dim>4</dim>
        \\      <dimIncrement>4</dimIncrement>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    const instance = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const peripheral = try db.get_peripheral(arena.allocator(), peripheral_id);

    try expectEqual(4, peripheral.size_bytes);
    try expectEqual(4, instance.count);
}

test "svd.peripheral with dimElementgroup, dimIndex set" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL%s</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <dim>4</dim>
        \\      <dimIncrement>4</dimIncrement>
        \\      <dimIndex>foo</dimIndex>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;

    // should not exist since dimIndex is not allowed to be defined for peripherals
    try expectError(error.MissingEntity, db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL"));
    try expectEqual(null, try db.get_peripheral_by_name("TEST_PERIPHERAL"));
}

test "svd.register with dimElementGroup, dimIncrement != size" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER[%s]</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>8</dimIncrement>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD</name>
        \\              <access>read-write</access>
        \\              <bitRange>[7:0]</bitRange>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("TEST_DEVICE") orelse return error.MissingDevice;
    _ = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "TEST_PERIPHERAL");
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");
    try expectEqual(4, register.count);
}

test "svd.register with dimElementGroup, suffixed with [%s]" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER[%s]</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    // [%s] is dropped from name, it is redundant
    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    try expectEqual(4, register.count);
}

test "svd.register with dimElementGroup, %s in name with missing dimIndex" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST%s_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_0 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST0_REGISTER");
    const register_1 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST1_REGISTER");
    const register_2 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST2_REGISTER");
    const register_3 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST3_REGISTER");

    try expectEqual(null, register_0.count);
    try expectEqual(0x00, register_0.offset_bytes);
    try expectEqual(null, register_1.count);
    try expectEqual(0x04, register_1.offset_bytes);
    try expectEqual(null, register_2.count);
    try expectEqual(0x08, register_2.offset_bytes);
    try expectEqual(null, register_3.count);
    try expectEqual(0x0C, register_3.offset_bytes);
}

test "svd.register with dimElementGroup, %s in name with default dimIndex" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST%s_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>0x8</dimIncrement>
        \\          <dimIndex>0-3</dimIndex>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_0 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST0_REGISTER");
    const register_1 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST1_REGISTER");
    const register_2 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST2_REGISTER");
    const register_3 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST3_REGISTER");

    try expectEqual(null, register_0.count);
    try expectEqual(0x00, register_0.offset_bytes);
    try expectEqual(null, register_1.count);
    try expectEqual(0x08, register_1.offset_bytes);
    try expectEqual(null, register_2.count);
    try expectEqual(0x10, register_2.offset_bytes);
    try expectEqual(null, register_3.count);
    try expectEqual(0x18, register_3.offset_bytes);
}

test "svd.register with dimElementGroup, %s in name with non-default dimIndex" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST%s_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\          <dimIndex>123-126</dimIndex>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_123 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST123_REGISTER");
    const register_124 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST124_REGISTER");
    const register_125 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST125_REGISTER");
    const register_126 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST126_REGISTER");

    try expectEqual(null, register_123.count);
    try expectEqual(null, register_124.count);
    try expectEqual(null, register_125.count);
    try expectEqual(null, register_126.count);
}

test "svd.register with dimElementGroup, dimIndex with CSV values, numbers" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST%s_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\          <dimIndex>12,34,13,37</dimIndex>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_12 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST12_REGISTER");
    const register_34 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST34_REGISTER");
    const register_13 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST13_REGISTER");
    const register_37 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST37_REGISTER");

    try expectEqual(0x0, register_12.offset_bytes);
    try expectEqual(0x4, register_34.offset_bytes);
    try expectEqual(0x8, register_13.offset_bytes);
    try expectEqual(0xC, register_37.offset_bytes);
}

test "svd.register with dimElementGroup, %s in name with alphabetical dimIndex" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST%s_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <dim>4</dim>
        \\          <dimIncrement>4</dimIncrement>
        \\          <dimIndex>D-G</dimIndex>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_d = try db.get_register_by_name(arena.allocator(), struct_id, "TESTD_REGISTER");
    const register_e = try db.get_register_by_name(arena.allocator(), struct_id, "TESTE_REGISTER");
    const register_f = try db.get_register_by_name(arena.allocator(), struct_id, "TESTF_REGISTER");
    const register_g = try db.get_register_by_name(arena.allocator(), struct_id, "TESTG_REGISTER");

    try expectEqual(null, register_d.count);
    try expectEqual(0x0, register_d.offset_bytes);
    try expectEqual(null, register_e.count);
    try expectEqual(0x4, register_e.offset_bytes);
    try expectEqual(null, register_f.count);
    try expectEqual(0x8, register_f.offset_bytes);
    try expectEqual(null, register_g.count);
    try expectEqual(0xC, register_g.offset_bytes);
}

test "svd.register with dimElementGroup, multiple registers" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER_A_CH%s</name>
        \\          <addressOffset>0x0</addressOffset>
        \\          <dim>3</dim>
        \\          <dimIncrement>0xC</dimIncrement>
        \\        </register>
        \\        <register>
        \\          <name>TEST_REGISTER_B_CH%s</name>
        \\          <addressOffset>0x4</addressOffset>
        \\          <dim>3</dim>
        \\          <dimIncrement>0xC</dimIncrement>
        \\        </register>
        \\        <register>
        \\          <name>TEST_REGISTER_C_CH%s</name>
        \\          <addressOffset>0x8</addressOffset>
        \\          <dim>3</dim>
        \\          <dimIncrement>0xC</dimIncrement>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_a_ch_0 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_A_CH0");
    const register_a_ch_1 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_A_CH1");
    const register_a_ch_2 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_A_CH2");
    const register_b_ch_0 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_B_CH0");
    const register_b_ch_1 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_B_CH1");
    const register_b_ch_2 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_B_CH2");
    const register_c_ch_0 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_C_CH0");
    const register_c_ch_1 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_C_CH1");
    const register_c_ch_2 = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER_C_CH2");

    try expectEqual(0x00, register_a_ch_0.offset_bytes);
    try expectEqual(0x04, register_b_ch_0.offset_bytes);
    try expectEqual(0x08, register_c_ch_0.offset_bytes);
    try expectEqual(0x0C, register_a_ch_1.offset_bytes);
    try expectEqual(0x10, register_b_ch_1.offset_bytes);
    try expectEqual(0x14, register_c_ch_1.offset_bytes);
    try expectEqual(0x18, register_a_ch_2.offset_bytes);
    try expectEqual(0x1C, register_b_ch_2.offset_bytes);
    try expectEqual(0x20, register_c_ch_2.offset_bytes);
}

test "svd.field with dimElementGroup, suffixed with %s" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <size>32</size>
        \\  <access>read-only</access>
        \\  <resetValue>0x00000000</resetValue>
        \\  <resetMask>0xffffffff</resetMask>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <baseAddress>0x1000</baseAddress>
        \\      <registers>
        \\        <register>
        \\          <name>TEST_REGISTER</name>
        \\          <addressOffset>0</addressOffset>
        \\          <fields>
        \\            <field>
        \\              <name>TEST_FIELD%s</name>
        \\              <access>read-write</access>
        \\              <bitRange>[1:0]</bitRange>
        \\              <dim>2</dim>
        \\              <dimIncrement>1</dimIncrement>
        \\            </field>
        \\          </fields>
        \\        </register>
        \\      </registers>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .svd, doc);
    defer db.destroy();

    const peripheral_id = try db.get_peripheral_by_name("TEST_PERIPHERAL") orelse return error.MissingPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, "TEST_REGISTER");

    const fields = try db.get_register_fields(arena.allocator(), register.id, .{ .distinct = false });

    try expectEqualStrings("TEST_FIELD0", fields[0].name);
    try expectEqual(null, fields[0].count);
    try expectEqualStrings("TEST_FIELD1", fields[1].name);
    try expectEqual(null, fields[1].count);
}

test "svd.DimElements.parse missing dimIncrement" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <dim>4</dim>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    var root = try doc.get_root_element();
    var iterator = root.iterate(&.{"peripherals"}, &.{"peripheral"});
    const peripheral_node = iterator.next() orelse unreachable;
    try expectError(error.NameFieldMalformed, DimElements.parse(&ctx, peripheral_node));
}

test "svd.DimElements.parse missing dim" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <dimIncrement>4</dimIncrement>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    var root = try doc.get_root_element();
    var iterator = root.iterate(&.{"peripherals"}, &.{"peripheral"});
    const peripheral_node = iterator.next() orelse unreachable;
    try expectError(error.DimElementGroupMalformed, DimElements.parse(&ctx, peripheral_node));
}

test "svd.DimElements.parse invalid name without %s or [%s]" {
    const text =
        \\<device>
        \\  <name>TEST_DEVICE</name>
        \\  <peripherals>
        \\    <peripheral>
        \\      <name>TEST_PERIPHERAL</name>
        \\      <dim>4</dim>
        \\      <dimIncrement>4</dimIncrement>
        \\    </peripheral>
        \\  </peripherals>
        \\</device>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    var root = try doc.get_root_element();
    var iterator = root.iterate(&.{"peripherals"}, &.{"peripheral"});
    const peripheral_node = iterator.next() orelse unreachable;
    try expectError(error.NameFieldMalformed, DimElements.parse(&ctx, peripheral_node));
}

test "svd.dimElements to array" {
    const elements: DimElements = .{
        .dim = 4,
        .dim_increment = 4,
    };

    const resolved = elements.resolve();
    try expectEqual(4, resolved.array.count);
    try expectEqual(4, resolved.array.increment);
}

test "svd.dimElements list explicit" {
    const text =
        \\<register>
        \\<dim>6</dim>
        \\<dimIncrement>4</dimIncrement>
        \\<dimIndex>A,B,C, Darst ,E,Z</dimIndex>
        \\<name>GPIO_%s_CTRL</name>
        \\</register>
    ;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    const doc = try xml.Doc.from_memory(text);
    const root = try doc.get_root_element();
    const elements = try DimElements.parse(&ctx, root) orelse return error.MissingElements;
    const expanded = try elements.resolve().list.expand(arena.allocator());

    try expectEqual(6, expanded.len);
    try expectEqualStrings("A", expanded[0]);
    try expectEqualStrings("B", expanded[1]);
    try expectEqualStrings("C", expanded[2]);
    try expectEqualStrings("Darst", expanded[3]);
    try expectEqualStrings("E", expanded[4]);
    try expectEqualStrings("Z", expanded[5]);
}

test "svd.dimElements integer list range" {
    const text =
        \\<register>
        \\    <dim>4</dim>
        \\    <dimIncrement>4</dimIncrement>
        \\    <dimIndex>3-6</dimIndex>
        \\    <name>IRQ%s</name>
        \\</register>
    ;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    const doc = try xml.Doc.from_memory(text);
    const root = try doc.get_root_element();
    const elements = try DimElements.parse(&ctx, root) orelse return error.MissingElements;
    const expanded = try elements.resolve().list.expand(arena.allocator());

    try expectEqual(4, expanded.len);
    try expectEqualStrings("3", expanded[0]);
    try expectEqualStrings("4", expanded[1]);
    try expectEqualStrings("5", expanded[2]);
    try expectEqualStrings("6", expanded[3]);
}

test "svd.dimElements letter list range" {
    const text =
        \\<register>
        \\    <dim>4</dim>
        \\    <dimIncrement>4</dimIncrement>
        \\    <dimIndex>E-H</dimIndex>
        \\    <name>IRQ%s</name>
        \\</register>
    ;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var ctx = Context{
        .db = undefined,
        .arena = arena,
    };

    const doc = try xml.Doc.from_memory(text);
    const root = try doc.get_root_element();
    const elements = try DimElements.parse(&ctx, root) orelse return error.MissingElements;
    const expanded = try elements.resolve().list.expand(arena.allocator());

    try expectEqual(4, expanded.len);
    try expectEqualStrings("E", expanded[0]);
    try expectEqualStrings("F", expanded[1]);
    try expectEqualStrings("G", expanded[2]);
    try expectEqualStrings("H", expanded[3]);
}
