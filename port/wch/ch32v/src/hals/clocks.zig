const microzig = @import("microzig");

/// Initialize system clock to 48 MHz using HSI
pub fn init_48mhz_hsi() void {
    const RCC = microzig.chip.peripherals.RCC;
    const EXTEND = microzig.chip.peripherals.EXTEND;
    // Enable PLL HSI prescaler (HSIPRE bit)
    EXTEND.EXTEND_CTR.modify(.{ .HSIPRE = 1 });

    // Configure clock prescalers
    RCC.CFGR0.modify(.{
        .HPRE = 0, // AHB prescaler = 1 (no division)
        .PPRE2 = 0, // APB2 prescaler = 1 (no division)
        .PPRE1 = 4, // APB1 prescaler = 2 (divide by 2)
        .PLLSRC = 0, // PLL source = HSI/2
        .PLLXTPRE = 0, // HSE divider for PLL = no division
        .PLLMUL = 4, // PLL multiplier = 6 (value 4 = 6x)
    });

    // Enable PLL
    RCC.CTLR.modify(.{ .PLLON = 1 });

    // Wait for PLL to lock
    while (RCC.CTLR.read().PLLRDY == 0) {}

    // Select PLL as system clock
    RCC.CFGR0.modify(.{ .SW = 2 }); // SW = 2 means PLL

    // Wait for PLL to be used as system clock (SWS should be 2)
    while (RCC.CFGR0.read().SWS != 2) {}
}
