const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const EXTEND = microzig.chip.peripherals.EXTEND;

const gpioBlock = enum {
    A,
    B,
    C,
    D,
};

pub fn enable_gpio_clock(block: gpioBlock) void {
    // TODO: How do we know if we need to set the AFIOEN?
    switch (block) {
        .A => RCC.APB2PCENR.modify(.{
            .IOPAEN = 1,
            .AFIOEN = 1,
        }),
        .B => RCC.APB2PCENR.modify(.{
            .IOPBEN = 1,
            .AFIOEN = 1,
        }),
        .C => RCC.APB2PCENR.modify(.{
            .IOPCEN = 1,
            .AFIOEN = 1,
        }),
        .D => RCC.APB2PCENR.modify(.{
            .IOPDEN = 1,
            .AFIOEN = 1,
        }),
    }
}

const peripheral = enum {
    // AHB peripherals
    DMA1,
    DMA2,

    // APB2 peripherals
    USART1,
    SPI1,
    ADC1,
    ADC2,
    TIM1,

    // APB1 peripherals
    USART2,
    USART3,
    I2C1,
    I2C2,
    SPI2,
    TIM2,
    TIM3,
    TIM4,
};

pub fn enable_peripheral_clock(p: peripheral) void {
    switch (p) {
        // AHB peripherals
        .DMA1 => RCC.AHBPCENR.modify(.{ .DMA1EN = 1 }),
        .DMA2 => RCC.AHBPCENR.modify(.{ .DMA2EN = 1 }),

        // APB2 peripherals (high-speed bus)
        .USART1 => RCC.APB2PCENR.modify(.{ .USART1EN = 1 }),
        .SPI1 => RCC.APB2PCENR.modify(.{ .SPI1EN = 1 }),
        .ADC1 => RCC.APB2PCENR.modify(.{ .ADC1EN = 1 }),
        .ADC2 => RCC.APB2PCENR.modify(.{ .ADC2EN = 1 }),
        .TIM1 => RCC.APB2PCENR.modify(.{ .TIM1EN = 1 }),

        // APB1 peripherals (low-speed bus)
        .USART2 => RCC.APB1PCENR.modify(.{ .USART2EN = 1 }),
        .USART3 => RCC.APB1PCENR.modify(.{ .USART3EN = 1 }),
        .I2C1 => RCC.APB1PCENR.modify(.{ .I2C1EN = 1 }),
        .I2C2 => RCC.APB1PCENR.modify(.{ .I2C2EN = 1 }),
        .SPI2 => RCC.APB1PCENR.modify(.{ .SPI2EN = 1 }),
        .TIM2 => RCC.APB1PCENR.modify(.{ .TIM2EN = 1 }),
        .TIM3 => RCC.APB1PCENR.modify(.{ .TIM3EN = 1 }),
        .TIM4 => RCC.APB1PCENR.modify(.{ .TIM4EN = 1 }),
    }
}

/// Enable AFIO (Alternate Function I/O) clock
/// Required for pin remapping and external interrupt configuration
pub fn enable_afio_clock() void {
    RCC.APB2PCENR.modify(.{ .AFIOEN = 1 });
}

const PLL2MUL = enum(u4) {
    PLL2_MUL_2_5 = 0,
    PLL2_MUL_12_5 = 0b0001,
    PLL2_MUL_4 = 0b0010,
    PLL2_MUL_5 = 0b0011,
    PLL2_MUL_6 = 0b0100,
    PLL2_MUL_7 = 0b0101,
    PLL2_MUL_8 = 0b0110,
    PLL2_MUL_9 = 0b0111,
    PLL2_MUL_10 = 0b1000,
    PLL2_MUL_11 = 0b1001,
    PLL2_MUL_12 = 0b1010,
    PLL2_MUL_13 = 0b1011,
    PLL2_MUL_14 = 0b1100,
    PLL2_MUL_15 = 0b1101,
    PLL2_MUL_16 = 0b1110,
    PLL2_MUL_20 = 0b1111,
};

