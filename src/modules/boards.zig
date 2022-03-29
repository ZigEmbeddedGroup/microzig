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

pub const stm32f3discovery = Board{
    .name = "STM32F3DISCOVERY",
    .path = root_path ++ "boards/stm32f3discovery/stm32f3discovery.zig",
    .chip = chips.stm32f303vc,
};

pub const stm32f4discovery = Board{
    .name = "STM32F4DISCOVERY",
    .path = root_path ++ "boards/stm32f4discovery/stm32f4discovery.zig",
    .chip = chips.stm32f407vg,
};
