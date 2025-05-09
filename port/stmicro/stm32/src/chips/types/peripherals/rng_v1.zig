const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Random number generator
pub const RNG = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Random number generator enable
        RNGEN: u1,
        /// Interrupt enable
        IE: u1,
        reserved5: u1 = 0,
        /// Clock error detection
        CED: u1,
        padding: u26 = 0,
    }),
    /// status register
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// Data ready
        DRDY: u1,
        /// Clock error current status
        CECS: u1,
        /// Seed error current status
        SECS: u1,
        reserved5: u2 = 0,
        /// Clock error interrupt status
        CEIS: u1,
        /// Seed error interrupt status
        SEIS: u1,
        padding: u25 = 0,
    }),
    /// data register
    /// offset: 0x08
    DR: u32,
};