fn prediv(div: u4) u4 {
    return div - 1;
}

const PREDIV = enum(u4) {
    DIV1 = 0b0000,
    DIV2 = 0b0001,
    DIV3 = 0b0010,
    DIV4 = 0b0011,
    DIV5 = 0b0100,
    DIV6 = 0b0101,
    DIV7 = 0b0110,
    DIV8 = 0b0111,
    DIV9 = 0b1000,
    DIV10 = 0b1001,
    DIV11 = 0b1010,
    DIV12 = 0b1011,
    DIV13 = 0b1100,
    DIV14 = 0b1101,
    DIV15 = 0b1110,
    DIV16 = 0b1111,
};

const PLL = enum {
    PLL1, //
    PLL2,
    PLL3,
};

/// Start a PLL and wait for it to stabilize
///
pub fn start_pll(pll: PLL) void {
    switch (pll) {
        .PLL1 => {
            RCC.CTLR.modify(.{ .PLLON = 1 });
            while (RCC.CTLR.read().PLLRDY == 0) {}
        },
        .PLL2 => {
            RCC.CTLR.modify(.{ .PLL2ON = 1 });
            while (RCC.CTLR.read().PLL2RDY == 0) {}
        },
        .PLL3 => {
            RCC.CTLR.modify(.{ .PLL3ON = 1 });
            while (RCC.CTLR.read().PLL3RDY == 0) {}
        },
    }
}

// ============================================================================
// Clock Configuration System
// ============================================================================

pub const ClockSource = enum {
    /// High Speed Internal oscillator (8 MHz RC oscillator)
    hsi,
    /// High Speed External oscillator (crystal/oscillator)
    hse,
};

/// Clock configuration for a board
pub const Config = struct {
    /// Clock source to use (HSI or HSE)
    source: ClockSource,
    /// Target CPU frequency in Hz
    target_frequency: u32,
    /// HSE crystal/oscillator frequency (required if source == .hse)
    hse_frequency: ?u32 = null,
};

/// Validate clock configuration at compile time
fn validate_config(comptime config: Config) void {
    if (config.source == .hse and config.hse_frequency == null) {
        @compileError("hse_frequency must be specified when using HSE clock source");
    }

    // Validate supported target frequencies for HSI
    if (config.source == .hsi) {
        const supported_hsi_freqs = [_]u32{ 8_000_000, 24_000_000, 48_000_000 };
        var supported = false;
        for (supported_hsi_freqs) |freq| {
            if (config.target_frequency == freq) {
                supported = true;
                break;
            }
        }
        if (!supported) {
            @compileError("Unsupported target_frequency for HSI. Supported: 8 MHz (direct), 24 MHz, 48 MHz");
        }
    }

    // Validate supported target frequencies for HSE
    if (config.source == .hse) {
        const hse_freq = config.hse_frequency.?;
        if (config.target_frequency != hse_freq and
            config.target_frequency != 48_000_000 and
            config.target_frequency != 144_000_000)
        {
            @compileError("Unsupported target_frequency for HSE. Supported: HSE frequency directly, or 48 MHz with PLL");
        }
    }
}

/// Initialize system clocks based on configuration
/// Config is validated at compile time
pub fn init(comptime config: Config) void {
    comptime validate_config(config);

    switch (config.source) {
        .hsi => init_from_hsi(config.target_frequency),
        .hse => init_from_hse(config.hse_frequency.?, config.target_frequency),
    }
}

