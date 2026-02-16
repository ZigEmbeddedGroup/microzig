const std = @import("std");
const diffz = @import("diffz");

const DiffLine = struct {
    kind: Kind,
    text: []const u8,

    const Kind = enum { context, added, removed };
};

fn compute_line_diff(arena: std.mem.Allocator, old_content: []const u8, new_content: []const u8) ![]const DiffLine {
    const Kind = DiffLine.Kind;
    var result: std.ArrayList(DiffLine) = .{};

    // Split content into lines
    var old_lines: std.ArrayList([]const u8) = .{};
    var new_lines: std.ArrayList([]const u8) = .{};

    var old_iter = std.mem.splitScalar(u8, old_content, '\n');
    while (old_iter.next()) |line| {
        try old_lines.append(arena, line);
    }

    var new_iter = std.mem.splitScalar(u8, new_content, '\n');
    while (new_iter.next()) |line| {
        try new_lines.append(arena, line);
    }

    // Encode lines as single characters for diffz (line-mode diffing)
    var line_to_char: std.StringHashMap(u8) = .init(arena);
    var char_to_line: std.ArrayList([]const u8) = .{};
    var next_char: u8 = 1;

    var old_chars: std.ArrayList(u8) = .{};
    var new_chars: std.ArrayList(u8) = .{};

    // Encode old lines
    for (old_lines.items) |line| {
        if (line_to_char.get(line)) |c| {
            try old_chars.append(arena, c);
        } else {
            try line_to_char.put(line, next_char);
            try char_to_line.append(arena, line);
            try old_chars.append(arena, next_char);
            next_char +%= 1;
            if (next_char == 0) next_char = 1;
        }
    }

    // Encode new lines
    for (new_lines.items) |line| {
        if (line_to_char.get(line)) |c| {
            try new_chars.append(arena, c);
        } else {
            try line_to_char.put(line, next_char);
            try char_to_line.append(arena, line);
            try new_chars.append(arena, next_char);
            next_char +%= 1;
            if (next_char == 0) next_char = 1;
        }
    }

    // Run diffz on the encoded character sequences
    const dmp: diffz = .{ .diff_timeout = 0 };
    const diffs = try dmp.diff(arena, old_chars.items, new_chars.items, false);

    // Decode diffs back to lines
    for (diffs.items) |d| {
        const kind: Kind = switch (d.operation) {
            .equal => .context,
            .insert => .added,
            .delete => .removed,
        };

        for (d.text) |c| {
            const line = char_to_line.items[c - 1];
            try result.append(arena, .{
                .kind = kind,
                .text = try arena.dupe(u8, line),
            });
        }
    }

    return result.toOwnedSlice(arena);
}

fn expect_diff_lines(result: []const DiffLine, expected: []const DiffLine) !void {
    try std.testing.expectEqual(expected.len, result.len);
    for (result, expected) |actual, exp| {
        try std.testing.expectEqual(exp.kind, actual.kind);
        try std.testing.expectEqualStrings(exp.text, actual.text);
    }
}

test "remove non-exhaustive marker from enum" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old =
        \\const Enum = enum {
        \\    value_a,
        \\    value_b,
        \\    _,
        \\};
    ;
    const new =
        \\const Enum = enum {
        \\    value_a,
        \\    value_b,
        \\};
    ;

    const result = try compute_line_diff(allocator, old, new);

    try expect_diff_lines(result, &.{
        .{ .kind = .context, .text = "const Enum = enum {" },
        .{ .kind = .context, .text = "    value_a," },
        .{ .kind = .context, .text = "    value_b," },
        .{ .kind = .removed, .text = "    _," },
        .{ .kind = .context, .text = "};" },
    });
}

test "add line to content" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old =
        \\line1
        \\line2
    ;
    const new =
        \\line1
        \\line2
        \\line3
    ;

    const result = try compute_line_diff(allocator, old, new);

    try expect_diff_lines(result, &.{
        .{ .kind = .context, .text = "line1" },
        .{ .kind = .context, .text = "line2" },
        .{ .kind = .added, .text = "line3" },
    });
}

test "modify line in content" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old =
        \\line1
        \\old_line
        \\line3
    ;
    const new =
        \\line1
        \\new_line
        \\line3
    ;

    const result = try compute_line_diff(allocator, old, new);

    try expect_diff_lines(result, &.{
        .{ .kind = .context, .text = "line1" },
        .{ .kind = .removed, .text = "old_line" },
        .{ .kind = .added, .text = "new_line" },
        .{ .kind = .context, .text = "line3" },
    });
}

test "identical content produces all context lines" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const content =
        \\line1
        \\line2
        \\line3
    ;

    const result = try compute_line_diff(allocator, content, content);

    try expect_diff_lines(result, &.{
        .{ .kind = .context, .text = "line1" },
        .{ .kind = .context, .text = "line2" },
        .{ .kind = .context, .text = "line3" },
    });
}

