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
    .{ .name = "PVD", .index = 1, .description = null },
    .{ .name = "TAMP_STAMP", .index = 2, .description = null },
    .{ .name = "RTC_WKUP", .index = 3, .description = null },
    .{ .name = "FLASH", .index = 4, .description = null },
    .{ .name = "RCC", .index = 5, .description = null },
    .{ .name = "EXTI0", .index = 6, .description = null },
    .{ .name = "EXTI1", .index = 7, .description = null },
    .{ .name = "EXTI2_TSC", .index = 8, .description = null },
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
    .{ .name = "CAN_TX", .index = 19, .description = null },
    .{ .name = "CAN_RX0", .index = 20, .description = null },
    .{ .name = "CAN_RX1", .index = 21, .description = null },
    .{ .name = "CAN_SCE", .index = 22, .description = null },
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM15", .index = 24, .description = null },
    .{ .name = "TIM16", .index = 25, .description = null },
    .{ .name = "TIM17", .index = 26, .description = null },
    .{ .name = "TIM18_DAC2", .index = 27, .description = null },
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
    .{ .name = "CEC", .index = 42, .description = null },
    .{ .name = "TIM12", .index = 43, .description = null },
    .{ .name = "TIM13", .index = 44, .description = null },
    .{ .name = "TIM14", .index = 45, .description = null },
    .{ .name = "TIM5", .index = 50, .description = null },
    .{ .name = "SPI3", .index = 51, .description = null },
    .{ .name = "TIM6_DAC1", .index = 54, .description = null },
    .{ .name = "TIM7", .index = 55, .description = null },
    .{ .name = "DMA2_Channel1", .index = 56, .description = null },
    .{ .name = "DMA2_Channel2", .index = 57, .description = null },
    .{ .name = "DMA2_Channel3", .index = 58, .description = null },
    .{ .name = "DMA2_Channel4", .index = 59, .description = null },
    .{ .name = "DMA2_Channel5", .index = 60, .description = null },
    .{ .name = "SDADC1", .index = 61, .description = null },
    .{ .name = "SDADC2", .index = 62, .description = null },
    .{ .name = "SDADC3", .index = 63, .description = null },
    .{ .name = "COMP", .index = 64, .description = null },
    .{ .name = "USB_HP", .index = 74, .description = null },
    .{ .name = "USB_LP", .index = 75, .description = null },
    .{ .name = "USBWakeUp", .index = 76, .description = null },
    .{ .name = "TIM19", .index = 78, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
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
    EXTI2_TSC: Handler = unhandled,
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
    CAN_TX: Handler = unhandled,
    CAN_RX0: Handler = unhandled,
    CAN_RX1: Handler = unhandled,
    CAN_SCE: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    TIM18_DAC2: Handler = unhandled,
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
    CEC: Handler = unhandled,
    TIM12: Handler = unhandled,
    TIM13: Handler = unhandled,
    TIM14: Handler = unhandled,
    reserved60: [4]u32 = undefined,
    TIM5: Handler = unhandled,
    SPI3: Handler = unhandled,
    reserved66: [2]u32 = undefined,
    TIM6_DAC1: Handler = unhandled,
    TIM7: Handler = unhandled,
    DMA2_Channel1: Handler = unhandled,
    DMA2_Channel2: Handler = unhandled,
    DMA2_Channel3: Handler = unhandled,
    DMA2_Channel4: Handler = unhandled,
    DMA2_Channel5: Handler = unhandled,
    SDADC1: Handler = unhandled,
    SDADC2: Handler = unhandled,
    SDADC3: Handler = unhandled,
    COMP: Handler = unhandled,
    reserved79: [9]u32 = undefined,
    USB_HP: Handler = unhandled,
    USB_LP: Handler = unhandled,
    USBWakeUp: Handler = unhandled,
    reserved91: [1]u32 = undefined,
    TIM19: Handler = unhandled,
    reserved93: [2]u32 = undefined,
    FPU: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1ffff7ac);
    /// VREFINT Factory Calibration
    pub const VREFINTCAL: *volatile types.peripherals.vrefintcal_v1.VREFINTCAL = @ptrFromInt(0x1ffff7ba);
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
    /// 2-channel timers
    pub const TIM12: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40001800);
    /// 1-channel timers
    pub const TIM13: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40001c00);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2f3.RTC = @ptrFromInt(0x40002800);
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
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Universal serial bus full-speed device interface
    pub const USB: *volatile types.peripherals.usb_v1.USB = @ptrFromInt(0x40005c00);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_16x2_512.USBRAM = @ptrFromInt(0x40006000);
    /// Controller area network
    pub const CAN: *volatile types.peripherals.can_bxcan.CAN = @ptrFromInt(0x40006400);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_f3.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40007400);
    /// CEC.
    pub const CEC: *volatile types.peripherals.cec_v2.CEC = @ptrFromInt(0x40007800);
    /// Digital-to-analog converter
    pub const DAC2: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40009800);
    /// Basic timers
    pub const TIM18: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40009c00);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_f3.SYSCFG = @ptrFromInt(0x40010000);
    /// General purpose comparators.
    pub const COMP1: *volatile types.peripherals.comp_f3_v1.COMP = @ptrFromInt(0x4001001c);
    /// General purpose comparators.
    pub const COMP2: *volatile types.peripherals.comp_f3_v1.COMP = @ptrFromInt(0x4001001e);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40010400);
    /// Analog-to-Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_f3_v2.ADC = @ptrFromInt(0x40012400);
    /// ADC common registers
    pub const ADC1_COMMON: *volatile types.peripherals.adccommon_f3.ADC_COMMON = @ptrFromInt(0x40012400);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v3.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// General purpose 16-bit timers
    pub const TIM19: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40015c00);
    /// Sigma-delta analog-to-digital converter.
    pub const SDADC1: *volatile types.peripherals.sdadc_v1.SDADC = @ptrFromInt(0x40016000);
    /// Sigma-delta analog-to-digital converter.
    pub const SDADC2: *volatile types.peripherals.sdadc_v1.SDADC = @ptrFromInt(0x40016400);
    /// Sigma-delta analog-to-digital converter.
    pub const SDADC3: *volatile types.peripherals.sdadc_v1.SDADC = @ptrFromInt(0x40016800);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020400);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_f37.RCC = @ptrFromInt(0x40021000);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_f3.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Touch sensing controller.
    pub const TSC: *volatile types.peripherals.tsc_v1.TSC = @ptrFromInt(0x40024000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001000);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001400);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_f3.DBGMCU = @ptrFromInt(0xe0042000);
};
