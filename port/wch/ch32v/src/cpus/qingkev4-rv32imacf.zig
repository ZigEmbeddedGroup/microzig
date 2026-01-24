pub const cpu_frequency = 8_000_000; // 8 MHz

pub const Interrupt = enum(u8) {
    /// Non-maskable interrupt
    NMI = 2,
    /// Abnormal interruptions
    HardFault = 3,
    /// Callback interrupt in machine mode
    EcallM = 5,
    /// Callback interrupt in user mode
    EcallU = 8,
    /// Breakpoint callback interrupt
    BreakPoint = 9,
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
    DMA1_Channel1 = 27,
    /// DMA1 Channel2 global interrupt
    DMA1_Channel2 = 28,
    /// DMA1 Channel3 global interrupt
    DMA1_Channel3 = 29,
    /// DMA1 Channel4 global interrupt
    DMA1_Channel4 = 30,
    /// DMA1 Channel5 global interrupt
    DMA1_Channel5 = 31,
    /// DMA1 Channel6 global interrupt
    DMA1_Channel6 = 32,
    /// DMA1 Channel7 global interrupt
    DMA1_Channel7 = 33,
    /// ADC global interrupt
    ADC = 34,
    /// CAN1 TX interrupts
    USB_HP_CAN1_TX = 35,
    /// CAN1 RX0 interrupts
    USB_LP_CAN1_RX0 = 36,
    /// CAN1 RX1 interrupt
    CAN1_RX1 = 37,
    /// CAN1 SCE interrupt
    CAN1_SCE = 38,
    /// EXTI Line[9:5] interrupts
    EXTI9_5 = 39,
    /// TIM1 Break interrupt
    TIM1_BRK = 40,
    /// TIM1 Update interrupt
    TIM1_UP_ = 41,
    /// TIM1 Trigger and Commutation interrupts
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
    /// USB Device WakeUp from suspend through EXTI Line Interrupt
    USBWakeUp = 58,
    /// TIM8 Break interrupt
    TIM8_BRK = 59,
    /// TIM8 Update interrupt
    TIM8_UP_ = 60,
    /// TIM8 Trigger and Commutation interrupts
    TIM8_TRG_COM = 61,
    /// TIM8 Capture Compare interrupt
    TIM8_CC = 62,
    /// RNG interrupt
    RNG = 63,
    /// SDIO global interrupt
    SDIO = 65,
    /// TIM5 global interrupt
    TIM5 = 66,
    /// SPI3 global interrupt
    SPI3 = 67,
    /// UART4 global interrupt
    UART4 = 68,
    /// UART5 global interrupt
    UART5 = 69,
    /// TIM6 Basic interrupt
    TIM6 = 70,
    /// TIM8 Basic interrupt
    TIM7 = 71,
    /// DMA2 Channel1 global interrupt
    DMA2_Channel1 = 72,
    /// DMA2 Channel2 global interrupt
    DMA2_Channel2 = 73,
    /// DMA2 Channel3 global interrupt
    DMA2_Channel3 = 74,
    /// DMA2 Channel4 global interrupt
    DMA2_Channel4 = 75,
    /// DMA2 Channel5 global interrupt
    DMA2_Channel5 = 76,
    /// Ethernet global interrupt
    ETH = 77,
    /// Ethernet Wakeup through EXTI line interrupt
    ETH_WKUP = 78,
    /// CAN2 TX interrupts
    CAN2_TX = 79,
    /// CAN2 RX0 interrupts
    CAN2_RX0 = 80,
    /// CAN2 RX1 interrupt
    CAN2_RX1 = 81,
    /// CAN2 SCE interrupt
    CAN2_SCE = 82,
    /// OTG_FS
    OTG_FS = 83,
    /// USBHSWakeup
    USBHSWakeup = 84,
    /// USBHS
    USBHS = 85,
    /// DVP global Interrupt interrupt
    DVP = 86,
    /// UART6 global interrupt
    UART6 = 87,
    /// UART7 global interrupt
    UART7 = 88,
    /// UART8 global interrupt
    UART8 = 89,
    /// TIM9 Break interrupt
    TIM9_BRK = 90,
    /// TIM9 Update interrupt
    TIM9_UP_ = 91,
    /// TIM9 Trigger and Commutation interrupts
    TIM9_TRG_COM = 92,
    /// TIM9 Capture Compare interrupt
    TIM9_CC = 93,
    /// TIM10 Break interrupt
    TIM10_BRK = 94,
    /// TIM10 Update interrupt
    TIM10_UP_ = 95,
    /// TIM10 Trigger and Commutation interrupts
    TIM10_TRG_COM = 96,
    /// TIM10 Capture Compare interrupt
    TIM10_CC = 97,
    /// DMA2 Channel6 global interrupt
    DMA2_Channel6 = 98,
    /// DMA2 Channel7 global interrupt
    DMA2_Channel7 = 99,
    /// DMA2 Channel8 global interrupt
    DMA2_Channel8 = 100,
    /// DMA2 Channel9 global interrupt
    DMA2_Channel9 = 101,
    /// DMA2 Channel10 global interrupt
    DMA2_Channel10 = 102,
    /// DMA2 Channel11 global interrupt
    DMA2_Channel11 = 103,
};

