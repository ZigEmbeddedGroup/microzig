const std = @import("std");
const micro = @import("microzig");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const arduino_nano = micro.Board{
    .name = "Arduino Nano",
    .source = .{ .path = root_dir() ++ "/boards/arduino_nano.zig" },
    .chip = chips.atmega328p,
};

pub const arduino_uno = micro.Board{
    .name = "Arduino Uno",
    .source = .{ .path = root_dir() ++ "/boards/arduino_uno.zig" },
    .chip = chips.atmega328p,
};
