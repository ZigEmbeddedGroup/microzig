const std = @import("std");
const microzig = @import("microzig");

const led_pin = microzig.core.experimental.Pin("PB5");

pub fn main() void {
    const led = microzig.core.experimental.gpio.Gpio(led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    while (true) {
        microzig.core.experimental.debug.busy_sleep(20_000);
        led.toggle();
    }
}
