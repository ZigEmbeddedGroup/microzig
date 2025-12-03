//NOTE: this file is only valid for densities: Low, Medium and High. Connectivity/XL line devices are not supported in this version.
//TODO: Add support for 105/107

const std = @import("std");
const microzig = @import("microzig");

const find_clocktree = @import("mcu_trees.zig").find_clock_tree;
const ClockTree = find_clocktree(microzig.config.chip_name);
const power = @import("power.zig");

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

pub const RccPeriferals = enum {
    DMA1,
    DMA2,
    SRAM,
    FLASH,
    CRC,
    FSMC, //F103xE
    SDIO, //F103xC/D/E

    // APB2ENR (APB2 peripherals)
    AFIO,
    GPIOA,
    GPIOB,
    GPIOC,
    GPIOD,
    GPIOE,
    GPIOF, //F103xE
    GPIOG, //F103xE
    ADC1,
    ADC2,
    TIM1,
    SPI1,
    USART1,

    // APB1ENR (APB1 peripherals)
    TIM2,
    TIM3,
    TIM4,
    TIM5, //F103xE
    TIM6, //F103xE
    TIM7, //F103xE
    WWDG,
    SPI2,
    SPI3, //F103xD/E
    USART2,
    USART3,
    UART4, //F103xC/D/E
    UART5, //F103xC/D/E
    I2C1,
    I2C2,
    USB,
    CAN,
    BKP,
    PWR,
    DAC, //F103xE

    //BKP
    RTC,
};

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
var corrent_clocks: ClockTree.Clock_Output = blk: {
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
    corrent_clocks = out_data.clock;
    return out_data.clock;
}

