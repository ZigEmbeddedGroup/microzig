const std = @import("std");
const mem = std.mem;

const SpiInterface = @import("bus.zig").SpiInterface;
const Bus = @import("bus.zig").Bus;
const WiFi = @import("wifi.zig").WiFi;

const log = std.log.scoped(.cyw43_runner);

pub const Runner = struct {
    const Self = @This();

    // tx: 4 ioctl cmd + 18 bus header + 14 ethernet header + 1500 MTU = 1536
    // rx: 22 bus (18 + 4 padding) + 14 ethernet header + 1500 MTU = 1536 bytes + 4 bytes status
    // aligned to 4 bytes for dma = 1536 / 4 + 1 = 385 u32 words
    pub const Buffer = [(1536 / 4) + 1]u32;
    buffer: *Buffer = undefined,

    bus: Bus = undefined,
    wifi: WiFi = undefined,
    led_pin: ?u2 = null,
    mac: [6]u8 = @splat(0),

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
            .buffer = buffer,
        };
        try self.wifi.init();

        if (led_pin) |pin| {
            self.led_pin = pin;
            self.wifi.gpio_enable(pin);
        }
        self.mac = try self.read_mac();
    }

    pub fn tx_buffer(self: *Self) []u8 {
        // first word (4 bytes) is reserved for bus command
        // then 18 bytes are reserved for bus header
        return mem.sliceAsBytes(self.wifi.buffer[1..])[18..];
    }

    pub fn join(self: *Self, ssid: []const u8, pwd: []const u8) !void {
        try self.wifi.join(ssid, pwd);
    }

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

    pub fn ready(ptr: *anyopaque) bool {
        const self: *Self = @ptrCast(@alignCast(ptr));
        return self.wifi.has_credit();
    }
};

test "sizes" {
    std.debug.print("Runner: {}\n", .{@sizeOf(Runner)});
    std.debug.print("Bus: {}\n", .{@sizeOf(Bus)});
    std.debug.print("WiFi: {}\n", .{@sizeOf(WiFi)});
}
