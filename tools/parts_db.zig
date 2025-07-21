const std = @import("std");
const MicroZig = @import("build/definitions");

pub const PartsDb = struct {
    chips: []const MicroZig.Chip,
    boards: []const MicroZig.Board,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const output_path = args[1];

    var chips = std.array_list.Managed(MicroZig.Chip).init(allocator);
    var boards = std.array_list.Managed(MicroZig.Board).init(allocator);
    inline for (port) |port| {}

    const json_str = std.json.stringifyAlloc(b.allocator, parts_db, .{}) catch @panic("OOM");

    const output_file = try std.fs.cwd().createFile(output_path, .{});
    defer output_file.close();
}
