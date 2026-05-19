const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const clock_frequencies = .{
    .cpu = 8_000_000,
};

pub const led_pin = gpio.pin(.b, 1);

pub const pin_map = .{
    .P0 = "PB0",
    .P1 = "PB1",
    .P2 = "PB2",
    .P3 = "PB3",
    .P4 = "PB4",
    // Built-in LED on P1 (PB1)
    .LED = "PB1",
};
