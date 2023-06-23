//! Regz JSON output
const std = @import("std");
const assert = std.debug.assert;
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const json = std.json;
const ObjectMap = json.ObjectMap;
const Value = json.Value;
const Parsed = json.Parsed;
const Array = json.Array;

const Database = @import("Database.zig");
const EntityId = Database.EntityId;
const PeripheralInstance = Database.PeripheralInstance;

const testing = @import("testing.zig");
const TypeOfField = testing.TypeOfField;

const log = std.log.scoped(.regzon);

pub const schema_version = "0.1.0";

const LoadContext = struct {
    db: *Database,
    arena: std.heap.ArenaAllocator,
    enum_refs: std.AutoArrayHashMapUnmanaged(EntityId, []const u8) = .{},

    fn deinit(ctx: *LoadContext) void {
        ctx.enum_refs.deinit(ctx.db.gpa);
        ctx.arena.deinit();
    }
};

fn get_object(val: Value) !ObjectMap {
    return switch (val) {
        .object => |obj| obj,
        else => return error.NotJsonObject,
    };
}

fn get_array(val: Value) !Array {
    return switch (val) {
        .array => |arr| arr,
        else => return error.NotJsonArray,
    };
}

// TODO: handle edge cases
fn get_integer_from_object(obj: ObjectMap, comptime T: type, key: []const u8) !?T {
    return switch (obj.get(key) orelse return null) {
        .integer => |num| @intCast(T, num),
        else => return error.NotJsonInteger,
    };
}

fn get_string_from_object(obj: ObjectMap, key: []const u8) !?[]const u8 {
    return switch (obj.get(key) orelse return null) {
        .string => |str| str,
        else => return error.NotJsonString,
    };
}

fn entity_type_to_string(entity_type: Database.EntityType) []const u8 {
    return switch (entity_type) {
        .peripheral => "peripherals",
        .register_group => "register_groups",
        .register => "registers",
        .field => "fields",
        .@"enum" => "enums",
        .enum_field => "enum_fields",
        .mode => "modes",
        .device => "devices",
        .interrupt => "interrupts",
        .peripheral_instance => "peripherals",
    };
}

const string_to_entity_type_map = std.ComptimeStringMap(Database.EntityType, .{
    .{ "peripherals", .peripheral },
    .{ "register_groups", .register_group },
    .{ "registers", .register },
    .{ "fields", .field },
    .{ "enums", .@"enum" },
    .{ "enum_fields", .enum_field },
    .{ "modes", .mode },
    .{ "interrupts", .interrupt },
});

fn string_to_entity_type(str: []const u8) !Database.EntityType {
    return if (string_to_entity_type_map.get(str)) |entity_type|
        entity_type
    else
        error.InvalidEntityType;
}

// gets stuffed in the arena allocator
fn id_to_ref(
    allocator: std.mem.Allocator,
    db: Database,
    entity_id: EntityId,
) ![]const u8 {
    var ids = std.ArrayList(EntityId).init(allocator);
    defer ids.deinit();

    try ids.append(entity_id);
    var tmp_id = entity_id;
    while (db.attrs.parent.get(tmp_id)) |parent_id| : (tmp_id = parent_id) {
        try ids.insert(0, parent_id);
    }

    var ref = std.ArrayList(u8).init(allocator);
    defer ref.deinit();

    const writer = ref.writer();
    const root_type = db.get_entity_type(ids.items[0]).?;

    if (root_type.is_instance())
        //try writer.writeAll("instances")
        @panic("TODO")
    else
        try writer.writeAll("types");

    try writer.print(".{s}.{s}", .{
        entity_type_to_string(root_type),
        std.zig.fmtId(db.attrs.name.get(ids.items[0]) orelse return error.MissingName),
    });

    for (ids.items[1..]) |id| {
        const entity_type = db.get_entity_type(id).?;
        try writer.print(".children.{s}.{s}", .{
            entity_type_to_string(entity_type),
            std.zig.fmtId(db.attrs.name.get(id) orelse return error.MissingName),
        });
    }

    return ref.toOwnedSlice();
}

pub fn load_into_db(db: *Database, text: []const u8) !void {
    var root = try json.parseFromSlice(Value, db.gpa, text, .{});
    defer root.deinit();

    var ctx = LoadContext{
        .db = db,
        .arena = std.heap.ArenaAllocator.init(db.gpa),
    };
    defer ctx.deinit();

    if (root.value.object.get("types")) |types|
        try load_types(&ctx, try get_object(types));

    if (root.value.object.get("devices")) |devices|
        try load_devices(&ctx, try get_object(devices));

    try resolve_enums(&ctx);
}

fn resolve_enums(ctx: *LoadContext) !void {
    const db = ctx.db;
    for (ctx.enum_refs.keys(), ctx.enum_refs.values()) |id, ref| {
        const enum_id = try ref_to_id(db.*, ref);
        //assert(db.entityIs("type.enum", enum_id));
        try ctx.db.attrs.@"enum".put(db.gpa, id, enum_id);
    }
}

