const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

const Database = @import("Database.zig");
const EntityId = Database.EntityId;

pub fn TypeOfField(comptime T: type, comptime field_name: []const u8) type {
    inline for (@typeInfo(T).Struct.fields) |field| {
        if (std.mem.eql(u8, field_name, field.name)) {
            return field.type;
        }
    }

    @compileError(field_name ++ " not found in " ++ @typeName(T));
}

fn Attr(comptime attr_name: []const u8) type {
    return TypeOfField(
        TypeOfField(
            TypeOfField(Database, "attrs"),
            attr_name,
        ).KV,
        "value",
    );
}

pub fn expect_attr(
    db: Database,
    comptime attr_name: []const u8,
    expected: Attr(attr_name),
    id: EntityId,
) !void {
    try expect(@field(db.attrs, attr_name).contains(id)); // id not in attr map
    switch (Attr(attr_name)) {
        []const u8 => try expectEqualStrings(expected, @field(db.attrs, attr_name).get(id).?),
        else => try expectEqual(expected, @field(db.attrs, attr_name).get(id).?),
    }
}

const DatabaseAndId = struct {
    db: Database,
    id: EntityId,
};

fn expect_equal_attr(
    comptime attr_name: []const u8,
    expected: DatabaseAndId,
    actual: DatabaseAndId,
) !void {
    const found = @field(expected.db.attrs, attr_name).contains(expected.id);
    try expectEqual(
        found,
        @field(actual.db.attrs, attr_name).contains(actual.id),
    );

    if (!found)
        return;

    const expected_value = @field(expected.db.attrs, attr_name).get(expected.id).?;
    const actual_value = @field(actual.db.attrs, attr_name).get(actual.id).?;
    switch (Attr(attr_name)) {
        []const u8 => try expectEqualStrings(expected_value, actual_value),
        else => try expectEqual(expected_value, actual_value),
    }
}

fn expect_equal_attrs(
    expected: DatabaseAndId,
    actual: DatabaseAndId,
) !void {
    // skip name since that's usually been compared

    try expect_equal_attr("description", expected, actual);
    try expect_equal_attr("offset", expected, actual);
    try expect_equal_attr("access", expected, actual);
    try expect_equal_attr("count", expected, actual);
    try expect_equal_attr("size", expected, actual);
    try expect_equal_attr("reset_value", expected, actual);
    try expect_equal_attr("reset_mask", expected, actual);
    try expect_equal_attr("version", expected, actual);

    // TODO:
    //  - modes
    //  - enum
}

pub fn expect_equal_databases(
    expected: Database,
    actual: Database,
) !void {
    var it = expected.types.peripherals.iterator();
    while (it.next()) |entry| {
        const peripheral_id = entry.key_ptr.*;
        const name = expected.attrs.name.get(peripheral_id) orelse unreachable;
        std.log.debug("peripheral: {s}", .{name});
        const expected_id = try expected.get_entity_id_by_name("type.peripheral", name);
        const actual_id = try actual.get_entity_id_by_name("type.peripheral", name);

        try expect_equal_entities(
            .{ .db = expected, .id = expected_id },
            .{ .db = actual, .id = actual_id },
        );
    }

    // difficult to debug, but broad checks
    inline for (@typeInfo(TypeOfField(Database, "attrs")).Struct.fields) |field| {
        std.log.debug("attr: {s}", .{field.name});
        try expectEqual(
            @field(expected.attrs, field.name).count(),
            @field(actual.attrs, field.name).count(),
        );
    }

    inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
        std.log.debug("child: {s}", .{field.name});
        try expectEqual(
            @field(expected.children, field.name).count(),
            @field(actual.children, field.name).count(),
        );
    }

    inline for (@typeInfo(TypeOfField(Database, "types")).Struct.fields) |field| {
        std.log.debug("type: {s}", .{field.name});
        try expectEqual(
            @field(expected.types, field.name).count(),
            @field(actual.types, field.name).count(),
        );
    }

    inline for (@typeInfo(TypeOfField(Database, "instances")).Struct.fields) |field| {
        std.log.debug("instance: {s}", .{field.name});
        try expectEqual(
            @field(expected.instances, field.name).count(),
            @field(actual.instances, field.name).count(),
        );
    }
}

