const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const WAYSEL = enum(u1) {
    /// direct mapped cache (1-way cache)
    DirectMapped = 0x0,
    /// n-way set associative cache (reset value)
    NWaySetAssociative = 0x1,
};

/// Instruction Cache Control Registers.
pub const ICACHE = extern struct {
    /// ICACHE control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// EN.
        EN: u1,
        /// Set by software and cleared by hardware when the BUSYF flag is set (during cache maintenance operation). Writing 0 has no effect.
        CACHEINV: u1,
        /// This bit allows user to choose ICACHE set-associativity. It can be written by software only when cache is disabled (EN = 0).
        WAYSEL: WAYSEL,
        reserved16: u13 = 0,
        /// Hit monitor enable.
        HITMEN: u1,
        /// Miss monitor enable.
        MISSMEN: u1,
        /// Hit monitor reset.
        HITMRST: u1,
        /// Miss monitor reset.
        MISSMRST: u1,
        padding: u12 = 0,
    }),
    /// ICACHE status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// cache busy executing a full invalidate CACHEINV operation.
        BUSYF: u1,
        /// full invalidate CACHEINV operation finished.
        BSYENDF: u1,
        /// an error occurred during the operation.
        ERRF: u1,
        padding: u29 = 0,
    }),
    /// ICACHE interrupt enable register.
    /// offset: 0x08
    IER: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Interrupt enable on busy end.
        BSYENDIE: u1,
        /// Error interrupt on cache error.
        ERRIE: u1,
        padding: u29 = 0,
    }),
    /// ICACHE flag clear register.
    /// offset: 0x0c
    FCR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Clear busy end flag.
        CBSYENDF: u1,
        /// Clear ERRF flag in SR.
        CERRF: u1,
        padding: u29 = 0,
    }),
    /// ICACHE hit monitor register.
    /// offset: 0x10
    HMONR: u32,
    /// ICACHE miss monitor register.
    /// offset: 0x14
    MMONR: mmio.Mmio(packed struct(u32) {
        /// Miss monitor register.
        MISSMON: u16,
        padding: u16 = 0,
    }),
};
