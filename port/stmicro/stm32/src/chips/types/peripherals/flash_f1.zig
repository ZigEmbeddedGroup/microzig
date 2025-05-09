const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const LATENCY = enum(u3) {
    /// Zero wait state, if 0 < SYSCLK≤ 24 MHz
    WS0 = 0x0,
    /// One wait state, if 24 MHz < SYSCLK ≤ 48 MHz
    WS1 = 0x1,
    /// Two wait states, if 48 MHz < SYSCLK ≤ 72 MHz
    WS2 = 0x2,
    _,
};

/// FLASH
pub const FLASH = extern struct {
    /// Flash access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: LATENCY,
        /// Flash half cycle access enable
        HLFCYA: u1,
        /// Prefetch buffer enable
        PRFTBE: u1,
        /// Prefetch buffer status
        PRFTBS: u1,
        padding: u26 = 0,
    }),
    /// Flash key register
    /// offset: 0x04
    KEYR: u32,
    /// Flash option key register
    /// offset: 0x08
    OPTKEYR: u32,
    /// Status register
    /// offset: 0x0c
    SR: mmio.Mmio(packed struct(u32) {
        /// Busy
        BSY: u1,
        reserved2: u1 = 0,
        /// Programming error
        PGERR: u1,
        reserved4: u1 = 0,
        /// Write protection error
        WRPRTERR: u1,
        /// End of operation
        EOP: u1,
        padding: u26 = 0,
    }),
    /// Control register
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page Erase
        PER: u1,
        /// Mass Erase
        MER: u1,
        reserved4: u1 = 0,
        /// Option byte programming
        OPTPG: u1,
        /// Option byte erase
        OPTER: u1,
        /// Start
        STRT: u1,
        /// Lock
        LOCK: u1,
        reserved9: u1 = 0,
        /// Option bytes write enable
        OPTWRE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        reserved12: u1 = 0,
        /// End of operation interrupt enable
        EOPIE: u1,
        padding: u19 = 0,
    }),
    /// Flash address register
    /// offset: 0x14
    AR: mmio.Mmio(packed struct(u32) {
        /// Flash Address
        FAR: u32,
    }),
    /// offset: 0x18
    reserved24: [4]u8,
    /// Option byte register
    /// offset: 0x1c
    OBR: mmio.Mmio(packed struct(u32) {
        /// Option byte error
        OPTERR: u1,
        /// Read protection
        RDPRT: u1,
        /// WDG_SW
        WDG_SW: u1,
        /// nRST_STOP
        nRST_STOP: u1,
        /// nRST_STDBY
        nRST_STDBY: u1,
        reserved10: u5 = 0,
        /// Data0
        Data0: u8,
        /// Data1
        Data1: u8,
        padding: u6 = 0,
    }),
    /// Write protection register
    /// offset: 0x20
    WRPR: mmio.Mmio(packed struct(u32) {
        /// Write protect
        WRP: u32,
    }),
};
