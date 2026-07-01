const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const led_pin = gpio.pin(.b, 1);
