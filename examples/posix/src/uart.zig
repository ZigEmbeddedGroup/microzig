const std = @import("std");
const microzig = @import("microzig");

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = .{
    .log_level = .debug,
    // .logFn = rp2040.uart.log,
};

pub fn main() !void {}
