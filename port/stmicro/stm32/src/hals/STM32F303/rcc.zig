/// This RCC config file apply to
/// 303xB or 303xC only. (regz using rcc_f3v1 from ambassy)
///
/// Other chip D/E/6/8 have different clock tree
/// In the future we can switch on chip name to address
/// this limitation.
const microzig = @import("microzig");
const Clock_Device = microzig.drivers.base.Clock_Device;
const enums = @import("../common/enums.zig");
const util = @import("../common/util.zig");
const clock_tree = @import("ClockTree").get_mcu_tree(microzig.config.chip_name);
const app = microzig.app;

pub const RCC_Peripheral = @This();

// Expose only configurations structs
pub const Config = clock_tree.Config;

const RCC = microzig.chip.peripherals.RCC;
const FLASH = microzig.chip.peripherals.FLASH;
const LATENCY = microzig.chip.types.peripherals.flash_f3.LATENCY;
const PREDIV = microzig.chip.types.peripherals.rcc_f3v1.PREDIV;
const HPRE = microzig.chip.types.peripherals.rcc_f3v1.HPRE;
const PPRE = microzig.chip.types.peripherals.rcc_f3v1.PPRE;
const ADCPRES = microzig.chip.types.peripherals.rcc_f3v1.ADCPRES;
const USBPRE = microzig.chip.types.peripherals.rcc_f3v1.USBPRE;

const PLLMUL = microzig.chip.types.peripherals.rcc_f3v1.PLLMUL;
const PLLSRC = microzig.chip.types.peripherals.rcc_f3v1.PLLSRC;
const ICSW = microzig.chip.types.peripherals.rcc_f3v1.ICSW;
const ISSRC = microzig.chip.types.peripherals.rcc_f3v1.ISSRC;
const SW = microzig.chip.types.peripherals.rcc_f3v1.SW;
const TIM2SW = microzig.chip.types.peripherals.rcc_f3v1.TIM2SW;
const TIMSW = microzig.chip.types.peripherals.rcc_f3v1.TIMSW;
const USART1SW = microzig.chip.types.peripherals.rcc_f3v1.USART1SW;
const USARTSW = microzig.chip.types.peripherals.rcc_f3v1.USARTSW;

pub const Peripherals = enums.Peripherals;

// The current running clock
pub const current_clocks: clock_tree.Tree_Output = clock_tree.get_clocks(microzig.options.hal.rcc_clock_config) catch unreachable;

pub fn apply() void {
    apply_flash_flash();
    apply_prescaler();

    // Configure primary clock source if need be
    apply_hse();
    apply_hsi();
    apply_pll();

    clean_clock();
    select_clock();
}

fn apply_flash_flash() void {
    const latency: LATENCY = if (current_clocks.config.FLatency) |lat| @enumFromInt(@as(u3, @intFromEnum(lat))) else .WS0;
    const prefetch: u1 = if (current_clocks.config.flags.PREFETCH_ENABLE) 1 else 0;

    FLASH.ACR.modify(.{ .LATENCY = latency, .PRFTBE = prefetch });
}

