const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const MEM_MODE = enum(u2) {
    /// Main Flash memory mapped at 0x0000_0000
    MainFlash = 0x0,
    /// System Flash memory mapped at 0x0000_0000
    SystemFlash = 0x1,
    /// FSMC Bank1 (NOR/PSRAM 1 and 2) mapped at 0x0000_0000
    FSMC = 0x2,
    /// Embedded SRAM mapped at 0x0000_0000
    SRAM = 0x3,
};

/// System configuration controller
pub const SYSCFG = extern struct {
    /// memory remap register
    /// offset: 0x00
    MEMRMP: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection
        MEM_MODE: MEM_MODE,
        padding: u30 = 0,
    }),
    /// peripheral mode configuration register
    /// offset: 0x04
    PMC: mmio.Mmio(packed struct(u32) {
        reserved23: u23 = 0,
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
        /// Compensation cell ready flag
        READY: u1,
        padding: u23 = 0,
    }),
};
