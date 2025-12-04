const std = @import("std");
const mem = std.mem;

const SpiInterface = @import("bus.zig").SpiInterface;
const Bus = @import("bus.zig").Bus;
const WiFi = @import("wifi.zig").WiFi;

const log = std.log.scoped(.cyw43_runner);

pub const Runner = struct {
    const Self = @This();

    bus: Bus = undefined,
    wifi: WiFi = undefined,
    led_pin: ?u2 = null,
    mac: [6]u8 = @splat(0),

    pub fn init(
        self: *Self,
        spi: SpiInterface,
        sleep_ms: *const fn (delay: u32) void,
        led_pin: ?u2,
    ) !void {
        self.bus = .{ .spi = spi, .sleep_ms = sleep_ms };
        try self.bus.init();

        self.wifi = .{ .bus = &self.bus };
        try self.wifi.init();

        if (led_pin) |pin| {
            self.led_pin = pin;
            self.wifi.gpio_enable(pin);
        }
        self.mac = try self.read_mac();
    }

    pub fn join(self: *Self, ssid: []const u8, pwd: []const u8) !void {
        try self.wifi.join(ssid, pwd);
    }

    // should not be used after join
    // read_packet can get packet of 1536 bytes while using buffer of 512 bytes
    fn show_clm_ver(self: *Self) !void {
        var data: [128]u8 = @splat(0);
        const n = try self.wifi.get_var("clmver", &data);
        var iter = mem.splitScalar(u8, data[0..n], 0x0a);
        log.debug("clmver:", .{});
        while (iter.next()) |line| {
            if (line.len == 0 or line[0] == 0x00) continue;
            log.debug("  {s}", .{line});
        }
    }

    fn read_mac(self: *Self) ![6]u8 {
        var mac: [6]u8 = @splat(0);
        const n = try self.wifi.get_var("cur_etheraddr", &mac);
        if (n != mac.len) {
            log.err("read_mac unexpected read bytes: {}", .{n});
            return error.ReadMacFailed;
        }
        return mac;
    }

    pub fn led_toggle(self: *Self) void {
        self.wifi.gpio_toggle(self.led_pin.?);
    }

    pub fn recv(ptr: *anyopaque, buffer: []u8) anyerror!?[]const u8 {
        const self: *Self = @ptrCast(@alignCast(ptr));
        return self.wifi.recv(buffer);
    }

    // UDP  : 14 (Eth) + 20 (IPv4) + 8 (UDP)  = 42 bytes
    // ICMP : 14 (Eth) + 20 (IPv4) + 8 (ICMP) = 42 bytes
    // ARP  : 14 (Eth) + 28 (ARP)             = 42 bytes
    // header:
    // 12 bytes sdp header
    //  2 bytes padding (aligns ethernet to 4 bytes)
    //  4 bytes cdc header
    // --- align 2
    // 14 bytes ethernet header
    // -- align 4
    // 20 bytes ip header    | 28 bytes arp header | 20 bytes ip
    //  8 bytes udp header   |                     |  8 bytes icmp header
    pub fn send(ptr: *anyopaque, net_header: []const u8, payload: []const u8) anyerror!void {
        const self: *Self = @ptrCast(@alignCast(ptr));
        try self.wifi.send(net_header, payload);
    }
};

test "sizes" {
    std.debug.print("Runner: {}\n", .{@sizeOf(Runner)});
    std.debug.print("Bus: {}\n", .{@sizeOf(Bus)});
    std.debug.print("WiFi: {}\n", .{@sizeOf(WiFi)});
}
