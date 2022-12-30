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

pub fn expectAttr(
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
