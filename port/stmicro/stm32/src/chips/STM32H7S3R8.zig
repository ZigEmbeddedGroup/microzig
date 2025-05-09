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
    .{ .name = "PVD_PVM", .index = 0, .description = null },
    .{ .name = "DTS", .index = 2, .description = null },
    .{ .name = "IWDG", .index = 3, .description = null },
    .{ .name = "WWDG", .index = 4, .description = null },
    .{ .name = "RCC", .index = 5, .description = null },
    .{ .name = "FLASH", .index = 8, .description = null },
    .{ .name = "RAMECC", .index = 9, .description = null },
    .{ .name = "FPU", .index = 10, .description = null },
    .{ .name = "TAMP", .index = 13, .description = null },
    .{ .name = "EXTI0", .index = 16, .description = null },
    .{ .name = "EXTI1", .index = 17, .description = null },
    .{ .name = "EXTI2", .index = 18, .description = null },
    .{ .name = "EXTI3", .index = 19, .description = null },
    .{ .name = "EXTI4", .index = 20, .description = null },
    .{ .name = "EXTI5", .index = 21, .description = null },
    .{ .name = "EXTI6", .index = 22, .description = null },
    .{ .name = "EXTI7", .index = 23, .description = null },
    .{ .name = "EXTI8", .index = 24, .description = null },
    .{ .name = "EXTI9", .index = 25, .description = null },
    .{ .name = "EXTI10", .index = 26, .description = null },
    .{ .name = "EXTI11", .index = 27, .description = null },
    .{ .name = "EXTI12", .index = 28, .description = null },
    .{ .name = "EXTI13", .index = 29, .description = null },
    .{ .name = "EXTI14", .index = 30, .description = null },
    .{ .name = "EXTI15", .index = 31, .description = null },
    .{ .name = "RTC", .index = 32, .description = null },
    .{ .name = "SAES", .index = 33, .description = null },
    .{ .name = "CRYP", .index = 34, .description = null },
    .{ .name = "PKA", .index = 35, .description = null },
    .{ .name = "HASH", .index = 36, .description = null },
    .{ .name = "RNG", .index = 37, .description = null },
    .{ .name = "ADC1_2", .index = 38, .description = null },
    .{ .name = "GPDMA1_Channel0", .index = 39, .description = null },
    .{ .name = "GPDMA1_Channel1", .index = 40, .description = null },
    .{ .name = "GPDMA1_Channel2", .index = 41, .description = null },
    .{ .name = "GPDMA1_Channel3", .index = 42, .description = null },
    .{ .name = "GPDMA1_Channel4", .index = 43, .description = null },
    .{ .name = "GPDMA1_Channel5", .index = 44, .description = null },
    .{ .name = "GPDMA1_Channel6", .index = 45, .description = null },
    .{ .name = "GPDMA1_Channel7", .index = 46, .description = null },
    .{ .name = "TIM1_BRK", .index = 47, .description = null },
    .{ .name = "TIM1_UP", .index = 48, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 49, .description = null },
    .{ .name = "TIM1_CC", .index = 50, .description = null },
    .{ .name = "TIM2", .index = 51, .description = null },
    .{ .name = "TIM3", .index = 52, .description = null },
    .{ .name = "TIM4", .index = 53, .description = null },
    .{ .name = "TIM5", .index = 54, .description = null },
    .{ .name = "TIM6", .index = 55, .description = null },
    .{ .name = "TIM7", .index = 56, .description = null },
    .{ .name = "TIM9", .index = 57, .description = null },
    .{ .name = "SPI1", .index = 58, .description = null },
    .{ .name = "SPI2", .index = 59, .description = null },
    .{ .name = "SPI3", .index = 60, .description = null },
    .{ .name = "SPI4", .index = 61, .description = null },
    .{ .name = "SPI5", .index = 62, .description = null },
    .{ .name = "SPI6", .index = 63, .description = null },
    .{ .name = "HPDMA1_Channel0", .index = 64, .description = null },
    .{ .name = "HPDMA1_Channel1", .index = 65, .description = null },
    .{ .name = "HPDMA1_Channel2", .index = 66, .description = null },
    .{ .name = "HPDMA1_Channel3", .index = 67, .description = null },
    .{ .name = "HPDMA1_Channel4", .index = 68, .description = null },
    .{ .name = "HPDMA1_Channel5", .index = 69, .description = null },
    .{ .name = "HPDMA1_Channel6", .index = 70, .description = null },
    .{ .name = "HPDMA1_Channel7", .index = 71, .description = null },
    .{ .name = "SAI1_A", .index = 72, .description = null },
    .{ .name = "SAI1_B", .index = 73, .description = null },
    .{ .name = "SAI2_A", .index = 74, .description = null },
    .{ .name = "SAI2_B", .index = 75, .description = null },
    .{ .name = "I2C1_EV", .index = 76, .description = null },
    .{ .name = "I2C1_ER", .index = 77, .description = null },
    .{ .name = "I2C2_EV", .index = 78, .description = null },
    .{ .name = "I2C2_ER", .index = 79, .description = null },
    .{ .name = "I2C3_EV", .index = 80, .description = null },
    .{ .name = "I2C3_ER", .index = 81, .description = null },
    .{ .name = "USART1", .index = 82, .description = null },
    .{ .name = "USART2", .index = 83, .description = null },
    .{ .name = "USART3", .index = 84, .description = null },
    .{ .name = "UART4", .index = 85, .description = null },
    .{ .name = "UART5", .index = 86, .description = null },
    .{ .name = "UART7", .index = 87, .description = null },
    .{ .name = "UART8", .index = 88, .description = null },
    .{ .name = "I3C1_EV", .index = 89, .description = null },
    .{ .name = "I3C1_ER", .index = 90, .description = null },
    .{ .name = "OTG_HS", .index = 91, .description = null },
    .{ .name = "ETH", .index = 92, .description = null },
    .{ .name = "CORDIC", .index = 93, .description = null },
    .{ .name = "GFXTIM", .index = 94, .description = null },
    .{ .name = "DCMIPP", .index = 95, .description = null },
    .{ .name = "DMA2D", .index = 98, .description = null },
    .{ .name = "JPEG", .index = 99, .description = null },
    .{ .name = "GFXMMU", .index = 100, .description = null },
    .{ .name = "I3C1_WKUP", .index = 101, .description = null },
    .{ .name = "MCE1", .index = 102, .description = null },
    .{ .name = "MCE2", .index = 103, .description = null },
    .{ .name = "MCE3", .index = 104, .description = null },
    .{ .name = "XSPI1", .index = 105, .description = null },
    .{ .name = "XSPI2", .index = 106, .description = null },
    .{ .name = "FMC", .index = 107, .description = null },
    .{ .name = "SDMMC1", .index = 108, .description = null },
    .{ .name = "SDMMC2", .index = 109, .description = null },
    .{ .name = "OTG_FS", .index = 112, .description = null },
    .{ .name = "TIM12", .index = 113, .description = null },
    .{ .name = "TIM13", .index = 114, .description = null },
    .{ .name = "TIM14", .index = 115, .description = null },
    .{ .name = "TIM15", .index = 116, .description = null },
    .{ .name = "TIM16", .index = 117, .description = null },
    .{ .name = "TIM17", .index = 118, .description = null },
    .{ .name = "LPTIM1", .index = 119, .description = null },
    .{ .name = "LPTIM2", .index = 120, .description = null },
    .{ .name = "LPTIM3", .index = 121, .description = null },
    .{ .name = "LPTIM4", .index = 122, .description = null },
    .{ .name = "LPTIM5", .index = 123, .description = null },
    .{ .name = "SPDIF_RX", .index = 124, .description = null },
    .{ .name = "MDIOS", .index = 125, .description = null },
    .{ .name = "ADF1_FLT0", .index = 126, .description = null },
    .{ .name = "CRS", .index = 127, .description = null },
    .{ .name = "UCPD1", .index = 128, .description = null },
    .{ .name = "CEC", .index = 129, .description = null },
    .{ .name = "PSSI", .index = 130, .description = null },
    .{ .name = "LPUART1", .index = 131, .description = null },
    .{ .name = "WAKEUP_PIN", .index = 132, .description = null },
    .{ .name = "GPDMA1_Channel8", .index = 133, .description = null },
    .{ .name = "GPDMA1_Channel9", .index = 134, .description = null },
    .{ .name = "GPDMA1_Channel10", .index = 135, .description = null },
    .{ .name = "GPDMA1_Channel11", .index = 136, .description = null },
    .{ .name = "GPDMA1_Channel12", .index = 137, .description = null },
    .{ .name = "GPDMA1_Channel13", .index = 138, .description = null },
    .{ .name = "GPDMA1_Channel14", .index = 139, .description = null },
    .{ .name = "GPDMA1_Channel15", .index = 140, .description = null },
    .{ .name = "HPDMA1_Channel8", .index = 141, .description = null },
    .{ .name = "HPDMA1_Channel9", .index = 142, .description = null },
    .{ .name = "HPDMA1_Channel10", .index = 143, .description = null },
    .{ .name = "HPDMA1_Channel11", .index = 144, .description = null },
    .{ .name = "HPDMA1_Channel12", .index = 145, .description = null },
    .{ .name = "HPDMA1_Channel13", .index = 146, .description = null },
    .{ .name = "HPDMA1_Channel14", .index = 147, .description = null },
    .{ .name = "HPDMA1_Channel15", .index = 148, .description = null },
    .{ .name = "FDCAN1_IT0", .index = 152, .description = null },
    .{ .name = "FDCAN1_IT1", .index = 153, .description = null },
    .{ .name = "FDCAN2_IT0", .index = 154, .description = null },
    .{ .name = "FDCAN2_IT1", .index = 155, .description = null },
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
    PVD_PVM: Handler = unhandled,
    reserved15: [1]u32 = undefined,
    DTS: Handler = unhandled,
    IWDG: Handler = unhandled,
    WWDG: Handler = unhandled,
    RCC: Handler = unhandled,
    reserved20: [2]u32 = undefined,
    FLASH: Handler = unhandled,
    RAMECC: Handler = unhandled,
    FPU: Handler = unhandled,
    reserved25: [2]u32 = undefined,
    TAMP: Handler = unhandled,
    reserved28: [2]u32 = undefined,
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
    RTC: Handler = unhandled,
    SAES: Handler = unhandled,
    CRYP: Handler = unhandled,
    PKA: Handler = unhandled,
    HASH: Handler = unhandled,
    RNG: Handler = unhandled,
    ADC1_2: Handler = unhandled,
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
    TIM3: Handler = unhandled,
    TIM4: Handler = unhandled,
    TIM5: Handler = unhandled,
    TIM6: Handler = unhandled,
    TIM7: Handler = unhandled,
    TIM9: Handler = unhandled,
    SPI1: Handler = unhandled,
    SPI2: Handler = unhandled,
    SPI3: Handler = unhandled,
    SPI4: Handler = unhandled,
    SPI5: Handler = unhandled,
    SPI6: Handler = unhandled,
    HPDMA1_Channel0: Handler = unhandled,
    HPDMA1_Channel1: Handler = unhandled,
    HPDMA1_Channel2: Handler = unhandled,
    HPDMA1_Channel3: Handler = unhandled,
    HPDMA1_Channel4: Handler = unhandled,
    HPDMA1_Channel5: Handler = unhandled,
    HPDMA1_Channel6: Handler = unhandled,
    HPDMA1_Channel7: Handler = unhandled,
    SAI1_A: Handler = unhandled,
    SAI1_B: Handler = unhandled,
    SAI2_A: Handler = unhandled,
    SAI2_B: Handler = unhandled,
    I2C1_EV: Handler = unhandled,
    I2C1_ER: Handler = unhandled,
    I2C2_EV: Handler = unhandled,
    I2C2_ER: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    USART1: Handler = unhandled,
    USART2: Handler = unhandled,
    USART3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    UART7: Handler = unhandled,
    UART8: Handler = unhandled,
    I3C1_EV: Handler = unhandled,
    I3C1_ER: Handler = unhandled,
    OTG_HS: Handler = unhandled,
    ETH: Handler = unhandled,
    CORDIC: Handler = unhandled,
    GFXTIM: Handler = unhandled,
    DCMIPP: Handler = unhandled,
    reserved110: [2]u32 = undefined,
    DMA2D: Handler = unhandled,
    JPEG: Handler = unhandled,
    GFXMMU: Handler = unhandled,
    I3C1_WKUP: Handler = unhandled,
    MCE1: Handler = unhandled,
    MCE2: Handler = unhandled,
    MCE3: Handler = unhandled,
    XSPI1: Handler = unhandled,
    XSPI2: Handler = unhandled,
    FMC: Handler = unhandled,
    SDMMC1: Handler = unhandled,
    SDMMC2: Handler = unhandled,
    reserved124: [2]u32 = undefined,
    OTG_FS: Handler = unhandled,
    TIM12: Handler = unhandled,
    TIM13: Handler = unhandled,
    TIM14: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    LPTIM3: Handler = unhandled,
    LPTIM4: Handler = unhandled,
    LPTIM5: Handler = unhandled,
    SPDIF_RX: Handler = unhandled,
    MDIOS: Handler = unhandled,
    ADF1_FLT0: Handler = unhandled,
    CRS: Handler = unhandled,
    UCPD1: Handler = unhandled,
    CEC: Handler = unhandled,
    PSSI: Handler = unhandled,
    LPUART1: Handler = unhandled,
    WAKEUP_PIN: Handler = unhandled,
    GPDMA1_Channel8: Handler = unhandled,
    GPDMA1_Channel9: Handler = unhandled,
    GPDMA1_Channel10: Handler = unhandled,
    GPDMA1_Channel11: Handler = unhandled,
    GPDMA1_Channel12: Handler = unhandled,
    GPDMA1_Channel13: Handler = unhandled,
    GPDMA1_Channel14: Handler = unhandled,
    GPDMA1_Channel15: Handler = unhandled,
    HPDMA1_Channel8: Handler = unhandled,
    HPDMA1_Channel9: Handler = unhandled,
    HPDMA1_Channel10: Handler = unhandled,
    HPDMA1_Channel11: Handler = unhandled,
    HPDMA1_Channel12: Handler = unhandled,
    HPDMA1_Channel13: Handler = unhandled,
    HPDMA1_Channel14: Handler = unhandled,
    HPDMA1_Channel15: Handler = unhandled,
    reserved163: [3]u32 = undefined,
    FDCAN1_IT0: Handler = unhandled,
    FDCAN1_IT1: Handler = unhandled,
    FDCAN2_IT0: Handler = unhandled,
    FDCAN2_IT1: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x8fff800);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
    /// General purpose 32-bit timers
    pub const TIM5: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000c00);
    /// Basic timers
    pub const TIM6: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001000);
    /// Basic timers
    pub const TIM7: *volatile types.peripherals.timer_v1.TIM_BASIC = @ptrFromInt(0x40001400);
    /// 2-channel timers
    pub const TIM12: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40001800);
    /// 1-channel timers
    pub const TIM13: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40001c00);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Window watchdog
    pub const WWDG: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x40002c00);
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
    pub const I2C1: *volatile types.peripherals.i2c_v3.I2C = @ptrFromInt(0x40005400);
    /// Inter-integrated circuit
    pub const I2C2: *volatile types.peripherals.i2c_v3.I2C = @ptrFromInt(0x40005800);
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v3.I2C = @ptrFromInt(0x40005c00);
    /// CEC.
    pub const CEC: *volatile types.peripherals.cec_v2.CEC = @ptrFromInt(0x40006c00);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART7: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40007800);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40008400);
    /// Management data input/output slave
    pub const MDIOS: *volatile types.peripherals.mdios_v1.MDIOS = @ptrFromInt(0x40009400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_h7.FDCAN = @ptrFromInt(0x4000a000);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN2: *volatile types.peripherals.can_fdcan_h7.FDCAN = @ptrFromInt(0x4000a400);
    /// FDCAN Message RAM
    pub const FDCANRAM: *volatile types.peripherals.fdcanram_h7.FDCANRAM = @ptrFromInt(0x4000ac00);
    /// GPDMA
    pub const GPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x40021000);
    /// Analog-to-Digital Converter
    pub const ADC12_COMMON: *volatile types.peripherals.adccommon_v4.ADC_COMMON = @ptrFromInt(0x40022300);
    /// USB on the go
    pub const USB_OTG_FS: *volatile types.peripherals.otg_v1.OTG = @ptrFromInt(0x40080000);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x42000000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x42001000);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x42003000);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x42004000);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x42004800);
    /// Serial peripheral interface
    pub const SPI5: *volatile types.peripherals.spi_v4.SPI = @ptrFromInt(0x42005000);
    /// Serial audio interface
    pub const SAI2: *volatile types.peripherals.sai_v4_4pdm.SAI = @ptrFromInt(0x42005c00);
    /// CORDIC co-processor.
    pub const CORDIC: *volatile types.peripherals.cordic_v1.CORDIC = @ptrFromInt(0x48004400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x48020000);
    /// Hash processor.
    pub const HASH: *volatile types.peripherals.hash_v3.HASH = @ptrFromInt(0x48020400);
    /// Cryptographic processor.
    pub const CRYP: *volatile types.peripherals.cryp_v4.CRYP = @ptrFromInt(0x48020800);
    /// GPDMA
    pub const HPDMA1: *volatile types.peripherals.gpdma_v1.GPDMA = @ptrFromInt(0x52000000);
    /// DMA2D
    pub const DMA2D: *volatile types.peripherals.dma2d_v2.DMA2D = @ptrFromInt(0x52001000);
    /// Embedded Flash memory.
    pub const FLASH: *volatile types.peripherals.flash_h7rs.FLASH = @ptrFromInt(0x52002000);
    /// JPEG codec
    pub const JPEG: *volatile types.peripherals.jpeg_v1.JPEG = @ptrFromInt(0x52003000);
    /// Flexible memory controller
    pub const FMC: *volatile types.peripherals.fmc_v3x1.FMC = @ptrFromInt(0x52004000);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_h7.EXTI = @ptrFromInt(0x58000000);
    /// System configuration, boot and security.
    pub const SYSCFG: *volatile types.peripherals.syscfg_h7rs.SYSCFG = @ptrFromInt(0x58000400);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x58000c00);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x58002400);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x58002800);
    /// Low power timer with Output Compare
    pub const LPTIM4: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x58002c00);
    /// Voltage reference buffer.
    pub const VREFBUF: *volatile types.peripherals.vrefbuf_v2a1.VREFBUF = @ptrFromInt(0x58003c00);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2h7.RTC = @ptrFromInt(0x58004000);
    /// Independent watchdog
    pub const IWDG: *volatile types.peripherals.iwdg_v3.IWDG = @ptrFromInt(0x58004800);
    /// Digital temperature sensor.
    pub const DTS: *volatile types.peripherals.dts_v1.DTS = @ptrFromInt(0x58006800);
    /// General-purpose I/Os
    pub const GPIOA: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58020000);
    /// General-purpose I/Os
    pub const GPIOB: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58020400);
    /// General-purpose I/Os
    pub const GPIOC: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58020800);
    /// General-purpose I/Os
    pub const GPIOD: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58020c00);
    /// General-purpose I/Os
    pub const GPIOE: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58021000);
    /// General-purpose I/Os
    pub const GPIOF: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58021400);
    /// General-purpose I/Os
    pub const GPIOG: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58021800);
    /// General-purpose I/Os
    pub const GPIOH: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58021c00);
    /// General-purpose I/Os
    pub const GPIOM: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58023000);
    /// General-purpose I/Os
    pub const GPION: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58023400);
    /// General-purpose I/Os
    pub const GPIOO: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58023800);
    /// General-purpose I/Os
    pub const GPIOP: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58023c00);
    /// Reset and clock control.
    pub const RCC: *volatile types.peripherals.rcc_h7rs.RCC = @ptrFromInt(0x58024400);
    /// Power control.
    pub const PWR: *volatile types.peripherals.pwr_h7rs.PWR = @ptrFromInt(0x58024800);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x58024c00);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_h7.DBGMCU = @ptrFromInt(0x5c001000);
};
