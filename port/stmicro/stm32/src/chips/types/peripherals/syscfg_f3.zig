const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADC12_EXT13_RMP = enum(u1) {
    /// Trigger source is TIM6_TRGO
    Tim6 = 0x0,
    /// Trigger source is TIM20_CC2
    Tim20 = 0x1,
};

pub const ADC12_EXT15_RMP = enum(u1) {
    /// Trigger source is TIM3_CC4
    Tim3 = 0x0,
    /// Trigger source is TIM20_CC3
    Tim20 = 0x1,
};

pub const ADC12_EXT2_RMP = enum(u1) {
    /// Trigger source is TIM3_CC3
    Tim1 = 0x0,
    /// rigger source is TIM20_TRGO
    Tim20 = 0x1,
};

pub const ADC12_EXT3_RMP = enum(u1) {
    /// Trigger source is TIM2_CC2
    Tim2 = 0x0,
    /// rigger source is TIM20_TRGO2
    Tim20 = 0x1,
};

pub const ADC12_EXT5_RMP = enum(u1) {
    /// Trigger source is TIM4_CC4
    Tim4 = 0x0,
    /// Trigger source is TIM20_CC1
    Tim20 = 0x1,
};

pub const ADC12_JEXT13_RMP = enum(u1) {
    /// Trigger source is TIM3_CC1
    Tim3 = 0x0,
    /// Trigger source is TIM20_CC4
    Tim20 = 0x1,
};

pub const ADC12_JEXT3_RMP = enum(u1) {
    /// Trigger source is TIM2_CC1
    Tim2 = 0x0,
    /// Trigger source is TIM20_TRGO
    Tim20 = 0x1,
};

pub const ADC12_JEXT6_RMP = enum(u1) {
    /// Trigger source is EXTI line 15
    Exti15 = 0x0,
    /// Trigger source is TIM20_TRGO2
    Tim20 = 0x1,
};

pub const ADC2_DMA_RMP_CFGR3 = enum(u2) {
    /// ADC2 mapped on DMA1 channel 2
    MapDma1Ch2 = 0x2,
    /// ADC2 mapped on DMA1 channel 4
    MapDma1Ch4 = 0x3,
    _,
};

pub const ADC34_EXT15_RMP = enum(u1) {
    /// Trigger source is TIM2_CC1
    Tim2 = 0x0,
    /// Trigger source is TIM20_CC1
    Tim20 = 0x1,
};

pub const ADC34_EXT5_RMP = enum(u1) {
    /// Trigger source is EXTI line 2 when reset at 0
    Exti2 = 0x0,
    /// Trigger source is TIM20_TRGO
    Tim20 = 0x1,
};

pub const ADC34_EXT6_RMP = enum(u1) {
    /// Trigger source is TIM4_CC1
    Tim4 = 0x0,
    /// Trigger source is TIM20_TRGO2
    Tim20 = 0x1,
};

pub const ADC34_JEXT11_RMP = enum(u1) {
    /// Trigger source is TIM1_CC3
    Tim1 = 0x0,
    /// Trigger source is TIM20_TRGO2
    Tim20 = 0x1,
};

pub const ADC34_JEXT14_RMP = enum(u1) {
    /// Trigger source is TIM7_TRGO
    Tim7 = 0x0,
    /// Trigger source is TIM20_CC2
    Tim20 = 0x1,
};

pub const ADC34_JEXT5_RMP = enum(u1) {
    /// Trigger source is TIM4_CC3
    Tim4 = 0x0,
    /// Trigger source is TIM20_TRGO
    Tim20 = 0x1,
};

pub const DAC1_TRIG3_RMP = enum(u1) {
    /// DAC trigger is TIM15_TRGO
    Tim15 = 0x0,
    /// DAC trigger is HRTIM1_DAC1_TRIG1
    HrTim1 = 0x1,
};

pub const ENCODER_MODE = enum(u2) {
    /// No redirection
    NoRedirection = 0x0,
    /// TIM2 IC1 and TIM2 IC2 are connected to TIM15 IC1 and TIM15 IC2 respectively
    MapTim2Tim15 = 0x1,
    /// TIM3 IC1 and TIM3 IC2 are connected to TIM15 IC1 and TIM15 IC2 respectively
    MapTim3Tim15 = 0x2,
    _,
};

pub const FMP = enum(u1) {
    /// Standard
    Standard = 0x0,
    /// FM+
    FMP = 0x1,
};

pub const I2C1_RX_DMA_RMP = enum(u2) {
    /// I2C1_RX mapped on DMA1 CH7
    MapDma1Ch7 = 0x0,
    /// I2C1_RX mapped on DMA1 CH3
    MapDma1Ch3 = 0x1,
    /// I2C1_RX mapped on DMA1 CH5
    MapDma1Ch5 = 0x2,
    _,
};

