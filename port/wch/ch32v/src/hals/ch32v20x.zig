const microzig = @import("microzig");

pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");

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
}
