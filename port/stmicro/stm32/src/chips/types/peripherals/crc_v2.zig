const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const POLYSIZE = enum(u2) {
    /// 32-bit polynomial
    Polysize32 = 0x0,
    /// 16-bit polynomial
    Polysize16 = 0x1,
    /// 8-bit polynomial
    Polysize8 = 0x2,
    /// 7-bit polynomial
    Polysize7 = 0x3,
};

pub const REV_IN = enum(u2) {
    /// Bit order not affected
    Normal = 0x0,
    /// Bit reversal done by byte
    Byte = 0x1,
    /// Bit reversal done by half-word
    HalfWord = 0x2,
    /// Bit reversal done by word
    Word = 0x3,
};

pub const REV_OUT = enum(u1) {
    /// Bit order not affected
    Normal = 0x0,
    /// Bit reversed output
    Reversed = 0x1,
};

/// Cyclic Redundancy Check calculation unit
pub const CRC = extern struct {
    /// Data register - half-word sized
    /// offset: 0x00
    DR16: u32,
    /// Independent Data register
    /// offset: 0x04
    IDR: u32,
    /// Control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// RESET bit
        RESET: u1,
        reserved3: u2 = 0,
        /// Polynomial size
        POLYSIZE: POLYSIZE,
        /// Reverse input data
        REV_IN: REV_IN,
        /// Reverse output data
        REV_OUT: REV_OUT,
        padding: u24 = 0,
    }),
    /// offset: 0x0c
    reserved12: [4]u8,
    /// Initial CRC value
    /// offset: 0x10
    INIT: u32,
};
