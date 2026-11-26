const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const drivers = rp2xxx.drivers;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(16);
pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

const log = std.log.scoped(.main);

comptime {
    _ = @import("lwip_exports.zig");
}
const net = @import("net");
const dhcp = @import("dhcp");
const DHCPServer = dhcp.Server(.{});

// WiFi credentials - change these for your project
const wifi_ssid = "YOUR_SSID";
const wifi_password = "12345678";

const ServerContext = struct {
    udp: net.Udp,
    server: DHCPServer,
    packet_buffer: dhcp.PacketBuffer,
    buffer_index: usize,

    fn init(self: *@This(), lease_buffer: []dhcp.Lease, nic: *net.Interface) !void {
        self.* = .{
            .udp = try .init(nic),
            .server = try .init(lease_buffer),
            .packet_buffer = undefined,
            .buffer_index = 0,
        };
        try self.udp.bind(dhcp.server_port, on_recv);
    }

    fn on_recv(udp: *net.Udp, data: []u8, recv_opt: net.Udp.RecvOptions) void {
        const self: *@This() = @fieldParentPtr("udp", udp);
        const packet_bytes = self.packet_buffer.asBytes();

        // Reset buffer index on exit
        defer if (recv_opt.last_fragment) {
            self.buffer_index = 0;
        };

        // Fill our packet buffer as it might be fragmented,
        // then leave if there is still more to come
        if (self.buffer_index + data.len >= packet_bytes.len) {
            log.err("Packet too big, dropping it.", .{});
            return;
        }
        @memcpy(packet_bytes[self.buffer_index..][0..data.len], data);
        self.buffer_index += data.len;
        if (!recv_opt.last_fragment) return;

        const now_us = rp2xxx.time.get_time_since_boot().to_us();
        const now_s: i64 = @intCast(now_us / std.time.us_per_s);
        const action = self.server.parse(&self.packet_buffer, now_s, self.buffer_index) catch |err| {
            log.err("Failed to fufil dhcp request: {}", .{err});
            return;
        };

        if (action == .respond) {
            const clinet: net.Endpoint = .{
                .addr = .{ .u_addr = .{ .ip4 = .{ .addr = 0xffff_ffff } }, .type = 0 },
                .port = dhcp.client_port,
            };
            udp.send(self.packet_buffer.getResponse(), clinet) catch |err| {
                log.err("Failed to send dhcp response: {}", .{err});
            };
        }
    }
};

pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{ .clock_config = rp2xxx.clock_config });
    rp2xxx.uart.init_logger(uart);

    log.info("Initializing CYW43...", .{});
    var wifi_driver: drivers.WiFi = .{};
    var wifi = try wifi_driver.init(.{});
    var led = wifi.gpio(0);

    log.info(
        "Starting access point. SSID: '{s}', Password: '{s}'",
        .{ wifi_ssid, wifi_password },
    );
    try wifi.start_ap(wifi_ssid, wifi_password, .{ .security = .wpa3_sae });

    log.info("Initializing IP Stack...", .{});
    var nic: net.Interface = .{ .link = wifi.link() };
    const opt: net.Interface.Options = .{ .fixed = .{
        .ip = .{ .addr = @bitCast(DHCPServer.server_ip_address) },
        .netmask = .{ .addr = @bitCast(DHCPServer.subnet_mask) },
        .gw = .{ .addr = 0 },
    } };
    try nic.init(wifi.mac, opt);

    log.info("Starting DHCP server...", .{});
    var lease_buffer: [16]dhcp.Lease = undefined;
    var dhcp_server: ServerContext = undefined;
    try dhcp_server.init(&lease_buffer, &nic);

    var ts = time.get_time_since_boot();
    while (true) {
        // run lwip poller
        nic.poll() catch |err| {
            log.err("net poll {}", .{err});
            wifi.wifi.err = null; // Silence discounntect errors
        };

        // blink
        const now = time.get_time_since_boot();
        if (now.diff(ts).to_us() > 500_000) {
            ts = now;
            led.toggle();
        }
    }
}