pub const I2C1_TX_DMA_RMP = enum(u2) {
    /// I2C1_TX mapped on DMA1 CH6
    MapDma1Ch6 = 0x0,
    /// I2C1_TX mapped on DMA1 CH2
    MapDma1Ch2 = 0x1,
    /// I2C1_TX mapped on DMA1 CH4
    MapDma1Ch4 = 0x2,
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

pub const SPI1_RX_DMA_RMP = enum(u2) {
    /// SPI1_RX mapped on DMA1 CH2
    MapDma1Ch3 = 0x0,
    /// SPI1_RX mapped on DMA1 CH4
    MapDma1Ch5 = 0x1,
    /// SPI1_RX mapped on DMA1 CH6
    MapDma1Ch7 = 0x2,
    _,
};

pub const SPI1_TX_DMA_RMP = enum(u2) {
    /// SPI1_TX mapped on DMA1 CH3
    MapDma1Ch3 = 0x0,
    /// SPI1_TX mapped on DMA1 CH5
    MapDma1Ch5 = 0x1,
    /// SPI1_TX mapped on DMA1 CH7
    MapDma1Ch7 = 0x2,
    _,
};

/// System configuration controller
pub const SYSCFG = extern struct {
    /// configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection bits
        MEM_MODE: MEM_MODE,
        reserved5: u3 = 0,
        /// USB interrupt remap 0: USB_HP, USB_LP and USB_WAKEUP interrupts are mapped on interrupt lines 19, 20 and 42 respectively 1: USB_HP, USB_LP and USB_WAKEUP interrupts are mapped on interrupt lines 74, 75 and 76 respectively
        USB_IT_RMP: u1,
        /// Timer 1 ITR3 selection 0: Not remapped 1: TIM1_ITR3 = TIM17_OC
        TIM1_ITR3_RMP: u1,
        /// DAC trigger remap (when TSEL = 001) 0: DAC trigger is TIM8_TRGO in STM32F303xB/C and STM32F358xC devices 1: DAC trigger is TIM3_TRGO
        DAC1_TRIG_RMP: u1,
        /// ADC24 DMA remapping bit 0: ADC24 DMA requests mapped on DMA2 channels 1 and 2 1: ADC24 DMA requests mapped on DMA2 channels 3 and 4
        ADC2_DMA_RMP: u1,
        reserved11: u2 = 0,
        /// TIM16 DMA request remapping bit 0: TIM16_CH1 and TIM16_UP DMA requests mapped on DMA channel 3 1: TIM16_CH1 and TIM16_UP DMA requests mapped on DMA channel 4
        TIM16_DMA_RMP: u1,
        /// TIM17 DMA request remapping bit 0: TIM17_CH1 and TIM17_UP DMA requests mapped on DMA channel 1 1: TIM17_CH1 and TIM17_UP DMA requests mapped on DMA channel 2
        TIM17_DMA_RMP: u1,
        /// TIM6 and DAC1 DMA request remapping bit 0: TIM6_UP and DAC_CH1 DMA requests mapped on DMA2 channel 3 1: TIM6_UP and DAC_CH1 DMA requests mapped on DMA1 channel 3
        TIM6_DAC1_CH1_DMA_RMP: u1,
        /// TIM7 and DAC2 DMA request remapping bit 0: Not remapped 1: TIM7_UP and DAC_CH2 DMA requests mapped on DMA1 channel 4
        TIM7_DAC1_CH2_DMA_RMP: u1,
        /// DAC2 channel1 DMA remap 0: Not remapped 1: DAC2_CH1 DMA requests mapped on DMA1 channel 5
        DAC2_CH1_DMA_RMP: u1,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB6 pin operate in standard mode 1: I2C FM+ mode enabled on PB6 and the Speed control is bypassed
        I2C_PB6_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB7 pin operate in standard mode 1: I2C FM+ mode enabled on PB7 and the Speed control is bypassed
        I2C_PB7_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB8 pin operate in standard mode 1: I2C FM+ mode enabled on PB8 and the Speed control is bypassed
        I2C_PB8_FMP: FMP,
        /// Fast Mode Plus (FM+) driving capability activation bits. 0: PB9 pin operate in standard mode 1: I2C FM+ mode enabled on PB9 and the Speed control is bypassed
        I2C_PB9_FMP: FMP,
        /// I2C1 Fast Mode Plus 0: FM+ mode is controlled by I2C_Pxx_FMP bits only 1: FM+ mode is enabled on all I2C1 pins selected through selection through IOPORT control registers AF selection bits
        I2C1_FMP: FMP,
        /// I2C2 Fast Mode Plus 0: FM+ mode is controlled by I2C_Pxx_FMP bits only 1: FM+ mode is enabled on all I2C2 pins selected through selection through IOPORT control registers AF selection bits
        I2C2_FMP: FMP,
        /// Encoder mode
        ENCODER_MODE: ENCODER_MODE,
        /// I2C3 Fast Mode Plus 0: FM+ mode is controlled by I2C_Pxx_FMP bits only 1: FM+ mode is enabled on all I2C3 pins selected through selection trhough IOPORT control registers AF selection bits
        I2C3_FMP: FMP,
        reserved26: u1 = 0,
        /// (1/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[0]": u1,
        /// (2/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[1]": u1,
        /// (3/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[2]": u1,
        /// (4/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[3]": u1,
        /// (5/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[4]": u1,
        /// (6/6 of FPU_IE) Idx 0: Invalid operation interrupt enable; Idx 1: Devide-by-zero interrupt enable; Idx 2: Underflow interrupt enable; Idx 3: Overflow interrupt enable; Idx 4: Input denormal interrupt enable; Idx 5: Inexact interrupt enable
        @"FPU_IE[5]": u1,
    }),
    /// CCM SRAM protection register
    /// offset: 0x04
    RCR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[0]": u1,
        /// (2/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[1]": u1,
        /// (3/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[2]": u1,
        /// (4/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[3]": u1,
        /// (5/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[4]": u1,
        /// (6/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[5]": u1,
        /// (7/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[6]": u1,
        /// (8/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[7]": u1,
        /// (9/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[8]": u1,
        /// (10/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[9]": u1,
        /// (11/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[10]": u1,
        /// (12/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[11]": u1,
        /// (13/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[12]": u1,
        /// (14/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[13]": u1,
        /// (15/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[14]": u1,
        /// (16/16 of PAGE_WP) CCM SRAM page x write protection enabled
        @"PAGE_WP[15]": u1,
        padding: u16 = 0,
    }),
    /// external interrupt configuration register
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI x configuration
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI x configuration
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI x configuration
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI x configuration
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
        reserved4: u1 = 0,
        /// Bypass address bit 29 in parity calculation
        BYP_ADDR_PAR: u1,
        reserved8: u3 = 0,
        /// SRAM parity flag
        SRAM_PEF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x1c
    reserved28: [44]u8,
    /// configuration register 4
    /// offset: 0x48
    CFGR4: mmio.Mmio(packed struct(u32) {
        /// Controls the Input trigger of ADC12 regular channel EXT2
        ADC12_EXT2_RMP: ADC12_EXT2_RMP,
        /// Controls the Input trigger of ADC12 regular channel EXT3
        ADC12_EXT3_RMP: ADC12_EXT3_RMP,
        /// Controls the Input trigger of ADC12 regular channel EXT5
        ADC12_EXT5_RMP: ADC12_EXT5_RMP,
        /// Controls the Input trigger of ADC12 regular channel EXT13
        ADC12_EXT13_RMP: ADC12_EXT13_RMP,
        /// Controls the Input trigger of ADC12 regular channel EXT15
        ADC12_EXT15_RMP: ADC12_EXT15_RMP,
        /// Controls the Input trigger of ADC12 injected channel JEXT3
        ADC12_JEXT3_RMP: ADC12_JEXT3_RMP,
        /// Controls the Input trigger of ADC12 injected channel JEXT6
        ADC12_JEXT6_RMP: ADC12_JEXT6_RMP,
        /// Controls the Input trigger of ADC12 injected channel JEXT13
        ADC12_JEXT13_RMP: ADC12_JEXT13_RMP,
        /// Controls the Input trigger of ADC34 regular channel EXT5
        ADC34_EXT5_RMP: ADC34_EXT5_RMP,
        /// Controls the Input trigger of ADC34 regular channel EXT6
        ADC34_EXT6_RMP: ADC34_EXT6_RMP,
        /// Controls the Input trigger of ADC34 regular channel EXT15
        ADC34_EXT15_RMP: ADC34_EXT15_RMP,
        /// Controls the Input trigger of ADC34 injected channel JEXT5
        ADC34_JEXT5_RMP: ADC34_JEXT5_RMP,
        /// Controls the Input trigger of ADC34 injected channel JEXT11
        ADC34_JEXT11_RMP: ADC34_JEXT11_RMP,
        /// Controls the Input trigger of ADC34 injected channel JEXT14
        ADC34_JEXT14_RMP: ADC34_JEXT14_RMP,
        padding: u18 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// configuration register 3
    /// offset: 0x50
    CFGR3: mmio.Mmio(packed struct(u32) {
        /// SPI1_RX DMA remapping bit
        SPI1_RX_DMA_RMP: SPI1_RX_DMA_RMP,
        /// SPI1_TX DMA remapping bit
        SPI1_TX_DMA_RMP: SPI1_TX_DMA_RMP,
        /// I2C1_RX DMA remapping bit
        I2C1_RX_DMA_RMP: I2C1_RX_DMA_RMP,
        /// I2C1_TX DMA remapping bit
        I2C1_TX_DMA_RMP: I2C1_TX_DMA_RMP,
        /// ADC2 DMA remapping bit
        ADC2_DMA_RMP: ADC2_DMA_RMP_CFGR3,
        reserved16: u6 = 0,
        /// DAC1_CH1 / DAC1_CH2 Trigger remap
        DAC1_TRIG3_RMP: DAC1_TRIG3_RMP,
        /// DAC1_CH1 / DAC1_CH2 Trigger remap 0: Not remapped 1: DAC trigger is HRTIM1_DAC1_TRIG2
        DAC1_TRIG5_RMP: u1,
        padding: u14 = 0,
    }),
};
