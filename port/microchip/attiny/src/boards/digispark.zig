const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const clock_frequencies = .{
    .cpu = 16_500_000,
};

pub const led_pin = gpio.pin(.b, 1);
