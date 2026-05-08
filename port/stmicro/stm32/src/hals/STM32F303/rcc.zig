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
const ClockTree = @import("ClockTree");
const Tree = @field(ClockTree, microzig.config.chip_name);
const app = microzig.app;

pub const RCC_Peripheral = @This();

// Expose only configurations structs
pub const Config = Tree.Config;

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
pub const current_clocks: Tree.TreeOutput = Tree.get_clocks(microzig.options.hal.rcc_clock_config) catch unreachable;

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
    const latency: LATENCY = @enumFromInt(@intFromEnum(current_clocks.config.FLatency));
    const prefetch: u1 = if (current_clocks.config.flags.PREFETCH_ENABLE) 1 else 0;

    FLASH.ACR.modify(.{ .LATENCY = latency, .PRFTBE = prefetch });
}

fn apply_pll() void {
    if (!current_clocks.config.flags.PLLUsed) {
        return;
    }
    const source: PLLSRC = @enumFromInt(@intFromEnum(current_clocks.config.PLLSourceVirtual));
    const mul: PLLMUL = @enumFromInt(@intFromEnum(current_clocks.config.PLLMUL));

    //only on STM32F303E clocktree for DIE446
    comptime if (Tree.check_MCU("DIE446")) {
        const divider: PREDIV = @enumFromInt(@intFromEnum(current_clocks.config.PLLDivider));
        RCC.CFGR2.modify(.{ .PREDIV = divider });
    };

    RCC.CFGR.modify(.{
        .PLLSRC = source,
        .PLLMUL = mul,
    });
    RCC.CR.modify(.{ .PLLON = 1 });

    while (RCC.CR.read().PLLRDY != 1) {
        asm volatile ("");
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
        asm volatile ("");
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
            asm volatile ("");
        }
    }
}

fn apply_prescaler() void {
    const apb1: PPRE = @enumFromInt(@intFromEnum(current_clocks.config.APB1CLKDivider));
    const apb2: PPRE = @enumFromInt(@intFromEnum(current_clocks.config.APB2CLKDivider));
    const ahb: HPRE = @enumFromInt(@intFromEnum(current_clocks.config.AHBCLKDivider));
    const adc12: ADCPRES = @enumFromInt(@intFromEnum(current_clocks.config.ADC12PRES));
    const adc34: ADCPRES = @enumFromInt(@intFromEnum(current_clocks.config.ADC34PRES));
    const usbprescal: USBPRE = @enumFromInt(@intFromEnum(current_clocks.config.PRESCALERUSB));

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

pub fn select_clock() void {
    const sys_clk: SW = @enumFromInt(@intFromEnum(current_clocks.config.SYSCLKSourceVirtual));
    const i2s_clk: ISSRC = @enumFromInt(@intFromEnum(current_clocks.config.I2SClockSource));
    const i2c1_clk: ICSW = @enumFromInt(@intFromEnum(current_clocks.config.I2c1ClockSelection));
    const i2c2_clk: ICSW = @enumFromInt(@intFromEnum(current_clocks.config.I2c2ClockSelection));

    const usart1_clk: USART1SW = @enumFromInt(@intFromEnum(current_clocks.config.Usart1ClockSelection));
    const usart2_clk: USARTSW = @enumFromInt(@intFromEnum(current_clocks.config.Usart2ClockSelection));
    const usart3_clk: USARTSW = @enumFromInt(@intFromEnum(current_clocks.config.Usart3ClockSelection));
    const uart4_clk: USARTSW = @enumFromInt(@intFromEnum(current_clocks.config.Uart4ClockSelection));
    const uart5_clk: USARTSW = @enumFromInt(@intFromEnum(current_clocks.config.Uart5ClockSelection));

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
        return @intCast(@field(current_clocks.clock, peri_name ++ "out"));
    }
    if (comptime util.match_name(peri_name, &.{
        "USART",
        "UART",
        "I2C",
        "RTC",
    })) {
        return @intCast(@field(current_clocks.clock, peri_name ++ "Output"));
    }
    if (comptime util.match_name(peri_name, &.{
        "DMA",
        "FLASH",
        "CRC",
        "GPIO",
    })) {
        return @intCast(current_clocks.clock.AHBOutput);
    }
    if (comptime util.match_name(peri_name, &.{
        "ADC1",
        "ADC2",
    })) {
        return @intCast(current_clocks.clock.ADC12output);
    }
    if (comptime util.match_name(peri_name, &.{
        "ADC3",
        "ADC4",
    })) {
        return @intCast(current_clocks.clock.ADC34output);
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI1",
    })) {
        return @intCast(current_clocks.clock.APB2Prescaler);
    }
    if (comptime util.match_name(peri_name, &.{
        "SPI2",
        "SPI3",
        "DAC",
        "CAN",
        "WWDG",
        "IWDG",
    })) {
        return @intCast(current_clocks.clock.APB1Prescaler);
    }
    if (comptime util.match_name(peri_name, &.{
        "USB",
    })) {
        return @intCast(current_clocks.clock.USBoutput);
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
