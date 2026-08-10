const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const clock_frequencies = .{
    .cpu = 8_000_000,
};

pub const led_pin = gpio.pin(.b, 1);
