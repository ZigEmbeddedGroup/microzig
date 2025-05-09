const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// memory remap register
    /// offset: 0x00
    MEMRMP: mmio.Mmio(packed struct(u32) {
        /// MEM_MODE
        MEM_MODE: u2,
        reserved8: u6 = 0,
        /// BOOT_MODE
        BOOT_MODE: u2,
        padding: u22 = 0,
    }),
    /// peripheral mode configuration register
    /// offset: 0x04
    PMC: mmio.Mmio(packed struct(u32) {
        /// USB pull-up
        USB_PU: u1,
        /// USB pull-up enable on DP line
        LCD_CAPA: u5,
        padding: u26 = 0,
    }),
    /// external interrupt configuration register 1
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI x configuration (x = 8 to 11)
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI x configuration (x = 8 to 11)
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI x configuration (x = 8 to 11)
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI x configuration (x = 8 to 11)
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
};
