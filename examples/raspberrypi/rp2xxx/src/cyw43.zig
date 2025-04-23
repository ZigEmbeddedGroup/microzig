//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico W and Pico 2 W
//! Driver code based on: https://github.com/embassy-rs/embassy/tree/main/cyw43
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;

const drivers = microzig.hal.drivers;
const CYW43_Pio_Device = drivers.CYW43_Pio_Device;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    var cyw43: CYW43_Pio_Device = .{};
    try cyw43.init(pio.num(0), gpio.num(25), gpio.num(24), gpio.num(29), gpio.num(23));

    cyw43.test_loop();
}
