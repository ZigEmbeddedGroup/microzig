//NOTE: this file is only valid for densities: Low, Medium and High. Connectivity/XL line devices are not supported in this version.
//TODO: Add support for 105/107
const std = @import("std");
const ClockTree = @import("ClockTree").get_mcu_tree(microzig.config.chip_name);
const microzig = @import("microzig");
const power = @import("power.zig");
const enums = @import("../common/enums.zig");
const util = @import("../common/util.zig");

//expose only the configuration structs
pub const Config = ClockTree.Config;
const flash_v1 = microzig.chip.types.peripherals.flash_f1;
const flash = microzig.chip.peripherals.FLASH;
const PLLMUL = microzig.chip.types.peripherals.rcc_f1.PLLMUL;
const PLLSRC = microzig.chip.types.peripherals.rcc_f1.PLLSRC;
const PLLXTPRE = microzig.chip.types.peripherals.rcc_f1.PLLXTPRE;
const PPRE = microzig.chip.types.peripherals.rcc_f1.PPRE; //apb prescaler
const HPRE = microzig.chip.types.peripherals.rcc_f1.HPRE; // ahb prescaler
const ADCPRE = microzig.chip.types.peripherals.rcc_f1.ADCPRE;
const USBPRE = microzig.chip.types.peripherals.rcc_f1.USBPRE;
const RTCSEL = microzig.chip.types.peripherals.rcc_f1.RTCSEL;
const MCOSEL = microzig.chip.types.peripherals.rcc_f1.MCOSEL;
const SW = microzig.chip.types.peripherals.rcc_f1.SW;
const rcc = microzig.chip.peripherals.RCC;

const ClockInitError = error{
    HSETimeout,
    LSETimeout,
};

pub const Peripherals = enums.Peripherals;

pub const ResetReason = enum {
    low_power,
    window_watchdog,
    independent_watchdog,
    POR_or_PDR,
    NRST,
};

pub const Bus = enum {
    // AHB, //AHB cannot be reset by software
    APB1,
    APB2,
};

//default clock config
var current_clocks: ClockTree.Clock_Output = blk: {
    const out = ClockTree.get_clocks(.{}) catch unreachable;
    break :blk out.clock;
};

//NOTE: procedural style or loop through all elements of the struct?
///Configures the system clocks
///NOTE: to configure the backup domain clocks (RTC) it is necessary to enable it through the power
///register before configuring the clocks
pub fn apply(comptime config: ClockTree.Config) ClockInitError!ClockTree.Clock_Output {
    const out_data = comptime ClockTree.get_clocks(config) catch unreachable;
    try apply_internal(out_data.config);
    current_clocks = out_data.clock;
    return out_data.clock;
}

