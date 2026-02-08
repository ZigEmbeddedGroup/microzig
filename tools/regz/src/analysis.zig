//! Analysis functions for identifying patterns in the database.
//!
//! This module provides analysis capabilities to identify and group anonymous
//! enums that are equivalent (same fields, descriptions, and size) within a
//! peripheral type. This enables suggesting `add_type_and_apply` patches.
const Analysis = @This();

const std = @import("std");
const Allocator = std.mem.Allocator;
const Database = @import("Database.zig");

const zqlite = @import("zqlite");

const log = std.log.scoped(.analysis);

db: *Database,

pub const EnumSignature = struct {
    size_bits: u8,
    description_hash: u64, // hash of description, 0 if null
    fields_hash: u64, // hash of canonical field representation
};

pub const AnonymousEnumInfo = struct {
    enum_id: Database.EnumID,
    struct_id: ?Database.StructID,
    size_bits: u8,
    description: ?[]const u8,
    /// Fields using this enum (register_name, field_name pairs)
    usages: []const FieldUsage,
};

pub const FieldUsage = struct {
    register_name: []const u8,
    field_name: []const u8,
};

pub const EnumEquivalenceGroup = struct {
    /// All enum IDs in this equivalence group
    members: []const Database.EnumID,
    /// Shared properties
    size_bits: u8,
    description: ?[]const u8,
    /// Fields from the representative enum
    fields: []const Database.EnumField,
    /// All field usages across all members
    usages: []const FieldUsage,
};

pub const AnalysisResult = struct {
    /// Groups with 2+ equivalent anonymous enums
    equivalence_groups: []const EnumEquivalenceGroup,
    /// Anonymous enums with no equivalents
    unique_enums: []const AnonymousEnumInfo,
    /// Statistics
    total_anonymous_enums: usize,
};

pub fn init(db: *Database) Analysis {
    return .{ .db = db };
}

/// Get all anonymous enums within a peripheral's struct hierarchy.
pub fn get_anonymous_enums_in_peripheral(
    self: *Analysis,
    arena: Allocator,
    peripheral_id: Database.PeripheralID,
) ![]const AnonymousEnumInfo {
    // Query: Get all anonymous enums in the peripheral's struct hierarchy
    // using a recursive CTE to traverse struct_decls
    const query =
        \\WITH RECURSIVE struct_tree AS (
        \\    SELECT struct_id FROM peripherals WHERE id = ?
        \\    UNION ALL
        \\    SELECT sd.struct_id FROM struct_decls sd
        \\    JOIN struct_tree st ON sd.parent_id = st.struct_id
        \\)
        \\SELECT e.id, e.struct_id, e.size_bits, e.description
        \\FROM enums e
        \\WHERE e.name IS NULL
        \\  AND (e.struct_id IN (SELECT struct_id FROM struct_tree) OR e.struct_id IS NULL)
        \\  AND e.id IN (
        \\      SELECT sf.enum_id FROM struct_fields sf
        \\      JOIN registers r ON sf.struct_id = r.struct_id
        \\      JOIN struct_registers sr ON sr.register_id = r.id
        \\      WHERE sr.struct_id IN (SELECT struct_id FROM struct_tree)
        \\        AND sf.enum_id IS NOT NULL
        \\  )
    ;

    var rows = try self.db.conn.rows(query, .{@intFromEnum(peripheral_id)});
    defer rows.deinit();

    var result: std.ArrayList(AnonymousEnumInfo) = .empty;

    while (rows.next()) |row| {
        const enum_id: Database.EnumID = @enumFromInt(row.int(0));
        const struct_id: ?Database.StructID = if (row.nullableInt(1)) |sid| @enumFromInt(sid) else null;
        const size_bits: u8 = @intCast(row.int(2));
        const description: ?[]const u8 = if (row.nullableText(3)) |text| try arena.dupe(u8, text) else null;

        const usages = try self.get_field_usages_for_enum(arena, enum_id, peripheral_id);

        try result.append(arena, .{
            .enum_id = enum_id,
            .struct_id = struct_id,
            .size_bits = size_bits,
            .description = description,
            .usages = usages,
        });
    }

    if (rows.err) |err| {
        return err;
    }

    return result.toOwnedSlice(arena);
}

