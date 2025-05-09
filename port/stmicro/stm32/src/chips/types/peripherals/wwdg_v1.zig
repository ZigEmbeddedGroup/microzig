const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const WDGTB = enum(u2) {
    /// Counter clock (PCLK1 div 4096) div 1
    Div1 = 0x0,
    /// Counter clock (PCLK1 div 4096) div 2
    Div2 = 0x1,
    /// Counter clock (PCLK1 div 4096) div 4
    Div4 = 0x2,
    /// Counter clock (PCLK1 div 4096) div 8
    Div8 = 0x3,
};

/// Window watchdog
pub const WWDG = extern struct {
    /// Control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// 7-bit counter (MSB to LSB)
        T: u7,
        /// Watchdog activated
        WDGA: u1,
        padding: u24 = 0,
    }),
    /// Configuration register
    /// offset: 0x04
    CFR: mmio.Mmio(packed struct(u32) {
        /// 7-bit window value
        W: u7,
        /// Timer base
        WDGTB: WDGTB,
        /// Early wakeup interrupt
        EWI: u1,
        padding: u22 = 0,
    }),
    /// Status register
    /// offset: 0x08
    SR: mmio.Mmio(packed struct(u32) {
        /// Early wakeup interrupt flag
        EWIF: u1,
        padding: u31 = 0,
    }),
};
