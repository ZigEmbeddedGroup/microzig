const std = @import("std");

const FamilyEntry = struct {
    id: []const u8,
    short_name: []const u8,
    description: []const u8,
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    defer arena.deinit();

    const json_file = try std.fs.cwd().openFile("deps/uf2/utils/uf2families.json", .{});
    defer json_file.close();

    const text = try json_file.readToEndAlloc(allocator, std.math.maxInt(usize));
    var stream = std.json.TokenStream.init(text);
    const entries = try std.json.parse([]FamilyEntry, &stream, .{
        .allocator = allocator,
    });

    const writer = std.io.getStdOut().writer();

    try writer.writeAll("pub const FamilyId = enum(u32) {\n");

    for (entries) |entry|
        try writer.print(
            \\    {s} = {s},
            \\
        , .{ entry.short_name, entry.id });

    try writer.writeAll("    _,\n};\n");
}
