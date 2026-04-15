const microzig = @import("microzig");
const enums = @import("../common/enums.zig");
const util = @import("../common/util.zig");
const clock_tree = @import("ClockTree").get_mcu_tree(microzig.config.chip_name);

//expose only configurations structs
pub const Config = clock_tree.Config;
pub const Peripherals = enums.Peripherals;
const RCC = microzig.chip.peripherals.RCC;
const PWR = microzig.chip.peripherals.PWR;
const I2C1SEL = microzig.chip.types.peripherals.rcc_l4.I2C1SEL;
const I2C2SEL = microzig.chip.types.peripherals.rcc_l4.I2C2SEL;
const I2C3SEL = microzig.chip.types.peripherals.rcc_l4.I2C3SEL;

const ICSW = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    _,
};
const pins = microzig.hal.pins;

// The current running clock
pub const current_clocks: clock_tree.Tree_Output = clock_tree.get_clocks(microzig.options.hal.rcc_clock_config) catch unreachable;

pub fn enable_rtc_lcd() void {
    RCC.APB1ENR1.modify(.{
        .PWREN = 1,
    });
    PWR.CR1.modify(.{
        .DBP = 1,
    });

    RCC.BDCR.modify(.{
        .LSEON = 1,
    });

    while (RCC.BDCR.read().LSERDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }

    RCC.BDCR.modify(.{
        .RTCSEL = .LSE,
        .RTCEN = 1,
        .LSCOEN = 1,
        .LSCOSEL = .LSE,
    });

    RCC.APB1ENR1.modify(.{
        .LCDEN = 1,
    });
}

pub fn get_clock(comptime source: Peripherals) u32 {
    const peri_name = @tagName(source);

    if (comptime util.match_name(peri_name, &.{
        "USART",
        "UART",
        "I2C",
    })) {
        return @intFromFloat(@field(current_clocks.clock, peri_name ++ "output"));
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI1",
    })) {
        return @intFromFloat(current_clocks.clock.APB2Prescaler);
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI2",
        "SPI3",
    })) {
        return @intFromFloat(current_clocks.clock.APB1Prescaler);
    }
    if (comptime util.match_name(peri_name, &.{
        "USB",
    })) {
        return @intFromFloat(current_clocks.clock.USBoutput);
    }

    @panic("Unknown clock for peripheral");
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
    })) "ADC34EN" else peri_name ++ "EN";

    const rcc_register_name = comptime if (util.match_name(peri_name, &.{
        "TSC",
        "CRC",
        "FLASH",
        "DMA",
    })) "AHB1ENR" else if (util.match_name(peri_name, &.{
        "RNG",
        "CRC",
        "ADC",
        "GPIO",
    })) "AHB2ENR" else if (util.match_name(peri_name, &.{
        "QUADSPI",
    })) "AHB3ENR" else if (util.match_name(peri_name, &.{
        "SAI",
        "TIM17",
        "TIM16",
        "TIM15",
        "USART1",
        "TIM8",
        "SPI1",
        "TIM1",
        "SDMMC",
        "SYSCFG",
    })) "APB2ENR" else if (util.match_name(peri_name, &.{
        "LPTIM1",
        "DAC",
        "PWR",
        "CAN",
        "I2C1",
        "I2C2",
        "I2C3",
        "UART",
        "USART",
        "SPI",
        "WWDG",
        "LCD",
        "TIM",
    })) "APB1ENR1" else if (util.match_name(peri_name, &.{
        "LPTIM2",
        "I2C4",
        "LPUART1EN",
    })) "APB1ENR2" else @panic("Unsported peripheral clock");

    @field(RCC, rcc_register_name).modify_one(field, state);
}

pub fn enable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 0);
}
