const std = @import("std");

const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const board = microzig.board;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const multicore = rp2xxx.multicore;

const pins = board.pin_config.pins();

fn core1() void {
    while (true) {
        pins.led.put(1);
        time.sleep_ms(100);
        pins.led.put(0);
        time.sleep_ms(100);
    }
}

pub fn main() !void {
    _ = board.pin_config.apply();

    // Blink a few time on core0
    pins.led.put(1);
    time.sleep_ms(250);
    pins.led.put(0);
    time.sleep_ms(250);

    multicore.launch_core1(core1);

    while (true) {
        microzig.cpu.wfi();
    }
}
