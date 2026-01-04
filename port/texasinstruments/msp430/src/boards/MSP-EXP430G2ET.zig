const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const rgb_led = gpio.mask(2, 0x2C);

// User LEDs, not part of RGB LED
pub const green_led = gpio.num(1, 0);
pub const red_led = gpio.num(1, 6);
