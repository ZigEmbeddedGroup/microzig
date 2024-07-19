const std = @import("std");
const mz = @import("microzig");
const periph = mz.chip.peripherals;

pub fn main() !void {
    mz.hal.rcc_init_hsi_pll();
    periph.RCC.APB2PCENR.modify(.{ .IOPCEN = 1 });
    periph.GPIOC.CFGLR.modify(.{ .CNF1 = 0b00, .MODE1 = 0b11 });

    var on: u1 = 0;
    while (true) {
        on ^= 1;
        periph.GPIOC.OUTDR.modify(.{ .ODR1 = on });
    }
}
