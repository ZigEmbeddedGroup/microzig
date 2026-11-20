//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico W and Pico 2 W
//! Driver code based on: https://github.com/embassy-rs/embassy/tree/main/cyw43
const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;

const drivers = microzig.hal.drivers;
var wifi_driver: drivers.WiFi = .{};

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = common.log,
});

comptime {
    _ = microzig.export_startup();
}

const log = std.log.scoped(.main);

pub fn main() !void {
    common.init_logger();

    // init cyw43
    var wifi = try wifi_driver.init(.{});
    log.debug("mac address: {x}", .{wifi.mac});
    var led = wifi.gpio(0);

    while (true) {
        time.sleep_ms(500);
        led.toggle();
    }
}
