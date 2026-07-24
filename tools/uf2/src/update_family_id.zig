const std = @import("std");

const FamilyEntry = struct {
    id: []const u8,
    short_name: []const u8,
    description: []const u8,
};

pub fn main(init: std.process.Init) !void {
    // var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // defer arena.deinit();
    // const allocator = arena.allocator();

    //const args = try std.process.argsAlloc(allocator);
    const io = init.io;
    var area = init.arena;
    defer area.deinit();
    const allocator = area.allocator();
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    if (args.len != 3) return error.UsageError;

    const json_data = try std.Io.Dir.cwd().readFileAlloc(io, args[1], allocator, .limited(100_000));

    const output_file = try std.Io.Dir.cwd().createFile(io, args[2], .{});
    defer output_file.close(io);
    var output_file_writer = output_file.writer(io,&.{});

    const entries = try std.json.parseFromSliceLeaky([]FamilyEntry, allocator, json_data, .{});

    try output_file_writer.interface.writeAll("pub const FamilyId = enum(u32) {\n");
    for (entries) |entry| {
        try output_file_writer.interface.print(
            \\    {f} = {s},
            \\
        , .{ std.zig.fmtId(entry.short_name), entry.id });
    }
    try output_file_writer.interface.writeAll("    _,\n};\n");
}
