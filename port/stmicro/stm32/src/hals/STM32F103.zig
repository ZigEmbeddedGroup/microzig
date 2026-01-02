const microzig = @import("microzig");
pub const rcc = @import("./STM32F103/rcc.zig");
pub const pins = @import("./STM32F103/pins.zig");
pub const gpio = @import("./STM32F103/gpio.zig");
pub const exti = @import("./STM32F103/exti.zig");
pub const uart = @import("./STM32F103/uart.zig");
pub const i2c = @import("./STM32F103/i2c.zig");
pub const spi = @import("./STM32F103/spi.zig");
pub const drivers = @import("./STM32F103/drivers.zig");
pub const timer = @import("./common/timer_v1.zig");
pub const usb = @import("./STM32F103/usb.zig");
pub const adc = @import("./STM32F103/adc.zig");
pub const crc = @import("./STM32F103/crc.zig");
pub const power = @import("./STM32F103/power.zig");
pub const backup = @import("./STM32F103/backup.zig");
pub const rtc = @import("./STM32F103/rtc.zig");
pub const dma = @import("./STM32F103/dma.zig");
pub const time = @import("./STM32F103/time.zig");
const util = @import("./common/util.zig");

//temporary solution
pub const default_interrupts = util.load_timer_interrupt(time.TIM_handler);

pub var Reset_Reason: rcc.ResetReason = .POR_or_PDR;
pub fn init() void {
    Reset_Reason = rcc.get_reset_reason();
}
