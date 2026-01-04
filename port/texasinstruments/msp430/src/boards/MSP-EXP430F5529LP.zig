const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const green_led = gpio.num(4, 7);

// TODO: determine the color
pub const other_led = gpio.num(1, 0);