/// Get field usages for a specific enum within a peripheral.
fn get_field_usages_for_enum(
    self: *Analysis,
    arena: Allocator,
    enum_id: Database.EnumID,
    peripheral_id: Database.PeripheralID,
) ![]const FieldUsage {
    const query =
        \\WITH RECURSIVE struct_tree AS (
        \\    SELECT struct_id FROM peripherals WHERE id = ?
        \\    UNION ALL
        \\    SELECT sd.struct_id FROM struct_decls sd
        \\    JOIN struct_tree st ON sd.parent_id = st.struct_id
        \\)
        \\SELECT r.name as register_name, sf.name as field_name
        \\FROM struct_fields sf
        \\JOIN registers r ON sf.struct_id = r.struct_id
        \\JOIN struct_registers sr ON sr.register_id = r.id
        \\WHERE sf.enum_id = ?
        \\  AND sr.struct_id IN (SELECT struct_id FROM struct_tree)
    ;

    var rows = try self.db.conn.rows(query, .{ @intFromEnum(peripheral_id), @intFromEnum(enum_id) });
    defer rows.deinit();

    var result: std.ArrayList(FieldUsage) = .empty;

    while (rows.next()) |row| {
        try result.append(arena, .{
            .register_name = try arena.dupe(u8, row.text(0)),
            .field_name = try arena.dupe(u8, row.text(1)),
        });
    }

    if (rows.err) |err| {
        return err;
    }

    return result.toOwnedSlice(arena);
}

/// Compute signature for an enum (for grouping).
fn compute_enum_signature(
    self: *Analysis,
    arena: Allocator,
    enum_id: Database.EnumID,
) !EnumSignature {
    // Get enum info
    const e = try self.db.get_enum(arena, enum_id);

    // Compute description hash
    const description_hash: u64 = if (e.description) |desc|
        std.hash.Wyhash.hash(0, desc)
    else
        0;

    // Get enum fields and compute fields hash
    const fields = try self.db.get_enum_fields(arena, enum_id, .{ .distinct = false });

    // Sort fields by value for canonical ordering
    const SortContext = struct {
        fn less_than(_: @This(), a: Database.EnumField, b: Database.EnumField) bool {
            return a.value < b.value;
        }
    };
    std.mem.sort(Database.EnumField, @constCast(fields), SortContext{}, SortContext.less_than);

    // Compute hash of (name, value, description) tuples
    var hasher = std.hash.Wyhash.init(0);
    for (fields) |field| {
        hasher.update(field.name);
        hasher.update(std.mem.asBytes(&field.value));
        if (field.description) |desc| {
            hasher.update(desc);
        } else {
            hasher.update(&[_]u8{0}); // Sentinel for null description
        }
    }

    return .{
        .size_bits = e.size_bits,
        .description_hash = description_hash,
        .fields_hash = hasher.final(),
    };
}

