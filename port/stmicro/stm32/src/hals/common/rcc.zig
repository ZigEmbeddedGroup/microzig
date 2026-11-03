const std = @import("std");
const microzig = @import("microzig");
const enums = @import("enums.zig");
const util = @import("util.zig");
const ClockTree = @import("ClockTree");
const Tree = @field(ClockTree, microzig.config.chip_name);
const power = microzig.hal.power;

pub const Config = Tree.Config;
const peripherals = microzig.chip.peripherals;
const peripheralTypes = microzig.chip.types.peripherals;
const RCC = peripherals.RCC;
const FLASH = peripherals.FLASH;
const flashType = if (@TypeOf(FLASH) == *volatile peripheralTypes.flash_f1.FLASH)
    peripheralTypes.flash_f1
else if (@TypeOf(FLASH) == *volatile peripheralTypes.flash_f4.FLASH)
    peripheralTypes.flash_f4
else
    @compileError("Unknown FLASH");

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

pub const Bus = chipdetails.Bus;

//default clock config
var current_clocks: Tree.ClockOutput = blk: {
    const out = Tree.get_clocks(.{}) catch unreachable;
    break :blk out.clock;
};

//NOTE: procedural style or loop through all elements of the struct?
///Configures the system clocks
///NOTE: to configure the backup domain clocks (RTC) it is necessary to enable it through the power
///register before configuring the clocks
pub fn apply(comptime config: Tree.Config) ClockInitError!Tree.ClockOutput {
    const out_data = comptime Tree.get_clocks(config) catch unreachable;
    try apply_internal(out_data.config);
    current_clocks = out_data.clock;
    return out_data.clock;
}

fn apply_internal(config: Tree.OutputConfig) ClockInitError!void {
    const latency: flashType.LATENCY = @fromBackingInt(@backingInt(config.FLatency));
    const prefetch = config.flags.PREFETCH_ENABLE;
    secure_enable();
    set_flash(latency, prefetch);

    if (config.flags.EnableHSE) {
        const timout = @as(usize, config.HSE_Timout);
        try enable_hse(config.flags.HSEByPass, config.flags.EnbaleCSS, timout);
    } else {
        disable_hse();
    }

    set_peripherals_prescaler(get_prescaler_config(config));

    if (config.flags.PLLUsed) {
        config_pll(get_pll_config(config));
        enable_pll();
    } else {
        disable_pll();
    }

    //BACKUP DOMAIN CLOCK CONFIG

    if (config.flags.EnableLSE) {
        const timeout = @as(usize, config.LSE_Timout);
        const bypass = config.flags.LSEByPass;
        try enable_lse(timeout, bypass);
    } else {
        disable_lse();
    }

    set_lsi(config.flags.LSIUsed);

    config_rtc(get_rtc_config(config));

    config_mco(get_mco_config(config));

    //SYSTEM CLOCK CONFIG
    config_system_clock(@fromBackingInt(@backingInt(config.SYSCLKSource)));

    //in case of HSI not used, we have to disable it here
    //becuse the system clock configuration 'secure_enable' enables it by default
    calib_hsi(@intCast(config.HSICalibrationValue));
    set_hsi(config.flags.HSIUsed);
}

//force HSI Clock and clear any clock configs
pub fn secure_enable() void {
    set_hsi(true);

    RCC.BDCR.raw = 0;
    RCC.CFGR.raw = 0;
    while (RCC.CFGR.read().SWS != .HSI) {
        asm volatile ("");
    }

    RCC.CR.modify(.{
        .PLLON = 0,
        .HSEBYP = 0,
        .HSEON = 0,
        .CSSON = 0,
    });
}

