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
    .{ .name = "RTC", .index = 2, .description = null },
    .{ .name = "FLASH", .index = 3, .description = null },
    .{ .name = "RCC", .index = 4, .description = null },
    .{ .name = "EXTI0_1", .index = 5, .description = null },
    .{ .name = "EXTI2_3", .index = 6, .description = null },
    .{ .name = "EXTI4_15", .index = 7, .description = null },
    .{ .name = "DMA1_Channel1", .index = 9, .description = null },
    .{ .name = "DMA1_Channel2_3", .index = 10, .description = null },
    .{ .name = "DMAMUX1", .index = 11, .description = null },
    .{ .name = "ADC1", .index = 12, .description = null },
    .{ .name = "TIM1_BRK_UP_TRG_COM", .index = 13, .description = null },
    .{ .name = "TIM1_CC", .index = 14, .description = null },
    .{ .name = "TIM3", .index = 16, .description = null },
    .{ .name = "TIM14", .index = 19, .description = null },
    .{ .name = "TIM16", .index = 21, .description = null },
    .{ .name = "TIM17", .index = 22, .description = null },
    .{ .name = "I2C1", .index = 23, .description = null },
    .{ .name = "SPI1", .index = 25, .description = null },
    .{ .name = "USART1", .index = 27, .description = null },
    .{ .name = "USART2", .index = 28, .description = null },
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
    reserved15: [1]u32 = undefined,
    RTC: Handler = unhandled,
    FLASH: Handler = unhandled,
    RCC: Handler = unhandled,
    EXTI0_1: Handler = unhandled,
    EXTI2_3: Handler = unhandled,
    EXTI4_15: Handler = unhandled,
    reserved22: [1]u32 = undefined,
    DMA1_Channel1: Handler = unhandled,
    DMA1_Channel2_3: Handler = unhandled,
    DMAMUX1: Handler = unhandled,
    ADC1: Handler = unhandled,
    TIM1_BRK_UP_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    reserved29: [1]u32 = undefined,
    TIM3: Handler = unhandled,
    reserved31: [2]u32 = undefined,
    TIM14: Handler = unhandled,
    reserved34: [1]u32 = undefined,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    I2C1: Handler = unhandled,
    reserved38: [1]u32 = undefined,
    SPI1: Handler = unhandled,
    reserved40: [1]u32 = undefined,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7550);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000400);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x40003000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004400);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// PWR address block description
    pub const PWR: *volatile types.peripherals.pwr_c0.PWR = @ptrFromInt(0x40007000);
    /// register block
    pub const SYSCFG: *volatile types.peripherals.syscfg_c0.SYSCFG = @ptrFromInt(0x40010000);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_c0.DBGMCU = @ptrFromInt(0x40015800);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// RCC address block description
    pub const RCC: *volatile types.peripherals.rcc_c0.RCC = @ptrFromInt(0x40021000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_c0.EXTI = @ptrFromInt(0x40021800);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_c0.FLASH = @ptrFromInt(0x40022000);
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
