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

    // init server
    var srv: net.tcp.Server = .{
        .nic = &nic,
        .on_accept = on_accept,
    };
    try srv.bind(9998);

    var ts = time.get_time_since_boot();
    while (true) {
        // run lwip poller
        nic.poll() catch |err| {
            log.err("net pool {}", .{err});
        };

        const now = time.get_time_since_boot();
        if (now.diff(ts).to_us() > 500_000) {
            // blink
            ts = now;
            led.toggle();
        }
    }
}

var pool: [2]Session = @splat(.{});

fn on_accept() ?*net.tcp.Connection {
    for (pool[0..]) |*handler| {
        if (handler.conn.state != .closed) continue;
        handler.* = .{
            .recv_bytes = 0,
            .conn = .{
                .on_recv = Session.on_recv,
                .on_connect = Session.on_connect,
                .on_close = Session.on_close,
            },
        };
        return &handler.conn;
    }
    return null;
}

const Session = struct {
    const Self = @This();

    conn: net.tcp.Connection = .{},
    recv_bytes: usize = 0,

    fn on_recv(conn: *net.tcp.Connection, bytes: []u8) void {
        const self: *Self = @fieldParentPtr("conn", conn);
        self.recv_bytes += bytes.len;
        log.debug(
            "{x} recv {} bytes, total: {} {s}",
            .{ @intFromPtr(conn), bytes.len, self.recv_bytes, @import("udp.zig").data_head(bytes, 64) },
        );
    }

    fn on_connect(conn: *net.tcp.Connection) void {
        log.debug("{x} connected", .{@intFromPtr(conn)});
    }

    fn on_close(conn: *net.tcp.Connection, err: net.Error) void {
        log.debug("{x} closed {}", .{ @intFromPtr(conn), err });
    }
};