// WHY is this part of the RCC? Esp since for example ADC is not
pub inline fn set_flash(latency: flashType.LATENCY, prefetch: bool) void {
    FLASH.ACR.modify_one("LATENCY", latency);

    const prfetch_en_reg = if (@TypeOf(FLASH) == *volatile peripheralTypes.flash_f1.FLASH)
        "PRFTBE"
    else if (@TypeOf(FLASH) == *volatile peripheralTypes.flash_f4.FLASH)
        "PRFTEN"
    else
        @compileError("Unknown FLASH");
    FLASH.ACR.modify_one(prfetch_en_reg, @intFromBool(prefetch));
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

    RCC.CR.modify(.{
        .HSEON = 1,
        .HSEBYP = @intFromBool(bypass),
        .CSSON = @intFromBool(css),
    });
    while (RCC.CR.read().HSERDY == 0) {
        if (ticks == 0) return error.HSETimeout;
        ticks -= 1;
        asm volatile ("");
    }
}

pub inline fn disable_hse() void {
    RCC.CR.modify(.{ .CSSON = 0 });
    RCC.CR.modify(.{ .HSEON = 0 });
}

pub const set_peripherals_prescaler = util.generateRCCPeripheralApply(chipdetails.prescalerFields);
const get_prescaler_config = util.generateRCCPeripheralConvert(chipdetails.prescalerFields);

pub const config_pll = util.generateRCCPeripheralApply(chipdetails.pllFields);
const get_pll_config = util.generateRCCPeripheralConvert(chipdetails.pllFields);

pub fn enable_pll() void {
    RCC.CR.modify(.{ .PLLON = 1 });
    while (RCC.CR.read().PLLRDY == 0) {
        asm volatile ("");
    }
}

pub fn disable_pll() void {
    RCC.CR.modify(.{ .PLLON = 0 });
    while (RCC.CR.read().PLLRDY != 0) {
        asm volatile ("");
    }
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

    RCC.BDCR.modify_one("LSEBYP", @intFromBool(bypass));
    RCC.BDCR.modify(.{ .LSEON = 1 });
    while (RCC.BDCR.read().LSERDY == 0) {
        if (ticks == 0) return error.LSETimeout;
        ticks -= 1;
        asm volatile ("");
    }
}

pub inline fn disable_lse() void {
    RCC.BDCR.modify(.{ .LSEON = 0 });
}

fn set_lsi(on: bool) void {
    RCC.CSR.modify(.{ .LSION = @intFromBool(on) });
    if (on) {
        while (RCC.CSR.read().LSIRDY == 0) {
            asm volatile ("");
        }
    }
}

///after the reset, the BDRD becomes read_only until access is released by the power register
///this function can also be called from `backup.reset()`
pub fn reset_backup_domain() void {
    RCC.BDCR.modify(.{ .BDRST = 1 });
    for (0..5) |i| {
        std.mem.doNotOptimizeAway(i);
    }
    RCC.BDCR.modify(.{ .BDRST = 0 });
}

const get_rtc_config = util.generateRCCPeripheralConvert(chipdetails.rtcields);

pub fn config_rtc(config: util.generateRCCPeripheralConfig(chipdetails.rtcields)) void {
    // RCC_BDCR is read-only
    const enableBKPRegs: []const Peripherals = if (@TypeOf(RCC) == *volatile peripheralTypes.rcc_f1.RCC)
        &[_]Peripherals{ .PWR, .BKP }
    else
        &[0]Peripherals{};

    //enable backup domain write acess
    inline for (enableBKPRegs) |reg| {
        enable_clock(reg);
    }
    power.backup_domain_protection(false);
    if (config.RTCSEL == .HSE) {
        reset_backup_domain(); //HSE as RTC source requires full reset of the bkp domain
        power.backup_domain_protection(false);
    }

    util.generateRCCPeripheralApply(chipdetails.rtcields)(config);
    power.backup_domain_protection(true);

    // Disable and reset clocks to avoid potential conflicts with the main application
    inline for (enableBKPRegs) |reg| {
        disable_clock(reg);
        reset_clock(reg);
    }
}

pub const config_mco = util.generateRCCPeripheralApply(chipdetails.mcoFields);
const get_mco_config = util.generateRCCPeripheralConvert(chipdetails.mcoFields);

