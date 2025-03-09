const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;
const time = rp2xxx.time;
const regs = microzig.chip.registers;
const multicore = rp2xxx.multicore;

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO25 = .{ .name = "led", .function = .PWM4_B },
};

const pins = pin_config.pins();

pub fn main() !void {
    pin_config.apply();
    pins.led.slice().set_wrap(100);
    pins.led.slice().enable();

    while (true) {
        for (0..101) |level| {
            pins.led.set_level(@truncate(level));
            time.sleep_ms(10);
        }
        for (1..100) |level| {
            pins.led.set_level(@truncate(100 - level));
            time.sleep_ms(10);
        }
    }
}
