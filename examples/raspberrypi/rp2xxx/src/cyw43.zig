//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const drivers = microzig.hal.drivers;

const Net = @import("lwip.zig");
comptime {
    _ = @import("lwip_exports.zig");
}
const Udp = Net.Udp;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

const log = std.log.scoped(.main);

var wifi_driver: drivers.WiFi = .{};
var net: Net = undefined;
var udp: Udp = .{};

const secrets = @import("secrets.zig");

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart_rx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // init cyw43
    var wifi = try wifi_driver.init(.{});
    log.debug("mac address: {x}", .{wifi.mac});
    var led = wifi.gpio(0);
    // join network
    try wifi.join(secrets.ssid, secrets.pwd);
    log.debug("wifi joined", .{});

    // init lwip
    net = .{
        .mac = wifi.mac,
        .link = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
            .ready = drivers.WiFi.ready,
        },
    };
    try net.init();

    // wait for lwip dhcp
    while (!net.ready()) {
        time.sleep_ms(100);
        led.toggle();
        try net.poll();
    }
    log.debug("net ready", .{});

    // send udp packets
    try net.udp_init(&udp, "192.168.190.235", 9999);
    var buf: [128]u8 = @splat('-');
    var i: usize = 0;
    while (true) : (i += 1) {
        time.sleep_ms(500);
        led.toggle();
        try net.poll();

        const msg = try std.fmt.bufPrint(&buf, "hello from pico {}\n", .{i});
        try udp.send(msg);
        check_reboot(); // Check for the reboot code.
    }
}

// Puts pico in bootsel mode by uart command.
fn check_reboot() void {
    const MAGICREBOOTCODE: u8 = 0xAB;
    const v = uart.read_word() catch {
        uart.clear_errors();
        return;
    } orelse return;
    if (v == MAGICREBOOTCODE) {
        std.log.warn("Reboot cmd received", .{});
        rp2xxx.rom.reset_to_usb_boot();
    }
}
