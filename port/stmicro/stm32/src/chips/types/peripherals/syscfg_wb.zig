const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// memory remap register
    /// offset: 0x00
    MEMRMP: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection
        MEM_MODE: u3,
        padding: u29 = 0,
    }),
    /// configuration register 1
    /// offset: 0x04
    CFGR1: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// I/O analog switch voltage booster enable
        BOOSTEN: u1,
        reserved16: u7 = 0,
        /// Fast-mode Plus (Fm+) driving capability activation on PB6
        I2C_PB6_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB7
        I2C_PB7_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB8
        I2C_PB8_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB9
        I2C_PB9_FMP: u1,
        /// I2C1 Fast-mode Plus driving capability activation
        I2C1_FMP: u1,
        reserved22: u1 = 0,
        /// I2C3 Fast-mode Plus driving capability activation
        I2C3_FMP: u1,
        reserved26: u3 = 0,
        /// Floating Point Unit interrupts enable bits
        FPU_IE: u6,
    }),
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI 0 configuration bits
        @"EXTI[0]": u3,
        reserved4: u1 = 0,
        /// (2/4 of EXTI) EXTI 0 configuration bits
        @"EXTI[1]": u3,
        reserved8: u1 = 0,
        /// (3/4 of EXTI) EXTI 0 configuration bits
        @"EXTI[2]": u3,
        reserved12: u1 = 0,
        /// (4/4 of EXTI) EXTI 0 configuration bits
        @"EXTI[3]": u3,
        padding: u17 = 0,
    }),
    /// SCSR
    /// offset: 0x18
    SCSR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 Erase
        SRAM2ER: u1,
        /// SRAM2 busy by erase operation
        SRAM2BSY: u1,
        reserved31: u29 = 0,
        /// CPU2 SRAM fetch (execution) disable.
        C2RFD: u1,
    }),
    /// CFGR2
    /// offset: 0x1c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex-M4 LOCKUP (Hardfault) output enable bit
        CLL: u1,
        /// SRAM2 parity lock bit
        SPL: u1,
        /// PVD lock enable bit
        PVDL: u1,
        /// ECC Lock
        ECCL: u1,
        reserved8: u4 = 0,
        /// SRAM2 parity error flag
        SPF: u1,
        padding: u23 = 0,
    }),
    /// SRAM2 write protection register
    /// offset: 0x20
    SWPR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of PWP) P0WP
        @"PWP[0]": u1,
        /// (2/32 of PWP) P0WP
        @"PWP[1]": u1,
        /// (3/32 of PWP) P0WP
        @"PWP[2]": u1,
        /// (4/32 of PWP) P0WP
        @"PWP[3]": u1,
        /// (5/32 of PWP) P0WP
        @"PWP[4]": u1,
        /// (6/32 of PWP) P0WP
        @"PWP[5]": u1,
        /// (7/32 of PWP) P0WP
        @"PWP[6]": u1,
        /// (8/32 of PWP) P0WP
        @"PWP[7]": u1,
        /// (9/32 of PWP) P0WP
        @"PWP[8]": u1,
        /// (10/32 of PWP) P0WP
        @"PWP[9]": u1,
        /// (11/32 of PWP) P0WP
        @"PWP[10]": u1,
        /// (12/32 of PWP) P0WP
        @"PWP[11]": u1,
        /// (13/32 of PWP) P0WP
        @"PWP[12]": u1,
        /// (14/32 of PWP) P0WP
        @"PWP[13]": u1,
        /// (15/32 of PWP) P0WP
        @"PWP[14]": u1,
        /// (16/32 of PWP) P0WP
        @"PWP[15]": u1,
        /// (17/32 of PWP) P0WP
        @"PWP[16]": u1,
        /// (18/32 of PWP) P0WP
        @"PWP[17]": u1,
        /// (19/32 of PWP) P0WP
        @"PWP[18]": u1,
        /// (20/32 of PWP) P0WP
        @"PWP[19]": u1,
        /// (21/32 of PWP) P0WP
        @"PWP[20]": u1,
        /// (22/32 of PWP) P0WP
        @"PWP[21]": u1,
        /// (23/32 of PWP) P0WP
        @"PWP[22]": u1,
        /// (24/32 of PWP) P0WP
        @"PWP[23]": u1,
        /// (25/32 of PWP) P0WP
        @"PWP[24]": u1,
        /// (26/32 of PWP) P0WP
        @"PWP[25]": u1,
        /// (27/32 of PWP) P0WP
        @"PWP[26]": u1,
        /// (28/32 of PWP) P0WP
        @"PWP[27]": u1,
        /// (29/32 of PWP) P0WP
        @"PWP[28]": u1,
        /// (30/32 of PWP) P0WP
        @"PWP[29]": u1,
        /// (31/32 of PWP) P0WP
        @"PWP[30]": u1,
        /// (32/32 of PWP) P0WP
        @"PWP[31]": u1,
    }),
    /// SKR
    /// offset: 0x24
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 write protection key for software erase
        KEY: u8,
        padding: u24 = 0,
    }),
    /// SRAM2 write protection register 2
    /// offset: 0x28
    SWPR2: mmio.Mmio(packed struct(u32) {
        /// (1/32 of PWP) P32WP
        @"PWP[0]": u1,
        /// (2/32 of PWP) P32WP
        @"PWP[1]": u1,
        /// (3/32 of PWP) P32WP
        @"PWP[2]": u1,
        /// (4/32 of PWP) P32WP
        @"PWP[3]": u1,
        /// (5/32 of PWP) P32WP
        @"PWP[4]": u1,
        /// (6/32 of PWP) P32WP
        @"PWP[5]": u1,
        /// (7/32 of PWP) P32WP
        @"PWP[6]": u1,
        /// (8/32 of PWP) P32WP
        @"PWP[7]": u1,
        /// (9/32 of PWP) P32WP
        @"PWP[8]": u1,
        /// (10/32 of PWP) P32WP
        @"PWP[9]": u1,
        /// (11/32 of PWP) P32WP
        @"PWP[10]": u1,
        /// (12/32 of PWP) P32WP
        @"PWP[11]": u1,
        /// (13/32 of PWP) P32WP
        @"PWP[12]": u1,
        /// (14/32 of PWP) P32WP
        @"PWP[13]": u1,
        /// (15/32 of PWP) P32WP
        @"PWP[14]": u1,
        /// (16/32 of PWP) P32WP
        @"PWP[15]": u1,
        /// (17/32 of PWP) P32WP
        @"PWP[16]": u1,
        /// (18/32 of PWP) P32WP
        @"PWP[17]": u1,
        /// (19/32 of PWP) P32WP
        @"PWP[18]": u1,
        /// (20/32 of PWP) P32WP
        @"PWP[19]": u1,
        /// (21/32 of PWP) P32WP
        @"PWP[20]": u1,
        /// (22/32 of PWP) P32WP
        @"PWP[21]": u1,
        /// (23/32 of PWP) P32WP
        @"PWP[22]": u1,
        /// (24/32 of PWP) P32WP
        @"PWP[23]": u1,
        /// (25/32 of PWP) P32WP
        @"PWP[24]": u1,
        /// (26/32 of PWP) P32WP
        @"PWP[25]": u1,
        /// (27/32 of PWP) P32WP
        @"PWP[26]": u1,
        /// (28/32 of PWP) P32WP
        @"PWP[27]": u1,
        /// (29/32 of PWP) P32WP
        @"PWP[28]": u1,
        /// (30/32 of PWP) P32WP
        @"PWP[29]": u1,
        /// (31/32 of PWP) P32WP
        @"PWP[30]": u1,
        /// (32/32 of PWP) P32WP
        @"PWP[31]": u1,
    }),
    /// offset: 0x2c
    reserved44: [212]u8,
    /// CPU1 interrupt mask register 1
    /// offset: 0x100
    IMR1: mmio.Mmio(packed struct(u32) {
        reserved13: u13 = 0,
        /// Peripheral TIM1 interrupt mask to CPU1
        TIM1IM: u1,
        /// Peripheral TIM16 interrupt mask to CPU1
        TIM16IM: u1,
        /// Peripheral TIM17 interrupt mask to CPU1
        TIM17IM: u1,
        reserved21: u5 = 0,
        /// Peripheral EXIT5 interrupt mask to CPU1
        EXIT5IM: u1,
        /// Peripheral EXIT6 interrupt mask to CPU1
        EXIT6IM: u1,
        /// Peripheral EXIT7 interrupt mask to CPU1
        EXIT7IM: u1,
        /// Peripheral EXIT8 interrupt mask to CPU1
        EXIT8IM: u1,
        /// Peripheral EXIT9 interrupt mask to CPU1
        EXIT9IM: u1,
        /// Peripheral EXIT10 interrupt mask to CPU1
        EXIT10IM: u1,
        /// Peripheral EXIT11 interrupt mask to CPU1
        EXIT11IM: u1,
        /// Peripheral EXIT12 interrupt mask to CPU1
        EXIT12IM: u1,
        /// Peripheral EXIT13 interrupt mask to CPU1
        EXIT13IM: u1,
        /// Peripheral EXIT14 interrupt mask to CPU1
        EXIT14IM: u1,
        /// Peripheral EXIT15 interrupt mask to CPU1
        EXIT15IM: u1,
    }),
    /// CPU1 interrupt mask register 2
    /// offset: 0x104
    IMR2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Peripheral PVM1 interrupt mask to CPU1
        PVM1IM: u1,
        reserved18: u1 = 0,
        /// Peripheral PVM3 interrupt mask to CPU1
        PVM3IM: u1,
        reserved20: u1 = 0,
        /// Peripheral PVD interrupt mask to CPU1
        PVDIM: u1,
        padding: u11 = 0,
    }),
    /// CPU2 interrupt mask register 1
    /// offset: 0x108
    C2IMR1: mmio.Mmio(packed struct(u32) {
        /// Peripheral RTCSTAMP interrupt mask to CPU2
        RTCSTAMP: u1,
        reserved3: u2 = 0,
        /// Peripheral RTCWKUP interrupt mask to CPU2
        RTCWKUP: u1,
        /// Peripheral RTCALARM interrupt mask to CPU2
        RTCALARM: u1,
        /// Peripheral RCC interrupt mask to CPU2
        RCC: u1,
        /// Peripheral FLASH interrupt mask to CPU2
        FLASH: u1,
        reserved8: u1 = 0,
        /// Peripheral PKA interrupt mask to CPU2
        PKA: u1,
        /// Peripheral RNG interrupt mask to CPU2
        RNG: u1,
        /// Peripheral AES1 interrupt mask to CPU2
        AES1: u1,
        /// Peripheral COMP interrupt mask to CPU2
        COMP: u1,
        /// Peripheral ADC interrupt mask to CPU2
        ADC: u1,
        padding: u19 = 0,
    }),
    /// CPU2 interrupt mask register 1
    /// offset: 0x10c
    C2IMR2: mmio.Mmio(packed struct(u32) {
        /// Peripheral DMA1 CH1 interrupt mask to CPU2
        DMA1_CH1_IM: u1,
        /// Peripheral DMA1 CH2 interrupt mask to CPU2
        DMA1_CH2_IM: u1,
        /// Peripheral DMA1 CH3 interrupt mask to CPU2
        DMA1_CH3_IM: u1,
        /// Peripheral DMA1 CH4 interrupt mask to CPU2
        DMA1_CH4_IM: u1,
        /// Peripheral DMA1 CH5 interrupt mask to CPU2
        DMA1_CH5_IM: u1,
        /// Peripheral DMA1 CH6 interrupt mask to CPU2
        DMA1_CH6_IM: u1,
        /// Peripheral DMA1 CH7 interrupt mask to CPU2
        DMA1_CH7_IM: u1,
        reserved8: u1 = 0,
        /// Peripheral DMA2 CH1 interrupt mask to CPU1
        DMA2_CH1_IM: u1,
        /// Peripheral DMA2 CH2 interrupt mask to CPU1
        DMA2_CH2_IM: u1,
        /// Peripheral DMA2 CH3 interrupt mask to CPU1
        DMA2_CH3_IM: u1,
        /// Peripheral DMA2 CH4 interrupt mask to CPU1
        DMA2_CH4_IM: u1,
        /// Peripheral DMA2 CH5 interrupt mask to CPU1
        DMA2_CH5_IM: u1,
        /// Peripheral DMA2 CH6 interrupt mask to CPU1
        DMA2_CH6_IM: u1,
        /// Peripheral DMA2 CH7 interrupt mask to CPU1
        DMA2_CH7_IM: u1,
        /// Peripheral DMAM UX1 interrupt mask to CPU1
        DMAM_UX1_IM: u1,
        /// Peripheral PVM1IM interrupt mask to CPU1
        PVM1IM: u1,
        reserved18: u1 = 0,
        /// Peripheral PVM3IM interrupt mask to CPU1
        PVM3IM: u1,
        reserved20: u1 = 0,
        /// Peripheral PVDIM interrupt mask to CPU1
        PVDIM: u1,
        /// Peripheral TSCIM interrupt mask to CPU1
        TSCIM: u1,
        /// Peripheral LCDIM interrupt mask to CPU1
        LCDIM: u1,
        padding: u9 = 0,
    }),
    /// secure IP control register
    /// offset: 0x110
    SIPCR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SAES) Enable AES1 KEY[7:0] security.
        @"SAES[0]": u1,
        /// (2/2 of SAES) Enable AES1 KEY[7:0] security.
        @"SAES[1]": u1,
        /// Enable PKA security
        SPKA: u1,
        /// Enable True RNG security
        SRNG: u1,
        padding: u28 = 0,
    }),
};
