const microzig = @import("microzig");

/// Initialize system clock to 48 MHz using HSI
pub fn init_48mhz_hsi() void {
    const RCC = microzig.chip.peripherals.RCC;
    const EXTEND = microzig.chip.peripherals.EXTEND;
    // Enable PLL HSI prescaler (HSIPRE bit)
    EXTEND.EXTEND_CTR.modify(.{ .HSIPRE = 1 });

    // Configure clock prescalers
    RCC.CFGR0.modify(.{
        .HPRE = 0, // AHB prescaler = 1 (no division)
        .PPRE2 = 0, // APB2 prescaler = 1 (no division)
        .PPRE1 = 4, // APB1 prescaler = 2 (divide by 2)
        .PLLSRC = 0, // PLL source = HSI/2
        .PLLXTPRE = 0, // HSE divider for PLL = no division
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
}

const ClockSpeeds = struct {
    sysclk: u32,
    hclk: u32,
    pclk1: u32,
    pclk2: u32,
    adcclk: u32,
};

// Clock constants
const HSI_VALUE: u32 = 8_000_000; // 8 MHz internal oscillator
const HSE_VALUE: u32 = 8_000_000; // 8 MHz external oscillator (board-dependent)

// Prescaler lookup table for AHB/APB buses
// Index into this table with the HPRE/PPRE bits, result is the shift amount
const prescaler_table = [16]u8{ 0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9 };

// ADC prescaler lookup table (divisor values)
const adc_prescaler_table = [4]u8{ 2, 4, 6, 8 };

/// Get the current clock frequencies by reading RCC registers
/// Based on WCH's RCC_GetClocksFreq() implementation
pub fn get_freqs() ClockSpeeds {
    const RCC = microzig.chip.peripherals.RCC;
    const EXTEND = microzig.chip.peripherals.EXTEND;

    var sysclk: u32 = 0;

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