// https://github.com/openwch/ch32v307/blob/d4771d341779c8b9dc205b9cc1bc5d77ceeaacf3/EVT/EXAM/RCC/MCO/User/system_ch32v30x.c#L111
pub inline fn system_init(comptime chip: anytype) void {
    const RCC = chip.peripherals.RCC;

    // RCC->CTLR |= (uint32_t)0x00000001;
    RCC.CTLR.modify(.{ .HSION = 1 });
    // RCC->CFGR0 &= (uint32_t)0xF0FF0000;
    RCC.CFGR0.modify(.{
        .SW = 0,
        .SWS = 0,
        .HPRE = 0,
        .PPRE1 = 0,
        .PPRE2 = 0,
        .ADCPRE = 0,
        .MCO = 0,
    });
    // RCC->CTLR &= (uint32_t)0xFEF6FFFF; and RCC->CTLR &= (uint32_t)0xEBFFFFFF;
    RCC.CTLR.modify(.{ .HSEON = 0, .CSSON = 0, .PLLON = 0, .PLL2ON = 0 });
    // RCC->CTLR &= (uint32_t)0xFFFBFFFF;
    RCC.CTLR.modify(.{ .HSEBYP = 0 });
    // RCC->CFGR0 &= (uint32_t)0xFF00FFFF;
    RCC.CFGR0.modify(.{ .PLLSRC = 0, .PLLXTPRE = 0, .PLLMUL = 0, .USBPRE = 0 });
    // RCC->INTR = 0x00FF0000;
    RCC.INTR.write(.{
        // Read-only ready flags.
        .LSIRDYF = 0,
        .LSERDYF = 0,
        .HSIRDYF = 0,
        .HSERDYF = 0,
        .PLLRDYF = 0,
        .PLL2RDYF = 0,
        .PLL3RDYF = 0,
        .CSSF = 0,
        // Disable ready interrupts.
        .LSIRDYIE = 0,
        .LSERDYIE = 0,
        .HSIRDYIE = 0,
        .HSERDYIE = 0,
        .PLLRDYIE = 0,
        .PLL2RDYIE = 0,
        .PLL3RDYIE = 0,
        // Clear ready flags.
        .LSIRDYC = 1,
        .LSERDYC = 1,
        .HSIRDYC = 1,
        .HSERDYC = 1,
        .PLLRDYC = 1,
        .PLL2RDYC = 1,
        .PLL3RDYC = 1,
        .CSSC = 1,
    });
    // RCC->CFGR2 = 0x00000000;
    RCC.CFGR2.raw = 0;
}

pub const csr_types = struct {
    pub const intsyscr = packed struct(u32) {
        /// [0] Hardware Prologue/Epilogue (HPE) enable
        /// NOTE: Probably not supported by the Zig compiler. Would require
        /// __attribute__((interrupt("WCH-Interrupt-fast"))).
        hwstken: u1,
        /// [1] Interrupt nesting enable
        inesten: u1,
        /// [3:2] Interrupt nesting depth configuration
        pmtcfg: u2,
        /// [4] Interrupt enable after HPE overflow
        hwstkoven: u1 = 0,
        /// [5] Global interrupt and HPE off enable
        gihwstknen: u1 = 0,
        /// [7:6] Reserved
        reserved1: u2 = 0,
        /// [15:8] Preemption status indication
        pmtsta: u8 = 0,
        /// [31:16] Reserved
        reserved0: u16 = 0,
    };
};