/// Initialize clocks from HSI to reach target frequency
/// Assumes target_freq has been validated at compile time
fn init_from_hsi(target_freq: u32) void {
    // Calculate PLL configuration
    // The HSIPRE bit controls whether HSI is divided before PLL
    // PLLMUL bits control the PLL multiplier factor

    // TODO: Make this more flexible.
    if (target_freq == 8_000_000) {
        // Use HSI directly at 8 MHz without PLL
        // HSI is already enabled by default after reset
        // Just ensure we're using HSI as system clock (should already be the case)
        RCC.CFGR0.modify(.{ .SW = 0 }); // SW = 0 means HSI
        while (RCC.CFGR0.read().SWS != 0) {}

        // Configure bus prescalers (no division)
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1
            .PPRE2 = 0, // APB2 prescaler = 1
            .PPRE1 = 0, // APB1 prescaler = 1
        });
    } else if (target_freq == 48_000_000) {
        // 48 MHz from 8 MHz HSI: HSI -> PLL (6x multiplier) -> 48 MHz
        // HSIPRE = 1 means HSI not divided before PLL
        EXTEND.EXTEND_CTR.modify(.{ .HSIPRE = 1 });

        // Configure clock prescalers
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1 (no division)
            .PPRE2 = 0, // APB2 prescaler = 1 (no division)
            // TODO: Why is this 4, not 2? Check
            .PPRE1 = 4, // APB1 prescaler = 2 (divide by 2)
            .PLLSRC = 0, // PLL source = HSI
            .PLLXTPRE = 0, // HSE divider for PLL = no division (unused for HSI)
            .PLLMUL = 4, // PLL multiplier = 6 (value 4 = 6x)
        });

        // Enable PLL
        RCC.CTLR.modify(.{ .PLLON = 1 });

        // Wait for PLL to lock
        while (RCC.CTLR.read().PLLRDY == 0) {}

        // Select PLL as system clock
        RCC.CFGR0.modify(.{ .SW = 2 }); // SW = 2 means PLL

        // Wait for PLL to be used as system clock (SWS should be 2)
        while (RCC.CFGR0.read().SWS != 2) {}
    } else if (target_freq == 24_000_000) {
        // 24 MHz from 8 MHz HSI: HSI/2 -> PLL (6x multiplier) -> 24 MHz
        // HSIPRE = 0 means HSI divided by 2 before PLL
        EXTEND.EXTEND_CTR.modify(.{ .HSIPRE = 0 });

        // Configure clock prescalers
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1 (no division)
            .PPRE2 = 0, // APB2 prescaler = 1 (no division)
            .PPRE1 = 0, // APB1 prescaler = 1 (no division)
            .PLLSRC = 0, // PLL source = HSI
            .PLLXTPRE = 0, // HSE divider (unused)
            .PLLMUL = 4, // PLL multiplier = 6 (value 4 = 6x)
        });

        // Enable PLL
        RCC.CTLR.modify(.{ .PLLON = 1 });

        // Wait for PLL to lock
        while (RCC.CTLR.read().PLLRDY == 0) {}

        // Select PLL as system clock
        RCC.CFGR0.modify(.{ .SW = 2 });

        // Wait for PLL to be used as system clock (SWS should be 2)
        while (RCC.CFGR0.read().SWS != 2) {}
    } else {
        unreachable; // Should be caught by compile-time validation
    }
}

