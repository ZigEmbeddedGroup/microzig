//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;
const Net = @import("net.zig").Net;

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

    var net = Net{
        .mac = mac,
        .ip = [4]u8{ 192, 168, 190, 90 },
        .driver = .{
            .tx_buffer = wifi.get_tx_buffer(),
            .ptr = wifi,
            .recv = drivers.WiFi.Driver.recv,
            .send = drivers.WiFi.Driver.send,
        },
    };

    try wifi.join("ninazara", "PeroZdero1");
    try wifi.show_clm_ver();

    while (true) {
        time.sleep_ms(500);
        wifi.led_toggle();
        net.poll(500) catch |err| {
            log.err("net pool {}", .{err});
        };
        const hydra_ip: [4]u8 = .{ 192, 168, 190, 235 };
        const hydra_mac = try net.get_mac(hydra_ip);
        log.debug("hydra mac: {x}", .{hydra_mac[0..6]});
    }

    rp2xxx.rom.reset_to_usb_boot();
}