fn config_system_clock(system_clock: chipdetails.rccType.SW) void {
    RCC.CFGR.modify(.{ .SW = system_clock });
    while (true) {
        const sws = RCC.CFGR.read().SWS;
        if (sws == system_clock) break;
        asm volatile ("");
    }
}

///configure the HSI calibration value
pub fn calib_hsi(calib: usize) void {
    //secure_enable has already started the HSE
    const trim: u5 = @truncate(calib);
    RCC.CR.modify(.{ .HSITRIM = trim });

    //wait for the HSI to stabilize
    for (0..16) |_| {
        asm volatile ("");
    }
}

pub fn set_hsi(on: bool) void {
    RCC.CR.modify(.{ .HSION = @intFromBool(on) });
    if (on) {
        while (RCC.CR.read().HSIRDY == 0) {
            asm volatile ("");
        }
    }
}

///configure the power and clock registers before enabling the RTC
///this function also can be called from `rtc.enable()`
pub fn enable_rtc(on: bool) void {
    RCC.BDCR.modify(.{ .RTCEN = @intFromBool(on) });
}

///backup domain is not reset with the rest of the system
///so this function can be used to check if the RTC is already running.
pub fn rtc_running() bool {
    return RCC.BDCR.read().RTCEN != 0;
}

pub fn set_clock(comptime peri: Peripherals, state: u1) void {
    const peri_name = @tagName(peri);
    const field = peri_name ++ "EN";
    if (util.match_name(peri_name, &.{"RTC"})) {
        enable_rtc(state != 0);
        return;
    }

    const rcc_register_name = comptime chipdetails.peripheral_to_en_reg(peri_name);

    @field(RCC, rcc_register_name).modify_one(field, state);
}

pub fn reset_clock(comptime peri: Peripherals) void {
    const peri_name = @tagName(peri);
    const field = peri_name ++ "RST";
    const rcc_register_name = comptime chipdetails.peripheral_to_rst_reg(peri_name);

    @field(RCC, rcc_register_name).modify_one(field, 1);
    @field(RCC, rcc_register_name).raw = 0;
}

pub fn enable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 0);
}

pub fn enable_all_clocks() void {
    //enable all clocks
    inline for (chipdetails.enRegs) |reg| {
        @field(RCC, reg).raw = std.math.maxInt(u32);
    }
}

pub fn disable_all_clocks() void {
    //disable all clocks
    inline for (chipdetails.enRegs) |reg| {
        @field(RCC, reg).raw = 0;
    }
}

///Reset all periferals of the specified bus to they default state.
///NOTE: this function does not effect the ENR registers.
pub fn reset_bus(bus: Bus) void {
    //first write 1 to all bits to reset them
    //then write 0 to all bits to release the reset
    //this is necessary because the reset bits are not self-clearing
    inline for (@typeInfo(Bus).@"enum".field_names, @typeInfo(Bus).@"enum".field_values) |name, value| {
        if (@backingInt(bus) == value) {
            @field(RCC, name ++ "RSTR").raw = std.math.maxInt(u32);
            @field(RCC, name ++ "RSTR").raw = 0;
        }
    }
}

pub inline fn get_sys_clk() u32 {
    return current_clocks.SysCLKOutput;
}

inline fn calc_wait_ticks(val: usize) usize {
    const corrent_clock: usize = @intCast(current_clocks.SysCLKOutput);
    const ms_per_tick = corrent_clock / 1000;
    return ms_per_tick * val;
}

pub fn enable_dma(index: enums.DMA_Type) void {
    inline for (@typeInfo(Bus).@"enum".field_names, @typeInfo(Bus).@"enum".field_values) |name, value| {
        if (@backingInt(index) == value) {
            @field(RCC, chipdetails.DMAENReg).modify_one(name ++ "EN", 1);
        }
    }
}

// TODO: Implement get_clock

