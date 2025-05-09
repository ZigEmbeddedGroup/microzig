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
    .{ .name = "TAMP_STAMP_LSECSS_SSRU", .index = 2, .description = null },
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
    .{ .name = "ADC", .index = 18, .description = null },
    .{ .name = "DAC", .index = 19, .description = null },
    .{ .name = "C2SEV_PWR_C2H", .index = 20, .description = null },
    .{ .name = "COMP", .index = 21, .description = null },
    .{ .name = "EXTI9_5", .index = 22, .description = null },
    .{ .name = "TIM1_BRK", .index = 23, .description = null },
    .{ .name = "TIM1_UP", .index = 24, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 25, .description = null },
    .{ .name = "TIM1_CC", .index = 26, .description = null },
    .{ .name = "TIM2", .index = 27, .description = null },
    .{ .name = "TIM16", .index = 28, .description = null },
    .{ .name = "TIM17", .index = 29, .description = null },
    .{ .name = "I2C1_EV", .index = 30, .description = null },
    .{ .name = "I2C1_ER", .index = 31, .description = null },
    .{ .name = "I2C2_EV", .index = 32, .description = null },
    .{ .name = "I2C2_ER", .index = 33, .description = null },
    .{ .name = "SPI1", .index = 34, .description = null },
    .{ .name = "SPI2", .index = 35, .description = null },
    .{ .name = "USART1", .index = 36, .description = null },
    .{ .name = "USART2", .index = 37, .description = null },
    .{ .name = "LPUART1", .index = 38, .description = null },
    .{ .name = "LPTIM1", .index = 39, .description = null },
    .{ .name = "LPTIM2", .index = 40, .description = null },
    .{ .name = "EXTI15_10", .index = 41, .description = null },
    .{ .name = "RTC_Alarm", .index = 42, .description = null },
    .{ .name = "LPTIM3", .index = 43, .description = null },
    .{ .name = "SUBGHZSPI", .index = 44, .description = null },
    .{ .name = "IPCC_C1_RX", .index = 45, .description = null },
    .{ .name = "IPCC_C1_TX", .index = 46, .description = null },
    .{ .name = "HSEM", .index = 47, .description = null },
    .{ .name = "I2C3_EV", .index = 48, .description = null },
    .{ .name = "I2C3_ER", .index = 49, .description = null },
    .{ .name = "SUBGHZ_Radio", .index = 50, .description = null },
    .{ .name = "AES", .index = 51, .description = null },
    .{ .name = "RNG", .index = 52, .description = null },
    .{ .name = "PKA", .index = 53, .description = null },
    .{ .name = "DMA2_Channel1", .index = 54, .description = null },
    .{ .name = "DMA2_Channel2", .index = 55, .description = null },
    .{ .name = "DMA2_Channel3", .index = 56, .description = null },
    .{ .name = "DMA2_Channel4", .index = 57, .description = null },
    .{ .name = "DMA2_Channel5", .index = 58, .description = null },
    .{ .name = "DMA2_Channel6", .index = 59, .description = null },
    .{ .name = "DMA2_Channel7", .index = 60, .description = null },
    .{ .name = "DMAMUX1_OVR", .index = 61, .description = null },
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
    TAMP_STAMP_LSECSS_SSRU: Handler = unhandled,
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
    ADC: Handler = unhandled,
    DAC: Handler = unhandled,
    C2SEV_PWR_C2H: Handler = unhandled,
    COMP: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK: Handler = unhandled,
    TIM1_UP: Handler = unhandled,
    TIM1_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    LPUART1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    EXTI15_10: Handler = unhandled,
    RTC_Alarm: Handler = unhandled,
    LPTIM3: Handler = unhandled,
    SUBGHZSPI: Handler = unhandled,
    IPCC_C1_RX: Handler = unhandled,
    IPCC_C1_TX: Handler = unhandled,
    HSEM: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    SUBGHZ_Radio: Handler = unhandled,
    AES: Handler = unhandled,
    RNG: Handler = unhandled,
    PKA: Handler = unhandled,
    DMA2_Channel1: Handler = unhandled,
    DMA2_Channel2: Handler = unhandled,
    DMA2_Channel3: Handler = unhandled,
    DMA2_Channel4: Handler = unhandled,
    DMA2_Channel5: Handler = unhandled,
    DMA2_Channel6: Handler = unhandled,
    DMA2_Channel7: Handler = unhandled,
    DMAMUX1_OVR: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7590);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
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
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005c00);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v4.DAC = @ptrFromInt(0x40007400);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1c.LPTIM = @ptrFromInt(0x40007c00);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008000);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v1c.LPTIM = @ptrFromInt(0x40009400);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v1c.LPTIM = @ptrFromInt(0x40009800);
    /// Tamper and backup registers
    pub const TAMP: *volatile types.peripherals.tamp_wl.TAMP = @ptrFromInt(0x4000b000);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_wl5.SYSCFG = @ptrFromInt(0x40010000);
    /// Voltage reference buffer.
    pub const VREFBUF: *volatile types.peripherals.vrefbuf_v1.VREFBUF = @ptrFromInt(0x40010030);
    /// Comparator.
    pub const COMP1: *volatile types.peripherals.comp_v3.COMP = @ptrFromInt(0x40010200);
    /// Comparator.
    pub const COMP2: *volatile types.peripherals.comp_v3.COMP = @ptrFromInt(0x40010204);
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
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020400);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001c00);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_wl5.RCC = @ptrFromInt(0x58000000);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_wl5.PWR = @ptrFromInt(0x58000400);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_w.EXTI = @ptrFromInt(0x58000800);
    /// IPCC
    pub const IPCC: *volatile types.peripherals.ipcc_v1.IPCC = @ptrFromInt(0x58000c00);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v2.RNG = @ptrFromInt(0x58001000);
    /// Hardware semaphore.
    pub const HSEM: *volatile types.peripherals.hsem_v3.HSEM = @ptrFromInt(0x58001400);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v2.AES = @ptrFromInt(0x58001800);
    /// Public key accelerator.
    pub const PKA: *volatile types.peripherals.pka_v1c.PKA = @ptrFromInt(0x58002000);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_wl.FLASH = @ptrFromInt(0x58004000);
    /// Serial peripheral interface
    pub const SUBGHZSPI: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x58010000);
    /// Microcontroller Debug Unit
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_wl.DBGMCU = @ptrFromInt(0xe0042000);
};
