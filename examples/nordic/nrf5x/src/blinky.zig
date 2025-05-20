const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

fn delay(cycles: u32) void {
    var i: u32 = 0;
    while (i < cycles) : (i += 1) {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    // Set P0.24 to output (Blue LED)
    const led_r_pin = gpio.num(0, 23);
    const led_g_pin = gpio.num(0, 22);
    const led_b_pin = gpio.num(0, 24);
    inline for (.{ led_r_pin, led_g_pin, led_b_pin }) |pin| {
        pin.set_direction(.out);
    }

    // Start with all LEDs off (active low)
    led_r_pin.put(1);
    led_g_pin.put(1);
    led_b_pin.put(1);
    while (true) {
        led_r_pin.toggle();
        delay(2000000);

        led_r_pin.toggle();
        led_g_pin.toggle();
        delay(2000000);

        led_g_pin.toggle();
        led_b_pin.toggle();
        delay(2000000);
    }
}
