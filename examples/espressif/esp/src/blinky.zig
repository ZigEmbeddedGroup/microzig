const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const gpio = microzig.hal.gpio;
const uart = microzig.hal.uart;

pub fn main() !void {
    const pin_config = gpio.Pin.Config{
        .output_enable = true,
        .drive_strength = gpio.DriveStrength.@"40mA",
    };

    const led_r_pin = gpio.instance.GPIO3;
    const led_g_pin = gpio.instance.GPIO4;
    const led_b_pin = gpio.instance.GPIO5;

    led_r_pin.apply(pin_config);
    led_g_pin.apply(pin_config);
    led_b_pin.apply(pin_config);

    uart.write(0, "Hello from Zig!\r\n");

    while (true) {
        led_r_pin.write(gpio.Level.high);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.low);
        uart.write(0, "R");
        microzig.hal.rom.delay_us(500_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.high);
        led_b_pin.write(gpio.Level.low);
        uart.write(0, "G");
        microzig.hal.rom.delay_us(500_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.high);
        uart.write(0, "B");
        microzig.hal.rom.delay_us(500_000);
    }
}
