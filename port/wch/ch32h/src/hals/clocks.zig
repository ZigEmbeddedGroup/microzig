const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

const RCC = microzig.chip.peripherals.RCC;
const FLASH = microzig.chip.peripherals.FLASH;

pub fn enable_gpio(port: gpio.Pin.Port) void {
    switch (port) {
        .a => RCC.HB2PCENR.modify(.{ .IOPAEN = 1 }),
        .b => RCC.HB2PCENR.modify(.{ .IOPBEN = 1 }),
        .c => RCC.HB2PCENR.modify(.{ .IOPCEN = 1 }),
        .d => RCC.HB2PCENR.modify(.{ .IOPDEN = 1 }),
        .e => RCC.HB2PCENR.modify(.{ .IOPEEN = 1 }),
        .f => RCC.HB2PCENR.modify(.{ .IOPFEN = 1 }),
    }
}

pub fn enable_afio() void {
    RCC.HB2PCENR.modify(.{ .AFIOEN = 1 });
}

// Initialize system clock. Currently set to HSE:
//   - V5F     400MHz
//   - V3F     100MHz
//   - SYSTICK 100MHz
// TODO: make this accept a config struct
pub fn init() void {
    RCC.CTLR.modify(.{ .HSEON = 1 });

    // Wait until HSE is ready.
    // TODO: add timeout.
    while (RCC.CTLR.read().HSERDY == 0) {}

    // Configure PLL.
    RCC.PLLCFGR.modify(.{
        .PLLMUL = 0b10000, // x16
        .PLL_SRC_DIV = 0, //  /1
        .PLLSRC = 0b001, // HSE
    });

    // Wait until HSE is used.
    while (RCC.PLLCFGR.read().PLLSRC != 0b001) {}

    // Enable PLL.
    RCC.CTLR.modify(.{ .PLLON = 1 });

    // Wait until PLL is ready.
    while (RCC.CTLR.read().PLLRDY == 0) {}

    // Set SYSPLL src to PLL.
    RCC.PLLCFGR.modify(.{
        .SYSPLL_GATE = 0,
        .SYSPLL_SEL = 0,
    });

    // Wait until PLL is used.
    while (RCC.PLLCFGR.read().SYSPLL_SEL != 0) {}

    // Set V5F clk to SYSCLK / 1, V3F clk to SYSCLK / 4.
    RCC.CFGR0.modify(.{ .HPRE = 0, .FPRE = 0b10 });

    // Set FLASH clk to HCLK / 2.
    FLASH.ACTLR.modify(.{ .SCK_CFG = 0b01 });

    // Set sys clk src to PLL.
    RCC.PLLCFGR.modify(.{ .SYSPLL_GATE = 1 });
    RCC.CFGR0.modify(.{ .SW = 0b10 });

    // Wait until PLL is set.
    while (RCC.CFGR0.read().SWS != 0b10) {}
}
