pub const cpu_frequency = 8_000_000; // 8 MHz

pub const Interrupt = enum(u8) {
    /// Reset
    // Reset = 1,
    /// Non-maskable interrupt
    NMI = 2,
    /// Exception interrupt
    EXC = 3,
    /// System timer interrupt
    SysTick = 12,
    /// Software interrupt
    SW = 14,
    /// Window Watchdog interrupt
    WWDG = 16,
    /// PVD through EXTI line detection interrupt
    PVD = 17,
    /// Tamper interrupt
    TAMPER = 18,
    /// RTC global interrupt
    RTC = 19,
    /// Flash global interrupt
    FLASH = 20,
    /// RCC global interrupt
    RCC = 21,
    /// EXTI Line0 interrupt
    EXTI0 = 22,
    /// EXTI Line1 interrupt
    EXTI1 = 23,
    /// EXTI Line2 interrupt
    EXTI2 = 24,
    /// EXTI Line3 interrupt
    EXTI3 = 25,
    /// EXTI Line4 interrupt
    EXTI4 = 26,
    /// DMA1 Channel1 global interrupt
    DMA1_CH1 = 27,
    /// DMA1 Channel2 global interrupt
    DMA1_CH2 = 28,
    /// DMA1 Channel3 global interrupt
    DMA1_CH3 = 29,
    /// DMA1 Channel4 global interrupt
    DMA1_CH4 = 30,
    /// DMA1 Channel5 global interrupt
    DMA1_CH5 = 31,
    /// DMA1 Channel6 global interrupt
    DMA1_CH6 = 32,
    /// DMA1 Channel7 global interrupt
    DMA1_CH7 = 33,
    /// ADC1 global interrupt
    ADC = 34,
    /// EXTI Line[9:5] interrupts
    EXTI9_5 = 39,
    /// TIM1 Break interrupt and TIM9 global interrupt
    TIM1_BRK = 40,
    /// TIM1 Update interrupt and TIM10 global interrupt
    TIM1_UP = 41,
    /// TIM1 Trigger and Commutation interrupts and TIM11 global interrupt
    TIM1_TRG_COM = 42,
    /// TIM1 Capture Compare interrupt
    TIM1_CC = 43,
    /// TIM2 global interrupt
    TIM2 = 44,
    /// TIM3 global interrupt
    TIM3 = 45,
    /// TIM4 global interrupt
    TIM4 = 46,
    /// I2C1 event interrupt
    I2C1_EV = 47,
    /// I2C1 error interrupt
    I2C1_ER = 48,
    /// I2C2 event interrupt
    I2C2_EV = 49,
    /// I2C2 error interrupt
    I2C2_ER = 50,
    /// SPI1 global interrupt
    SPI1 = 51,
    /// SPI2 global interrupt
    SPI2 = 52,
    /// USART1 global interrupt
    USART1 = 53,
    /// USART2 global interrupt
    USART2 = 54,
    /// USART3 global interrupt
    USART3 = 55,
    /// EXTI Line[15:10] interrupts
    EXTI15_10 = 56,
    /// RTC Alarms through EXTI line interrupt
    RTCAlarm = 57,
    /// USB Device FS Wakeup through EXTI line interrupt
    USB_FS_WKUP = 58,
    /// USBFS_IRQHandler
    USBFS = 59,
};

// https://github.com/openwch/ch32v103/blob/f99a84c4c42b6fb676560a9b8b7c737401efe0ad/EVT/EXAM/RCC/MCO/User/system_ch32v10x.c#L78
pub inline fn system_init(comptime chip: anytype) void {
    const RCC = chip.peripherals.RCC;

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
    // RCC->CFGR0 &= (uint32_t)0xFF80FFFF;
    RCC.CFGR0.modify(.{ .PLLSRC = 0, .PLLXTPRE = 0, .PLLMUL = 0, .USBPRE = 0 });
    // RCC->INTR = 0x009F0000;
    RCC.INTR.write(.{
        // Read-only ready flags.
        .LSIRDYF = 0,
        .LSERDYF = 0,
        .HSIRDYF = 0,
        .HSERDYF = 0,
        .PLLRDYF = 0,
        .CSSF = 0,
        // Disable ready interrupts.
        .LSIRDYIE = 0,
        .LSERDYIE = 0,
        .HSIRDYIE = 0,
        .HSERDYIE = 0,
        .PLLRDYIE = 0,
        // Clear ready flags.
        .LSIRDYC = 1,
        .LSERDYC = 1,
        .HSIRDYC = 1,
        .HSERDYC = 1,
        .PLLRDYC = 1,
        .CSSC = 1,
    });
}
