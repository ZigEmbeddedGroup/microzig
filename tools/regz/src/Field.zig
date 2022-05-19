name: []const u8,
description: ?[]const u8,
offset: u8,
width: u8,
access: ?@import("svd.zig").Access,

pub fn lessThan(_: void, lhs: @This(), rhs: @This()) bool {
    return if (lhs.offset == rhs.offset)
        lhs.width < rhs.width
    else
        lhs.offset < rhs.offset;
}
