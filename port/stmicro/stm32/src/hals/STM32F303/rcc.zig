const microzig = @import("microzig");
const RCC = microzig.chip.peripherals.RCC;
const GPIOF = microzig.chip.peripherals.GPIOF;
const FLASH = microzig.chip.peripherals.FLASH;
const PREDIV = microzig.chip.types.peripherals.rcc_f3v1.PREDIV;
const PLLMUL = microzig.chip.types.peripherals.rcc_f3v1.PLLMUL;
const ICSW = microzig.chip.types.peripherals.rcc_f3v1.ICSW;
const enums = @import("../common/enums.zig");

pub const ClockName = enum {
    HSE,
    HSI,
    PLLCLK,
    SYSCLK,

    fn is_for_pll(self: @This()) bool {
        return self == .HSE or self == .HSI;
    }

    fn is_for_sysclk(self: @This()) bool {
        return self != .SYSCLK;
    }
};

pub const RccErrorConfig = error{
    WrongClockSource,
    SourceClockNotInitialized,
    OutputPllTooHigh,
    PllMustBeEnableFirst,
};

pub const Clock = struct {
    sys_clk: u32 = 8_000_000,
    h_clk: u32 = 8_000_000,
    p1_clk: u32 = 8_000_000,
    p2_clk: u32 = 8_000_000,
    hse: u32 = 0,
    hsi: u32 = 8_000_000,
    pllout: u32 = 0,
    usart1_clk: u32 = 8_000_000,
};

pub var current_clock: Clock = .{};

pub fn enable_pll(comptime source: ClockName, div: PREDIV, mul: PLLMUL) RccErrorConfig!void {
    if (!source.is_for_pll()) {
        return RccErrorConfig.WrongClockSource;
    }

    if (source == .HSE and current_clock.hse == 0) {
        return RccErrorConfig.SourceClockNotInitialized;
    }

    const inputClock = if (source == .HSE) current_clock.hse else (current_clock.hsi >> 1);

    const inputDiv = @intFromEnum(div) + 1;
    const outputMul = @intFromEnum(mul) + 2;

    const expectedPllOut = @divTrunc(inputClock, inputDiv) * outputMul;
    if (expectedPllOut > 72_000_000) {
        return RccErrorConfig.OutputPllTooHigh;
    }

    RCC.CFGR.modify(.{ .PLLSRC = comptime if (source == .HSE) .HSE_Div_PREDIV else .HSI_Div2, .PLLMUL = mul });
    RCC.CR.modify(.{ .PLLON = 1 });

    while (RCC.CR.read().PLLRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }

    current_clock.pllout = expectedPllOut;
}

pub fn enable_gpio_port(used_gpios_port: u8) void {
    RCC.AHBENR.modify(.{
        .GPIOAEN = @as(u1, @truncate(0b1 & used_gpios_port)),
        .GPIOBEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 1))),
        .GPIOCEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 2))),
        .GPIODEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 3))),
        .GPIOEEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 4))),
        .GPIOFEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 5))),
        .GPIOGEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 6))),
        .GPIOHEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 7))),
    });
}

pub fn enable_uart(index: enums.UART_V3_Type) void {
    switch (index) {
        .USART1 => RCC.APB2ENR.modify(.{ .USART1EN = 1 }),
        .USART2 => RCC.APB1ENR.modify(.{ .USART2EN = 1 }),
        .USART3 => RCC.APB1ENR.modify(.{ .USART3EN = 1 }),
        .UART4 => RCC.APB1ENR.modify(.{ .UART4EN = 1 }),
        .UART5 => RCC.APB1ENR.modify(.{ .UART5EN = 1 }),
    }
}

pub fn enable_hse(speed: u32) void {
    RCC.CR.modify(.{ .HSEON = 1, .HSEBYP = 1 });

    while (RCC.CR.read().HSERDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
    current_clock.hse = speed;
}

pub fn enable_dma(index: enums.DMA_V1_Type) void {
    switch (index) {
        .DMA1 => RCC.AHBENR.modify(.{ .DMA1EN = 1 }),
        .DMA2 => RCC.AHBENR.modify(.{ .DMA2EN = 1 }),
    }
}

pub fn select_pll_for_sysclk() RccErrorConfig!void {
    if (current_clock.pllout == 0) {
        return RccErrorConfig.PllMustBeEnableFirst;
    }
    // Maximum APB low speed domain is 36Nhz, let's divide by 2
    if (current_clock.pllout > 36_000_000) {
        RCC.CFGR.modify(.{ .PPRE1 = .Div2 });
        current_clock.p1_clk = current_clock.pllout >> 1;
    } else {
        current_clock.p1_clk = current_clock.pllout;
    }
    current_clock.sys_clk = current_clock.pllout;
    adjust_flash();
    RCC.CFGR.modify(.{ .SW = .PLL1_P });
    current_clock.h_clk = current_clock.pllout;
    current_clock.p2_clk = current_clock.pllout;
    current_clock.usart1_clk = current_clock.pllout;
}

pub fn enable_i2c(comptime i2cindex: enums.I2C_V2_Type, clock: ICSW) void {
    RCC.APB1ENR.modify(switch (i2cindex) {
        .I2C1 => .{ .I2C1EN = 1 },
        .I2C2 => .{ .I2C2EN = 1 },
    });

    RCC.CFGR3.modify(switch (i2cindex) {
        .I2C1 => .{ .I2C1SW = clock },
        .I2C2 => .{ .I2C2SW = clock },
    });
}

pub fn enable_spi(comptime spiindex: enums.SPI_V2_Type) void {
    switch (spiindex) {
        .SPI1 => RCC.APB2ENR.modify(.{ .SPI1EN = 1 }),

        .SPI2 => RCC.APB1ENR.modify(.{ .SPI2EN = 1 }),
        .SPI3 => RCC.APB1ENR.modify(.{ .SPI3EN = 1 }),
    }
}

pub fn get_spi_clk(spiindex: enums.SPI_V2_Type) u32 {
    return switch (spiindex) {
        .SPI1 => current_clock.p2_clk,
        .SPI2, .SPI3 => current_clock.p1_clk,
    };
}

fn adjust_flash() void {
    if (current_clock.sys_clk < 24_000_000) {
        FLASH.ACR.modify(.{ .LATENCY = .WS0 });
    } else if (current_clock.sys_clk < 42_000_000) {
        FLASH.ACR.modify(.{ .LATENCY = .WS1, .PRFTBE = 1 });
    } else {
        FLASH.ACR.modify(.{ .LATENCY = .WS2, .PRFTBE = 1 });
    }
}
