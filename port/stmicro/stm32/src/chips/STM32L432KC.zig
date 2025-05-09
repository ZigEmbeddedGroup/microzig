const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("types.zig");

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
    .{ .name = "PVD_PVM", .index = 1, .description = null },
    .{ .name = "TAMP_STAMP", .index = 2, .description = null },
    .{ .name = "RTC_WKUP", .index = 3, .description = null },
    .{ .name = "FLASH", .index = 4, .description = null },
    .{ .name = "RCC", .index = 5, .description = null },
    .{ .name = "EXTI0", .index = 6, .description = null },
    .{ .name = "EXTI1", .index = 7, .description = null },
    .{ .name = "EXTI2", .index = 8, .description = null },
    .{ .name = "EXTI3", .index = 9, .description = null },
    .{ .name = "EXTI4", .index = 10, .description = null },
    .{ .name = "DMA1_Channel1", .index = 11, .description = null },
    .{ .name = "DMA1_Channel2", .index = 12, .description = null },
    .{ .name = "DMA1_Channel3", .index = 13, .description = null },
    .{ .name = "DMA1_Channel4", .index = 14, .description = null },
    .{ .name = "DMA1_Channel5", .index = 15, .description = null },
    .{ .name = "DMA1_Channel6", .index = 16, .description = null },
    .{ .name = "DMA1_Channel7", .index = 17, .description = null },
    .{ .name = "ADC1", .index = 18, .description = null },
    .{ .name = "CAN1_TX", .index = 19, .description = null },
    .{ .name = "CAN1_RX0", .index = 20, .description = null },
    .{ .name = "CAN1_RX1", .index = 21, .description = null },
    .{ .name = "CAN1_SCE", .index = 22, .description = null },
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM1_BRK_TIM15", .index = 24, .description = null },
    .{ .name = "TIM1_UP_TIM16", .index = 25, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 26, .description = null },
    .{ .name = "TIM1_CC", .index = 27, .description = null },
    .{ .name = "TIM2", .index = 28, .description = null },
    .{ .name = "I2C1_EV", .index = 31, .description = null },
    .{ .name = "I2C1_ER", .index = 32, .description = null },
    .{ .name = "SPI1", .index = 35, .description = null },
    .{ .name = "USART1", .index = 37, .description = null },
    .{ .name = "USART2", .index = 38, .description = null },
    .{ .name = "EXTI15_10", .index = 40, .description = null },
    .{ .name = "RTC_Alarm", .index = 41, .description = null },
    .{ .name = "SPI3", .index = 51, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "TIM7", .index = 55, .description = null },
    .{ .name = "DMA2_Channel1", .index = 56, .description = null },
    .{ .name = "DMA2_Channel2", .index = 57, .description = null },
    .{ .name = "DMA2_Channel3", .index = 58, .description = null },
    .{ .name = "DMA2_Channel4", .index = 59, .description = null },
    .{ .name = "DMA2_Channel5", .index = 60, .description = null },
    .{ .name = "COMP", .index = 64, .description = null },
    .{ .name = "LPTIM1", .index = 65, .description = null },
    .{ .name = "LPTIM2", .index = 66, .description = null },
    .{ .name = "USB", .index = 67, .description = null },
    .{ .name = "DMA2_Channel6", .index = 68, .description = null },
    .{ .name = "DMA2_Channel7", .index = 69, .description = null },
    .{ .name = "LPUART1", .index = 70, .description = null },
    .{ .name = "QUADSPI", .index = 71, .description = null },
    .{ .name = "I2C3_EV", .index = 72, .description = null },
    .{ .name = "I2C3_ER", .index = 73, .description = null },
    .{ .name = "SAI1", .index = 74, .description = null },
    .{ .name = "SWPMI1", .index = 76, .description = null },
    .{ .name = "TSC", .index = 77, .description = null },
    .{ .name = "RNG", .index = 80, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
    .{ .name = "CRS", .index = 82, .description = null },
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
    PVD_PVM: Handler = unhandled,
    TAMP_STAMP: Handler = unhandled,
    RTC_WKUP: Handler = unhandled,
    FLASH: Handler = unhandled,
    RCC: Handler = unhandled,
    EXTI0: Handler = unhandled,
    EXTI1: Handler = unhandled,
    EXTI2: Handler = unhandled,
    EXTI3: Handler = unhandled,
    EXTI4: Handler = unhandled,
    DMA1_Channel1: Handler = unhandled,
    DMA1_Channel2: Handler = unhandled,
    DMA1_Channel3: Handler = unhandled,
    DMA1_Channel4: Handler = unhandled,
    DMA1_Channel5: Handler = unhandled,
    DMA1_Channel6: Handler = unhandled,
    DMA1_Channel7: Handler = unhandled,
    ADC1: Handler = unhandled,
    CAN1_TX: Handler = unhandled,
    CAN1_RX0: Handler = unhandled,
    CAN1_RX1: Handler = unhandled,
    CAN1_SCE: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK_TIM15: Handler = unhandled,
    TIM1_UP_TIM16: Handler = unhandled,
    TIM1_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    reserved43: [2]u32 = undefined,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    reserved47: [2]u32 = undefined,
    SPI1: Handler = unhandled,
    reserved50: [1]u32 = undefined,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    reserved53: [1]u32 = undefined,
    EXTI15_10: Handler = unhandled,
    RTC_Alarm: Handler = unhandled,
    reserved56: [9]u32 = undefined,
    SPI3: Handler = unhandled,
    reserved66: [2]u32 = undefined,
    TIM6_DAC: Handler = unhandled,
    TIM7: Handler = unhandled,
    DMA2_Channel1: Handler = unhandled,
    DMA2_Channel2: Handler = unhandled,
    DMA2_Channel3: Handler = unhandled,
    DMA2_Channel4: Handler = unhandled,
    DMA2_Channel5: Handler = unhandled,
    reserved75: [3]u32 = undefined,
    COMP: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    USB: Handler = unhandled,
    DMA2_Channel6: Handler = unhandled,
    DMA2_Channel7: Handler = unhandled,
    LPUART1: Handler = unhandled,
    QUADSPI: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    SAI1: Handler = unhandled,
    reserved89: [1]u32 = undefined,
    SWPMI1: Handler = unhandled,
    TSC: Handler = unhandled,
    reserved92: [2]u32 = undefined,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    CRS: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7590);
    /// VREFINT Factory Calibration
    pub const VREFINTCAL: *volatile types.peripherals.vrefintcal_v1.VREFINTCAL = @ptrFromInt(0x1fff75aa);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2l4.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v1.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40004400);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005c00);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40006000);
    /// Controller area network
    pub const CAN1: *volatile types.peripherals.can_bxcan.CAN = @ptrFromInt(0x40006400);
    /// Universal serial bus full-speed device interface
    pub const USB: *volatile types.peripherals.usb_v3.USB = @ptrFromInt(0x40006800);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_16x2_1024.USBRAM = @ptrFromInt(0x40006c00);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_l4.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v3.DAC = @ptrFromInt(0x40007400);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1a.LPTIM = @ptrFromInt(0x40007c00);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v3.LPUART = @ptrFromInt(0x40008000);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v1a.LPTIM = @ptrFromInt(0x40009400);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_l4.SYSCFG = @ptrFromInt(0x40010000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40010400);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v2.SAI = @ptrFromInt(0x40015400);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v2.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v2.DMA = @ptrFromInt(0x40020400);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_l4.RCC = @ptrFromInt(0x40021000);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_l4.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Touch sensing controller.
    pub const TSC: *volatile types.peripherals.tsc_v3.TSC = @ptrFromInt(0x40024000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001c00);
    /// Analog-to-Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_v3.ADC = @ptrFromInt(0x50040000);
    /// Analog-to-Digital Converter
    pub const ADC1_COMMON: *volatile types.peripherals.adccommon_v3.ADC_COMMON = @ptrFromInt(0x50040300);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x50060800);
    /// QuadSPI interface
    pub const QUADSPI: *volatile types.peripherals.quadspi_v1.QUADSPI = @ptrFromInt(0xa0001000);
    /// MCU debug component
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_l4.DBGMCU = @ptrFromInt(0xe0042000);
};
