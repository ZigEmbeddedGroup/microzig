const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const time = rp2040.time;
const regs = microzig.chip.registers;
const multicore = rp2040.multicore;

const pin_config = rp2040.pins.GlobalConfiguration{
    .GPIO25 = .{ .name = "led", .function = .PWM4_B },
};

pub fn main() !void {
    const pins = pin_config.apply();
    pins.led.slice().setWrap(100);
    pins.led.setLevel(10);
    pins.led.slice().enable();

    while (true) {
        time.sleepMs(250);
    }
}
