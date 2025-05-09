const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Data cache.
pub const DCACHE = extern struct {
    /// DCACHE control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// enable.
        EN: u1,
        /// full cache invalidation Can be set by software, only when EN = 1. Cleared by hardware when the BUSYF flag is set (during full cache invalidation operation). Writing 0 has no effect.
        CACHEINV: u1,
        reserved8: u6 = 0,
        /// cache command maintenance operation (cleans and/or invalidates an address range) Can be set and cleared by software, only when no maintenance command is ongoing (BUSYCMDF = 0). others: reserved.
        CACHECMD: u3,
        /// starts maintenance command (maintenance operation defined in CACHECMD). Can be set by software, only when EN = 1, BUSYCMDF = 0, BUSYF = 0 and CACHECMD = 0b001, 0b010 or 0b011. Cleared by hardware when the BUSYCMDF flag is set (during cache maintenance operation). Writing 0 has no effect.
        STARTCMD: u1,
        reserved16: u4 = 0,
        /// read-hit monitor enable.
        RHITMEN: u1,
        /// read-miss monitor enable.
        RMISSMEN: u1,
        /// read-hit monitor reset.
        RHITMRST: u1,
        /// read-miss monitor reset.
        RMISSMRST: u1,
        /// write-hit monitor enable.
        WHITMEN: u1,
        /// write-miss monitor enable.
        WMISSMEN: u1,
        /// write-hit monitor reset.
        WHITMRST: u1,
        /// write-miss monitor reset.
        WMISSMRST: u1,
        reserved31: u7 = 0,
        /// output burst type for cache master port read accesses Write access is always done in INCR burst type.
        HBURST: u1,
    }),
    /// DCACHE status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// full invalidate busy flag.
        BUSYF: u1,
        /// full invalidate busy end flag Cleared by writing DCACHE_FCR.CBSYENDF = 1.
        BSYENDF: u1,
        /// cache error flag Cleared by writing DCACHE_FCR.CERRF = 1.
        ERRF: u1,
        /// command busy flag.
        BUSYCMDF: u1,
        /// command end flag Cleared by writing DCACHE_FCR.CCMDENDF = 1.
        CMDENDF: u1,
        padding: u27 = 0,
    }),
    /// DCACHE interrupt enable register.
    /// offset: 0x08
    IER: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// interrupt enable on busy end Set by SW to enable an interrupt generation at the end of a cache full invalidate operation.
        BSYENDIE: u1,
        /// interrupt enable on cache error Set by software to enable an interrupt generation in case of cache functional error (eviction or clean operation write-back error).
        ERRIE: u1,
        reserved4: u1 = 0,
        /// interrupt enable on command end Set by software to enable an interrupt generation at the end of a cache command (clean and/or invalidate an address range).
        CMDENDIE: u1,
        padding: u27 = 0,
    }),
    /// DCACHE flag clear register.
    /// offset: 0x0c
    FCR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// clear full invalidate busy end flag Set by software.
        CBSYENDF: u1,
        /// clear cache error flag Set by software.
        CERRF: u1,
        reserved4: u1 = 0,
        /// clear command end flag Set by software.
        CCMDENDF: u1,
        padding: u27 = 0,
    }),
    /// DCACHE read-hit monitor register.
    /// offset: 0x10
    RHMONR: u32,
    /// DCACHE read-miss monitor register.
    /// offset: 0x14
    RMMONR: mmio.Mmio(packed struct(u32) {
        /// cache read-miss monitor counter.
        RMISSMON: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// DCACHE write-hit monitor register.
    /// offset: 0x20
    WHMONR: u32,
    /// DCACHE write-miss monitor register.
    /// offset: 0x24
    WMMONR: mmio.Mmio(packed struct(u32) {
        /// cache write-miss monitor counter.
        WMISSMON: u16,
        padding: u16 = 0,
    }),
    /// DCACHE command range start address register.
    /// offset: 0x28
    CMDRSADDRR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// start address of range to which the cache maintenance command specified in DCACHE_CR.CACHECMD field applies This register must be set before DCACHE_CR.CACHECMD is written..
        CMDSTARTADDR: u28,
    }),
    /// DCACHE command range end address register.
    /// offset: 0x2c
    CMDREADDRR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// end address of range to which the cache maintenance command specified in DCACHE_CR.CACHECMD field applies This register must be set before DCACHE_CR.CACHECMD is written.
        CMDENDADDR: u28,
    }),
};
