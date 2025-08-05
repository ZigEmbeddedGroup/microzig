const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const hal = microzig.hal;
const gpio = hal.gpio;
const usb_serial_jtag = hal.usb_serial_jtag;
const time = hal.time;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
};

pub fn main() !void {
    const pin_config: gpio.Pin.Config = .{
        .output_enable = true,
        .drive_strength = .@"40mA",
    };

    const led_r_pin = gpio.num(3);
    const led_g_pin = gpio.num(4);
    const led_b_pin = gpio.num(5);

    led_r_pin.apply(pin_config);
    led_g_pin.apply(pin_config);
    led_b_pin.apply(pin_config);

    std.log.info("Hello from Zig!", .{});

    while (true) {
        led_r_pin.write(.high);
        led_g_pin.write(.low);
        led_b_pin.write(.low);
        std.log.info("R", .{});
        time.sleep_ms(500);

        led_r_pin.write(.low);
        led_g_pin.write(.high);
        led_b_pin.write(.low);
        std.log.info("G", .{});
        time.sleep_ms(500);

        led_r_pin.write(.low);
        led_g_pin.write(.low);
        led_b_pin.write(.high);
        std.log.info("B", .{});
        time.sleep_ms(500);
    }
}
