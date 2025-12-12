const microzig = @import("microzig");
pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
pub const usart = @import("usart.zig");

/// Default interrupt handlers provided by the HAL
pub const default_interrupts: microzig.cpu.InterruptOptions = .{
    .TIM2 = time.tim2_handler,
};

/// Initialize HAL subsystems used by default
pub fn init() void {
    // Configure TIM2 timing driver
    time.init();
}
