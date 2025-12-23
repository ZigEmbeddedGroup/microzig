const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const cyw43 = rp2xxx.cyw43;

const Wifi = cyw43.Wifi;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{ .clock_config = rp2xxx.clock_config });
    rp2xxx.uart.init_logger(uart);

    std.log.info("Initializing CYW43...", .{});

    try cyw43.init();
    const wifi = cyw43.wifi();
    try wifi.enable("GB");

    const mac = try wifi.get_mac_address();
    std.log.info("MAC: {x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}:{x:0>2}", .{
        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
    });

    std.log.info("Scanning for WiFi networks...", .{});

    var results_buf: [64]Wifi.BSS_Info = undefined;
    const results = try wifi.scan(.{
        .active_time = 200,
        .nprobes = 6,
    }, &.{}, &results_buf);

    std.log.info("Found {} networks ({} total seen, {} stored)", .{
        results.bsss.len,
        results.seen,
        results.bsss.len,
    });

    for (results.bsss, 0..) |ap, i| {
        const ssid = ap.ssid[0..ap.ssid_len];
        std.log.info("{d}: SSID='{s}' RSSI={d}dBm CH={d}", .{
            i,
            ssid,
            ap.rssi,
            ap.channel,
        });
    }

    std.log.info("Scan complete.", .{});
}
