const std = @import("std");
const chips = @import("chips.zig");
const Board = @import("Board.zig");

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const root_path = root() ++ "/";

pub const arduino_nano = Board{
    .name = "Arduino Nano",
    .path = root_path ++ "boards/arduino-nano/arduino-nano.zig",
    .chip = chips.atmega328p,
};

pub const mbed_lpc1768 = Board{
    .name = "mbed LPC1768",
    .path = root_path ++ "boards/mbed-lpc1768/mbed-lpc1768.zig",
    .chip = chips.lpc1768,
};