fn ref_to_id(db: Database, ref: []const u8) !EntityId {
    // TODO: do proper tokenization since we'll need to handle @"" fields. okay to leave for now.
    var it = std.mem.tokenize(u8, ref, ".");
    const first = it.next() orelse return error.Malformed;
    return if (std.mem.eql(u8, "types", first)) blk: {
        var tmp_id: ?EntityId = null;
        break :blk while (true) {
            const entity_type = entity_type: {
                const str = it.next() orelse return error.Malformed;
                break :entity_type try string_to_entity_type(str);
            };

            const name = it.next() orelse return error.Malformed;
            const last = if (it.next()) |token|
                if (std.mem.eql(u8, "children", token))
                    false
                else
                    return error.Malformed
            else
                true;

            if (tmp_id == null) {
                tmp_id = tmp_id: inline for (@typeInfo(TypeOfField(Database, "types")).Struct.fields) |field| {
                    const other_type = try string_to_entity_type(field.name);
                    if (entity_type == other_type) {
                        for (@field(db.types, field.name).keys()) |id| {
                            if (db.attrs.parent.contains(id))
                                continue;

                            if (db.attrs.name.get(id)) |other_name| {
                                if (std.mem.eql(u8, name, other_name))
                                    break :tmp_id id;
                            }
                        }
                    }
                } else return error.RefNotFound;
            } else {
                tmp_id = tmp_id: inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
                    const other_type = try string_to_entity_type(field.name);
                    if (entity_type == other_type) {
                        if (@field(db.children, field.name).get(tmp_id.?)) |children| {
                            for (children.keys()) |child_id| {
                                if (db.attrs.name.get(child_id)) |other_name| {
                                    if (std.mem.eql(u8, name, other_name))
                                        break :tmp_id child_id;
                                }
                            }
                        }
                    }
                } else return error.RefNotFound;
            }

            if (last)
                break tmp_id.?;
        } else error.RefNotFound;
    } else if (std.mem.eql(u8, "instances", first))
        @panic("TODO")
    else
        error.Malformed;
}

fn load_types(ctx: *LoadContext, types: ObjectMap) !void {
    if (types.get("peripherals")) |peripherals|
        try load_peripherals(ctx, try get_object(peripherals));
}

fn load_peripherals(ctx: *LoadContext, peripherals: ObjectMap) !void {
    for (peripherals.keys(), peripherals.values()) |name, peripheral|
        try load_peripheral(ctx, name, try get_object(peripheral));
}

