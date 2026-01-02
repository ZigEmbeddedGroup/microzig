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

const net = @import("lwip/net.zig");
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
    var nic: net.Interface = .{
        .mac = wifi.mac,
        .link = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
            .ready = drivers.WiFi.ready,
        },
    };
    try nic.init();

    // udp init
    var udp: net.Udp = try .init(&nic);
    // listen for udp packets on port 9999 and call on_recv for each received packet
    try udp.bind(9999, on_recv);

    var ts = time.get_time_since_boot();
    while (true) {
        // run lwip poller
        nic.poll() catch |err| {
            log.err("net pool {}", .{err});
        };

        // blink
        const now = time.get_time_since_boot();
        if (now.diff(ts).to_us() > 500_000) {
            ts = now;
            led.toggle();
        }
    }
}

fn on_recv(udp: *net.Udp, bytes: []u8, opt: net.Udp.RecvOptions) void {
    // show received packet
    log.debug(
        "received {} bytes, from: {f}, last: {}, data: {s}",
        .{ bytes.len, opt.src, opt.last_fragment, data_head(bytes, 32) },
    );
    // echo same data to the source address and port 9999
    udp.send(bytes, .{ .addr = opt.src.addr, .port = 9999 }) catch |err| {
        log.err("udp send {}", .{err});
    };
}

// log helper
fn data_head(bytes: []u8, max: usize) []u8 {
    const head: []u8 = bytes[0..@min(max, bytes.len)];
    std.mem.replaceScalar(u8, head, '\n', ' ');
    return head;
}

// when you run this example pico ip will be displayed in log:
// debug (lwip): netif status callback is_link_up: true, is_up: true, ready: true, ip: 192.168.190.206
//
// on host listen for udp packets on port 9999
// $ nc -ulp 9999
//
// then send something to the pico:
// $ nc -u 192.168.190.206 9999 -c < LICENSE
//
// pico will show recived bytes and echo that to the sender ip and port 9999
// debug (main): received 867 bytes, from: 192.168.190.235:47205, last: true, data: Copyright (c) Zig Embedded Group
//
