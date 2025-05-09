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
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM1_BRK_TIM9", .index = 24, .description = null },
    .{ .name = "TIM1_UP", .index = 25, .description = null },
    .{ .name = "TIM1_TRG_COM_TIM11", .index = 26, .description = null },
    .{ .name = "TIM1_CC", .index = 27, .description = null },
    .{ .name = "I2C1_EV", .index = 31, .description = null },
    .{ .name = "I2C1_ER", .index = 32, .description = null },
    .{ .name = "I2C2_EV", .index = 33, .description = null },
    .{ .name = "I2C2_ER", .index = 34, .description = null },
    .{ .name = "SPI1", .index = 35, .description = null },
    .{ .name = "USART1", .index = 37, .description = null },
    .{ .name = "USART2", .index = 38, .description = null },
    .{ .name = "EXTI15_10", .index = 40, .description = null },
    .{ .name = "RTC_Alarm", .index = 41, .description = null },
    .{ .name = "DMA1_Stream7", .index = 47, .description = null },
    .{ .name = "TIM5", .index = 50, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "DMA2_Stream0", .index = 56, .description = null },
    .{ .name = "DMA2_Stream1", .index = 57, .description = null },
    .{ .name = "DMA2_Stream2", .index = 58, .description = null },
    .{ .name = "DMA2_Stream3", .index = 59, .description = null },
    .{ .name = "DMA2_Stream4", .index = 60, .description = null },
    .{ .name = "DMA2_Stream5", .index = 68, .description = null },
    .{ .name = "DMA2_Stream6", .index = 69, .description = null },
    .{ .name = "DMA2_Stream7", .index = 70, .description = null },
    .{ .name = "RNG", .index = 80, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
    .{ .name = "FMPI2C1_EV", .index = 95, .description = null },
    .{ .name = "FMPI2C1_ER", .index = 96, .description = null },
    .{ .name = "LPTIM1", .index = 97, .description = null },
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
    reserved33: [4]u32 = undefined,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK_TIM9: Handler = unhandled,
    TIM1_UP: Handler = unhandled,
    TIM1_TRG_COM_TIM11: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    reserved42: [3]u32 = undefined,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    SPI1: Handler = unhandled,
    reserved50: [1]u32 = undefined,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    reserved53: [1]u32 = undefined,
    EXTI15_10: Handler = unhandled,
    RTC_Alarm: Handler = unhandled,
    reserved56: [5]u32 = undefined,
    DMA1_Stream7: Handler = unhandled,
    reserved62: [2]u32 = undefined,
    TIM5: Handler = unhandled,
    reserved65: [3]u32 = undefined,
    TIM6_DAC: Handler = unhandled,
    reserved69: [1]u32 = undefined,
    DMA2_Stream0: Handler = unhandled,
    DMA2_Stream1: Handler = unhandled,
    DMA2_Stream2: Handler = unhandled,
    DMA2_Stream3: Handler = unhandled,
    DMA2_Stream4: Handler = unhandled,
    reserved75: [7]u32 = undefined,
    DMA2_Stream5: Handler = unhandled,
    DMA2_Stream6: Handler = unhandled,
    DMA2_Stream7: Handler = unhandled,
    reserved85: [9]u32 = undefined,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    reserved96: [13]u32 = undefined,
    FMPI2C1_EV: Handler = unhandled,
    FMPI2C1_ER: Handler = unhandled,
    LPTIM1: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7a10);
    /// General purpose 32-bit timers
    pub const TIM5: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000c00);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1a.LPTIM = @ptrFromInt(0x40002400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2f4.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v1.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v1.IWDG = @ptrFromInt(0x40003000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v2.USART = @ptrFromInt(0x40004400);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005800);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_f4.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40007400);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40010000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v2.USART = @ptrFromInt(0x40011000);
    /// Analog-to-digital converter
    pub const ADC1: *volatile types.peripherals.adc_v2.ADC = @ptrFromInt(0x40012000);
    /// ADC common registers
    pub const ADC1_COMMON: *volatile types.peripherals.adccommon_v2.ADC_COMMON = @ptrFromInt(0x40012300);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v1.SPI = @ptrFromInt(0x40013000);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_f4.SYSCFG = @ptrFromInt(0x40013800);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40013c00);
    /// 2-channel timers
    pub const TIM9: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40014000);
    /// 1-channel timers
    pub const TIM11: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40014800);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021c00);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v1.CRC = @ptrFromInt(0x40023000);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_f410.RCC = @ptrFromInt(0x40023800);
    /// FLASH
    pub const FLASH: *volatile types.peripherals.flash_f4.FLASH = @ptrFromInt(0x40023c00);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.dma_v2.DMA = @ptrFromInt(0x40026000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.dma_v2.DMA = @ptrFromInt(0x40026400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x40080000);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_f4.DBGMCU = @ptrFromInt(0xe0042000);
};
