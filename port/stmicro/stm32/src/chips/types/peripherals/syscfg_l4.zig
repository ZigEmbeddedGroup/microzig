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
        /// QUADSPI memory mapping swap
        QFS: u1,
        reserved8: u4 = 0,
        /// Flash Bank mode selection
        FB_MODE: u1,
        padding: u23 = 0,
    }),
    /// configuration register 1
    /// offset: 0x04
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Firewall disable
        FWDIS: u1,
        reserved8: u7 = 0,
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
        reserved26: u3 = 0,
        /// Floating Point Unit interrupts enable bits
        FPU_IE: u6,
    }),
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI12 configuration bits
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI12 configuration bits
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI12 configuration bits
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI12 configuration bits
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// SCSR
    /// offset: 0x18
    SCSR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 Erase
        SRAM2ER: u1,
        /// SRAM2 busy by erase operation
        SRAM2BSY: u1,
        padding: u30 = 0,
    }),
    /// CFGR2
    /// offset: 0x1c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex LOCKUP (Hardfault) output enable bit
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
        /// (1/32 of PWP) SRAWM2 write protection.
        @"PWP[0]": u1,
        /// (2/32 of PWP) SRAWM2 write protection.
        @"PWP[1]": u1,
        /// (3/32 of PWP) SRAWM2 write protection.
        @"PWP[2]": u1,
        /// (4/32 of PWP) SRAWM2 write protection.
        @"PWP[3]": u1,
        /// (5/32 of PWP) SRAWM2 write protection.
        @"PWP[4]": u1,
        /// (6/32 of PWP) SRAWM2 write protection.
        @"PWP[5]": u1,
        /// (7/32 of PWP) SRAWM2 write protection.
        @"PWP[6]": u1,
        /// (8/32 of PWP) SRAWM2 write protection.
        @"PWP[7]": u1,
        /// (9/32 of PWP) SRAWM2 write protection.
        @"PWP[8]": u1,
        /// (10/32 of PWP) SRAWM2 write protection.
        @"PWP[9]": u1,
        /// (11/32 of PWP) SRAWM2 write protection.
        @"PWP[10]": u1,
        /// (12/32 of PWP) SRAWM2 write protection.
        @"PWP[11]": u1,
        /// (13/32 of PWP) SRAWM2 write protection.
        @"PWP[12]": u1,
        /// (14/32 of PWP) SRAWM2 write protection.
        @"PWP[13]": u1,
        /// (15/32 of PWP) SRAWM2 write protection.
        @"PWP[14]": u1,
        /// (16/32 of PWP) SRAWM2 write protection.
        @"PWP[15]": u1,
        /// (17/32 of PWP) SRAWM2 write protection.
        @"PWP[16]": u1,
        /// (18/32 of PWP) SRAWM2 write protection.
        @"PWP[17]": u1,
        /// (19/32 of PWP) SRAWM2 write protection.
        @"PWP[18]": u1,
        /// (20/32 of PWP) SRAWM2 write protection.
        @"PWP[19]": u1,
        /// (21/32 of PWP) SRAWM2 write protection.
        @"PWP[20]": u1,
        /// (22/32 of PWP) SRAWM2 write protection.
        @"PWP[21]": u1,
        /// (23/32 of PWP) SRAWM2 write protection.
        @"PWP[22]": u1,
        /// (24/32 of PWP) SRAWM2 write protection.
        @"PWP[23]": u1,
        /// (25/32 of PWP) SRAWM2 write protection.
        @"PWP[24]": u1,
        /// (26/32 of PWP) SRAWM2 write protection.
        @"PWP[25]": u1,
        /// (27/32 of PWP) SRAWM2 write protection.
        @"PWP[26]": u1,
        /// (28/32 of PWP) SRAWM2 write protection.
        @"PWP[27]": u1,
        /// (29/32 of PWP) SRAWM2 write protection.
        @"PWP[28]": u1,
        /// (30/32 of PWP) SRAWM2 write protection.
        @"PWP[29]": u1,
        /// (31/32 of PWP) SRAWM2 write protection.
        @"PWP[30]": u1,
        /// (32/32 of PWP) SRAWM2 write protection.
        @"PWP[31]": u1,
    }),
    /// SKR
    /// offset: 0x24
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 write protection key for software erase
        KEY: u8,
        padding: u24 = 0,
    }),
};
