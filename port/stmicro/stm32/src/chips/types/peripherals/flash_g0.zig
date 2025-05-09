const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BORF_LEV = enum(u2) {
    /// BOR falling level 1 with threshold around 2.0V
    FALLING_0 = 0x0,
    /// BOR falling level 2 with threshold around 2.2V
    FALLING_1 = 0x1,
    /// BOR falling level 3 with threshold around 2.5V
    FALLING_2 = 0x2,
    /// BOR falling level 4 with threshold around 2.8V
    FALLING_3 = 0x3,
};

pub const BORR_LEV = enum(u2) {
    /// BOR rising level 1 with threshold around 2.1V
    RISING_0 = 0x0,
    /// BOR rising level 2 with threshold around 2.3V
    RISING_1 = 0x1,
    /// BOR rising level 3 with threshold around 2.6V
    RISING_2 = 0x2,
    /// BOR rising level 4 with threshold around 2.9V
    RISING_3 = 0x3,
};

pub const LATENCY = enum(u3) {
    /// Zero wait states
    WS0 = 0x0,
    /// One wait state
    WS1 = 0x1,
    /// Two wait states
    WS2 = 0x2,
    _,
};

pub const NRST_MODE = enum(u2) {
    /// Reset pin is in reset input mode only
    INPUT_ONLY = 0x1,
    /// Reset pin is in GPIO mode only
    GPIO = 0x2,
    /// Reset pin is in resety input and output mode
    INPUT_OUTPUT = 0x3,
    _,
};

pub const RDP = enum(u8) {
    /// Read protection not active
    LEVEL_0 = 0xaa,
    /// Memories read protection active
    LEVEL_1 = 0xbb,
    /// Chip read protection active
    LEVEL_2 = 0xcc,
    _,
};

/// Flash
pub const FLASH = extern struct {
    /// Access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: LATENCY,
        reserved8: u5 = 0,
        /// Prefetch enable
        PRFTEN: u1,
        /// Instruction cache enable
        ICEN: u1,
        reserved11: u1 = 0,
        /// Instruction cache reset
        ICRST: u1,
        reserved16: u4 = 0,
        /// Flash User area empty
        EMPTY: u1,
        reserved18: u1 = 0,
        /// Debug access software enable
        DBG_SWEN: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// Flash key register
    /// offset: 0x08
    KEYR: u32,
    /// Option byte key register
    /// offset: 0x0c
    OPTKEYR: u32,
    /// Status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// End of operation
        EOP: u1,
        /// Operation error
        OPERR: u1,
        reserved3: u1 = 0,
        /// Programming error
        PROGERR: u1,
        /// Write protected error
        WRPERR: u1,
        /// Programming alignment error
        PGAERR: u1,
        /// Size error
        SIZERR: u1,
        /// Programming sequence error
        PGSERR: u1,
        /// Fast programming data miss error
        MISERR: u1,
        /// Fast programming error
        FASTERR: u1,
        reserved14: u4 = 0,
        /// PCROP read error
        RDERR: u1,
        /// Option and Engineering bits loading validity error
        OPTVERR: u1,
        /// Busy
        BSY: u1,
        reserved18: u1 = 0,
        /// Programming or erase configuration busy.
        CFGBSY: u1,
        padding: u13 = 0,
    }),
    /// Flash control register
    /// offset: 0x14
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page erase
        PER: u1,
        /// Mass erase
        MER: u1,
        /// Page number
        PNB: u6,
        reserved16: u7 = 0,
        /// Start
        STRT: u1,
        /// Options modification start
        OPTSTRT: u1,
        /// Fast programming
        FSTPG: u1,
        reserved24: u5 = 0,
        /// End of operation interrupt enable
        EOPIE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        /// PCROP read error interrupt enable
        RDERRIE: u1,
        /// Force the option byte loading
        OBL_LAUNCH: u1,
        /// Securable memory area protection enable
        SEC_PROT: u1,
        reserved30: u1 = 0,
        /// Options Lock
        OPTLOCK: u1,
        /// FLASH_CR Lock
        LOCK: u1,
    }),
    /// Flash ECC register
    /// offset: 0x18
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC fail address
        ADDR_ECC: u14,
        reserved20: u6 = 0,
        /// ECC fail for Corrected ECC Error or Double ECC Error in info block
        SYSF_ECC: u1,
        reserved24: u3 = 0,
        /// ECC correction interrupt enable
        ECCIE: u1,
        reserved30: u5 = 0,
        /// ECC correction
        ECCC: u1,
        /// ECC detection
        ECCD: u1,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// Flash option register
    /// offset: 0x20
    OPTR: mmio.Mmio(packed struct(u32) {
        /// Read protection level
        RDP: RDP,
        /// BOR reset Level
        BOREN: u1,
        /// These bits contain the VDD supply level threshold that activates the reset
        BORF_LEV: BORF_LEV,
        /// These bits contain the VDD supply level threshold that releases the reset.
        BORR_LEV: BORR_LEV,
        /// nRST_STOP
        nRST_STOP: u1,
        /// nRST_STDBY
        nRST_STDBY: u1,
        /// nRSTS_HDW
        nRSTS_HDW: u1,
        /// Independent watchdog selection
        IDWG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        reserved22: u2 = 0,
        /// SRAM parity check control
        RAM_PARITY_CHECK: u1,
        reserved24: u1 = 0,
        /// nBOOT_SEL
        nBOOT_SEL: u1,
        /// Boot configuration
        nBOOT1: u1,
        /// nBOOT0 option bit
        nBOOT0: u1,
        /// NRST_MODE
        NRST_MODE: NRST_MODE,
        /// Internal reset holder enable bit
        IRHEN: u1,
        padding: u2 = 0,
    }),
    /// Flash PCROP zone A Start address register
    /// offset: 0x24
    PCROP1ASR: mmio.Mmio(packed struct(u32) {
        /// PCROP1A area start offset
        PCROP1A_STRT: u8,
        padding: u24 = 0,
    }),
    /// Flash PCROP zone A End address register
    /// offset: 0x28
    PCROP1AER: mmio.Mmio(packed struct(u32) {
        /// PCROP1A area end offset
        PCROP1A_END: u8,
        reserved31: u23 = 0,
        /// PCROP area preserved when RDP level decreased
        PCROP_RDP: u1,
    }),
    /// Flash WRP area A address register
    /// offset: 0x2c
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// WRP area A start offset
        WRP1A_STRT: u6,
        reserved16: u10 = 0,
        /// WRP area A end offset
        WRP1A_END: u6,
        padding: u10 = 0,
    }),
    /// Flash WRP area B address register
    /// offset: 0x30
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// WRP area B start offset
        WRP1B_STRT: u6,
        reserved16: u10 = 0,
        /// WRP area B end offset
        WRP1B_END: u6,
        padding: u10 = 0,
    }),
    /// Flash PCROP zone B Start address register
    /// offset: 0x34
    PCROP1BSR: mmio.Mmio(packed struct(u32) {
        /// PCROP1B area start offset
        PCROP1B_STRT: u8,
        padding: u24 = 0,
    }),
    /// Flash PCROP zone B End address register
    /// offset: 0x38
    PCROP1BER: mmio.Mmio(packed struct(u32) {
        /// PCROP1B area end offset
        PCROP1B_END: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x3c
    reserved60: [68]u8,
    /// Flash Security register
    /// offset: 0x80
    SECR: mmio.Mmio(packed struct(u32) {
        /// Securable memory area size
        SEC_SIZE: u7,
        reserved16: u9 = 0,
        /// used to force boot from user area
        BOOT_LOCK: u1,
        padding: u15 = 0,
    }),
};
