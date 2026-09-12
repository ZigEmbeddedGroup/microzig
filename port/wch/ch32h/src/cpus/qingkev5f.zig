///
/// Processor-specific configuration for WCH QingKe V5F processor (CH32H417 CORE1).
/// Interrupt vector table extracted from openwch/ch32h417 EVT startup_ch32h417_v5f.S.
///
pub const cpu_frequency = 400_000_000; // 400 MHz

pub const Interrupt = enum(u8) {
    NMI = 2,
    HardFault = 3,
    Ecall_M_Mode = 5,
    Ecall_U_Mode = 8,
    Break_Point = 9,
    SysTick0 = 12,
    SysTick1 = 13,
    SW = 14,
    IPC_CH0 = 16,
    IPC_CH1 = 17,
    IPC_CH2 = 18,
    IPC_CH3 = 19,
    HSEM = 28,
    WWDG = 32,
    EXTI15_8 = 33,
    FLASH = 34,
    RCC = 35,
    EXTI7_0 = 36,
    SPI1 = 37,
    DMA1_Channel2 = 38,
    DMA1_Channel3 = 39,
    DMA1_Channel4 = 40,
    DMA1_Channel5 = 41,
    DMA1_Channel6 = 42,
    DMA1_Channel7 = 43,
    DMA1_Channel8 = 44,
    USART2 = 45,
    I2C1_EV = 46,
    I2C1_ER = 47,
    USART1 = 48,
    SPI2 = 49,
    SPI3 = 50,
    SPI4 = 51,
    I2C2_EV = 52,
    I2C2_ER = 53,
    USBPD = 54,
    USBPDWakeUp = 55,
    USBHS = 56,
    DMA1_Channel1 = 57,
    CAN1_SCE = 58,
    CAN1_TX = 59,
    CAN1_RX0 = 60,
    CAN1_RX1 = 61,
    USBSS = 62,
    USBSS_LINK = 63,
    USBHSWakeup = 64,
    USBSSWakeup = 65,
    RTCAlarm = 66,
    USBFS = 67,
    USBFSWakeup = 68,
    ADC1_2 = 69,
    TIM1_BRK = 70,
    TIM1_UP = 71,
    TIM1_TRG_COM = 72,
    TIM1_CC = 73,
    TIM2 = 74,
    TIM3 = 75,
    TIM4 = 76,
    TIM5 = 77,
    I2C3_EV = 78,
    I2C3_ER = 79,
    I2C4_EV = 80,
    I2C4_ER = 81,
    QSPI1 = 82,
    SERDES = 83,
    USART3 = 84,
    USART4 = 85,
    TIM8_BRK = 86,
    TIM8_UP = 87,
    TIM8_TRG_COM = 88,
    TIM8_CC = 89,
    TIM9 = 90,
    TIM10 = 91,
    TIM11 = 92,
    TIM12 = 93,
    FMC = 94,
    SDMMC = 95,
    LPTIM1 = 96,
    LPTIM2 = 97,
    USART5 = 98,
    USART6 = 99,
    TIM6 = 100,
    TIM7 = 101,
    DMA2_Channel1 = 102,
    DMA2_Channel2 = 103,
    DMA2_Channel3 = 104,
    DMA2_Channel4 = 105,
    DMA2_Channel5 = 106,
    DMA2_Channel6 = 107,
    DMA2_Channel7 = 108,
    DMA2_Channel8 = 109,
    ETH = 110,
    ETH_WKUP = 111,
    CAN2_SCE = 112,
    CAN2_TX = 113,
    CAN2_RX0 = 114,
    CAN2_RX1 = 115,
    USART7 = 116,
    USART8 = 117,
    I3C_EV = 118,
    I3C_ER = 119,
    DVP = 120,
    ECDC = 121,
    PIOC = 122,
    SAI = 123,
    LTDC = 124,
    GPHA = 125,
    DFSDM0 = 127,
    DFSDM1 = 128,
    SWPMI = 131,
    QSPI2 = 134,
    SWPMI_WKUP = 135,
    CAN3_SCE = 136,
    CAN3_TX = 137,
    CAN3_RX0 = 138,
    CAN3_RX1 = 139,
    LPTIM2_WKUP = 140,
    LPTIM1_WKUP = 141,
    I3C_WKUP = 142,
    RTC = 143,
    HSADC = 144,
    UHSIF = 145,
    RNG = 146,
    SDIO = 147,
    USART_WKUP = 148,
};

/// System initialization: no-op for now (both cores boot from the 25 MHz HSI).
// TODO: port the PLL/clock bring-up from the EVT startup code.
pub inline fn system_init(comptime chip: anytype) void {
    _ = chip;
}

/// Wait for interrupt. Clears WFITOWFE so the wfi instruction behaves as
/// a true wait-for-interrupt.
pub inline fn wfi(comptime chip: anytype) void {
    const PFIC = chip.peripherals.PFIC;
    PFIC.SCTLR.modify(.{ .WFITOWFE = 0 });
    asm volatile ("wfi");
}

/// Wait for event. Sets SETEVENT to clear any stale event latch, enables
/// WFITOWFE so the wfi instruction acts as wfe, then executes wfi twice:
/// the first clears the just-set event, the second sleeps until a real event.
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
