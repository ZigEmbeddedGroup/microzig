const std = @import("std");

fn root_dir() []const u8 {
    return std.Io.Dir.path.dirname(@src().file) orelse ".";
}
