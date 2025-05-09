const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// Remap Memory register
    /// offset: 0x00
    MEMRMP: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection
        MEM_MODE: u3,
        reserved8: u5 = 0,
        /// User Flash Bank mode
        FB_mode: u1,
        padding: u23 = 0,
    }),
    /// peripheral mode configuration register
    /// offset: 0x04
    CFGR1: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// BOOSTEN
        BOOSTEN: u1,
        /// GPIO analog switch control voltage selection
        ANASWVDD: u1,
        reserved16: u6 = 0,
        /// FM+ drive capability on PB6
        I2C_PB6_FMP: u1,
        /// FM+ drive capability on PB6
        I2C_PB7_FMP: u1,
        /// FM+ drive capability on PB6
        I2C_PB8_FMP: u1,
        /// FM+ drive capability on PB6
        I2C_PB9_FMP: u1,
        /// I2C1 FM+ drive capability enable
        I2C1_FMP: u1,
        /// I2C1 FM+ drive capability enable
        I2C2_FMP: u1,
        /// I2C1 FM+ drive capability enable
        I2C3_FMP: u1,
        /// I2C1 FM+ drive capability enable
        I2C4_FMP: u1,
        reserved26: u2 = 0,
        /// FPU Interrupts Enable
        FPU_IE: u6,
    }),
    /// external interrupt configuration register 1
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
    /// CCM SRAM control and status register
    /// offset: 0x18
    SCSR: mmio.Mmio(packed struct(u32) {
        /// CCM SRAM Erase
        CCMER: u1,
        /// CCM SRAM busy by erase operation
        CCMBSY: u1,
        padding: u30 = 0,
    }),
    /// configuration register 2
    /// offset: 0x1c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Core Lockup Lock
        CLL: u1,
        /// SRAM Parity Lock
        SPL: u1,
        /// PVD Lock
        PVDL: u1,
        /// ECC Lock
        ECCL: u1,
        reserved8: u4 = 0,
        /// SRAM Parity Flag
        SPF: u1,
        padding: u23 = 0,
    }),
    /// SRAM Write protection register 1
    /// offset: 0x20
    SWPR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of Page_WP) Write protection
        @"Page_WP[0]": u1,
        /// (2/32 of Page_WP) Write protection
        @"Page_WP[1]": u1,
        /// (3/32 of Page_WP) Write protection
        @"Page_WP[2]": u1,
        /// (4/32 of Page_WP) Write protection
        @"Page_WP[3]": u1,
        /// (5/32 of Page_WP) Write protection
        @"Page_WP[4]": u1,
        /// (6/32 of Page_WP) Write protection
        @"Page_WP[5]": u1,
        /// (7/32 of Page_WP) Write protection
        @"Page_WP[6]": u1,
        /// (8/32 of Page_WP) Write protection
        @"Page_WP[7]": u1,
        /// (9/32 of Page_WP) Write protection
        @"Page_WP[8]": u1,
        /// (10/32 of Page_WP) Write protection
        @"Page_WP[9]": u1,
        /// (11/32 of Page_WP) Write protection
        @"Page_WP[10]": u1,
        /// (12/32 of Page_WP) Write protection
        @"Page_WP[11]": u1,
        /// (13/32 of Page_WP) Write protection
        @"Page_WP[12]": u1,
        /// (14/32 of Page_WP) Write protection
        @"Page_WP[13]": u1,
        /// (15/32 of Page_WP) Write protection
        @"Page_WP[14]": u1,
        /// (16/32 of Page_WP) Write protection
        @"Page_WP[15]": u1,
        /// (17/32 of Page_WP) Write protection
        @"Page_WP[16]": u1,
        /// (18/32 of Page_WP) Write protection
        @"Page_WP[17]": u1,
        /// (19/32 of Page_WP) Write protection
        @"Page_WP[18]": u1,
        /// (20/32 of Page_WP) Write protection
        @"Page_WP[19]": u1,
        /// (21/32 of Page_WP) Write protection
        @"Page_WP[20]": u1,
        /// (22/32 of Page_WP) Write protection
        @"Page_WP[21]": u1,
        /// (23/32 of Page_WP) Write protection
        @"Page_WP[22]": u1,
        /// (24/32 of Page_WP) Write protection
        @"Page_WP[23]": u1,
        /// (25/32 of Page_WP) Write protection
        @"Page_WP[24]": u1,
        /// (26/32 of Page_WP) Write protection
        @"Page_WP[25]": u1,
        /// (27/32 of Page_WP) Write protection
        @"Page_WP[26]": u1,
        /// (28/32 of Page_WP) Write protection
        @"Page_WP[27]": u1,
        /// (29/32 of Page_WP) Write protection
        @"Page_WP[28]": u1,
        /// (30/32 of Page_WP) Write protection
        @"Page_WP[29]": u1,
        /// (31/32 of Page_WP) Write protection
        @"Page_WP[30]": u1,
        /// (32/32 of Page_WP) Write protection
        @"Page_WP[31]": u1,
    }),
    /// SRAM2 Key Register
    /// offset: 0x24
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 Key for software erase
        KEY: u8,
        padding: u24 = 0,
    }),
};
