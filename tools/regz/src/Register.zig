const std = @import("std");

name: []const u8,
description: ?[]const u8,
addr_offset: usize,
size: ?usize,
access: ?@import("svd.zig").Access,
reset_value: ?u64,
reset_mask: ?u64,

pub fn format(
    register: @This(),
    comptime fmt: []const u8,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = fmt;
    _ = options;
    try writer.print("0x{x} -> {s}: size={}, {s}", .{
        register.addr_offset,
        register.name,
        register.size,
        register.description,
    });
}
