const std = @import("std");
const micro = @import("../deps/microzig/build.zig");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const longan_nano = micro.Board{
    .name = "Longan Nano",
    .source = .{ .path = root_dir() ++ "/boards/longan_nano.zig" },
    .chip = chips.gd32vf103xb,
};
