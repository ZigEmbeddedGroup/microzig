const std = @import("std");
const microzig = @import("microzig");

pub const systick_timer = @import("./common/systick_timer.zig");
pub const systick = @import("./common/systick.zig");
pub const gpio = @import("./common/gpio_v2.zig");
pub const pins = @import("./common/pins_v2.zig");
pub const rcc = @import("./STM32H723/rcc.zig");
pub const spi = @import("./common/spi_v3.zig");

pub fn get_sys_clk() u32 {
    return @intFromFloat(rcc.current_clocks.SysCLKOutput);
}

pub fn get_systick_clk() u32 {
    return @intFromFloat(rcc.current_clocks.CortexSysOutput);
}

pub var Reset_Reason: rcc.ResetReason = .unknown;
pub fn init() void {
    const reset = rcc.get_reset_reason();
    Reset_Reason = reset;

    // force default configuration; required for clock configuration
    // Power control (PWR) 6.4.1 System supply startup - page: 238 RM0468 Rev 3
    if (reset == .power_on) {
        microzig.chip.peripherals.PWR.CR3.raw = 0x0000_0046;
    }
}
