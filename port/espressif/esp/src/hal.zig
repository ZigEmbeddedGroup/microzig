const std = @import("std");
const microzig = @import("microzig");

pub const gpio = @import("hal/gpio.zig");
pub const uart = @import("hal/uart.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const rom = @import("hal/rom.zig");
pub const clocks = @import("hal/clocks.zig");

pub fn init() void {
    const cpu_clk_freq = 80_000_000;
    const config: clocks.Config = .init_from_cpu_frequency(cpu_clk_freq);
    config.apply();
}
