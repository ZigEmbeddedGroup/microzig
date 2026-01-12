const std = @import("std");
const microzig = @import("microzig");

pub const systick_timer = @import("./common/systick_timer.zig");
pub const systick = @import("./common/systick.zig");
pub const gpio = @import("./common/gpio_v2.zig");
pub const pins = @import("./common/pins_v2.zig");
pub const rcc = @import("./STM32H723/rcc.zig");

pub fn get_sys_clk() u32 {
    return @intFromFloat(rcc.current_clocks.SysCLKOutput);
}

pub fn get_systick_clk() u32 {
    return @intFromFloat(rcc.current_clocks.CortexSysOutput);
}
