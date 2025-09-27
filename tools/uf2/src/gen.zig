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

    const uf2families = @embedFile("uf2families");
    const entries = try std.json.parseFromSliceLeaky([]FamilyEntry, allocator, uf2families, .{});

    const family_id_file = try std.fs.cwd().createFile("src/family_id.zig", .{});
    defer family_id_file.close();
    var writer = family_id_file.writer(&.{});

    try writer.interface.writeAll("pub const FamilyId = enum(u32) {\n");
    for (entries) |entry| {
        try writer.interface.print(
            \\    {f} = {s},
            \\
        , .{ std.zig.fmtId(entry.short_name), entry.id });
    }
    try writer.interface.writeAll("    _,\n};\n");
}
