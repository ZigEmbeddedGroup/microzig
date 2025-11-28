//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;
const net = @import("net.zig");

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

    net.init(mac, [4]u8{ 192, 168, 190, 90 });
    net.tx_buffer = wifi.get_tx_buffer();

    try wifi.join("ninazara", "PeroZdero1");
    try wifi.show_clm_ver();

    while (true) {
        //time.sleep_ms(500);
        wifi.led_toggle();
        if (try wifi.data_poll(500)) |data| {
            const n = net.handle(data) catch |err| {
                log.err("net handle {} on data: {x}", .{ err, data });
                continue;
            };
            if (n > 0) try wifi.send(n);
        }
    }

    rp2xxx.rom.reset_to_usb_boot();
}
