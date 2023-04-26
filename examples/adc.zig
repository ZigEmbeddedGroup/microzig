//! This example takes periodic samples of the temperature sensor and
//! prints it to the UART using the stdlib logging facility.
const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const adc = rp2040.adc;
const time = rp2040.time;

const temp_sensor: adc.Input = .temperature_sensor;
const uart = rp2040.uart.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub const std_options = struct {
    pub const logFn = rp2040.uart.log;
};

pub fn main() void {
    uart.apply(.{
        .baud_rate = baud_rate,
        .tx_pin = uart_tx_pin,
        .rx_pin = uart_rx_pin,
        .clock_config = rp2040.clock_config,
    });

    rp2040.uart.init_logger(uart);

    while (true) : (time.sleep_ms(1000)) {
        const sample = temp_sensor.read();
        std.log.info("temp value: {}", .{sample});
    }
}
