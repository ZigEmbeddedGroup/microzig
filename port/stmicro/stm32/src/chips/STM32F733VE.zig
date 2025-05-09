const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const Interrupt = struct {
    name: [:0]const u8,
    index: i16,
    description: ?[:0]const u8,
};

pub const interrupts: []const Interrupt = &.{
    .{ .name = "NMI", .index = -14, .description = null },
    .{ .name = "HardFault", .index = -13, .description = null },
    .{ .name = "MemManageFault", .index = -12, .description = null },
    .{ .name = "BusFault", .index = -11, .description = null },
    .{ .name = "UsageFault", .index = -10, .description = null },
    .{ .name = "SVCall", .index = -5, .description = null },
    .{ .name = "PendSV", .index = -2, .description = null },
    .{ .name = "SysTick", .index = -1, .description = null },
    .{ .name = "WWDG", .index = 0, .description = null },
    .{ .name = "PVD", .index = 1, .description = null },
    .{ .name = "TAMP_STAMP", .index = 2, .description = null },
    .{ .name = "RTC_WKUP", .index = 3, .description = null },
    .{ .name = "FLASH", .index = 4, .description = null },
    .{ .name = "RCC", .index = 5, .description = null },
    .{ .name = "EXTI0", .index = 6, .description = null },
    .{ .name = "EXTI1", .index = 7, .description = null },
    .{ .name = "EXTI2", .index = 8, .description = null },
    .{ .name = "EXTI3", .index = 9, .description = null },
    .{ .name = "EXTI4", .index = 10, .description = null },
    .{ .name = "DMA1_Stream0", .index = 11, .description = null },
    .{ .name = "DMA1_Stream1", .index = 12, .description = null },
    .{ .name = "DMA1_Stream2", .index = 13, .description = null },
    .{ .name = "DMA1_Stream3", .index = 14, .description = null },
    .{ .name = "DMA1_Stream4", .index = 15, .description = null },
    .{ .name = "DMA1_Stream5", .index = 16, .description = null },
    .{ .name = "DMA1_Stream6", .index = 17, .description = null },
    .{ .name = "ADC", .index = 18, .description = null },
    .{ .name = "CAN1_TX", .index = 19, .description = null },
    .{ .name = "CAN1_RX0", .index = 20, .description = null },
    .{ .name = "CAN1_RX1", .index = 21, .description = null },
    .{ .name = "CAN1_SCE", .index = 22, .description = null },
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM1_BRK_TIM9", .index = 24, .description = null },
    .{ .name = "TIM1_UP_TIM10", .index = 25, .description = null },
    .{ .name = "TIM1_TRG_COM_TIM11", .index = 26, .description = null },
    .{ .name = "TIM1_CC", .index = 27, .description = null },
    .{ .name = "TIM2", .index = 28, .description = null },
    .{ .name = "TIM3", .index = 29, .description = null },
    .{ .name = "TIM4", .index = 30, .description = null },
    .{ .name = "I2C1_EV", .index = 31, .description = null },
    .{ .name = "I2C1_ER", .index = 32, .description = null },
    .{ .name = "I2C2_EV", .index = 33, .description = null },
    .{ .name = "I2C2_ER", .index = 34, .description = null },
    .{ .name = "SPI1", .index = 35, .description = null },
    .{ .name = "SPI2", .index = 36, .description = null },
    .{ .name = "USART1", .index = 37, .description = null },
    .{ .name = "USART2", .index = 38, .description = null },
    .{ .name = "USART3", .index = 39, .description = null },
    .{ .name = "EXTI15_10", .index = 40, .description = null },
    .{ .name = "RTC_Alarm", .index = 41, .description = null },
    .{ .name = "OTG_FS_WKUP", .index = 42, .description = null },
    .{ .name = "TIM8_BRK_TIM12", .index = 43, .description = null },
    .{ .name = "TIM8_UP_TIM13", .index = 44, .description = null },
    .{ .name = "TIM8_TRG_COM_TIM14", .index = 45, .description = null },
    .{ .name = "TIM8_CC", .index = 46, .description = null },
    .{ .name = "DMA1_Stream7", .index = 47, .description = null },
    .{ .name = "FMC", .index = 48, .description = null },
    .{ .name = "SDMMC1", .index = 49, .description = null },
    .{ .name = "TIM5", .index = 50, .description = null },
    .{ .name = "SPI3", .index = 51, .description = null },
    .{ .name = "UART4", .index = 52, .description = null },
    .{ .name = "UART5", .index = 53, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "TIM7", .index = 55, .description = null },
    .{ .name = "DMA2_Stream0", .index = 56, .description = null },
    .{ .name = "DMA2_Stream1", .index = 57, .description = null },
    .{ .name = "DMA2_Stream2", .index = 58, .description = null },
    .{ .name = "DMA2_Stream3", .index = 59, .description = null },
    .{ .name = "DMA2_Stream4", .index = 60, .description = null },
    .{ .name = "ETH", .index = 61, .description = null },
    .{ .name = "ETH_WKUP", .index = 62, .description = null },
    .{ .name = "OTG_FS", .index = 67, .description = null },
    .{ .name = "DMA2_Stream5", .index = 68, .description = null },
    .{ .name = "DMA2_Stream6", .index = 69, .description = null },
    .{ .name = "DMA2_Stream7", .index = 70, .description = null },
    .{ .name = "USART6", .index = 71, .description = null },
    .{ .name = "I2C3_EV", .index = 72, .description = null },
    .{ .name = "I2C3_ER", .index = 73, .description = null },
    .{ .name = "OTG_HS_EP1_OUT", .index = 74, .description = null },
    .{ .name = "OTG_HS_EP1_IN", .index = 75, .description = null },
    .{ .name = "OTG_HS_WKUP", .index = 76, .description = null },
    .{ .name = "OTG_HS", .index = 77, .description = null },
    .{ .name = "AES", .index = 79, .description = null },
    .{ .name = "RNG", .index = 80, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
    .{ .name = "UART7", .index = 82, .description = null },
    .{ .name = "UART8", .index = 83, .description = null },
    .{ .name = "SPI4", .index = 84, .description = null },
    .{ .name = "SPI5", .index = 85, .description = null },
    .{ .name = "SAI1", .index = 87, .description = null },
    .{ .name = "SAI2", .index = 91, .description = null },
    .{ .name = "QUADSPI", .index = 92, .description = null },
    .{ .name = "LPTIM1", .index = 93, .description = null },
    .{ .name = "SDMMC2", .index = 103, .description = null },
};

pub const VectorTable = extern struct {
    const Handler = microzig.interrupt.Handler;
    const unhandled = microzig.interrupt.unhandled;

    initial_stack_pointer: u32,
    Reset: Handler,
    NMI: Handler = unhandled,
    HardFault: Handler = unhandled,
    MemManageFault: Handler = unhandled,
    BusFault: Handler = unhandled,
    UsageFault: Handler = unhandled,
    reserved5: [4]u32 = undefined,
    SVCall: Handler = unhandled,
    reserved10: [2]u32 = undefined,
    PendSV: Handler = unhandled,
    SysTick: Handler = unhandled,
    WWDG: Handler = unhandled,
    PVD: Handler = unhandled,
    TAMP_STAMP: Handler = unhandled,
    RTC_WKUP: Handler = unhandled,
    FLASH: Handler = unhandled,
    RCC: Handler = unhandled,
    EXTI0: Handler = unhandled,
    EXTI1: Handler = unhandled,
    EXTI2: Handler = unhandled,
    EXTI3: Handler = unhandled,
    EXTI4: Handler = unhandled,
    DMA1_Stream0: Handler = unhandled,
    DMA1_Stream1: Handler = unhandled,
    DMA1_Stream2: Handler = unhandled,
    DMA1_Stream3: Handler = unhandled,
    DMA1_Stream4: Handler = unhandled,
    DMA1_Stream5: Handler = unhandled,
    DMA1_Stream6: Handler = unhandled,
    ADC: Handler = unhandled,
    CAN1_TX: Handler = unhandled,
    CAN1_RX0: Handler = unhandled,
    CAN1_RX1: Handler = unhandled,
    CAN1_SCE: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK_TIM9: Handler = unhandled,
    TIM1_UP_TIM10: Handler = unhandled,
    TIM1_TRG_COM_TIM11: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    TIM3: Handler = unhandled,
    TIM4: Handler = unhandled,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    USART3: Handler = unhandled,
    EXTI15_10: Handler = unhandled,
    RTC_Alarm: Handler = unhandled,
    OTG_FS_WKUP: Handler = unhandled,
    TIM8_BRK_TIM12: Handler = unhandled,
    TIM8_UP_TIM13: Handler = unhandled,
    TIM8_TRG_COM_TIM14: Handler = unhandled,
    TIM8_CC: Handler = unhandled,
    DMA1_Stream7: Handler = unhandled,
    FMC: Handler = unhandled,
    SDMMC1: Handler = unhandled,
    TIM5: Handler = unhandled,
    SPI3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    TIM6_DAC: Handler = unhandled,
    TIM7: Handler = unhandled,
    DMA2_Stream0: Handler = unhandled,
    DMA2_Stream1: Handler = unhandled,
    DMA2_Stream2: Handler = unhandled,
    DMA2_Stream3: Handler = unhandled,
    DMA2_Stream4: Handler = unhandled,
    ETH: Handler = unhandled,
    ETH_WKUP: Handler = unhandled,
    reserved77: [4]u32 = undefined,
    OTG_FS: Handler = unhandled,
    DMA2_Stream5: Handler = unhandled,
    DMA2_Stream6: Handler = unhandled,
    DMA2_Stream7: Handler = unhandled,
    USART6: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    OTG_HS_EP1_OUT: Handler = unhandled,
    OTG_HS_EP1_IN: Handler = unhandled,
    OTG_HS_WKUP: Handler = unhandled,
    OTG_HS: Handler = unhandled,
    reserved92: [1]u32 = undefined,
    AES: Handler = unhandled,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    UART7: Handler = unhandled,
    UART8: Handler = unhandled,
    SPI4: Handler = unhandled,
    SPI5: Handler = unhandled,
    reserved100: [1]u32 = undefined,
    SAI1: Handler = unhandled,
    reserved102: [3]u32 = undefined,
    SAI2: Handler = unhandled,
    QUADSPI: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    reserved108: [9]u32 = undefined,
    SDMMC2: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1ff07a10);
    /// VREFINT Factory Calibration
    pub const VREFINTCAL: *volatile types.peripherals.vrefintcal_v1.VREFINTCAL = @ptrFromInt(0x1ff07a2a);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000400);
    /// General purpose 16-bit timers
    pub const TIM4: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000800);
    /// General purpose 32-bit timers
    pub const TIM5: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000c00);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001400);
    /// 1-channel timers
    pub const TIM13: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40001c00);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1a.LPTIM = @ptrFromInt(0x40002400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2f7.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v1.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40004400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40004800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART4: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40004c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART5: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40005000);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005c00);
    /// Controller area network
    pub const CAN1: *volatile types.peripherals.can_bxcan.CAN = @ptrFromInt(0x40006400);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_f7.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40007400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART7: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40007800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART8: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40007c00);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40010000);
    /// Advanced Control timers
    pub const TIM8: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40010400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40011000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART6: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40011400);
    /// Analog-to-digital converter
    pub const ADC1: *volatile types.peripherals.adc_v2.ADC = @ptrFromInt(0x40012000);
    /// Analog-to-digital converter
    pub const ADC2: *volatile types.peripherals.adc_v2.ADC = @ptrFromInt(0x40012100);
    /// Analog-to-digital converter
    pub const ADC3: *volatile types.peripherals.adc_v2.ADC = @ptrFromInt(0x40012200);
    /// ADC common registers
    pub const ADC123_COMMON: *volatile types.peripherals.adccommon_v2.ADC_COMMON = @ptrFromInt(0x40012300);
    /// Secure digital input/output interface
    pub const SDMMC1: *volatile types.peripherals.sdmmc_v1.SDMMC = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Serial peripheral interface
    pub const SPI4: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013400);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_f7.SYSCFG = @ptrFromInt(0x40013800);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40013c00);
    /// 2-channel timers
    pub const TIM9: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40014000);
    /// 1-channel timers
    pub const TIM10: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40014400);
    /// 1-channel timers
    pub const TIM11: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40014800);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v2.SAI = @ptrFromInt(0x40015800);
    /// Serial audio interface
    pub const SAI2: *volatile types.peripherals.sai_v2.SAI = @ptrFromInt(0x40015c00);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021000);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021400);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021c00);
    /// General-purpose I/Os
    pub const GPIOI: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_f7.RCC = @ptrFromInt(0x40023800);
    /// FLASH
    pub const FLASH: *volatile types.peripherals.flash_f7.FLASH = @ptrFromInt(0x40023c00);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.dma_v2.DMA = @ptrFromInt(0x40026000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.dma_v2.DMA = @ptrFromInt(0x40026400);
    /// USB on the go
    pub const USB_OTG_HS: *volatile types.peripherals.otg_v1.OTG = @ptrFromInt(0x40040000);
    /// USB on the go
    pub const USB_OTG_FS: *volatile types.peripherals.otg_v1.OTG = @ptrFromInt(0x50000000);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_f7.AES = @ptrFromInt(0x50060000);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x50060800);
    /// Flexible memory controller
    pub const FMC: *volatile types.peripherals.fmc_v2x1.FMC = @ptrFromInt(0xa0000000);
    /// QuadSPI interface
    pub const QUADSPI: *volatile types.peripherals.quadspi_v1.QUADSPI = @ptrFromInt(0xa0001000);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_f7.DBGMCU = @ptrFromInt(0xe0042000);
};
