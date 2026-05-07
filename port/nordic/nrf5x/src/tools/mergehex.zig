const std = @import("std");

pub fn main() !u8 {
    const allocator = std.heap.page_allocator;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 4) {
        std.log.err("usage: nrf5x-mergehex <lower.hex> <upper.hex> <output.hex>", .{});
        return 1;
    }

    try merge_hex_files(allocator, args[1], args[2], args[3]);
    return 0;
}

fn merge_hex_files(allocator: std.mem.Allocator, lower_path: []const u8, upper_path: []const u8, out_path: []const u8) !void {
    const lower_data = try read_file(allocator, lower_path);
    defer allocator.free(lower_data);

    const upper_data = try read_file(allocator, upper_path);
    defer allocator.free(upper_data);

    const out_file = try std.fs.cwd().createFile(out_path, .{});
    defer out_file.close();

    var out_write_buf: [4096]u8 = undefined;
    var writer = out_file.writer(&out_write_buf);

    try write_without_eof(&writer.interface, lower_data);
    const upper_has_eof = try write_all_lines(&writer.interface, upper_data);

    if (!upper_has_eof) {
        try writer.interface.writeAll(":00000001FF\n");
    }

    try writer.interface.flush();
}

fn read_file(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const stat = try file.stat();
    return try file.readToEndAlloc(allocator, stat.size + 1);
}

fn write_without_eof(writer: *std.Io.Writer, data: []const u8) !void {
    var lines = std.mem.splitScalar(u8, data, '\n');
    while (lines.next()) |line_with_cr| {
        const line = std.mem.trimRight(u8, line_with_cr, "\r");
        if (line.len == 0) continue;
        if (std.mem.eql(u8, line, ":00000001FF")) continue;
        try writer.print("{s}\n", .{line});
    }
}

fn write_all_lines(writer: *std.Io.Writer, data: []const u8) !bool {
    var eof_seen = false;
    var lines = std.mem.splitScalar(u8, data, '\n');

    while (lines.next()) |line_with_cr| {
        const line = std.mem.trimRight(u8, line_with_cr, "\r");
        if (line.len == 0) continue;

        if (std.mem.eql(u8, line, ":00000001FF")) {
            eof_seen = true;
        }

        try writer.print("{s}\n", .{line});
    }

    return eof_seen;
}
