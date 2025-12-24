const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const cyw43 = rp2xxx.cyw43;

const Wifi = cyw43.Wifi;
const Security = cyw43.Security;
const Runner = cyw43.Runner;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.log,
};

// WiFi credentials - change these for your network
const WIFI_SSID = "YOUR_SSID";
const WIFI_PASSWORD = "YOUR_PASSWORD";
const WIFI_AUTH = Security.wpa2_psk;

pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{ .clock_config = rp2xxx.clock_config });
    rp2xxx.uart.init_logger(uart);

    std.log.info("Initializing CYW43...", .{});

    try cyw43.init();
    const wifi = cyw43.wifi();
    const runner = cyw43.runner();

    try wifi.enable("GB");

    const mac = try wifi.get_mac_address();
    std.log.info("MAC: {x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}", .{
        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
    });

    std.log.info("Connecting to '{s}'...", .{WIFI_SSID});
    try wifi.join(WIFI_SSID, WIFI_PASSWORD, WIFI_AUTH);

    var attempts: u32 = 0;
    while (attempts < 100) : (attempts += 1) {
        _ = runner.run();
        if (wifi.is_connected()) break;
        time.sleep_ms(100);
    }

    if (!wifi.is_connected()) {
        std.log.err("Connection timeout!", .{});
        return;
    }

    std.log.info("Connected!", .{});
    std.log.info("Listening for ethernet frames...", .{});

    // Main loop - poll and receive frames
    while (true) {
        _ = runner.run();
        if (runner.get_rx_frame()) |frame| {
            // Handle ethernet frame here
            std.log.info("Frame: {} bytes", .{frame.len});
        }
    }
}
