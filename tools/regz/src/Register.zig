const std = @import("std");

name: []const u8,
description: ?[]const u8 = null,
addr_offset: usize,
size: ?usize = null,
access: ?@import("svd.zig").Access = null,
reset_value: ?u64 = null,
reset_mask: ?u64 = null,

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
