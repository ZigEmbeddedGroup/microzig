const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.chip;
const RCC = chip.peripherals.RCC;
const GPIOB = chip.peripherals.GPIOB;
const GPIO_TYPE = chip.types.peripherals.gpio_v2;

pub fn main() !void {
    RCC.GPIOENR.modify(.{ .GPIOBEN = 1 });
    GPIOB.MODER.modify(.{ .@"MODER[3]" = GPIO_TYPE.MODER.Output });

    while (true) {
        var i: u32 = 0;
        while (i < 100_000) {
            asm volatile ("nop");
            i += 1;
        }
        GPIOB.ODR.raw = (GPIOB.ODR.raw ^ 0x8);
    }
}
