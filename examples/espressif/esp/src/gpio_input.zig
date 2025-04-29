const std = @import("std");
const microzig = @import("microzig");

const esp = microzig.hal;
const time = esp.time;
const gpio = esp.gpio;

pub fn main() !void {
    var input_pin = gpio.num(0);
    var led_pin = gpio.num(8);
    // TODO: This sets some basic stuff, which seems to be needed, we can't set output on its
    // own
    inline for (&.{ input_pin, led_pin }) |pin| {
        // Give the pin a sane default config
        pin.apply(.{});
    }
    led_pin.set_output_enable(true);
    input_pin.set_input_enable(true);

    while (true) {
        led_pin.write(input_pin.read());
    }
}
