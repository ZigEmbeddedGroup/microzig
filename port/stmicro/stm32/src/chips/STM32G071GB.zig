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
    .{ .name = "SVCall", .index = -5, .description = null },
    .{ .name = "PendSV", .index = -2, .description = null },
    .{ .name = "SysTick", .index = -1, .description = null },
    .{ .name = "WWDG", .index = 0, .description = null },
    .{ .name = "PVD", .index = 1, .description = null },
    .{ .name = "RTC_TAMP", .index = 2, .description = null },
    .{ .name = "FLASH", .index = 3, .description = null },
    .{ .name = "RCC", .index = 4, .description = null },
    .{ .name = "EXTI0_1", .index = 5, .description = null },
    .{ .name = "EXTI2_3", .index = 6, .description = null },
    .{ .name = "EXTI4_15", .index = 7, .description = null },
    .{ .name = "UCPD1_2", .index = 8, .description = null },
    .{ .name = "DMA1_Channel1", .index = 9, .description = null },
    .{ .name = "DMA1_Channel2_3", .index = 10, .description = null },
    .{ .name = "DMA1_Ch4_7_DMAMUX1_OVR", .index = 11, .description = null },
    .{ .name = "ADC1_COMP", .index = 12, .description = null },
    .{ .name = "TIM1_BRK_UP_TRG_COM", .index = 13, .description = null },
    .{ .name = "TIM1_CC", .index = 14, .description = null },
    .{ .name = "TIM2", .index = 15, .description = null },
    .{ .name = "TIM3", .index = 16, .description = null },
    .{ .name = "TIM6_DAC_LPTIM1", .index = 17, .description = null },
    .{ .name = "TIM7_LPTIM2", .index = 18, .description = null },
    .{ .name = "TIM14", .index = 19, .description = null },
    .{ .name = "TIM15", .index = 20, .description = null },
    .{ .name = "TIM16", .index = 21, .description = null },
    .{ .name = "TIM17", .index = 22, .description = null },
    .{ .name = "I2C1", .index = 23, .description = null },
    .{ .name = "I2C2", .index = 24, .description = null },
    .{ .name = "SPI1", .index = 25, .description = null },
    .{ .name = "SPI2", .index = 26, .description = null },
    .{ .name = "USART1", .index = 27, .description = null },
    .{ .name = "USART2", .index = 28, .description = null },
    .{ .name = "USART3_4_LPUART1", .index = 29, .description = null },
    .{ .name = "CEC", .index = 30, .description = null },
};

pub const VectorTable = extern struct {
    const Handler = microzig.interrupt.Handler;
    const unhandled = microzig.interrupt.unhandled;

    initial_stack_pointer: u32,
    Reset: Handler,
    NMI: Handler = unhandled,
    HardFault: Handler = unhandled,
    reserved2: [7]u32 = undefined,
    SVCall: Handler = unhandled,
    reserved10: [2]u32 = undefined,
    PendSV: Handler = unhandled,
    SysTick: Handler = unhandled,
    WWDG: Handler = unhandled,
    PVD: Handler = unhandled,
    RTC_TAMP: Handler = unhandled,
    FLASH: Handler = unhandled,
    RCC: Handler = unhandled,
    EXTI0_1: Handler = unhandled,
    EXTI2_3: Handler = unhandled,
    EXTI4_15: Handler = unhandled,
    UCPD1_2: Handler = unhandled,
    DMA1_Channel1: Handler = unhandled,
    DMA1_Channel2_3: Handler = unhandled,
    DMA1_Ch4_7_DMAMUX1_OVR: Handler = unhandled,
    ADC1_COMP: Handler = unhandled,
    TIM1_BRK_UP_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    TIM3: Handler = unhandled,
    TIM6_DAC_LPTIM1: Handler = unhandled,
    TIM7_LPTIM2: Handler = unhandled,
    TIM14: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    I2C1: Handler = unhandled,
    I2C2: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    USART3_4_LPUART1: Handler = unhandled,
    CEC: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7590);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000400);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001400);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART4: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004c00);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_g0.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v4.DAC = @ptrFromInt(0x40007400);
    /// CEC.
    pub const CEC: *volatile types.peripherals.cec_v2.CEC = @ptrFromInt(0x40007800);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1b.LPTIM = @ptrFromInt(0x40007c00);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008000);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v1b.LPTIM = @ptrFromInt(0x40009400);
    /// USB Power Delivery interface
    pub const UCPD1: *volatile types.peripherals.ucpd_v1.UCPD = @ptrFromInt(0x4000a000);
    /// USB Power Delivery interface
    pub const UCPD2: *volatile types.peripherals.ucpd_v1.UCPD = @ptrFromInt(0x4000a400);
    /// Tamper and backup registers
    pub const TAMP: *volatile types.peripherals.tamp_g0.TAMP = @ptrFromInt(0x4000b000);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_g0.SYSCFG = @ptrFromInt(0x40010000);
    /// Comparator v1. (RM0444 18)
    pub const COMP1: *volatile types.peripherals.comp_v1.COMP = @ptrFromInt(0x40010200);
    /// Comparator v1. (RM0444 18)
    pub const COMP2: *volatile types.peripherals.comp_v1.COMP = @ptrFromInt(0x40010204);
    /// Analog to Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_g0.ADC = @ptrFromInt(0x40012400);
    /// Analog-to-Digital Converter
    pub const ADC1_COMMON: *volatile types.peripherals.adccommon_v3.ADC_COMMON = @ptrFromInt(0x40012708);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_g0.DBGMCU = @ptrFromInt(0x40015800);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_g0.RCC = @ptrFromInt(0x40021000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_g0.EXTI = @ptrFromInt(0x40021800);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_g0.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000c00);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50001400);
};
