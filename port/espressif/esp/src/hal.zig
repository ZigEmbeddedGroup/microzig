pub const gpio = @import("hal/gpio.zig");
pub const uart = @import("hal/uart.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const rom = @import("hal/rom.zig");
pub const clocks = @import("hal/clocks.zig");

/// Clock config applied by the default `init()` function of the hal.
pub const clock_config: clocks.Config = .default;

pub fn init() void {
    clock_config.apply();

    // TODO: reset peripherals
}
