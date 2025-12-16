const microzig = @import("microzig");

pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
pub const usart = @import("usart.zig");

/// HSI (High Speed Internal) oscillator frequency
/// This is the fixed internal RC oscillator frequency for CH32V20x
pub const hsi_frequency: u32 = 8_000_000; // 8 MHz

pub const default_interrupts: microzig.cpu.InterruptOptions = .{
    // Default TIM2 handler provided by the HAL for 1ms timekeeping
    .TIM2 = time.tim2_handler,
};

pub fn init() void {
    time.init();
}

test "hal tests" {
    _ = clocks;
    _ = gpio;
    _ = time;
    _ = usart;
}
