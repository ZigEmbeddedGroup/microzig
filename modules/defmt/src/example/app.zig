const std = @import("std");
const defmt = @import("defmt");

pub const std_options: std.Options = .{
    .logFn = log_fn,
};

fn log_fn(comptime level: std.log.Level, comptime scope: @EnumLiteral(), comptime fmt: []const u8, args: anytype) void {
    _ = scope;

    defmt.print(&stdout.interface, "[" ++ level.asText() ++ "] " ++ fmt, args) catch unreachable;
    stdout.interface.flush() catch unreachable;
}

var stdout: std.Io.File.Writer = undefined;

pub fn main(init: std.process.Init) void {
    stdout = std.Io.File.stdout().writer(init.io, &.{});
    std.log.info("hello world", .{});
}
