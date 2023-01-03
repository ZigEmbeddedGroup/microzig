//! Regz JSON output
const std = @import("std");
const json = std.json;
const assert = std.debug.assert;
const ArenaAllocator = std.heap.ArenaAllocator;

const Database = @import("Database.zig");
const EntityId = Database.EntityId;
const PeripheralInstance = Database.PeripheralInstance;

const log = std.log.scoped(.regzon);

pub fn loadIntoDb(db: *Database, reader: anytype) !void {
    _ = db;
    _ = reader;
    return error.Todo;
}

pub fn toJson(db: Database) !json.ValueTree {
    var arena = ArenaAllocator.init(db.gpa);
    errdefer arena.deinit();

    const allocator = arena.allocator();
    var root = json.ObjectMap.init(allocator);
    var types = json.ObjectMap.init(allocator);
    var devices = json.ObjectMap.init(allocator);

    // this is a string map to ensure there are no typename collisions
    var types_to_populate = std.StringArrayHashMap(EntityId).init(allocator);

    var device_it = db.instances.devices.iterator();
    while (device_it.next()) |entry|
        try populateDevice(
            db,
            &arena,
            &types_to_populate,
            &devices,
            entry.key_ptr.*,
        );

    try populateTypes(db, &arena, &types);
    try root.put("types", .{ .Object = types });

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
    var it = db.types.peripherals.iterator();
    while (it.next()) |entry| {
        const periph_id = entry.key_ptr.*;
        const name = db.attrs.name.get(periph_id) orelse continue;
        var typ = json.ObjectMap.init(allocator);
        try populateType(db, arena, periph_id, &typ);
        try types.put(name, .{ .Object = typ });
    }
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

    if (db.attrs.@"enum".get(id)) |enum_id|
        if (db.attrs.name.get(enum_id)) |enum_name|
            try typ.put("enum", .{ .String = enum_name });

    if (db.attrs.modes.get(id)) |modeset| {
        var modearray = json.Array.init(allocator);

        var it = modeset.iterator();
        while (it.next()) |entry|
            if (db.attrs.name.get(entry.key_ptr.*)) |mode_name|
                try modearray.append(.{ .String = mode_name });

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
    types_to_populate: *std.StringArrayHashMap(EntityId),
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
            types_to_populate,
            &peripherals,
            entry.key_ptr.*,
            entry.value_ptr.*,
        );

    const arch = db.instances.devices.get(id).?.arch;
    try device.put("arch", .{ .String = arch.toString() });

    if (properties.count() > 0)
        try device.put("properties", .{ .Object = properties });

    if (interrupts.count() > 0)
        try device.put("interrupts", .{ .Object = interrupts });

    if (peripherals.count() > 0)
        try device.put("peripherals", .{ .Object = peripherals });

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
    types_to_populate: *std.StringArrayHashMap(EntityId),
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

    // if the peripheral instance's type is named, then we add it to the list
    // of types to populate
    if (db.attrs.name.get(type_id)) |type_name| {
        // TODO: handle collisions -- will need to inline the type
        try types_to_populate.put(type_name, type_id);
        try peripheral.put("type", .{ .String = type_name });
    } else {
        var typ = json.ObjectMap.init(allocator);
        try populateType(db, arena, type_id, &typ);
        try peripheral.put("type", .{ .Object = typ });
    }

    // TODO: peripheral instance children

    try peripherals.put(name, .{ .Object = peripheral });
}

// =============================================================================
// loadIntoDb Tests
// =============================================================================

// =============================================================================
// toJson Tests
// =============================================================================
