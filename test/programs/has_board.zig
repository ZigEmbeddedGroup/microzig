const std = @import("std");
const assert = std.debug.assert;
const microzig = @import("microzig");

comptime {
    assert(microzig.config.has_board);
    assert(!microzig.config.has_hal);
}

pub fn main() void {}