/// Find groups of equivalent anonymous enums within a peripheral.
pub fn find_equivalent_enums(
    self: *Analysis,
    arena: Allocator,
    peripheral_id: Database.PeripheralID,
) !AnalysisResult {
    // Get all anonymous enums in the peripheral
    const anonymous_enums = try self.get_anonymous_enums_in_peripheral(arena, peripheral_id);

    if (anonymous_enums.len == 0) {
        return .{
            .equivalence_groups = &.{},
            .unique_enums = &.{},
            .total_anonymous_enums = 0,
        };
    }

    // Group enums by signature
    const SignatureKey = struct {
        size_bits: u8,
        description_hash: u64,
        fields_hash: u64,

        pub fn hash(key: @This()) u64 {
            var hasher = std.hash.Wyhash.init(0);
            hasher.update(std.mem.asBytes(&key.size_bits));
            hasher.update(std.mem.asBytes(&key.description_hash));
            hasher.update(std.mem.asBytes(&key.fields_hash));
            return hasher.final();
        }

        pub fn eql(a: @This(), b: @This()) bool {
            return a.size_bits == b.size_bits and
                a.description_hash == b.description_hash and
                a.fields_hash == b.fields_hash;
        }
    };

    const HashMapContext = struct {
        pub fn hash(_: @This(), key: SignatureKey) u32 {
            return @truncate(SignatureKey.hash(key));
        }

        pub fn eql(_: @This(), a: SignatureKey, b: SignatureKey, _: usize) bool {
            return SignatureKey.eql(a, b);
        }
    };

    var groups: std.ArrayHashMapUnmanaged(SignatureKey, std.ArrayList(AnonymousEnumInfo), HashMapContext, false) = .{};

    for (anonymous_enums) |enum_info| {
        const signature = try self.compute_enum_signature(arena, enum_info.enum_id);
        const key: SignatureKey = .{
            .size_bits = signature.size_bits,
            .description_hash = signature.description_hash,
            .fields_hash = signature.fields_hash,
        };

        const entry = try groups.getOrPut(arena, key);
        if (!entry.found_existing) {
            entry.value_ptr.* = .empty;
        }
        try entry.value_ptr.append(arena, enum_info);
    }

    // Separate into equivalence groups (2+ members) and unique enums
    var equivalence_groups: std.ArrayList(EnumEquivalenceGroup) = .empty;
    var unique_enums: std.ArrayList(AnonymousEnumInfo) = .empty;

    var it = groups.iterator();
    while (it.next()) |entry| {
        const group_members = entry.value_ptr.items;
        if (group_members.len >= 2) {
            // This is an equivalence group
            var member_ids: std.ArrayList(Database.EnumID) = .empty;
            var all_usages: std.ArrayList(FieldUsage) = .empty;

            for (group_members) |member| {
                try member_ids.append(arena, member.enum_id);
                for (member.usages) |usage| {
                    try all_usages.append(arena, usage);
                }
            }

            // Get fields from representative enum (first one)
            const representative = group_members[0];
            const fields = try self.db.get_enum_fields(arena, representative.enum_id, .{ .distinct = false });

            try equivalence_groups.append(arena, .{
                .members = try member_ids.toOwnedSlice(arena),
                .size_bits = representative.size_bits,
                .description = representative.description,
                .fields = fields,
                .usages = try all_usages.toOwnedSlice(arena),
            });
        } else {
            // Single enum, no equivalents
            for (group_members) |member| {
                try unique_enums.append(arena, member);
            }
        }
    }

    return .{
        .equivalence_groups = try equivalence_groups.toOwnedSlice(arena),
        .unique_enums = try unique_enums.toOwnedSlice(arena),
        .total_anonymous_enums = anonymous_enums.len,
    };
}

// ============================================================================
// Tests
// ============================================================================

