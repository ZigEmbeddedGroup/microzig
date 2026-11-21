const microzig = @import("microzig");
const gpio = microzig.hal.gpio;
const Peripherals = @import("Peripherals.zig");

const RCC = microzig.chip.peripherals.RCC;
const FLASH = microzig.chip.peripherals.FLASH;

pub fn enable(peripheral: Peripherals.All) void {
    switch (peripheral) {
        .AFIO => RCC.HB2PCENR.modify(.{ .AFIOEN = 1 }),

        .GPIOA => RCC.HB2PCENR.modify(.{ .IOPAEN = 1 }),
        .GPIOB => RCC.HB2PCENR.modify(.{ .IOPBEN = 1 }),
        .GPIOC => RCC.HB2PCENR.modify(.{ .IOPCEN = 1 }),
        .GPIOD => RCC.HB2PCENR.modify(.{ .IOPDEN = 1 }),
        .GPIOE => RCC.HB2PCENR.modify(.{ .IOPEEN = 1 }),
        .GPIOF => RCC.HB2PCENR.modify(.{ .IOPFEN = 1 }),

        .USART1 => RCC.HB2PCENR.modify(.{ .USART1EN = 1 }),
        .USART2 => RCC.HB1PCENR.modify(.{ .USART2EN = 1 }),
        .USART3 => RCC.HB1PCENR.modify(.{ .USART3EN = 1 }),
        .USART4 => RCC.HB1PCENR.modify(.{ .USART4EN = 1 }),
        .USART5 => RCC.HB1PCENR.modify(.{ .USART5EN = 1 }),
        .USART6 => RCC.HB1PCENR.modify(.{ .USART6EN = 1 }),
        .USART7 => RCC.HB1PCENR.modify(.{ .USART7EN = 1 }),
        .USART8 => RCC.HB1PCENR.modify(.{ .USART8EN = 1 }),

        .DMA1 => RCC.HBPCENR.modify(.{ .DMA1EN = 1 }),
        .DMA2 => RCC.HBPCENR.modify(.{ .DMA2EN = 1 }),

        .SPI1 => RCC.HB2PCENR.modify(.{ .SPI1EN = 1 }),
        .SPI2 => RCC.HB1PCENR.modify(.{ .SPI2EN = 1 }),
        .SPI3 => RCC.HB1PCENR.modify(.{ .SPI3EN = 1 }),
        .SPI4 => RCC.HB1PCENR.modify(.{ .SPI4EN = 1 }),
    }
}

pub const ClockSpeeds = struct {
    sysclk: u32,
    hclk: u32,
    pclk1: u32,
    pclk2: u32,
};

/// Returns the current clock frequencies.
///
/// TODO: derive these from the RCC registers once the CH32H417 clock tree
/// (PLLMUL / PLL_SRC_DIV / PLLSRC / SYSPLL_SEL / HPRE / PPRE encodings) is
/// modelled here.
///
/// NOTE: this should be cached.
pub fn get_freqs() ClockSpeeds {
    const freq = 100_000_000;
    return .{ .sysclk = freq, .hclk = freq, .pclk1 = freq, .pclk2 = freq };
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