fn apply_internal(config: ClockTree.Config_Output) ClockInitError!void {
    const latency: flash_v1.LATENCY = if (config.FLatency) |lat| @enumFromInt(@as(u3, @intFromEnum(lat))) else .WS0;
    const prefetch = if (config.PREFETCH_ENABLE) |pre| (pre == .@"1") else false;
    const apb1: ?PPRE = if (config.APB1CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else null;
    const apb2: ?PPRE = if (config.APB2CLKDivider) |pre| @enumFromInt(@as(u3, @intFromEnum(pre))) else null;
    const ahb: ?HPRE = if (config.AHBCLKDivider) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else null;
    const adc: ?ADCPRE = if (config.ADCPresc) |pre| @enumFromInt(@as(u2, @intFromEnum(pre))) else null;
    const sys_clk: SW = if (config.SYSCLKSource) |src| @enumFromInt(@as(u2, @intFromEnum(src))) else .HSI;
    //USB prescaler enum is inverted
    const usb: ?USBPRE = if (config.USBPrescaler) |pre| @enumFromInt(@as(u1, @intFromEnum(pre)) ^ 1) else null;

    secure_enable();
    set_flash(latency, prefetch);

    hse_config: {
        if (config.EnableHSE) |en| {
            switch (en) {
                .true => {
                    const timout = if (config.HSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
                    try enable_hse(config.flags.HSEByPass, timout);
                    break :hse_config;
                },
                else => {},
            }
        }
        disable_hse();
    }

    pll_config: {
        if (config.PLLUsed) |en| {
            if (en != 0) {
                const source: PLLSRC = if (config.PLLSource) |src| @enumFromInt(@as(u1, @intFromEnum(src))) else PLLSRC.HSI_Div2;
                const mul: PLLMUL = if (config.PLLMUL) |pre| @enumFromInt(@as(u4, @intFromEnum(pre))) else PLLMUL.Mul2;
                const pre_div: PLLXTPRE = if (config.HSEDivPLL) |pre| @enumFromInt(@as(u1, @intFromEnum(pre))) else PLLXTPRE.Div1;
                config_pll(source, mul, pre_div);
                enable_pll();
                break :pll_config;
            }
        }
        disable_pll();
    }

    set_peripherals_prescaler(apb1, apb2, ahb, adc, usb);

    //BACKUP DOMAIN CLOCK CONFIG

    lse_config: {
        if (config.EnableLSE) |en| {
            switch (en) {
                .true => {
                    const timeout = if (config.LSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
                    const bypass = config.flags.LSEByPass;
                    try enable_lse(timeout, bypass);
                    break :lse_config;
                },
                else => {},
            }
        }
        disable_lse();
    }

    lsi_config: {
        if (config.LSIUsed) |en| {
            set_lsi(en != 0);
            break :lsi_config;
        }
        set_lsi(false);
    }

    rtc_config: {
        if (config.RTCEnable) |en| {
            switch (en) {
                .true => {
                    if (config.RTCClockSelection) |s| {
                        const source = switch (s) {
                            .RCC_RTCCLKSOURCE_HSE_DIV128 => RTCSEL.HSE,
                            .RCC_RTCCLKSOURCE_LSE => RTCSEL.LSE,
                            .RCC_RTCCLKSOURCE_LSI => RTCSEL.LSI,
                        };

                        config_rtc(source);
                        break :rtc_config;
                    }
                },
                else => {},
            }
        }
        config_rtc(.DISABLE);
    }
    mco_config: {
        if (config.MCOEnable) |en| {
            switch (en) {
                .true => {
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
                },
                else => {},
            }
        }
        config_mco(.DISABLE);
    }

    //SYSTEM CLOCK CONFIG
    config_system_clock(sys_clk);

    //in case of HSI not used, we have to disable it here
    //becuse the system clock configuration 'secure_enable' enables it by default
    hsi_config: {
        if (config.HSIUsed) |en| {
            set_hsi(en != 0);
            if (config.HSICalibrationValue) |val| {
                calib_hsi(@intFromFloat(val));
            }
            break :hsi_config;
        }
        set_hsi(false);
    }
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

pub fn enable_hse(bypass: bool, timeout: ?usize) ClockInitError!void {
    const max_wait: u32 = blk: {
        if (timeout) |val| {
            if (val != 0) {
                break :blk val;
            }
        }
        break :blk std.math.maxInt(usize);
    };
    var ticks: usize = calc_wait_ticks(max_wait - 1);

    rcc.CR.modify_one("HSEBYP", @intFromBool(bypass));
    rcc.CR.modify(.{ .HSEON = 1 });
    while (rcc.CR.read().HSERDY == 0) {
        if (ticks == 0) return error.HSETimeout;
        ticks -= 1;
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_hse() void {
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
pub fn reset_clock(peri: RccPeriferals) void {

    //set the selected peripheral reset bit
    switch (peri) {
        // APB2RSTR (APB2 peripherals)
        .AFIO => rcc.APB2RSTR.modify(.{ .AFIORST = 1 }),
        .GPIOA => rcc.APB2RSTR.modify(.{ .GPIOARST = 1 }),
        .GPIOB => rcc.APB2RSTR.modify(.{ .GPIOBRST = 1 }),
        .GPIOC => rcc.APB2RSTR.modify(.{ .GPIOCRST = 1 }),
        .GPIOD => rcc.APB2RSTR.modify(.{ .GPIODRST = 1 }),
        .GPIOE => rcc.APB2RSTR.modify(.{ .GPIOERST = 1 }),
        .GPIOF => rcc.APB2RSTR.modify(.{ .GPIOFRST = 1 }), //F103xE
        .GPIOG => rcc.APB2RSTR.modify(.{ .GPIOGRST = 1 }), //F103xE
        .ADC1 => rcc.APB2RSTR.modify(.{ .ADC1RST = 1 }),
        .ADC2 => rcc.APB2RSTR.modify(.{ .ADC2RST = 1 }),
        .TIM1 => rcc.APB2RSTR.modify(.{ .TIM1RST = 1 }),
        .SPI1 => rcc.APB2RSTR.modify(.{ .SPI1RST = 1 }),
        .USART1 => rcc.APB2RSTR.modify(.{ .USART1RST = 1 }),

        // APB1RSTR (APB1 peripherals)
        .TIM2 => rcc.APB1RSTR.modify(.{ .TIM2RST = 1 }),
        .TIM3 => rcc.APB1RSTR.modify(.{ .TIM3RST = 1 }),
        .TIM4 => rcc.APB1RSTR.modify(.{ .TIM4RST = 1 }),
        .TIM5 => rcc.APB1RSTR.modify(.{ .TIM5RST = 1 }), //F103xE
        .TIM6 => rcc.APB1RSTR.modify(.{ .TIM6RST = 1 }), //F103xE
        .TIM7 => rcc.APB1RSTR.modify(.{ .TIM7RST = 1 }), //F103xE
        .WWDG => rcc.APB1RSTR.modify(.{ .WWDGRST = 1 }),
        .SPI2 => rcc.APB1RSTR.modify(.{ .SPI2RST = 1 }),
        .SPI3 => rcc.APB1RSTR.modify(.{ .SPI3RST = 1 }), //F103xD/E
        .USART2 => rcc.APB1RSTR.modify(.{ .USART2RST = 1 }),
        .USART3 => rcc.APB1RSTR.modify(.{ .USART3RST = 1 }),
        .UART4 => rcc.APB1RSTR.modify(.{ .UART4RST = 1 }), //F103xC/D/E
        .UART5 => rcc.APB1RSTR.modify(.{ .UART5RST = 1 }), //F103xC/D/E
        .I2C1 => rcc.APB1RSTR.modify(.{ .I2C1RST = 1 }),
        .I2C2 => rcc.APB1RSTR.modify(.{ .I2C2RST = 1 }),
        .USB => rcc.APB1RSTR.modify(.{ .USBRST = 1 }),
        .CAN => rcc.APB1RSTR.modify(.{ .CANRST = 1 }),
        .BKP => rcc.APB1RSTR.modify(.{ .BKPRST = 1 }),
        .PWR => rcc.APB1RSTR.modify(.{ .PWRRST = 1 }),
        .DAC => rcc.APB1RSTR.modify(.{ .DACRST = 1 }), //F103xE
        else => {},
    }
    //release the reset, this is necessary because the reset bits are not self-clearing
    //write 0 to all bits is safe becuse 0 does nothing (other than releasing the reset)
    rcc.APB2RSTR.raw = 0;
    rcc.APB1RSTR.raw = 0;
}

pub fn set_clock(peri: RccPeriferals, state: u1) void {
    switch (peri) {
        .DMA1 => rcc.AHBENR.modify(.{ .DMA1EN = state }),
        .DMA2 => rcc.AHBENR.modify(.{ .DMA2EN = state }),
        .SRAM => rcc.AHBENR.modify(.{ .SRAMEN = state }),
        .FLASH => rcc.AHBENR.modify(.{ .FLASHEN = state }),
        .CRC => rcc.AHBENR.modify(.{ .CRCEN = state }),
        .FSMC => rcc.AHBENR.modify(.{ .FSMCEN = state }), //F103xE
        .SDIO => rcc.AHBENR.modify(.{ .SDIOEN = state }), //F103xC/D/E

        // APB2ENR (APB2 peripherals)
        .AFIO => rcc.APB2ENR.modify(.{ .AFIOEN = state }),
        .GPIOA => rcc.APB2ENR.modify(.{ .GPIOAEN = state }),
        .GPIOB => rcc.APB2ENR.modify(.{ .GPIOBEN = state }),
        .GPIOC => rcc.APB2ENR.modify(.{ .GPIOCEN = state }),
        .GPIOD => rcc.APB2ENR.modify(.{ .GPIODEN = state }),
        .GPIOE => rcc.APB2ENR.modify(.{ .GPIOEEN = state }),
        .GPIOF => rcc.APB2ENR.modify(.{ .GPIOFEN = state }), //F103xE
        .GPIOG => rcc.APB2ENR.modify(.{ .GPIOGEN = state }), //F103xE
        .ADC1 => rcc.APB2ENR.modify(.{ .ADC1EN = state }),
        .ADC2 => rcc.APB2ENR.modify(.{ .ADC2EN = state }),
        .TIM1 => rcc.APB2ENR.modify(.{ .TIM1EN = state }),
        .SPI1 => rcc.APB2ENR.modify(.{ .SPI1EN = state }),
        .USART1 => rcc.APB2ENR.modify(.{ .USART1EN = state }),

        // APB1ENR (APB1 peripherals)
        .TIM2 => rcc.APB1ENR.modify(.{ .TIM2EN = state }),
        .TIM3 => rcc.APB1ENR.modify(.{ .TIM3EN = state }),
        .TIM4 => rcc.APB1ENR.modify(.{ .TIM4EN = state }),
        .TIM5 => rcc.APB1ENR.modify(.{ .TIM5EN = state }), //F103xE
        .TIM6 => rcc.APB1ENR.modify(.{ .TIM6EN = state }), //F103xE
        .TIM7 => rcc.APB1ENR.modify(.{ .TIM7EN = state }), //F103xE
        .WWDG => rcc.APB1ENR.modify(.{ .WWDGEN = state }),
        .SPI2 => rcc.APB1ENR.modify(.{ .SPI2EN = state }),
        .SPI3 => rcc.APB1ENR.modify(.{ .SPI3EN = state }), //F103xD/E
        .USART2 => rcc.APB1ENR.modify(.{ .USART2EN = state }),
        .USART3 => rcc.APB1ENR.modify(.{ .USART3EN = state }),
        .UART4 => rcc.APB1ENR.modify(.{ .UART4EN = state }), //F103xC/D/E
        .UART5 => rcc.APB1ENR.modify(.{ .UART5EN = state }), //F103xC/D/E
        .I2C1 => rcc.APB1ENR.modify(.{ .I2C1EN = state }),
        .I2C2 => rcc.APB1ENR.modify(.{ .I2C2EN = state }),
        .USB => rcc.APB1ENR.modify(.{ .USBEN = state }),
        .CAN => rcc.APB1ENR.modify(.{ .CANEN = state }),
        .BKP => rcc.APB1ENR.modify(.{ .BKPEN = state }),
        .PWR => rcc.APB1ENR.modify(.{ .PWREN = state }),
        .DAC => rcc.APB1ENR.modify(.{ .DACEN = state }), //F103xE
        .RTC => enable_rtc(state != 0),
    }
}

pub fn enable_clock(peri: RccPeriferals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(peri: RccPeriferals) void {
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
pub fn get_clock(comptime source: RccPeriferals) u32 {
    return @intFromFloat(switch (source) {
        // AHB peripherals
        .DMA1,
        .DMA2,
        .SRAM,
        .FLASH,
        .CRC,
        => corrent_clocks.AHBOutput,

        .FSMC => corrent_clocks.FSMClkOutput,
        .SDIO => corrent_clocks.SDIOClkOutput,

        // APB2 peripherals
        .AFIO,
        .GPIOA,
        .GPIOB,
        .GPIOC,
        .GPIOD,
        .GPIOE,
        .GPIOF,
        .GPIOG,
        .SPI1,
        .USART1,
        => corrent_clocks.APB2Prescaler,

        .ADC1, .ADC2 => corrent_clocks.ADCoutput,

        .TIM1 => corrent_clocks.TimPrescalerAPB2,

        // APB1 peripherals
        .TIM2, .TIM3, .TIM4, .TIM5, .TIM6, .TIM7 => corrent_clocks.TimPrescalerAPB1,

        .DAC => corrent_clocks.APB1Output,

        .WWDG,
        .SPI2,
        .SPI3,
        .USART2,
        .USART3,
        .UART4,
        .UART5,
        .I2C1,
        .I2C2,
        .CAN,
        .BKP,
        .PWR,
        => corrent_clocks.APB1Output,

        .USB => corrent_clocks.USBoutput,
        .RTC => corrent_clocks.RTCOutput,
    });
}

pub inline fn get_sys_clk() u32 {
    return @intFromFloat(corrent_clocks.SysCLKOutput);
}

inline fn calc_wait_ticks(val: usize) usize {
    const corrent_clock: usize = @intFromFloat(corrent_clocks.SysCLKOutput);
    const ms_per_tick = corrent_clock / 1000;
    return ms_per_tick * val;
}
