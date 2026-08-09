const std = @import("std");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
