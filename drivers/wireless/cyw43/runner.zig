const std = @import("std");
const mem = std.mem;

const SpiInterface = @import("bus.zig").SpiInterface;
const Bus = @import("bus.zig").Bus;
const WiFi = @import("wifi.zig").WiFi;

const log = std.log.scoped(.cyw43_runner);

pub const Runner = struct {
    const Self = @This();

    pub const Buffer = [770]u32;

    bus: Bus = undefined,
    wifi: WiFi = undefined,
    led_pin: ?u2 = null,
    mac: [6]u8 = @splat(0),

    buffer: *Buffer = undefined,

    pub fn init(
        self: *Self,
        spi: SpiInterface,
        sleep_ms: *const fn (delay: u32) void,
        led_pin: ?u2,
        buffer: *Buffer,
    ) !void {
        self.bus = .{ .spi = spi, .sleep_ms = sleep_ms };
        try self.bus.init();

        self.wifi = .{
            .bus = &self.bus,
            .tx_words = buffer[0..385],
            .rx_words = buffer[385..],
        };
        try self.wifi.init();

        if (led_pin) |pin| {
            self.led_pin = pin;
            self.wifi.gpio_enable(pin);
        }
        self.mac = try self.read_mac();
    }

    pub fn tx_buffer(self: *Self) []u8 {
        // first word is reserved for bus command
        // then 18 bytes are bus header
        return mem.sliceAsBytes(self.wifi.tx_words[1..])[18..];
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

    pub fn recv(ptr: *anyopaque) anyerror!?[]const u8 {
        const self: *Self = @ptrCast(@alignCast(ptr));
        return self.wifi.recv();
    }

    // data is network header + payload, network header is
    //   UDP  : 14 (Eth) + 20 (IPv4) + 8 (UDP)  = 42 bytes
    //   ICMP : 14 (Eth) + 20 (IPv4) + 8 (ICMP) = 42 bytes
    //   ARP  : 14 (Eth) + 28 (ARP)             = 42 bytes
    //
    pub fn send(ptr: *anyopaque, data: []const u8) anyerror!void {
        const self: *Self = @ptrCast(@alignCast(ptr));
        try self.wifi.send(data);
    }
};

test "sizes" {
    std.debug.print("Runner: {}\n", .{@sizeOf(Runner)});
    std.debug.print("Bus: {}\n", .{@sizeOf(Bus)});
    std.debug.print("WiFi: {}\n", .{@sizeOf(WiFi)});
}
