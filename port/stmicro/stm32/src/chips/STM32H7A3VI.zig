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
    .{ .name = "RTC_TAMP_STAMP_CSS_LSE", .index = 2, .description = null },
    .{ .name = "RTC_WKUP", .index = 3, .description = null },
    .{ .name = "FLASH", .index = 4, .description = null },
    .{ .name = "RCC", .index = 5, .description = null },
    .{ .name = "EXTI0", .index = 6, .description = null },
    .{ .name = "EXTI1", .index = 7, .description = null },
    .{ .name = "EXTI2", .index = 8, .description = null },
    .{ .name = "EXTI3", .index = 9, .description = null },
    .{ .name = "EXTI4", .index = 10, .description = null },
    .{ .name = "DMA1_Stream0", .index = 11, .description = null },
    .{ .name = "DMA1_Stream1", .index = 12, .description = null },
    .{ .name = "DMA1_Stream2", .index = 13, .description = null },
    .{ .name = "DMA1_Stream3", .index = 14, .description = null },
    .{ .name = "DMA1_Stream4", .index = 15, .description = null },
    .{ .name = "DMA1_Stream5", .index = 16, .description = null },
    .{ .name = "DMA1_Stream6", .index = 17, .description = null },
    .{ .name = "ADC", .index = 18, .description = null },
    .{ .name = "FDCAN1_IT0", .index = 19, .description = null },
    .{ .name = "FDCAN2_IT0", .index = 20, .description = null },
    .{ .name = "FDCAN1_IT1", .index = 21, .description = null },
    .{ .name = "FDCAN2_IT1", .index = 22, .description = null },
    .{ .name = "EXTI9_5", .index = 23, .description = null },
    .{ .name = "TIM1_BRK", .index = 24, .description = null },
    .{ .name = "TIM1_UP", .index = 25, .description = null },
    .{ .name = "TIM1_TRG_COM", .index = 26, .description = null },
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
    .{ .name = "DFSDM2", .index = 42, .description = null },
    .{ .name = "TIM8_BRK_TIM12", .index = 43, .description = null },
    .{ .name = "TIM8_UP_TIM13", .index = 44, .description = null },
    .{ .name = "TIM8_TRG_COM_TIM14", .index = 45, .description = null },
    .{ .name = "TIM8_CC", .index = 46, .description = null },
    .{ .name = "DMA1_Stream7", .index = 47, .description = null },
    .{ .name = "FMC", .index = 48, .description = null },
    .{ .name = "SDMMC1", .index = 49, .description = null },
    .{ .name = "TIM5", .index = 50, .description = null },
    .{ .name = "SPI3", .index = 51, .description = null },
    .{ .name = "UART4", .index = 52, .description = null },
    .{ .name = "UART5", .index = 53, .description = null },
    .{ .name = "TIM6_DAC", .index = 54, .description = null },
    .{ .name = "TIM7", .index = 55, .description = null },
    .{ .name = "DMA2_Stream0", .index = 56, .description = null },
    .{ .name = "DMA2_Stream1", .index = 57, .description = null },
    .{ .name = "DMA2_Stream2", .index = 58, .description = null },
    .{ .name = "DMA2_Stream3", .index = 59, .description = null },
    .{ .name = "DMA2_Stream4", .index = 60, .description = null },
    .{ .name = "FDCAN_CAL", .index = 63, .description = null },
    .{ .name = "DFSDM1_FLT4", .index = 64, .description = null },
    .{ .name = "DFSDM1_FLT5", .index = 65, .description = null },
    .{ .name = "DFSDM1_FLT6", .index = 66, .description = null },
    .{ .name = "DFSDM1_FLT7", .index = 67, .description = null },
    .{ .name = "DMA2_Stream5", .index = 68, .description = null },
    .{ .name = "DMA2_Stream6", .index = 69, .description = null },
    .{ .name = "DMA2_Stream7", .index = 70, .description = null },
    .{ .name = "USART6", .index = 71, .description = null },
    .{ .name = "I2C3_EV", .index = 72, .description = null },
    .{ .name = "I2C3_ER", .index = 73, .description = null },
    .{ .name = "OTG_HS_EP1_OUT", .index = 74, .description = null },
    .{ .name = "OTG_HS_EP1_IN", .index = 75, .description = null },
    .{ .name = "OTG_HS_WKUP", .index = 76, .description = null },
    .{ .name = "OTG_HS", .index = 77, .description = null },
    .{ .name = "DCMI_PSSI", .index = 78, .description = null },
    .{ .name = "RNG", .index = 80, .description = null },
    .{ .name = "FPU", .index = 81, .description = null },
    .{ .name = "UART7", .index = 82, .description = null },
    .{ .name = "UART8", .index = 83, .description = null },
    .{ .name = "SPI4", .index = 84, .description = null },
    .{ .name = "SPI5", .index = 85, .description = null },
    .{ .name = "SPI6", .index = 86, .description = null },
    .{ .name = "SAI1", .index = 87, .description = null },
    .{ .name = "LTDC", .index = 88, .description = null },
    .{ .name = "LTDC_ER", .index = 89, .description = null },
    .{ .name = "DMA2D", .index = 90, .description = null },
    .{ .name = "SAI2", .index = 91, .description = null },
    .{ .name = "OCTOSPI1", .index = 92, .description = null },
    .{ .name = "LPTIM1", .index = 93, .description = null },
    .{ .name = "CEC", .index = 94, .description = null },
    .{ .name = "I2C4_EV", .index = 95, .description = null },
    .{ .name = "I2C4_ER", .index = 96, .description = null },
    .{ .name = "SPDIF_RX", .index = 97, .description = null },
    .{ .name = "DMAMUX1_OVR", .index = 102, .description = null },
    .{ .name = "DFSDM1_FLT0", .index = 110, .description = null },
    .{ .name = "DFSDM1_FLT1", .index = 111, .description = null },
    .{ .name = "DFSDM1_FLT2", .index = 112, .description = null },
    .{ .name = "DFSDM1_FLT3", .index = 113, .description = null },
    .{ .name = "SWPMI1", .index = 115, .description = null },
    .{ .name = "TIM15", .index = 116, .description = null },
    .{ .name = "TIM16", .index = 117, .description = null },
    .{ .name = "TIM17", .index = 118, .description = null },
    .{ .name = "MDIOS_WKUP", .index = 119, .description = null },
    .{ .name = "MDIOS", .index = 120, .description = null },
    .{ .name = "JPEG", .index = 121, .description = null },
    .{ .name = "MDMA", .index = 122, .description = null },
    .{ .name = "SDMMC2", .index = 124, .description = null },
    .{ .name = "HSEM1", .index = 125, .description = null },
    .{ .name = "DAC2", .index = 127, .description = null },
    .{ .name = "DMAMUX2_OVR", .index = 128, .description = null },
    .{ .name = "BDMA2_Channel0", .index = 129, .description = null },
    .{ .name = "BDMA2_Channel1", .index = 130, .description = null },
    .{ .name = "BDMA2_Channel2", .index = 131, .description = null },
    .{ .name = "BDMA2_Channel3", .index = 132, .description = null },
    .{ .name = "BDMA2_Channel4", .index = 133, .description = null },
    .{ .name = "BDMA2_Channel5", .index = 134, .description = null },
    .{ .name = "BDMA2_Channel6", .index = 135, .description = null },
    .{ .name = "BDMA2_Channel7", .index = 136, .description = null },
    .{ .name = "COMP", .index = 137, .description = null },
    .{ .name = "LPTIM2", .index = 138, .description = null },
    .{ .name = "LPTIM3", .index = 139, .description = null },
    .{ .name = "UART9", .index = 140, .description = null },
    .{ .name = "USART10", .index = 141, .description = null },
    .{ .name = "LPUART1", .index = 142, .description = null },
    .{ .name = "WWDG_RST", .index = 143, .description = null },
    .{ .name = "CRS", .index = 144, .description = null },
    .{ .name = "ECC", .index = 145, .description = null },
    .{ .name = "DTS", .index = 147, .description = null },
    .{ .name = "WAKEUP_PIN", .index = 149, .description = null },
    .{ .name = "OCTOSPI2", .index = 150, .description = null },
    .{ .name = "GFXMMU", .index = 153, .description = null },
    .{ .name = "BDMA1", .index = 154, .description = null },
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
    RTC_TAMP_STAMP_CSS_LSE: Handler = unhandled,
    RTC_WKUP: Handler = unhandled,
    FLASH: Handler = unhandled,
    RCC: Handler = unhandled,
    EXTI0: Handler = unhandled,
    EXTI1: Handler = unhandled,
    EXTI2: Handler = unhandled,
    EXTI3: Handler = unhandled,
    EXTI4: Handler = unhandled,
    DMA1_Stream0: Handler = unhandled,
    DMA1_Stream1: Handler = unhandled,
    DMA1_Stream2: Handler = unhandled,
    DMA1_Stream3: Handler = unhandled,
    DMA1_Stream4: Handler = unhandled,
    DMA1_Stream5: Handler = unhandled,
    DMA1_Stream6: Handler = unhandled,
    ADC: Handler = unhandled,
    FDCAN1_IT0: Handler = unhandled,
    FDCAN2_IT0: Handler = unhandled,
    FDCAN1_IT1: Handler = unhandled,
    FDCAN2_IT1: Handler = unhandled,
    EXTI9_5: Handler = unhandled,
    TIM1_BRK: Handler = unhandled,
    TIM1_UP: Handler = unhandled,
    TIM1_TRG_COM: Handler = unhandled,
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
    DFSDM2: Handler = unhandled,
    TIM8_BRK_TIM12: Handler = unhandled,
    TIM8_UP_TIM13: Handler = unhandled,
    TIM8_TRG_COM_TIM14: Handler = unhandled,
    TIM8_CC: Handler = unhandled,
    DMA1_Stream7: Handler = unhandled,
    FMC: Handler = unhandled,
    SDMMC1: Handler = unhandled,
    TIM5: Handler = unhandled,
    SPI3: Handler = unhandled,
    UART4: Handler = unhandled,
    UART5: Handler = unhandled,
    TIM6_DAC: Handler = unhandled,
    TIM7: Handler = unhandled,
    DMA2_Stream0: Handler = unhandled,
    DMA2_Stream1: Handler = unhandled,
    DMA2_Stream2: Handler = unhandled,
    DMA2_Stream3: Handler = unhandled,
    DMA2_Stream4: Handler = unhandled,
    reserved75: [2]u32 = undefined,
    FDCAN_CAL: Handler = unhandled,
    DFSDM1_FLT4: Handler = unhandled,
    DFSDM1_FLT5: Handler = unhandled,
    DFSDM1_FLT6: Handler = unhandled,
    DFSDM1_FLT7: Handler = unhandled,
    DMA2_Stream5: Handler = unhandled,
    DMA2_Stream6: Handler = unhandled,
    DMA2_Stream7: Handler = unhandled,
    USART6: Handler = unhandled,
    I2C3_EV: Handler = unhandled,
    I2C3_ER: Handler = unhandled,
    OTG_HS_EP1_OUT: Handler = unhandled,
    OTG_HS_EP1_IN: Handler = unhandled,
    OTG_HS_WKUP: Handler = unhandled,
    OTG_HS: Handler = unhandled,
    DCMI_PSSI: Handler = unhandled,
    reserved93: [1]u32 = undefined,
    RNG: Handler = unhandled,
    FPU: Handler = unhandled,
    UART7: Handler = unhandled,
    UART8: Handler = unhandled,
    SPI4: Handler = unhandled,
    SPI5: Handler = unhandled,
    SPI6: Handler = unhandled,
    SAI1: Handler = unhandled,
    LTDC: Handler = unhandled,
    LTDC_ER: Handler = unhandled,
    DMA2D: Handler = unhandled,
    SAI2: Handler = unhandled,
    OCTOSPI1: Handler = unhandled,
    LPTIM1: Handler = unhandled,
    CEC: Handler = unhandled,
    I2C4_EV: Handler = unhandled,
    I2C4_ER: Handler = unhandled,
    SPDIF_RX: Handler = unhandled,
    reserved112: [4]u32 = undefined,
    DMAMUX1_OVR: Handler = unhandled,
    reserved117: [7]u32 = undefined,
    DFSDM1_FLT0: Handler = unhandled,
    DFSDM1_FLT1: Handler = unhandled,
    DFSDM1_FLT2: Handler = unhandled,
    DFSDM1_FLT3: Handler = unhandled,
    reserved128: [1]u32 = undefined,
    SWPMI1: Handler = unhandled,
    TIM15: Handler = unhandled,
    TIM16: Handler = unhandled,
    TIM17: Handler = unhandled,
    MDIOS_WKUP: Handler = unhandled,
    MDIOS: Handler = unhandled,
    JPEG: Handler = unhandled,
    MDMA: Handler = unhandled,
    reserved137: [1]u32 = undefined,
    SDMMC2: Handler = unhandled,
    HSEM1: Handler = unhandled,
    reserved140: [1]u32 = undefined,
    DAC2: Handler = unhandled,
    DMAMUX2_OVR: Handler = unhandled,
    BDMA2_Channel0: Handler = unhandled,
    BDMA2_Channel1: Handler = unhandled,
    BDMA2_Channel2: Handler = unhandled,
    BDMA2_Channel3: Handler = unhandled,
    BDMA2_Channel4: Handler = unhandled,
    BDMA2_Channel5: Handler = unhandled,
    BDMA2_Channel6: Handler = unhandled,
    BDMA2_Channel7: Handler = unhandled,
    COMP: Handler = unhandled,
    LPTIM2: Handler = unhandled,
    LPTIM3: Handler = unhandled,
    UART9: Handler = unhandled,
    USART10: Handler = unhandled,
    LPUART1: Handler = unhandled,
    WWDG_RST: Handler = unhandled,
    CRS: Handler = unhandled,
    ECC: Handler = unhandled,
    reserved160: [1]u32 = undefined,
    DTS: Handler = unhandled,
    reserved162: [1]u32 = undefined,
    WAKEUP_PIN: Handler = unhandled,
    OCTOSPI2: Handler = unhandled,
    reserved165: [2]u32 = undefined,
    GFXMMU: Handler = unhandled,
    BDMA1: Handler = unhandled,
};

