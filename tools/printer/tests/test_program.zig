const std = @import("std");

pub const std_options: std.Options = .{
    .log_level = .debug,
};

pub fn main() !void {
    std.debug.print("Hello world!", .{});

    std.debug.print("Hello world!", .{});

    std.debug.print("Hello world!", .{});
}
