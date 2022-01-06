const chips = @import("chips.zig");

const Chip = chips.Chip;
pub const Board = struct {
    name: []const u8,
    path: []const u8,
    chip: Chip,
};

pub const arduino_nano = Board{
    .name = "Arduino Nano",
    .path = "src/modules/boards/arduino-nano/arduino-nano.zig",
    .chip = chips.atmega328p,
};

pub const mbed_lpc1768 = Board{
    .name = "mbed LPC1768",
    .path = "src/modules/boards/mbed-lpc1768/mbed-lpc1768.zig",
    .chip = chips.lpc1768,
};
