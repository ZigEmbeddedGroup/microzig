pub const systick_timer = @import("./common/systick_timer.zig");
pub const systick = @import("./common/systick.zig");
pub const enums = @import("./common/enums.zig");
pub const lcd = @import("./STM32L47X/lcd.zig");
pub const uart = @import("./STM32L47X/uart.zig");
pub const pins = @import("./STM32L47X/pins.zig");
pub const rcc = @import("./STM32L47X/rcc.zig");
pub const i2c = @import("./STM32L47X/i2c.zig");
pub const dma = @import("./STM32L47X/dma.zig");

pub fn get_sys_clk() u32 {
    return rcc.current_clock.h_clk;
}

pub fn get_systick_clk() u32 {
    return rcc.current_clock.h_clk / 8;
}
