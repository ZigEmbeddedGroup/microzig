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
    .{ .name = "WWDG_IWDG", .index = 0, .description = null },
    .{ .name = "PVD_PVM", .index = 1, .description = null },
    .{ .name = "RTC_TAMP", .index = 2, .description = null },
    .{ .name = "FLASH_ECC", .index = 3, .description = null },
    .{ .name = "RCC_CRS", .index = 4, .description = null },
    .{ .name = "EXTI0_1", .index = 5, .description = null },
    .{ .name = "EXTI2_3", .index = 6, .description = null },
    .{ .name = "EXTI4_15", .index = 7, .description = null },
    .{ .name = "USB_DRD_FS", .index = 8, .description = null },
    .{ .name = "DMA1_Channel1", .index = 9, .description = null },
    .{ .name = "DMA1_Channel2_3", .index = 10, .description = null },
    .{ .name = "DMA1_Ch4_7_DMA2_Ch1_5_DMAMUX_OVR", .index = 11, .description = null },
    .{ .name = "ADC_COMP1_2", .index = 12, .description = null },
    .{ .name = "TIM1_BRK_UP_TRG_COM", .index = 13, .description = null },
    .{ .name = "TIM1_CC", .index = 14, .description = null },
    .{ .name = "TIM2", .index = 15, .description = null },
    .{ .name = "TIM3", .index = 16, .description = null },
    .{ .name = "TIM6_DAC_LPTIM1", .index = 17, .description = null },
    .{ .name = "TIM7_LPTIM2", .index = 18, .description = null },
    .{ .name = "TIM15_LPTIM3", .index = 19, .description = null },
    .{ .name = "TIM16", .index = 20, .description = null },
    .{ .name = "TSC", .index = 21, .description = null },
    .{ .name = "LCD", .index = 22, .description = null },
    .{ .name = "I2C1", .index = 23, .description = null },
    .{ .name = "I2C2_3_4", .index = 24, .description = null },
    .{ .name = "SPI1", .index = 25, .description = null },
    .{ .name = "SPI2_3", .index = 26, .description = null },
    .{ .name = "USART1", .index = 27, .description = null },
    .{ .name = "USART2_LPUART2", .index = 28, .description = null },
    .{ .name = "USART3_LPUART1", .index = 29, .description = null },
    .{ .name = "USART4_LPUART3", .index = 30, .description = null },
    .{ .name = "RNG_CRYP", .index = 31, .description = null },
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
    WWDG_IWDG: Handler = unhandled,
    PVD_PVM: Handler = unhandled,
    RTC_TAMP: Handler = unhandled,
    FLASH_ECC: Handler = unhandled,
    RCC_CRS: Handler = unhandled,
    EXTI0_1: Handler = unhandled,
    EXTI2_3: Handler = unhandled,
    EXTI4_15: Handler = unhandled,
    USB_DRD_FS: Handler = unhandled,
    DMA1_Channel1: Handler = unhandled,
    DMA1_Channel2_3: Handler = unhandled,
    DMA1_Ch4_7_DMA2_Ch1_5_DMAMUX_OVR: Handler = unhandled,
    ADC_COMP1_2: Handler = unhandled,
    TIM1_BRK_UP_TRG_COM: Handler = unhandled,
    TIM1_CC: Handler = unhandled,
    TIM2: Handler = unhandled,
    TIM3: Handler = unhandled,
    TIM6_DAC_LPTIM1: Handler = unhandled,
    TIM7_LPTIM2: Handler = unhandled,
    TIM15_LPTIM3: Handler = unhandled,
    TIM16: Handler = unhandled,
    TSC: Handler = unhandled,
    LCD: Handler = unhandled,
    I2C1: Handler = unhandled,
    I2C2_3_4: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2_3: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2_LPUART2: Handler = unhandled,
    USART3_LPUART1: Handler = unhandled,
    USART4_LPUART3: Handler = unhandled,
    RNG_CRYP: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff6e50);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v2.TIM_GP16 = @ptrFromInt(0x40000400);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Liquid crystal display controller
    pub const LCD: *volatile types.peripherals.lcd_v2.LCD = @ptrFromInt(0x40002400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003c00);
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
    /// Universal serial bus full-speed host/device interface
    pub const USB: *volatile types.peripherals.usb_v4.USB = @ptrFromInt(0x40005c00);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40006c00);
    /// PWR register block
    pub const PWR: *volatile types.peripherals.pwr_u0.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v4.DAC = @ptrFromInt(0x40007400);
    /// OPAMP address block description.
    pub const OPAMP1: *volatile types.peripherals.opamp_u0.OPAMP = @ptrFromInt(0x40007800);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v2b.LPTIM = @ptrFromInt(0x40007c00);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008000);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART2: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008400);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40008800);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART3: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008c00);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v2b.LPTIM = @ptrFromInt(0x40009000);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v2b.LPTIM = @ptrFromInt(0x40009400);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_32_1024.USBRAM = @ptrFromInt(0x40009800);
    /// Inter-integrated circuit
    pub const I2C4: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x4000a000);
    /// SYSCFG register block
    pub const SYSCFG: *volatile types.peripherals.syscfg_u0.SYSCFG = @ptrFromInt(0x40010000);
    /// Comparator.
    pub const COMP1: *volatile types.peripherals.comp_u0.COMP = @ptrFromInt(0x40010200);
    /// Comparator.
    pub const COMP2: *volatile types.peripherals.comp_u0.COMP = @ptrFromInt(0x40010204);
    /// Analog to Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_u0.ADC = @ptrFromInt(0x40012400);
    /// Analog-to-Digital Converter
    pub const ADC1_COMMON: *volatile types.peripherals.adccommon_v3.ADC_COMMON = @ptrFromInt(0x40012708);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v2.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020400);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// RCC address block description.
    pub const RCC: *volatile types.peripherals.rcc_u0.RCC = @ptrFromInt(0x40021000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_u0.EXTI = @ptrFromInt(0x40021800);
    /// Mamba FLASH register block
    pub const FLASH: *volatile types.peripherals.flash_u0.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// Touch sensing controller.
    pub const TSC: *volatile types.peripherals.tsc_v2.TSC = @ptrFromInt(0x40024000);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v3.RNG = @ptrFromInt(0x40025000);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v2.AES = @ptrFromInt(0x40026000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50000c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50001000);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x50001400);
};
