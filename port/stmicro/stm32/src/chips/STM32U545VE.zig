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
    .{ .name = "PVD_PVM", .index = 1, .description = null },
    .{ .name = "RTC", .index = 2, .description = null },
    .{ .name = "RTC_S", .index = 3, .description = null },
    .{ .name = "TAMP", .index = 4, .description = null },
    .{ .name = "RAMCFG", .index = 5, .description = null },
    .{ .name = "FLASH", .index = 6, .description = null },
    .{ .name = "FLASH_S", .index = 7, .description = null },
    .{ .name = "GTZC", .index = 8, .description = null },
    .{ .name = "RCC", .index = 9, .description = null },
    .{ .name = "RCC_S", .index = 10, .description = null },
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
    .{ .name = "SAES", .index = 28, .description = null },
    .{ .name = "GPDMA1_Channel0", .index = 29, .description = null },
    .{ .name = "GPDMA1_Channel1", .index = 30, .description = null },
    .{ .name = "GPDMA1_Channel2", .index = 31, .description = null },
    .{ .name = "GPDMA1_Channel3", .index = 32, .description = null },
    .{ .name = "GPDMA1_Channel4", .index = 33, .description = null },
    .{ .name = "GPDMA1_Channel5", .index = 34, .description = null },
    .{ .name = "GPDMA1_Channel6", .index = 35, .description = null },
    .{ .name = "GPDMA1_Channel7", .index = 36, .description = null },
    .{ .name = "ADC1", .index = 37, .description = null },
    .{ .name = "DAC1", .index = 38, .description = null },
    .{ .name = "FDCAN1_IT0", .index = 39, .description = null },
    .{ .name = "FDCAN1_IT1", .index = 40, .description = null },
    .{ .name = "TIM1_BRK", .index = 41, .description = null },
    .{ .name = "TIM1_UP", .index = 42, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 43, .description = null },
    .{ .name = "TIM1_CC", .index = 44, .description = null },
    .{ .name = "TIM2", .index = 45, .description = null },
    .{ .name = "TIM3", .index = 46, .description = null },
    .{ .name = "TIM4", .index = 47, .description = null },
    .{ .name = "TIM5", .index = 48, .description = null },
    .{ .name = "TIM6", .index = 49, .description = null },
    .{ .name = "TIM7", .index = 50, .description = null },
    .{ .name = "TIM8_BRK", .index = 51, .description = null },
    .{ .name = "TIM8_UP", .index = 52, .description = null },
    .{ .name = "TIM8_TRG_COM", .index = 53, .description = null },
    .{ .name = "TIM8_CC", .index = 54, .description = null },
    .{ .name = "I2C1_EV", .index = 55, .description = null },
    .{ .name = "I2C1_ER", .index = 56, .description = null },
    .{ .name = "I2C2_EV", .index = 57, .description = null },
    .{ .name = "I2C2_ER", .index = 58, .description = null },
    .{ .name = "SPI1", .index = 59, .description = null },
    .{ .name = "SPI2", .index = 60, .description = null },
    .{ .name = "USART1", .index = 61, .description = null },
    .{ .name = "USART3", .index = 63, .description = null },
    .{ .name = "UART4", .index = 64, .description = null },
    .{ .name = "UART5", .index = 65, .description = null },
    .{ .name = "LPUART1", .index = 66, .description = null },
    .{ .name = "LPTIM1", .index = 67, .description = null },
    .{ .name = "LPTIM2", .index = 68, .description = null },
    .{ .name = "TIM15", .index = 69, .description = null },
    .{ .name = "TIM16", .index = 70, .description = null },
    .{ .name = "TIM17", .index = 71, .description = null },
    .{ .name = "COMP", .index = 72, .description = null },
    .{ .name = "USB", .index = 73, .description = null },
    .{ .name = "CRS", .index = 74, .description = null },
    .{ .name = "OCTOSPI1", .index = 76, .description = null },
    .{ .name = "PWR_S3WU", .index = 77, .description = null },
    .{ .name = "SDMMC1", .index = 78, .description = null },
    .{ .name = "GPDMA1_Channel8", .index = 80, .description = null },
    .{ .name = "GPDMA1_Channel9", .index = 81, .description = null },
    .{ .name = "GPDMA1_Channel10", .index = 82, .description = null },
    .{ .name = "GPDMA1_Channel11", .index = 83, .description = null },
    .{ .name = "GPDMA1_Channel12", .index = 84, .description = null },
    .{ .name = "GPDMA1_Channel13", .index = 85, .description = null },
    .{ .name = "GPDMA1_Channel14", .index = 86, .description = null },
    .{ .name = "GPDMA1_Channel15", .index = 87, .description = null },
    .{ .name = "I2C3_EV", .index = 88, .description = null },
    .{ .name = "I2C3_ER", .index = 89, .description = null },
    .{ .name = "SAI1", .index = 90, .description = null },
    .{ .name = "TSC", .index = 92, .description = null },
    .{ .name = "AES", .index = 93, .description = null },
    .{ .name = "RNG", .index = 94, .description = null },
    .{ .name = "FPU", .index = 95, .description = null },
    .{ .name = "HASH", .index = 96, .description = null },
    .{ .name = "PKA", .index = 97, .description = null },
    .{ .name = "LPTIM3", .index = 98, .description = null },
    .{ .name = "SPI3", .index = 99, .description = null },
    .{ .name = "I2C4_ER", .index = 100, .description = null },
    .{ .name = "I2C4_EV", .index = 101, .description = null },
    .{ .name = "MDF1_FLT0", .index = 102, .description = null },
    .{ .name = "MDF1_FLT1", .index = 103, .description = null },
    .{ .name = "ICACHE", .index = 107, .description = null },
    .{ .name = "OTFDEC1", .index = 108, .description = null },
    .{ .name = "LPTIM4", .index = 110, .description = null },
    .{ .name = "DCACHE1", .index = 111, .description = null },
    .{ .name = "ADF1", .index = 112, .description = null },
    .{ .name = "ADC4", .index = 113, .description = null },
    .{ .name = "LPDMA1_Channel0", .index = 114, .description = null },
    .{ .name = "LPDMA1_Channel1", .index = 115, .description = null },
    .{ .name = "LPDMA1_Channel2", .index = 116, .description = null },
    .{ .name = "LPDMA1_Channel3", .index = 117, .description = null },
    .{ .name = "DCMI_PSSI", .index = 119, .description = null },
    .{ .name = "CORDIC", .index = 123, .description = null },
    .{ .name = "FMAC", .index = 124, .description = null },
    .{ .name = "LSECSSD", .index = 125, .description = null },
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
    PVD_PVM: Handler = unhandled,
    RTC: Handler = unhandled,
    RTC_S: Handler = unhandled,
    TAMP: Handler = unhandled,
    RAMCFG: Handler = unhandled,
    FLASH: Handler = unhandled,
    FLASH_S: Handler = unhandled,
    GTZC: Handler = unhandled,
    RCC: Handler = unhandled,
    RCC_S: Handler = unhandled,
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
    SAES: Handler = unhandled,
    GPDMA1_Channel0: Handler = unhandled,
    GPDMA1_Channel1: Handler = unhandled,
    GPDMA1_Channel2: Handler = unhandled,
    GPDMA1_Channel3: Handler = unhandled,
    GPDMA1_Channel4: Handler = unhandled,
    GPDMA1_Channel5: Handler = unhandled,
    GPDMA1_Channel6: Handler = unhandled,
    GPDMA1_Channel7: Handler = unhandled,
    ADC1: Handler = unhandled,
    DAC1: Handler = unhandled,
    FDCAN1_IT0: Handler = unhandled,
    FDCAN1_IT1: Handler = unhandled,
    TIM1_BRK: Handler = unhandled,
    TIM1_UP: Handler = unhandled,
    TIM1_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    TIM3: Handler = unhandled,
    TIM4: Handler = unhandled,
    TIM5: Handler = unhandled,
    TIM6: Handler = unhandled,
    TIM7: Handler = unhandled,
    TIM8_BRK: Handler = unhandled,
    TIM8_UP: Handler = unhandled,
    TIM8_TRG_COM: Handler = unhandled,
    TIM8_CC: Handler = unhandled,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    USART1: Handler = unhandled,
    reserved76: [1]u32 = undefined,
    USART3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    LPUART1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    COMP: Handler = unhandled,
    USB: Handler = unhandled,
    CRS: Handler = unhandled,
    reserved89: [1]u32 = undefined,
    OCTOSPI1: Handler = unhandled,
    PWR_S3WU: Handler = unhandled,
    SDMMC1: Handler = unhandled,
    reserved93: [1]u32 = undefined,
    GPDMA1_Channel8: Handler = unhandled,
    GPDMA1_Channel9: Handler = unhandled,
    GPDMA1_Channel10: Handler = unhandled,
    GPDMA1_Channel11: Handler = unhandled,
    GPDMA1_Channel12: Handler = unhandled,
    GPDMA1_Channel13: Handler = unhandled,
    GPDMA1_Channel14: Handler = unhandled,
    GPDMA1_Channel15: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    SAI1: Handler = unhandled,
    reserved105: [1]u32 = undefined,
    TSC: Handler = unhandled,
    AES: Handler = unhandled,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    HASH: Handler = unhandled,
    PKA: Handler = unhandled,
    LPTIM3: Handler = unhandled,
    SPI3: Handler = unhandled,
    I2C4_ER: Handler = unhandled,
    I2C4_EV: Handler = unhandled,
    MDF1_FLT0: Handler = unhandled,
    MDF1_FLT1: Handler = unhandled,
    reserved118: [3]u32 = undefined,
    ICACHE: Handler = unhandled,
    OTFDEC1: Handler = unhandled,
    reserved123: [1]u32 = undefined,
    LPTIM4: Handler = unhandled,
    DCACHE1: Handler = unhandled,
    ADF1: Handler = unhandled,
    ADC4: Handler = unhandled,
    LPDMA1_Channel0: Handler = unhandled,
    LPDMA1_Channel1: Handler = unhandled,
    LPDMA1_Channel2: Handler = unhandled,
    LPDMA1_Channel3: Handler = unhandled,
    reserved132: [1]u32 = undefined,
    DCMI_PSSI: Handler = unhandled,
    reserved134: [3]u32 = undefined,
    CORDIC: Handler = unhandled,
    FMAC: Handler = unhandled,
    LSECSSD: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0xbfa0700);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 32-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000400);
    /// General purpose 32-bit timers
    pub const TIM4: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000800);
    /// General purpose 32-bit timers
    pub const TIM5: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000c00);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v5.SPI = @ptrFromInt(0x40003800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART4: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART5: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40005000);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40006000);
    /// Inter-integrated circuit
    pub const I2C4: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40008400);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x40009400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x4000a400);
    /// FDCAN Message RAM
    pub const FDCANRAM1: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000ac00);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v5.SPI = @ptrFromInt(0x40013000);
    /// Advanced Control timers
    pub const TIM8: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40013400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v2.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v4_2pdm.SAI = @ptrFromInt(0x40015400);
    /// Universal serial bus full-speed host/device interface
    pub const USB: *volatile types.peripherals.usb_v4.USB = @ptrFromInt(0x40016000);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_32_2048.USBRAM = @ptrFromInt(0x40016400);
    /// GPDMA
    pub const GPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40020000);
    /// CORDIC co-processor.
    pub const CORDIC: *volatile types.peripherals.cordic_v1.CORDIC = @ptrFromInt(0x40021000);
    /// Filter math accelerator
    pub const FMAC: *volatile types.peripherals.fmac_v1.FMAC = @ptrFromInt(0x40021400);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_u5.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Touch sensing controller.
    pub const TSC: *volatile types.peripherals.tsc_v3.TSC = @ptrFromInt(0x40024000);
    /// Instruction Cache Control Registers.
    pub const ICACHE: *volatile types.peripherals.icache_v1_3crr.ICACHE = @ptrFromInt(0x40030400);
    /// Data cache.
    pub const DCACHE1: *volatile types.peripherals.dcache_v1.DCACHE = @ptrFromInt(0x40031400);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021000);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021c00);
    /// ADC.
    pub const ADC1: *volatile types.peripherals.adc_u5.ADC = @ptrFromInt(0x42028000);
    /// Digital camera interface
    pub const DCMI: *volatile types.peripherals.dcmi_v1.DCMI = @ptrFromInt(0x4202c000);
    /// Parallel synchronous slave interface.
    pub const PSSI: *volatile types.peripherals.pssi_v1.PSSI = @ptrFromInt(0x4202c400);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v3a.AES = @ptrFromInt(0x420c0000);
    /// Hash processor.
    pub const HASH: *volatile types.peripherals.hash_v4.HASH = @ptrFromInt(0x420c0400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v3.RNG = @ptrFromInt(0x420c0800);
    /// Secure advanced encryption standard hardware accelerator.
    pub const SAES: *volatile types.peripherals.saes_v1b.SAES = @ptrFromInt(0x420c0c00);
    /// Public key accelerator.
    pub const PKA: *volatile types.peripherals.pka_v1b.PKA = @ptrFromInt(0x420c2000);
    /// On-The-Fly Decryption engine.
    pub const OTFDEC1: *volatile types.peripherals.otfdec_v1.OTFDEC = @ptrFromInt(0x420c5000);
    /// SDMMC
    pub const SDMMC1: *volatile types.peripherals.sdmmc_v2.SDMMC = @ptrFromInt(0x420c8000);
    /// OctoSPI
    pub const OCTOSPI1: *volatile types.peripherals.octospi_v1.OCTOSPI = @ptrFromInt(0x420d1400);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_u5.SYSCFG = @ptrFromInt(0x46000400);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v5.SPI = @ptrFromInt(0x46002000);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x46002400);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x46002800);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x46004400);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x46004800);
    /// Low power timer with Output Compare
    pub const LPTIM4: *volatile types.peripherals.lptim_v2a.LPTIM_BASIC = @ptrFromInt(0x46004c00);
    /// Comparator.
    pub const COMP1: *volatile types.peripherals.comp_u5.COMP = @ptrFromInt(0x46005400);
    /// Voltage reference buffer.
    pub const VREFBUF: *volatile types.peripherals.vrefbuf_v2a1.VREFBUF = @ptrFromInt(0x46007400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3u5.RTC = @ptrFromInt(0x46007800);
    /// Tamper and backup registers
    pub const TAMP: *volatile types.peripherals.tamp_u5.TAMP = @ptrFromInt(0x46007c00);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_u5.PWR = @ptrFromInt(0x46020800);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_u5.RCC = @ptrFromInt(0x46020c00);
    /// ADC.
    pub const ADC4: *volatile types.peripherals.adc_u5.ADC = @ptrFromInt(0x46021000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v6.DAC = @ptrFromInt(0x46021800);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_u5.EXTI = @ptrFromInt(0x46022000);
    /// ADF.
    pub const ADF1: *volatile types.peripherals.adf_v1.ADF = @ptrFromInt(0x46024000);
    /// LPDMA
    pub const LPDMA1: *volatile types.peripherals.lpdma_v1.LPDMA = @ptrFromInt(0x46025000);
    /// MCU debug component
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_u5.DBGMCU = @ptrFromInt(0xe0044000);
};
