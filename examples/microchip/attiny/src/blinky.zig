const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

// ATtiny85: PB1 is the Digispark onboard LED
const led_pin = gpio.pin(.b, 1);

pub fn main() void {
    led_pin.set_direction(.output);

    while (true) {
        busy_sleep(20_000);
        led_pin.toggle();
    }
}

pub fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be non-negative!");

    comptime var bits = 0;
    inline while ((1 << bits) <= limit) {
        bits += 1;
    }

    const I = std.meta.Int(.unsigned, bits);

    var i: I = 0;
    while (i < limit) : (i += 1) {
        std.mem.doNotOptimizeAway(i);
    }
}
