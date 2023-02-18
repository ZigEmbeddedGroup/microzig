const std = @import("std");
const micro = @import("../deps/microzig/src/main.zig");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const mbed_lpc1768 = micro.Board{
    .name = "mbed LPC1768",
    .source = .{ .path = root_dir() ++ "/boards/mbed_LPC1768.zig" },
    .chip = chips.lpc176x5x,
};