fn apply_pll() void {
    if (!current_clocks.config.flags.PLLUsed) {
        return;
    }
    const source: PLLSRC = if (current_clocks.config.PLLSource) |src| @enumFromInt(@as(u1, @intCast(src.get()))) else .HSI_Div2;
    const mul: PLLMUL = if (current_clocks.config.PLLMUL) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else .Mul2;
    // TODO: ClockHelper need fix for STM32F303xC/xB
    // const divider: PREDIV = if (current_clocks.config.PLLDivider) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else .Div1;
    //RCC.CFGR2.modify(.{ .PREDIV = divider });

    RCC.CFGR.modify(.{
        .PLLSRC = source,
        .PLLMUL = mul,
    });
    RCC.CR.modify(.{ .PLLON = 1 });

    while (RCC.CR.read().PLLRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

fn apply_hsi() void {
    if (!current_clocks.config.flags.HSIUsed) {
        return;
    }
    RCC.CR.modify(.{
        .HSION = 1,
    });

    while (RCC.CR.read().HSIRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

fn apply_hse() void {
    if (!current_clocks.config.flags.HSEUsed) {
        return;
    } else {
        const hse_by_pass: u1 = if (current_clocks.config.flags.HSEByPass) 1 else 0;
        RCC.CR.modify(.{
            .HSEON = 1,
            .HSEBYP = hse_by_pass,
        });

        while (RCC.CR.read().HSERDY != 1) {
            asm volatile ("" ::: .{ .memory = true });
        }
    }
}

fn apply_prescaler() void {
    const apb1: PPRE = if (current_clocks.config.APB1CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else .Div1;
    const apb2: PPRE = if (current_clocks.config.APB2CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else .Div1;
    const ahb: HPRE = if (current_clocks.config.AHBCLKDivider) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else .Div1;
    const adc12: ADCPRES = if (current_clocks.config.ADC12PRES) |pre| @enumFromInt(@as(u5, @intFromEnum(pre))) else .Div1;
    const adc34: ADCPRES = if (current_clocks.config.ADC34PRES) |pre| @enumFromInt(@as(u5, @intFromEnum(pre))) else .Div1;
    const usbprescal: USBPRE = if (current_clocks.config.PRESCALERUSB) |pre| @enumFromInt(@as(u1, @intFromEnum(pre))) else .Div1;

    RCC.CFGR.modify(.{
        .HPRE = ahb,
        .PPRE1 = apb1,
        .PPRE2 = apb2,
        .USBPRE = usbprescal,
    });
    RCC.CFGR2.modify(.{
        .ADC12PRES = adc12,
        .ADC34PRES = adc34,
    });
}

// Once all clock is setup for the system
// we can disable all clock not used
fn clean_clock() void {
    if (current_clocks.config.flags.EnbaleCSS) {
        RCC.CR.modify(.{ .CSSON = 0 });
    }
    if (!current_clocks.config.flags.HSEUsed) {
        RCC.CR.modify(.{ .HSEON = 0 });
    }
    if (!current_clocks.config.flags.HSEUsed) {
        RCC.CR.modify(.{ .HSION = 0 });
    }
    if (!current_clocks.config.flags.PLLUsed) {
        RCC.CR.modify(.{ .PLLON = 0 });
    }
}

// TODO: Patch for ClockTree
fn usart1_selection(src: anytype) USART1SW {
    return switch (src) {
        .RCC_USART1CLKSOURCE_SYSCLK => .SYS,
        .RCC_USART1CLKSOURCE_HSI => .HSI,
        .RCC_USART1CLKSOURCE_LSE => .LSE,
        .RCC_USART1CLKSOURCE_PCLK1 => unreachable,
        .RCC_USART1CLKSOURCE_PCLK2 => .PCLK2,
    };
}

// TODO: Patch for ClockTree
fn usart2_selection(src: anytype) USARTSW {
    return switch (src) {
        .RCC_USART2CLKSOURCE_SYSCLK => .SYS,
        .RCC_USART2CLKSOURCE_HSI => .HSI,
        .RCC_USART2CLKSOURCE_LSE => .LSE,
        .RCC_USART2CLKSOURCE_PCLK1 => .PCLK1,
    };
}

// TODO: Patch for ClockTree
fn usart3_selection(src: anytype) USARTSW {
    return switch (src) {
        .RCC_USART3CLKSOURCE_SYSCLK => .SYS,
        .RCC_USART3CLKSOURCE_HSI => .HSI,
        .RCC_USART3CLKSOURCE_LSE => .LSE,
        .RCC_USART3CLKSOURCE_PCLK1 => .PCLK1,
    };
}

// TODO: Patch for ClockTree
fn uart4_selection(src: anytype) USARTSW {
    return switch (src) {
        .RCC_UART4CLKSOURCE_SYSCLK => .SYS,
        .RCC_UART4CLKSOURCE_HSI => .HSI,
        .RCC_UART4CLKSOURCE_LSE => .LSE,
        .RCC_UART4CLKSOURCE_PCLK1 => .PCLK1,
    };
}

// TODO: Patch for ClockTree
fn uart5_selection(src: anytype) USARTSW {
    return switch (src) {
        .RCC_UART5CLKSOURCE_SYSCLK => .SYS,
        .RCC_UART5CLKSOURCE_HSI => .HSI,
        .RCC_UART5CLKSOURCE_LSE => .LSE,
        .RCC_UART5CLKSOURCE_PCLK1 => .PCLK1,
    };
}

// TODO: Patch for ClockTree
fn i2s_selection(src: anytype) ISSRC {
    return switch (src) {
        .RCC_I2SCLKSOURCE_EXT => .CKIN,
        .RCC_I2SCLKSOURCE_SYSCLK => .SYS,
    };
}

pub fn select_clock() void {
    const sys_clk: SW = if (current_clocks.config.SYSCLKSource) |src| @enumFromInt(@as(u2, @intFromEnum(src))) else .HSI;
    const i2s_clk: ISSRC = if (current_clocks.config.I2SClockSource) |src| i2s_selection(src) else .SYS;
    const i2c1_clk: ICSW = if (current_clocks.config.I2c1ClockSelection) |src| @enumFromInt(@as(u1, @intCast(src.get()))) else .HSI;
    const i2c2_clk: ICSW = if (current_clocks.config.I2c1ClockSelection) |src| @enumFromInt(@as(u1, @intCast(src.get()))) else .HSI;

    const usart1_clk: USART1SW = if (current_clocks.config.Usart1ClockSelection) |src| usart1_selection(src) else .HSI;
    const usart2_clk: USARTSW = if (current_clocks.config.Usart2ClockSelection) |src| usart2_selection(src) else .HSI;
    const usart3_clk: USARTSW = if (current_clocks.config.Usart3ClockSelection) |src| usart3_selection(src) else .HSI;
    const uart4_clk: USARTSW = if (current_clocks.config.Uart4ClockSelection) |src| uart4_selection(src) else .HSI;
    const uart5_clk: USARTSW = if (current_clocks.config.Uart5ClockSelection) |src| uart5_selection(src) else .HSI;

    RCC.CFGR.modify(.{
        .SW = sys_clk,
        .I2SSRC = i2s_clk,
    });
    RCC.CFGR3.modify(.{
        .USART1SW = usart1_clk,
        .USART2SW = usart2_clk,
        .USART3SW = usart3_clk,
        .UART4SW = uart4_clk,
        .UART5SW = uart5_clk,
        .I2C1SW = i2c1_clk,
        .I2C2SW = i2c2_clk,
    });
}

pub fn get_clock(comptime source: Peripherals) u32 {
    const peri_name = @tagName(source);

    if (comptime util.match_name(peri_name, &.{
        "TIM",
    })) {
        return @intFromFloat(@field(current_clocks.clock, peri_name ++ "out"));
    }
    if (comptime util.match_name(peri_name, &.{
        "USART",
        "UART",
        "I2C",
        "RTC",
    })) {
        return @intFromFloat(@field(current_clocks.clock, peri_name ++ "Output"));
    }
    if (comptime util.match_name(peri_name, &.{
        "DMA",
        "FLASH",
        "CRC",
        "GPIO",
    })) {
        return @intFromFloat(current_clocks.clock.AHBOutput);
    }
    if (comptime util.match_name(peri_name, &.{
        "ADC1",
        "ADC2",
    })) {
        return @intFromFloat(current_clocks.clock.ADC12output);
    }
    if (comptime util.match_name(peri_name, &.{
        "ADC3",
        "ADC4",
    })) {
        return @intFromFloat(current_clocks.clock.ADC34output);
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI1",
    })) {
        return @intFromFloat(current_clocks.clock.APB2Prescaler);
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI2",
        "SPI3",
        "DAC",
        "CAN",
        "WWDG",
        "IWDG",
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
    if (comptime util.match_name(peri_name, &.{"RTC"})) {
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
