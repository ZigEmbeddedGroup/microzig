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
    .{ .name = "PVD_AVD", .index = 1, .description = null },
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
    .{ .name = "TIM4", .index = 47, .description = null },
    .{ .name = "TIM5", .index = 48, .description = null },
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
    .{ .name = "UART4", .index = 61, .description = null },
    .{ .name = "UART5", .index = 62, .description = null },
    .{ .name = "LPUART1", .index = 63, .description = null },
    .{ .name = "LPTIM1", .index = 64, .description = null },
    .{ .name = "TIM8_BRK", .index = 65, .description = null },
    .{ .name = "TIM8_UP", .index = 66, .description = null },
    .{ .name = "TIM8_TRG_COM", .index = 67, .description = null },
    .{ .name = "TIM8_CC", .index = 68, .description = null },
    .{ .name = "ADC2", .index = 69, .description = null },
    .{ .name = "LPTIM2", .index = 70, .description = null },
    .{ .name = "TIM15", .index = 71, .description = null },
    .{ .name = "TIM16", .index = 72, .description = null },
    .{ .name = "TIM17", .index = 73, .description = null },
    .{ .name = "USB_DRD_FS", .index = 74, .description = null },
    .{ .name = "CRS", .index = 75, .description = null },
    .{ .name = "UCPD1", .index = 76, .description = null },
    .{ .name = "FMC", .index = 77, .description = null },
    .{ .name = "OCTOSPI1", .index = 78, .description = null },
    .{ .name = "SDMMC1", .index = 79, .description = null },
    .{ .name = "I2C3_EV", .index = 80, .description = null },
    .{ .name = "I2C3_ER", .index = 81, .description = null },
    .{ .name = "SPI4", .index = 82, .description = null },
    .{ .name = "SPI5", .index = 83, .description = null },
    .{ .name = "SPI6", .index = 84, .description = null },
    .{ .name = "USART6", .index = 85, .description = null },
    .{ .name = "USART10", .index = 86, .description = null },
    .{ .name = "USART11", .index = 87, .description = null },
    .{ .name = "SAI1", .index = 88, .description = null },
    .{ .name = "SAI2", .index = 89, .description = null },
    .{ .name = "GPDMA2_Channel0", .index = 90, .description = null },
    .{ .name = "GPDMA2_Channel1", .index = 91, .description = null },
    .{ .name = "GPDMA2_Channel2", .index = 92, .description = null },
    .{ .name = "GPDMA2_Channel3", .index = 93, .description = null },
    .{ .name = "GPDMA2_Channel4", .index = 94, .description = null },
    .{ .name = "GPDMA2_Channel5", .index = 95, .description = null },
    .{ .name = "GPDMA2_Channel6", .index = 96, .description = null },
    .{ .name = "GPDMA2_Channel7", .index = 97, .description = null },
    .{ .name = "UART7", .index = 98, .description = null },
    .{ .name = "UART8", .index = 99, .description = null },
    .{ .name = "UART9", .index = 100, .description = null },
    .{ .name = "UART12", .index = 101, .description = null },
    .{ .name = "SDMMC2", .index = 102, .description = null },
    .{ .name = "FPU", .index = 103, .description = null },
    .{ .name = "ICACHE", .index = 104, .description = null },
    .{ .name = "DCACHE1", .index = 105, .description = null },
    .{ .name = "ETH", .index = 106, .description = null },
    .{ .name = "ETH_WKUP", .index = 107, .description = null },
    .{ .name = "DCMI_PSSI", .index = 108, .description = null },
    .{ .name = "FDCAN2_IT0", .index = 109, .description = null },
    .{ .name = "FDCAN2_IT1", .index = 110, .description = null },
    .{ .name = "CORDIC", .index = 111, .description = null },
    .{ .name = "FMAC", .index = 112, .description = null },
    .{ .name = "DTS", .index = 113, .description = null },
    .{ .name = "RNG", .index = 114, .description = null },
    .{ .name = "HASH", .index = 117, .description = null },
    .{ .name = "PKA", .index = 118, .description = null },
    .{ .name = "CEC", .index = 119, .description = null },
    .{ .name = "TIM12", .index = 120, .description = null },
    .{ .name = "TIM13", .index = 121, .description = null },
    .{ .name = "TIM14", .index = 122, .description = null },
    .{ .name = "I3C1_EV", .index = 123, .description = null },
    .{ .name = "I3C1_ER", .index = 124, .description = null },
    .{ .name = "I2C4_EV", .index = 125, .description = null },
    .{ .name = "I2C4_ER", .index = 126, .description = null },
    .{ .name = "LPTIM3", .index = 127, .description = null },
    .{ .name = "LPTIM4", .index = 128, .description = null },
    .{ .name = "LPTIM5", .index = 129, .description = null },
    .{ .name = "LPTIM6", .index = 130, .description = null },
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
    TIM4: Handler = unhandled,
    TIM5: Handler = unhandled,
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
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    LPUART1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    TIM8_BRK: Handler = unhandled,
    TIM8_UP: Handler = unhandled,
    TIM8_TRG_COM: Handler = unhandled,
    TIM8_CC: Handler = unhandled,
    ADC2: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    USB_DRD_FS: Handler = unhandled,
    CRS: Handler = unhandled,
    UCPD1: Handler = unhandled,
    FMC: Handler = unhandled,
    OCTOSPI1: Handler = unhandled,
    SDMMC1: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    SPI4: Handler = unhandled,
    SPI5: Handler = unhandled,
    SPI6: Handler = unhandled,
    USART6: Handler = unhandled,
    USART10: Handler = unhandled,
    USART11: Handler = unhandled,
    SAI1: Handler = unhandled,
    SAI2: Handler = unhandled,
    GPDMA2_Channel0: Handler = unhandled,
    GPDMA2_Channel1: Handler = unhandled,
    GPDMA2_Channel2: Handler = unhandled,
    GPDMA2_Channel3: Handler = unhandled,
    GPDMA2_Channel4: Handler = unhandled,
    GPDMA2_Channel5: Handler = unhandled,
    GPDMA2_Channel6: Handler = unhandled,
    GPDMA2_Channel7: Handler = unhandled,
    UART7: Handler = unhandled,
    UART8: Handler = unhandled,
    UART9: Handler = unhandled,
    UART12: Handler = unhandled,
    SDMMC2: Handler = unhandled,
    FPU: Handler = unhandled,
    ICACHE: Handler = unhandled,
    DCACHE1: Handler = unhandled,
    ETH: Handler = unhandled,
    ETH_WKUP: Handler = unhandled,
    DCMI_PSSI: Handler = unhandled,
    FDCAN2_IT0: Handler = unhandled,
    FDCAN2_IT1: Handler = unhandled,
    CORDIC: Handler = unhandled,
    FMAC: Handler = unhandled,
    DTS: Handler = unhandled,
    RNG: Handler = unhandled,
    reserved129: [2]u32 = undefined,
    HASH: Handler = unhandled,
    PKA: Handler = unhandled,
    CEC: Handler = unhandled,
    TIM12: Handler = unhandled,
    TIM13: Handler = unhandled,
    TIM14: Handler = unhandled,
    I3C1_EV: Handler = unhandled,
    I3C1_ER: Handler = unhandled,
    I2C4_EV: Handler = unhandled,
    I2C4_ER: Handler = unhandled,
    LPTIM3: Handler = unhandled,
    LPTIM4: Handler = unhandled,
    LPTIM5: Handler = unhandled,
    LPTIM6: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x8fff800);
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
    /// 2-channel timers
    pub const TIM12: *volatile types.peripherals.timer_v2.TIM_2CH = @ptrFromInt(0x40001800);
    /// 1-channel timers
    pub const TIM13: *volatile types.peripherals.timer_v2.TIM_1CH = @ptrFromInt(0x40001c00);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v2.TIM_1CH = @ptrFromInt(0x40002000);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x40003000);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40003c00);
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
    /// Improved inter-integrated circuit.
    pub const I3C1: *volatile types.peripherals.i3c_v1.I3C = @ptrFromInt(0x40005c00);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40006000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART6: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40006400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART11: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40006c00);
    /// CEC.
    pub const CEC: *volatile types.peripherals.cec_v2.CEC = @ptrFromInt(0x40007000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART7: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40007800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART9: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40008000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART12: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40008400);
    /// Digital temperature sensor.
    pub const DTS: *volatile types.peripherals.dts_v1.DTS = @ptrFromInt(0x40008c00);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x40009400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x4000a400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN2: *volatile types.peripherals.can_fdcan_v1.FDCAN = @ptrFromInt(0x4000a800);
    /// FDCAN Message RAM
    pub const FDCANRAM1: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000ac00);
    /// FDCAN Message RAM
    pub const FDCANRAM2: *volatile types.peripherals.fdcanram_v1.FDCANRAM = @ptrFromInt(0x4000af50);
    /// USB Power Delivery interface
    pub const UCPD1: *volatile types.peripherals.ucpd_v1.UCPD = @ptrFromInt(0x4000dc00);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v2.TIM_ADV = @ptrFromInt(0x40012c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40013000);
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
    /// Serial peripheral interface
    pub const SPI6: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x40015000);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v4_2pdm.SAI = @ptrFromInt(0x40015400);
    /// Serial audio interface
    pub const SAI2: *volatile types.peripherals.sai_v4_2pdm.SAI = @ptrFromInt(0x40015800);
    /// Universal serial bus full-speed host/device interface
    pub const USB: *volatile types.peripherals.usb_v4.USB = @ptrFromInt(0x40016000);
    /// USB Endpoint memory
    pub const USBRAM: *volatile types.peripherals.usbram_32_2048.USBRAM = @ptrFromInt(0x40016400);
    /// GPDMA
    pub const GPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40020000);
    /// GPDMA
    pub const GPDMA2: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40021000);
    /// FLASH address block description
    pub const FLASH: *volatile types.peripherals.flash_h5.FLASH = @ptrFromInt(0x40022000);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// CORDIC co-processor.
    pub const CORDIC: *volatile types.peripherals.cordic_v1.CORDIC = @ptrFromInt(0x40023800);
    /// Filter math accelerator
    pub const FMAC: *volatile types.peripherals.fmac_v1.FMAC = @ptrFromInt(0x40023c00);
    /// Ethernet Peripheral
    pub const ETH: *volatile types.peripherals.eth_v2.ETH = @ptrFromInt(0x40028000);
    /// Instruction Cache Control Registers.
    pub const ICACHE: *volatile types.peripherals.icache_v1_4crr.ICACHE = @ptrFromInt(0x40030400);
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
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021400);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42021c00);
    /// General-purpose I/Os
    pub const GPIOI: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x42022000);
    /// Analog to digital converter
    pub const ADC1: *volatile types.peripherals.adc_h5.ADC = @ptrFromInt(0x42028000);
    /// Analog to digital converter
    pub const ADC2: *volatile types.peripherals.adc_h5.ADC = @ptrFromInt(0x42028100);
    /// ADC common registers
    pub const ADC12_COMMON: *volatile types.peripherals.adccommon_h5.ADC_COMMON = @ptrFromInt(0x42028300);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v6.DAC = @ptrFromInt(0x42028400);
    /// Digital camera interface
    pub const DCMI: *volatile types.peripherals.dcmi_v1.DCMI = @ptrFromInt(0x4202c000);
    /// Parallel synchronous slave interface.
    pub const PSSI: *volatile types.peripherals.pssi_v1.PSSI = @ptrFromInt(0x4202c400);
    /// Hash processor.
    pub const HASH: *volatile types.peripherals.hash_v3.HASH = @ptrFromInt(0x420c0400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v3.RNG = @ptrFromInt(0x420c0800);
    /// Public key accelerator.
    pub const PKA: *volatile types.peripherals.pka_v1a.PKA = @ptrFromInt(0x420c2000);
    /// SBS register block
    pub const SYSCFG: *volatile types.peripherals.syscfg_h5.SYSCFG = @ptrFromInt(0x44000400);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x44002400);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x44002800);
    /// Inter-integrated circuit
    pub const I2C4: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x44002c00);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x44004400);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x44004800);
    /// Low power timer with Output Compare
    pub const LPTIM4: *volatile types.peripherals.lptim_v2a.LPTIM_BASIC = @ptrFromInt(0x44004c00);
    /// Low power timer with Output Compare
    pub const LPTIM5: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x44005000);
    /// Low power timer with Output Compare
    pub const LPTIM6: *volatile types.peripherals.lptim_v2a.LPTIM = @ptrFromInt(0x44005400);
    /// Voltage reference buffer.
    pub const VREFBUF: *volatile types.peripherals.vrefbuf_v2a2.VREFBUF = @ptrFromInt(0x44007400);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v3u5.RTC = @ptrFromInt(0x44007800);
    /// Tamper and backup.
    pub const TAMP: *volatile types.peripherals.tamp_h5.TAMP = @ptrFromInt(0x44007c00);
    /// Power control.
    pub const PWR: *volatile types.peripherals.pwr_h5.PWR = @ptrFromInt(0x44020800);
    /// Reset and clock controller
    pub const RCC: *volatile types.peripherals.rcc_h5.RCC = @ptrFromInt(0x44020c00);
    /// Extended interrupt and event controller
    pub const EXTI: *volatile types.peripherals.exti_h5.EXTI = @ptrFromInt(0x44022000);
    /// Microcontroller debug unit.
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_h5.DBGMCU = @ptrFromInt(0x44024000);
    /// SDMMC
    pub const SDMMC1: *volatile types.peripherals.sdmmc_v2.SDMMC = @ptrFromInt(0x46008000);
    /// OctoSPI
    pub const OCTOSPI1: *volatile types.peripherals.octospi_v2.OCTOSPI = @ptrFromInt(0x47001400);
    /// Flexible memory controller.
    pub const FMC: *volatile types.peripherals.fmc_v4.FMC = @ptrFromInt(0x60000000);
};
