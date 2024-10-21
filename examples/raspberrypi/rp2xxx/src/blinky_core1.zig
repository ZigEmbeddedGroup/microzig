const std = @import("std");

const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const multicore = rp2xxx.multicore;

const led = gpio.num(25);

fn core1() void {
    while (true) {
        led.put(1);
        time.sleep_ms(250);
        led.put(0);
        time.sleep_ms(250);
    }
}

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    multicore.launch_core1(core1);

    while (true) {
        microzig.cpu.wfi();
    }
}
