const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const LATENCY = enum(u4) {
    /// Zero wait states
    WS0 = 0x0,
    /// One wait state
    WS1 = 0x1,
    /// Two wait states
    WS2 = 0x2,
    /// Three wait states
    WS3 = 0x3,
    /// Four wait states
    WS4 = 0x4,
    _,
};

pub const NRST_MODE = enum(u2) {
    /// Reset pin is in reset input mode only
    INPUT_ONLY = 0x1,
    /// Reset pin is in GPIO mode only
    GPIO = 0x2,
    /// Reset pin is in reset input and output mode
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
        reserved8: u4 = 0,
        /// Prefetch enable
        PRFTEN: u1,
        /// Instruction cache enable
        ICEN: u1,
        /// Data cache enable
        DCEN: u1,
        /// Instruction cache reset
        ICRST: u1,
        /// Data cache reset
        DCRST: u1,
        /// Flash Power-down mode during Low-power run mode
        RUN_PD: u1,
        /// Flash Power-down mode during Low-power sleep mode
        SLEEP_PD: u1,
        reserved18: u3 = 0,
        /// Debug software enable
        DBG_SWEN: u1,
        padding: u13 = 0,
    }),
    /// Power down key register
    /// offset: 0x04
    PDKEYR: u32,
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
        /// Option validity error
        OPTVERR: u1,
        /// Busy
        BSY: u1,
        padding: u15 = 0,
    }),
    /// Flash control register
    /// offset: 0x14
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page erase
        PER: u1,
        /// Bank 1 Mass erase
        MER1: u1,
        /// Page number
        PNB: u7,
        reserved16: u6 = 0,
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
        SEC_PROT1: u1,
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
        ADDR_ECC: u19,
        reserved21: u2 = 0,
        /// ECC fail for Corrected ECC Error or Double ECC Error in info block
        BK_ECC: u1,
        /// ECC fail for Corrected ECC Error or Double ECC Error in info block
        SYSF_ECC: u1,
        reserved24: u1 = 0,
        /// ECC correction interrupt enable
        ECCIE: u1,
        reserved28: u3 = 0,
        /// ECC correction
        ECCC2: u1,
        /// ECC2 detection
        ECCD2: u1,
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
        BOR_LEV: u3,
        reserved12: u1 = 0,
        /// nRST_STOP
        nRST_STOP: u1,
        /// nRST_STDBY
        nRST_STDBY: u1,
        /// nRST_SHDW
        nRST_SHDW: u1,
        reserved16: u1 = 0,
        /// Independent watchdog selection
        IDWG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        reserved23: u3 = 0,
        /// Boot configuration
        nBOOT1: u1,
        /// SRAM2 parity check enable
        SRAM2_PE: u1,
        /// SRAM2 Erase when system reset
        SRAM2_RST: u1,
        /// nSWBOOT0
        nSWBOOT0: u1,
        /// nBOOT0 option bit
        nBOOT0: u1,
        /// NRST_MODE
        NRST_MODE: NRST_MODE,
        /// Internal reset holder enable bit
        IRHEN: u1,
        padding: u1 = 0,
    }),
    /// Flash Bank 1 PCROP Start address register
    /// offset: 0x24
    PCROP1SR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area start offset
        PCROP1_STRT: u15,
        padding: u17 = 0,
    }),
    /// Flash Bank 1 PCROP End address register
    /// offset: 0x28
    PCROP1ER: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area end offset
        PCROP1_END: u15,
        reserved31: u16 = 0,
        /// PCROP area preserved when RDP level decreased
        PCROP_RDP: u1,
    }),
    /// Flash Bank 1 WRP area A address register
    /// offset: 0x2c
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP first area start offset
        WRP1A_STRT: u7,
        reserved16: u9 = 0,
        /// Bank 1 WRP first area A end offset
        WRP1A_END: u7,
        padding: u9 = 0,
    }),
    /// Flash Bank 1 WRP area B address register
    /// offset: 0x30
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP second area B end offset
        WRP1B_STRT: u7,
        reserved16: u9 = 0,
        /// Bank 1 WRP second area B start offset
        WRP1B_END: u7,
        padding: u9 = 0,
    }),
    /// offset: 0x34
    reserved52: [60]u8,
    /// securable area bank1 register
    /// offset: 0x70
    SEC1R: mmio.Mmio(packed struct(u32) {
        /// SEC_SIZE1
        SEC_SIZE1: u8,
        reserved16: u8 = 0,
        /// used to force boot from user area
        BOOT_LOCK: u1,
        padding: u15 = 0,
    }),
};
