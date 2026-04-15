const std = @import("std");
const microzig = @import("microzig");

pub const uart = @import("STM32F303/uart.zig");
pub const rcc = @import("STM32F303/rcc.zig");
pub const i2c = @import("STM32F303/i2c.zig");
pub const spi = @import("STM32F303/spi.zig");
pub const pins = @import("STM32F303/pins.zig");
pub const dma = @import("./STM32F303/dma.zig");
pub const enums = @import("./common//enums.zig");
pub const systick_timer = @import("./common/systick_timer.zig");
pub const systick = @import("./common/systick.zig");

pub fn get_sys_clk() u32 {
    return @intFromFloat(rcc.current_clocks.clock.HCLKOutput);
}

pub fn get_systick_clk() u32 {
    return @as(u32, @intFromFloat(rcc.current_clocks.clock.HCLKOutput)) / 8;
}

pub const HAL_Options = struct {
    rcc_clock_config: rcc.Config = .{},
};
