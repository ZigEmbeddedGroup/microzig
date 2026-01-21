const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(allocator);
    if (args.len < 2) {
        std.log.err("usage: ./cat [src_file ...] dst_file", .{});
        return error.InvalidArguments;
    }

    const output_file = try std.Io.Dir.createFileAbsolute(io, args[args.len - 1], .{});
    defer output_file.close(io);
    var output_file_buf: [4096]u8 = undefined;
    var output_file_writer = output_file.writer(io, &output_file_buf);

    for (args[1 .. args.len - 1]) |arg| {
        const file = try std.Io.Dir.openFileAbsolute(io, arg, .{});
        defer file.close(io);
        var file_reader = file.reader(io, &.{});
        _ = try output_file_writer.interface.sendFileAll(&file_reader, .unlimited);
    }
}