fn load_peripheral(
    ctx: *LoadContext,
    name: []const u8,
    peripheral: ObjectMap,
) !void {
    log.debug("loading peripheral: {s}", .{name});
    const db = ctx.db;
    const id = try db.create_peripheral(.{
        .name = name,
        .description = try get_string_from_object(peripheral, "description"),
        .size = if (peripheral.get("size")) |size_val|
            switch (size_val) {
                .integer => |num| @intCast(u64, num),
                else => return error.SizeNotInteger,
            }
        else
            null,
    });
    errdefer db.destroy_entity(id);

    if (peripheral.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

const LoadError = error{
    RefNotFound,
    InvalidChildType,
    NoPeripheralFound,
    MissingEnumFieldValue,
    MissingEnumSize,
    MissingRegisterOffset,
    MissingRegisterSize,
    InvalidJsonType,
    NotJsonInteger,
    NotJsonObject,
    NotJsonString,
    NotJsonArray,
    OutOfMemory,
    MissingModeValue,
    MissingModeQualifier,
    Malformed,
    InvalidEntityType,
    MissingInterruptIndex,
    MissingInstanceType,
    MissingInstanceOffset,
};

const LoadFn = fn (*LoadContext, EntityId, []const u8, ObjectMap) LoadError!void;
const LoadMultipleFn = fn (*LoadContext, EntityId, ObjectMap) LoadError!void;
fn load_entities(comptime load_fn: LoadFn) LoadMultipleFn {
    return struct {
        fn tmp(
            ctx: *LoadContext,
            parent_id: EntityId,
            entities: ObjectMap,
        ) LoadError!void {
            for (entities.keys(), entities.values()) |name, entity|
                try load_fn(ctx, parent_id, name, try get_object(entity));
        }
    }.tmp;
}

const load_fns = struct {
    // types
    const register_groups = load_entities(load_register_group);
    const registers = load_entities(load_register);
    const fields = load_entities(load_field);
    const enums = load_entities(load_enum);
    const enum_fields = load_entities(load_enum_field);
    const modes = load_entities(load_mode);

    // instances
    const interrupts = load_entities(load_interrupt);
    const peripheral_instances = load_entities(load_peripheral_instance);
};

fn load_children(
    ctx: *LoadContext,
    parent_id: EntityId,
    children: ObjectMap,
) LoadError!void {
    for (children.keys(), children.values()) |child_type, child_map| {
        inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
            if (std.mem.eql(u8, child_type, field.name)) {
                if (@hasDecl(load_fns, field.name))
                    try @field(load_fns, field.name)(ctx, parent_id, try get_object(child_map));

                break;
            }
        } else if (std.mem.eql(u8, "peripheral_instances", child_type)) {
            try load_fns.peripheral_instances(ctx, parent_id, try get_object(child_map));
        } else {
            log.err("{s} is not a valid child type", .{child_type});
            return error.InvalidChildType;
        }
    }
}

fn load_mode(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    mode: ObjectMap,
) LoadError!void {
    _ = try ctx.db.create_mode(parent_id, .{
        .name = name,
        .description = try get_string_from_object(mode, "description"),
        .value = (try get_string_from_object(mode, "value")) orelse return error.MissingModeValue,
        .qualifier = (try get_string_from_object(mode, "qualifier")) orelse return error.MissingModeQualifier,
    });
}

fn load_register_group(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    register_group: ObjectMap,
) LoadError!void {
    log.debug("load register group", .{});
    const db = ctx.db;
    // TODO: probably more
    const id = try db.create_register_group(parent_id, .{
        .name = name,
        .description = try get_string_from_object(register_group, "description"),
    });
    errdefer db.destroy_entity(id);

    if (register_group.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

fn load_register(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    register: ObjectMap,
) LoadError!void {
    const db = ctx.db;
    const id = try db.create_register(parent_id, .{
        .name = name,
        .description = try get_string_from_object(register, "description"),
        .offset = (try get_integer_from_object(register, u64, "offset")) orelse return error.MissingRegisterOffset,
        .size = (try get_integer_from_object(register, u64, "size")) orelse return error.MissingRegisterSize,
        .count = try get_integer_from_object(register, u64, "count"),
        .access = if (try get_string_from_object(register, "access")) |access_str|
            std.meta.stringToEnum(Database.Access, access_str)
        else
            null,
        .reset_mask = try get_integer_from_object(register, u64, "reset_mask"),
        .reset_value = try get_integer_from_object(register, u64, "reset_value"),
    });
    errdefer db.destroy_entity(id);

    if (register.get("modes")) |modes|
        try load_modes(ctx, id, try get_array(modes));

    if (register.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

fn load_modes(
    ctx: *LoadContext,
    parent_id: EntityId,
    modes: Array,
) !void {
    const db = ctx.db;
    for (modes.items) |mode_val| {
        const mode_ref = switch (mode_val) {
            .string => |str| str,
            else => return error.InvalidJsonType,
        };

        const mode_id = try ref_to_id(db.*, mode_ref);
        //assert(db.entityIs("type.mode", mode_id));
        const result = try db.attrs.modes.getOrPut(db.gpa, parent_id);
        if (!result.found_existing)
            result.value_ptr.* = .{};

        try result.value_ptr.put(db.gpa, mode_id, {});
    }
}

fn load_field(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    field: ObjectMap,
) LoadError!void {
    const db = ctx.db;
    const id = try db.create_field(parent_id, .{
        .name = name,
        .description = try get_string_from_object(field, "description"),
        .offset = (try get_integer_from_object(field, u64, "offset")) orelse return error.MissingRegisterOffset,
        .size = (try get_integer_from_object(field, u64, "size")) orelse return error.MissingRegisterSize,
        .count = try get_integer_from_object(field, u64, "count"),
    });
    errdefer db.destroy_entity(id);

    if (field.get("enum")) |enum_val|
        switch (enum_val) {
            .string => |ref_str| try ctx.enum_refs.put(db.gpa, id, ref_str),
            .object => |enum_obj| {
                // peripheral is the parent of enums
                // TODO: change this
                const peripheral_id = peripheral_id: {
                    var tmp_id = id;
                    break :peripheral_id while (db.attrs.parent.get(tmp_id)) |next_id| : (tmp_id = next_id) {
                        if (.peripheral == db.get_entity_type(next_id).?)
                            break next_id;
                    } else return error.NoPeripheralFound;
                };

                const enum_id = try load_enum_base(ctx, peripheral_id, null, enum_obj);
                try db.attrs.@"enum".put(db.gpa, id, enum_id);
            },
            else => return error.InvalidJsonType,
        };

    if (field.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

fn load_enum(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    enumeration: ObjectMap,
) LoadError!void {
    _ = try load_enum_base(ctx, parent_id, name, enumeration);
}

fn load_enum_base(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: ?[]const u8,
    enumeration: ObjectMap,
) LoadError!EntityId {
    const db = ctx.db;
    const id = try db.create_enum(parent_id, .{
        .name = name,
        .description = try get_string_from_object(enumeration, "description"),
        .size = (try get_integer_from_object(enumeration, u64, "size")) orelse return error.MissingEnumSize,
    });
    errdefer db.destroy_entity(id);

    if (enumeration.get("children")) |children|
        try load_children(ctx, id, try get_object(children));

    return id;
}

fn load_enum_field(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    enum_field: ObjectMap,
) LoadError!void {
    const db = ctx.db;

    const id = try db.create_enum_field(parent_id, .{
        .name = name,
        .description = try get_string_from_object(enum_field, "description"),
        .value = (try get_integer_from_object(enum_field, u32, "value")) orelse return error.MissingEnumFieldValue,
    });

    if (enum_field.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

fn load_devices(ctx: *LoadContext, devices: ObjectMap) !void {
    for (devices.keys(), devices.values()) |name, device|
        try load_device(ctx, name, try get_object(device));
}

fn load_device(ctx: *LoadContext, name: []const u8, device: ObjectMap) !void {
    log.debug("loading device: {s}", .{name});
    const db = ctx.db;
    const id = try db.create_device(.{
        .name = name,
        .description = try get_string_from_object(device, "description"),
        .arch = if (device.get("arch")) |arch_val|
            switch (arch_val) {
                .string => |arch_str| std.meta.stringToEnum(Database.Arch, arch_str) orelse return error.InvalidArch,
                else => return error.InvalidJsonType,
            }
        else
            .unknown,
    });
    errdefer db.destroy_entity(id);

    if (device.get("properties")) |properties|
        try load_properties(ctx, id, try get_object(properties));

    if (device.get("children")) |children|
        try load_children(ctx, id, try get_object(children));
}

fn load_properties(ctx: *LoadContext, device_id: EntityId, properties: ObjectMap) !void {
    const db = ctx.db;
    for (properties.keys(), properties.values()) |key, json_value| {
        const value = switch (json_value) {
            .string => |str| str,
            else => return error.InvalidJsonType,
        };

        try db.add_device_property(device_id, key, value);
    }
}

fn load_interrupt(
    ctx: *LoadContext,
    device_id: EntityId,
    name: []const u8,
    interrupt: ObjectMap,
) LoadError!void {
    _ = try ctx.db.create_interrupt(device_id, .{
        .name = name,
        .description = try get_string_from_object(interrupt, "description"),
        .index = (try get_integer_from_object(interrupt, i32, "index")) orelse return error.MissingInterruptIndex,
    });
}

fn load_peripheral_instance(
    ctx: *LoadContext,
    device_id: EntityId,
    name: []const u8,
    peripheral: ObjectMap,
) !void {
    const db = ctx.db;
    const type_ref = (try get_string_from_object(peripheral, "type")) orelse return error.MissingInstanceType;
    const type_id = try ref_to_id(db.*, type_ref);
    _ = try ctx.db.create_peripheral_instance(device_id, type_id, .{
        .name = name,
        .description = try get_string_from_object(peripheral, "description"),
        .offset = (try get_integer_from_object(peripheral, u64, "offset")) orelse return error.MissingInstanceOffset,
        .count = try get_integer_from_object(peripheral, u64, "count"),
    });
}

pub fn to_json(db: Database) !Parsed(Value) {
    const arena = try db.gpa.create(ArenaAllocator);
    errdefer db.gpa.destroy(arena);

    arena.* = ArenaAllocator.init(db.gpa);
    errdefer arena.deinit();

    const allocator = arena.allocator();
    var root = ObjectMap.init(allocator);
    var types = ObjectMap.init(allocator);
    var devices = ObjectMap.init(allocator);

    for (db.instances.devices.keys()) |device_id|
        try populate_device(db, arena, &devices, device_id);

    try root.put("version", .{ .string = schema_version });
    try populate_types(db, arena, &types);
    if (types.count() > 0)
        try root.put("types", .{ .object = types });

    if (devices.count() > 0)
        try root.put("devices", .{ .object = devices });

    return Parsed(Value){
        .arena = arena,
        .value = .{ .object = root },
    };
}

fn populate_types(
    db: Database,
    arena: *ArenaAllocator,
    types: *ObjectMap,
) !void {
    const allocator = arena.allocator();
    var peripherals = ObjectMap.init(allocator);

    for (db.types.peripherals.keys()) |peripheral_id| {
        const name = db.attrs.name.get(peripheral_id) orelse continue;
        var typ = ObjectMap.init(allocator);
        try populate_type(db, arena, peripheral_id, &typ);
        try peripherals.put(name, .{ .object = typ });
    }

    if (peripherals.count() > 0)
        try types.put("peripherals", .{ .object = peripherals });
}

fn populate_type(
    db: Database,
    arena: *ArenaAllocator,
    id: EntityId,
    typ: *ObjectMap,
) !void {
    const allocator = arena.allocator();
    if (db.attrs.description.get(id)) |description|
        try typ.put("description", .{ .string = description });

    if (db.attrs.offset.get(id)) |offset|
        try typ.put("offset", .{ .integer = @intCast(i64, offset) });

    if (db.attrs.size.get(id)) |size|
        try typ.put("size", .{ .integer = @intCast(i64, size) });

    if (db.attrs.count.get(id)) |count|
        try typ.put("count", .{ .integer = @intCast(i64, count) });

    if (db.attrs.reset_value.get(id)) |reset_value|
        try typ.put("reset_value", .{ .integer = @intCast(i64, reset_value) });

    if (db.attrs.reset_mask.get(id)) |reset_mask|
        try typ.put("reset_mask", .{ .integer = @intCast(i64, reset_mask) });

    if (db.attrs.version.get(id)) |version|
        try typ.put("version", .{ .string = version });

    if (db.attrs.access.get(id)) |access| if (access != .read_write)
        try typ.put("access", .{
            .string = switch (access) {
                .read_only => "read-only",
                .write_only => "write-only",
                else => unreachable,
            },
        });

    if (db.attrs.@"enum".get(id)) |enum_id| {
        if (db.attrs.name.contains(enum_id)) {
            const ref = try id_to_ref(arena.allocator(), db, enum_id);
            try typ.put("enum", .{ .string = ref });
        } else {
            var anon_enum = ObjectMap.init(allocator);
            try populate_type(db, arena, enum_id, &anon_enum);
            try typ.put("enum", .{ .object = anon_enum });
        }
    }

    if (db.attrs.modes.get(id)) |modeset| {
        var modearray = Array.init(allocator);

        for (modeset.keys()) |mode_id| {
            if (db.attrs.name.contains(mode_id)) {
                const ref = try id_to_ref(
                    arena.allocator(),
                    db,
                    mode_id,
                );
                try modearray.append(.{ .string = ref });
            } else return error.MissingModeName;
        }

        if (modearray.items.len > 0)
            try typ.put("modes", .{ .array = modearray });
    }

    if (db.types.enum_fields.get(id)) |enum_field| {
        try typ.put("value", .{ .integer = enum_field });
    } else if (db.types.modes.get(id)) |mode| {
        try typ.put("value", .{ .string = mode.value });
        try typ.put("qualifier", .{ .string = mode.qualifier });
    }

    var children = ObjectMap.init(allocator);
    inline for (@typeInfo(@TypeOf(db.children)).Struct.fields) |field| {
        var obj = ObjectMap.init(allocator);

        if (@field(db.children, field.name).get(id)) |set| {
            assert(set.count() > 0);
            for (set.keys()) |child_id| {
                const name = db.attrs.name.get(child_id) orelse continue;
                var child_type = ObjectMap.init(allocator);
                try populate_type(db, arena, child_id, &child_type);
                try obj.put(name, .{ .object = child_type });
            }
        }

        if (obj.count() > 0)
            try children.put(field.name, .{ .object = obj });
    }

    if (children.count() > 0)
        try typ.put("children", .{ .object = children });
}

fn populate_device(
    db: Database,
    arena: *ArenaAllocator,
    devices: *ObjectMap,
    id: EntityId,
) !void {
    const allocator = arena.allocator();
    const name = db.attrs.name.get(id) orelse return error.MissingDeviceName;

    var device = ObjectMap.init(allocator);
    var properties = ObjectMap.init(allocator);
    var prop_it = db.instances.devices.get(id).?.properties.iterator();
    while (prop_it.next()) |entry|
        try properties.put(entry.key_ptr.*, .{ .string = entry.value_ptr.* });

    var interrupts = ObjectMap.init(allocator);
    populate_interrupts: {
        var interrupt_it = (db.children.interrupts.get(id) orelse
            break :populate_interrupts).iterator();
        while (interrupt_it.next()) |entry|
            try populate_interrupt(db, arena, &interrupts, entry.key_ptr.*);
    }

    // TODO: link peripherals to device
    var peripherals = ObjectMap.init(allocator);
    for (db.instances.peripherals.keys(), db.instances.peripherals.values()) |instance_id, type_id|
        try populate_peripheral(db, arena, &peripherals, instance_id, type_id);

    const arch = db.instances.devices.get(id).?.arch;
    try device.put("arch", .{ .string = arch.to_string() });
    if (db.attrs.description.get(id)) |description|
        try device.put("description", .{ .string = description });

    if (properties.count() > 0)
        try device.put("properties", .{ .object = properties });

    var device_children = ObjectMap.init(allocator);
    if (interrupts.count() > 0)
        try device_children.put("interrupts", .{ .object = interrupts });

    if (peripherals.count() > 0)
        try device_children.put("peripheral_instances", .{ .object = peripherals });

    if (device_children.count() > 0)
        try device.put("children", .{ .object = device_children });

    try devices.put(name, .{ .object = device });
}

fn populate_interrupt(
    db: Database,
    arena: *ArenaAllocator,
    interrupts: *ObjectMap,
    id: EntityId,
) !void {
    const allocator = arena.allocator();
    var interrupt = ObjectMap.init(allocator);

    const name = db.attrs.name.get(id) orelse return error.MissingInterruptName;
    const index = db.instances.interrupts.get(id) orelse return error.MissingInterruptIndex;
    try interrupt.put("index", .{ .integer = index });
    if (db.attrs.description.get(id)) |description|
        try interrupt.put("description", .{ .string = description });

    try interrupts.put(name, .{ .object = interrupt });
}

fn populate_peripheral(
    db: Database,
    arena: *ArenaAllocator,
    peripherals: *ObjectMap,
    id: EntityId,
    type_id: EntityId,
) !void {
    const allocator = arena.allocator();
    const name = db.attrs.name.get(id) orelse return error.MissingPeripheralName;
    var peripheral = ObjectMap.init(allocator);
    if (db.attrs.description.get(id)) |description|
        try peripheral.put("description", .{ .string = description });

    if (db.attrs.offset.get(id)) |offset|
        try peripheral.put("offset", .{ .integer = @intCast(i64, offset) });

    if (db.attrs.version.get(id)) |version|
        try peripheral.put("version", .{ .string = version });

    if (db.attrs.count.get(id)) |count|
        try peripheral.put("count", .{ .integer = @intCast(i64, count) });

    // TODO: handle collisions -- will need to inline the type
    const type_ref = try id_to_ref(
        arena.allocator(),
        db,
        type_id,
    );
    try peripheral.put("type", .{ .string = type_ref });

    // TODO: peripheral instance children

    try peripherals.put(name, .{ .object = peripheral });
}

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;
const DbInitFn = fn (allocator: std.mem.Allocator) anyerror!Database;
const tests = @import("output_tests.zig");

test "refToId" {
    var db = try tests.peripheral_with_modes(std.testing.allocator);
    defer db.deinit();

    const mode_id = try db.get_entity_id_by_name("type.mode", "TEST_MODE1");
    const mode_ref = try id_to_ref(std.testing.allocator, db, mode_id);
    defer std.testing.allocator.free(mode_ref);

    try expectEqualStrings(
        "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE1",
        mode_ref,
    );
}

test "idToRef" {
    var db = try tests.peripheral_with_modes(std.testing.allocator);
    defer db.deinit();

    const expected_mode_id = try db.get_entity_id_by_name("type.mode", "TEST_MODE1");
    const actual_mode_id = try ref_to_id(
        db,
        "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE1",
    );

    try expectEqual(expected_mode_id, actual_mode_id);
}

// =============================================================================
// loadIntoDb Tests
// =============================================================================
fn load_test(comptime init: DbInitFn, input: []const u8) !void {
    var expected = try init(std.testing.allocator);
    defer expected.deinit();

    const copy = try std.testing.allocator.dupe(u8, input);
    var actual = Database.init_from_json(std.testing.allocator, copy) catch |err| {
        std.testing.allocator.free(copy);
        return err;
    };
    defer actual.deinit();

    // freeing explicitly here to invalidate the memory for input
    std.testing.allocator.free(copy);
    try testing.expect_equal_databases(expected, actual);
}

test "regzon.load.empty" {
    try load_test(empty_db, json_data.empty);
}

test "regzon.load.peripheral type with register and field" {
    try load_test(
        tests.peripheral_type_with_register_and_field,
        json_data.peripheral_type_with_register_and_field,
    );
}

test "regzon.load.peripheral instantiation" {
    try load_test(
        tests.peripheral_instantiation,
        json_data.peripheral_instantiation,
    );
}

test "regzon.load.peripherals with a shared type" {
    try load_test(
        tests.peripherals_with_shared_type,
        json_data.peripherals_with_shared_type,
    );
}

test "regzon.load.peripheral with modes" {
    try load_test(
        tests.peripheral_with_modes,
        json_data.peripherals_with_modes,
    );
}

test "regzon.load.field with named enum" {
    try load_test(
        tests.field_with_named_enum,
        json_data.field_with_named_enum,
    );
}

test "regzon.load.field with anonymous enum" {
    try load_test(
        tests.field_with_anonymous_enum,
        json_data.field_with_anonymous_enum,
    );
}

test "regzon.load.namespaced register groups" {
    try load_test(
        tests.namespaced_register_groups,
        json_data.namespaced_register_groups,
    );
}

test "regzon.load.peripheral with count" {
    try load_test(
        tests.peripheral_with_count,
        json_data.peripheral_with_count,
    );
}

test "regzon.load.register with count" {
    try load_test(
        tests.register_with_count,
        json_data.register_with_count,
    );
}

test "regzon.load.register with count and fields" {
    try load_test(
        tests.register_with_count_and_fields,
        json_data.register_with_count_and_fields,
    );
}

test "regzon.load.field with count, width of one, offset, and padding" {
    try load_test(
        tests.field_with_count_width_of_one_offset_and_padding,
        json_data.field_with_count_width_of_one_offset_and_padding,
    );
}

test "regzon.load.field_with_count_multibit_width_offset_and_padding" {
    try load_test(
        tests.field_with_count_multi_bit_width_offset_and_padding,
        json_data.field_with_count_multibit_width_offset_and_padding,
    );
}

test "regzon.load.interruptsAvr" {
    try load_test(
        tests.interrupts_avr,
        json_data.interrupts_avr,
    );
}

// =============================================================================
// jsonStringify Tests
// =============================================================================
fn stringify_test(comptime init: DbInitFn, expected: []const u8) !void {
    var db = try init(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    const test_stringify_opts = .{
        .whitespace = .{
            .indent_level = 0,
            .indent = .{ .space = 2 },
        },
    };

    try db.json_stringify(test_stringify_opts, buffer.writer());
    try expectEqualStrings(expected, buffer.items);
}

fn empty_db(allocator: Allocator) !Database {
    return Database.init(allocator);
}

test "regzon.jsonStringify.empty" {
    try stringify_test(empty_db, json_data.empty);
}

test "regzon.jsonStringify.peripheral type with register and field" {
    try stringify_test(
        tests.peripheral_type_with_register_and_field,
        json_data.peripheral_type_with_register_and_field,
    );
}

test "regzon.jsonStringify.peripheral instantiation" {
    try stringify_test(
        tests.peripheral_instantiation,
        json_data.peripheral_instantiation,
    );
}

test "regzon.jsonStringify.peripherals with a shared type" {
    try stringify_test(
        tests.peripherals_with_shared_type,
        json_data.peripherals_with_shared_type,
    );
}

test "regzon.jsonStringify.peripheral with modes" {
    try stringify_test(
        tests.peripheral_with_modes,
        json_data.peripherals_with_modes,
    );
}

test "regzon.jsonStringify.field with named enum" {
    try stringify_test(
        tests.field_with_named_enum,
        json_data.field_with_named_enum,
    );
}

test "regzon.jsonStringify.field with anonymous enum" {
    try stringify_test(
        tests.field_with_anonymous_enum,
        json_data.field_with_anonymous_enum,
    );
}

test "regzon.jsonStringify.namespaced register groups" {
    try stringify_test(
        tests.namespaced_register_groups,
        json_data.namespaced_register_groups,
    );
}

test "regzon.jsonStringify.peripheral with count" {
    try stringify_test(
        tests.peripheral_with_count,
        json_data.peripheral_with_count,
    );
}

test "regzon.jsonStringify.register with count" {
    try stringify_test(
        tests.register_with_count,
        json_data.register_with_count,
    );
}

test "regzon.jsonStringify.register with count and fields" {
    try stringify_test(
        tests.register_with_count_and_fields,
        json_data.register_with_count_and_fields,
    );
}

test "regzon.jsonStringify.field with count, width of one, offset, and padding" {
    try stringify_test(
        tests.field_with_count_width_of_one_offset_and_padding,
        json_data.field_with_count_width_of_one_offset_and_padding,
    );
}

test "regzon.jsonStringify.field_with_count_multibit_width_offset_and_padding" {
    try stringify_test(
        tests.field_with_count_multi_bit_width_offset_and_padding,
        json_data.field_with_count_multibit_width_offset_and_padding,
    );
}

test "regzon.jsonStringify.interruptsAvr" {
    try stringify_test(
        tests.interrupts_avr,
        json_data.interrupts_avr,
    );
}

// =============================================================================
// Test data
// =============================================================================

fn versionize(comptime version: []const u8, comptime json_str: []const u8) []const u8 {
    const template = "<version>";
    const index = std.mem.indexOf(u8, json_str, template) orelse unreachable; // gotta specify version

    return json_str[0..index] ++ version ++ json_str[index + template.len ..];
}

const json_data = struct {
    const empty = versionize(schema_version,
        \\{
        \\  "version": "<version>"
        \\}
    );

    const peripheral_type_with_register_and_field = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "registers": {
        \\            "TEST_REGISTER": {
        \\              "offset": 0,
        \\              "size": 32,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 1
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const peripheral_instantiation = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "registers": {
        \\            "TEST_REGISTER": {
        \\              "offset": 0,
        \\              "size": 32,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 1
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "TEST_DEVICE": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "TEST0": {
        \\            "offset": 4096,
        \\            "type": "types.peripherals.TEST_PERIPHERAL"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const peripherals_with_shared_type = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "registers": {
        \\            "TEST_REGISTER": {
        \\              "offset": 0,
        \\              "size": 32,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 1
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "TEST_DEVICE": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "TEST0": {
        \\            "offset": 4096,
        \\            "type": "types.peripherals.TEST_PERIPHERAL"
        \\          },
        \\          "TEST1": {
        \\            "offset": 8192,
        \\            "type": "types.peripherals.TEST_PERIPHERAL"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const peripherals_with_modes = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "modes": {
        \\            "TEST_MODE1": {
        \\              "value": "0x00",
        \\              "qualifier": "TEST_PERIPHERAL.TEST_MODE1.COMMON_REGISTER.TEST_FIELD"
        \\            },
        \\            "TEST_MODE2": {
        \\              "value": "0x01",
        \\              "qualifier": "TEST_PERIPHERAL.TEST_MODE2.COMMON_REGISTER.TEST_FIELD"
        \\            }
        \\          },
        \\          "registers": {
        \\            "TEST_REGISTER1": {
        \\              "offset": 0,
        \\              "size": 32,
        \\              "modes": [
        \\                "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE1"
        \\              ]
        \\            },
        \\            "TEST_REGISTER2": {
        \\              "offset": 0,
        \\              "size": 32,
        \\              "modes": [
        \\                "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE2"
        \\              ]
        \\            },
        \\            "COMMON_REGISTER": {
        \\              "offset": 4,
        \\              "size": 32,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 1
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const field_with_named_enum = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "registers": {
        \\            "TEST_REGISTER": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 4,
        \\                    "enum": "types.peripherals.TEST_PERIPHERAL.children.enums.TEST_ENUM"
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          },
        \\          "enums": {
        \\            "TEST_ENUM": {
        \\              "size": 4,
        \\              "children": {
        \\                "enum_fields": {
        \\                  "TEST_ENUM_FIELD1": {
        \\                    "value": 0
        \\                  },
        \\                  "TEST_ENUM_FIELD2": {
        \\                    "value": 1
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const field_with_anonymous_enum = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "TEST_PERIPHERAL": {
        \\        "children": {
        \\          "registers": {
        \\            "TEST_REGISTER": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 4,
        \\                    "enum": {
        \\                      "size": 4,
        \\                      "children": {
        \\                        "enum_fields": {
        \\                          "TEST_ENUM_FIELD1": {
        \\                            "value": 0
        \\                          },
        \\                          "TEST_ENUM_FIELD2": {
        \\                            "value": 1
        \\                          }
        \\                        }
        \\                      }
        \\                    }
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const namespaced_register_groups = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORT": {
        \\        "children": {
        \\          "register_groups": {
        \\            "PORTB": {
        \\              "children": {
        \\                "registers": {
        \\                  "PORTB": {
        \\                    "offset": 0,
        \\                    "size": 8
        \\                  },
        \\                  "DDRB": {
        \\                    "offset": 1,
        \\                    "size": 8
        \\                  },
        \\                  "PINB": {
        \\                    "offset": 2,
        \\                    "size": 8
        \\                  }
        \\                }
        \\              }
        \\            },
        \\            "PORTC": {
        \\              "children": {
        \\                "registers": {
        \\                  "PORTC": {
        \\                    "offset": 0,
        \\                    "size": 8
        \\                  },
        \\                  "DDRC": {
        \\                    "offset": 1,
        \\                    "size": 8
        \\                  },
        \\                  "PINC": {
        \\                    "offset": 2,
        \\                    "size": 8
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "ATmega328P": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "PORTB": {
        \\            "offset": 35,
        \\            "type": "types.peripherals.PORT.children.register_groups.PORTB"
        \\          },
        \\          "PORTC": {
        \\            "offset": 38,
        \\            "type": "types.peripherals.PORT.children.register_groups.PORTC"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const peripheral_with_count = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORTB": {
        \\        "size": 3,
        \\        "children": {
        \\          "registers": {
        \\            "PORTB": {
        \\              "offset": 0,
        \\              "size": 8
        \\            },
        \\            "DDRB": {
        \\              "offset": 1,
        \\              "size": 8
        \\            },
        \\            "PINB": {
        \\              "offset": 2,
        \\              "size": 8
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "ATmega328P": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "PORTB": {
        \\            "offset": 35,
        \\            "count": 4,
        \\            "type": "types.peripherals.PORTB"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const register_with_count = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORTB": {
        \\        "children": {
        \\          "registers": {
        \\            "PORTB": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "count": 4
        \\            },
        \\            "DDRB": {
        \\              "offset": 4,
        \\              "size": 8
        \\            },
        \\            "PINB": {
        \\              "offset": 5,
        \\              "size": 8
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "ATmega328P": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "PORTB": {
        \\            "offset": 35,
        \\            "type": "types.peripherals.PORTB"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const register_with_count_and_fields = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORTB": {
        \\        "children": {
        \\          "registers": {
        \\            "PORTB": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "count": 4,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 0,
        \\                    "size": 4
        \\                  }
        \\                }
        \\              }
        \\            },
        \\            "DDRB": {
        \\              "offset": 4,
        \\              "size": 8
        \\            },
        \\            "PINB": {
        \\              "offset": 5,
        \\              "size": 8
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  },
        \\  "devices": {
        \\    "ATmega328P": {
        \\      "arch": "unknown",
        \\      "children": {
        \\        "peripheral_instances": {
        \\          "PORTB": {
        \\            "offset": 35,
        \\            "type": "types.peripherals.PORTB"
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const field_with_count_width_of_one_offset_and_padding = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORTB": {
        \\        "children": {
        \\          "registers": {
        \\            "PORTB": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 2,
        \\                    "size": 1,
        \\                    "count": 5
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const field_with_count_multibit_width_offset_and_padding = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "types": {
        \\    "peripherals": {
        \\      "PORTB": {
        \\        "children": {
        \\          "registers": {
        \\            "PORTB": {
        \\              "offset": 0,
        \\              "size": 8,
        \\              "children": {
        \\                "fields": {
        \\                  "TEST_FIELD": {
        \\                    "offset": 2,
        \\                    "size": 2,
        \\                    "count": 2
        \\                  }
        \\                }
        \\              }
        \\            }
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );

    const interrupts_avr = versionize(schema_version,
        \\{
        \\  "version": "<version>",
        \\  "devices": {
        \\    "ATmega328P": {
        \\      "arch": "avr8",
        \\      "children": {
        \\        "interrupts": {
        \\          "TEST_VECTOR1": {
        \\            "index": 1
        \\          },
        \\          "TEST_VECTOR2": {
        \\            "index": 3
        \\          }
        \\        }
        \\      }
        \\    }
        \\  }
        \\}
    );
};
