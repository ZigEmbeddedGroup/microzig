//NOTE: this file is only valid for densities: Low, Medium, High, and XL. Connectivity line devices are not supported in this version.
//TODO: Add support for 105/107
const std = @import("std");
const microzig = @import("microzig");
const find_clocktree = @import("util.zig").find_clock_tree;

const ClockInitError = error{
    HSETimeout,
    LSETimeout,
};

const flash_v1 = microzig.chip.types.peripherals.flash_f1;
const flash = microzig.chip.peripherals.FLASH;
const PLLMUL = microzig.chip.types.peripherals.rcc_f1.PLLMUL;
const PLLSRC = microzig.chip.types.peripherals.rcc_f1.PLLSRC;
const PLLXTPRE = microzig.chip.types.peripherals.rcc_f1.PLLXTPRE;
const PRE = microzig.chip.types.peripherals.rcc_f1.PPRE;
const HPRE = microzig.chip.types.peripherals.rcc_f1.HPRE;
const ADCPRE = microzig.chip.types.peripherals.rcc_f1.ADCPRE;
const USBPRE = microzig.chip.types.peripherals.rcc_f1.USBPRE;
const RTCSEL = microzig.chip.types.peripherals.rcc_f1.RTCSEL;
const MCOSEL = microzig.chip.types.peripherals.rcc_f1.MCOSEL;
const SW = microzig.chip.types.peripherals.rcc_f1.SW;
const rcc = microzig.chip.peripherals.RCC;

pub const ClockTree = find_clocktree(microzig.config.chip_name);

const RccPeriferals = enum {
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
};

pub const ResetReason = enum {
    low_power,
    window_watchdog,
    independent_watchdog,
    POR_or_PDR,
    NRST,
};

//TODO: change anytype to the correct clocktype
//NOTE: procedural style or loop through all elements of the struct?
/// Configures the system clocks
/// NOTE: to configure the backup domain clocks (RTC) it is necessary to enable it through the power register before configuring the clocks
pub fn clock_init(comptime config: ClockTree.Config) ClockInitError!void {
    const sysclck = comptime validate_clocks(config);

    set_flash(sysclck);

    //rest all clock configs
    secure_enable();
    if (config.HSICalibrationValue) |val| {
        config_HSI(@intFromEnum(val));
    }

    try config_PLL(config);
    config_peripherals(config);
    try config_RTC(config);
    try config_system_clock(config);
    config_MCO(config);
}

//check clocks and return sysclk for flash config
fn validate_clocks(comptime config: ClockTree.Config) usize {
    const tree_values = ClockTree.ClockTree.init_comptime(config);

    //checks if the clocks of the used peripherals are valid
    const sysclk = tree_values.SysCLKOutput.get_comptime();
    _ = tree_values.APB1Output.get_comptime();
    _ = tree_values.APB2Output.get_comptime();
    _ = tree_values.AHBOutput.get_comptime();

    if (config.MCOMult) |_| {
        _ = tree_values.MCOoutput.get_comptime();
    }

    if (config.USBPrescaler) |_| {
        _ = tree_values.USBoutput.get_comptime();
        if (config.PLLSource) |src| {
            if (src == .RCC_PLLSOURCE_HSI_DIV2) {
                @compileError("USB clock is not stable when PLL source is HSI");
            }
        }
    }

    return @intFromFloat(sysclk);
}

fn set_flash(clock: usize) void {
    if (clock <= 24_000_000) {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS0,
            .PRFTBE = 0,
        });
    } else if (clock <= 48_000_000) {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS1,
            .PRFTBE = 1,
        });
    } else {
        flash.ACR.modify(.{
            .LATENCY = flash_v1.LATENCY.WS2,
            .PRFTBE = 1,
        });
    }
}

//force HSI Clock and clear any clock configs
fn secure_enable() void {
    rcc.CR.modify(.{ .HSION = 1 });
    while (rcc.CR.read().HSIRDY != 1) {
        asm volatile ("" ::: "memory");
    }

    rcc.BDCR.raw = 0;
    rcc.CFGR.raw = 0;
    while (rcc.CFGR.read().SWS != .HSI) {
        asm volatile ("" ::: "memory");
    }

    rcc.CR.modify(.{
        .PLLON = 0,
        .HSEBYP = 0,
        .HSEON = 0,
        .CSSON = 0,
    });
}

fn config_HSI(value: usize) void {
    //secure_enable has already started the HSE
    const trim: u5 = @truncate(value);
    rcc.CR.modify(.{ .HSITRIM = trim });

    //wait for the HSI to stabilize
    for (0..16) |_| {
        asm volatile ("" ::: "memory");
    }
}

fn config_LSI() void {
    rcc.CSR.modify(.{ .LSION = 1 });
    while (rcc.CSR.read().LSIRDY == 0) {
        asm volatile ("" ::: "memory");
    }
}