test "find equivalent anonymous enums" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    // Create a peripheral
    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Create multiple registers with anonymous enums that have identical fields
    // REG0 and REG1 will have equivalent anonymous enums
    // REG2 will have a different anonymous enum

    // Register 0 with anonymous enum
    const register0_id = try db.create_register(struct_id, .{
        .name = "REG0",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    const enum0_id = try db.create_enum(null, .{
        .size_bits = 2,
        .description = "mode selector",
    });
    try db.add_enum_field(enum0_id, .{ .name = "DISABLED", .value = 0 });
    try db.add_enum_field(enum0_id, .{ .name = "ENABLED", .value = 1 });
    try db.add_enum_field(enum0_id, .{ .name = "AUTO", .value = 2 });
    try db.add_register_field(register0_id, .{
        .name = "MODE",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum0_id,
    });

    // Register 1 with equivalent anonymous enum (same fields, size, description)
    const register1_id = try db.create_register(struct_id, .{
        .name = "REG1",
        .size_bits = 32,
        .offset_bytes = 4,
    });
    const enum1_id = try db.create_enum(null, .{
        .size_bits = 2,
        .description = "mode selector",
    });
    try db.add_enum_field(enum1_id, .{ .name = "DISABLED", .value = 0 });
    try db.add_enum_field(enum1_id, .{ .name = "ENABLED", .value = 1 });
    try db.add_enum_field(enum1_id, .{ .name = "AUTO", .value = 2 });
    try db.add_register_field(register1_id, .{
        .name = "MODE",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum1_id,
    });

    // Register 2 with different anonymous enum (different field values)
    const register2_id = try db.create_register(struct_id, .{
        .name = "REG2",
        .size_bits = 32,
        .offset_bytes = 8,
    });
    const enum2_id = try db.create_enum(null, .{
        .size_bits = 2,
        .description = "mode selector",
    });
    try db.add_enum_field(enum2_id, .{ .name = "OFF", .value = 0 });
    try db.add_enum_field(enum2_id, .{ .name = "ON", .value = 1 });
    try db.add_register_field(register2_id, .{
        .name = "STATE",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum2_id,
    });

    // Run analysis
    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    // Verify results
    try std.testing.expectEqual(@as(usize, 3), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 1), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 1), result.unique_enums.len);

    // The equivalence group should have enum0 and enum1
    const group = result.equivalence_groups[0];
    try std.testing.expectEqual(@as(usize, 2), group.members.len);
    try std.testing.expectEqual(@as(u8, 2), group.size_bits);
    try std.testing.expectEqual(@as(usize, 3), group.fields.len);
    try std.testing.expectEqual(@as(usize, 2), group.usages.len);

    // The unique enum should be enum2
    try std.testing.expectEqual(enum2_id, result.unique_enums[0].enum_id);
}

test "find equivalent enums - different sizes are not equivalent" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Two enums with same fields but different sizes
    const register0_id = try db.create_register(struct_id, .{
        .name = "REG0",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    const enum0_id = try db.create_enum(null, .{
        .size_bits = 2,
    });
    try db.add_enum_field(enum0_id, .{ .name = "A", .value = 0 });
    try db.add_enum_field(enum0_id, .{ .name = "B", .value = 1 });
    try db.add_register_field(register0_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum0_id,
    });

    const register1_id = try db.create_register(struct_id, .{
        .name = "REG1",
        .size_bits = 32,
        .offset_bytes = 4,
    });
    const enum1_id = try db.create_enum(null, .{
        .size_bits = 4, // Different size!
    });
    try db.add_enum_field(enum1_id, .{ .name = "A", .value = 0 });
    try db.add_enum_field(enum1_id, .{ .name = "B", .value = 1 });
    try db.add_register_field(register1_id, .{
        .name = "FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum1_id,
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    // Should have no equivalence groups since sizes differ
    try std.testing.expectEqual(@as(usize, 2), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 0), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 2), result.unique_enums.len);
}

test "find equivalent enums - different descriptions are not equivalent" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Two enums with same fields but different descriptions
    const register0_id = try db.create_register(struct_id, .{
        .name = "REG0",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    const enum0_id = try db.create_enum(null, .{
        .size_bits = 2,
        .description = "description A",
    });
    try db.add_enum_field(enum0_id, .{ .name = "A", .value = 0 });
    try db.add_register_field(register0_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum0_id,
    });

    const register1_id = try db.create_register(struct_id, .{
        .name = "REG1",
        .size_bits = 32,
        .offset_bytes = 4,
    });
    const enum1_id = try db.create_enum(null, .{
        .size_bits = 2,
        .description = "description B", // Different description!
    });
    try db.add_enum_field(enum1_id, .{ .name = "A", .value = 0 });
    try db.add_register_field(register1_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum1_id,
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    // Should have no equivalence groups since descriptions differ
    try std.testing.expectEqual(@as(usize, 2), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 0), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 2), result.unique_enums.len);
}

