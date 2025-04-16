const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const clocks = rp2xxx.clocks;
const Pin = rp2xxx.gpio.Pin;

const gpout0_pin = gpio.num(21);

pub fn main() !void {
    // Don't forget to bring a blinky!
    const led_gpio = rp2xxx.gpio.num(25);
    led_gpio.set_direction(.out);
    led_gpio.set_function(.sio);
    led_gpio.put(1);

    // Use the output_to_gpio() preset helper to create a clock config that will mux out a clock to GPOUT0
    const gpio_clk_cfg = comptime clocks.config.preset.output_to_gpio(
        .{
            // We only want to set GPOUT0
            .gpout0 = .{
                // Mux out the SYS clock
                .source = .clk_sys,
                // Divide the 125 MHz clock by 1000 to get a 125 KHz clock on the GPIO
                .integer_divisor = 1000,
            },
        },
        rp2xxx.clock_config,
    );

    // Apply configuration
    gpio_clk_cfg.apply();

    // Swap GP21 to use GPOUT0 clock
    gpout0_pin.set_function(.gpck);
    while (true) {
        led_gpio.toggle();
        time.sleep_ms(1000);
    }
}
