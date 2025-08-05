//NOTE: this file is only valid for densities: Low, Medium, High, and XL. Connectivity line devices are not supported in this version.
//TODO: Add support for 105/107
const std = @import("std");
const microzig = @import("microzig");

const find_clocktree = @import("util.zig").find_clock_tree;
const ClockTree = find_clocktree(microzig.config.chip_name);
const power = @import("power.zig");

//expose only the configuration structs
pub const Config = ClockTree.Config;
pub const ConfigWithRef = ClockTree.ConfigWithRef;

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

const ClockInitError = error{
    HSETimeout,
    LSETimeout,
};

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

pub const ClockOutputs = struct {
    //system clock
    SYS: u32 = 0,

    //Bus Clocks
    AHB: u32 = 0,
    APB1: u32 = 0,
    APB2: u32 = 0,

    //Peripheral clocks
    FSMC: u32 = 0,
    SDIO: u32 = 0,
    TimAPB1: u32 = 0,
    TimAPB2: u32 = 0,
    ADC: u32 = 0,
    USB: u32 = 0,
};

//default clock config
var corrent_clocks: ClockOutputs = validate_clocks(.{});

//NOTE: procedural style or loop through all elements of the struct?
///Configures the system clocks
///NOTE: to configure the backup domain clocks (RTC) it is necessary to enable it through the power
///register before configuring the clocks
pub fn apply_clock(comptime config: ClockTree.Config) ClockInitError!void {
    const clck = comptime validate_clocks(config);

    set_flash(clck.SYS);

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
    corrent_clocks = clck;
}

//check clocks and return all used outputs
fn validate_clocks(comptime config: ClockTree.Config) ClockOutputs {
    const tree_values = ClockTree.ClockTree.init_comptime(config);
    var outputs: ClockOutputs = .{};

    //checks if the clocks of the used peripherals are valid
    outputs.SYS = @intFromFloat(tree_values.SysCLKOutput.get_comptime());

    outputs.AHB = @intFromFloat(tree_values.AHBOutput.get_comptime());
    outputs.APB1 = @intFromFloat(tree_values.APB1Output.get_comptime());
    outputs.APB2 = @intFromFloat(tree_values.APB2Output.get_comptime());
    outputs.TimAPB1 = @intFromFloat(tree_values.TimPrescOut1.get_comptime());
    outputs.TimAPB2 = @intFromFloat(tree_values.TimPrescOut2.get_comptime());

    if (config.MCOMult) |_| {
        _ = tree_values.MCOoutput.get_comptime();
    }

    if (config.USBPrescaler) |_| {
        outputs.USB = @intFromFloat(tree_values.USBoutput.get_comptime());
        if (config.PLLSource) |src| {
            if (src == .RCC_PLLSOURCE_HSI_DIV2) {
                @compileError("USB clock is not stable when PLL source is HSI");
            }
        }
    }

    if (config.ADCprescaler) |_| {
        outputs.ADC = @intFromFloat(tree_values.ADCoutput.get_comptime());
    }

    return outputs;
}

fn set_flash(clock: u32) void {
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

    const max_wait: u32 = if (config.HSE_Timeout) |val| @intFromEnum(val) else std.math.maxInt(u32);
    var ticks: usize = 0;
    while (rcc.CR.read().HSERDY == 0) {
        if (ticks == max_wait - 1) return error.HSETimeout;
        ticks += 1;
        asm volatile ("" ::: "memory");
    }
}

fn config_LSE(comptime config: ClockTree.Config) ClockInitError!void {
    const max_wait: u32 = if (config.LSE_Timeout) |val| @intFromEnum(val) else std.math.maxInt(u32);
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
        const p: u1 = switch (pre) {
            .RCC_USBCLKSOURCE_PLL_DIV1_5 => 0,
            .RCC_USBCLKSOURCE_PLL => 1,
        };
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
        //enable backup domain
        enable_clock(.PWR);
        enable_clock(.BKP);
        power.backup_domain_protection(false);

        var rtcs: RTCSEL = .DISABLE;
        switch (src) {
            .RCC_RTCCLKSOURCE_HSE_DIV128 => {
                rtcs = .HSE;
                try config_HSE(config);
            },
            .RCC_RTCCLKSOURCE_LSE => {
                rtcs = .LSE;
                try config_LSE(config);
            },
            .RCC_RTCCLKSOURCE_LSI => {
                rtcs = .LSI;
                config_LSI();
            },
        }

        rcc.BDCR.modify(.{ .RTCSEL = rtcs });
        power.backup_domain_protection(true);

        // Disable and reset clocks to avoid potential conflicts with the main application
        disable_clock(.BKP);
        reset_clock(.BKP);
        disable_clock(.PWR);
        reset_clock(.PWR);
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
pub fn enable_RTC(on: bool) void {
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

///NOTE: AHB bus cannot be reset, so this function only resets the APB1 and APB2 peripherals
pub fn reset_clock(peri: RccPeriferals) void {
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
    //release reset
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

///Reset all clocks to their default state
pub fn reset_all_clocks() void {
    rcc.APB2RSTR.raw = std.math.maxInt(u32);
    rcc.APB2RSTR.raw = 0;
    rcc.APB1RSTR.raw = std.math.maxInt(u32);
    rcc.APB1RSTR.raw = 0;
}
//NOTE: should we panic on invalid clocks?
//errors at comptime appear for peripherals manually configured like USB.
///if requests the clock of an unconfigured peripheral, 0 means error, != 0 means ok
pub fn get_clock(source: RccPeriferals) u32 {
    return switch (source) {
        // AHB peripherals
        .DMA1,
        .DMA2,
        .SRAM,
        .FLASH,
        .CRC,
        => corrent_clocks.AHB,

        .FSMC => corrent_clocks.FSMC,
        .SDIO => corrent_clocks.SDIO,

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
        => corrent_clocks.APB2,

        .ADC1, .ADC2 => corrent_clocks.ADC,

        .TIM1 => corrent_clocks.TimAPB2,

        // APB1 peripherals
        .TIM2, .TIM3, .TIM4, .TIM5, .TIM6, .TIM7 => corrent_clocks.TimAPB1,

        .DAC => corrent_clocks.APB1,

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
        => corrent_clocks.APB1,

        .USB => corrent_clocks.USB,
    };
}

pub inline fn get_sys_clk() u32 {
    return corrent_clocks.SYS;
}
