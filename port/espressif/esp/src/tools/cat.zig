const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len < 2) {
        std.log.err("usage: ./cat [src_file ...] dst_file", .{});
        return error.InvalidArguments;
    }

    const src_paths = args[1 .. args.len - 1];
    const dst_path = args[args.len - 1];

    const output_file = try std.Io.Dir.cwd().createFile(io, dst_path, .{});
    defer output_file.close(io);

    var write_buf: [1024 * 1024]u8 = undefined;
    var file_writer = output_file.writer(io, &write_buf);
    const writer = &file_writer.interface;
    for (src_paths) |src_path| {
        const file = try std.Io.Dir.openFileAbsolute(io, src_path, .{ .mode = .read_only });
        defer file.close(io);

        var read_buf: [1024 * 1024]u8 = undefined;
        var reader = file.reader(io, &read_buf);

        _ = try reader.interface.streamRemaining(writer);
    }

    try writer.flush();
}
