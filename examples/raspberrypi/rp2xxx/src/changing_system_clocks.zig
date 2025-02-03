const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const clocks = rp2xxx.clocks;
const GlobalConfig = clocks.config.Global;
const Pin = rp2xxx.gpio.Pin;

/// The HAL provides a convenvience function for detecting which of the RP2XXX
/// family you're currently compiling for.
const chip = rp2xxx.compatibility.chip;

// Use the system() preset helper to change the SYS and REF clock frequencies from default
const system_clock_cfg = clocks.config.preset.system(
    // Reduce the system clock by a factor of 4 (different default clock speeds for RP2350/RP2040)
    switch (chip) {
        .RP2040 => 125_000_000 / 4,
        .RP2350 => 150_000_000 / 4,
    },
    // Reduce reference clock by a factor of 3
    12_000_000 / 3,
);

// Have to override init() so we can apply our own custom pre-main startup procedure
pub fn init() void {
    // The default init_sequence works fine here, we just want to swap in our own clock config
    rp2xxx.init_sequence(system_clock_cfg);
}

pub fn main() !void {

    // Don't forget to bring a blinky!
    const led_gpio = gpio.num(25);
    led_gpio.set_direction(.out);
    led_gpio.set_function(.sio);
    led_gpio.put(1);

    // See gpio_clock_output.zig for how you could MUX out some of these clocks
    // to GPIOs for oscilloscope confirmation!
    while (true) {
        led_gpio.toggle();
        time.sleep_ms(1000);
    }
}
