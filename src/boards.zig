const std = @import("std");
const microzig = @import("../deps/microzig/src/main.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
