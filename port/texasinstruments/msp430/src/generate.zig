const std = @import("std");
const regz = @import("regz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2)
        return error.InvalidArgs;

    const package_path = args[1];

    std.log.info("package path: {s}", .{package_path});
    var package_dir = try std.fs.cwd().openDir(package_path, .{});
    defer package_dir.close();

    const chips_file = try std.fs.cwd().createFile("src/Chips.zig", .{});
    defer chips_file.close();

    var buf: [4096]u8 = undefined;
    var writer = chips_file.writer(&buf);
    try generate_chips_file(allocator, &writer.interface);
}

fn generate_chips_file(
    allocator: std.mem.Allocator,
    writer: *std.Io.Writer,
) !void {
    _ = allocator;
    _ = writer;

    // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/839
    // Implement Chips.zig generation for MSP430
    @panic("TODO");
}
