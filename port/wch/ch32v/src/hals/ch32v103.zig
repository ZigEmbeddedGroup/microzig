const microzig = @import("microzig");
pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
pub const i2c = @import("i2c.zig");
pub const usart = @import("usart.zig");

/// HSI (High Speed Internal) oscillator frequency
/// This is the fixed internal RC oscillator frequency for CH32V103
pub const hsi_frequency: u32 = 8_000_000; // 8 MHz

/// Initialize HAL subsystems used by default
/// CH32V103: set clock to 48 MHz via HSI PLL; SysTick driver differs on 103, so time is not enabled here.
pub fn init() void {
    clocks.init(.{
        .source = .hsi,
        .target_frequency = 48_000_000,
    });
}
