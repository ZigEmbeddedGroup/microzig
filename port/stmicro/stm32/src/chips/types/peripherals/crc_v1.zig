const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Cyclic Redundancy Check calculation unit
pub const CRC = extern struct {
    /// Data register
    /// offset: 0x00
    DR: u32,
    /// Independent Data register
    /// offset: 0x04
    IDR: u32,
    /// Control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// RESET bit
        RESET: u1,
        padding: u31 = 0,
    }),
};
