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
    const led = gpio.num(0, 24);
    led.set_direction(.out);

    while (true) {
        // Turn LED on (active low)
        led.put(0);
        delay(2000000);

        // Turn LED off
        led.put(1);
        delay(2000000);
    }
}
