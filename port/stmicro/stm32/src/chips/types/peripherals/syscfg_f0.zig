const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const FMP = enum(u1) {
    /// Standard
    Standard = 0x0,
    /// FM+
    FMP = 0x1,
};

pub const IR_MOD = enum(u2) {
    /// TIM16 selected
    TIM16 = 0x0,
    /// USART1 selected
    USART1 = 0x1,
    /// USART4 selected
    USART4 = 0x2,
    _,
};

pub const MEM_MODE = enum(u2) {
    /// Main Flash memory mapped at 0x0000_0000
    MainFlash = 0x0,
    /// System Flash memory mapped at 0x0000_0000
    SystemFlash = 0x1,
    /// Main Flash memory mapped at 0x0000_0000
    MainFlash2 = 0x2,
    /// Embedded SRAM mapped at 0x0000_0000
    SRAM = 0x3,
};

/// System configuration controller
pub const SYSCFG = extern struct {
    /// configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection bits
        MEM_MODE: MEM_MODE,
        reserved4: u2 = 0,
        /// PA11 and PA12 remapping bit for small packages (28 and 20 pins) 0: Pin pair PA9/PA10 mapped on the pins 1: Pin pair PA11/PA12 mapped instead of PA9/PA10
        PA11_PA12_RMP: u1,
        reserved6: u1 = 0,
        /// IR Modulation Envelope signal selection
        IR_MOD: IR_MOD,
        /// ADC DMA remapping bit 0: ADC DMA request mapped on DMA channel 1 1: ADC DMA request mapped on DMA channel 2
        ADC_DMA_RMP: u1,
        /// USART1_TX DMA remapping bit 0: USART1_TX DMA request mapped on DMA channel 2 1: USART1_TX DMA request mapped on DMA channel 4
        USART1_TX_DMA_RMP: u1,
        /// USART1_RX DMA request remapping bit 0: USART1_RX DMA request mapped on DMA channel 3 1: USART1_RX DMA request mapped on DMA channel 5
        USART1_RX_DMA_RMP: u1,
        /// TIM16 DMA request remapping bit 0: TIM16_CH1 and TIM16_UP DMA request mapped on DMA channel 3 1: TIM16_CH1 and TIM16_UP DMA request mapped on DMA channel 4
        TIM16_DMA_RMP: u1,
        /// TIM17 DMA request remapping bit 0: TIM17_CH1 and TIM17_UP DMA request mapped on DMA channel 1 1: TIM17_CH1 and TIM17_UP DMA request mapped on DMA channel 2
        TIM17_DMA_RMP: u1,
        /// TIM16 alternate DMA request remapping bit 0: TIM16 DMA request mapped according to TIM16_DMA_RMP bit 1: TIM16_CH1 and TIM16_UP DMA request mapped on DMA channel 6
        TIM16_DMA_RMP2: u1,
        /// TIM17 alternate DMA request remapping bit 0: TIM17 DMA request mapped according to TIM16_DMA_RMP bit 1: TIM17_CH1 and TIM17_UP DMA request mapped on DMA channel 7
        TIM17_DMA_RMP2: u1,
        reserved16: u1 = 0,
        /// Fast Mode Plus (FM plus) driving capability activation bits. 0: PB6 pin operate in standard mode 1: I2C FM+ mode enabled on PB6 and the Speed control is bypassed
        I2C_PB6_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB7 pin operate in standard mode 1: I2C FM+ mode enabled on PB7 and the Speed control is bypassed
        I2C_PB7_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB8 pin operate in standard mode 1: I2C FM+ mode enabled on PB8 and the Speed control is bypassed
        I2C_PB8_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB9 pin operate in standard mode 1: I2C FM+ mode enabled on PB9 and the Speed control is bypassed
        I2C_PB9_FMP: FMP,
        /// FM+ driving capability activation for I2C1 0: FM+ mode is controlled by I2C_Pxx_FMP bits only 1: FM+ mode is enabled on all I2C1 pins selected through selection bits in GPIOx_AFR registers
        I2C1_FMP: FMP,
        /// FM+ driving capability activation for I2C2 0: FM+ mode is controlled by I2C_Pxx_FMP bits only 1: FM+ mode is enabled on all I2C2 pins selected through selection bits in GPIOx_AFR registers
        I2C2_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits 0: PA9 pin operate in standard mode 1: I2C FM+ mode enabled on PA9 and the Speed control is bypassed
        I2C_PA9_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits 0: PA10 pin operate in standard mode 1: I2C FM+ mode enabled on PA10 and the Speed control is bypassed
        I2C_PA10_FMP: FMP,
        /// SPI2 DMA request remapping bit 0: SPI2_RX and SPI2_TX DMA requests mapped on DMA channel 4 and 5 respectively 1: SPI2_RX and SPI2_TX DMA requests mapped on DMA channel 6 and 7 respectively
        SPI2_DMA_RMP: u1,
        /// USART2 DMA request remapping bit 0: USART2_RX and USART2_TX DMA requests mapped on DMA channel 5 and 4 respectively 1: USART2_RX and USART2_TX DMA requests mapped on DMA channel 6 and 7 respectively
        USART2_DMA_RMP: u1,
        /// USART3 DMA request remapping bit 0: USART3_RX and USART3_TX DMA requests mapped on DMA channel 6 and 7 respectively (or simply disabled on STM32F0x0) 1: USART3_RX and USART3_TX DMA requests mapped on DMA channel 3 and 2 respectively
        USART3_DMA_RMP: u1,
        /// I2C1 DMA request remapping bit 0: I2C1_RX and I2C1_TX DMA requests mapped on DMA channel 3 and 2 respectively 1: I2C1_RX and I2C1_TX DMA requests mapped on DMA channel 7 and 6 respectively
        I2C1_DMA_RMP: u1,
        /// TIM1 DMA request remapping bit 0: TIM1_CH1, TIM1_CH2 and TIM1_CH3 DMA requests mapped on DMA channel 2, 3 and 4 respectively 1: TIM1_CH1, TIM1_CH2 and TIM1_CH3 DMA requests mapped on DMA channel 6
        TIM1_DMA_RMP: u1,
        /// TIM2 DMA request remapping bit 0: TIM2_CH2 and TIM2_CH4 DMA requests mapped on DMA channel 3 and 4 respectively 1: TIM2_CH2 and TIM2_CH4 DMA requests mapped on DMA channel 7
        TIM2_DMA_RMP: u1,
        /// TIM3 DMA request remapping bit 0: TIM3_CH1 and TIM3_TRIG DMA requests mapped on DMA channel 4 1: TIM3_CH1 and TIM3_TRIG DMA requests mapped on DMA channel 6
        TIM3_DMA_RMP: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI configuration bits
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI configuration bits
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI configuration bits
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI configuration bits
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// configuration register 2
    /// offset: 0x18
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex-M0 LOCKUP bit enable bit
        LOCKUP_LOCK: u1,
        /// SRAM parity lock bit
        SRAM_PARITY_LOCK: u1,
        /// PVD lock enable bit
        PVD_LOCK: u1,
        reserved8: u5 = 0,
        /// SRAM parity flag
        SRAM_PEF: u1,
        padding: u23 = 0,
    }),
};
