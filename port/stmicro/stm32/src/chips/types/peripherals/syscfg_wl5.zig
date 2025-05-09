const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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
        /// I2C2 Fast-mode Plus driving capability activation
        I2C2_FMP: u1,
        /// I2C3 Fast-mode Plus driving capability activation
        I2C3_FMP: u1,
        padding: u9 = 0,
    }),
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI12 configuration bits
        @"EXTI[0]": u3,
        reserved4: u1 = 0,
        /// (2/4 of EXTI) EXTI12 configuration bits
        @"EXTI[1]": u3,
        reserved8: u1 = 0,
        /// (3/4 of EXTI) EXTI12 configuration bits
        @"EXTI[2]": u3,
        reserved12: u1 = 0,
        /// (4/4 of EXTI) EXTI12 configuration bits
        @"EXTI[3]": u3,
        padding: u17 = 0,
    }),
    /// SCSR
    /// offset: 0x18
    SCSR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 erase
        SRAM2ER: u1,
        /// SRAM1, SRAM2 and PKA SRAM busy by erase operation
        SRAMBSY: u1,
        reserved8: u6 = 0,
        /// PKA SRAM busy by erase operation
        PKASRAMBSY: u1,
        padding: u23 = 0,
    }),
    /// CFGR2
    /// offset: 0x1c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// CPU1 LOCKUP (Hardfault) output enable bit
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
    /// SWPR
    /// offset: 0x20
    SWPR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[0]": u1,
        /// (2/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[1]": u1,
        /// (3/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[2]": u1,
        /// (4/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[3]": u1,
        /// (5/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[4]": u1,
        /// (6/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[5]": u1,
        /// (7/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[6]": u1,
        /// (8/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[7]": u1,
        /// (9/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[8]": u1,
        /// (10/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[9]": u1,
        /// (11/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[10]": u1,
        /// (12/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[11]": u1,
        /// (13/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[12]": u1,
        /// (14/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[13]": u1,
        /// (15/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[14]": u1,
        /// (16/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[15]": u1,
        /// (17/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[16]": u1,
        /// (18/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[17]": u1,
        /// (19/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[18]": u1,
        /// (20/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[19]": u1,
        /// (21/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[20]": u1,
        /// (22/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[21]": u1,
        /// (23/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[22]": u1,
        /// (24/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[23]": u1,
        /// (25/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[24]": u1,
        /// (26/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[25]": u1,
        /// (27/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[26]": u1,
        /// (28/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[27]": u1,
        /// (29/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[28]": u1,
        /// (30/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[29]": u1,
        /// (31/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[30]": u1,
        /// (32/32 of PWP) SRAM2 1Kbyte page 0 write protection
        @"PWP[31]": u1,
    }),
    /// SKR
    /// offset: 0x24
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 write protection key for software erase
        KEY: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    reserved40: [216]u8,
    /// SYSCFG CPU1 interrupt mask register 1
    /// offset: 0x100
    IMR1: mmio.Mmio(packed struct(u32) {
        /// RTCSTAMPTAMPLSECSSIM
        RTCSTAMPTAMPLSECSSIM: u1,
        reserved2: u1 = 0,
        /// RTCSSRUIM
        RTCSSRUIM: u1,
        reserved21: u18 = 0,
        /// EXTI5IM
        EXTI5IM: u1,
        /// EXTI6IM
        EXTI6IM: u1,
        /// EXTI7IM
        EXTI7IM: u1,
        /// EXTI8IM
        EXTI8IM: u1,
        /// EXTI9IM
        EXTI9IM: u1,
        /// EXTI10IM
        EXTI10IM: u1,
        /// EXTI11IM
        EXTI11IM: u1,
        /// EXTI12IM
        EXTI12IM: u1,
        /// EXTI13IM
        EXTI13IM: u1,
        /// EXTI14IM
        EXTI14IM: u1,
        /// EXTI15IM
        EXTI15IM: u1,
    }),
    /// SYSCFG CPU1 interrupt mask register 2
    /// offset: 0x104
    IMR2: mmio.Mmio(packed struct(u32) {
        reserved18: u18 = 0,
        /// PVM3IM
        PVM3IM: u1,
        reserved20: u1 = 0,
        /// PVDIM
        PVDIM: u1,
        padding: u11 = 0,
    }),
    /// SYSCFG CPU2 interrupt mask register 1
    /// offset: 0x108
    C2IMR1: mmio.Mmio(packed struct(u32) {
        /// RTCSTAMPTAMPLSECSSIM
        RTCSTAMPTAMPLSECSSIM: u1,
        /// RTCALARMIM
        RTCALARMIM: u1,
        /// RTCSSRUIM
        RTCSSRUIM: u1,
        /// RTCWKUPIM
        RTCWKUPIM: u1,
        reserved5: u1 = 0,
        /// RCCIM
        RCCIM: u1,
        /// FLASHIM
        FLASHIM: u1,
        reserved8: u1 = 0,
        /// PKAIM
        PKAIM: u1,
        reserved10: u1 = 0,
        /// AESIM
        AESIM: u1,
        /// COMPIM
        COMPIM: u1,
        /// ADCIM
        ADCIM: u1,
        /// DACIM
        DACIM: u1,
        reserved16: u2 = 0,
        /// EXTI0IM
        EXTI0IM: u1,
        /// EXTI1IM
        EXTI1IM: u1,
        /// EXTI2IM
        EXTI2IM: u1,
        /// EXTI3IM
        EXTI3IM: u1,
        /// EXTI4IM
        EXTI4IM: u1,
        /// EXTI5IM
        EXTI5IM: u1,
        /// EXTI6IM
        EXTI6IM: u1,
        /// EXTI7IM
        EXTI7IM: u1,
        /// EXTI8IM
        EXTI8IM: u1,
        /// EXTI9IM
        EXTI9IM: u1,
        /// EXTI10IM
        EXTI10IM: u1,
        /// EXTI11IM
        EXTI11IM: u1,
        /// EXTI12IM
        EXTI12IM: u1,
        /// EXTI13IM
        EXTI13IM: u1,
        /// EXTI14IM
        EXTI14IM: u1,
        /// EXTI15IM
        EXTI15IM: u1,
    }),
    /// SYSCFG CPU2 interrupt mask register 2
    /// offset: 0x10c
    C2IMR2: mmio.Mmio(packed struct(u32) {
        /// DMA1CH1IM
        DMA1CH1IM: u1,
        /// DMA1CH2IM
        DMA1CH2IM: u1,
        /// DMA1CH3IM
        DMA1CH3IM: u1,
        /// DMA1CH4IM
        DMA1CH4IM: u1,
        /// DMA1CH5IM
        DMA1CH5IM: u1,
        /// DMA1CH6IM
        DMA1CH6IM: u1,
        /// DMA1CH7IM
        DMA1CH7IM: u1,
        reserved8: u1 = 0,
        /// DMA2CH1IM
        DMA2CH1IM: u1,
        /// DMA2CH2IM
        DMA2CH2IM: u1,
        /// DMA2CH3IM
        DMA2CH3IM: u1,
        /// DMA2CH4IM
        DMA2CH4IM: u1,
        /// DMA2CH5IM
        DMA2CH5IM: u1,
        /// DMA2CH6IM
        DMA2CH6IM: u1,
        /// DMA2CH7IM
        DMA2CH7IM: u1,
        /// DMAMUX1IM
        DMAMUX1IM: u1,
        reserved18: u2 = 0,
        /// PVM3IM
        PVM3IM: u1,
        reserved20: u1 = 0,
        /// PVDIM
        PVDIM: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x110
    reserved272: [248]u8,
    /// radio debug control register
    /// offset: 0x208
    RFDCR: mmio.Mmio(packed struct(u32) {
        /// radio debug test bus selection
        RFTBSEL: u1,
        padding: u31 = 0,
    }),
};
