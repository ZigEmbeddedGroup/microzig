const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

const led_pin = gpio.pin(.b, 1);

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .INT0 = &my_int0_handler,
    },
};

fn my_int0_handler() callconv(.avr_signal) void {
    led_pin.toggle();
}

pub fn main() void {
    led_pin.set_direction(.output);

    while (true) {
        std.mem.doNotOptimizeAway({});
    }
}
