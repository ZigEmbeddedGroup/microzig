pub const gpio = @import("hal/gpio.zig");
pub const uart = @import("hal/uart.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const rom = @import("hal/rom.zig");
pub const clocks = @import("hal/clocks.zig");

/// Clock config applied by the default `init()` function of the hal.
pub const clock_config: clocks.Config = .default;

pub fn init() void {
    default_startup_procedure(clock_config);
}

/// A standard startup procedure for the system. To be used when providing a custom `init()` function.
pub fn default_startup_procedure(cfg: clocks.Config) void {
    // TODO: disable watchdogs

    cfg.apply();

    // TODO: reset peripheral clocks
}
