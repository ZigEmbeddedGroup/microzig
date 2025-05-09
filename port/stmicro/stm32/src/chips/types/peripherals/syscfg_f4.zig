const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// memory remap register
    /// offset: 0x00
    MEMRM: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection
        MEM_MODE: u3,
        reserved8: u5 = 0,
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
        reserved16: u16 = 0,
        /// ADC1DC2
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
