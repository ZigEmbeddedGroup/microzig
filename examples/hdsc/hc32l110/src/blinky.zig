const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const time = hal.time;
const clocks = hal.clocks;
const gpio = hal.gpio;

const led = gpio.num(3, 6);

pub fn main() !void {
    clocks.gate.enable(.Gpio);

    led.init(.out);
    led.put(0);

    while (true) {
        time.sleep_ms(250);
        led.toggle();
    }
}
