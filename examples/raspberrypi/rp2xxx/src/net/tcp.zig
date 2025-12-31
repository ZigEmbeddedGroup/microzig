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

    const target = try net.Endpoint.parse("192.168.190.235", 9998);
    var cli: Client = .{
        .tcp = .init(
            &nic,
            target,
            Client.on_recv,
            Client.on_sent,
            Client.on_connect,
        ),
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
                try cli.tick();
            }
        }
    }
}

const Client = struct {
    const Self = @This();

    tcp: net.tcp.Client,
    bytes_sent: usize = 0,
    bytes_received: usize = 0,
    send_count: usize = 0,

    fn on_connect(tcp: *net.tcp.Client, maybe_err: ?net.Error) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        _ = self;
        if (maybe_err) |err| {
            log.debug("connection closed {}", .{err});
        } else {
            log.debug("connection open", .{});
        }
    }

    fn on_recv(tcp: *net.tcp.Client, bytes: []u8) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        self.bytes_received += bytes.len;
        log.debug(
            "recv {} bytes, total {} data: {s}",
            .{ bytes.len, self.bytes_received, bytes[0..@min(64, bytes.len)] },
        );
    }

    fn on_sent(tcp: *net.tcp.Client, n: u16) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        self.bytes_sent += n;
        log.debug("sent {} bytes, total {}", .{ n, self.bytes_sent });
    }

    fn tick(self: *Self) !void {
        switch (self.tcp.state) {
            .closed => {
                try self.tcp.connect();
            },
            .open => {
                self.send_count += 1;
                // close
                if (self.send_count % 16 == 0) {
                    try self.tcp.close();
                    return;
                }
                // TCP_SND_BUF is maximum send buffer size, default is 536 * 2 = 1072 bytes
                // ref: https://github.com/lwip-tcpip/lwip/blob/6ca936f6b588cee702c638eee75c2436e6cf75de/src/include/lwip/opt.h#L1310
                var buf: [net.lwip.TCP_SND_BUF + 128]u8 = @splat('-');
                // add some header to the buf
                _ = try std.fmt.bufPrint(
                    &buf,
                    "hello from rpi pi pico {}",
                    .{self.send_count},
                );
                // change len on each send
                const chunk_len = (self.send_count * 64) % buf.len;
                // try to send if buf.len is greater than self.tcp.send_buffer()
                // it will fail with OutOfMemory while trying to fill copy to
                // tcp send buffer
                self.tcp.send(buf[0..chunk_len]) catch |err| {
                    log.err("send {} bytes {}", .{ chunk_len, err });
                    self.tcp.limits();
                    return;
                };
                log.debug("send {} bytes", .{chunk_len});
            },
            .connecting => {},
        }
    }
};

// on the host listen for tcp connections on port 9988:
// $ nc  -l -v -p 9998
//
// or run simple tcp echo:
// $ socat -d2 TCP-LISTEN:9998,fork EXEC:"cat"