/// Initialize clocks from HSE to reach target frequency
/// Assumes hse_freq and target_freq have been validated at compile time
fn init_from_hse(hse_freq: u32, comptime target_freq: u32) void {
    // Enable HSE
    RCC.CTLR.modify(.{ .HSEON = 1 });

    // Wait for HSE to be ready
    while (RCC.CTLR.read().HSERDY == 0) {}

    // If target matches HSE exactly, use HSE directly
    if (target_freq == hse_freq) {
        RCC.CFGR0.modify(.{ .SW = 1 }); // SW = 1 means HSE
        while (RCC.CFGR0.read().SWS != 1) {}
        return;
    }

    // Use PLL to reach 48 MHz from HSE
    // Common case: 8 MHz HSE -> 48 MHz (6x multiplier)
    // TODO: We don't actually ensure that HSE is 8MHz. Fix this.
    if (target_freq == 48_000_000) {
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1
            .PPRE2 = 0, // APB2 prescaler = 1
            .PPRE1 = 4, // APB1 prescaler = 2
            .PLLSRC = 1, // PLL source = HSE
            .PLLXTPRE = 0, // HSE not divided before PLL
            .PLLMUL = 4, // PLL multiplier = 6
        });

        // Enable PLL
        RCC.CTLR.modify(.{ .PLLON = 1 });
        while (RCC.CTLR.read().PLLRDY == 0) {}

        // Select PLL as system clock
        RCC.CFGR0.modify(.{ .SW = 2 });
        while (RCC.CFGR0.read().SWS != 2) {}
    } else if (target_freq == 144_000_000) {
        // TODO: Handle the chip specific clock config for PLLMUL, this is for the v307
        RCC.CFGR0.modify(.{
            .HPRE = 0, // AHB prescaler = 1
            .PPRE2 = 0, // APB2 prescaler = 1
            .PPRE1 = 0b101, // APB1 prescaler = 2
            .PLLSRC = 1, // PLL source = HSE
            .PLLXTPRE = 0, // HSE not divided before PLL
            .PLLMUL = 0, // PLL multiplier = 18
        });

        // // // coefficients, not reg vals
        // const prediv2: u32 = 2;
        // const pll2mul: u32 = 9;
        // const prediv1: u32 = 1;
        // const pllmul: u32 = 8;

        // const sysclk = ((8_000_000 / prediv2) * pll2mul / prediv1) * pllmul;

        // if (sysclk != target_freq) {
        //     // const std = @import("std");
        //     // @compileError(std.fmt.comptimePrint("Warning: Target frequency {} Hz does not match calculated system clock of {} Hz\n", .{ target_freq, sysclk }));
        //     // _ = sysclk;
        // }

        // RCC.CFGR0.modify(.{
        //     .HPRE = 1, // AHB prescaler = 1
        //     .PPRE2 = 0, // APB2 prescaler = 1
        //     .PPRE1 = 0b101, // APB1 prescaler = 2
        //     .PLLSRC = 1, // PLL source = HSE
        //     .PLLMUL = 0b0000,
        // });

        // RCC.CFGR2.modify(.{
        //     .PLL2MUL = @intFromEnum(@as(PLL2MUL, .PLL2_MUL_9)), // PLL2MUL = 9
        //     .PREDIV2 = prediv(prediv2), // PREDIV2 = 4
        //     .PREDIV1 = @intFromEnum(@as(PREDIV, .DIV1)), // HSE not divided before PLL
        // });
        // RCC.CTLR.modify(.{ .PLL2ON = 1 });
        // while (RCC.CTLR.read().PLL2RDY == 0) {}

        // RCC.CFGR2.modify(.{ .PREDIV1SRC = 1 });

        // Enable PLL
        RCC.CTLR.modify(.{ .PLLON = 1 });
        while (RCC.CTLR.read().PLLRDY == 0) {}

        // Select PLL as system clock
        RCC.CFGR0.modify(.{ .SW = 2 });
        while (RCC.CFGR0.read().SWS != 2) {}
    } else {
        unreachable; // Should be caught by compile-time validation
    }
}

// ============================================================================
// Clock Speed Query Functions
// ============================================================================

pub const ClockSpeeds = struct {
    sysclk: u32,
    hclk: u32,
    pclk1: u32,
    pclk2: u32,
    adcclk: u32,
};

// Prescaler lookup table for AHB/APB buses
// Index into this table with the HPRE/PPRE bits, result is the shift amount
const prescaler_table = [16]u8{ 0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9 };

// ADC prescaler lookup table (divisor values)
const adc_prescaler_table = [4]u8{ 2, 4, 6, 8 };

/// Get HSI oscillator frequency from chip HAL
fn get_hsi_value() u32 {
    return microzig.hal.hsi_frequency;
}

/// Get HSE oscillator frequency from board configuration
fn get_hse_value() u32 {
    // Try to get from board's clock config
    if (microzig.config.has_board and @hasDecl(microzig.board, "clock_config")) {
        if (microzig.board.clock_config.hse_frequency) |freq| {
            return freq;
        }
    }
    // Default fallback (though this shouldn't be used if board uses HSE)
    return 8_000_000;
}

