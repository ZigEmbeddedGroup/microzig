const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const xt1_freq_hz = 32_768;
pub const xt2_freq_hz = 4_000_000;

pub const rgb_led = gpio.mask(2, 0x2C);

// User LEDs, not part of RGB LED
pub const green_led = gpio.num(1, 0);
pub const red_led = gpio.num(1, 6);
