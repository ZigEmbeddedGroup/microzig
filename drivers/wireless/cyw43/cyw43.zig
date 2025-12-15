// CYW43 WiFi Driver
// Top-level entry point for the CYW43439 WiFi chip

const std = @import("std");
const bus = @import("bus.zig");
const runner_mod = @import("runner.zig");
const wifi_mod = @import("wifi.zig");

pub const Runner = runner_mod.Cyw43_Runner;
pub const Wifi = wifi_mod.CYW43_Wifi;
pub const Bus = bus.Cyw43_Bus;
pub const Security = wifi_mod.Security;
pub const Event = wifi_mod.Event;

/// Initialize CYW43 chip and return Runner
/// Loads firmware and prepares chip for WiFi operations.
/// Use runner.wifi() to access WiFi configuration (enable, join, etc.)
/// Use runner.run() in your main loop to poll for packets
/// Use runner.get_rx_frame() to retrieve received data
pub fn init(cyw43_bus: *Bus, delay_ms: *const fn (u32) void) !Runner {
    var cyw43_runner = Runner{
        .bus = cyw43_bus,
        .internal_delay_ms = delay_ms,
    };
    try cyw43_runner.init();

    return cyw43_runner;
}