/// Get the current clock frequencies by reading RCC registers
/// Based on WCH's RCC_GetClocksFreq() implementation
pub fn get_freqs() ClockSpeeds {
    var sysclk: u32 = 0;

    // Get actual oscillator frequencies from chip/board config
    const HSI_VALUE = get_hsi_value();
    const HSE_VALUE = get_hse_value();

    // Determine system clock source from SWS (System Clock Switch Status)
    const sws = RCC.CFGR0.read().SWS;

    switch (sws) {
        0 => {
            // HSI used as system clock
            sysclk = HSI_VALUE;
        },
        1 => {
            // HSE used as system clock
            sysclk = HSE_VALUE;
        },
        2 => {
            // PLL used as system clock
            const cfgr0 = RCC.CFGR0.read();
            const pllmul_bits = cfgr0.PLLMUL;
            const pllsrc = cfgr0.PLLSRC;

            // PLL multiplication factor: PLLMUL bits + 2
            // Special case: if result is 17, it's actually 18
            var pllmul: u32 = @as(u32, pllmul_bits) + 2;
            // TODO: Handle chip specific clock config
            // if (pllmul == 17) pllmul = 18;
            if (@as(u32, pllmul_bits) == 0) pllmul = 18;

            if (pllsrc == 0) {
                // PLL source is HSI
                const hsipre = EXTEND.EXTEND_CTR.read().HSIPRE;
                if (hsipre == 1) {
                    // HSI not divided
                    sysclk = HSI_VALUE * pllmul;
                } else {
                    // HSI divided by 2
                    sysclk = (HSI_VALUE >> 1) * pllmul;
                }
            } else {
                // PLL source is HSE
                const pllxtpre = cfgr0.PLLXTPRE;
                if (pllxtpre == 1) {
                    // HSE divided by 2 before PLL
                    sysclk = (HSE_VALUE >> 1) * pllmul;
                } else {
                    // HSE not divided
                    sysclk = HSE_VALUE * pllmul;
                }
            }
        },
        else => {
            // Default to HSI
            sysclk = HSI_VALUE;
        },
    }

    // Calculate AHB clock (HCLK) from SYSCLK using HPRE prescaler
    const hpre = RCC.CFGR0.read().HPRE;
    const hpre_shift = prescaler_table[hpre];
    const hclk = sysclk >> @as(u5, @intCast(hpre_shift));

    // Calculate APB1 clock (PCLK1) from HCLK using PPRE1 prescaler
    const ppre1 = RCC.CFGR0.read().PPRE1;
    const ppre1_shift = prescaler_table[ppre1];
    const pclk1 = hclk >> @as(u5, @intCast(ppre1_shift));

    // Calculate APB2 clock (PCLK2) from HCLK using PPRE2 prescaler
    const ppre2 = RCC.CFGR0.read().PPRE2;
    const ppre2_shift = prescaler_table[ppre2];
    const pclk2 = hclk >> @as(u5, @intCast(ppre2_shift));

    // Calculate ADC clock from PCLK2 using ADCPRE
    const adcpre = RCC.CFGR0.read().ADCPRE;
    const adc_divisor: u32 = adc_prescaler_table[adcpre];
    const adcclk = pclk2 / adc_divisor;

    return .{
        .sysclk = sysclk,
        .hclk = hclk,
        .pclk1 = pclk1,
        .pclk2 = pclk2,
        .adcclk = adcclk,
    };
}

