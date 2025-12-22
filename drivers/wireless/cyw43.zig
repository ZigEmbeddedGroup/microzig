const std = @import("std");
const mem = std.mem;

const Bus = @import("cyw43/bus.zig");
const WiFi = @import("cyw43/wifi.zig");

const log = std.log.scoped(.cyw43);

const Self = @This();

bus: Bus = undefined,
wifi: WiFi = undefined,
led_pin: ?u2 = null,
mac: [6]u8 = @splat(0),

pub fn init(
    self: *Self,
    spi: Bus.Spi,
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

pub fn recv_zc(ptr: *anyopaque, bytes: []u8) anyerror!?struct { usize, usize } {
    const self: *Self = @ptrCast(@alignCast(ptr));
    return self.wifi.recv_zc(bytes);
}

pub fn send_zc(ptr: *anyopaque, bytes: []u8) anyerror!void {
    const self: *Self = @ptrCast(@alignCast(ptr));
    try self.wifi.send_zc(bytes);
}

pub fn ready(ptr: *anyopaque) bool {
    const self: *Self = @ptrCast(@alignCast(ptr));
    return self.wifi.has_credit();
}

// References:
//   https://github.com/embassy-rs/embassy/blob/abb1d8286e2415686150e2e315ca1c380659c3c3/cyw43/src/consts.rs
//   https://github.com/jbentham/picowi/blob/main/lib/picowi_regs.h
//   https://github.com/georgerobotics/cyw43-driver/blob/dd7568229f3bf7a37737b9e1ef250c26efe75b23/src/cyw43_ll.c#L126
