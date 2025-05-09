const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Alternate function I/O
pub const AFIO = extern struct {
    /// Event Control Register (AFIO_EVCR)
    /// offset: 0x00
    EVCR: mmio.Mmio(packed struct(u32) {
        /// Pin selection
        PIN: u4,
        /// Port selection
        PORT: u3,
        /// Event Output Enable
        EVOE: u1,
        padding: u24 = 0,
    }),
    /// AF remap and debug I/O configuration register (AFIO_MAPR)
    /// offset: 0x04
    MAPR: mmio.Mmio(packed struct(u32) {
        /// SPI1 remapping
        SPI1_REMAP: u1,
        /// I2C1 remapping
        I2C1_REMAP: u1,
        /// USART1 remapping
        USART1_REMAP: u1,
        /// USART2 remapping
        USART2_REMAP: u1,
        /// USART3 remapping
        USART3_REMAP: u2,
        /// TIM1 remapping
        TIM1_REMAP: u2,
        /// TIM2 remapping
        TIM2_REMAP: u2,
        /// TIM3 remapping
        TIM3_REMAP: u2,
        /// TIM4 remapping
        TIM4_REMAP: u1,
        /// CAN1 remapping
        CAN1_REMAP: u2,
        /// Port D0/Port D1 mapping on OSCIN/OSCOUT
        PD01_REMAP: u1,
        /// Set and cleared by software
        TIM5CH4_IREMAP: u1,
        /// ADC 1 External trigger injected conversion remapping
        ADC1_ETRGINJ_REMAP: u1,
        /// ADC 1 external trigger regular conversion remapping
        ADC1_ETRGREG_REMAP: u1,
        /// ADC 2 external trigger injected conversion remapping
        ADC2_ETRGINJ_REMAP: u1,
        /// ADC 2 external trigger regular conversion remapping
        ADC2_ETRGREG_REMAP: u1,
        /// Ethernet MAC I/O remapping
        ETH_REMAP: u1,
        /// CAN2 I/O remapping
        CAN2_REMAP: u1,
        /// MII or RMII selection
        MII_RMII_SEL: u1,
        /// Serial wire JTAG configuration
        SWJ_CFG: u3,
        reserved28: u1 = 0,
        /// SPI3/I2S3 remapping
        SPI3_REMAP: u1,
        /// TIM2 internal trigger 1 remapping
        TIM2ITR1_IREMAP: u1,
        /// Ethernet PTP PPS remapping
        PTP_PPS_REMAP: u1,
        padding: u1 = 0,
    }),
    /// External interrupt configuration register 1 (AFIO_EXTICR1)
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI12 configuration
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI12 configuration
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI12 configuration
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI12 configuration
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [4]u8,
    /// AF remap and debug I/O configuration register
    /// offset: 0x1c
    MAPR2: mmio.Mmio(packed struct(u32) {
        /// TIM15 remapping
        TIM15_REMAP: u1,
        /// TIM16 remapping
        TIM16_REMAP: u1,
        /// TIM17 remapping
        TIM17_REMAP: u1,
        /// CEC remapping
        CEC_REMAP: u1,
        /// TIM1 DMA remapping
        TIM1_DMA_REMAP: u1,
        /// TIM9 remapping
        TIM9_REMAP: u1,
        /// TIM10 remapping
        TIM10_REMAP: u1,
        /// TIM11 remapping
        TIM11_REMAP: u1,
        /// TIM13 remapping
        TIM13_REMAP: u1,
        /// TIM14 remapping
        TIM14_REMAP: u1,
        /// NADV connect/disconnect
        FSMC_NADV: u1,
        /// TIM67_DAC DMA remapping
        TIM67_DAC_DMA_REMAP: u1,
        /// TIM12 remapping
        TIM12_REMAP: u1,
        /// Miscellaneous features remapping
        MISC_REMAP: u1,
        padding: u18 = 0,
    }),
};
