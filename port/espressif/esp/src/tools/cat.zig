const std = @import("std");

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();

    const allocator = debug_allocator.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.log.err("usage: ./cat [src_file ...] dst_file", .{});
        return error.InvalidArguments;
    }

    const output_file = try std.fs.createFileAbsolute(args[args.len - 1], .{});
    defer output_file.close();

    for (args[1 .. args.len - 1]) |arg| {
        const file = try std.fs.openFileAbsolute(arg, .{ .mode = .read_only });
        defer file.close();

        const data = try file.readToEndAlloc(allocator, 1_000_000);
        defer allocator.free(data);

        try output_file.writeAll(data);
    }
}
