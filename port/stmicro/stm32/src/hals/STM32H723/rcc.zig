const std = @import("std");
const microzig = @import("microzig");
const enums = @import("../common/enums.zig");
const util = @import("../common/util.zig");

//Instances
const Peripherals = enums.Peripherals;
const FLASH = microzig.chip.peripherals.FLASH;
const RCC = microzig.chip.peripherals.RCC;
const PWR = microzig.chip.peripherals.PWR;

//RCC types
const VOS = microzig.chip.types.peripherals.pwr_h7rm0468.VOS;
const HSIDIV = microzig.chip.types.peripherals.rcc_h7.HSIDIV;
const SW = microzig.chip.types.peripherals.rcc_h7.SW;
const HPRE = microzig.chip.types.peripherals.rcc_h7.HPRE;
const PPRE = microzig.chip.types.peripherals.rcc_h7.PPRE;
const PLLM = microzig.chip.types.peripherals.rcc_h7.PLLM;
const PLLN = microzig.chip.types.peripherals.rcc_h7.PLLN;
const PLLDIV = microzig.chip.types.peripherals.rcc_h7.PLLDIV;
const PLLRGE = microzig.chip.types.peripherals.rcc_h7.PLLRGE;
const PLLVCOSEL = microzig.chip.types.peripherals.rcc_h7.PLLVCOSEL;
const PLLSRC = microzig.chip.types.peripherals.rcc_h7.PLLSRC;
const LSEDRV = microzig.chip.types.peripherals.rcc_h7.LSEDRV;
const MCOPRE = microzig.chip.types.peripherals.rcc_h7.MCOPRE;
const MCO1SEL = microzig.chip.types.peripherals.rcc_h7.MCO1SEL;
const MCO2SEL = microzig.chip.types.peripherals.rcc_h7.MCO2SEL;
const TIMPRE = microzig.chip.types.peripherals.rcc_h7.TIMPRE;
const RTCSEL = microzig.chip.types.peripherals.rcc_h7.RTCSEL;
const PERSEL = microzig.chip.types.peripherals.rcc_h7.PERSEL;
const SDMMCSEL = microzig.chip.types.peripherals.rcc_h7.SDMMCSEL;
const FMCSEL = microzig.chip.types.peripherals.rcc_h7.FMCSEL;
const SAISEL = microzig.chip.types.peripherals.rcc_h7.SAISEL;
const SAIASEL = microzig.chip.types.peripherals.rcc_h7.SAIASEL;
const SPI6SEL = microzig.chip.types.peripherals.rcc_h7.SPI6SEL;
const ADCSEL = microzig.chip.types.peripherals.rcc_h7.ADCSEL;
const LPTIMSEL = microzig.chip.types.peripherals.rcc_h7.LPTIM1SEL;
const LPTIM2SEL = microzig.chip.types.peripherals.rcc_h7.LPTIM2SEL;
const LPUARTSEL = microzig.chip.types.peripherals.rcc_h7.LPUARTSEL;
const I2C4SEL = microzig.chip.types.peripherals.rcc_h7.I2C4SEL;
const CECSEL = microzig.chip.types.peripherals.rcc_h7.CECSEL;
const USBSEL = microzig.chip.types.peripherals.rcc_h7.USBSEL;
const I2C1235SEL = microzig.chip.types.peripherals.rcc_h7.I2C1235SEL;
const RNGSEL = microzig.chip.types.peripherals.rcc_h7.RNGSEL;
const USART16910SEL = microzig.chip.types.peripherals.rcc_h7.USART16910SEL;
const USART234578SEL = microzig.chip.types.peripherals.rcc_h7.USART234578SEL;
const SWPMMISEL = microzig.chip.types.peripherals.rcc_h7.SWPMISEL;
const FDCANSEL = microzig.chip.types.peripherals.rcc_h7.FDCANSEL;
const DFSDMSEL = microzig.chip.types.peripherals.rcc_h7.DFSDMSEL;
const SPDIFRXSEL = microzig.chip.types.peripherals.rcc_h7.SPDIFRXSEL;
const SPI45SEL = microzig.chip.types.peripherals.rcc_h7.SPI45SEL;

//clocktree type shortcuts
const ClockTree = @field(@import("ClockTree"), microzig.config.chip_name);
const Config = ClockTree.Config;
const Clock_Output = ClockTree.Clock_Output;
const Config_Output = ClockTree.Config_Output;

var current_clk: Clock_Output = blk: {
    const ret = ClockTree.get_clocks(.{}) catch unreachable;
    break :blk ret.clock;
};

/// Configuration for a PLL instance
/// optional DIVP, DIVQ, DIVR can be null if not used.
/// (this means that the respective output is going to be disabled!)
pub const PLL_Config = struct {
    DIVM: PLLM,
    DIVN: PLLN,
    VCI_range: PLLRGE,
    VCO_selection: PLLVCOSEL,
    DIVP: ?PLLDIV,
    DIVQ: ?PLLDIV,
    DIVR: ?PLLDIV,
    fractional: ?u13,
};

pub const MCO_Config = struct {
    mco1_src: MCO1SEL,
    mco2_src: MCO2SEL,

    mco1_pre: MCOPRE,
    mco2_pre: MCOPRE,
};

pub const Sysclk_Config = struct {
    upscale: bool,
    falsh_latency: u3,
    flash_signal_delay: u2,
    power_scale: VOS,
    clk_src: SW,
};

pub const D1_Kernel_Config = struct {
    peri_src: PERSEL,
    sdmcc_src: SDMMCSEL,
    octospi_src: FMCSEL,
    fmc_src: FMCSEL,
};

pub const D2_Kernel_Config = struct {
    //CCIP1R
    spwmi_src: SWPMMISEL,
    dfsdm_src: DFSDMSEL,
    fdcan_src: FDCANSEL,
    spdifrx_src: SPDIFRXSEL,
    spi45_src: SPI45SEL,
    spi123_src: SAISEL,
    sai23_src: SAISEL,
    sai1_src: SAISEL,
    //CCIP2R
    lptim1_src: LPTIMSEL,
    usart234578_src: USART234578SEL,
    usart16910_src: USART16910SEL,
    rng_src: RNGSEL,
    i2c1235_src: I2C1235SEL,
    usb_src: USBSEL,
    cec_src: CECSEL,
};

