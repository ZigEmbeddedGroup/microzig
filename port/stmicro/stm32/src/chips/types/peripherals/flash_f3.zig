const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const LATENCY = enum(u3) {
    /// 0 wait states, if 0 < HCLK <= 24 MHz
    WS0 = 0x0,
    /// 1 wait state, if 24 < HCLK <= 48 MHz
    WS1 = 0x1,
    /// 2 wait states, if 48 < HCLK <= 72 MHz
    WS2 = 0x2,
    _,
};

pub const RDPRT = enum(u2) {
    /// Level 0
    Level0 = 0x0,
    /// Level 1
    Level1 = 0x1,
    /// Level 2
    Level2 = 0x3,
    _,
};

pub const WDG_SW = enum(u1) {
    /// Hardware watchdog
    Hardware = 0x0,
    /// Software watchdog
    Software = 0x1,
};

pub const nRST_STDBY = enum(u1) {
    /// Reset generated when entering Standby mode
    Reset = 0x0,
    /// No reset generated
    NoReset = 0x1,
};

pub const nRST_STOP = enum(u1) {
    /// Reset generated when entering Stop mode
    Reset = 0x0,
    /// No reset generated
    NoReset = 0x1,
};

/// Flash
pub const FLASH = extern struct {
    /// Flash access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// LATENCY
        LATENCY: LATENCY,
        /// Flash half cycle access enable
        HLFCYA: u1,
        /// PRFTBE
        PRFTBE: u1,
        /// PRFTBS
        PRFTBS: u1,
        padding: u26 = 0,
    }),
    /// Flash key register
    /// offset: 0x04
    KEYR: u32,
    /// Flash option key register
    /// offset: 0x08
    OPTKEYR: u32,
    /// Flash status register
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
    /// Flash control register
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page erase
        PER: u1,
        /// Mass erase
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
        /// Force option byte loading
        OBL_LAUNCH: u1,
        padding: u18 = 0,
    }),
    /// Flash address register
    /// offset: 0x14
    AR: mmio.Mmio(packed struct(u32) {
        /// Flash address
        FAR: u32,
    }),
    /// offset: 0x18
    reserved24: [4]u8,
    /// Option byte register
    /// offset: 0x1c
    OBR: mmio.Mmio(packed struct(u32) {
        /// Option byte error
        OPTERR: u1,
        /// Read protection Level status
        RDPRT: RDPRT,
        reserved8: u5 = 0,
        /// WDG_SW
        WDG_SW: WDG_SW,
        /// nRST_STOP
        nRST_STOP: nRST_STOP,
        /// nRST_STDBY
        nRST_STDBY: nRST_STDBY,
        reserved12: u1 = 0,
        /// BOOT1
        nBOOT1: u1,
        /// VDDA_MONITOR
        VDDA_MONITOR: u1,
        /// SRAM_PARITY_CHECK
        SRAM_PARITY_CHECK: u1,
        /// SDADC12_VDD_MONITOR
        SDADC12_VDD_MONITOR: u1,
        /// Data0
        Data0: u8,
        /// Data1
        Data1: u8,
    }),
    /// Write protection register
    /// offset: 0x20
    WRPR: mmio.Mmio(packed struct(u32) {
        /// Write protect
        WRP: u32,
    }),
};
