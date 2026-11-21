pub const cpu_frequency = 48_000_000; // 48 MHz

pub const Interrupt = enum(u8) {
    /// Non-maskable interrupt
    NMI = 2,
    /// Abnormal interruptions
    HardFault = 3,
    /// System timer interrupt
    SysTick = 12,
    /// Software interrupt
    SW = 14,
    /// Window Watchdog interrupt
    WWDG = 16,
    /// PVD through EXTI line detection interrupt
    PVD = 17,
    /// Flash global interrupt
    FLASH = 18,
    /// Reset and clock control interrupt
    RCC = 19,
    /// EXTI Line[7:0] interrupt
    EXTI7_0 = 20,
    /// AWU global interrupt
    AWU = 21,
    /// DMA1 Channel 1 global interrupt
    DMA1_Channel1 = 22,
    /// DMA1 Channel 2 global interrupt
    DMA1_Channel2 = 23,
    /// DMA1 Channel 3 global interrupt
    DMA1_Channel3 = 24,
    /// DMA1 Channel 4 global interrupt
    DMA1_Channel4 = 25,
    /// DMA1 Channel 5 global interrupt
    DMA1_Channel5 = 26,
    /// DMA1 Channel 6 global interrupt
    DMA1_Channel6 = 27,
    /// DMA1 Channel 7 global interrupt
    DMA1_Channel7 = 28,
    /// ADC global interrupt
    ADC = 29,
    /// I2C1 event interrupt
    I2C1_EV = 30,
    /// I2C1 error interrupt
    I2C1_ER = 31,
    /// USART1 global interrupt
    USART1 = 32,
    /// SPI1 global interrupt
    SPI1 = 33,
    /// TIM1 Break interrupt
    TIM1BRK = 34,
    /// TIM1 Update interrupt
    TIM1UP = 35,
    /// TIM1 Trigger and Commutation interrupts
    TIM1RG = 36,
    /// TIM1 Capture Compare interrupt
    TIM1CC = 37,
    /// TIM2 global interrupt
    TIM2 = 38,
    /// USART2 global interrupt (CH32V005/6/7 only)
    USART2 = 39,
    /// OPA/CMP combined interrupt
    OPCM = 40,
};

