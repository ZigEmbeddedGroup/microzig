const microzig = @import("microzig");
const enums = @import("../common/enums.zig");
const util = @import("../common/util.zig");
const RCC = microzig.chip.peripherals.RCC;
const GPIOF = microzig.chip.peripherals.GPIOF;
const FLASH = microzig.chip.peripherals.FLASH;
const PREDIV = microzig.chip.types.peripherals.rcc_f3v1.PREDIV;
const PLLMUL = microzig.chip.types.peripherals.rcc_f3v1.PLLMUL;
const ICSW = microzig.chip.types.peripherals.rcc_f3v1.ICSW;

pub const Peripherals = enums.Peripherals;

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

pub fn enable_hse(speed: u32) void {
    RCC.CR.modify(.{ .HSEON = 1, .HSEBYP = 1 });

    while (RCC.CR.read().HSERDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
    current_clock.hse = speed;
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

pub fn get_spi_clk(spiindex: enums.SPI_Type) u32 {
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

pub fn set_clock(comptime peri: Peripherals, state: u1) void {
    const peri_name = @tagName(peri);
    if (util.match_name(peri_name, &.{"RTC"})) {
        @panic("RTC not implemented yet");
    }

    const field = comptime if (util.match_name(peri_name, &.{
        "ADC1",
        "ADC2",
    })) "ADC12EN" else if (util.match_name(peri_name, &.{
        "ADC3",
        "ADC4",
    })) "ADC34EN" else if (util.match_name(peri_name, &.{
        "FLASH",
    })) "FLITFEN" else peri_name ++ "EN";

    const rcc_register_name = comptime if (util.match_name(peri_name, &.{
        "ADC",
        "TSC",
        "GPIO",
        "CRC",
        "DMA",
    })) "AHBENR" else if (util.match_name(peri_name, &.{
        "TIM20",
        "TIM17",
        "TIM16",
        "TIM15",
        "SPI4",
        "USART1",
        "TIM8",
        "SPI1",
        "TIM1",
        "SYSCFG",
    })) "APB2ENR" else "APB1ENR";

    @field(RCC, rcc_register_name).modify_one(field, state);
}

pub fn enable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 0);
}
