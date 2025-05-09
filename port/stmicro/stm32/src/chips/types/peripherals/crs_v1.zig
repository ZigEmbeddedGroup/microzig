const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const SYNCSRC = enum(u2) {
    /// GPIO selected as SYNC signal source
    GPIO = 0x0,
    /// LSE selected as SYNC signal source
    LSE = 0x1,
    /// USB SOF selected as SYNC signal source
    USB = 0x2,
    _,
};

/// Clock recovery system
pub const CRS = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// SYNC event OK interrupt enable
        SYNCOKIE: u1,
        /// SYNC warning interrupt enable
        SYNCWARNIE: u1,
        /// Synchronization or trimming error interrupt enable
        ERRIE: u1,
        /// Expected SYNC interrupt enable
        ESYNCIE: u1,
        reserved5: u1 = 0,
        /// Frequency error counter enable
        CEN: u1,
        /// Automatic trimming enable
        AUTOTRIMEN: u1,
        /// Generate software SYNC event
        SWSYNC: u1,
        /// HSI48 oscillator smooth trimming
        TRIM: u6,
        padding: u18 = 0,
    }),
    /// configuration register
    /// offset: 0x04
    CFGR: mmio.Mmio(packed struct(u32) {
        /// Counter reload value
        RELOAD: u16,
        /// Frequency error limit
        FELIM: u8,
        /// SYNC divider
        SYNCDIV: u3,
        reserved28: u1 = 0,
        /// SYNC signal source selection
        SYNCSRC: SYNCSRC,
        reserved31: u1 = 0,
        /// SYNC polarity selection
        SYNCPOL: u1,
    }),
    /// interrupt and status register
    /// offset: 0x08
    ISR: mmio.Mmio(packed struct(u32) {
        /// SYNC event OK flag
        SYNCOKF: u1,
        /// SYNC warning flag
        SYNCWARNF: u1,
        /// Error flag
        ERRF: u1,
        /// Expected SYNC flag
        ESYNCF: u1,
        reserved8: u4 = 0,
        /// SYNC error
        SYNCERR: u1,
        /// SYNC missed
        SYNCMISS: u1,
        /// Trimming overflow or underflow
        TRIMOVF: u1,
        reserved15: u4 = 0,
        /// Frequency error direction
        FEDIR: u1,
        /// Frequency error capture
        FECAP: u16,
    }),
    /// interrupt flag clear register
    /// offset: 0x0c
    ICR: mmio.Mmio(packed struct(u32) {
        /// SYNC event OK clear flag
        SYNCOKC: u1,
        /// SYNC warning clear flag
        SYNCWARNC: u1,
        /// Error clear flag
        ERRC: u1,
        /// Expected SYNC clear flag
        ESYNCC: u1,
        padding: u28 = 0,
    }),
};