const ErrorEqualEntities = error{
    TestExpectedEqual,
    NameNotFound,
    TestUnexpectedResult,
};

fn expect_equal_entities(
    expected: DatabaseAndId,
    actual: DatabaseAndId,
) ErrorEqualEntities!void {
    const expected_type = expected.db.get_entity_type(expected.id).?;
    const actual_type = actual.db.get_entity_type(actual.id).?;
    try expectEqual(expected_type, actual_type);

    switch (expected_type) {
        .enum_field => {
            const expected_value = expected.db.types.enum_fields.get(expected.id).?;
            const actual_value = actual.db.types.enum_fields.get(actual.id).?;
            try expectEqual(expected_value, actual_value);
        },
        .mode => {
            const expected_mode = expected.db.types.modes.get(expected.id).?;
            const actual_mode = actual.db.types.modes.get(actual.id).?;
            try expectEqualStrings(expected_mode.qualifier, actual_mode.qualifier);
            try expectEqualStrings(expected_mode.value, actual_mode.value);
        },
        .interrupt => {
            const expected_value = expected.db.instances.interrupts.get(expected.id).?;
            const actual_value = actual.db.instances.interrupts.get(actual.id).?;
            try expectEqual(expected_value, actual_value);
        },
        .peripheral_instance => {
            const expected_id = expected.db.instances.peripherals.get(expected.id).?;
            const actual_id = actual.db.instances.peripherals.get(actual.id).?;
            try expect_equal_entities(
                .{ .db = expected.db, .id = expected_id },
                .{ .db = actual.db, .id = actual_id },
            );
        },
        .device => {
            const expected_device = expected.db.instances.devices.get(expected.id).?;
            const actual_device = actual.db.instances.devices.get(actual.id).?;
            try expectEqual(expected_device.arch, actual_device.arch);

            // properties
            try expectEqual(
                expected_device.properties.count(),
                actual_device.properties.count(),
            );

            var it = expected_device.properties.iterator();
            while (it.next()) |entry| {
                const key = entry.key_ptr.*;
                const expected_value = entry.value_ptr.*;
                try expect(actual_device.properties.contains(key));
                try expectEqualStrings(
                    expected_value,
                    actual_device.properties.get(key).?,
                );
            }
        },

        else => {},
    }

    try expect_equal_attrs(expected, actual);
    try expect_equal_children(expected, actual);
}

fn expect_equal_children(
    expected: DatabaseAndId,
    actual: DatabaseAndId,
) ErrorEqualEntities!void {
    inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
        if (@field(expected.db.children, field.name).get(expected.id)) |entity_set| {
            var it = entity_set.iterator();
            while (it.next()) |entry| {
                const expected_child_id = entry.key_ptr.*;
                const expected_child_name = expected.db.attrs.name.get(expected_child_id) orelse continue;

                try expect(@field(actual.db.children, field.name).contains(actual.id));
                var actual_it = @field(actual.db.children, field.name).get(actual.id).?.iterator();
                const actual_child_id = while (actual_it.next()) |child_entry| {
                    const child_id = child_entry.key_ptr.*;
                    const actual_child_name = actual.db.attrs.name.get(child_id) orelse continue;
                    if (std.mem.eql(u8, expected_child_name, actual_child_name))
                        break child_id;
                } else return error.NameNotFound;

                try expect_equal_entities(
                    .{ .db = expected.db, .id = expected_child_id },
                    .{ .db = actual.db, .id = actual_child_id },
                );
            }
        }
    }
}