pub const peripherals = struct {
    /// Device Factory programmed 96-bit unique device identifier
    pub const UID: *volatile types.peripherals.uid_v1.UID = @ptrFromInt(0x8fff800);
    /// General purpose 32-bit timers
    pub const TIM2: *volatile types.peripherals.timer_v1.TIM_GP32 = @ptrFromInt(0x40000000);
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
    /// 2-channel timers
    pub const TIM12: *volatile types.peripherals.timer_v1.TIM_2CH = @ptrFromInt(0x40001800);
    /// 1-channel timers
    pub const TIM13: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40001c00);
    /// 1-channel timers
    pub const TIM14: *volatile types.peripherals.timer_v1.TIM_1CH = @ptrFromInt(0x40002000);
    /// Low power timer with Output Compare
    pub const LPTIM1: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x40002400);
    /// Serial peripheral interface
    pub const SPI2: *volatile types.peripherals.spi_v3.SPI = @ptrFromInt(0x40003800);
    /// Serial peripheral interface
    pub const SPI3: *volatile types.peripherals.spi_v3.SPI = @ptrFromInt(0x40003c00);
    /// Receiver Interface
    pub const SPDIFRX1: *volatile types.peripherals.spdifrx_h7.SPDIFRX = @ptrFromInt(0x40004000);
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
    /// Inter-integrated circuit
    pub const I2C3: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x40005c00);
    /// CEC.
    pub const CEC: *volatile types.peripherals.cec_v2.CEC = @ptrFromInt(0x40006c00);
    /// Digital-to-analog converter
    pub const DAC1: *volatile types.peripherals.dac_v4.DAC = @ptrFromInt(0x40007400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART7: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40007800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART8: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40007c00);
    /// Clock recovery system
    pub const CRS: *volatile types.peripherals.crs_v1.CRS = @ptrFromInt(0x40008400);
    /// Operational amplifiers.
    pub const OPAMP1: *volatile types.peripherals.opamp_h_v1.OPAMP = @ptrFromInt(0x40009000);
    /// Operational amplifiers.
    pub const OPAMP2: *volatile types.peripherals.opamp_h_v1.OPAMP = @ptrFromInt(0x40009010);
    /// Management data input/output slave
    pub const MDIOS: *volatile types.peripherals.mdios_v1.MDIOS = @ptrFromInt(0x40009400);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN1: *volatile types.peripherals.can_fdcan_h7.FDCAN = @ptrFromInt(0x4000a000);
    /// Controller area network with flexible data rate (FD)
    pub const FDCAN2: *volatile types.peripherals.can_fdcan_h7.FDCAN = @ptrFromInt(0x4000a400);
    /// FDCAN Message RAM
    pub const FDCANRAM: *volatile types.peripherals.fdcanram_h7.FDCANRAM = @ptrFromInt(0x4000ac00);
    /// Advanced Control timers
    pub const TIM1: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40010000);
    /// Advanced Control timers
    pub const TIM8: *volatile types.peripherals.timer_v1.TIM_ADV = @ptrFromInt(0x40010400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART1: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40011000);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART6: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40011400);
    /// Universal synchronous asynchronous receiver transmitter
    pub const UART9: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40011800);
    /// Universal synchronous asynchronous receiver transmitter
    pub const USART10: *volatile types.peripherals.usart_v4.USART = @ptrFromInt(0x40011c00);
    /// Serial peripheral interface
    pub const SPI1: *volatile types.peripherals.spi_v3.SPI = @ptrFromInt(0x40013000);
    /// Serial peripheral interface
    pub const SPI4: *volatile types.peripherals.spi_v3.SPI = @ptrFromInt(0x40013400);
    /// 2-channel with one complementary output timers
    pub const TIM15: *volatile types.peripherals.timer_v1.TIM_2CH_CMP = @ptrFromInt(0x40014000);
    /// 1-channel with one complementary output timers
    pub const TIM16: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014400);
    /// 1-channel with one complementary output timers
    pub const TIM17: *volatile types.peripherals.timer_v1.TIM_1CH_CMP = @ptrFromInt(0x40014800);
    /// Serial audio interface
    pub const SAI1: *volatile types.peripherals.sai_v4_4pdm.SAI = @ptrFromInt(0x40015800);
    /// Serial audio interface
    pub const SAI2: *volatile types.peripherals.sai_v4_4pdm.SAI = @ptrFromInt(0x40015c00);
    /// DMA controller
    pub const DMA1: *volatile types.peripherals.dma_v1.DMA = @ptrFromInt(0x40020000);
    /// DMA controller
    pub const DMA2: *volatile types.peripherals.dma_v1.DMA = @ptrFromInt(0x40020400);
    /// DMAMUX
    pub const DMAMUX1: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x40020800);
    /// Analog to Digital Converter
    pub const ADC1: *volatile types.peripherals.adc_v4.ADC = @ptrFromInt(0x40022000);
    /// Analog to Digital Converter
    pub const ADC2: *volatile types.peripherals.adc_v4.ADC = @ptrFromInt(0x40022100);
    /// Analog-to-Digital Converter
    pub const ADC12_COMMON: *volatile types.peripherals.adccommon_v4.ADC_COMMON = @ptrFromInt(0x40022300);
    /// Cyclic Redundancy Check calculation unit
    pub const CRC: *volatile types.peripherals.crc_v3.CRC = @ptrFromInt(0x40023000);
    /// USB on the go
    pub const USB_OTG_HS: *volatile types.peripherals.otg_v1.OTG = @ptrFromInt(0x40040000);
    /// Digital camera interface
    pub const DCMI: *volatile types.peripherals.dcmi_v1.DCMI = @ptrFromInt(0x48020000);
    /// Parallel synchronous slave interface.
    pub const PSSI: *volatile types.peripherals.pssi_v1.PSSI = @ptrFromInt(0x48020400);
    /// Random number generator
    pub const RNG: *volatile types.peripherals.rng_v1.RNG = @ptrFromInt(0x48021800);
    /// SDMMC
    pub const SDMMC2: *volatile types.peripherals.sdmmc_v2.SDMMC = @ptrFromInt(0x48022400);
    /// DMA controller
    pub const BDMA1: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x48022c00);
    /// LCD-TFT Controller
    pub const LTDC: *volatile types.peripherals.ltdc_v1.LTDC = @ptrFromInt(0x50001000);
    /// Window watchdog
    pub const WWDG1: *volatile types.peripherals.wwdg_v2.WWDG = @ptrFromInt(0x50003000);
    /// DMA2D
    pub const DMA2D: *volatile types.peripherals.dma2d_v2.DMA2D = @ptrFromInt(0x52001000);
    /// Flash
    pub const FLASH: *volatile types.peripherals.flash_h7ab.FLASH = @ptrFromInt(0x52002000);
    /// JPEG codec
    pub const JPEG: *volatile types.peripherals.jpeg_v1.JPEG = @ptrFromInt(0x52003000);
    /// Flexible memory controller
    pub const FMC: *volatile types.peripherals.fmc_v3x1.FMC = @ptrFromInt(0x52004000);
    /// OctoSPI
    pub const OCTOSPI1: *volatile types.peripherals.octospi_v1.OCTOSPI = @ptrFromInt(0x52005000);
    /// SDMMC
    pub const SDMMC1: *volatile types.peripherals.sdmmc_v2.SDMMC = @ptrFromInt(0x52007000);
    /// OctoSPI
    pub const OCTOSPI2: *volatile types.peripherals.octospi_v1.OCTOSPI = @ptrFromInt(0x5200a000);
    /// OctoSPI IO Manager
    pub const OCTOSPIM: *volatile types.peripherals.octospim_v1.OCTOSPIM = @ptrFromInt(0x5200b400);
    /// External interrupt/event controller
    pub const EXTI: *volatile types.peripherals.exti_h7.EXTI = @ptrFromInt(0x58000000);
    /// System configuration controller
    pub const SYSCFG: *volatile types.peripherals.syscfg_h7.SYSCFG = @ptrFromInt(0x58000400);
    /// Low-power Universal synchronous asynchronous receiver transmitter
    pub const LPUART1: *volatile types.peripherals.usart_v4.LPUART = @ptrFromInt(0x58000c00);
    /// Serial peripheral interface
    pub const SPI6: *volatile types.peripherals.spi_v3.SPI = @ptrFromInt(0x58001400);
    /// Inter-integrated circuit
    pub const I2C4: *volatile types.peripherals.i2c_v2.I2C = @ptrFromInt(0x58001c00);
    /// Low power timer with Output Compare
    pub const LPTIM2: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x58002400);
    /// Low power timer with Output Compare
    pub const LPTIM3: *volatile types.peripherals.lptim_v1b_h7.LPTIM = @ptrFromInt(0x58002800);
    /// Digital-to-analog converter
    pub const DAC2: *volatile types.peripherals.dac_v4.DAC = @ptrFromInt(0x58003400);
    /// COMP1.
    pub const COMP1: *volatile types.peripherals.comp_h7_a.COMP = @ptrFromInt(0x5800380c);
    /// COMP1.
    pub const COMP2: *volatile types.peripherals.comp_h7_a.COMP = @ptrFromInt(0x58003810);
    /// Voltage reference buffer.
    pub const VREFBUF: *volatile types.peripherals.vrefbuf_v2a1.VREFBUF = @ptrFromInt(0x58003c00);
    /// Real-time clock
    pub const RTC: *volatile types.peripherals.rtc_v2h7.RTC = @ptrFromInt(0x58004000);
    /// Independent watchdog
    pub const IWDG1: *volatile types.peripherals.iwdg_v2.IWDG = @ptrFromInt(0x58004800);
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
    pub const GPIOI: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58022000);
    /// General-purpose I/Os
    pub const GPIOJ: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58022400);
    /// General-purpose I/Os
    pub const GPIOK: *volatile types.peripherals.gpio_v2.GPIO = @ptrFromInt(0x58022800);
    /// Reset and clock control
    pub const RCC: *volatile types.peripherals.rcc_h7ab.RCC = @ptrFromInt(0x58024400);
    /// PWR
    pub const PWR: *volatile types.peripherals.pwr_h7rm0455.PWR = @ptrFromInt(0x58024800);
    /// DMA controller
    pub const BDMA2: *volatile types.peripherals.bdma_v1.DMA = @ptrFromInt(0x58025400);
    /// DMAMUX
    pub const DMAMUX2: *volatile types.peripherals.dmamux_v1.DMAMUX = @ptrFromInt(0x58025800);
    /// Debug support
    pub const DBGMCU: *volatile types.peripherals.dbgmcu_h7.DBGMCU = @ptrFromInt(0x5c001000);
};
