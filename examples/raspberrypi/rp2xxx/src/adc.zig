//! This example takes periodic samples of the temperature sensor and
//! prints it to the UART using the stdlib logging facility.
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const adc = rp2xxx.adc;
const time = rp2xxx.time;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    adc.apply(.{
        .temp_sensor_enabled = true,
    });

    while (true) : (time.sleep_ms(1000)) {
        const sample = adc.convert_one_shot_blocking(.temp_sensor) catch {
            std.log.err("conversion failed!", .{});
            continue;
        };

        std.log.info("temp value: {}", .{sample});
    }
}
