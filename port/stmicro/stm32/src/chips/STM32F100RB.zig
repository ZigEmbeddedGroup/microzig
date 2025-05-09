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
    .{ .name = "TAMPER", .index = 2, .description = null },
    .{ .name = "RTC", .index = 3, .description = null },
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
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM1_BRK_TIM15", .index = 24, .description = null },
    .{ .name = "TIM1_UP_TIM16", .index = 25, .description = null },
    .{ .name = "TIM1_TRG_COM_TIM17", .index = 26, .description = null },
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
    .{ .name = "CEC", .index = 42, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "TIM7", .index = 55, .description = null },
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
    TAMPER: Handler = unhandled,
    RTC: Handler = unhandled,
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
    reserved33: [4]u32 = undefined,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK_TIM15: Handler = unhandled,
    TIM1_UP_TIM16: Handler = unhandled,
    TIM1_TRG_COM_TIM17: Handler = unhandled,
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
    CEC: Handler = unhandled,
    reserved57: [11]u32 = undefined,
    TIM6_DAC: Handler = unhandled,
    TIM7: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1ffff7e8);
    /// General purpose 16-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000400);
    /// General purpose 16-bit timers
    pub const TIM4: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000800);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v1.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v1.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v1.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_f1.SPI = @ptrFromInt(0x40003800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v1.USART = @ptrFromInt(0x40004400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v1.USART = @ptrFromInt(0x40004800);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005800);
    /// Backup registers
    pub const BKP: *volatile types.peripherals.bkp_v1.BKP = @ptrFromInt(0x40006c00);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_f1.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40007400);
    /// HDMI-CEC controller.
    pub const CEC: *volatile types.peripherals.cec_v1.CEC = @ptrFromInt(0x40007800);
    /// Alternate function I/O
    pub const AFIO: *volatile types.peripherals.afio_f1.AFIO = @ptrFromInt(0x40010000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40010400);
    /// General purpose I/O
    pub const GPIOA: *volatile types.peripherals.gpio_v1.GPIO = @ptrFromInt(0x40010800);
    /// General purpose I/O
    pub const GPIOB: *volatile types.peripherals.gpio_v1.GPIO = @ptrFromInt(0x40010c00);
    /// General purpose I/O
    pub const GPIOC: *volatile types.peripherals.gpio_v1.GPIO = @ptrFromInt(0x40011000);
    /// General purpose I/O
    pub const GPIOD: *volatile types.peripherals.gpio_v1.GPIO = @ptrFromInt(0x40011400);
    /// General purpose I/O
    pub const GPIOE: *volatile types.peripherals.gpio_v1.GPIO = @ptrFromInt(0x40011800);
    /// Analog-to-digital converter
    pub const ADC1: *volatile types.peripherals.adc_f1.ADC = @ptrFromInt(0x40012400);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_f1.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v1.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_f100.RCC = @ptrFromInt(0x40021000);
    /// FLASH
    pub const FLASH: *volatile types.peripherals.flash_f1.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v1.CRC = @ptrFromInt(0x40023000);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_f1.DBGMCU = @ptrFromInt(0xe0042000);
};
