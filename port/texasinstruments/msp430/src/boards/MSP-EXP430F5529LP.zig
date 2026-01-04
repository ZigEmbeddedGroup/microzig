const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const xt1_freq_hz = 32_768;
pub const xt2_freq_hz = 4_000_000;

pub const green_led = gpio.num(4, 7);
pub const other_led = gpio.num(1, 0);
