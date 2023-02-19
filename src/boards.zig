const std = @import("std");
const microzig = @import("../deps/microzig/src/main.zig");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

const board_path = std.fmt.comptimePrint("{s}/boards/raspberry_pi_pico.zig", .{root_dir()});

pub const raspberry_pi_pico = microzig.Board{
    .name = "Raspberry Pi Pico",
    .source = .{ .path = board_path },
    .chip = chips.rp2040,
};
