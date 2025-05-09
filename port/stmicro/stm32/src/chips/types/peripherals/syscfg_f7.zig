const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// memory remap register
    /// offset: 0x00
    MEMRMP: mmio.Mmio(packed struct(u32) {
        /// Memory boot mapping
        MEM_BOOT: u1,
        reserved8: u7 = 0,
        /// Flash bank mode selection
        FB_MODE: u1,
        reserved10: u1 = 0,
        /// FMC memory mapping swap
        SWP_FMC: u2,
        padding: u20 = 0,
    }),
    /// peripheral mode configuration register
    /// offset: 0x04
    PMC: mmio.Mmio(packed struct(u32) {
        /// I2C1_FMP I2C1 Fast Mode + Enable
        I2C1_FMP: u1,
        /// I2C2_FMP I2C2 Fast Mode + Enable
        I2C2_FMP: u1,
        /// I2C3_FMP I2C3 Fast Mode + Enable
        I2C3_FMP: u1,
        /// I2C4 Fast Mode + Enable
        I2C4_FMP: u1,
        /// PB6_FMP Fast Mode
        PB6_FMP: u1,
        /// PB7_FMP Fast Mode + Enable
        PB7_FMP: u1,
        /// PB8_FMP Fast Mode + Enable
        PB8_FMP: u1,
        /// Fast Mode + Enable
        PB9_FMP: u1,
        reserved16: u8 = 0,
        /// ADC3DC2
        ADC1DC2: u1,
        /// ADC2DC2
        ADC2DC2: u1,
        /// ADC3DC2
        ADC3DC2: u1,
        reserved23: u4 = 0,
        /// Ethernet PHY interface selection
        MII_RMII_SEL: u1,
        padding: u8 = 0,
    }),
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI x configuration (x = 0 to 3)
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI x configuration (x = 0 to 3)
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI x configuration (x = 0 to 3)
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI x configuration (x = 0 to 3)
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// Compensation cell control register
    /// offset: 0x20
    CMPCR: mmio.Mmio(packed struct(u32) {
        /// Compensation cell power-down
        CMP_PD: u1,
        reserved8: u7 = 0,
        /// READY
        READY: u1,
        padding: u23 = 0,
    }),
};
