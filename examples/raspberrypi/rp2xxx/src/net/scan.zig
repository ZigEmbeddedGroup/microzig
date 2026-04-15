const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = rp2xxx.drivers;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);
pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};
const log = std.log.scoped(.main);

comptime {
    _ = @import("lwip_exports.zig");
}
const net = @import("net");

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // init cyw43
    var wifi_driver: drivers.WiFi = .{};
    var wifi = try wifi_driver.init(.{});
    var led = wifi.gpio(0);

    var ssid_buf: [32]u8 = undefined;
    var ssid: []const u8 = ssid_buf[0..0];

    log.debug("scaning wifi networks", .{});
    var scan = try wifi.scan();
    while (try scan.poll()) {
        if (scan.result()) |res| {
            log.debug(
                "  found ssid: {s:<20}, channel: {}, open: {:<5}, ap mac {x}",
                .{ res.ssid, res.channel, res.security.open(), res.ap_mac },
            );
            if (res.security.open() and ssid.len == 0) {
                ssid_buf = res.ssid_buf;
                ssid = ssid_buf[0..res.ssid.len];
            }
        }
        time.sleep_ms(10);
    }

    if (ssid.len == 0) {
        @panic("no open WiFi network found");
    }

    log.debug("joining to: {s}", .{ssid});
    var join = try wifi.join(ssid, "", .{ .security = .open });
    var ticks: u32 = 0;
    while (try join.poll()) : (ticks +%= 1) {
        if (ticks % 5 == 0) {
            led.toggle();
        }
        time.sleep_ms(10);
    }
    log.debug("join state {}", .{wifi.join_state()});

    // init lwip network interface
    var nic: net.Interface = .{ .link = wifi.link() };
    try nic.init(wifi.mac, .{});

    var join_state = wifi.join_state();
    ticks = 0;
    while (true) : (ticks +%= 1) {
        // run lwip poller
        try nic.poll();
        // blink
        if (ticks % 50 == 0) {
            led.toggle();
        }
        if (join_state != wifi.join_state()) {
            join_state = wifi.join_state();
            log.debug("join state changed {}", .{join_state});
        }
        time.sleep_ms(10);
    }
}
