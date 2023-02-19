const std = @import("std");

const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const time = rp2040.time;
const multicore = rp2040.multicore;

const led = 25;

fn core1() void {
    while (true) {
        gpio.put(led, 1);
        time.sleep_ms(250);
        gpio.put(led, 0);
        time.sleep_ms(250);
    }
}

pub fn main() !void {
    gpio.init(led);
    gpio.set_direction(led, .out);

    multicore.launch_core1(core1);

    while (true) {
        microzig.cpu.wfi();
    }
}
