const std = @import("std");
const microzig = @import("microzig");

const esp = microzig.hal;
const time = esp.time;
const gpio = esp.gpio;

pub fn main() !void {
    var input_pin = gpio.num(0);
    input_pin.apply(.{
        .input_enable = true,
    });

    var led_pin = gpio.num(8);
    led_pin.apply(.{
        .output_enable = true,
    });

    while (true) {
        led_pin.put(input_pin.read());
    }
}