test "find equivalent enums - different field names are not equivalent" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register0_id = try db.create_register(struct_id, .{
        .name = "REG0",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    const enum0_id = try db.create_enum(null, .{
        .size_bits = 2,
    });
    try db.add_enum_field(enum0_id, .{ .name = "FOO", .value = 0 });
    try db.add_register_field(register0_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum0_id,
    });

    const register1_id = try db.create_register(struct_id, .{
        .name = "REG1",
        .size_bits = 32,
        .offset_bytes = 4,
    });
    const enum1_id = try db.create_enum(null, .{
        .size_bits = 2,
    });
    try db.add_enum_field(enum1_id, .{ .name = "BAR", .value = 0 }); // Different name!
    try db.add_register_field(register1_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum1_id,
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    // Should have no equivalence groups since field names differ
    try std.testing.expectEqual(@as(usize, 2), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 0), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 2), result.unique_enums.len);
}

test "find equivalent enums - empty peripheral" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "EMPTY_PERIPHERAL",
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    try std.testing.expectEqual(@as(usize, 0), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 0), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 0), result.unique_enums.len);
}

test "find equivalent enums - named enums are excluded" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Create a named enum (should be excluded from analysis)
    const named_enum_id = try db.create_enum(struct_id, .{
        .name = "NamedEnum",
        .size_bits = 2,
    });
    try db.add_enum_field(named_enum_id, .{ .name = "A", .value = 0 });

    const register0_id = try db.create_register(struct_id, .{
        .name = "REG0",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    try db.add_register_field(register0_id, .{
        .name = "FIELD",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = named_enum_id,
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    // Named enums should be excluded
    try std.testing.expectEqual(@as(usize, 0), result.total_anonymous_enums);
}

test "find equivalent enums - three equivalent enums" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Create three registers with identical anonymous enums
    inline for ([_]struct { name: []const u8, offset: u64 }{
        .{ .name = "REG0", .offset = 0 },
        .{ .name = "REG1", .offset = 4 },
        .{ .name = "REG2", .offset = 8 },
    }) |reg_info| {
        const register_id = try db.create_register(struct_id, .{
            .name = reg_info.name,
            .size_bits = 32,
            .offset_bytes = reg_info.offset,
        });
        const enum_id = try db.create_enum(null, .{
            .size_bits = 2,
        });
        try db.add_enum_field(enum_id, .{ .name = "X", .value = 0 });
        try db.add_enum_field(enum_id, .{ .name = "Y", .value = 1 });
        try db.add_register_field(register_id, .{
            .name = "MODE",
            .size_bits = 2,
            .offset_bits = 0,
            .enum_id = enum_id,
        });
    }

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try analysis.find_equivalent_enums(arena.allocator(), peripheral_id);

    try std.testing.expectEqual(@as(usize, 3), result.total_anonymous_enums);
    try std.testing.expectEqual(@as(usize, 1), result.equivalence_groups.len);
    try std.testing.expectEqual(@as(usize, 0), result.unique_enums.len);

    const group = result.equivalence_groups[0];
    try std.testing.expectEqual(@as(usize, 3), group.members.len);
    try std.testing.expectEqual(@as(usize, 3), group.usages.len);
}

test "get_anonymous_enums_in_peripheral returns correct usages" {
    const allocator = std.testing.allocator;

    var db = try Database.create(allocator);
    defer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Create a register with an anonymous enum used in a field
    const register_id = try db.create_register(struct_id, .{
        .name = "CONTROL",
        .size_bits = 32,
        .offset_bytes = 0,
    });
    const enum_id = try db.create_enum(null, .{
        .size_bits = 2,
    });
    try db.add_enum_field(enum_id, .{ .name = "VAL0", .value = 0 });
    try db.add_register_field(register_id, .{
        .name = "SELECT",
        .size_bits = 2,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    var analysis = Analysis.init(db);
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const enums = try analysis.get_anonymous_enums_in_peripheral(arena.allocator(), peripheral_id);

    try std.testing.expectEqual(@as(usize, 1), enums.len);
    try std.testing.expectEqual(enum_id, enums[0].enum_id);
    try std.testing.expectEqual(@as(usize, 1), enums[0].usages.len);
    try std.testing.expectEqualStrings("CONTROL", enums[0].usages[0].register_name);
    try std.testing.expectEqualStrings("SELECT", enums[0].usages[0].field_name);
}
