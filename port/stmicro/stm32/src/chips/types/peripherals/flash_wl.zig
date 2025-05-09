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
        reserved15: u2 = 0,
        /// CPU1 CortexM4 program erase suspend request
        PES: u1,
        /// Flash User area empty
        EMPTY: u1,
        padding: u15 = 0,
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
        reserved13: u3 = 0,
        /// User Option OPTVAL indication
        OPTNV: u1,
        /// PCROP read error
        RDERR: u1,
        /// Option validity error
        OPTVERR: u1,
        /// Busy
        BSY: u1,
        reserved18: u1 = 0,
        /// Programming or erase configuration busy
        CFGBSY: u1,
        /// Programming or erase operation suspended
        PESD: u1,
        padding: u12 = 0,
    }),
    /// Flash control register
    /// offset: 0x14
    CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page erase
        PER: u1,
        /// This bit triggers the mass erase (all user pages) when set
        MER: u1,
        /// Page number selection
        PNB: u8,
        reserved16: u5 = 0,
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
        ADDR_ECC: u17,
        reserved20: u3 = 0,
        /// System Flash ECC fail
        SYSF_ECC: u1,
        reserved24: u3 = 0,
        /// ECC correction interrupt enable
        ECCCIE: u1,
        reserved26: u1 = 0,
        /// CPU identification
        CPUID: u3,
        reserved30: u1 = 0,
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
        /// Security enabled
        ESE: u1,
        /// BOR reset Level
        BOR_LEV: u3,
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
        /// Software Boot0
        nSWBOOT0: u1,
        /// nBoot0 option bit
        nBOOT0: u1,
        reserved29: u1 = 0,
        /// Radio Automatic Gain Control Trimming
        AGC_TRIM: u3,
    }),
    /// Flash Bank 1 PCROP Start address zone A register
    /// offset: 0x24
    PCROP1ASR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROPQ area start offset
        PCROP1A_STRT: u9,
        padding: u23 = 0,
    }),
    /// Flash Bank 1 PCROP End address zone A register
    /// offset: 0x28
    PCROP1AER: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area end offset
        PCROP1A_END: u9,
        reserved31: u22 = 0,
        /// PCROP area preserved when RDP level decreased
        PCROP_RDP: u1,
    }),
    /// Flash Bank 1 WRP area A address register
    /// offset: 0x2c
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP first area A start offset
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
        WRP1B_END: u8,
        reserved16: u8 = 0,
        /// Bank 1 WRP second area B end offset
        WRP1B_STRT: u8,
        padding: u8 = 0,
    }),
    /// Flash Bank 1 PCROP Start address area B register
    /// offset: 0x34
    PCROP1BSR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area B start offset
        PCROP1B_STRT: u9,
        padding: u23 = 0,
    }),
    /// Flash Bank 1 PCROP End address area B register
    /// offset: 0x38
    PCROP1BER: mmio.Mmio(packed struct(u32) {
        /// Bank 1 PCROP area end area B offset
        PCROP1B_END: u9,
        padding: u23 = 0,
    }),
    /// IPCC mailbox data buffer address register
    /// offset: 0x3c
    IPCCBR: mmio.Mmio(packed struct(u32) {
        /// PCC mailbox data buffer base address
        IPCCDBA: u14,
        padding: u18 = 0,
    }),
    /// offset: 0x40
    reserved64: [28]u8,
    /// CPU2 cortex M0 access control register
    /// offset: 0x5c
    C2ACR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// CPU2 cortex M0 prefetch enable
        PRFTEN: u1,
        /// CPU2 cortex M0 instruction cache enable
        ICEN: u1,
        reserved11: u1 = 0,
        /// CPU2 cortex M0 instruction cache reset
        ICRST: u1,
        reserved15: u3 = 0,
        /// CPU2 cortex M0 program erase suspend request
        PES: u1,
        padding: u16 = 0,
    }),
    /// CPU2 cortex M0 status register
    /// offset: 0x60
    C2SR: mmio.Mmio(packed struct(u32) {
        /// End of operation
        EOP: u1,
        /// Operation error
        OPERR: u1,
        reserved3: u1 = 0,
        /// Programming error
        PROGERR: u1,
        /// write protection error
        WRPERR: u1,
        /// Programming alignment error
        PGAERR: u1,
        /// Size error
        SIZERR: u1,
        /// Programming sequence error
        PGSERR: u1,
        /// Fast programming data miss error
        MISSERR: u1,
        /// Fast programming error
        FASTERR: u1,
        reserved14: u4 = 0,
        /// PCROP read error
        RDERR: u1,
        reserved16: u1 = 0,
        /// Busy
        BSY: u1,
        reserved18: u1 = 0,
        /// Programming or erase configuration busy
        CFGBSY: u1,
        /// Programming or erase operation suspended
        PESD: u1,
        padding: u12 = 0,
    }),
    /// CPU2 cortex M0 control register
    /// offset: 0x64
    C2CR: mmio.Mmio(packed struct(u32) {
        /// Programming
        PG: u1,
        /// Page erase
        PER: u1,
        /// Masse erase
        MER: u1,
        /// Page Number selection
        PNB: u8,
        reserved16: u5 = 0,
        /// Start
        STRT: u1,
        reserved18: u1 = 0,
        /// Fast programming
        FSTPG: u1,
        reserved24: u5 = 0,
        /// End of operation interrupt enable
        EOPIE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        /// PCROP read error interrupt enable
        RDERRIE: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x68
    reserved104: [24]u8,
    /// Secure flash start address register
    /// offset: 0x80
    SFR: mmio.Mmio(packed struct(u32) {
        /// Secure flash start address
        SFSA: u8,
        /// Flash security disable
        FSD: u1,
        reserved12: u3 = 0,
        /// Disable Cortex M0 debug access
        DDS: u1,
        padding: u19 = 0,
    }),
    /// Secure SRAM2 start address and cortex M0 reset vector register
    /// offset: 0x84
    SRRVR: mmio.Mmio(packed struct(u32) {
        /// cortex M0 access control register
        SBRV: u18,
        /// Secure backup SRAM2a start address
        SBRSA: u5,
        /// backup SRAM2a security disable
        BRSD: u1,
        reserved25: u1 = 0,
        /// Secure non backup SRAM2a start address
        SNBRSA: u5,
        /// non-backup SRAM2b security disable
        NBRSD: u1,
        /// CPU2 cortex M0 boot reset vector memory selection
        C2OPT: u1,
    }),
};
