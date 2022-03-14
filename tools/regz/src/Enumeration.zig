value: usize,
description: ?[]const u8,

pub fn lessThan(_: void, lhs: @This(), rhs: @This()) bool {
    return lhs.value < rhs.value;
}
