const std = @import("std");

name: []const u8,
version: ?[]const u8,
description: ?[]const u8,
base_addr: ?usize,

pub fn format(
    peripheral: @This(),
    comptime fmt: []const u8,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = fmt;
    _ = options;
    try writer.print("{s}: {s}", .{
        peripheral.name,
        peripheral.description,
    });
}
