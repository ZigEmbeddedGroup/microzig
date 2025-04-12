const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const hal = microzig.hal;
const gpio = hal.gpio;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = usb_serial_jtag.logger.logFn,
};

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

    std.log.info("Hello from Zig!", .{});

    while (true) {
        led_r_pin.write(gpio.Level.high);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.low);
        std.log.info("R", .{});
        microzig.hal.rom.delay_us(500_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.high);
        led_b_pin.write(gpio.Level.low);
        std.log.info("G", .{});
        microzig.hal.rom.delay_us(500_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.high);
        std.log.info("B", .{});
        microzig.hal.rom.delay_us(500_000);
    }
}
