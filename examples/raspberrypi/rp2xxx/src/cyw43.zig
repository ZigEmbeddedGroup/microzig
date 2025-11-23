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
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    const cyw43_config = drivers.CYW43_Pio_Device_Config{
        .spi = .{
            .pio = pio.num(0),
            .cs_pin = gpio.num(25),
            .io_pin = gpio.num(24),
            .clk_pin = gpio.num(29),
        },
        .pwr_pin = gpio.num(23),
    };
    var cyw43: CYW43_Pio_Device = .{};
    try cyw43.init(cyw43_config);

    // The driver isn't finished yet, so we're using this infinite test loop to process all internal driver events.
    // Eventually, this will be replaced by a dedicated driver task/thread.
    cyw43.test_loop();
}