fn config_HSE(comptime config: ClockTree.Config) ClockInitError!void {
    rcc.CR.modify(.{ .HSEON = 1 });

    const max_wait: u32 = if (config.HSE_Timout) |val| @intFromEnum(val) else std.math.maxInt(u32);
    var ticks: usize = 0;
    while (rcc.CR.read().HSERDY == 0) {
        if (ticks == max_wait - 1) return error.HSETimeout;
        ticks += 1;
        asm volatile ("" ::: "memory");
    }
}

fn config_LSE(comptime config: ClockTree.Config) ClockInitError!void {
    const max_wait: u32 = if (config.LSE_Timout) |val| @intFromEnum(val) else std.math.maxInt(u32);
    var ticks: usize = 0;
    rcc.BDCR.modify(.{ .LSEON = 1 });
    while (rcc.BDCR.read().LSERDY == 0) {
        if (ticks == max_wait - 1) return error.LSETimeout;
        ticks += 1;
        asm volatile ("" ::: "memory");
    }
}

fn config_PLL(comptime config: ClockTree.Config) ClockInitError!void {
    if (config.PLLSource) |src| {
        const s: u1 = @intFromEnum(src);
        const val: PLLSRC = @enumFromInt(s);
        rcc.CFGR.modify(.{ .PLLSRC = val });
        if (val == .HSE_Div_PREDIV) {
            try config_HSE(config);
        }
    }

    if (config.HSEDivPLL) |pre| {
        const p: u1 = @intFromEnum(pre);
        const val: PLLXTPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PLLXTPRE = val });
    }

    if (config.PLLMUL) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PLLMUL = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PLLMUL = val });
    }
}

//TODO: Add STM32F105/7 devices peri
fn config_peripherals(comptime config: ClockTree.Config) void {
    if (config.APB1Prescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PPRE1 = val });
    }

    if (config.APB2Prescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: PRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .PPRE2 = val });
    }

    if (config.AHBPrescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: HPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .HPRE = val });
    }

    if (config.ADCprescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: ADCPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .ADCPRE = val });
    }

    if (config.USBPrescaler) |pre| {
        const p: u32 = @intFromEnum(pre);
        const val: USBPRE = @enumFromInt(p);
        rcc.CFGR.modify(.{ .USBPRE = val });
    }
}

fn config_system_clock(comptime config: ClockTree.Config) ClockInitError!void {
    if (config.SysClkSource) |src| {
        const val: u2 = @intFromEnum(src);
        const e_val: SW = @enumFromInt(val);
        switch (val) {
            1 => try config_HSE(config),
            2 => init_pll(),
            else => {},
        }

        rcc.CFGR.modify(.{ .SW = e_val });
        while (true) {
            const sws = rcc.CFGR.read().SWS;
            if (sws == e_val) break;
            asm volatile ("" ::: "memory");
        }
    }
}

fn init_pll() void {
    rcc.CR.modify(.{ .PLLON = 1 });
    while (rcc.CR.read().PLLRDY == 0) {
        asm volatile ("" ::: "memory");
    }
}

fn config_RTC(comptime config: ClockTree.Config) ClockInitError!void {
    if (config.RTCClkSource) |src| {
        var rtc: RTCSEL = .DISABLE;
        switch (src) {
            .RCC_RTCCLKSOURCE_HSE_DIV128 => {
                rtc = .HSE;
                try config_HSE(config);
            },
            .RCC_RTCCLKSOURCE_LSE => {
                rtc = .LSE;
                try config_LSE(config);
            },
            .RCC_RTCCLKSOURCE_LSI => {
                rtc = .LSI;
                config_LSI();
            },
            else => {},
        }

        rcc.BDCR.modify(.{ .RTCSEL = rtc });
    }
}

fn config_MCO(comptime config: ClockTree.Config) void {
    if (config.MCOMult) |src| {
        const mco: MCOSEL = switch (src) {
            .RCC_MCO1SOURCE_HSE => .HSE,
            .RCC_MCO1SOURCE_HSI => .HSI,
            .RCC_MCO1SOURCE_PLLCLK => .PLL,
            .RCC_MCO1SOURCE_SYSCLK => .SYS,
        };
        rcc.CFGR.modify(.{ .MCOSEL = mco });
    }
}

///after the reset, the BDRD becomes read_only until access is released by the power register
pub fn reset_backup_domain() void {
    rcc.BDCR.modify(.{ .BDRST = 1 });
    for (0..5) |i| {
        std.mem.doNotOptimizeAway(i);
    }
    rcc.BDCR.modify(.{ .BDRST = 0 });
}

///configure the power and clock registers before enabling the RTC
pub fn enable_RTC() void {
    rcc.BDCR.modify(.{ .RTCEN = 1 });
}

///This function is called internally by the HAL, the RESET value should only be read after the RESET
/// read the Reset value through the global variable hal.RESET
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

