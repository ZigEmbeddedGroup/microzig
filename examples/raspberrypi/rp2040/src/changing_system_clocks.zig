const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const GlobalConfig = clocks.config.Global;
const Pin = rp2040.gpio.Pin;

// Use the system() preset helper to change the SYS and REF clock frequencies from default
const system_clock_cfg = clocks.config.preset.system(
    // Reduce the system clock by a factor of 4
    125_000_000 / 4,
    // Reduce reference clock by a factor of 3
    12_000_000 / 3,
);

// Have to override init() so we can apply our own custom pre-main startup procedure
pub fn init() void {
    // The default init_sequence works fine here, we just want to swap in our own clock config
    rp2040.init_sequence(system_clock_cfg);
}

fn blinkLed(led_gpio: *Pin) void {
    led_gpio.put(0);
    rp2040.time.sleep_ms(500);
    led_gpio.put(1);
    rp2040.time.sleep_ms(500);
}

pub fn main() !void {

    // Don't forget to bring a blinky!
    var led_gpio = rp2040.gpio.num(25);
    led_gpio.set_direction(.out);
    led_gpio.set_function(.sio);
    led_gpio.put(1);

    // See gpio_clock_output.zig for how you could MUX out some of these clocks
    // to GPIOs for oscilloscope confirmation!

    while (true) {
        blinkLed(&led_gpio);
    }
}