pub const D3_Kernel_Config = struct {
    lpuart1: LPUARTSEL,
    i2c4_src: I2C4SEL,
    lptim2_src: LPTIM2SEL,
    lptim345_src: LPTIM2SEL,
    adc_src: ADCSEL,
    sai4a_src: SAIASEL,
    sai4b_src: SAIASEL,
    spi6_src: SPI6SEL,
};
/// configure clocks
/// NOTE: this function expects the current clock to be in a valid state and free of glitches in the flash and PWR domains
/// it is important that any external change (whether manual or caused by hardware events) to the clock tree be restored before calling this function
pub fn apply(comptime config: Config) !Clock_Output {
    const clk = comptime ClockTree.get_clocks(config) catch unreachable;
    current_clk = clk.clock;

    //verify if we need to upscale or downscale
    const HSI_CLK = if (clk.clock.HSIDiv == 0) 64_000_000 else clk.clock.HSIDiv;
    const secure_sys_upscale: bool = current_clk.CpuClockOutput >= HSI_CLK;
    const target_sys_upscale: bool = clk.clock.CpuClockOutput >= HSI_CLK;

    const hsi_div: HSIDIV = if (clk.config.HSIDiv) |d| @as(HSIDIV, @enumFromInt(@as(u2, @intFromEnum(d)))) else .Div1;
    const trim = if (clk.config.HSICalibrationValue) |v| @as(u7, @intCast(@as(u32, @intFromFloat(v)))) else null;
    secure_enable(secure_sys_upscale, hsi_div, trim); //force sysclk into secure state

    try apply_internal(clk.config, target_sys_upscale);
    return clk.clock;
}

/// forces sysclk into a secure state, by using HSI at 64/hsi_div MHz as the temporary sysclk source.
/// upscale: true if the HSI frequency is grater than the current sysclk frequency
fn secure_enable(upscale: bool, hsi_div: HSIDIV, trim: ?u7) void {
    enable_hsi(null, null);

    set_sysclk(.{
        .upscale = upscale,
        .falsh_latency = 0b111,
        .flash_signal_delay = 0b11,
        .power_scale = .Scale3,
        .clk_src = .HSI,
    });

    //now that sysclock is HSI, we can safely set the dividers
    const pll_states = RCC.CR.read();
    //disable all PLLs to safely change HSI dividers
    RCC.CR.modify(.{
        .@"PLLON[0]" = 0,
        .@"PLLON[1]" = 0,
        .@"PLLON[2]" = 0,
    });

    while (RCC.CR.read().@"PLLRDY[0]" != 0) {
        asm volatile ("" ::: .{ .memory = true });
    }

    //configure and enable HSI with desired trim and division
    enable_hsi(trim, hsi_div);

    //set PLL states back to previous values
    //we dont need to wait for PLLs to lock here, as we are not using them yet
    RCC.CR.modify(.{
        .@"PLLON[0]" = pll_states.@"PLLON[0]",
        .@"PLLON[1]" = pll_states.@"PLLON[1]",
        .@"PLLON[2]" = pll_states.@"PLLON[2]",
    });

    //set D1 domain prescalers to no division
    set_D1_prescaler(.Div1, .Div1, .Div1);
}