fn apply_internal(config: ClockTree.Config_Output) ClockInitError!void {
    const latency: flash_v1.LATENCY = if (config.FLatency) |lat| @enumFromInt(@as(u3, @intFromEnum(lat))) else .WS0;
    const prefetch = config.flags.PREFETCH_ENABLE;
    const apb1: ?PPRE = if (config.APB1CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else null;
    const apb2: ?PPRE = if (config.APB2CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else null;
    const ahb: ?HPRE = if (config.AHBCLKDivider) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else null;
    const adc: ?ADCPRE = if (config.ADCPresc) |pre| @enumFromInt(@as(u2, @intFromEnum(pre))) else null;
    const sys_clk: SW = if (config.SYSCLKSource) |src| @enumFromInt(@as(u2, @intFromEnum(src))) else .HSI;
    //USB prescaler enum is inverted
    const usb: ?USBPRE = if (config.USBPrescaler) |pre| @enumFromInt(@as(u1, @intFromEnum(pre)) ^ 1) else null;

    secure_enable();
    set_flash(latency, prefetch);

    if (config.flags.EnableHSE) {
        const timout = if (config.HSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
        try enable_hse(config.flags.HSEByPass, config.flags.EnbaleCSS, timout);
    } else {
        disable_hse();
    }

    if (config.flags.PLLUsed) {
        const source: PLLSRC = if (config.PLLSource) |src| @enumFromInt(@as(u1, @intFromEnum(src))) else PLLSRC.HSI_Div2;
        const mul: PLLMUL = if (config.PLLMUL) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else PLLMUL.Mul2;
        const pre_div: PLLXTPRE = if (config.HSEDivPLL) |pre| @enumFromInt(@as(u1, @intFromEnum(pre))) else PLLXTPRE.Div1;
        config_pll(source, mul, pre_div);
        enable_pll();
    } else {
        disable_pll();
    }

    set_peripherals_prescaler(apb1, apb2, ahb, adc, usb);

    //BACKUP DOMAIN CLOCK CONFIG

    if (config.flags.EnableLSE) {
        const timeout = if (config.LSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
        const bypass = config.flags.LSEByPass;
        try enable_lse(timeout, bypass);
    } else {
        disable_lse();
    }

    set_lsi(config.flags.LSIUsed);

    rtc_config: {
        if (config.flags.RTCEnable) {
            if (config.RTCClockSelection) |s| {
                const source = switch (s) {
                    .RCC_RTCCLKSOURCE_HSE_DIV128 => RTCSEL.HSE,
                    .RCC_RTCCLKSOURCE_LSE => RTCSEL.LSE,
                    .RCC_RTCCLKSOURCE_LSI => RTCSEL.LSI,
                };
                config_rtc(source);
                break :rtc_config;
            }
        }
        config_rtc(.DISABLE);
    }

    mco_config: {
        if (config.flags.MCOEnable) {
            if (config.RCC_MCOSource) |src| {
                const source: MCOSEL = switch (src) {
                    .RCC_MCO1SOURCE_HSE => .HSE,
                    .RCC_MCO1SOURCE_HSI => .HSI,
                    .RCC_MCO1SOURCE_PLLCLK => .PLL,
                    .RCC_MCO1SOURCE_SYSCLK => .SYS,
                };
                config_mco(source);
                break :mco_config;
            }
        }
        config_mco(.DISABLE);
    }

    //SYSTEM CLOCK CONFIG
    config_system_clock(sys_clk);

    //in case of HSI not used, we have to disable it here
    //becuse the system clock configuration 'secure_enable' enables it by default
    if (config.HSICalibrationValue) |val| {
        calib_hsi(@intFromFloat(val));
    }
    set_hsi(config.flags.HSIUsed);
}

pub inline fn set_flash(latency: flash_v1.LATENCY, prefetch: bool) void {
    flash.ACR.modify_one("LATENCY", latency);
    flash.ACR.modify_one("PRFTBE", @intFromBool(prefetch));
}

//force HSI Clock and clear any clock configs
pub fn secure_enable() void {
    set_hsi(true);

    rcc.BDCR.raw = 0;
    rcc.CFGR.raw = 0;
    while (rcc.CFGR.read().SWS != .HSI) {
        asm volatile ("" ::: .{ .memory = true });
    }

    rcc.CR.modify(.{
        .PLLON = 0,
        .HSEBYP = 0,
        .HSEON = 0,
        .CSSON = 0,
    });
}

pub fn set_hsi(on: bool) void {
    rcc.CR.modify(.{ .HSION = @intFromBool(on) });
    if (on) {
        while (rcc.CR.read().HSIRDY == 0) {
            asm volatile ("" ::: .{ .memory = true });
        }
    }
}

///configure the HSI calibration value
pub fn calib_hsi(calib: usize) void {
    //secure_enable has already started the HSE
    const trim: u5 = @truncate(calib);
    rcc.CR.modify(.{ .HSITRIM = trim });

    //wait for the HSI to stabilize
    for (0..16) |_| {
        asm volatile ("" ::: .{ .memory = true });
    }
}

fn set_lsi(on: bool) void {
    rcc.CSR.modify(.{ .LSION = @intFromBool(on) });
    if (on) {
        while (rcc.CSR.read().LSIRDY == 0) {
            asm volatile ("" ::: .{ .memory = true });
        }
    }
}

pub fn enable_hse(bypass: bool, css: bool, timeout: ?usize) ClockInitError!void {
    const max_wait: u32 = blk: {
        if (timeout) |val| {
            if (val != 0) {
                break :blk val;
            }
        }
        break :blk std.math.maxInt(usize);
    };
    var ticks: usize = calc_wait_ticks(max_wait - 1);

    rcc.CR.modify(.{
        .HSEON = 1,
        .HSEBYP = @intFromBool(bypass),
        .CSSON = @intFromBool(css),
    });
    while (rcc.CR.read().HSERDY == 0) {
        if (ticks == 0) return error.HSETimeout;
        ticks -= 1;
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_hse() void {
    rcc.CR.modify(.{ .CSSON = 0 });
    rcc.CR.modify(.{ .HSEON = 0 });
}

fn enable_lse(timeout: ?usize, bypass: bool) ClockInitError!void {
    const max_wait: u32 = blk: {
        if (timeout) |val| {
            if (val != 0) {
                break :blk val;
            }
        }
        break :blk std.math.maxInt(u32);
    };
    var ticks: usize = calc_wait_ticks(max_wait - 1);

    rcc.BDCR.modify_one("LSEBYP", @intFromBool(bypass));
    rcc.BDCR.modify(.{ .LSEON = 1 });
    while (rcc.BDCR.read().LSERDY == 0) {
        if (ticks == 0) return error.LSETimeout;
        ticks -= 1;
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_lse() void {
    rcc.BDCR.modify(.{ .LSEON = 0 });
}

pub fn config_pll(source: PLLSRC, mul: PLLMUL, pre_div: PLLXTPRE) void {
    rcc.CFGR.modify(.{ .PLLSRC = source });
    rcc.CFGR.modify(.{ .PLLMUL = mul });
    rcc.CFGR.modify(.{ .PLLXTPRE = pre_div });
}

//TODO: Add STM32F105/7 devices peri
pub fn set_peripherals_prescaler(
    apb1: ?PPRE,
    apb2: ?PPRE,
    ahb: ?HPRE,
    adc: ?ADCPRE,
    usb: ?USBPRE,
) void {
    if (apb1) |pre| {
        rcc.CFGR.modify(.{ .PPRE1 = pre });
    }

    if (apb2) |pre| {
        rcc.CFGR.modify(.{ .PPRE2 = pre });
    }

    if (ahb) |pre| {
        rcc.CFGR.modify(.{ .HPRE = pre });
    }

    if (adc) |pre| {
        rcc.CFGR.modify(.{ .ADCPRE = pre });
    }

    if (usb) |pre| {
        rcc.CFGR.modify(.{ .USBPRE = pre });
    }
}

fn config_system_clock(system_clock: SW) void {
    rcc.CFGR.modify(.{ .SW = system_clock });
    while (true) {
        const sws = rcc.CFGR.read().SWS;
        if (sws == system_clock) break;
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn enable_pll() void {
    rcc.CR.modify(.{ .PLLON = 1 });
    while (rcc.CR.read().PLLRDY == 0) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn disable_pll() void {
    rcc.CR.modify(.{ .PLLON = 0 });
    while (rcc.CR.read().PLLRDY != 0) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn config_rtc(source: RTCSEL) void {

    //enable backup domain write acess
    enable_clock(.PWR);
    enable_clock(.BKP);
    power.backup_domain_protection(false);
    if (source == .HSE) {
        reset_backup_domain(); //HSE as RTC source requires full reset of the bkp domain
        power.backup_domain_protection(false);
    }

    rcc.BDCR.modify(.{ .RTCSEL = source });
    power.backup_domain_protection(true);

    // Disable and reset clocks to avoid potential conflicts with the main application
    disable_clock(.BKP);
    reset_clock(.BKP);
    disable_clock(.PWR);
    reset_clock(.PWR);
}

pub fn config_mco(source: MCOSEL) void {
    rcc.CFGR.modify(.{ .MCOSEL = source });
}

///after the reset, the BDRD becomes read_only until access is released by the power register
///this function can also be called from `backup.reset()`
pub fn reset_backup_domain() void {
    rcc.BDCR.modify(.{ .BDRST = 1 });
    for (0..5) |i| {
        std.mem.doNotOptimizeAway(i);
    }
    rcc.BDCR.modify(.{ .BDRST = 0 });
}

///configure the power and clock registers before enabling the RTC
///this function also can be called from `rtc.enable()`
pub fn enable_rtc(on: bool) void {
    rcc.BDCR.modify(.{ .RTCEN = @intFromBool(on) });
}

///backup domain is not reset with the rest of the system
///so this function can be used to check if the RTC is already running.
pub fn rtc_running() bool {
    return rcc.BDCR.read().RTCEN != 0;
}

///This function is called internally by the HAL, the RESET value should only be read after the RESET
///read the Reset value through the global variable hal.RESET
pub fn get_reset_reason() ResetReason {
    const flags = rcc.CSR.read();
    const rst: ResetReason = blk: {
        if (flags.PINRSTF == 1) break :blk ResetReason.NRST;
        if (flags.PORRSTF == 1) break :blk ResetReason.POR_or_PDR;
        if (flags.SFTRSTF == 1) break :blk ResetReason.low_power;
        if (flags.IWDGRSTF == 1) break :blk ResetReason.independent_watchdog;
        if (flags.WWDGRSTF == 1) break :blk ResetReason.window_watchdog;
        if (flags.LPWRRSTF == 1) break :blk ResetReason.low_power;
        break :blk ResetReason.POR_or_PDR;
    };

    rcc.CSR.modify(.{ .RMVF = 1 });
    return rst;
}

///reset the selected peripheral to they default state.
///this is useful to get the peripheral out of a deadlock state or
///to put the peripheral in a known state before configuring it.
///
///NOTE: this function does not effect the ENR (clock enable) registers.
pub fn reset_clock(comptime peri: Peripherals) void {
    const peri_name = @tagName(peri);
    const field = peri_name ++ "RST";
    const rcc_register_name = comptime if (util.match_name(peri_name, &.{
        "AFIO",
        "GPIO",
        "ADC",
        "TIM1",
        "SPI1",
        "USART1",
    })) "APB2RSTR" else if (util.match_name(peri_name, &.{
        "TIM",
        "WWDG",
        "SPI",
        "USART",
        "UART",
        "I2C",
        "CAN",
        "BKP",
        "PWR",
        "DAC",
    })) "APB1RSTR" else @panic("No reset possible for this peripheral");

    @field(rcc, rcc_register_name).modify_one(field, 1);
    //release the reset, this is necessary because the reset bits are not self-clearing
    //write 0 to all bits is safe becuse 0 does nothing (other than releasing the reset)
    @field(rcc, rcc_register_name).raw = 0;
}

pub fn set_clock(comptime peri: Peripherals, state: u1) void {
    const peri_name = @tagName(peri);
    const field = peri_name ++ "EN";
    if (util.match_name(peri_name, &.{"RTC"})) {
        enable_rtc(state != 0);
        return;
    }
    const rcc_register_name = comptime if (util.match_name(peri_name, &.{
        "DMA",
        "FLASH",
        "CRC",
        "FSMC",
        "SDIO",
    })) "AHBENR" else if (util.match_name(peri_name, &.{
        "AFIO",
        "GPIO",
        "ADC",
        "TIM1",
        "SPI1",
        "USART1",
    })) "APB2ENR" else "APB1ENR";

    @field(rcc, rcc_register_name).modify_one(field, state);
}

pub fn enable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 0);
}

pub fn enable_all_clocks() void {
    //enable all clocks
    rcc.AHBENR.raw = std.math.maxInt(u32);
    rcc.APB1ENR.raw = std.math.maxInt(u32);
    rcc.APB2ENR.raw = std.math.maxInt(u32);
}

pub fn disable_all_clocks() void {
    //disable all clocks
    rcc.AHBENR.raw = 0;
    rcc.APB1ENR.raw = 0;
    rcc.APB2ENR.raw = 0;
}

///Reset all periferals of the specified bus to they default state.
///NOTE: this function does not effect the ENR registers.
pub fn reset_bus(bus: Bus) void {
    //first write 1 to all bits to reset them
    //then write 0 to all bits to release the reset
    //this is necessary because the reset bits are not self-clearing
    switch (bus) {
        .APB1 => {
            rcc.APB1RSTR.raw = std.math.maxInt(u32);
            rcc.APB1RSTR.raw = 0;
        },
        .APB2 => {
            rcc.APB2RSTR.raw = std.math.maxInt(u32);
            rcc.APB2RSTR.raw = 0;
        },
    }
}
//NOTE: should we panic on invalid clocks?
//errors at comptime appear for peripherals manually configured like USB.
///if requests the clock of an unconfigured peripheral, 0 means error, != 0 means ok
pub fn get_clock(comptime source: Peripherals) u32 {
    const peri_name = @tagName(source);
    const clock = if (util.match_name(peri_name, &.{
        "DMA",
        "FLASH",
        "CRC",
    })) current_clocks.AHBOutput else if (util.match_name(peri_name, &.{
        "FSMC",
    })) current_clocks.FSMClkOutput else if (util.match_name(peri_name, &.{
        "SDIO",
    })) current_clocks.SDIOClkOutput else if (util.match_name(peri_name, &.{
        "AFIO",
        "GPIO",
        "SPI1",
        "UUSART1",
    })) current_clocks.APB2Prescaler else if (util.match_name(peri_name, &.{
        "ADC",
    })) current_clocks.ADCoutput else if (util.match_name(peri_name, &.{
        "TIM1",
    })) current_clocks.TimPrescalerAPB2 else if (util.match_name(peri_name, &.{
        "TIM",
    })) current_clocks.TimPrescalerAPB1 else if (util.match_name(peri_name, &.{
        "DAC",
    })) current_clocks.APB1Output else if (util.match_name(peri_name, &.{
        "WWDG",
        "SPI",
        "USART",
        "UART",
        "I2C",
        "CAN",
        "BKP",
        "PWR",
    })) current_clocks.APB1Output else if (util.match_name(peri_name, &.{
        "USB",
    })) current_clocks.USBoutput else if (util.match_name(peri_name, &.{
        "RTC",
    })) current_clocks.RTCOutput else @panic("Unknown clock for peripheral");
    return @intFromFloat(clock);
}

pub inline fn get_sys_clk() u32 {
    return @intFromFloat(current_clocks.SysCLKOutput);
}

inline fn calc_wait_ticks(val: usize) usize {
    const corrent_clock: usize = @intFromFloat(current_clocks.SysCLKOutput);
    const ms_per_tick = corrent_clock / 1000;
    return ms_per_tick * val;
}

pub fn enable_dma(index: enums.DMA_Type) void {
    switch (index) {
        .DMA1 => rcc.AHBENR.modify(.{ .DMA1EN = 1 }),
    }
}