// Inspired by the WCH's SystemInit()/SetSysClock() from
// https://github.com/openwch/ch32v003/blob/main/EVT/EXAM/RCC/MCO/User/system_ch32v00x.c
pub inline fn system_init(comptime chip: anytype) void {
    const FLASH = chip.peripherals.FLASH;
    const RCC = chip.peripherals.RCC;
    const GPIOD = chip.peripherals.GPIOD;

    // Configure the SWIO (Single-Wire debug IO) pin (PD1) as a non-driven input with pull-up before
    // doing anything else to keep the debug interface usable.
    // Enable GPIOD clock.
    RCC.PB2PCENR.modify(.{ .IOPDEN = 1 });
    // In both the CH32V00X Reference Manual ("7.3.1.3 Port Output Data Register" and "7.3.1.1 Port
    // Configuration Register Low") and the SystemInit() function in system_ch32v00x.c, the pull-up
    // is set in both the input and the output mode registers before switching mode so to avoid a
    // momentary pull-down.
    // Set pull-up resistor in output mode.
    GPIOD.OUTDR.modify(.{ .ODR1 = 1 });
    // Set input mode (MODE1 = 0b00) with pull-up (CNF1 = 0b10).
    GPIOD.CFGLR.modify(.{
        .MODE1 = 0,
        .CNF1 = 0b10,
    });
    // Set the pin state. GPIOx_BSHR is write-only [CH32V00X Reference Manual - 7.3.1.4 Port
    // Reset/Set Register (GPIOx_BSHR)], so just writing it instead of reading it back.
    GPIOD.BSHR.write(.{ .BS1 = 1 });

    // CH32V00X models support 0, 1, and 2 for 0 =< SYSCLK =< 15MHz, 15 =< SYSCLK =< 24MHz and
    // 24 =< SYSCLK =< 48MHz respectively.
    // [CH32V00X Reference Manual - 18.3.1 Control Register (FLASH_ACTLR)]
    // Set conservatively to allow the core to fetch correctly whatever frequency is chosen. This
    // can be lowered later if a lower speed is configured.
    FLASH.ACTLR.modify(.{ .LATENCY = 2 });

    // RCC->CTLR |= (uint32_t)0x00000001;
    RCC.CTLR.modify(.{ .HSION = 1 });
    // RCC->CFGR0 &= (uint32_t)0x68FF0000;
    RCC.CFGR0.modify(.{
        .SW = 0,
        .SWS = 0,
        .HPRE = 0, // Set the clock prescaler off (i.e. SYSCLK/HBCLK not divided).
        .ADCPRE = 0, // Set the ADC clock to SYSCLK / 2 (Note: ADC max clock must be <= 24MHz).
        .MCO = 0, // Don't output a clock.
        // Note: to output a clock, set PC4 to `OutputMode.alternate_function_push_pull`
    });
    // RCC->CTLR &= (uint32_t)0xFED6FFFB;
    RCC.CTLR.modify(.{
        .HSI_LP = 0, // Keep the HSI oscillator in its normal mode.
        .HSEON = 0,
        .CSSON = 0,
        .HSE_LP = 1, // Put HSE in sleep mode.
        .SYSCM_EN = 0,
        .HSE_SI = 0,
    });
    // RCC->CTLR &= (uint32_t)0xFFFBFFFF;
    RCC.CTLR.modify(.{ .HSEBYP = 0 });
    // RCC->CFGR0 &= (uint32_t)0xFFFEFFFF; (i.e. HSI as PLL source)
    RCC.CFGR0.modify(.{ .PLLSRC = 0 });
    // RCC->INTR = 0x009F0000;
    RCC.INTR.write(.{
        // Read-only ready flags.
        .LSIRDYF = 0,
        .HSIRDYF = 0,
        .HSERDYF = 0,
        .PLLRDYF = 0,
        .CSSF = 0,
        // Disable ready interrupts.
        .LSIRDYIE = 0,
        .HSIRDYIE = 0,
        .HSERDYIE = 0,
        .PLLRDYIE = 0,
        // Clear ready flags.
        .LSIRDYC = 1,
        .HSIRDYC = 1,
        .HSERDYC = 1,
        .PLLRDYC = 1,
        .CSSC = 1,
    });

    // Set the system clock to 48MHz as `SetSysClockTo_48MHz_HSI()` does in `system_ch32v00X.c`.
    // https://github.com/openwch/ch32v002_004_005_006_007/blob/main/EVT/EXAM/RCC/MCO/User/system_ch32v00X.c#L225
    // PLL configuration: PLLCLK = HSI * 2 = 48 MHz.
    // Enable PLL.
    RCC.CTLR.modify(.{ .PLLON = 1 });
    // Wait till PLL is ready.
    while (RCC.CTLR.read().PLLRDY != 1) {}
    // Select PLL as system clock source.
    RCC.CFGR0.modify(.{ .SW = 0b10 });
    // Wait untill PLL can be used as system clock source.
    while (RCC.CFGR0.read().SWS != 0b10) {}
}

/// Wait for interrupt. Clears WFITOWFE so the wfi instruction behaves as a true wait-for-interrupt
/// and not as a wait-for-event.
pub inline fn wfi(comptime chip: anytype) void {
    const PFIC = chip.peripherals.PFIC;
    PFIC.SCTLR.modify(.{ .WFITOWFE = 0 });
    asm volatile ("wfi");
}

/// Wait for event. Sets SETEVENT to clear any stale event latch, enables WFITOWFE so the wfi
/// instruction acts as wfe, then executes wfi twice: the first clears the just-set event, the
/// second sleeps until a real event.
///
/// NOTE: Like with the CH32V003, the OpenWCH's CH32V00X reference implementation has a more
/// complex WFE that handles the stand-by mode (i.e. deep-sleep) alongside the normal sleep mode.
/// This simplified version only handles normal sleep mode.
/// See:
/// - https://github.com/openwch/ch32v002_004_005_006_007/blob/main/EVT/EXAM/SRC/Core/core_riscv.h#L305,L333
/// - CH32V00X Reference Manual - 2.3.2 Sleep Mode (SLEEP)
// TODO: Implement stand-by mode (i.e. deep-sleep).
pub inline fn wfe(comptime chip: anytype) void {
    const PFIC = chip.peripherals.PFIC;
    PFIC.SCTLR.modify(.{ .SETEVENT = 1, .WFITOWFE = 1 });
    asm volatile ("wfi");
    asm volatile ("wfi");
}

pub const csr_types = struct {
    pub const intsyscr = packed struct(u32) {
        /// [0] Hardware Prologue/Epilogue (HPE) enable
        /// NOTE: Probably not supported by the Zig compiler. Would require
        /// __attribute__((interrupt("WCH-Interrupt-fast"))).
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [2] EABI enable
        eabien: u1,
        /// [31:3] Reserved
        reserved0: u29 = 0,
    };
};