/// USBHS/USBHD clock helper.
/// This configures RCC_CFGR2 fields for the USBHS PHY PLL reference (if present),
/// selects whether the USBHS 48MHz clock comes from the system PLL clock or the USB PHY,
/// and enables the AHB clock gate for USBHS.
///
/// Note: The SVD names bit31 as `USBFSSRC`, but the reference manual
/// describes it as `USBHSSRC` ("USBHS 48MHz clock source selection").
/// We write the SVD field, but treat it as USBHS 48MHz source select.
pub const UsbHsClockConfig = struct {
    pub const RefSource = enum { hse, hsi };
    /// Desired PHY PLL reference frequency (the USBHSCLK field selects one of these).
    /// If null, we'll pick the highest one we can generate exactly: 8MHz, then 5MHz, 4MHz, 3MHz.
    pub const RefFreq = enum(u2) {
        mhz3 = 0b00,
        mhz4 = 0b01,
        mhz8 = 0b10,
        mhz5 = 0b11,
    };
    /// Some parts have the USBHS controller but *no* built-in HS PHY.
    /// If false, we will not enable the PHY internal PLL and will select 48MHz from PLL CLK.
    has_hs_phy: bool = true,

    /// If true (and has_hs_phy), select USB PHY as the 48MHz source and enable the PHY internal PLL.
    /// If false, select PLL CLK as the 48MHz source (you must ensure a valid 48MHz PLL clock exists).
    use_phy_48mhz: bool = true,

    /// PHY PLL reference source (only used when has_hs_phy && use_phy_48mhz).
    ref_source: RefSource = .hse,

    /// Frequency of the chosen ref_source, in Hz.
    /// Typical: HSE crystal (e.g. 8_000_000, 12_000_000, 24_000_000) or HSI (often 8_000_000).
    ref_source_hz: u32,

    ref_freq: ?RefFreq = null,
};

fn div_to_usbhsdiv(div: u32) u3 {
    // RCC_CFGR2 USBHSDIV encoding:
    // 000: /1, 001: /2, ... 111: /8
    return @as(u3, @intCast(div - 1));
}

fn hz_for_ref(ref: UsbHsClockConfig.RefFreq) u32 {
    return switch (ref) {
        .mhz3 => 3_000_000,
        .mhz4 => 4_000_000,
        .mhz5 => 5_000_000,
        .mhz8 => 8_000_000,
    };
}

const HSPLLSRC = enum(u2) {
    hse = 0,
    hsi = 1,
};