fn apply_internal(comptime config: Config_Output, upscale: bool) !void {
    const actual_state = RCC.CR.read();

    const d1_core_pre: HPRE = blk: {
        if (config.D1CPRE) |p| {
            break :blk switch (p) {
                .RCC_SYSCLK_DIV1 => HPRE.Div1,
                .RCC_SYSCLK_DIV2 => HPRE.Div2,
                .RCC_SYSCLK_DIV4 => HPRE.Div4,
                .RCC_SYSCLK_DIV8 => HPRE.Div8,
                .RCC_SYSCLK_DIV16 => HPRE.Div16,
                .RCC_SYSCLK_DIV64 => HPRE.Div64,
                .RCC_SYSCLK_DIV128 => HPRE.Div128,
                .RCC_SYSCLK_DIV256 => HPRE.Div256,
                .RCC_SYSCLK_DIV512 => HPRE.Div512,
            };
        }
        break :blk HPRE.Div1; //default reset
    };

    const d1_ahb_pre: HPRE = blk: {
        if (config.HPRE) |p| {
            break :blk switch (p) {
                .RCC_HCLK_DIV1 => HPRE.Div1,
                .RCC_HCLK_DIV2 => HPRE.Div2,
                .RCC_HCLK_DIV4 => HPRE.Div4,
                .RCC_HCLK_DIV8 => HPRE.Div8,
                .RCC_HCLK_DIV16 => HPRE.Div16,
                .RCC_HCLK_DIV64 => HPRE.Div64,
                .RCC_HCLK_DIV128 => HPRE.Div128,
                .RCC_HCLK_DIV256 => HPRE.Div256,
                .RCC_HCLK_DIV512 => HPRE.Div512,
            };
        }
        break :blk HPRE.Div1; //default reset

    };

    const d1_apb_pre: PPRE = blk: {
        if (config.D1PPRE) |p| {
            break :blk switch (p) {
                .RCC_APB3_DIV1 => PPRE.Div1,
                .RCC_APB3_DIV2 => PPRE.Div2,
                .RCC_APB3_DIV4 => PPRE.Div4,
                .RCC_APB3_DIV8 => PPRE.Div8,
                .RCC_APB3_DIV16 => PPRE.Div16,
            };
        }
        break :blk PPRE.Div1; //default reset

    };

    const d2_apb1: PPRE = blk: {
        if (config.D2PPRE1) |p| {
            break :blk switch (p) {
                .RCC_APB1_DIV1 => PPRE.Div1,
                .RCC_APB1_DIV2 => PPRE.Div2,
                .RCC_APB1_DIV4 => PPRE.Div4,
                .RCC_APB1_DIV8 => PPRE.Div8,
                .RCC_APB1_DIV16 => PPRE.Div16,
            };
        }
        break :blk PPRE.Div1; //default reset

    };

    const d2_apb2: PPRE = blk: {
        if (config.D2PPRE2) |p| {
            break :blk switch (p) {
                .RCC_APB2_DIV1 => PPRE.Div1,
                .RCC_APB2_DIV2 => PPRE.Div2,
                .RCC_APB2_DIV4 => PPRE.Div4,
                .RCC_APB2_DIV8 => PPRE.Div8,
                .RCC_APB2_DIV16 => PPRE.Div16,
            };
        }
        break :blk PPRE.Div1; //default reset

    };

    const d3_apb1: PPRE = blk: {
        if (config.D3PPRE) |p| {
            break :blk switch (p) {
                .RCC_APB4_DIV1 => PPRE.Div1,
                .RCC_APB4_DIV2 => PPRE.Div2,
                .RCC_APB4_DIV4 => PPRE.Div4,
                .RCC_APB4_DIV8 => PPRE.Div8,
                .RCC_APB4_DIV16 => PPRE.Div16,
            };
        }
        break :blk PPRE.Div1; //default reset

    };

    const tim_pre: TIMPRE = if (config.RCC_TIM_PRescaler_Selection.? == .RCC_TIMPRES_ACTIVATED) TIMPRE.DefaultX4 else TIMPRE.DefaultX2;

    //sys main
    const vos: VOS = switch (config.PWR_Regulator_Voltage_Scale.?) {
        .PWR_REGULATOR_VOLTAGE_SCALE3 => VOS.Scale3,
        .PWR_REGULATOR_VOLTAGE_SCALE2 => VOS.Scale2,
        .PWR_REGULATOR_VOLTAGE_SCALE1 => VOS.Scale1,
        .PWR_REGULATOR_VOLTAGE_SCALE0 => VOS.Scale0,
    };
    // NOTE: the system does not validate correct WRHIGHFREQ + flash latency configurations,
    // so CubeMX always sets them to the closest recommended values.
    // Manual changes can be made without affecting the clock tree
    const flantency: u2 = @intFromEnum(config.FLatency.?); // the same value is valid for WRHIGHFREQ and flash latency

    const sysclk: SW = @enumFromInt(@as(u3, @intFromEnum(config.SYSCLKSource.?)));

    //D1 kernel clocks
    const fmc_src: FMCSEL = @enumFromInt(@as(u2, @intFromEnum(config.FMCCLockSelection.?)));
    const ospi_src: FMCSEL = if (config.flags.OCTOSPIEnable) @enumFromInt(@as(u2, @intFromEnum(config.QSPICLockSelection.?))) else FMCSEL.HCLK3;
    const mmc_src: SDMMCSEL = @enumFromInt(@as(u1, @intFromEnum(config.SDMMC1CLockSelection.?)));
    const presel_src: PERSEL = @enumFromInt(@as(u1, @intFromEnum(config.CKPERSourceSelection.?)));

    //D2 kernel clocks
    const sai1_src: SAISEL = @enumFromInt(@as(u3, @intFromEnum(config.SAI1CLockSelection.?)));
    const spi123_src: SAISEL = @enumFromInt(@as(u3, @intFromEnum(config.SPI123CLockSelection.?)));
    const spi45_src: SPI45SEL = @enumFromInt(@as(u3, @intFromEnum(config.Spi45ClockSelection.?)));
    const spdifrx_src: SPDIFRXSEL = @enumFromInt(@as(u3, @intFromEnum(config.SPDIFCLockSelection.?)));
    const dfsdm_src: DFSDMSEL = @enumFromInt(@as(u1, @intFromEnum(config.DFSDMCLockSelection.?)));
    const fdcan_src: FDCANSEL = @enumFromInt(@as(u2, @intFromEnum(config.FDCANCLockSelection.?)));
    const swpmi: SWPMMISEL = @enumFromInt(@as(u1, @intFromEnum(config.SWPCLockSelection.?)));
    const usart234578_src: USART234578SEL = @enumFromInt(@as(u3, @intFromEnum(config.USART234578CLockSelection.?)));
    const usart16910_src: USART16910SEL = @enumFromInt(@as(u3, @intFromEnum(config.USART16CLockSelection.?)));
    const rng_src: RNGSEL = @enumFromInt(@as(u2, @intFromEnum(config.RNGCLockSelection.?)));
    const i2c1235_src: I2C1235SEL = @enumFromInt(@as(u2, @intFromEnum(config.I2C123CLockSelection.?)));
    const usb_src: USBSEL = if (config.flags.USBEnable)
        @enumFromInt(@as(u3, @intFromEnum(config.USBCLockSelection.?)) + 1)
    else
        USBSEL.DISABLE;

    const cec_src: CECSEL = @enumFromInt(@as(u2, @intFromEnum(config.CECCLockSelection.?)));
    const tim1_src: LPTIMSEL = @enumFromInt(@as(u3, @intFromEnum(config.LPTIM1CLockSelection.?)));

    //D3 kernel clocks
    const lpuart1_src: LPUARTSEL = @enumFromInt(@as(u3, @intFromEnum(config.LPUART1CLockSelection.?)));
    const i2c4_src: I2C4SEL = @enumFromInt(@as(u2, @intFromEnum(config.I2C4CLockSelection.?)));
    const lptim2_src: LPTIM2SEL = @enumFromInt(@as(u3, @intFromEnum(config.LPTIM2CLockSelection.?)));
    const lptim34_src: LPTIM2SEL = @enumFromInt(@as(u3, @intFromEnum(config.LPTIM345CLockSelection.?)));
    const adc_src: ADCSEL = @enumFromInt(@as(u2, @intFromEnum(config.ADCCLockSelection.?)));
    const sai4a_src: SAIASEL = @enumFromInt(@as(u3, @intFromEnum(config.SAI4ACLockSelection.?)));
    const sai4b_src: SAIASEL = @enumFromInt(@as(u3, @intFromEnum(config.SAI4BCLockSelection.?)));
    const spi6_src: SPI6SEL = @enumFromInt(@as(u3, @intFromEnum(config.SPI6CLockSelection.?)));

    PWR.CR1.modify_one("DBP", 1); //enable access to backup domain
    defer PWR.CR1.modify_one("DBP", 0);

    //first, enable the required oscillators
    // we cannot disable unused oscillators in this stage, because switching clock requires both new and old clock to be enabled
    //HSI is always enabled from secure_enable

    if (!config.flags.HSIUsed) {
        defer disable_hsi();
    }

    if (config.flags.HSI48Used) {
        enable_hsi48();
    } else {
        defer disable_hsi48();
    }

    if (config.flags.CSIUsed) {
        const trim = if (config.CSICalibrationValue) |v| @as(u6, @intCast(@as(u32, @intFromFloat(v)))) else null;
        enable_csi(trim);
    } else {
        defer disable_csi();
    }

    if (config.flags.LSIEnable) {
        enable_lsi();
    } else {
        defer disable_lsi();
    }

    if (config.flags.EnableHSE) {
        const css = config.flags.EnbaleCSS;
        const bypass = config.flags.HSEByPass;
        const timeout = if (config.HSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
        try enable_hse(css, bypass, timeout);
    } else {
        defer disable_hse();
    }

    if (config.flags.LSEUsed) {
        //const css = config.
        const bypass = config.flags.LSEByPass;
        const timeout = if (config.LSE_Timout) |t| @as(usize, @intFromFloat(t)) else null;
        const css = config.flags.EnableCSSLSE;
        const driver: LSEDRV = blk: {
            if (config.LSE_Drive_Capability) |drv| {
                break :blk @as(LSEDRV, @enumFromInt(@as(u2, @intFromEnum(drv))));
            } else break :blk LSEDRV.MediumLow;
        };

        try enable_lse(css, bypass, driver, timeout);
    } else {
        defer disable_lse();
    }
    // Second: configure the PLLs
    // even if a PLL is not used in this configuration, its state must be restored after this stage
    // and it can only be actually disabled after finishing this configuration to avoid putting the clock into an invalid state.

    //force disable all PLL before config

    disable_PLL1();
    disable_PLL2();
    disable_PLL3();

    if (config.PLLSource) |s| {
        const src: PLLSRC = @enumFromInt(@intFromEnum(s));
        set_plls_source(src);
    }

    if (config.flags.PLLUsed) {
        // if a PLL is active and valid, these values will never be null
        const divm: PLLM = @enumFromInt(@as(u6, @intFromFloat(config.DIVM1.?)));
        const divn: PLLN = @enumFromInt(@as(u9, @intFromFloat(config.DIVN1.?)) - 1);
        const vci: PLLRGE = @enumFromInt(@intFromEnum(config.PLL1_VCI_Range.?));
        const vco: PLLVCOSEL = switch (config.PLL1_VCO_SEL.?) {
            .RCC_PLL1VCOMEDIUM => PLLVCOSEL.MediumVCO,
            .RCC_PLL1VCOWIDE => PLLVCOSEL.WideVCO,
        };

        // these values are optional
        const frac = if (config.PLLFRACN) |f| @as(u13, @intCast(@as(u32, @intFromFloat(f)))) else null;
        const divq: ?PLLDIV = blk: {
            if (config.flags.DIVQ1Enable) {
                if (config.DIVQ1) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        // DIVP1 does not have an enable flag in CubeMX, therefore there is no flag to check here
        const divp: ?PLLDIV = blk: {
            if (config.DIVP1) |d| {
                const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                break :blk @enumFromInt(v);
            }
            break :blk null;
        };
        const divr: ?PLLDIV = blk: {
            if (config.flags.DIVR1Enable) {
                if (config.DIVR1) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        enable_PLL1(PLL_Config{
            .DIVM = divm,
            .DIVN = divn,
            .VCI_range = vci,
            .VCO_selection = vco,
            .DIVP = divp,
            .DIVQ = divq,
            .DIVR = divr,
            .fractional = frac,
        });
    } else {
        //Restore PLL state and set to disable after clock config
        RCC.CR.modify_one("PLLON[0]", actual_state.@"PLLON[0]");
        disable_PLL1();
    }

    if (config.flags.PLL2Used) {
        // if a PLL is active and valid, these values will never be null
        const divm: PLLM = @enumFromInt(@as(u6, @intFromFloat(config.DIVM2.?)));
        const divn: PLLN = @enumFromInt(@as(u9, @intFromFloat(config.DIVN2.?)) - 1);
        const vci: PLLRGE = @enumFromInt(@intFromEnum(config.PLL2_VCI_Range.?));
        const vco: PLLVCOSEL = switch (config.PLL2_VCO_SEL.?) {
            .RCC_PLL2VCOMEDIUM => PLLVCOSEL.MediumVCO,
            .RCC_PLL2VCOWIDE => PLLVCOSEL.WideVCO,
        };

        // these values are optional
        const frac = if (config.PLL2FRACN) |f| @as(u13, @intCast(@as(u32, @intFromFloat(f)))) else null;
        const divq: ?PLLDIV = blk: {
            if (config.flags.DIVQ2Enable) {
                if (config.DIVQ2) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        const divp: ?PLLDIV = blk: {
            if (config.flags.DIVP2Enable) {
                if (config.DIVP2) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        const divr: ?PLLDIV = blk: {
            if (config.flags.DIVR2Enable) {
                if (config.DIVR2) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        enable_PLL2(PLL_Config{
            .DIVM = divm,
            .DIVN = divn,
            .VCI_range = vci,
            .VCO_selection = vco,
            .DIVP = divp,
            .DIVQ = divq,
            .DIVR = divr,
            .fractional = frac,
        });
    } else {
        //Restore PLL state and set to disable after clock config
        RCC.CR.modify_one("PLLON[1]", actual_state.@"PLLON[1]");
        disable_PLL2();
    }

    if (config.flags.PLL3Used) {
        // if a PLL is active and valid, these values will never be null
        const divm: PLLM = @enumFromInt(@as(u6, @intFromFloat(config.DIVM3.?)));
        const divn: PLLN = @enumFromInt(@as(u9, @intFromFloat(config.DIVN3.?)) - 1);
        const vci: PLLRGE = @enumFromInt(@intFromEnum(config.PLL3_VCI_Range.?));
        const vco: PLLVCOSEL = switch (config.PLL3_VCO_SEL.?) {
            .RCC_PLL3VCOMEDIUM => PLLVCOSEL.MediumVCO,
            .RCC_PLL3VCOWIDE => PLLVCOSEL.WideVCO,
        };

        // these values are optional
        const frac = if (config.PLL3FRACN) |f| @as(u13, @intCast(@as(u32, @intFromFloat(f)))) else null;
        const divq: ?PLLDIV = blk: {
            if (config.flags.DIVQ3Enable) {
                if (config.DIVQ3) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        const divp: ?PLLDIV = blk: {
            if (config.flags.DIVP3Enable) {
                if (config.DIVP3) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        const divr: ?PLLDIV = blk: {
            if (config.flags.DIVR3Enable) {
                if (config.DIVR3) |d| {
                    const v: u7 = @intCast(@as(u32, @intFromFloat(d)) - 1);
                    break :blk @enumFromInt(v);
                }
            }
            break :blk null;
        };

        enable_PLL3(PLL_Config{
            .DIVM = divm,
            .DIVN = divn,
            .VCI_range = vci,
            .VCO_selection = vco,
            .DIVP = divp,
            .DIVQ = divq,
            .DIVR = divr,
            .fractional = frac,
        });
    } else {
        //Restore PLL state and set to disable after clock config
        RCC.CR.modify_one("PLLON[2]", actual_state.@"PLLON[2]");
        disable_PLL3();
    }

    // Third: apply prescalers (except for the D1 prescaler, these will be applied only during the sysclk clock switch)

    set_D2_prescaler(d2_apb1, d2_apb2);
    set_D3_prescaler(d3_apb1);
    set_rcc_tim_pre(tim_pre);
    // final stage: apply clock switches and configure the system properly

    // changing D1 without checking for upscale is safe here, since both VOS and FLASH are configured for maximum HSI(secure_enable clock)
    set_D1_prescaler(d1_core_pre, d1_ahb_pre, d1_apb_pre);
    set_sysclk(Sysclk_Config{
        .clk_src = sysclk,
        .falsh_latency = flantency,
        .flash_signal_delay = flantency,
        .power_scale = vos,
        .upscale = upscale,
    });

    if (config.flags.MCO1OutPutEnable) {
        const src: MCO1SEL = switch (config.RCC_MCO1Source.?) {
            .RCC_MCO1SOURCE_LSE => MCO1SEL.LSE,
            .RCC_MCO1SOURCE_HSE => MCO1SEL.HSE,
            .RCC_MCO1SOURCE_HSI => MCO1SEL.HSI,
            .RCC_MCO1SOURCE_HSI48 => MCO1SEL.HSI48,
            .RCC_MCO1SOURCE_PLL1QCLK => MCO1SEL.PLL1_Q,
        };

        const mco1_pre: MCOPRE = blk: {
            if (config.RCC_MCODiv1) |p| {
                const n: u4 = @intFromEnum(p);
                break :blk @enumFromInt(n + 1);
            }
            break :blk MCOPRE.Div1;
        };

        set_mco1_params(src, mco1_pre);
    }

    if (config.flags.MCO2OutPutEnable) {
        const src: MCO2SEL = switch (config.RCC_MCO2Source.?) {
            .RCC_MCO2SOURCE_SYSCLK => MCO2SEL.SYS,
            .RCC_MCO2SOURCE_PLL2PCLK => MCO2SEL.PLL2_P,
            .RCC_MCO2SOURCE_HSE => MCO2SEL.HSE,
            .RCC_MCO2SOURCE_PLLCLK => MCO2SEL.PLL1_P,
            .RCC_MCO2SOURCE_CSICLK => MCO2SEL.CSI,
            .RCC_MCO2SOURCE_LSICLK => MCO2SEL.LSI,
        };

        const mco2_pre: MCOPRE = blk: {
            if (config.RCC_MCODiv2) |p| {
                const n: u4 = @intFromEnum(p);
                break :blk @enumFromInt(n + 1);
            }
            break :blk MCOPRE.Div1;
        };

        set_mco2_params(src, mco2_pre);
    }

    if (config.flags.RTCEnable) {
        const pre: u6 = if (config.RCC_RTC_Clock_Source_FROM_HSE) |d| @intCast(@as(u32, @intFromFloat(d.get()))) else 0;
        const src: RTCSEL = blk: {
            break :blk switch (config.RTCClockSelection.?) {
                .HSERTCDevisor => RTCSEL.HSE,
                .RCC_RTCCLKSOURCE_LSE => RTCSEL.LSE,
                .RCC_RTCCLKSOURCE_LSI => RTCSEL.LSI,
            };
        };
        set_RTC_params(src, pre);
    } else {
        set_RTC_params(.DISABLE, 63);
    }

    config_d1_kernel_srcs(.{
        .fmc_src = fmc_src,
        .octospi_src = ospi_src,
        .peri_src = presel_src,
        .sdmcc_src = mmc_src,
    });

    config_d2_kernel_src(.{
        .cec_src = cec_src,
        .dfsdm_src = dfsdm_src,
        .fdcan_src = fdcan_src,
        .i2c1235_src = i2c1235_src,
        .lptim1_src = tim1_src,
        .rng_src = rng_src,
        .sai1_src = sai1_src,
        .sai23_src = .PER, // not present in STM32H723VG
        .spdifrx_src = spdifrx_src,
        .spi123_src = spi123_src,
        .spi45_src = spi45_src,
        .spwmi_src = swpmi,
        .usart16910_src = usart16910_src,
        .usart234578_src = usart234578_src,
        .usb_src = usb_src,
    });

    config_d3_kernel_src(D3_Kernel_Config{
        .adc_src = adc_src,
        .i2c4_src = i2c4_src,
        .lptim2_src = lptim2_src,
        .lptim345_src = lptim34_src,
        .lpuart1 = lpuart1_src,
        .sai4a_src = sai4a_src,
        .sai4b_src = sai4b_src,
        .spi6_src = spi6_src,
    });
}

pub fn set_power_scale(scale: VOS) void {
    PWR.D3CR.modify_one("VOS", scale); //set VOS scale

    //wait until voltage scaling is applied
    while (@as(u2, @intFromEnum(PWR.D3CR.read().VOS)) != PWR.CSR1.read().ACTVOS) {
        asm volatile ("" ::: .{ .memory = true });
    }

    //wait until voltage scaling is ready
    while (PWR.CSR1.read().ACTVOSRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn set_flash(latency: u3, signal_delay: u2) void {
    FLASH.ACR.modify(.{
        .LATENCY = latency,
        .WRHIGHFREQ = signal_delay,
    });
}

/// enables the HSI oscillator with optional trimming and division
/// NOTE: Division can only be applied when the HSI is not used by some PLL
pub fn enable_hsi(trim: ?u7, div: ?HSIDIV) void {
    if (trim) |t| {
        RCC.HSICFGR.modify_one("HSITRIM", t);
    }

    if (div) |d| {
        RCC.CR.modify_one("HSIDIV", d);
    }

    RCC.CR.modify_one("HSION", 1);
    while (RCC.CR.read().HSIRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_hsi() void {
    RCC.CR.modify_one("HSION", 0);
}

pub fn enable_hsi48() void {
    RCC.CR.modify_one("HSI48ON", 1);
    while (RCC.CR.read().HSI48RDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn disable_hsi48() void {
    RCC.CR.modify_one("HSI48ON", 0);
}

pub fn enable_csi(trim: ?u6) void {
    if (trim) |t| {
        RCC.CSICFGR.modify_one("CSITRIM", t);
    }
    RCC.CR.modify_one("CSION", 1);
    while (RCC.CR.read().CSIRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_csi() void {
    RCC.CR.modify_one("CSION", 0);
}

pub fn enable_lsi() void {
    RCC.CSR.modify_one("LSION", 1);

    while (RCC.CSR.read().LSIRDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_lsi() void {
    RCC.CSR.modify_one("LSION", 0);
}

pub fn enable_hse(css: bool, bypass: bool, timeout: ?usize) error{HSE_Timeout}!void {
    var wait_ticks: usize = blk: {
        if (timeout) |t| {
            break :blk calc_wait_ticks(t);
        } else {
            break :blk std.math.maxInt(usize);
        }
    };

    RCC.CR.modify(.{
        .HSEBYP = @intFromBool(bypass),
        .HSECSSON = @intFromBool(css),
        .HSEON = 1,
    });

    while (RCC.CR.read().HSERDY != 1) : (wait_ticks -= 1) {
        if (wait_ticks == 0) {
            //timeout reached
            return error.HSE_Timeout;
        }

        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_hse() void {
    RCC.CR.modify_one("HSEON", 0);
}

pub fn enable_lse(css: bool, bypass: bool, drive: LSEDRV, timeout: ?usize) error{LSE_Timeout}!void {
    var wait_ticks: usize = blk: {
        if (timeout) |t| {
            break :blk calc_wait_ticks(t);
        } else {
            break :blk std.math.maxInt(usize);
        }
    };

    RCC.BDCR.modify(.{
        .LSEBYP = @intFromBool(bypass),
        .LSECSSON = @intFromBool(css),
        .LSEON = 1,
        .LSEDRV = drive,
    });

    while (RCC.BDCR.read().LSERDY != 1) : (wait_ticks -= 1) {
        if (wait_ticks == 0) {
            //timeout reached
            return error.LSE_Timeout;
        }

        asm volatile ("" ::: .{ .memory = true });
    }
}

pub inline fn disable_lse() void {
    PWR.CR1.modify_one("DBP", 1); //enable access to backup domain
    RCC.BDCR.modify_one("LSEON", 0);
}
/// Change the PLL clock source
/// NOTE: This function should only be used while ALL PLLs are disabled
pub fn set_plls_source(src: PLLSRC) void {
    RCC.PLLCKSELR.modify_one("PLLSRC", src);
}

pub fn enable_PLL1(config: PLL_Config) void {
    // first set the dividers and then enable the clocks
    RCC.PLLCKSELR.modify_one("DIVM[0]", config.DIVM);
    RCC.PLLDIVR.modify_one("PLLN", config.DIVN);
    RCC.PLLCFGR.modify(.{
        .@"PLLVCOSEL[0]" = config.VCO_selection,
        .@"PLLRGE[0]" = config.VCI_range,
    });

    if (config.DIVP) |c| {
        RCC.PLLDIVR.modify_one("PLLP", c);
        RCC.PLLCFGR.modify_one("DIVPEN[0]", 1);
    }

    if (config.DIVQ) |c| {
        RCC.PLLDIVR.modify_one("PLLQ", c);
        RCC.PLLCFGR.modify_one("DIVQEN[0]", 1);
    }

    if (config.DIVR) |c| {
        RCC.PLLDIVR.modify_one("PLLR", c);
        RCC.PLLCFGR.modify_one("DIVREN[0]", 1);
    }

    if (config.fractional) |f| {
        RCC.PLLCFGR.modify_one("PLLFRACEN[0]", 0);
        RCC.PLLFRACR.modify_one("FRACN", f);
        RCC.PLLCFGR.modify_one("PLLFRACEN[0]", 1);
    }

    RCC.CR.modify_one("PLLON[0]", 1);
    while (RCC.CR.read().@"PLLRDY[0]" != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

// TODO: maybe create a function to disable PLL dividers individually
pub fn disable_PLL1() void {
    RCC.CR.modify_one("PLLON[0]", 0);
    while (RCC.CR.read().@"PLLRDY[0]" != 0) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

// TODO: fix MMIO to include registers for PLL2 and PLL3
pub fn enable_PLL2(config: PLL_Config) void {
    const PLL2DIVR: *volatile @TypeOf(RCC.PLLDIVR) = @ptrFromInt(@intFromPtr(RCC) + 0x38);
    const PLL2FRACR: *volatile @TypeOf(RCC.PLLFRACR) = @ptrFromInt(@intFromPtr(RCC) + 0x3C);

    // first set the dividers and then enable the clocks
    RCC.PLLCKSELR.modify_one("DIVM[1]", config.DIVM);
    PLL2DIVR.modify_one("PLLN", config.DIVN);
    RCC.PLLCFGR.modify(.{
        .@"PLLVCOSEL[1]" = config.VCO_selection,
        .@"PLLRGE[1]" = config.VCI_range,
    });

    if (config.DIVP) |c| {
        PLL2DIVR.modify_one("PLLP", c);
        RCC.PLLCFGR.modify_one("DIVPEN[1]", 1);
    }

    if (config.DIVQ) |c| {
        PLL2DIVR.modify_one("PLLQ", c);
        RCC.PLLCFGR.modify_one("DIVQEN[1]", 1);
    }

    if (config.DIVR) |c| {
        PLL2DIVR.modify_one("PLLR", c);
        RCC.PLLCFGR.modify_one("DIVREN[1]", 1);
    }

    if (config.fractional) |f| {
        RCC.PLLCFGR.modify_one("PLLFRACEN[1]", 0);
        PLL2FRACR.modify_one("FRACN", f);
        RCC.PLLCFGR.modify_one("PLLFRACEN[1]", 1);
    }

    RCC.CR.modify_one("PLLON[1]", 1);
    while (RCC.CR.read().@"PLLRDY[1]" != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn disable_PLL2() void {
    RCC.CR.modify_one("PLLON[1]", 0);
    while (RCC.CR.read().@"PLLRDY[1]" != 0) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn enable_PLL3(config: PLL_Config) void {
    const PLL3DIVR: *volatile @TypeOf(RCC.PLLDIVR) = @ptrFromInt(@intFromPtr(RCC) + 0x40);
    const PLL3FRACR: *volatile @TypeOf(RCC.PLLFRACR) = @ptrFromInt(@intFromPtr(RCC) + 0x44);

    // first set the dividers and then enable the clocks
    RCC.PLLCKSELR.modify_one("DIVM[2]", config.DIVM);
    PLL3DIVR.modify_one("PLLN", config.DIVN);
    RCC.PLLCFGR.modify(.{
        .@"PLLVCOSEL[2]" = config.VCO_selection,
        .@"PLLRGE[2]" = config.VCI_range,
    });

    if (config.DIVP) |c| {
        PLL3DIVR.modify_one("PLLP", c);
        RCC.PLLCFGR.modify_one("DIVPEN[2]", 1);
    }

    if (config.DIVQ) |c| {
        PLL3DIVR.modify_one("PLLQ", c);
        RCC.PLLCFGR.modify_one("DIVQEN[2]", 1);
    }

    if (config.DIVR) |c| {
        PLL3DIVR.modify_one("PLLR", c);
        RCC.PLLCFGR.modify_one("DIVREN[2]", 1);
    }

    if (config.fractional) |f| {
        RCC.PLLCFGR.modify_one("PLLFRACEN[2]", 0);
        PLL3FRACR.modify_one("FRACN", f);
        RCC.PLLCFGR.modify_one("PLLFRACEN[2]", 1);
    }

    RCC.CR.modify_one("PLLON[2]", 1);
    while (RCC.CR.read().@"PLLRDY[2]" != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn disable_PLL3() void {
    RCC.CR.modify_one("PLLON[2]", 0);
    while (RCC.CR.read().@"PLLRDY[2]" != 0) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn set_sysclock_source(src: SW) void {
    RCC.CFGR.modify_one("SW", src);
    while (RCC.CFGR.read().SW != RCC.CFGR.read().SWS) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn set_D1_prescaler(core: HPRE, AHB: HPRE, APB3: PPRE) void {
    RCC.D1CFGR.modify(.{
        .D1CPRE = core,
        .HPRE = AHB,
        .D1PPRE = APB3,
    });

    //wait until core prescaler is applied
    while (RCC.D1CFGR.read().D1CPRE != core) {
        asm volatile ("" ::: .{ .memory = true });
    }
}

pub fn set_D2_prescaler(d2_apb1: PPRE, d2_apb2: PPRE) void {
    RCC.D2CFGR.modify(.{
        .D2PPRE1 = d2_apb1,
        .D2PPRE2 = d2_apb2,
    });
}

pub fn set_D3_prescaler(d3_apb: PPRE) void {
    RCC.D3CFGR.modify_one("D3PPRE", d3_apb);
}

pub fn set_sysclk(config: Sysclk_Config) void {

    //if upscaling, set voltage scaling and flash latency before changing sysclock
    //else, set them after changing sysclock
    if (config.upscale) {
        set_flash(config.falsh_latency, config.flash_signal_delay);
        set_power_scale(config.power_scale);
    } else {
        defer set_flash(config.falsh_latency, config.flash_signal_delay);
        defer set_power_scale(config.power_scale);
    }

    set_sysclock_source(config.clk_src);
}

pub fn set_mco1_params(src: MCO1SEL, div: MCOPRE) void {
    RCC.CFGR.modify(.{
        .MCO1PRE = div,
        .MCO1SEL = src,
    });
}

pub fn set_mco2_params(src: MCO2SEL, div: MCOPRE) void {
    RCC.CFGR.modify(.{
        .MCO2PRE = div,
        .MCO2SEL = src,
    });
}

///set RTC config params
/// NOTE: Div only applies when the RTC clock source is HSE,
/// otherwise the value is simply ignored
pub fn set_RTC_params(src: RTCSEL, div: u6) void {
    RCC.CFGR.modify_one("RTCPRE", div);
    RCC.BDCR.modify_one("RTCSEL", src);
}

pub fn set_rcc_tim_pre(p: TIMPRE) void {
    RCC.CFGR.modify_one("TIMPRE", p);
}

pub fn config_d1_kernel_srcs(config: D1_Kernel_Config) void {
    RCC.D1CCIPR.modify(.{
        .FMCSEL = config.fmc_src,
        .OCTOSPISEL = config.octospi_src,
        .SDMMCSEL = config.sdmcc_src,
        .PERSEL = config.peri_src,
    });
}

pub fn config_d2_kernel_src(config: D2_Kernel_Config) void {
    RCC.D2CCIP1R.modify(.{
        .SAI1SEL = config.sai1_src,
        .SAI23SEL = config.sai23_src,
        .SPI123SEL = config.spi123_src,
        .SPI45SEL = config.spi45_src,
        .SPDIFRXSEL = config.spdifrx_src,
        .DFSDM1SEL = config.dfsdm_src,
        .FDCANSEL = config.fdcan_src,
        .SWPMISEL = config.spwmi_src,
    });

    RCC.D2CCIP2R.modify(.{
        .USART234578SEL = config.usart234578_src,
        .USART16910SEL = config.usart16910_src,
        .RNGSEL = config.rng_src,
        .I2C1235SEL = config.i2c1235_src,
        .USBSEL = config.usb_src,
        .CECSEL = config.cec_src,
        .LPTIM1SEL = config.lptim1_src,
    });
}

pub fn config_d3_kernel_src(config: D3_Kernel_Config) void {
    RCC.D3CCIPR.modify(.{
        .LPUART1SEL = config.lpuart1,
        .I2C4SEL = config.i2c4_src,
        .LPTIM2SEL = config.lptim2_src,
        .LPTIM345SEL = config.lptim345_src,
        .ADCSEL = config.adc_src,
        .SAI4ASEL = config.sai4a_src,
        .SAI4BSEL = config.sai4b_src,
        .SPI6SEL = config.spi6_src,
    });
}

inline fn calc_wait_ticks(val: usize) usize {
    const sysclk: usize = @intFromFloat(current_clk.CpuClockOutput);
    const ms_per_tick = sysclk / 1000;
    return ms_per_tick * val;
}

//TODO: OTF, MDMA, USB_OTG_PHY, ETH_RC/TX
pub fn set_clock(comptime peri: Peripherals, state: u1) void {
    const peri_name = @tagName(peri);
    //microzig.chip.peripherals

    const field = comptime if (util.match_name(peri_name, &.{
        "OCTOSPIM",
    })) "IOMNGREN" else if (util.match_name(peri_name, &.{
        "ADC1",
        "ADC2",
    })) "ADC12EN" else if (util.match_name(peri_name, &.{
        "PSSI",
    })) "DCMIEN" else if (util.match_name(peri_name, &.{
        "DAC1",
        "DAC2",
    })) "DAC12EN" else peri_name ++ "EN";

    const rcc_register_name = comptime if (util.match_name(peri_name, &.{
        "OCTOSPIM",
        "OCTOSPI",
        "SDMMC1",
        "FMC",
        "DMA2D",
    })) "AHB3ENR" else if (util.match_name(peri_name, &.{
        "DMA",
        "ADC",
        "ETH",
        "USB_OTG_HS",
    })) "AHB1ENR" else if (util.match_name(peri_name, &.{
        "PSSI",
        "DCMI",
        "RNG",
        "SDMMC2",
        "FMAC",
        "CORDIC",
    })) "AHB2ENR" else if (util.match_name(peri_name, &.{
        "GPIOA",
        "GPIOB",
        "GPIOC",
        "GPIOD",
        "GPIOE",
        "GPIOF",
        "GPIOG",
        "GPIOH",
        "GPIOI",
        "GPIOJ",
        "GPIOK",
        "CRC",
        "BDMA",
        "ADC3",
    })) "AHB4ENR" else if (util.match_name(peri_name, &.{
        "LTDC",
        "WWDG1",
    })) "APB3ENR" else if (util.match_name(peri_name, &.{
        "TIM2",
        "TIM3",
        "TIM4",
        "TIM5",
        "TIM6",
        "TIM7",
        "TIM12",
        "TIM13",
        "TIM14",
        "LPTIM1",
        "WWDG2",
        "SPI2",
        "SPI3",
        "SPDIFRX",
        "USART2",
        "USART3",
        "UART4",
        "UART5",
        "I2C1",
        "I2C2",
        "I2C3",
        "I2C5",
        "CEC",
        "DAC",
        "UART7",
        "UART8",
    })) "APB1LENR" else if (util.match_name(peri_name, &.{
        "CRS",
        "SWPMI",
        "OPAMP",
        "MDIOS",
        "FDCAN",
        "TIM23",
        "TIM24",
    })) "APB1HENR" else if (util.match_name(peri_name, &.{
        "TIM1",
        "TIM8",
        "USART1",
        "USART6",
        "UART9",
        "USART10",
        "SPI1",
        "SPI4",
        "TIM15",
        "TIM16",
        "TIM17",
        "SPI5",
        "SAI1",
        "SAI2",
        "SAI3",
        "DFSDM1",
        "HRTIM",
    })) "APB2ENR" else if (util.match_name(peri_name, &.{
        "SYSCFG",
        "LPUART1",
        "SPI6",
        "I2C4",
        "LPTIM2",
        "LPTIM3",
        "LPTIM4",
        "LPTIM5",
        "DAC2",
        "COMP12",
        "VREF",
        "RTCAPB",
        "SAI4",
        "DTS",
    })) "APB4ENR";

    @field(RCC, rcc_register_name).modify_one(field, state);
}

pub fn enable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 1);
}

pub fn disable_clock(comptime peri: Peripherals) void {
    set_clock(peri, 0);
}
