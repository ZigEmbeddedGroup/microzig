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
    .{ .name = "TAMPER_STAMP", .index = 2, .description = null },
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
    .{ .name = "ADC1", .index = 18, .description = null },
    .{ .name = "USB_HP", .index = 19, .description = null },
    .{ .name = "USB_LP", .index = 20, .description = null },
    .{ .name = "DAC", .index = 21, .description = null },
    .{ .name = "COMP", .index = 22, .description = null },
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "LCD", .index = 24, .description = null },
    .{ .name = "TIM9", .index = 25, .description = null },
    .{ .name = "TIM10", .index = 26, .description = null },
    .{ .name = "TIM11", .index = 27, .description = null },
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
    .{ .name = "USB_FS_WKUP", .index = 42, .description = null },
    .{ .name = "TIM6", .index = 43, .description = null },
    .{ .name = "TIM7", .index = 44, .description = null },
    .{ .name = "SDIO", .index = 45, .description = null },
    .{ .name = "TIM5", .index = 46, .description = null },
    .{ .name = "SPI3", .index = 47, .description = null },
    .{ .name = "UART4", .index = 48, .description = null },
    .{ .name = "UART5", .index = 49, .description = null },
    .{ .name = "DMA2_Channel1", .index = 50, .description = null },
    .{ .name = "DMA2_Channel2", .index = 51, .description = null },
    .{ .name = "DMA2_Channel3", .index = 52, .description = null },
    .{ .name = "DMA2_Channel4", .index = 53, .description = null },
    .{ .name = "DMA2_Channel5", .index = 54, .description = null },
    .{ .name = "AES", .index = 55, .description = null },
    .{ .name = "COMP_ACQ", .index = 56, .description = null },
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
    TAMPER_STAMP: Handler = unhandled,
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
    ADC1: Handler = unhandled,
    USB_HP: Handler = unhandled,
    USB_LP: Handler = unhandled,
    DAC: Handler = unhandled,
    COMP: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    LCD: Handler = unhandled,
    TIM9: Handler = unhandled,
    TIM10: Handler = unhandled,
    TIM11: Handler = unhandled,
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
    USB_FS_WKUP: Handler = unhandled,
    TIM6: Handler = unhandled,
    TIM7: Handler = unhandled,
    SDIO: Handler = unhandled,
    TIM5: Handler = unhandled,
    SPI3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    DMA2_Channel1: Handler = unhandled,
    DMA2_Channel2: Handler = unhandled,
    DMA2_Channel3: Handler = unhandled,
    DMA2_Channel4: Handler = unhandled,
    DMA2_Channel5: Handler = unhandled,
    AES: Handler = unhandled,
    COMP_ACQ: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1ff800d0);
    /// VREFINT Factory Calibration
    pub const VREFINTCAL: *volatile types.peripherals.vrefintcal_v1.VREFINTCAL = @ptrFromInt(0x1ff800f8);
    /// General purpose 16-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP16 = @ptrFromInt(0x40000000);
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
    /// Liquid crystal display controller
    pub const LCD: *volatile types.peripherals.lcd_v1.LCD = @ptrFromInt(0x40002400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2l1.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v1.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v1.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v1.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v1.SPI = @ptrFromInt(0x40003c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v2.USART = @ptrFromInt(0x40004400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART3: *volatile types.peripherals.usart_v2.USART = @ptrFromInt(0x40004800);
    /// Inter-integrated circuit
    pub const I2C1: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v1.I2C = @ptrFromInt(0x40005800);
    /// Universal serial bus full-speed device interface
    pub const USB: *volatile types.peripherals.usb_v1.USB = @ptrFromInt(0x40005c00);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_16x1_512.USBRAM = @ptrFromInt(0x40006000);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_l1.PWR = @ptrFromInt(0x40007000);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v2.DAC = @ptrFromInt(0x40007400);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_l1.SYSCFG = @ptrFromInt(0x40010000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40010400);
    /// 2-channel timers
    pub const TIM9: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40010800);
    /// 1-channel timers
    pub const TIM10: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40010c00);
    /// 1-channel timers
    pub const TIM11: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40011000);
    /// Analog-to-digital converter
    pub const ADC1: *volatile types.peripherals.adc_f3_v1_1.ADC = @ptrFromInt(0x40012400);
    /// Secure digital input/output interface
    pub const SDIO: *volatile types.peripherals.sdmmc_v1.SDMMC = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v1.SPI = @ptrFromInt(0x40013000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v2.USART = @ptrFromInt(0x40013800);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40020c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021000);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021400);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021800);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x40021c00);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v1.CRC = @ptrFromInt(0x40023000);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_l1.RCC = @ptrFromInt(0x40023800);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_l1.FLASH = @ptrFromInt(0x40023c00);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40026000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40026400);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v1.AES = @ptrFromInt(0x50060000);
    /// Flexible static memory controller
    pub const FSMC: *volatile types.peripherals.fsmc_v1x0.FSMC = @ptrFromInt(0xa0000000);
    /// debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_l1.DBGMCU = @ptrFromInt(0xe0042000);
};
