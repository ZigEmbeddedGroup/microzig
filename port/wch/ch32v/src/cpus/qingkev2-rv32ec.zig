pub const cpu_frequency = 24_000_000; // 24 MHz

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
};

// https://github.com/openwch/ch32v003/blob/27f871a42060b06c381df2d199fd4ac28adaacd7/EVT/EXAM/RCC/MCO/User/system_ch32v00x.c#L73
pub inline fn system_init(comptime chip: anytype) void {
    const FLASH = chip.peripherals.FLASH;
    const RCC = chip.peripherals.RCC;

    FLASH.ACTLR.modify(.{ .LATENCY = 0 });

    // RCC->CTLR |= (uint32_t)0x00000001;
    RCC.CTLR.modify(.{ .HSION = 1 });
    // RCC->CFGR0 &= (uint32_t)0xF8FF0000;
    RCC.CFGR0.modify(.{
        .SW = 0,
        .SWS = 0,
        .HPRE = 0,
        .ADCPRE = 0,
        .MCO = 0,
    });
    // RCC->CTLR &= (uint32_t)0xFEF6FFFF;
    RCC.CTLR.modify(.{ .HSEON = 0, .CSSON = 0, .PLLON = 0 });
    // RCC->CTLR &= (uint32_t)0xFFFBFFFF;
    RCC.CTLR.modify(.{ .HSEBYP = 0 });
    // RCC->CFGR0 &= (uint32_t)0xFFFEFFFF;
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

    // Adjusts the Internal High Speed oscillator (HSI) calibration value.
    RCC.CTLR.modify(.{ .HSITRIM = 0x10 });
}

pub const csr_types = struct {
    pub const intsyscr = packed struct(u32) {
        /// [0] HPE enable
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [2] EABI enable
        eabien: u1,
        /// [31:3] Reserved
        reserved0: u29 = 0,
    };
};
