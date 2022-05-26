name: []const u8,
description: ?[]const u8 = null,
offset: u8,
width: u8,
access: ?@import("svd.zig").Access = null,

pub fn lessThan(_: void, lhs: @This(), rhs: @This()) bool {
    return if (lhs.offset == rhs.offset)
        lhs.width < rhs.width
    else
        lhs.offset < rhs.offset;
}
