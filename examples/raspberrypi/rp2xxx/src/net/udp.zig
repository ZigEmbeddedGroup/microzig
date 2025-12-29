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

const Net = @import("lwip/net.zig");
comptime {
    _ = @import("lwip/exports.zig");
}
const secrets = @import("secrets.zig");

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
    log.debug("mac address: {x}", .{wifi.mac});

    // join network
    try wifi.join(secrets.ssid, secrets.pwd, .{});
    log.debug("wifi joined", .{});

    // init lwip
    var net: Net = .{
        .mac = wifi.mac,
        .link = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
            .ready = drivers.WiFi.ready,
        },
    };
    try net.init();

    var handler: EchoHandler = .{};
    try net.udp_connect(&handler.sender);
    try net.udp_bind(&handler.receiver, 9988, EchoHandler.on_recv);

    var ts = time.get_time_since_boot();
    while (true) {
        // run lwip poller
        try net.poll();

        // blink
        const now = time.get_time_since_boot();
        if (now.diff(ts).to_us() > 500_000) {
            ts = now;
            led.toggle();
        }
    }
}

const EchoHandler = struct {
    const Self = @This();

    receiver: Net.UdpReceiver = .{},
    sender: Net.UdpSender = .{},

    fn on_recv(ptr: *Net.UdpReceiver, bytes: []const u8, src: Net.Target) void {
        const self: *Self = @fieldParentPtr("receiver", ptr);
        log.debug("packet: {} bytes from: {f}", .{ bytes.len, src });
        self.sender.send(bytes, .{ .addr = src.addr, .port = 9999 }) catch |err| {
            log.err("udp send {}", .{err});
        };
    }
};
