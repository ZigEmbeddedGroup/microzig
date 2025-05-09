const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Flash
pub const FLASH = extern struct {
    /// Access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: u4,
        reserved13: u9 = 0,
        /// Flash Power-down mode during Low-power run mode
        RUN_PD: u1,
        /// Flash Power-down mode during Low-power sleep mode
        SLEEP_PD: u1,
        /// LVEN
        LVEN: u1,
        padding: u16 = 0,
    }),
    /// Power down key register
    /// offset: 0x04
    PDKEYR: u32,
    /// Flash non-secure key register
    /// offset: 0x08
    NSKEYR: u32,
    /// Flash secure key register
    /// offset: 0x0c
    SECKEYR: u32,
    /// Flash option key register
    /// offset: 0x10
    OPTKEYR: u32,
    /// Flash low voltage key register
    /// offset: 0x14
    LVEKEYR: u32,
    /// offset: 0x18
    reserved24: [8]u8,
    /// Flash status register
    /// offset: 0x20
    NSSR: mmio.Mmio(packed struct(u32) {
        /// NSEOP
        NSEOP: u1,
        /// NSOPERR
        NSOPERR: u1,
        reserved3: u1 = 0,
        /// NSPROGERR
        NSPROGERR: u1,
        /// NSWRPERR
        NSWRPERR: u1,
        /// NSPGAERR
        NSPGAERR: u1,
        /// NSSIZERR
        NSSIZERR: u1,
        /// NSPGSERR
        NSPGSERR: u1,
        reserved13: u5 = 0,
        /// OPTWERR
        OPTWERR: u1,
        reserved15: u1 = 0,
        /// OPTVERR
        OPTVERR: u1,
        /// NSBusy
        NSBSY: u1,
        padding: u15 = 0,
    }),
    /// Flash status register
    /// offset: 0x24
    SECSR: mmio.Mmio(packed struct(u32) {
        /// SECEOP
        SECEOP: u1,
        /// SECOPERR
        SECOPERR: u1,
        reserved3: u1 = 0,
        /// SECPROGERR
        SECPROGERR: u1,
        /// SECWRPERR
        SECWRPERR: u1,
        /// SECPGAERR
        SECPGAERR: u1,
        /// SECSIZERR
        SECSIZERR: u1,
        /// SECPGSERR
        SECPGSERR: u1,
        reserved14: u6 = 0,
        /// Secure read protection error
        SECRDERR: u1,
        reserved16: u1 = 0,
        /// SECBusy
        SECBSY: u1,
        padding: u15 = 0,
    }),
    /// Flash non-secure control register
    /// offset: 0x28
    NSCR: mmio.Mmio(packed struct(u32) {
        /// NSPG
        NSPG: u1,
        /// NSPER
        NSPER: u1,
        /// NSMER1
        NSMER1: u1,
        /// NSPNB
        NSPNB: u7,
        reserved11: u1 = 0,
        /// NSBKER
        NSBKER: u1,
        reserved15: u3 = 0,
        /// NSMER2
        NSMER2: u1,
        /// Options modification start
        NSSTRT: u1,
        /// Options modification start
        OPTSTRT: u1,
        reserved24: u6 = 0,
        /// NSEOPIE
        NSEOPIE: u1,
        /// NSERRIE
        NSERRIE: u1,
        reserved27: u1 = 0,
        /// Force the option byte loading
        OBL_LAUNCH: u1,
        reserved30: u2 = 0,
        /// Options Lock
        OPTLOCK: u1,
        /// NSLOCK
        NSLOCK: u1,
    }),
    /// Flash secure control register
    /// offset: 0x2c
    SECCR: mmio.Mmio(packed struct(u32) {
        /// SECPG
        SECPG: u1,
        /// SECPER
        SECPER: u1,
        /// SECMER1
        SECMER1: u1,
        /// SECPNB
        SECPNB: u7,
        reserved11: u1 = 0,
        /// SECBKER
        SECBKER: u1,
        reserved15: u3 = 0,
        /// SECMER2
        SECMER2: u1,
        /// SECSTRT
        SECSTRT: u1,
        reserved24: u7 = 0,
        /// SECEOPIE
        SECEOPIE: u1,
        /// SECERRIE
        SECERRIE: u1,
        /// SECRDERRIE
        SECRDERRIE: u1,
        reserved29: u2 = 0,
        /// SECINV
        SECINV: u1,
        reserved31: u1 = 0,
        /// SECLOCK
        SECLOCK: u1,
    }),
    /// Flash ECC register
    /// offset: 0x30
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC fail address
        ADDR_ECC: u19,
        reserved21: u2 = 0,
        /// BK_ECC
        BK_ECC: u1,
        /// SYSF_ECC
        SYSF_ECC: u1,
        reserved24: u1 = 0,
        /// ECC correction interrupt enable
        ECCIE: u1,
        reserved28: u3 = 0,
        /// ECCC2
        ECCC2: u1,
        /// ECCD2
        ECCD2: u1,
        /// ECC correction
        ECCC: u1,
        /// ECC detection
        ECCD: u1,
    }),
    /// offset: 0x34
    reserved52: [12]u8,
    /// Flash option register
    /// offset: 0x40
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
        /// nRST_SHDW
        nRST_SHDW: u1,
        reserved16: u1 = 0,
        /// Independent watchdog selection
        IWDG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        /// SWAP_BANK
        SWAP_BANK: u1,
        /// DB256K
        DB256K: u1,
        /// DBANK
        DBANK: u1,
        reserved24: u1 = 0,
        /// SRAM2 parity check enable
        SRAM2_PE: u1,
        /// SRAM2 Erase when system reset
        SRAM2_RST: u1,
        /// nSWBOOT0
        nSWBOOT0: u1,
        /// nBOOT0
        nBOOT0: u1,
        /// PA15_PUPEN
        PA15_PUPEN: u1,
        reserved31: u2 = 0,
        /// TZEN
        TZEN: u1,
    }),
    /// Flash non-secure boot address 0 register
    /// offset: 0x44
    NSBOOTADD0R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// NSBOOTADD0
        NSBOOTADD0: u25,
    }),
    /// Flash non-secure boot address 1 register
    /// offset: 0x48
    NSBOOTADD1R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// NSBOOTADD1
        NSBOOTADD1: u25,
    }),
    /// FFlash secure boot address 0 register
    /// offset: 0x4c
    SECBOOTADD0R: mmio.Mmio(packed struct(u32) {
        /// BOOT_LOCK
        BOOT_LOCK: u1,
        reserved7: u6 = 0,
        /// SECBOOTADD0
        SECBOOTADD0: u25,
    }),
    /// Flash bank 1 secure watermak1 register
    /// offset: 0x50
    SECWM1R1: mmio.Mmio(packed struct(u32) {
        /// SECWM1_PSTRT
        SECWM1_PSTRT: u7,
        reserved16: u9 = 0,
        /// SECWM1_PEND
        SECWM1_PEND: u7,
        padding: u9 = 0,
    }),
    /// Flash secure watermak1 register 2
    /// offset: 0x54
    SECWM1R2: mmio.Mmio(packed struct(u32) {
        /// PCROP1_PSTRT
        PCROP1_PSTRT: u7,
        reserved15: u8 = 0,
        /// PCROP1EN
        PCROP1EN: u1,
        /// HDP1_PEND
        HDP1_PEND: u7,
        reserved31: u8 = 0,
        /// HDP1EN
        HDP1EN: u1,
    }),
    /// Flash Bank 1 WRP area A address register
    /// offset: 0x58
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// WRP1A_PSTRT
        WRP1A_PSTRT: u7,
        reserved16: u9 = 0,
        /// WRP1A_PEND
        WRP1A_PEND: u7,
        padding: u9 = 0,
    }),
    /// Flash Bank 1 WRP area B address register
    /// offset: 0x5c
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// WRP1B_PSTRT
        WRP1B_PSTRT: u7,
        reserved16: u9 = 0,
        /// WRP1B_PEND
        WRP1B_PEND: u7,
        padding: u9 = 0,
    }),
    /// Flash secure watermak2 register
    /// offset: 0x60
    SECWM2R1: mmio.Mmio(packed struct(u32) {
        /// SECWM2_PSTRT
        SECWM2_PSTRT: u7,
        reserved16: u9 = 0,
        /// SECWM2_PEND
        SECWM2_PEND: u7,
        padding: u9 = 0,
    }),
    /// Flash secure watermak2 register2
    /// offset: 0x64
    SECWM2R2: mmio.Mmio(packed struct(u32) {
        /// PCROP2_PSTRT
        PCROP2_PSTRT: u7,
        reserved15: u8 = 0,
        /// PCROP2EN
        PCROP2EN: u1,
        /// HDP2_PEND
        HDP2_PEND: u7,
        reserved31: u8 = 0,
        /// HDP2EN
        HDP2EN: u1,
    }),
    /// Flash WPR2 area A address register
    /// offset: 0x68
    WRP2AR: mmio.Mmio(packed struct(u32) {
        /// WRP2A_PSTRT
        WRP2A_PSTRT: u7,
        reserved16: u9 = 0,
        /// WRP2A_PEND
        WRP2A_PEND: u7,
        padding: u9 = 0,
    }),
    /// Flash WPR2 area B address register
    /// offset: 0x6c
    WRP2BR: mmio.Mmio(packed struct(u32) {
        /// WRP2B_PSTRT
        WRP2B_PSTRT: u7,
        reserved16: u9 = 0,
        /// WRP2B_PEND
        WRP2B_PEND: u7,
        padding: u9 = 0,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// FLASH secure block based bank 1 register
    /// offset: 0x80
    SECBB1R1: mmio.Mmio(packed struct(u32) {
        /// SECBB1
        SECBB1: u32,
    }),
    /// FLASH secure block based bank 1 register
    /// offset: 0x84
    SECBB1R2: mmio.Mmio(packed struct(u32) {
        /// SECBB1
        SECBB1: u32,
    }),
    /// FLASH secure block based bank 1 register
    /// offset: 0x88
    SECBB1R3: mmio.Mmio(packed struct(u32) {
        /// SECBB1
        SECBB1: u32,
    }),
    /// FLASH secure block based bank 1 register
    /// offset: 0x8c
    SECBB1R4: mmio.Mmio(packed struct(u32) {
        /// SECBB1
        SECBB1: u32,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// FLASH secure block based bank 2 register
    /// offset: 0xa0
    SECBB2R1: mmio.Mmio(packed struct(u32) {
        /// SECBB2
        SECBB2: u32,
    }),
    /// FLASH secure block based bank 2 register
    /// offset: 0xa4
    SECBB2R2: mmio.Mmio(packed struct(u32) {
        /// SECBB2
        SECBB2: u32,
    }),
    /// FLASH secure block based bank 2 register
    /// offset: 0xa8
    SECBB2R3: mmio.Mmio(packed struct(u32) {
        /// SECBB2
        SECBB2: u32,
    }),
    /// FLASH secure block based bank 2 register
    /// offset: 0xac
    SECBB2R4: mmio.Mmio(packed struct(u32) {
        /// SECBB2
        SECBB2: u32,
    }),
    /// offset: 0xb0
    reserved176: [16]u8,
    /// FLASH secure HDP control register
    /// offset: 0xc0
    SECHDPCR: mmio.Mmio(packed struct(u32) {
        /// HDP1_ACCDIS
        HDP1_ACCDIS: u1,
        /// HDP2_ACCDIS
        HDP2_ACCDIS: u1,
        padding: u30 = 0,
    }),
    /// Power privilege configuration register
    /// offset: 0xc4
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// PRIV
        PRIV: u1,
        padding: u31 = 0,
    }),
};
