const std = @import("std");

const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const multicore = rp2xxx.multicore;

const led = gpio.num(7);

fn core1() void {
    while (true) {
        led.put(1);
        time.sleep_ms(100);
        led.put(0);
        time.sleep_ms(100);
    }
}

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);

    // Blink a few time on core0
    led.put(1);
    time.sleep_ms(250);
    led.put(0);
    time.sleep_ms(250);

    multicore.launch_core1(core1);

    while (true) {
        microzig.cpu.wfi();
    }
}
