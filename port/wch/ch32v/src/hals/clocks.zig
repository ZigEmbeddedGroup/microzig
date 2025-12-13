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
        const supported_hsi_freqs = [_]u32{ 24_000_000, 48_000_000 };
        var supported = false;
        for (supported_hsi_freqs) |freq| {
            if (config.target_frequency == freq) {
                supported = true;
                break;
            }
        }
        if (!supported) {
            @compileError("Unsupported target_frequency for HSI. Supported: 24 MHz, 48 MHz");
        }
    }

    // Validate supported target frequencies for HSE
    if (config.source == .hse) {
        const hse_freq = config.hse_frequency.?;
        if (config.target_frequency != hse_freq and config.target_frequency != 48_000_000) {
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
    if (target_freq == 48_000_000) {
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
fn init_from_hse(hse_freq: u32, target_freq: u32) void {
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
            if (pllmul == 17) pllmul = 18;

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
