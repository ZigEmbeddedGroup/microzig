//! This example takes periodic samples of the temperature sensor and
//! prints it to the UART using the stdlib logging facility.
const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const adc = rp2040.adc;
const time = rp2040.time;

const uart = rp2040.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub const microzig_options = .{
    .logFn = rp2040.uart.logFn,
};

pub fn main() void {
    adc.apply(.{
        .temp_sensor_enabled = true,
    });

    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2040.clock_config,
    });

    rp2040.uart.init_logger(uart);
    while (true) : (time.sleep_ms(1000)) {
        const sample = adc.convert_one_shot_blocking(.temp_sensor) catch {
            std.log.err("conversion failed!", .{});
            continue;
        };

        std.log.info("temp value: {}", .{sample});
    }
}
