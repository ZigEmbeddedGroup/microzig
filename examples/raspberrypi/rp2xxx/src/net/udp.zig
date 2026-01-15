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

const net = @import("net");
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
    // join network
    try wifi.join(secrets.ssid, secrets.pwd, secrets.join_opt);

    // init lwip network interface
    var nic: net.Interface = .{ .link = wifi.link() };
    try nic.init(wifi.mac, try secrets.nic_options());

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
pub fn data_head(bytes: []u8, max: usize) []u8 {
    const head: []u8 = bytes[0..@min(max, bytes.len)];
    std.mem.replaceScalar(u8, head, '\n', ' ');
    return head;
}