pub fn disable_clock(peri: RccPeriferals) void {
    switch (peri) {
        .DMA1 => rcc.AHBRSTR.modify(.{ .DMA1RST = 1 }),
        .DMA2 => rcc.AHBRSTR.modify(.{ .DMA2RST = 1 }),
        .SRAM => rcc.AHBRSTR.modify(.{ .SRAMRST = 1 }),
        .FLASH => rcc.AHBRSTR.modify(.{ .FLASHRST = 1 }),
        .CRC => rcc.AHBRSTR.modify(.{ .CRCRST = 1 }),
        .FSMC => rcc.AHBRSTR.modify(.{ .FSMCRST = 1 }), //F103xE
        .SDIO => rcc.AHBRSTR.modify(.{ .SDIORST = 1 }), //F103xC/D/E

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
    }
}

pub fn enable_clock(peri: RccPeriferals) void {
    switch (peri) {
        .DMA1 => rcc.AHBENR.modify(.{ .DMA1EN = 1 }),
        .DMA2 => rcc.AHBENR.modify(.{ .DMA2EN = 1 }),
        .SRAM => rcc.AHBENR.modify(.{ .SRAMEN = 1 }),
        .FLASH => rcc.AHBENR.modify(.{ .FLASHEN = 1 }),
        .CRC => rcc.AHBENR.modify(.{ .CRCEN = 1 }),
        .FSMC => rcc.AHBENR.modify(.{ .FSMCEN = 1 }), //F103xE
        .SDIO => rcc.AHBENR.modify(.{ .SDIOEN = 1 }), //F103xC/D/E

        // APB2ENR (APB2 peripherals)
        .AFIO => rcc.APB2ENR.modify(.{ .AFIOEN = 1 }),
        .GPIOA => rcc.APB2ENR.modify(.{ .GPIOAEN = 1 }),
        .GPIOB => rcc.APB2ENR.modify(.{ .GPIOBEN = 1 }),
        .GPIOC => rcc.APB2ENR.modify(.{ .GPIOCEN = 1 }),
        .GPIOD => rcc.APB2ENR.modify(.{ .GPIODEN = 1 }),
        .GPIOE => rcc.APB2ENR.modify(.{ .GPIOEEN = 1 }),
        .GPIOF => rcc.APB2ENR.modify(.{ .GPIOFEN = 1 }), //F103xE
        .GPIOG => rcc.APB2ENR.modify(.{ .GPIOGEN = 1 }), //F103xE
        .ADC1 => rcc.APB2ENR.modify(.{ .ADC1EN = 1 }),
        .ADC2 => rcc.APB2ENR.modify(.{ .ADC2EN = 1 }),
        .TIM1 => rcc.APB2ENR.modify(.{ .TIM1EN = 1 }),
        .SPI1 => rcc.APB2ENR.modify(.{ .SPI1EN = 1 }),
        .USART1 => rcc.APB2ENR.modify(.{ .USART1EN = 1 }),

        // APB1ENR (APB1 peripherals)
        .TIM2 => rcc.APB1ENR.modify(.{ .TIM2EN = 1 }),
        .TIM3 => rcc.APB1ENR.modify(.{ .TIM3EN = 1 }),
        .TIM4 => rcc.APB1ENR.modify(.{ .TIM4EN = 1 }),
        .TIM5 => rcc.APB1ENR.modify(.{ .TIM5EN = 1 }), //F103xE
        .TIM6 => rcc.APB1ENR.modify(.{ .TIM6EN = 1 }), //F103xE
        .TIM7 => rcc.APB1ENR.modify(.{ .TIM7EN = 1 }), //F103xE
        .WWDG => rcc.APB1ENR.modify(.{ .WWDGEN = 1 }),
        .SPI2 => rcc.APB1ENR.modify(.{ .SPI2EN = 1 }),
        .SPI3 => rcc.APB1ENR.modify(.{ .SPI3EN = 1 }), //F103xD/E
        .USART2 => rcc.APB1ENR.modify(.{ .USART2EN = 1 }),
        .USART3 => rcc.APB1ENR.modify(.{ .USART3EN = 1 }),
        .UART4 => rcc.APB1ENR.modify(.{ .UART4EN = 1 }), //F103xC/D/E
        .UART5 => rcc.APB1ENR.modify(.{ .UART5EN = 1 }), //F103xC/D/E
        .I2C1 => rcc.APB1ENR.modify(.{ .I2C1EN = 1 }),
        .I2C2 => rcc.APB1ENR.modify(.{ .I2C2EN = 1 }),
        .USB => rcc.APB1ENR.modify(.{ .USBEN = 1 }),
        .CAN => rcc.APB1ENR.modify(.{ .CANEN = 1 }),
        .BKP => rcc.APB1ENR.modify(.{ .BKPEN = 1 }),
        .PWR => rcc.APB1ENR.modify(.{ .PWREN = 1 }),
        .DAC => rcc.APB1ENR.modify(.{ .DACEN = 1 }), //F103xE
    }
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
