const std = @import("std");
const diffz = @import("diffz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

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

    std.debug.print("=== OLD ===\n{s}\n", .{old});
    std.debug.print("=== NEW ===\n{s}\n", .{new});

    const result = try compute_line_diff(allocator, old, new);
    defer {
        for (result) |line| allocator.free(line.text);
        allocator.free(result);
    }

    std.debug.print("\n=== DIFF RESULT ({d} lines) ===\n", .{result.len});
    for (result) |line| {
        const prefix: u8 = switch (line.kind) {
            .context => ' ',
            .added => '+',
            .removed => '-',
        };
        std.debug.print("{c}{s}\n", .{ prefix, line.text });
    }
}

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

    std.debug.print("\nOld has {d} lines, New has {d} lines\n", .{ old_lines.items.len, new_lines.items.len });

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

    std.debug.print("Old chars: ", .{});
    for (old_chars.items) |c| std.debug.print("{d} ", .{c});
    std.debug.print("\nNew chars: ", .{});
    for (new_chars.items) |c| std.debug.print("{d} ", .{c});
    std.debug.print("\n", .{});

    std.debug.print("Char to line mapping:\n", .{});
    for (char_to_line.items, 0..) |line, i| {
        std.debug.print("  {d}: '{s}'\n", .{ i + 1, line });
    }

    // Run diffz on the encoded character sequences
    const dmp: diffz = .{ .diff_timeout = 0 };
    const diffs = dmp.diff(arena, old_chars.items, new_chars.items, false) catch {
        std.debug.print("diffz failed!\n", .{});
        return result.toOwnedSlice(arena);
    };

    std.debug.print("\nDiffz returned {d} chunks:\n", .{diffs.items.len});
    for (diffs.items) |d| {
        std.debug.print("  op={s} text_len={d} bytes: ", .{ @tagName(d.operation), d.text.len });
        for (d.text) |c| std.debug.print("{d} ", .{c});
        std.debug.print("\n", .{});
    }

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
