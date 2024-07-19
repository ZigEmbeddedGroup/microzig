const std = @import("std");
const mz = @import("microzig");
const periph = mz.chip.peripherals;

const RCC = periph.RCC;
const FLASH = periph.FLASH;

pub fn rcc_init_hsi_pll() void {
    const CFG0_PLL_TRIM: *u8 = @ptrFromInt(0x1FFFF7D4); // Factory HSI clock trim value
    if (CFG0_PLL_TRIM.* != 0xFF) {
        RCC.CTLR.modify(.{ .HSITRIM = @as(u5, @truncate(CFG0_PLL_TRIM.*)) });
    }

    FLASH.ACTLR.modify(.{ .LATENCY = 1 }); // Flash wait state 1 for 48MHz clock

    RCC.CFGR0.modify(.{
        .PLLSRC = 0, // HSI
        .HPRE = 0, // Prescaler off
    });
    RCC.CTLR.modify(.{ .PLLON = 1 });
    while (RCC.CTLR.read().PLLRDY != 1) {}
    RCC.CFGR0.modify(.{ .SW = 0b10 }); // Select PLL clock source
    while (RCC.CFGR0.read().SWS != 0b10) {} // Spin until PLL selected
}
