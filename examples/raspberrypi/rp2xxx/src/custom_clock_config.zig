const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const clocks = rp2xxx.clocks;
const GlobalConfig = clocks.config.Global;
const gpout0_pin = gpio.num(21);
const Pin = gpio.Pin;

/// The HAL provides a convenvience function for detecting which of the RP2XXX
/// family you're currently compiling for.
const chip = rp2xxx.compatibility.chip;

const xosc_freq = microzig.board.xosc_freq;

/// Define an entirely custom clock configuration for the system
/// that changes which clocks are driven from where.
///
/// NOTE: It is very easy to create bogus clock configurations that don't
///       drive the peripheral blocks correctly (or at all) so make sure
///       you know what you're doing if you use this low level interface!
const system_clock_cfg: GlobalConfig = val: {
    var temp: GlobalConfig = .{

        // Divide our reference clock by 2 to be 6 MHz for fun
        .ref = .{
            .input = .{
                .source = .src_xosc,
                .freq = xosc_freq,
            },
            .integer_divisor = 2,
        },

        // Change our PLL frequency to be 100MHz instead
        .pll_sys = .{
            .refdiv = 1,
            .fbdiv = 100,
            .postdiv1 = 6,
            .postdiv2 = 2,
        },

        // Drive SYS off the PLL_SYS
        .sys = .{
            .input = .{
                .source = .pll_sys,
                .freq = 100_000_000,
            },
            .integer_divisor = 1,
        },

        // ADC and USB peripherals have to run off 48MHz clock, so these are unchanged
        .pll_usb = .{
            .refdiv = 1,
            .fbdiv = 40,
            .postdiv1 = 5,
            .postdiv2 = 2,
        },

        .usb = .{
            .input = .{
                .source = .pll_usb,
                .freq = 48_000_000,
            },
            .integer_divisor = 1,
        },

        .adc = .{
            .input = .{
                .source = .pll_usb,
                .freq = 48_000_000,
            },
            .integer_divisor = 1,
        },

        // Change peri to also run off XOSC, not neccessarily reccomended, but interesting!
        .peri = .{
            .input = .{
                .source = .src_xosc,
                .freq = xosc_freq,
            },
            .integer_divisor = 1,
        },
    };

    // GlobalConfig has a slight difference between RP2350 (has HSTX) and RP2040 (has RTC)
    switch (chip) {
        .RP2040 => {
            // Drive RTC off XOSC / 3 for a change of pace!
            temp.rtc = .{
                .input = .{
                    .source = .src_xosc,
                    .freq = xosc_freq,
                },
                .integer_divisor = 3,
            };
        },
        .RP2350 => {
            // Drive HSTX off SYS
            temp.hstx = .{
                .input = .{
                    .source = .clk_sys,
                    .freq = 100_000_000,
                },
                .integer_divisor = 1,
            };
        },
    }
    break :val temp;
};

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
