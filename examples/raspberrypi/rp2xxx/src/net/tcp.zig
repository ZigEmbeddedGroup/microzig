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

    var socket: Socket = .{
        .tcp = Net.Tcp.init(&net, Socket.on_recv, Socket.on_sent, Socket.on_state_changed),
        .target = try Net.Endpoint.parse("192.168.190.235", 9998),
    };

    var ts = time.get_time_since_boot();
    while (true) {
        // run lwip poller
        net.poll() catch |err| {
            log.err("net pool {}", .{err});
        };

        const now = time.get_time_since_boot();
        if (now.diff(ts).to_us() > 500_000) {
            // blink
            ts = now;
            led.toggle();

            try socket.tick();
        }
    }
}

const Socket = struct {
    const Self = @This();

    tcp: Net.Tcp,
    target: Net.Endpoint,
    bytes_sent: usize = 0,
    send_count: usize = 0,

    fn on_state_changed(tcp: *Net.Tcp) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        log.debug("state {} {any}", .{ self.tcp.state, self.tcp.err });
    }

    fn on_recv(tcp: *Net.Tcp, bytes: []u8) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        _ = self;
        log.debug("recv {} bytes: {s}", .{ bytes.len, data_head(bytes, 64) });
    }

    fn on_sent(tcp: *Net.Tcp, n: u16) void {
        const self: *Self = @fieldParentPtr("tcp", tcp);
        self.bytes_sent += n;
        log.debug("sent {} bytes, total {}", .{ n, self.bytes_sent });
    }

    fn tick(self: *Self) !void {
        switch (self.tcp.state) {
            .closed => {
                try self.tcp.connect(self.target);
            },
            .open => {
                self.send_count += 1;
                var buf: [64]u8 = undefined;
                const bytes = try std.fmt.bufPrint(
                    &buf,
                    "hello from rpi pi pico {}\n",
                    .{self.send_count},
                );
                self.tcp.send(bytes) catch |err| {
                    log.err("send {}", .{err});
                };
            },
            else => {},
        }
    }
};

// log helper
fn data_head(bytes: []u8, max: usize) []u8 {
    const head: []u8 = bytes[0..@min(max, bytes.len)];
    std.mem.replaceScalar(u8, head, '\n', ' ');
    return head;
}
