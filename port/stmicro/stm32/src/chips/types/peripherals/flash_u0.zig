const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BORR_LEV = enum(u3) {
    /// BOR rising level 1 with threshold around 2.1 V
    Level1 = 0x0,
    /// BOR rising level 2 with threshold around 2.3 V
    Level2 = 0x1,
    /// BOR rising level 3 with threshold around 2.6 V
    Level3 = 0x2,
    /// BOR rising level 4 with threshold around 2.9 V
    Level4 = 0x3,
    _,
};

pub const NRST_MODE = enum(u2) {
    /// Reset input only: a low level on the NRST pin generates system reset; internal RESET is not propagated to the NRST pin.
    OnlyInput = 0x1,
    /// Standard GPIO: only internal RESET is possible
    OnlyInternal = 0x2,
    /// Bidirectional reset: the NRST pin is configured in reset input/output (legacy) mode
    Bidirectional = 0x3,
    _,
};

pub const RDP = enum(u8) {
    /// Level 0, read protection not active
    Level0 = 0xaa,
    /// Level 2, chip read protection active
    Level2 = 0xcc,
    _,
};

/// Mamba FLASH register block
pub const FLASH = extern struct {
    /// FLASH access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Flash memory access latency The value in this bitfield represents the number of CPU wait states when accessing the flash memory. Other: Reserved A new write into the bitfield becomes effective when it returns the same value upon read.
        LATENCY: u3,
        reserved8: u5 = 0,
        /// CPU Prefetch enable
        PRFTEN: u1,
        /// CPU Instruction cache enable
        ICEN: u1,
        reserved11: u1 = 0,
        /// CPU Instruction cache reset This bit can be written only when the instruction cache is disabled.
        ICRST: u1,
        reserved16: u4 = 0,
        /// Main flash memory area empty This bit indicates whether the first location of the main flash memory area is erased or has a programmed value. The bit can be set and reset by software.
        EMPTY: u1,
        reserved18: u1 = 0,
        /// Debug access software enable Software may use this bit to enable/disable the debugger read access.
        DBG_SWEN: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// FLASH key register
    /// offset: 0x08
    KEYR: mmio.Mmio(packed struct(u32) {
        /// FLASH key The following values must be written consecutively to unlock the FLASH control register (FLASH_CR), thus enabling programming/erasing operations: KEY1: 0x4567 0123 KEY2: 0xCDEF 89AB
        KEY: u32,
    }),
    /// FLASH option key register
    /// offset: 0x0c
    OPTKEYR: mmio.Mmio(packed struct(u32) {
        /// Option byte key The following values must be written consecutively to unlock the flash memory option registers, enabling option byte programming/erasing operations: KEY1: 0x0819 2A3B KEY2: 0x4C5D 6E7F
        OPTKEY: u32,
    }),
    /// FLASH status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// End of operation Set by hardware when one or more flash memory operation (programming / erase) has been completed successfully. This bit is set only if the end of operation interrupts are enabled (EOPIE=1). Cleared by writing 1.
        EOP: u1,
        /// Operation error Set by hardware when a flash memory operation (program / erase) completes unsuccessfully. This bit is set only if error interrupts are enabled (ERRIE=1). Cleared by writing 1.
        OPERR: u1,
        reserved3: u1 = 0,
        /// Programming error Set by hardware when a double-word address to be programmed contains a value different from '0xFFFF FFFF' before programming, except if the data to write is '0x0000 0000'. Cleared by writing 1.
        PROGERR: u1,
        /// Write protection error Set by hardware when an address to be erased/programmed belongs to a write-protected part (by WRP, PCROP or RDP Level 1) of the flash memory. Cleared by writing 1.
        WRPERR: u1,
        /// Programming alignment error Set by hardware when the data to program cannot be contained in the same double word (64-bit) flash memory in case of standard programming, or if there is a change of page during fast programming. Cleared by writing 1.
        PGAERR: u1,
        /// Size error Set by hardware when the size of the access is a byte or half-word during a program or a fast program sequence. Only double word programming is allowed (consequently: word access). Cleared by writing 1.
        SIZERR: u1,
        /// Programming sequence error Set by hardware when a write access to the flash memory is performed by the code while PG or FSTPG have not been set previously. Set also by hardware when PROGERR, SIZERR, PGAERR, WRPERR, MISSERR or FASTERR is set due to a previous programming error. Cleared by writing 1.
        PGSERR: u1,
        /// Fast programming data miss error In Fast programming mode, 16 double words (128 bytes) must be sent to flash memory successively, and the new data must be sent to the logic control before the current data is fully programmed. MISSERR is set by hardware when the new data is not present in time. Cleared by writing 1.
        MISSERR: u1,
        /// Fast programming error Set by hardware when a fast programming sequence (activated by FSTPG) is interrupted due to an error (alignment, size, write protection or data miss). The corresponding status bit (PGAERR, SIZERR, WRPERR or MISSERR) is set at the same time. Cleared by writing 1.
        FASTERR: u1,
        reserved14: u4 = 0,
        /// PCROP read error Set by hardware when an address to be read belongs to a read protected area of the flash memory (PCROP protection). An interrupt is generated if RDERRIE is set in FLASH_CR. Cleared by writing 1.
        RDERR: u1,
        /// Option and Engineering bits loading validity error
        OPTVERR: u1,
        /// Busy This flag indicates that a flash memory operation requested by FLASH control register (FLASH_CR) is in progress. This bit is set at the beginning of the flash memory operation, and cleared when the operation finishes or when an error occurs.
        BSY1: u1,
        reserved18: u1 = 0,
        /// Programming or erase configuration busy. This flag is set and cleared by hardware. It is set when the first word is sent for program or when setting the STRT bit of FLASH control register (FLASH_CR) for erase. It is cleared when the flash memory program or erase operation completes or ends with an error. When set, launching any other operation through the FLASH control register (FLASH_CR) is impossible, and must be postponed (a programming or erase operation is ongoing). When cleared, the program and erase settings in the FLASH control register (FLASH_CR) can be modified.
        CFGBSY: u1,
        padding: u13 = 0,
    }),
    /// FLASH control register
    /// offset: 0x14
    CR: mmio.Mmio(packed struct(u32) {
        /// Flash memory programming enable
        PG: u1,
        /// Page erase enable
        PER: u1,
        /// Mass erase When set, this bit triggers the mass erase, that is, all user pages.
        MER1: u1,
        /// Page number selection These bits select the page to erase: ... Note: Values corresponding to addresses outside the main memory are not allowed.
        PNB: u7,
        reserved16: u6 = 0,
        /// Start erase operation This bit triggers an erase operation when set. This bit is possible to set only by software and to clear only by hardware. The hardware clears it when one of BSY1 and BSY2 flags in the FLASH_SR register transits to zero.
        STRT: u1,
        /// Start of modification of option bytes This bit triggers an options operation when set. This bit is set only by software, and is cleared when the BSY1 bit is cleared in FLASH_SR.
        OPTSTRT: u1,
        /// Fast programming enable
        FSTPG: u1,
        reserved24: u5 = 0,
        /// End-of-operation interrupt enable This bit enables the interrupt generation upon setting the EOP flag in the FLASH_SR register.
        EOPIE: u1,
        /// Error interrupt enable This bit enables the interrupt generation upon setting the OPERR flag in the FLASH_SR register.
        ERRIE: u1,
        /// PCROP read error interrupt enable This bit enables the interrupt generation upon setting the RDERR flag in the FLASH_SR register.
        RDERRIE: u1,
        /// Option byte load launch When set, this bit triggers the load of option bytes into option registers. It is automatically cleared upon the completion of the load. The high state of the bit indicates pending option byte load. The bit cannot be cleared by software. It cannot be written as long as OPTLOCK is set.
        OBL_LAUNCH: u1,
        /// Securable memory area protection enable This bit enables the protection on securable area, provided that a non-null securable memory area size (SEC_SIZE[4:0]) is defined in option bytes. This bit is possible to set only by software and to clear only through a system reset.
        SEC_PROT: u1,
        reserved30: u1 = 0,
        /// Options Lock This bit is set only. When set, all bits concerning user option in FLASH_CR register and so option page are locked. This bit is cleared by hardware after detecting the unlock sequence. The LOCK bit must be cleared before doing the unlock sequence for OPTLOCK bit. In case of an unsuccessful unlock operation, this bit remains set until the next reset.
        OPTLOCK: u1,
        /// FLASH_CR Lock This bit is set only. When set, the FLASH_CR register is locked. It is cleared by hardware after detecting the unlock sequence. In case of an unsuccessful unlock operation, this bit remains set until the next system reset.
        LOCK: u1,
    }),
    /// FLASH ECC register
    /// offset: 0x18
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC fail double-word address offset In case of ECC error or ECC correction detected, this bitfield contains double-word offset (multiple of 64 bits) to main Flash memory.
        ADDR_ECC: u14,
        reserved20: u6 = 0,
        /// System Flash memory ECC fail This bit indicates that the ECC error correction or double ECC error detection is located in the system Flash memory.
        SYSF_ECC: u1,
        reserved24: u3 = 0,
        /// ECC correction interrupt enable
        ECCCIE: u1,
        reserved30: u5 = 0,
        /// ECC correction Set by hardware when one ECC error has been detected and corrected. An interrupt is generated if ECCIE is set. Cleared by writing 1.
        ECCC: u1,
        /// ECC detection Set by hardware when two ECC errors have been detected. When this bit is set, a NMI is generated. Cleared by writing 1.
        ECCD: u1,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// FLASH option register
    /// offset: 0x20
    OPTR: mmio.Mmio(packed struct(u32) {
        /// Read protection level Other: Level 1, memories read protection active
        RDP: RDP,
        /// BOR reset level
        BORR_LEV: BORR_LEV,
        reserved13: u2 = 0,
        /// Reset generated when entering Stop mode
        NRST_STOP: u1,
        /// Reset generated when entering Standby mode
        NRST_STDBY: u1,
        /// Reset generated when entering Shutdown mode
        NRST_SHDW: u1,
        /// Independent watchdog selection
        IWDG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        reserved21: u1 = 0,
        /// Backup domain reset
        BDRST: u1,
        /// SRAM parity check control enable/disable
        RAM_PARITY_CHECK: u1,
        /// Backup SRAM erase prevention
        BKPSRAM_HW_ERASE_DISABLE: u1,
        /// BOOT0 signal source selection This option bit defines the source of the BOOT0 signal.
        NBOOT_SEL: u1,
        /// Boot configuration Together with the BOOT0 pin or option bit NBOOT0 (depending on NBOOT_SEL option bit configuration), this bit selects boot mode from the main flash memory, SRAM or the system memory. Refer to Section12.5: Boot configuration.
        NBOOT1: u1,
        /// NBOOT0 option bit
        NBOOT0: u1,
        /// NRST pin configuration
        NRST_MODE: NRST_MODE,
        /// Internal reset holder enable bit
        IRHEN: u1,
        padding: u2 = 0,
    }),
    /// offset: 0x24
    reserved36: [8]u8,
    /// FLASH WRP area A address register
    /// offset: 0x2c
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// WRP area A start offset This bitfield contains the offset of the first page of the WRP area A. Note: The number of effective bits depends on the size of the flash memory in the device.
        WRP1A_STRT: u7,
        reserved16: u9 = 0,
        /// WRP area A end offset This bitfield contains the offset of the last page of the WRP area A. Note: The number of effective bits depends on the size of the flash memory in the device.
        WRP1A_END: u7,
        padding: u9 = 0,
    }),
    /// FLASH WRP area B address register
    /// offset: 0x30
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// WRP area B start offset This bitfield contains the offset of the first page of the WRP area B. Note: The number of effective bits depends on the size of the flash memory in the device.
        WRP1B_STRT: u7,
        reserved16: u9 = 0,
        /// WRP area B end offset This bitfield contains the offset of the last page of the WRP area B. Note: The number of effective bits depends on the size of the flash memory in the device.
        WRP1B_END: u7,
        padding: u9 = 0,
    }),
    /// offset: 0x34
    reserved52: [76]u8,
    /// FLASH security register
    /// offset: 0x80
    SECR: mmio.Mmio(packed struct(u32) {
        /// Last page of the first hide protection area
        HDP1_PEND: u7,
        reserved16: u9 = 0,
        /// used to force boot from user area If the bit is set in association with RDP level 1, the debug capabilities are disabled, except in the case of a bad OBL (mismatch).
        BOOT_LOCK: u1,
        reserved24: u7 = 0,
        /// Hide protection area enable
        HDP1EN: u8,
    }),
};
