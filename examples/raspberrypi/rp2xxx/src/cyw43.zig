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
var wifi_driver: drivers.WiFi = .{};

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

const log = std.log.scoped(.main);

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // init cyw43
    var wifi = try wifi_driver.init(.{});
    log.debug("mac address: {x}", .{wifi.mac});
    var led = wifi.gpio(0);

    while (true) {
        time.sleep_ms(500);
        led.toggle();
    }
}
