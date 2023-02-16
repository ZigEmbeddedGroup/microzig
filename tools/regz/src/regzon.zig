//! Regz JSON output
const std = @import("std");
const json = std.json;
const assert = std.debug.assert;
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;

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

fn getObject(val: json.Value) !json.ObjectMap {
    return switch (val) {
        .Object => |obj| obj,
        else => return error.NotJsonObject,
    };
}

fn getArray(val: json.Value) !json.Array {
    return switch (val) {
        .Array => |arr| arr,
        else => return error.NotJsonArray,
    };
}

// TODO: handle edge cases
fn getIntegerFromObject(obj: json.ObjectMap, comptime T: type, key: []const u8) !?T {
    return switch (obj.get(key) orelse return null) {
        .Integer => |num| @intCast(T, num),
        else => return error.NotJsonInteger,
    };
}

fn getStringFromObject(obj: json.ObjectMap, key: []const u8) !?[]const u8 {
    return switch (obj.get(key) orelse return null) {
        .String => |str| str,
        else => return error.NotJsonString,
    };
}

fn entityTypeToString(entity_type: Database.EntityType) []const u8 {
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

const string_to_entity_type = std.ComptimeStringMap(Database.EntityType, .{
    .{ "peripherals", .peripheral },
    .{ "register_groups", .register_group },
    .{ "registers", .register },
    .{ "fields", .field },
    .{ "enums", .@"enum" },
    .{ "enum_fields", .enum_field },
    .{ "modes", .mode },
    .{ "interrupts", .interrupt },
});

fn stringToEntityType(str: []const u8) !Database.EntityType {
    return if (string_to_entity_type.get(str)) |entity_type|
        entity_type
    else
        error.InvalidEntityType;
}

// gets stuffed in the arena allocator
fn idToRef(
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
    const root_type = db.getEntityType(ids.items[0]).?;

    if (root_type.isInstance())
        //try writer.writeAll("instances")
        @panic("TODO")
    else
        try writer.writeAll("types");

    try writer.print(".{s}.{s}", .{
        entityTypeToString(root_type),
        std.zig.fmtId(db.attrs.name.get(ids.items[0]) orelse return error.MissingName),
    });

    for (ids.items[1..]) |id| {
        const entity_type = db.getEntityType(id).?;
        try writer.print(".children.{s}.{s}", .{
            entityTypeToString(entity_type),
            std.zig.fmtId(db.attrs.name.get(id) orelse return error.MissingName),
        });
    }

    return ref.toOwnedSlice();
}

pub fn loadIntoDb(db: *Database, text: []const u8) !void {
    var parser = json.Parser.init(db.gpa, false);
    defer parser.deinit();

    var tree = try parser.parse(text);
    defer tree.deinit();

    if (tree.root != .Object)
        return error.NotJsonObject;

    var ctx = LoadContext{
        .db = db,
        .arena = std.heap.ArenaAllocator.init(db.gpa),
    };
    defer ctx.deinit();

    if (tree.root.Object.get("types")) |types|
        try loadTypes(&ctx, try getObject(types));

    if (tree.root.Object.get("devices")) |devices|
        try loadDevices(&ctx, try getObject(devices));

    try resolveEnums(&ctx);
}

fn resolveEnums(ctx: *LoadContext) !void {
    const db = ctx.db;
    var it = ctx.enum_refs.iterator();
    while (it.next()) |entry| {
        const id = entry.key_ptr.*;
        const ref = entry.value_ptr.*;
        const enum_id = try refToId(db.*, ref);
        //assert(db.entityIs("type.enum", enum_id));
        try ctx.db.attrs.@"enum".put(db.gpa, id, enum_id);
    }
}

fn refToId(db: Database, ref: []const u8) !EntityId {
    // TODO: do proper tokenization since we'll need to handle @"" fields. okay to leave for now.
    var it = std.mem.tokenize(u8, ref, ".");
    const first = it.next() orelse return error.Malformed;
    return if (std.mem.eql(u8, "types", first)) blk: {
        var tmp_id: ?EntityId = null;
        break :blk while (true) {
            const entity_type = entity_type: {
                const str = it.next() orelse return error.Malformed;
                break :entity_type try stringToEntityType(str);
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
                    const other_type = try stringToEntityType(field.name);
                    if (entity_type == other_type) {
                        var entity_it = @field(db.types, field.name).iterator();
                        while (entity_it.next()) |entry| {
                            const id = entry.key_ptr.*;
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
                    const other_type = try stringToEntityType(field.name);
                    if (entity_type == other_type) {
                        if (@field(db.children, field.name).get(tmp_id.?)) |children| {
                            var child_it = children.iterator();
                            while (child_it.next()) |child_entry| {
                                const child_id = child_entry.key_ptr.*;
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

fn loadTypes(ctx: *LoadContext, types: json.ObjectMap) !void {
    if (types.get("peripherals")) |peripherals|
        try loadPeripherals(ctx, try getObject(peripherals));
}

fn loadPeripherals(ctx: *LoadContext, peripherals: json.ObjectMap) !void {
    var it = peripherals.iterator();
    while (it.next()) |entry| {
        const name = entry.key_ptr.*;
        const peripheral = entry.value_ptr.*;
        try loadPeripheral(ctx, name, try getObject(peripheral));
    }
}

fn loadPeripheral(
    ctx: *LoadContext,
    name: []const u8,
    peripheral: json.ObjectMap,
) !void {
    log.debug("loading peripheral: {s}", .{name});
    const db = ctx.db;
    const id = try db.createPeripheral(.{
        .name = name,
        .description = try getStringFromObject(peripheral, "description"),
        .size = if (peripheral.get("size")) |size_val|
            switch (size_val) {
                .Integer => |num| @intCast(u64, num),
                else => return error.SizeNotInteger,
            }
        else
            null,
    });
    errdefer db.destroyEntity(id);

    if (peripheral.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
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

const LoadFn = fn (*LoadContext, EntityId, []const u8, json.ObjectMap) LoadError!void;
const LoadMultipleFn = fn (*LoadContext, EntityId, json.ObjectMap) LoadError!void;
fn loadEntities(comptime load_fn: LoadFn) LoadMultipleFn {
    return struct {
        fn tmp(
            ctx: *LoadContext,
            parent_id: EntityId,
            entities: json.ObjectMap,
        ) LoadError!void {
            var it = entities.iterator();
            while (it.next()) |entry| {
                const name = entry.key_ptr.*;
                const entity = entry.value_ptr.*;
                try load_fn(ctx, parent_id, name, try getObject(entity));
            }
        }
    }.tmp;
}

const load_fns = struct {
    // types
    const register_groups = loadEntities(loadRegisterGroup);
    const registers = loadEntities(loadRegister);
    const fields = loadEntities(loadField);
    const enums = loadEntities(loadEnum);
    const enum_fields = loadEntities(loadEnumField);
    const modes = loadEntities(loadMode);

    // instances
    const interrupts = loadEntities(loadInterrupt);
    const peripheral_instances = loadEntities(loadPeripheralInstance);
};

fn loadChildren(
    ctx: *LoadContext,
    parent_id: EntityId,
    children: json.ObjectMap,
) LoadError!void {
    var it = children.iterator();
    while (it.next()) |entry| {
        const child_type = entry.key_ptr.*;
        const child_map = entry.value_ptr.*;

        inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
            if (std.mem.eql(u8, child_type, field.name)) {
                if (@hasDecl(load_fns, field.name))
                    try @field(load_fns, field.name)(ctx, parent_id, try getObject(child_map));

                break;
            }
        } else if (std.mem.eql(u8, "peripheral_instances", child_type)) {
            try load_fns.peripheral_instances(ctx, parent_id, try getObject(child_map));
        } else {
            log.err("{s} is not a valid child type", .{child_type});
            return error.InvalidChildType;
        }
    }
}

fn loadMode(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    mode: json.ObjectMap,
) LoadError!void {
    _ = try ctx.db.createMode(parent_id, .{
        .name = name,
        .description = try getStringFromObject(mode, "description"),
        .value = (try getStringFromObject(mode, "value")) orelse return error.MissingModeValue,
        .qualifier = (try getStringFromObject(mode, "qualifier")) orelse return error.MissingModeQualifier,
    });
}

fn loadRegisterGroup(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    register_group: json.ObjectMap,
) LoadError!void {
    log.debug("load register group", .{});
    const db = ctx.db;
    // TODO: probably more
    const id = try db.createRegisterGroup(parent_id, .{
        .name = name,
        .description = try getStringFromObject(register_group, "description"),
    });
    errdefer db.destroyEntity(id);

    if (register_group.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
}

fn loadRegister(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    register: json.ObjectMap,
) LoadError!void {
    const db = ctx.db;
    const id = try db.createRegister(parent_id, .{
        .name = name,
        .description = try getStringFromObject(register, "description"),
        .offset = (try getIntegerFromObject(register, u64, "offset")) orelse return error.MissingRegisterOffset,
        .size = (try getIntegerFromObject(register, u64, "size")) orelse return error.MissingRegisterSize,
        .count = try getIntegerFromObject(register, u64, "count"),
        .access = if (try getStringFromObject(register, "access")) |access_str|
            std.meta.stringToEnum(Database.Access, access_str)
        else
            null,
        .reset_mask = try getIntegerFromObject(register, u64, "reset_mask"),
        .reset_value = try getIntegerFromObject(register, u64, "reset_value"),
    });
    errdefer db.destroyEntity(id);

    if (register.get("modes")) |modes|
        try loadModes(ctx, id, try getArray(modes));

    if (register.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
}

fn loadModes(
    ctx: *LoadContext,
    parent_id: EntityId,
    modes: json.Array,
) !void {
    const db = ctx.db;
    for (modes.items) |mode_val| {
        const mode_ref = switch (mode_val) {
            .String => |str| str,
            else => return error.InvalidJsonType,
        };

        const mode_id = try refToId(db.*, mode_ref);
        //assert(db.entityIs("type.mode", mode_id));
        const result = try db.attrs.modes.getOrPut(db.gpa, parent_id);
        if (!result.found_existing)
            result.value_ptr.* = .{};

        try result.value_ptr.put(db.gpa, mode_id, {});
    }
}

fn loadField(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    field: json.ObjectMap,
) LoadError!void {
    const db = ctx.db;
    const id = try db.createField(parent_id, .{
        .name = name,
        .description = try getStringFromObject(field, "description"),
        .offset = (try getIntegerFromObject(field, u64, "offset")) orelse return error.MissingRegisterOffset,
        .size = (try getIntegerFromObject(field, u64, "size")) orelse return error.MissingRegisterSize,
        .count = try getIntegerFromObject(field, u64, "count"),
    });
    errdefer db.destroyEntity(id);

    if (field.get("enum")) |enum_val|
        switch (enum_val) {
            .String => |ref_str| try ctx.enum_refs.put(db.gpa, id, ref_str),
            .Object => |enum_obj| {
                // peripheral is the parent of enums
                // TODO: change this
                const peripheral_id = peripheral_id: {
                    var tmp_id = id;
                    break :peripheral_id while (db.attrs.parent.get(tmp_id)) |next_id| : (tmp_id = next_id) {
                        if (.peripheral == db.getEntityType(next_id).?)
                            break next_id;
                    } else return error.NoPeripheralFound;
                };

                const enum_id = try loadEnumBase(ctx, peripheral_id, null, enum_obj);
                try db.attrs.@"enum".put(db.gpa, id, enum_id);
            },
            else => return error.InvalidJsonType,
        };

    if (field.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
}

fn loadEnum(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    enumeration: json.ObjectMap,
) LoadError!void {
    _ = try loadEnumBase(ctx, parent_id, name, enumeration);
}

fn loadEnumBase(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: ?[]const u8,
    enumeration: json.ObjectMap,
) LoadError!EntityId {
    const db = ctx.db;
    const id = try db.createEnum(parent_id, .{
        .name = name,
        .description = try getStringFromObject(enumeration, "description"),
        .size = (try getIntegerFromObject(enumeration, u64, "size")) orelse return error.MissingEnumSize,
    });
    errdefer db.destroyEntity(id);

    if (enumeration.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));

    return id;
}

fn loadEnumField(
    ctx: *LoadContext,
    parent_id: EntityId,
    name: []const u8,
    enum_field: json.ObjectMap,
) LoadError!void {
    const db = ctx.db;

    const id = try db.createEnumField(parent_id, .{
        .name = name,
        .description = try getStringFromObject(enum_field, "description"),
        .value = (try getIntegerFromObject(enum_field, u32, "value")) orelse return error.MissingEnumFieldValue,
    });

    if (enum_field.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
}

fn loadDevices(ctx: *LoadContext, devices: json.ObjectMap) !void {
    var it = devices.iterator();
    while (it.next()) |entry| {
        const name = entry.key_ptr.*;
        const device = entry.value_ptr.*;
        try loadDevice(ctx, name, try getObject(device));
    }
}

fn loadDevice(ctx: *LoadContext, name: []const u8, device: json.ObjectMap) !void {
    log.debug("loading device: {s}", .{name});
    const db = ctx.db;
    const id = try db.createDevice(.{
        .name = name,
        .description = try getStringFromObject(device, "description"),
        .arch = if (device.get("arch")) |arch_val|
            switch (arch_val) {
                .String => |arch_str| std.meta.stringToEnum(Database.Arch, arch_str) orelse return error.InvalidArch,
                else => return error.InvalidJsonType,
            }
        else
            .unknown,
    });
    errdefer db.destroyEntity(id);

    if (device.get("properties")) |properties|
        try loadProperties(ctx, id, try getObject(properties));

    if (device.get("children")) |children|
        try loadChildren(ctx, id, try getObject(children));
}

fn loadProperties(ctx: *LoadContext, device_id: EntityId, properties: json.ObjectMap) !void {
    const db = ctx.db;
    var it = properties.iterator();
    while (it.next()) |entry| {
        const key = entry.key_ptr.*;
        const value = switch (entry.value_ptr.*) {
            .String => |str| str,
            else => return error.InvalidJsonType,
        };

        try db.addDeviceProperty(device_id, key, value);
    }
}

fn loadInterrupt(
    ctx: *LoadContext,
    device_id: EntityId,
    name: []const u8,
    interrupt: json.ObjectMap,
) LoadError!void {
    _ = try ctx.db.createInterrupt(device_id, .{
        .name = name,
        .description = try getStringFromObject(interrupt, "description"),
        .index = (try getIntegerFromObject(interrupt, i32, "index")) orelse return error.MissingInterruptIndex,
    });
}

fn loadPeripheralInstance(
    ctx: *LoadContext,
    device_id: EntityId,
    name: []const u8,
    peripheral: json.ObjectMap,
) !void {
    const db = ctx.db;
    const type_ref = (try getStringFromObject(peripheral, "type")) orelse return error.MissingInstanceType;
    const type_id = try refToId(db.*, type_ref);
    _ = try ctx.db.createPeripheralInstance(device_id, type_id, .{
        .name = name,
        .description = try getStringFromObject(peripheral, "description"),
        .offset = (try getIntegerFromObject(peripheral, u64, "offset")) orelse return error.MissingInstanceOffset,
        .count = try getIntegerFromObject(peripheral, u64, "count"),
    });
}

pub fn toJson(db: Database) !json.ValueTree {
    const arena = try db.gpa.create(ArenaAllocator);
    errdefer db.gpa.destroy(arena);

    arena.* = ArenaAllocator.init(db.gpa);
    errdefer arena.deinit();

    const allocator = arena.allocator();
    var root = json.ObjectMap.init(allocator);
    var types = json.ObjectMap.init(allocator);
    var devices = json.ObjectMap.init(allocator);

    var device_it = db.instances.devices.iterator();
    while (device_it.next()) |entry|
        try populateDevice(
            db,
            arena,
            &devices,
            entry.key_ptr.*,
        );

    try root.put("version", .{ .String = schema_version });
    try populateTypes(db, arena, &types);
    if (types.count() > 0)
        try root.put("types", .{ .Object = types });

    if (devices.count() > 0)
        try root.put("devices", .{ .Object = devices });

    return json.ValueTree{
        .arena = arena,
        .root = .{ .Object = root },
    };
}

fn populateTypes(
    db: Database,
    arena: *ArenaAllocator,
    types: *json.ObjectMap,
) !void {
    const allocator = arena.allocator();
    var peripherals = json.ObjectMap.init(allocator);
    var it = db.types.peripherals.iterator();
    while (it.next()) |entry| {
        const periph_id = entry.key_ptr.*;
        const name = db.attrs.name.get(periph_id) orelse continue;
        var typ = json.ObjectMap.init(allocator);
        try populateType(db, arena, periph_id, &typ);
        try peripherals.put(name, .{ .Object = typ });
    }

    if (peripherals.count() > 0)
        try types.put("peripherals", .{ .Object = peripherals });
}

fn populateType(
    db: Database,
    arena: *ArenaAllocator,
    id: EntityId,
    typ: *json.ObjectMap,
) !void {
    const allocator = arena.allocator();
    if (db.attrs.description.get(id)) |description|
        try typ.put("description", .{ .String = description });

    if (db.attrs.offset.get(id)) |offset|
        try typ.put("offset", .{ .Integer = @intCast(i64, offset) });

    if (db.attrs.size.get(id)) |size|
        try typ.put("size", .{ .Integer = @intCast(i64, size) });

    if (db.attrs.count.get(id)) |count|
        try typ.put("count", .{ .Integer = @intCast(i64, count) });

    if (db.attrs.reset_value.get(id)) |reset_value|
        try typ.put("reset_value", .{ .Integer = @intCast(i64, reset_value) });

    if (db.attrs.reset_mask.get(id)) |reset_mask|
        try typ.put("reset_mask", .{ .Integer = @intCast(i64, reset_mask) });

    if (db.attrs.version.get(id)) |version|
        try typ.put("version", .{ .String = version });

    if (db.attrs.access.get(id)) |access| if (access != .read_write)
        try typ.put("access", .{
            .String = switch (access) {
                .read_only => "read-only",
                .write_only => "write-only",
                else => unreachable,
            },
        });

    if (db.attrs.@"enum".get(id)) |enum_id| {
        if (db.attrs.name.contains(enum_id)) {
            const ref = try idToRef(arena.allocator(), db, enum_id);
            try typ.put("enum", .{ .String = ref });
        } else {
            var anon_enum = json.ObjectMap.init(allocator);
            try populateType(db, arena, enum_id, &anon_enum);
            try typ.put("enum", .{ .Object = anon_enum });
        }
    }

    if (db.attrs.modes.get(id)) |modeset| {
        var modearray = json.Array.init(allocator);

        var it = modeset.iterator();
        while (it.next()) |entry| {
            const mode_id = entry.key_ptr.*;
            if (db.attrs.name.contains(mode_id)) {
                const ref = try idToRef(
                    arena.allocator(),
                    db,
                    mode_id,
                );
                try modearray.append(.{ .String = ref });
            } else return error.MissingModeName;
        }

        if (modearray.items.len > 0)
            try typ.put("modes", .{ .Array = modearray });
    }

    if (db.types.enum_fields.get(id)) |enum_field| {
        try typ.put("value", .{ .Integer = enum_field });
    } else if (db.types.modes.get(id)) |mode| {
        try typ.put("value", .{ .String = mode.value });
        try typ.put("qualifier", .{ .String = mode.qualifier });
    }

    var children = json.ObjectMap.init(allocator);
    inline for (@typeInfo(@TypeOf(db.children)).Struct.fields) |field| {
        var obj = json.ObjectMap.init(allocator);

        if (@field(db.children, field.name).get(id)) |set| {
            assert(set.count() > 0);
            var it = set.iterator();
            while (it.next()) |entry| {
                const child_id = entry.key_ptr.*;
                const name = db.attrs.name.get(child_id) orelse continue;
                var child_type = json.ObjectMap.init(allocator);
                try populateType(db, arena, child_id, &child_type);
                try obj.put(name, .{ .Object = child_type });
            }
        }

        if (obj.count() > 0)
            try children.put(field.name, .{ .Object = obj });
    }

    if (children.count() > 0)
        try typ.put("children", .{ .Object = children });
}

fn populateDevice(
    db: Database,
    arena: *ArenaAllocator,
    devices: *json.ObjectMap,
    id: EntityId,
) !void {
    const allocator = arena.allocator();
    const name = db.attrs.name.get(id) orelse return error.MissingDeviceName;

    var device = json.ObjectMap.init(allocator);
    var properties = json.ObjectMap.init(allocator);
    var prop_it = db.instances.devices.get(id).?.properties.iterator();
    while (prop_it.next()) |entry|
        try properties.put(entry.key_ptr.*, .{ .String = entry.value_ptr.* });

    var interrupts = json.ObjectMap.init(allocator);
    populate_interrupts: {
        var interrupt_it = (db.children.interrupts.get(id) orelse
            break :populate_interrupts).iterator();
        while (interrupt_it.next()) |entry|
            try populateInterrupt(db, arena, &interrupts, entry.key_ptr.*);
    }

    // TODO: link peripherals to device
    var peripherals = json.ObjectMap.init(allocator);
    var periph_it = db.instances.peripherals.iterator();
    while (periph_it.next()) |entry|
        try populatePeripheral(
            db,
            arena,
            &peripherals,
            entry.key_ptr.*,
            entry.value_ptr.*,
        );

    const arch = db.instances.devices.get(id).?.arch;
    try device.put("arch", .{ .String = arch.toString() });
    if (db.attrs.description.get(id)) |description|
        try device.put("description", .{ .String = description });

    if (properties.count() > 0)
        try device.put("properties", .{ .Object = properties });

    var device_children = json.ObjectMap.init(allocator);
    if (interrupts.count() > 0)
        try device_children.put("interrupts", .{ .Object = interrupts });

    if (peripherals.count() > 0)
        try device_children.put("peripheral_instances", .{ .Object = peripherals });

    if (device_children.count() > 0)
        try device.put("children", .{ .Object = device_children });

    try devices.put(name, .{ .Object = device });
}

fn populateInterrupt(
    db: Database,
    arena: *ArenaAllocator,
    interrupts: *json.ObjectMap,
    id: EntityId,
) !void {
    const allocator = arena.allocator();
    var interrupt = json.ObjectMap.init(allocator);

    const name = db.attrs.name.get(id) orelse return error.MissingInterruptName;
    const index = db.instances.interrupts.get(id) orelse return error.MissingInterruptIndex;
    try interrupt.put("index", .{ .Integer = index });
    if (db.attrs.description.get(id)) |description|
        try interrupt.put("description", .{ .String = description });

    try interrupts.put(name, .{ .Object = interrupt });
}

fn populatePeripheral(
    db: Database,
    arena: *ArenaAllocator,
    peripherals: *json.ObjectMap,
    id: EntityId,
    type_id: EntityId,
) !void {
    const allocator = arena.allocator();
    const name = db.attrs.name.get(id) orelse return error.MissingPeripheralName;
    var peripheral = json.ObjectMap.init(allocator);
    if (db.attrs.description.get(id)) |description|
        try peripheral.put("description", .{ .String = description });

    if (db.attrs.offset.get(id)) |offset|
        try peripheral.put("offset", .{ .Integer = @intCast(i64, offset) });

    if (db.attrs.version.get(id)) |version|
        try peripheral.put("version", .{ .String = version });

    if (db.attrs.count.get(id)) |count|
        try peripheral.put("count", .{ .Integer = @intCast(i64, count) });

    // TODO: handle collisions -- will need to inline the type
    const type_ref = try idToRef(
        arena.allocator(),
        db,
        type_id,
    );
    try peripheral.put("type", .{ .String = type_ref });

    // TODO: peripheral instance children

    try peripherals.put(name, .{ .Object = peripheral });
}

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;
const DbInitFn = fn (allocator: std.mem.Allocator) anyerror!Database;
const tests = @import("output_tests.zig");

test "refToId" {
    var db = try tests.peripheralWithModes(std.testing.allocator);
    defer db.deinit();

    const mode_id = try db.getEntityIdByName("type.mode", "TEST_MODE1");
    const mode_ref = try idToRef(std.testing.allocator, db, mode_id);
    defer std.testing.allocator.free(mode_ref);

    try expectEqualStrings(
        "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE1",
        mode_ref,
    );
}

test "idToRef" {
    var db = try tests.peripheralWithModes(std.testing.allocator);
    defer db.deinit();

    const expected_mode_id = try db.getEntityIdByName("type.mode", "TEST_MODE1");
    const actual_mode_id = try refToId(
        db,
        "types.peripherals.TEST_PERIPHERAL.children.modes.TEST_MODE1",
    );

    try expectEqual(expected_mode_id, actual_mode_id);
}

// =============================================================================
// loadIntoDb Tests
// =============================================================================
fn loadTest(comptime init: DbInitFn, input: []const u8) !void {
    var expected = try init(std.testing.allocator);
    defer expected.deinit();

    const copy = try std.testing.allocator.dupe(u8, input);
    var actual = Database.initFromJson(std.testing.allocator, copy) catch |err| {
        std.testing.allocator.free(copy);
        return err;
    };
    defer actual.deinit();

    // freeing explicitly here to invalidate the memory for input
    std.testing.allocator.free(copy);
    try testing.expectEqualDatabases(expected, actual);
}

test "regzon.load.empty" {
    try loadTest(emptyDb, json_data.empty);
}

test "regzon.load.peripheral type with register and field" {
    try loadTest(
        tests.peripheralTypeWithRegisterAndField,
        json_data.peripheral_type_with_register_and_field,
    );
}

test "regzon.load.peripheral instantiation" {
    try loadTest(
        tests.peripheralInstantiation,
        json_data.peripheral_instantiation,
    );
}

test "regzon.load.peripherals with a shared type" {
    try loadTest(
        tests.peripheralsWithSharedType,
        json_data.peripherals_with_shared_type,
    );
}

test "regzon.load.peripheral with modes" {
    try loadTest(
        tests.peripheralWithModes,
        json_data.peripherals_with_modes,
    );
}

test "regzon.load.field with named enum" {
    try loadTest(
        tests.fieldWithNamedEnum,
        json_data.field_with_named_enum,
    );
}

test "regzon.load.field with anonymous enum" {
    try loadTest(
        tests.fieldWithAnonymousEnum,
        json_data.field_with_anonymous_enum,
    );
}

test "regzon.load.namespaced register groups" {
    try loadTest(
        tests.namespacedRegisterGroups,
        json_data.namespaced_register_groups,
    );
}

test "regzon.load.peripheral with count" {
    try loadTest(
        tests.peripheralWithCount,
        json_data.peripheral_with_count,
    );
}

test "regzon.load.register with count" {
    try loadTest(
        tests.registerWithCount,
        json_data.register_with_count,
    );
}

test "regzon.load.register with count and fields" {
    try loadTest(
        tests.registerWithCountAndFields,
        json_data.register_with_count_and_fields,
    );
}

test "regzon.load.field with count, width of one, offset, and padding" {
    try loadTest(
        tests.fieldWithCountWidthOfOneOffsetAndPadding,
        json_data.field_with_count_width_of_one_offset_and_padding,
    );
}

test "regzon.load.field_with_count_multibit_width_offset_and_padding" {
    try loadTest(
        tests.fieldWithCountMultiBitWidthOffsetAndPadding,
        json_data.field_with_count_multibit_width_offset_and_padding,
    );
}

test "regzon.load.interruptsAvr" {
    try loadTest(
        tests.interruptsAvr,
        json_data.interrupts_avr,
    );
}

// =============================================================================
// jsonStringify Tests
// =============================================================================
fn stringifyTest(comptime init: DbInitFn, expected: []const u8) !void {
    var db = try init(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    const test_stringify_opts = .{
        .whitespace = .{
            .indent_level = 0,
            .indent = .{ .Space = 2 },
        },
    };

    try db.jsonStringify(test_stringify_opts, buffer.writer());
    try expectEqualStrings(expected, buffer.items);
}

fn emptyDb(allocator: Allocator) !Database {
    return Database.init(allocator);
}

test "regzon.jsonStringify.empty" {
    try stringifyTest(emptyDb, json_data.empty);
}

test "regzon.jsonStringify.peripheral type with register and field" {
    try stringifyTest(
        tests.peripheralTypeWithRegisterAndField,
        json_data.peripheral_type_with_register_and_field,
    );
}

test "regzon.jsonStringify.peripheral instantiation" {
    try stringifyTest(
        tests.peripheralInstantiation,
        json_data.peripheral_instantiation,
    );
}

test "regzon.jsonStringify.peripherals with a shared type" {
    try stringifyTest(
        tests.peripheralsWithSharedType,
        json_data.peripherals_with_shared_type,
    );
}

test "regzon.jsonStringify.peripheral with modes" {
    try stringifyTest(
        tests.peripheralWithModes,
        json_data.peripherals_with_modes,
    );
}

test "regzon.jsonStringify.field with named enum" {
    try stringifyTest(
        tests.fieldWithNamedEnum,
        json_data.field_with_named_enum,
    );
}

test "regzon.jsonStringify.field with anonymous enum" {
    try stringifyTest(
        tests.fieldWithAnonymousEnum,
        json_data.field_with_anonymous_enum,
    );
}

test "regzon.jsonStringify.namespaced register groups" {
    try stringifyTest(
        tests.namespacedRegisterGroups,
        json_data.namespaced_register_groups,
    );
}

test "regzon.jsonStringify.peripheral with count" {
    try stringifyTest(
        tests.peripheralWithCount,
        json_data.peripheral_with_count,
    );
}

test "regzon.jsonStringify.register with count" {
    try stringifyTest(
        tests.registerWithCount,
        json_data.register_with_count,
    );
}

test "regzon.jsonStringify.register with count and fields" {
    try stringifyTest(
        tests.registerWithCountAndFields,
        json_data.register_with_count_and_fields,
    );
}

test "regzon.jsonStringify.field with count, width of one, offset, and padding" {
    try stringifyTest(
        tests.fieldWithCountWidthOfOneOffsetAndPadding,
        json_data.field_with_count_width_of_one_offset_and_padding,
    );
}

test "regzon.jsonStringify.field_with_count_multibit_width_offset_and_padding" {
    try stringifyTest(
        tests.fieldWithCountMultiBitWidthOffsetAndPadding,
        json_data.field_with_count_multibit_width_offset_and_padding,
    );
}

test "regzon.jsonStringify.interruptsAvr" {
    try stringifyTest(
        tests.interruptsAvr,
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
