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
    .{ .name = "SecureFault", .index = -9, .description = null },
    .{ .name = "SVCall", .index = -5, .description = null },
    .{ .name = "DebugMonitor", .index = -4, .description = null },
    .{ .name = "PendSV", .index = -2, .description = null },
    .{ .name = "SysTick", .index = -1, .description = null },
    .{ .name = "WWDG", .index = 0, .description = null },
    .{ .name = "PVD", .index = 1, .description = null },
    .{ .name = "RTC", .index = 2, .description = null },
    .{ .name = "TAMP", .index = 4, .description = null },
    .{ .name = "RAMCFG", .index = 5, .description = null },
    .{ .name = "FLASH", .index = 6, .description = null },
    .{ .name = "RCC", .index = 9, .description = null },
    .{ .name = "EXTI0", .index = 11, .description = null },
    .{ .name = "EXTI1", .index = 12, .description = null },
    .{ .name = "EXTI2", .index = 13, .description = null },
    .{ .name = "EXTI3", .index = 14, .description = null },
    .{ .name = "EXTI4", .index = 15, .description = null },
    .{ .name = "EXTI5", .index = 16, .description = null },
    .{ .name = "EXTI6", .index = 17, .description = null },
    .{ .name = "EXTI7", .index = 18, .description = null },
    .{ .name = "EXTI8", .index = 19, .description = null },
    .{ .name = "EXTI9", .index = 20, .description = null },
    .{ .name = "EXTI10", .index = 21, .description = null },
    .{ .name = "EXTI11", .index = 22, .description = null },
    .{ .name = "EXTI12", .index = 23, .description = null },
    .{ .name = "EXTI13", .index = 24, .description = null },
    .{ .name = "EXTI14", .index = 25, .description = null },
    .{ .name = "EXTI15", .index = 26, .description = null },
    .{ .name = "IWDG", .index = 27, .description = null },
    .{ .name = "GPDMA1_Channel0", .index = 29, .description = null },
    .{ .name = "GPDMA1_Channel1", .index = 30, .description = null },
    .{ .name = "GPDMA1_Channel2", .index = 31, .description = null },
    .{ .name = "GPDMA1_Channel3", .index = 32, .description = null },
    .{ .name = "GPDMA1_Channel4", .index = 33, .description = null },
    .{ .name = "GPDMA1_Channel5", .index = 34, .description = null },
    .{ .name = "GPDMA1_Channel6", .index = 35, .description = null },
    .{ .name = "GPDMA1_Channel7", .index = 36, .description = null },
    .{ .name = "TIM1_BRK", .index = 37, .description = null },
    .{ .name = "TIM1_UP", .index = 38, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 39, .description = null },
    .{ .name = "TIM1_CC", .index = 40, .description = null },
    .{ .name = "TIM2", .index = 41, .description = null },
    .{ .name = "USART1", .index = 46, .description = null },
    .{ .name = "LPUART1", .index = 48, .description = null },
    .{ .name = "LPTIM1", .index = 49, .description = null },
    .{ .name = "TIM16", .index = 51, .description = null },
    .{ .name = "I2C3_EV", .index = 54, .description = null },
    .{ .name = "I2C3_ER", .index = 55, .description = null },
    .{ .name = "TSC", .index = 57, .description = null },
    .{ .name = "AES", .index = 58, .description = null },
    .{ .name = "RNG", .index = 59, .description = null },
    .{ .name = "FPU", .index = 60, .description = null },
    .{ .name = "HASH", .index = 61, .description = null },
    .{ .name = "PKA", .index = 62, .description = null },
    .{ .name = "SPI3", .index = 63, .description = null },
    .{ .name = "ICACHE", .index = 64, .description = null },
    .{ .name = "ADC4", .index = 65, .description = null },
    .{ .name = "RADIO", .index = 66, .description = null },
    .{ .name = "WKUP", .index = 67, .description = null },
    .{ .name = "HSEM", .index = 68, .description = null },
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
    SecureFault: Handler = unhandled,
    reserved6: [3]u32 = undefined,
    SVCall: Handler = unhandled,
    DebugMonitor: Handler = unhandled,
    reserved11: [1]u32 = undefined,
    PendSV: Handler = unhandled,
    SysTick: Handler = unhandled,
    WWDG: Handler = unhandled,
    PVD: Handler = unhandled,
    RTC: Handler = unhandled,
    reserved17: [1]u32 = undefined,
    TAMP: Handler = unhandled,
    RAMCFG: Handler = unhandled,
    FLASH: Handler = unhandled,
    reserved21: [2]u32 = undefined,
    RCC: Handler = unhandled,
    reserved24: [1]u32 = undefined,
    EXTI0: Handler = unhandled,
    EXTI1: Handler = unhandled,
    EXTI2: Handler = unhandled,
    EXTI3: Handler = unhandled,
    EXTI4: Handler = unhandled,
    EXTI5: Handler = unhandled,
    EXTI6: Handler = unhandled,
    EXTI7: Handler = unhandled,
    EXTI8: Handler = unhandled,
    EXTI9: Handler = unhandled,
    EXTI10: Handler = unhandled,
    EXTI11: Handler = unhandled,
    EXTI12: Handler = unhandled,
    EXTI13: Handler = unhandled,
    EXTI14: Handler = unhandled,
    EXTI15: Handler = unhandled,
    IWDG: Handler = unhandled,
    reserved42: [1]u32 = undefined,
    GPDMA1_Channel0: Handler = unhandled,
    GPDMA1_Channel1: Handler = unhandled,
    GPDMA1_Channel2: Handler = unhandled,
    GPDMA1_Channel3: Handler = unhandled,
    GPDMA1_Channel4: Handler = unhandled,
    GPDMA1_Channel5: Handler = unhandled,
    GPDMA1_Channel6: Handler = unhandled,
    GPDMA1_Channel7: Handler = unhandled,
    TIM1_BRK: Handler = unhandled,
    TIM1_UP: Handler = unhandled,
    TIM1_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    reserved56: [4]u32 = undefined,
    USART1: Handler = unhandled,
    reserved61: [1]u32 = undefined,
    LPUART1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    reserved64: [1]u32 = undefined,
    TIM16: Handler = unhandled,
    reserved66: [2]u32 = undefined,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    reserved70: [1]u32 = undefined,
    TSC: Handler = unhandled,
    AES: Handler = unhandled,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    HASH: Handler = unhandled,
    PKA: Handler = unhandled,
    SPI3: Handler = unhandled,
    ICACHE: Handler = unhandled,
    ADC4: Handler = unhandled,
    RADIO: Handler = unhandled,
    WKUP: Handler = unhandled,
    HSEM: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0xbf90700);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000000);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x40003000);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// GPDMA
    pub const GPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40020000);
    /// Embedded memory
    pub const FLASH: *volatile types.peripherals.flash_wba.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Touch sensing controller.
    pub const TSC: *volatile types.peripherals.tsc_v1.TSC = @ptrFromInt(0x40024000);
    /// Instruction Cache Control Registers.
    pub const ICACHE: *volatile types.peripherals.icache_v1_4crr.ICACHE = @ptrFromInt(0x40030400);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021c00);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v3b.AES = @ptrFromInt(0x420c0000);
    /// Hash processor.
    pub const HASH: *volatile types.peripherals.hash_v4.HASH = @ptrFromInt(0x420c0400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x420c0800);
    /// Public key accelerator.
    pub const PKA: *volatile types.peripherals.pka_v1a.PKA = @ptrFromInt(0x420c2000);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_wba.SYSCFG = @ptrFromInt(0x46000400);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v5.SPI = @ptrFromInt(0x46002000);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x46002400);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x46002800);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x46004400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3u5.RTC = @ptrFromInt(0x46007800);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_wba.PWR = @ptrFromInt(0x46020800);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_wba.RCC = @ptrFromInt(0x46020c00);
    /// Analog-to-Digital Converter
    pub const ADC4_COMMON: *volatile types.peripherals.adccommon_v3.ADC_COMMON = @ptrFromInt(0x46021308);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_l5.EXTI = @ptrFromInt(0x46022000);
    /// Microcontroller debug unit
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_wba.DBGMCU = @ptrFromInt(0xe0044000);
};
