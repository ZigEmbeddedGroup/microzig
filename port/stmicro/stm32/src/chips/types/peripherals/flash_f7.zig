const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const LATENCY = enum(u4) {
    /// 0 wait states
    WS0 = 0x0,
    /// 1 wait states
    WS1 = 0x1,
    /// 2 wait states
    WS2 = 0x2,
    /// 3 wait states
    WS3 = 0x3,
    /// 4 wait states
    WS4 = 0x4,
    /// 5 wait states
    WS5 = 0x5,
    /// 6 wait states
    WS6 = 0x6,
    /// 7 wait states
    WS7 = 0x7,
    /// 8 wait states
    WS8 = 0x8,
    /// 9 wait states
    WS9 = 0x9,
    /// 10 wait states
    WS10 = 0xa,
    /// 11 wait states
    WS11 = 0xb,
    /// 12 wait states
    WS12 = 0xc,
    /// 13 wait states
    WS13 = 0xd,
    /// 14 wait states
    WS14 = 0xe,
    /// 15 wait states
    WS15 = 0xf,
};

pub const PSIZE = enum(u2) {
    /// Program x8
    PSIZE8 = 0x0,
    /// Program x16
    PSIZE16 = 0x1,
    /// Program x32
    PSIZE32 = 0x2,
    /// Program x64
    PSIZE64 = 0x3,
};

/// FLASH
pub const FLASH = extern struct {
    /// Flash access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: LATENCY,
        reserved8: u4 = 0,
        /// Prefetch enable
        PRFTEN: u1,
        /// ART Accelerator Enable
        ARTEN: u1,
        reserved11: u1 = 0,
        /// ART Accelerator reset
        ARTRST: u1,
        padding: u20 = 0,
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
        /// End of operation
        EOP: u1,
        /// Operation error
        OPERR: u1,
        reserved4: u2 = 0,
        /// Write protection error
        WRPERR: u1,
        /// Programming alignment error
        PGAERR: u1,
        /// Programming parallelism error
        PGPERR: u1,
        /// Erase Sequence Error
        ERSERR: u1,
        /// RDERR
        RDERR: u1,
        reserved16: u7 = 0,
        /// Busy
        BSY: u1,
        padding: u15 = 0,
    }),
    /// Control register
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Sector Erase
        SER: u1,
        /// Mass Erase of sectors 0 to 11
        MER: u1,
        /// Sector number
        SNB: u4,
        reserved8: u1 = 0,
        /// Program size
        PSIZE: PSIZE,
        reserved16: u6 = 0,
        /// Start
        STRT: u1,
        reserved24: u7 = 0,
        /// End of operation interrupt enable
        EOPIE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        /// PCROP error interrupt enable
        RDERRIE: u1,
        reserved31: u4 = 0,
        /// Lock
        LOCK: u1,
    }),
    /// Flash option control register
    /// offset: 0x14
    OPTCR: mmio.Mmio(packed struct(u32) {
        /// Option lock
        OPTLOCK: u1,
        /// Option start
        OPTSTRT: u1,
        /// BOR reset Level
        BOR_LEV: u2,
        /// User option bytes
        WWDG_SW: u1,
        /// WDG_SW User option bytes
        IWDG_SW: u1,
        /// nRST_STOP User option bytes
        nRST_STOP: u1,
        /// nRST_STDBY User option bytes
        nRST_STDBY: u1,
        /// Read protect
        RDP: u8,
        /// Not write protect
        nWRP: u8,
        reserved28: u4 = 0,
        /// Dual Boot mode (valid only when nDBANK=0)
        nDBOOT: u1,
        /// Not dual bank mode
        nDBANK: u1,
        /// Independent watchdog counter freeze in standby mode
        IWDG_STDBY: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
    }),
    /// Flash option control register 1
    /// offset: 0x18
    OPTCR1: mmio.Mmio(packed struct(u32) {
        /// Boot base address when Boot pin =0
        BOOT_ADD0: u16,
        /// Boot base address when Boot pin =1
        BOOT_ADD1: u16,
    }),
    /// Flash option control register
    /// offset: 0x1c
    OPTCR2: mmio.Mmio(packed struct(u32) {
        /// PCROP option byte
        PCROPi: u8,
        reserved31: u23 = 0,
        /// PCROP zone preserved when RDP level decreased
        PCROP_RDP: u1,
    }),
};
