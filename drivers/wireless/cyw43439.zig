const std = @import("std");
const mem = std.mem;
const assert = std.debug.assert;

const Link = @import("link");
const Bus = @import("cyw43439/bus.zig");
const WiFi = @import("cyw43439/wifi.zig");
pub const JoinOptions = WiFi.JoinOptions;
pub const InitOptions = WiFi.InitOptions;

const log = std.log.scoped(.cyw43);

const Self = @This();

bus: Bus = undefined,
wifi: WiFi = undefined,
mac: [6]u8 = @splat(0),

pub fn init(
    self: *Self,
    spi: Bus.Spi,
    sleep_ms: *const fn (delay: u32) void,
    opt: InitOptions,
) !void {
    self.bus = .{ .spi = spi, .sleep_ms = sleep_ms };
    try self.bus.init();

    self.wifi = .{ .bus = &self.bus };
    try self.wifi.init(opt);

    self.mac = try self.wifi.read_mac();
}

pub fn join(self: *Self, ssid: []const u8, pwd: []const u8, opt: JoinOptions) !WiFi.JoinPoller {
    return try self.wifi.join(ssid, pwd, opt);
}

/// Blocking wifi network join
pub fn join_wait(self: *Self, ssid: []const u8, pwd: []const u8, opt: JoinOptions) !void {
    var poller = try self.join(ssid, pwd, opt);
    try poller.wait(opt.wait_ms);
}

pub fn join_state(self: *Self) WiFi.JoinState {
    return self.wifi.join_state;
}

pub fn is_joined(self: *Self) bool {
    return self.wifi.join_state == .joined;
}

pub fn scan(self: *Self) !WiFi.ScanPoller {
    return try self.wifi.scan();
}

pub fn scan_result(self: *Self) ?WiFi.ScanResult {
    return self.wifi.scan_result;
}

pub fn recv_zc(ptr: *anyopaque, bytes: []u8) anyerror!?struct { usize, usize } {
    const self: *Self = @ptrCast(@alignCast(ptr));
    return self.wifi.recv_zc(bytes);
}

pub fn send_zc(ptr: *anyopaque, bytes: []u8) Link.Error!void {
    const self: *Self = @ptrCast(@alignCast(ptr));
    self.wifi.send_zc(bytes) catch |err| switch (err) {
        error.OutOfMemory => return error.OutOfMemory,
        error.LinkDown => return error.LinkDown,
        else => return error.InternalError,
    };
}

pub fn gpio(self: *Self, pin: u2) Pin {
    assert(pin < 3);
    self.wifi.gpio_enable(pin);
    return .{
        .pin = pin,
        .wifi = &self.wifi,
    };
}

pub const Pin = struct {
    pin: u2,
    wifi: *WiFi,

    pub fn toggle(self: *Pin) void {
        self.wifi.gpio_toggle(self.pin);
    }

    pub fn put(self: *Pin, value: u1) void {
        self.wifi.gpio_put(self.pin, value);
    }
};

pub fn link(self: *Self) Link {
    return .{
        .ptr = self,
        .vtable = .{
            .recv = recv_zc,
            .send = send_zc,
        },
    };
}

// References:
//   https://github.com/embassy-rs/embassy/blob/abb1d8286e2415686150e2e315ca1c380659c3c3/cyw43/src/consts.rs
//   https://github.com/jbentham/picowi/blob/main/lib/picowi_regs.h
//   https://github.com/georgerobotics/cyw43-driver/blob/dd7568229f3bf7a37737b9e1ef250c26efe75b23/src/cyw43_ll.c#L126