///This function is called internally by the HAL, the RESET value should only be read after the RESET
///read the Reset value through the global variable hal.RESET
pub fn get_reset_reason() ResetReason {
    const flags = RCC.CSR.read();
    const rst: ResetReason = blk: {
        // TODO: Add BORRSTF for stm32f4
        if (flags.PINRSTF == 1) break :blk ResetReason.NRST;
        if (flags.PORRSTF == 1) break :blk ResetReason.POR_or_PDR;
        if (flags.SFTRSTF == 1) break :blk ResetReason.low_power;
        if (flags.IWDGRSTF == 1) break :blk ResetReason.independent_watchdog;
        if (flags.WWDGRSTF == 1) break :blk ResetReason.window_watchdog;
        if (flags.LPWRRSTF == 1) break :blk ResetReason.low_power;
        break :blk ResetReason.POR_or_PDR;
    };

    RCC.CSR.modify(.{ .RMVF = 1 });
    return rst;
}

const chipdetails = if (@TypeOf(RCC) == *volatile peripheralTypes.rcc_f1.RCC)
    details_rcc_f1
else if (@TypeOf(RCC) == *volatile peripheralTypes.rcc_f4.RCC)
    details_rcc_f4
else
    @compileError("Unknown RCC");

const details_rcc_f1 = struct {
    const rccType = peripheralTypes.rcc_f1;

    const Bus = enum {
        // TODO: Why not? To me it seems they can be reset, albeit only ATHMAC and OTGFS
        // AHB, //AHB cannot be reset by software
        APB1,
        APB2,
    };

    const DMAENReg = "AHBENR";

    //TODO: Add STM32F105/7 devices peri
    const prescalerFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "CFGR", .name = "USBPRE", .type = rccType.USBPRE, .optional = true, .rccName = "USBPrescaler" },
            .{ .reg = "CFGR", .name = "ADCPRE", .type = rccType.ADCPRE, .optional = true, .rccName = "ADCPresc" },
            .{ .reg = "CFGR", .name = "PPRE2", .type = rccType.PPRE, .optional = true, .rccName = "APB2CLKDivider" },
            .{ .reg = "CFGR", .name = "PPRE1", .type = rccType.PPRE, .optional = true, .rccName = "APB1CLKDivider" },
            .{ .reg = "CFGR", .name = "HPRE", .type = rccType.HPRE, .optional = true, .rccName = "AHBCLKDivider" },
        };
    const pllFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "CFGR", .name = "PLLSRC", .type = rccType.PLLSRC, .rccName = "PLLSourceVirtual" },
            .{ .reg = "CFGR", .name = "PLLMUL", .type = rccType.PLLMUL, .rccName = "PLLMUL" },
            .{ .reg = "CFGR", .name = "PLLXTPRE", .type = rccType.PLLXTPRE, .rccName = "HSEDivPLL" },
        };
    const rtcields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "BDCR", .name = "RTCSEL", .type = rccType.RTCSEL, .rccName = "RTCClockSelection", .default = .{ .value = @ptrCast(&rccType.RTCSEL.DISABLE), .unless = "RTCEnable" } },
        };
    const mcoFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "CFGR", .name = "MCOSEL", .type = rccType.MCOSEL, .rccName = "RCC_MCOSource", .default = .{ .value = @ptrCast(&rccType.MCOSEL.DISABLE), .unless = "MCOEnable" } },
        };

    const enRegs: []const []const u8 = .{
        "AHBENR",
        "APB1ENR",
        "APB2ENR",
    };

    inline fn peripheral_to_en_reg(peri_name: [:0]const u8) []const u8 {
        return if (util.match_name(peri_name, &.{
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
    }

    inline fn peripheral_to_rst_reg(peri_name: [:0]const u8) []const u8 {
        return if (util.match_name(peri_name, &.{
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
    }
};

const details_rcc_f4 = struct {
    const rccType = peripheralTypes.rcc_f4;
    const Bus = enum {
        AHB1,
        AHB2,
        AHB3,
        APB1,
        APB2,
    };

    const DMAENReg = "AHB1ENR";

    const prescalerFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "CFGR", .name = "MCO2PRE", .type = rccType.MCOPRE, .rccName = "RCC_MCODiv2" },
            .{ .reg = "CFGR", .name = "MCO1PRE", .type = rccType.MCOPRE, .rccName = "RCC_MCODiv1" },
            .{ .reg = "CFGR", .name = "PPRE2", .type = rccType.PPRE, .rccName = "APB2CLKDivider" },
            .{ .reg = "CFGR", .name = "PPRE1", .type = rccType.PPRE, .rccName = "APB1CLKDivider" },
            .{ .reg = "CFGR", .name = "HPRE", .type = rccType.HPRE, .rccName = "AHBCLKDivider" },
            .{ .reg = "DCKCFGR", .name = "TIMPRE", .type = rccType.TIMPRE, .rccName = "RCC_TIM_PRescaler_Selection" },
        };
    const pllFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "PLLCFGR", .name = "PLLSRC", .type = rccType.PLLSRC, .rccName = "PLLSourceVirtual" },
            .{ .reg = "PLLCFGR", .name = "PLLN", .type = rccType.PLLN, .rccName = "PLLN", .rccIsEnum = false },
        };
    const rtcields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "BDCR", .name = "RTCSEL", .type = rccType.RTCSEL, .rccName = "RCC_RTC_Clock_SourceVirtual", .default = .{ .value = @ptrCast(&rccType.RTCSEL.DISABLE), .unless = "RTCEnable" } },
        };
    const mcoFields: []const util.rccPeripheralField =
        &[_]util.rccPeripheralField{
            .{ .reg = "CFGR", .name = "MCO2SEL", .type = rccType.MCO2SEL, .optional = true, .rccName = "RCC_MCO2Source", .shouldConfigFlag = "MCO2Config" },
            .{ .reg = "CFGR", .name = "MCO1SEL", .type = rccType.MCO1SEL, .optional = true, .rccName = "RCC_MCO1Source", .shouldConfigFlag = "MCO1Config" },
        };

    const enRegs: []const []const u8 = .{
        "AHB1ENR",
        "APB1ENR",
    };

    inline fn peripheral_to_en_reg(peri_name: [:0]const u8) []const u8 {
        return if (util.match_name(peri_name, &.{
            "OTGHSULPI",
            "OTGHS",
            "ETHMACPTP",
            "ETHMACRX",
            "ETHMACTX",
            "ETHMAC",
            "DMA2D",
            "DMA2",
            "DMA1",
            "CCMDATARAM",
            "BKPSRAM",
            "CRC",
            "GPIOK",
            "GPIOJ",
            "GPIOI",
            "GPIOH",
            "GPIOG",
            "GPIOF",
            "GPIOE",
            "GPIOD",
            "GPIOC",
            "GPIOB",
            "GPIOA",
        })) "AHB1ENR" else if (util.match_name(peri_name, &.{
            "DAC",
            "PWD",
            "CAN2",
            "CAN1",
            "I2C3",
            "I2C2",
            "I2C1",
            "UART5",
            "UART4",
            "UART3",
            "UART2",
            "SPI3",
            "SPI2",
            "TIM14",
            "TIM13",
            "TIM12",
            "TIM7",
            "TIM6",
            "TIM5",
            "TIM4",
            "TIM3",
            "TIM2",
        })) "APB1ENR" else @panic("Unknown peripheral");
    }
    // TODO: Should this be the same as above??
    inline fn peripheral_to_rst_reg(peri_name: [:0]const u8) []const u8 {
        return if (util.match_name(peri_name, &.{
            "OTGHSULPI",
            "OTGHS",
            "ETHMACPTP",
            "ETHMACRX",
            "ETHMACTX",
            "ETHMAC",
            "DMA2D",
            "DMA2",
            "DMA1",
            "CCMDATARAM",
            "BKPSRAM",
            "CRC",
            "GPIOK",
            "GPIOJ",
            "GPIOI",
            "GPIOH",
            "GPIOG",
            "GPIOF",
            "GPIOE",
            "GPIOD",
            "GPIOC",
            "GPIOB",
            "GPIOA",
        })) "AHB1ENR" else @panic("No reset possible for this peripheral");
    }
};