test "empty old content shows all lines as added" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old = "";
    const new =
        \\line1
        \\line2
    ;

    const result = try compute_line_diff(allocator, old, new);

    try expect_diff_lines(result, &.{
        .{ .kind = .removed, .text = "" },
        .{ .kind = .added, .text = "line1" },
        .{ .kind = .added, .text = "line2" },
    });
}

test "empty new content shows all lines as removed" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old =
        \\line1
        \\line2
    ;
    const new = "";

    const result = try compute_line_diff(allocator, old, new);

    try expect_diff_lines(result, &.{
        .{ .kind = .removed, .text = "line1" },
        .{ .kind = .removed, .text = "line2" },
        .{ .kind = .added, .text = "" },
    });
}

test "duplicate lines are handled correctly" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const old =
        \\a
        \\b
        \\a
        \\b
    ;
    const new =
        \\a
        \\a
        \\b
        \\b
    ;

    const result = try compute_line_diff(allocator, old, new);

    // The exact diff output depends on the diffz algorithm
    // Just verify we get a valid result with the right total lines
    var context_count: usize = 0;
    var added_count: usize = 0;
    var removed_count: usize = 0;

    for (result) |line| {
        switch (line.kind) {
            .context => context_count += 1,
            .added => added_count += 1,
            .removed => removed_count += 1,
        }
    }

    // We should have some context and the added/removed should balance
    try std.testing.expect(context_count > 0);
    try std.testing.expectEqual(added_count, removed_count);
}

// ============================================================================
// ZON serialization tests
// ============================================================================

// Test types that mimic the Patch structure
const TestEnumField = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    value: u32,
};

const TestEnum = struct {
    description: ?[]const u8 = null,
    bitsize: u8,
    fields: []const TestEnumField = &.{},
};

const TestPatch = union(enum) {
    add_type_and_apply: struct {
        parent: []const u8,
        type_name: []const u8,
        type: union(enum) { @"enum": TestEnum },
        apply_to: []const []const u8,
    },
};

test "zon serialize single patch - raw output" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const patch = TestPatch{ .add_type_and_apply = .{
        .parent = "types.peripherals.TEST",
        .type_name = "TestEnum",
        .type = .{ .@"enum" = .{
            .description = null,
            .bitsize = 2,
            .fields = &.{
                .{ .name = "val0", .description = null, .value = 0 },
                .{ .name = "val1", .description = null, .value = 1 },
            },
        } },
        .apply_to = &.{
            "types.peripherals.TEST.REG1.FIELD",
            "types.peripherals.TEST.REG2.FIELD",
        },
    } };

    const patches: []const TestPatch = &.{patch};

    var zon_buf: std.Io.Writer.Allocating = .init(allocator);
    try std.zon.stringify.serialize(patches, .{}, &zon_buf.writer);

    const output = zon_buf.written();
    std.debug.print("\n=== Raw ZON output (single patch) ===\n{s}\n=== End ===\n", .{output});

    // Check that the output contains expected content
    try std.testing.expect(std.mem.indexOf(u8, output, "add_type_and_apply") != null);
    try std.testing.expect(std.mem.indexOf(u8, output, "TestEnum") != null);
}

test "zon serialize multiple patches - raw output" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const patch1 = TestPatch{ .add_type_and_apply = .{
        .parent = "types.peripherals.TEST1",
        .type_name = "Enum1",
        .type = .{ .@"enum" = .{
            .description = null,
            .bitsize = 2,
            .fields = &.{},
        } },
        .apply_to = &.{},
    } };

    const patch2 = TestPatch{ .add_type_and_apply = .{
        .parent = "types.peripherals.TEST2",
        .type_name = "Enum2",
        .type = .{ .@"enum" = .{
            .description = null,
            .bitsize = 2,
            .fields = &.{},
        } },
        .apply_to = &.{},
    } };

    const patches: []const TestPatch = &.{ patch1, patch2 };

    var zon_buf: std.Io.Writer.Allocating = .init(allocator);
    try std.zon.stringify.serialize(patches, .{}, &zon_buf.writer);

    const output = zon_buf.written();
    std.debug.print("\n=== Raw ZON output (multiple patches) ===\n{s}\n=== End ===\n", .{output});

    // Check for problematic patterns
    const has_double_close = std.mem.indexOf(u8, output, "} }") != null;
    const has_inline_open = std.mem.indexOf(u8, output, ".{ .{") != null;
    std.debug.print("Has '}} }}' pattern: {}\n", .{has_double_close});
    std.debug.print("Has '.{{ .{{' pattern: {}\n", .{has_inline_open});
}
