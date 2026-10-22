pub const syscon = @import("hal/syscon.zig");
pub const clkout = @import("hal/clkout.zig");
pub const port = @import("hal/port.zig");
pub const gpio = @import("hal/gpio.zig");
pub const ostime = @import("hal/ostimer.zig");

pub const time = struct {
    pub const get_time_since_boot = ostime.get_time_since_boot;
    pub const sleep_ms = ostime.sleep_ms;
    pub const sleep_us = ostime.sleep_us;
};

pub fn init() void {
    ostime.init();
}
