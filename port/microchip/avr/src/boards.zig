const std = @import("std");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}
