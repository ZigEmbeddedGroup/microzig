const std = @import("std");
const isa = @embedFile("isa.txt");
const aviron = @import("aviron");
const Opcode = aviron.isa.Opcode;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var out = try std.fs.cwd().createFile("src/tables.zig", .{});
    defer out.close();

    var buf = std.ArrayList(u8).init(allocator);
    defer buf.deinit();

    const writer = buf.writer();

    var lut = [_]Opcode{.unknown} ** (std.math.maxInt(u16) + 1);

    var base_number_bit_set = std.bit_set.IntegerBitSet(16).initEmpty();
    var unknown_indices = try std.BoundedArray(u8, 16).init(0);
    var unknown_indices_bit_set = std.bit_set.IntegerBitSet(16).initEmpty();
    var result_bit_set = std.bit_set.IntegerBitSet(16).initEmpty();

    var positionals = std.enums.EnumArray(Opcode, std.AutoArrayHashMapUnmanaged(u8, std.BoundedArray(u8, 16))).initFill(.{});
    defer for (&positionals.values) |*map| {
        map.deinit(allocator);
    };

    var lit = std.mem.split(u8, isa, "\n");
    while (lit.next()) |line| {
        var pit = std.mem.split(u8, line, " ");

        const opcode = std.meta.stringToEnum(Opcode, pit.next().?).?;

        base_number_bit_set.mask = 0;
        try unknown_indices.resize(0);

        var index: usize = 0;
        for (pit.rest()) |r| {
            if (r == ' ')
                continue;
            if (index >= 16)
                break;

            switch (r) {
                '0' => {},
                '1' => base_number_bit_set.set(index),
                else => {
                    var gop = try positionals.getPtr(opcode).getOrPut(allocator, r);
                    if (!gop.found_existing) gop.value_ptr.* = try std.BoundedArray(u8, 16).init(0);
                    try gop.value_ptr.*.append(@intCast(index));

                    try unknown_indices.append(@intCast(index));
                },
            }

            index += 1;
        }

        const max_int = (try std.math.powi(usize, 2, unknown_indices.len)) - 1;
        index = 0;
        while (index <= max_int) : (index += 1) {
            unknown_indices_bit_set.mask = @intCast(index);
            result_bit_set.mask = base_number_bit_set.mask;

            for (unknown_indices.slice(), 0..) |v, i| {
                result_bit_set.setValue(v, unknown_indices_bit_set.isSet(i));
            }

            const result = @bitReverse(result_bit_set.mask);

            if (lut[result] != .unknown) {
                std.log.err("Overlap ({b}): {s} vs {s}", .{ result, @tagName(lut[result]), @tagName(opcode) });
                return;
            }
            lut[result] = opcode;
        }
    }

    try writer.writeAll("const Opcode = @import(\"isa.zig\").Opcode;\n\npub const lookup = [_]Opcode{");

    for (lut, 0..) |v, i| {
        try writer.print(".{s},", .{std.zig.fmtId(@tagName(v))});
        if ((i + 1) % 16 == 0) {
            try writer.print("\n", .{});
        }
    }

    try writer.writeAll("};\n\npub const positionals = .{");

    for (positionals.values, 0..) |map, i| {
        try writer.writeAll(".{");
        var it = map.iterator();
        while (it.next()) |entry| {
            try writer.print(".{{'{c}', .{{", .{entry.key_ptr.*});

            const slice = entry.value_ptr.*.slice();
            for (slice, 0..) |val, ii| {
                try writer.print("{d}", .{val});
                if (ii != slice.len - 1) {
                    try writer.writeAll(",");
                }
            }

            try writer.writeAll("}}");

            if (it.index != it.len) {
                try writer.writeAll(",");
            }
        }
        try writer.writeAll("},");
        if ((i + 1) % 16 == 0) {
            try writer.print("\n", .{});
        }
    }

    try writer.writeAll("};");

    var txt = try buf.toOwnedSliceSentinel(0);
    defer allocator.free(txt);

    var tree = try std.zig.Ast.parse(allocator, txt, .zig);
    defer tree.deinit(allocator);

    if (tree.errors.len != 0) {
        for (tree.errors) |err| {
            try tree.renderError(err, std.io.getStdErr().writer());
        }
        try out.writer().writeAll(txt);
    } else {
        const render_result = try tree.render(allocator);
        defer allocator.free(render_result);

        try out.writer().writeAll(render_result);
    }
}
