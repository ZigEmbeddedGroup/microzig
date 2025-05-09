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
    .{ .name = "SecureFault", .index = -9, .description = null },
    .{ .name = "SVCall", .index = -5, .description = null },
    .{ .name = "DebugMonitor", .index = -4, .description = null },
    .{ .name = "PendSV", .index = -2, .description = null },
    .{ .name = "SysTick", .index = -1, .description = null },
    .{ .name = "WWDG", .index = 0, .description = null },
    .{ .name = "PVD_AVD", .index = 1, .description = null },
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
    .{ .name = "GPDMA1_Channel0", .index = 27, .description = null },
    .{ .name = "GPDMA1_Channel1", .index = 28, .description = null },
    .{ .name = "GPDMA1_Channel2", .index = 29, .description = null },
    .{ .name = "GPDMA1_Channel3", .index = 30, .description = null },
    .{ .name = "GPDMA1_Channel4", .index = 31, .description = null },
    .{ .name = "GPDMA1_Channel5", .index = 32, .description = null },
    .{ .name = "GPDMA1_Channel6", .index = 33, .description = null },
    .{ .name = "GPDMA1_Channel7", .index = 34, .description = null },
    .{ .name = "IWDG", .index = 35, .description = null },
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
    .{ .name = "TIM6", .index = 49, .description = null },
    .{ .name = "TIM7", .index = 50, .description = null },
    .{ .name = "I2C1_EV", .index = 51, .description = null },
    .{ .name = "I2C1_ER", .index = 52, .description = null },
    .{ .name = "I2C2_EV", .index = 53, .description = null },
    .{ .name = "I2C2_ER", .index = 54, .description = null },
    .{ .name = "SPI1", .index = 55, .description = null },
    .{ .name = "SPI2", .index = 56, .description = null },
    .{ .name = "SPI3", .index = 57, .description = null },
    .{ .name = "USART1", .index = 58, .description = null },
    .{ .name = "USART2", .index = 59, .description = null },
    .{ .name = "USART3", .index = 60, .description = null },
    .{ .name = "LPUART1", .index = 63, .description = null },
    .{ .name = "LPTIM1", .index = 64, .description = null },
    .{ .name = "LPTIM2", .index = 70, .description = null },
    .{ .name = "USB_DRD_FS", .index = 74, .description = null },
    .{ .name = "CRS", .index = 75, .description = null },
    .{ .name = "GPDMA2_Channel0", .index = 90, .description = null },
    .{ .name = "GPDMA2_Channel1", .index = 91, .description = null },
    .{ .name = "GPDMA2_Channel2", .index = 92, .description = null },
    .{ .name = "GPDMA2_Channel3", .index = 93, .description = null },
    .{ .name = "GPDMA2_Channel4", .index = 94, .description = null },
    .{ .name = "GPDMA2_Channel5", .index = 95, .description = null },
    .{ .name = "GPDMA2_Channel6", .index = 96, .description = null },
    .{ .name = "GPDMA2_Channel7", .index = 97, .description = null },
    .{ .name = "FPU", .index = 103, .description = null },
    .{ .name = "ICACHE", .index = 104, .description = null },
    .{ .name = "DTS", .index = 113, .description = null },
    .{ .name = "RNG", .index = 114, .description = null },
    .{ .name = "HASH", .index = 117, .description = null },
    .{ .name = "I3C1_EV", .index = 123, .description = null },
    .{ .name = "I3C1_ER", .index = 124, .description = null },
    .{ .name = "I3C2_EV", .index = 131, .description = null },
    .{ .name = "I3C2_ER", .index = 132, .description = null },
    .{ .name = "COMP1", .index = 133, .description = null },
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
    PVD_AVD: Handler = unhandled,
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
    GPDMA1_Channel0: Handler = unhandled,
    GPDMA1_Channel1: Handler = unhandled,
    GPDMA1_Channel2: Handler = unhandled,
    GPDMA1_Channel3: Handler = unhandled,
    GPDMA1_Channel4: Handler = unhandled,
    GPDMA1_Channel5: Handler = unhandled,
    GPDMA1_Channel6: Handler = unhandled,
    GPDMA1_Channel7: Handler = unhandled,
    IWDG: Handler = unhandled,
    reserved50: [1]u32 = undefined,
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
    reserved61: [2]u32 = undefined,
    TIM6: Handler = unhandled,
    TIM7: Handler = unhandled,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    SPI3: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    USART3: Handler = unhandled,
    reserved75: [2]u32 = undefined,
    LPUART1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    reserved79: [5]u32 = undefined,
    LPTIM2: Handler = unhandled,
    reserved85: [3]u32 = undefined,
    USB_DRD_FS: Handler = unhandled,
    CRS: Handler = unhandled,
    reserved90: [14]u32 = undefined,
    GPDMA2_Channel0: Handler = unhandled,
    GPDMA2_Channel1: Handler = unhandled,
    GPDMA2_Channel2: Handler = unhandled,
    GPDMA2_Channel3: Handler = unhandled,
    GPDMA2_Channel4: Handler = unhandled,
    GPDMA2_Channel5: Handler = unhandled,
    GPDMA2_Channel6: Handler = unhandled,
    GPDMA2_Channel7: Handler = unhandled,
    reserved112: [5]u32 = undefined,
    FPU: Handler = unhandled,
    ICACHE: Handler = unhandled,
    reserved119: [8]u32 = undefined,
    DTS: Handler = unhandled,
    RNG: Handler = unhandled,
    reserved129: [2]u32 = undefined,
    HASH: Handler = unhandled,
    reserved132: [5]u32 = undefined,
    I3C1_EV: Handler = unhandled,
    I3C1_ER: Handler = unhandled,
    reserved139: [6]u32 = undefined,
    I3C2_EV: Handler = unhandled,
    I3C2_ER: Handler = unhandled,
    COMP1: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x8fff800);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v2.TIM_GP16 = @ptrFromInt(0x40000400);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x40003000);
    /// Operational amplifiers.
    pub const OPAMP1: *volatile types.peripherals.opamp_h_v2.OPAMP = @ptrFromInt(0x40003400);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40003c00);
    /// Comparator.
    pub const COMP1: *volatile types.peripherals.comp_h5.COMP = @ptrFromInt(0x40004000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004800);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005800);
    /// Improved inter-integrated circuit.
    pub const I3C1: *volatile types.peripherals.i3c_v1.I3C = @ptrFromInt(0x40005c00);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40006000);
    /// Digital temperature sensor.
    pub const DTS: *volatile types.peripherals.dts_v1.DTS = @ptrFromInt(0x40008c00);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x40009400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x4000a400);
    /// FDCAN Message RAM
    pub const FDCANRAM1: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000ac00);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// Universal serial bus full-speed host/device interface
    pub const USB: *volatile types.peripherals.usb_v4.USB = @ptrFromInt(0x40016000);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_32_2048.USBRAM = @ptrFromInt(0x40016400);
    /// GPDMA
    pub const GPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40020000);
    /// GPDMA
    pub const GPDMA2: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40021000);
    /// FLASH address block description
    pub const FLASH: *volatile types.peripherals.flash_h50.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Instruction Cache Control Registers.
    pub const ICACHE: *volatile types.peripherals.icache_v1_0crr.ICACHE = @ptrFromInt(0x40030400);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42020c00);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021c00);
    /// Analog to digital converter
    pub const ADC1: *volatile types.peripherals.adc_h5.ADC = @ptrFromInt(0x42028000);
    /// ADC common registers
    pub const ADC12_COMMON: *volatile types.peripherals.adccommon_h50.ADC_COMMON = @ptrFromInt(0x42028300);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v6.DAC = @ptrFromInt(0x42028400);
    /// Hash processor.
    pub const HASH: *volatile types.peripherals.hash_v3.HASH = @ptrFromInt(0x420c0400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v3.RNG = @ptrFromInt(0x420c0800);
    /// System configuration, boot and security
    pub const SYSCFG: *volatile types.peripherals.syscfg_h50.SYSCFG = @ptrFromInt(0x44000400);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x44002400);
    /// Improved inter-integrated circuit.
    pub const I3C2: *volatile types.peripherals.i3c_v1.I3C = @ptrFromInt(0x44003000);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x44004400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3u5.RTC = @ptrFromInt(0x44007800);
    /// Tamper and backup.
    pub const TAMP: *volatile types.peripherals.tamp_h5.TAMP = @ptrFromInt(0x44007c00);
    /// Power control.
    pub const PWR: *volatile types.peripherals.pwr_h50.PWR = @ptrFromInt(0x44020800);
    /// Reset and clock controller
    pub const RCC: *volatile types.peripherals.rcc_h50.RCC = @ptrFromInt(0x44020c00);
    /// Extended interrupt and event controller
    pub const EXTI: *volatile types.peripherals.exti_h50.EXTI = @ptrFromInt(0x44022000);
    /// Microcontroller debug unit.
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_h5.DBGMCU = @ptrFromInt(0x44024000);
};
