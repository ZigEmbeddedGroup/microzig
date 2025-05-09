const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Flash
pub const FLASH = extern struct {
    /// Access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: u3,
        reserved8: u5 = 0,
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
        padding: u17 = 0,
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
        /// (1/2 of MER) Bank 1 Mass erase
        @"MER[0]": u1,
        /// Page number
        PNB: u8,
        /// Bank erase
        BKER: u1,
        reserved15: u3 = 0,
        /// (2/2 of MER) Bank 1 Mass erase
        @"MER[1]": u1,
        /// Start
        START: u1,
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
        reserved30: u2 = 0,
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
        /// ECC fail bank
        BK_ECC: u1,
        /// System Flash ECC fail
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
        RDP: u8,
        /// BOR reset Level
        BOR_LEV: u3,
        reserved12: u1 = 0,
        /// nRST_STOP
        nRST_STOP: u1,
        /// nRST_STDBY
        nRST_STDBY: u1,
        reserved16: u2 = 0,
        /// Independent watchdog selection
        IDWG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        /// Dual-bank boot
        BFB: u1,
        /// Dual-Bank on 512 KB or 256 KB Flash memory devices
        DUALBANK: u1,
        reserved23: u1 = 0,
        /// Boot configuration
        nBOOT1: u1,
        /// SRAM2 parity check enable
        SRAM2_PE: u1,
        /// SRAM2 Erase when system reset
        SRAM2_RST: u1,
        /// Software BOOT0
        nSWBOOT0: u1,
        /// nBOOT0 option bit
        nBOOT0: u1,
        padding: u4 = 0,
    }),
    /// Flash Bank 1 PCROP Start address register
    /// offset: 0x24
    PCROP1SR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area start offset
        PCROP1_STRT: u16,
        padding: u16 = 0,
    }),
    /// Flash Bank 1 PCROP End address register
    /// offset: 0x28
    PCROP1ER: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area end offset
        PCROP1_END: u16,
        reserved31: u15 = 0,
        /// PCROP area preserved when RDP level decreased
        PCROP_RDP: u1,
    }),
    /// Flash Bank 1 WRP area A address register
    /// offset: 0x2c
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP first area tart offset
        WRP1A_STRT: u8,
        reserved16: u8 = 0,
        /// Bank 1 WRP first area A end offset
        WRP1A_END: u8,
        padding: u8 = 0,
    }),
    /// Flash Bank 1 WRP area B address register
    /// offset: 0x30
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP second area B start offset
        WRP1B_STRT: u8,
        reserved16: u8 = 0,
        /// Bank 1 WRP second area B end offset
        WRP1B_END: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x34
    reserved52: [16]u8,
    /// Flash Bank 2 PCROP Start address register
    /// offset: 0x44
    PCROP2SR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 PCROP area start offset
        PCROP2_STRT: u16,
        padding: u16 = 0,
    }),
    /// Flash Bank 2 PCROP End address register
    /// offset: 0x48
    PCROP2ER: mmio.Mmio(packed struct(u32) {
        /// Bank 2 PCROP area end offset
        PCROP2_END: u16,
        padding: u16 = 0,
    }),
    /// Flash Bank 2 WRP area A address register
    /// offset: 0x4c
    WRP2AR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 WRP first area A start offset
        WRP2A_STRT: u8,
        reserved16: u8 = 0,
        /// Bank 2 WRP first area A end offset
        WRP2A_END: u8,
        padding: u8 = 0,
    }),
    /// Flash Bank 2 WRP area B address register
    /// offset: 0x50
    WRP2BR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 WRP second area B start offset
        WRP2B_STRT: u8,
        reserved16: u8 = 0,
        /// Bank 2 WRP second area B end offset
        WRP2B_END: u8,
        padding: u8 = 0,
    }),
};
