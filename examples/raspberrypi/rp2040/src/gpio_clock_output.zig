const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const GlobalConfig = clocks.config.Global;
const Pin = rp2040.gpio.Pin;

const gpout0_pin = gpio.num(21);

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
        rp2040.clock_config,
    );

    // Apply configuration
    gpio_clk_cfg.apply();

    // Swap GP21 to use GPOUT0 clock
    gpout0_pin.set_function(.gpck);
    while (true) {
        blinkLed(&led_gpio);
    }
}
