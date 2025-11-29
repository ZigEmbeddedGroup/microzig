const microzig = @import("microzig");
pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");

/// Initialize HAL subsystems used by default
/// CH32V103: set clock to 48 MHz via HSI PLL; SysTick driver differs on 103, so time is not enabled here.
pub fn init() void {
    clocks.init_48mhz_hsi();
}
