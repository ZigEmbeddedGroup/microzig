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
                else => try unknown_indices.append(@as(u8, @intCast(index))),
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

    _ = @divExact(lut.len, 8);

    try writer.writeAll("const Opcode = @import(\"isa.zig\").Opcode;\n\npub const lookup = [_]Opcode{");

    for (lut, 0..) |v, i| {
        try writer.print(".{s},", .{std.zig.fmtId(@tagName(v))});
        if ((i + 1) % 16 == 0) {
            try writer.print("\n", .{});
        }
    }

    try writer.writeAll("};");

    var tree = try std.zig.Ast.parse(allocator, try buf.toOwnedSliceSentinel(0), .zig);
    defer tree.deinit(allocator);

    const render_result = try tree.render(allocator);
    defer allocator.free(render_result);

    try out.writer().writeAll(render_result);
}
