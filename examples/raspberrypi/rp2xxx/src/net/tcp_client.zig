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
    // join network
    try wifi.join(secrets.ssid, secrets.pwd, secrets.join_opt);

    // init lwip network interface
    var nic: net.Interface = .{
        .link = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
            .ready = drivers.WiFi.ready,
        },
    };
    try nic.init(wifi.mac, try secrets.nic_options());

    // init handler
    const target = try net.Endpoint.parse(secrets.host_ip, 9998);
    var cli: Client = .{
        .target = target,
        .nic = &nic,
        .conn = .{
            .on_recv = Client.on_recv,
            .on_sent = Client.on_sent,
            .on_close = Client.on_close,
            .on_connect = Client.on_connect,
        },
    };

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

            if (nic.ready()) {
                cli.tick();
            }
        }
    }
}

const Client = struct {
    const Self = @This();

    nic: *net.Interface,
    target: net.Endpoint,
    conn: net.tcp.Connection,
    bytes_sent: usize = 0,
    bytes_received: usize = 0,
    send_count: usize = 0,

    fn on_connect(_: *net.tcp.Connection) void {
        log.debug("connection open", .{});
    }

    fn on_close(_: *net.tcp.Connection, err: net.Error) void {
        log.debug("connection closed {}", .{err});
    }

    fn on_recv(tcp: *net.tcp.Connection, bytes: []u8) void {
        const self: *Self = @fieldParentPtr("conn", tcp);
        self.bytes_received += bytes.len;
        log.debug(
            "recv {} bytes, total {} data: {s}",
            .{ bytes.len, self.bytes_received, bytes[0..@min(64, bytes.len)] },
        );
    }

    fn on_sent(tcp: *net.tcp.Connection, n: u16) void {
        const self: *Self = @fieldParentPtr("conn", tcp);
        self.bytes_sent += n;
        log.debug("sent {} bytes, total {}", .{ n, self.bytes_sent });
    }

    fn tick(self: *Self) void {
        switch (self.conn.state) {
            .closed => {
                net.tcp.connect(self.nic, &self.conn, &self.target) catch |err| {
                    log.err("tcp connect {}", .{err});
                    return;
                };
            },
            .open => {
                self.send_count += 1;
                // close
                if (self.send_count % 16 == 0) {
                    self.conn.close() catch |err| {
                        log.err("tcp close {}", .{err});
                    };
                    return;
                }
                // TCP_SND_BUF is maximum send buffer size, default is 536 * 2 = 1072 bytes
                // ref: https://github.com/lwip-tcpip/lwip/blob/6ca936f6b588cee702c638eee75c2436e6cf75de/src/include/lwip/opt.h#L1310
                var buf: [net.lwip.TCP_SND_BUF + 128]u8 = @splat('-');
                // add some header to the buf
                _ = std.fmt.bufPrint(
                    &buf,
                    "hello from rpi pi pico {}",
                    .{self.send_count},
                ) catch unreachable;
                // change len on each send
                const chunk_len = (self.send_count * 64) % buf.len;
                // Try to send. If buf.len is greater than
                // self.tcp.send_buffer() it will fail with OutOfMemory while
                // trying to copy to tcp send buffer.
                self.conn.send(buf[0..chunk_len]) catch |err| {
                    log.err("send {} bytes {}", .{ chunk_len, err });
                    if (err == error.OutOfMemory) {
                        self.conn.limits();
                    }
                    return;
                };
                log.debug("sent {} bytes", .{chunk_len});
            },
            .connecting => {},
        }
    }
};
