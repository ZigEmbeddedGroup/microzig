//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const log = std.log.scoped(.main);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

var wifi_interface: drivers.WiFi = .{};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    try wifi_interface.init(.{});
    var wifi = &wifi_interface.driver;

    const mac = try wifi.read_mac();
    log.debug("mac address: {x}", .{mac});

    try wifi.join("ninazara", "PeroZdero1");
    try wifi.show_clm_ver();

    while (true) {
        time.sleep_ms(500);
        wifi.led_toggle();
    }

    rp2xxx.rom.reset_to_usb_boot();
}
