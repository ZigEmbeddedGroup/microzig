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
    .{ .name = "PVD_PVM", .index = 1, .description = null },
    .{ .name = "RTC_TAMP_LSECSS", .index = 2, .description = null },
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
    .{ .name = "ADC1_2", .index = 18, .description = null },
    .{ .name = "USB_HP", .index = 19, .description = null },
    .{ .name = "USB_LP", .index = 20, .description = null },
    .{ .name = "FDCAN1_IT0", .index = 21, .description = null },
    .{ .name = "FDCAN1_IT1", .index = 22, .description = null },
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
    .{ .name = "USBWakeUp", .index = 42, .description = null },
    .{ .name = "TIM8_BRK", .index = 43, .description = null },
    .{ .name = "TIM8_UP", .index = 44, .description = null },
    .{ .name = "TIM8_TRG_COM", .index = 45, .description = null },
    .{ .name = "TIM8_CC", .index = 46, .description = null },
    .{ .name = "ADC3", .index = 47, .description = null },
    .{ .name = "FMC", .index = 48, .description = null },
    .{ .name = "LPTIM1", .index = 49, .description = null },
    .{ .name = "TIM5", .index = 50, .description = null },
    .{ .name = "SPI3", .index = 51, .description = null },
    .{ .name = "UART4", .index = 52, .description = null },
    .{ .name = "UART5", .index = 53, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "TIM7_DAC", .index = 55, .description = null },
    .{ .name = "DMA2_Channel1", .index = 56, .description = null },
    .{ .name = "DMA2_Channel2", .index = 57, .description = null },
    .{ .name = "DMA2_Channel3", .index = 58, .description = null },
    .{ .name = "DMA2_Channel4", .index = 59, .description = null },
    .{ .name = "DMA2_Channel5", .index = 60, .description = null },
    .{ .name = "ADC4", .index = 61, .description = null },
    .{ .name = "ADC5", .index = 62, .description = null },
    .{ .name = "UCPD1", .index = 63, .description = null },
    .{ .name = "COMP1_2_3", .index = 64, .description = null },
    .{ .name = "COMP4_5_6", .index = 65, .description = null },
    .{ .name = "COMP7", .index = 66, .description = null },
    .{ .name = "CRS", .index = 75, .description = null },
    .{ .name = "SAI1", .index = 76, .description = null },
    .{ .name = "TIM20_BRK", .index = 77, .description = null },
    .{ .name = "TIM20_UP", .index = 78, .description = null },
    .{ .name = "TIM20_TRG_COM", .index = 79, .description = null },
    .{ .name = "TIM20_CC", .index = 80, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
    .{ .name = "I2C4_EV", .index = 82, .description = null },
    .{ .name = "I2C4_ER", .index = 83, .description = null },
    .{ .name = "SPI4", .index = 84, .description = null },
    .{ .name = "AES", .index = 85, .description = null },
    .{ .name = "FDCAN2_IT0", .index = 86, .description = null },
    .{ .name = "FDCAN2_IT1", .index = 87, .description = null },
    .{ .name = "FDCAN3_IT0", .index = 88, .description = null },
    .{ .name = "FDCAN3_IT1", .index = 89, .description = null },
    .{ .name = "RNG", .index = 90, .description = null },
    .{ .name = "LPUART1", .index = 91, .description = null },
    .{ .name = "I2C3_EV", .index = 92, .description = null },
    .{ .name = "I2C3_ER", .index = 93, .description = null },
    .{ .name = "DMAMUX_OVR", .index = 94, .description = null },
    .{ .name = "QUADSPI", .index = 95, .description = null },
    .{ .name = "DMA1_Channel8", .index = 96, .description = null },
    .{ .name = "DMA2_Channel6", .index = 97, .description = null },
    .{ .name = "DMA2_Channel7", .index = 98, .description = null },
    .{ .name = "DMA2_Channel8", .index = 99, .description = null },
    .{ .name = "CORDIC", .index = 100, .description = null },
    .{ .name = "FMAC", .index = 101, .description = null },
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
    RTC_TAMP_LSECSS: Handler = unhandled,
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
    ADC1_2: Handler = unhandled,
    USB_HP: Handler = unhandled,
    USB_LP: Handler = unhandled,
    FDCAN1_IT0: Handler = unhandled,
    FDCAN1_IT1: Handler = unhandled,
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
    USBWakeUp: Handler = unhandled,
    TIM8_BRK: Handler = unhandled,
    TIM8_UP: Handler = unhandled,
    TIM8_TRG_COM: Handler = unhandled,
    TIM8_CC: Handler = unhandled,
    ADC3: Handler = unhandled,
    FMC: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    TIM5: Handler = unhandled,
    SPI3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    TIM6_DAC: Handler = unhandled,
    TIM7_DAC: Handler = unhandled,
    DMA2_Channel1: Handler = unhandled,
    DMA2_Channel2: Handler = unhandled,
    DMA2_Channel3: Handler = unhandled,
    DMA2_Channel4: Handler = unhandled,
    DMA2_Channel5: Handler = unhandled,
    ADC4: Handler = unhandled,
    ADC5: Handler = unhandled,
    UCPD1: Handler = unhandled,
    COMP1_2_3: Handler = unhandled,
    COMP4_5_6: Handler = unhandled,
    COMP7: Handler = unhandled,
    reserved81: [8]u32 = undefined,
    CRS: Handler = unhandled,
    SAI1: Handler = unhandled,
    TIM20_BRK: Handler = unhandled,
    TIM20_UP: Handler = unhandled,
    TIM20_TRG_COM: Handler = unhandled,
    TIM20_CC: Handler = unhandled,
    FPU: Handler = unhandled,
    I2C4_EV: Handler = unhandled,
    I2C4_ER: Handler = unhandled,
    SPI4: Handler = unhandled,
    AES: Handler = unhandled,
    FDCAN2_IT0: Handler = unhandled,
    FDCAN2_IT1: Handler = unhandled,
    FDCAN3_IT0: Handler = unhandled,
    FDCAN3_IT1: Handler = unhandled,
    RNG: Handler = unhandled,
    LPUART1: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    DMAMUX_OVR: Handler = unhandled,
    QUADSPI: Handler = unhandled,
    DMA1_Channel8: Handler = unhandled,
    DMA2_Channel6: Handler = unhandled,
    DMA2_Channel7: Handler = unhandled,
    DMA2_Channel8: Handler = unhandled,
    CORDIC: Handler = unhandled,
    FMAC: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x1fff7590);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 16-bit timers
    pub const TIM3: *volatile types.peripherals.timer_v2.TIM_GP16 = @ptrFromInt(0x40000400);
    /// General purpose 16-bit timers
    pub const TIM4: *volatile types.peripherals.timer_v2.TIM_GP16 = @ptrFromInt(0x40000800);
    /// General purpose 32-bit timers
    pub const TIM5: *volatile types.peripherals.timer_v2.TIM_GP32 = @ptrFromInt(0x40000c00);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v2.TIM_BASIC = @ptrFromInt(0x40001400);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40002000);
    /// Tamper and backup registers
    pub const TAMP: *volatile types.peripherals.tamp_g4.TAMP = @ptrFromInt(0x40002400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3.RTC = @ptrFromInt(0x40002800);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40003c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART2: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40004400);
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
    /// Universal serial bus full-speed device interface
    pub const USB: *volatile types.peripherals.usb_v3.USB = @ptrFromInt(0x40005c00);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_16x2_1024.USBRAM = @ptrFromInt(0x40006000);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x40006400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN2: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x40006800);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN3: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x40006c00);
    /// Power control
    pub const PWR: *volatile types.peripherals.pwr_g4.PWR = @ptrFromInt(0x40007000);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40007800);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1b_g4.LPTIM = @ptrFromInt(0x40007c00);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x40008000);
    /// Inter-integrated circuit
    pub const I2C4: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40008400);
    /// USB Power Delivery interface
    pub const UCPD1: *volatile types.peripherals.ucpd_v1.UCPD = @ptrFromInt(0x4000a000);
    /// FDCAN Message RAM
    pub const FDCANRAM1: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000a400);
    /// FDCAN Message RAM
    pub const FDCANRAM2: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000a750);
    /// FDCAN Message RAM
    pub const FDCANRAM3: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000aaa0);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_g4.SYSCFG = @ptrFromInt(0x40010000);
    /// Comparator v2. (RM0440 24)
    pub const COMP1: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010200);
    /// Comparator v2. (RM0440 24)
    pub const COMP2: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010204);
    /// Comparator v2. (RM0440 24)
    pub const COMP3: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010208);
    /// Comparator v2. (RM0440 24)
    pub const COMP4: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x4001020c);
    /// Comparator v2. (RM0440 24)
    pub const COMP5: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010210);
    /// Comparator v2. (RM0440 24)
    pub const COMP6: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010214);
    /// Comparator v2. (RM0440 24)
    pub const COMP7: *volatile types.peripherals.comp_v2.COMP = @ptrFromInt(0x40010218);
    /// Operational Amplifier
    pub const OPAMP1: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x40010300);
    /// Operational Amplifier
    pub const OPAMP2: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x40010304);
    /// Operational Amplifier
    pub const OPAMP3: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x40010308);
    /// Operational Amplifier
    pub const OPAMP4: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x4001030c);
    /// Operational Amplifier
    pub const OPAMP5: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x40010310);
    /// Operational Amplifier
    pub const OPAMP6: *volatile types.peripherals.opamp_g4.OPAMP = @ptrFromInt(0x40010314);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_v1.EXTI = @ptrFromInt(0x40010400);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013000);
    /// Advanced Control timers
    pub const TIM8: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40013400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40013800);
    /// Serial peripheral interface
    pub const SPI4: *volatile types.peripherals.spi_v2.SPI = @ptrFromInt(0x40013c00);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v2.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v2.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// Advanced Control timers
    pub const TIM20: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40015000);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v4_4pdm.SAI = @ptrFromInt(0x40015400);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x40020400);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// CORDIC co-processor.
    pub const CORDIC: *volatile types.peripherals.cordic_v1.CORDIC = @ptrFromInt(0x40020c00);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_g4.RCC = @ptrFromInt(0x40021000);
    /// Filter math accelerator
    pub const FMAC: *volatile types.peripherals.fmac_v1.FMAC = @ptrFromInt(0x40021400);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_g4c3.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48000c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001000);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001400);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x48001800);
    /// Analog to Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_g4.ADC = @ptrFromInt(0x50000000);
    /// Analog to Digital Converter
    pub const ADC2: *volatile types.peripherals.adc_g4.ADC = @ptrFromInt(0x50000100);
    /// Analog-to-Digital Converter
    pub const ADC12_COMMON: *volatile types.peripherals.adccommon_v4.ADC_COMMON = @ptrFromInt(0x50000300);
    /// Analog to Digital Converter
    pub const ADC3: *volatile types.peripherals.adc_g4.ADC = @ptrFromInt(0x50000400);
    /// Analog to Digital Converter
    pub const ADC4: *volatile types.peripherals.adc_g4.ADC = @ptrFromInt(0x50000500);
    /// Analog to Digital Converter
    pub const ADC5: *volatile types.peripherals.adc_g4.ADC = @ptrFromInt(0x50000600);
    /// Analog-to-Digital Converter
    pub const ADC345_COMMON: *volatile types.peripherals.adccommon_v4.ADC_COMMON = @ptrFromInt(0x50000700);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v7.DAC = @ptrFromInt(0x50000800);
    /// Digital-to-analog converter
    pub const DAC2: *volatile types.peripherals.dac_v7.DAC = @ptrFromInt(0x50000c00);
    /// Digital-to-analog converter
    pub const DAC3: *volatile types.peripherals.dac_v7.DAC = @ptrFromInt(0x50001000);
    /// Digital-to-analog converter
    pub const DAC4: *volatile types.peripherals.dac_v7.DAC = @ptrFromInt(0x50001400);
    /// Advanced encryption standard hardware accelerator
    pub const AES: *volatile types.peripherals.aes_v2.AES = @ptrFromInt(0x50060000);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x50060800);
    /// QuadSPI interface
    pub const QUADSPI1: *volatile types.peripherals.quadspi_v1.QUADSPI = @ptrFromInt(0xa0001000);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_g4.DBGMCU = @ptrFromInt(0xe0042000);
};