/// Enable + configure USBHS clocks.
///
/// Selects USBHS Clock source, options are:
/// - "PLL CLK" 48MHz source (cfg.use_phy_48mhz = false), or
/// - "USB PHY" 48MHz source (cfg.use_phy_48mhz = true and cfg.has_hs_phy = true),
///   in which case it also configures the PHY PLL reference (USBHSCLK/USBHSPLLSRC/USBHSDIV)
///   and enables the PHY internal PLL (USBHSPLL).
pub fn enable_usbhs_clock(comptime cfg: UsbHsClockConfig) void {
    // Turn on the AHB clock gate for the USBHS peripheral block.

    // If there's no PHY (or caller prefers PLL CLK), force PLL CLK selection and keep PHY PLL off.
    if (!cfg.has_hs_phy or !cfg.use_phy_48mhz) {
        RCC.CFGR2.modify(.{
            // SVD name mismatch: USBFSSRC field == USBHS 48MHz source select per RM.
            .USBFSSRC = 0, // 0: PLL CLK (per RM: "USBHS 48MHz clock source selection")
            .USBHSPLL = 0, // PHY internal PLL disabled
        });
        return;
    }

    // Ensure the selected oscillator is on (best-effort; usually already enabled by your system clock init).
    switch (cfg.ref_source) {
        .hse => {
            if (RCC.CTLR.read().HSEON == 0) RCC.CTLR.modify(.{ .HSEON = 1 });
            while (RCC.CTLR.read().HSERDY == 0) {}
        },
        .hsi => {
            if (RCC.CTLR.read().HSION == 0) RCC.CTLR.modify(.{ .HSION = 1 });
            while (RCC.CTLR.read().HSIRDY == 0) {}
        },
    }

    // Choose a reference frequency and divider that is exactly achievable.
    const candidates = [_]UsbHsClockConfig.RefFreq{ .mhz8, .mhz5, .mhz4, .mhz3 };

    comptime var chosen_ref: UsbHsClockConfig.RefFreq = undefined;
    comptime var chosen_div: u32 = 0;
    comptime {
        if (cfg.ref_freq) |forced| {
            const want = hz_for_ref(forced);
            var found = false;
            for (1..9) |div| {
                if (cfg.ref_source_hz % div == 0 and (cfg.ref_source_hz / div) == want) {
                    chosen_ref = forced;
                    chosen_div = div;
                    found = true;
                    break;
                }
            }
            if (!found) {
                @compileError("USBHS PHY PLL ref cannot be generated exactly from ref_source_hz with /1..8 prescaler.");
            }
        } else {
            var found = false;
            for (candidates) |ref| {
                const want = hz_for_ref(ref);
                for (1..9) |div| {
                    if (cfg.ref_source_hz % div == 0 and (cfg.ref_source_hz / div) == want) {
                        chosen_ref = ref;
                        chosen_div = div;
                        found = true;
                        break;
                    }
                }
                if (found) break;
            }
            if (!found) {
                @compileError("USBHS PHY PLL ref cannot be generated: need 3/4/5/8MHz from ref_source_hz using /1..8 prescaler.");
            }
        }
    }

    // RCC_USBCLK48MConfig( RCC_USBCLK48MCLKSource_USBPHY ); // bit 31 = 1
    // RCC_USBHSPLLCLKConfig( RCC_HSBHSPLLCLKSource_HSE );   // bit 27 = 0
    // RCC_USBHSConfig( RCC_USBPLL_Div2 );                   // bit 24 = 1
    // RCC_USBHSPLLCKREFCLKConfig( RCC_USBHSPLLCKREFCLK_4M );// bit 28 = 1
    // RCC_USBHSPHYPLLALIVEcmd( ENABLE );                    // bit 30 = 1
    // RCC_AHBPeriphClockCmd( RCC_AHBPeriph_USBHS, ENABLE );

    // Program CFGR2:
    // - USBHSPLLSRC: 0=HSE, 1=HSI
    // - USBHSDIV: prescaler (/1..8)
    // - USBHSCLK: selects which ref freq the PHY PLL expects (3/4/8/5 MHz)
    // - USBHSPLL: enable PHY internal PLL
    // - USBHSSRC (SVD calls it USBFSSRC): 1=USB PHY as 48MHz source
    RCC.CFGR2.modify(.{
        .USBHSPLLSRC = switch (cfg.ref_source) {
            .hse => 0,
            .hsi => 1,
        },
        .USBHSDIV = div_to_usbhsdiv(chosen_div),
        .USBHSCLK = @as(u2, @intFromEnum(chosen_ref)),
        .USBHSPLL = 1,
        .USBFSSRC = 1, // RM: USBHS 48MHz clock source = USB PHY
    });

    RCC.AHBPCENR.modify(.{ .USBHS_EN = 1 });
}

// ============================================================================
// Convenience Functions for HAL Modules
// ============================================================================

/// Get the system clock frequency (SYSCLK/HCLK).
///
/// **This is the recommended way for HAL modules to get the CPU frequency.**
///
/// Uses the board's configured frequency if available (compile-time constant, zero cost),
/// otherwise queries the hardware (runtime cost).
pub fn get_sysclk() u32 {
    // Prefer the compile-time constant from board config for efficiency
    if (microzig.config.has_board and @hasDecl(microzig.board, "cpu_frequency")) {
        return microzig.board.cpu_frequency;
    }
    // Fall back to querying the hardware
    return get_freqs().sysclk;
}

/// Get the APB1 peripheral clock frequency (PCLK1).
pub fn get_pclk1() u32 {
    return get_freqs().pclk1;
}

/// Get the APB2 peripheral clock frequency (PCLK2).
pub fn get_pclk2() u32 {
    return get_freqs().pclk2;
}

/// Get the AHB clock frequency (HCLK).
/// This is typically the same as SYSCLK unless the AHB prescaler is configured.
pub fn get_hclk() u32 {
    return get_freqs().hclk;
}
