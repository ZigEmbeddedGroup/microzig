const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BOOTR_SECBOOT_LOCK = enum(u8) {
    /// The BOOT_UBE and SECBOOTADD are frozen. SWAP_BANK can only be modified with TZEN set to 0xC3 (disabled).
    B_0xB4 = 0xb4,
    /// The BOOT_UBE, SWAP_ BANK and SECBOOTADD can still be modified following their individual rules.
    B_0xC3 = 0xc3,
    _,
};

pub const CODE_OP = enum(u3) {
    /// No flash operation on going during previous reset
    B_0x0 = 0x0,
    /// Single write operation interrupted
    B_0x1 = 0x1,
    /// OBK alternate sector erase
    B_0x2 = 0x2,
    /// Sector erase operation interrupted
    B_0x3 = 0x3,
    /// Bank erase operation interrupted
    B_0x4 = 0x4,
    /// Mass erase operation interrupted
    B_0x5 = 0x5,
    /// Option change operation interrupted
    B_0x6 = 0x6,
    /// OBK swap sector request
    B_0x7 = 0x7,
};

pub const NSBOOTR_NSBOOT_LOCK = enum(u8) {
    /// The NSBOOTADD is frozen. SWAP_ BANK can only be modified with TZEN set to 0xB4 (enabled).
    B_0xB4 = 0xb4,
    /// The SWAP_ BANK and NSBOOTADD can still be modified following their individual rules.
    B_0xC3 = 0xc3,
    _,
};

pub const NSCR_BKSEL = enum(u1) {
    /// Bank1 is selected for Bank erase / sector erase / interrupt enable
    B_0x0 = 0x0,
    /// Bank2 is selected for BER / SER
    B_0x1 = 0x1,
};

pub const NSPRIV = enum(u1) {
    /// access to non secure registers is always granted
    B_0x0 = 0x0,
    /// access to non secure registers is denied in case of unprivileged access.
    B_0x1 = 0x1,
};

pub const OPTCR_SWAP_BANK = enum(u1) {
    /// Bank1 and Bank2 not swapped
    B_0x0 = 0x0,
    /// Bank1 and Bank2 swapped
    B_0x1 = 0x1,
};

pub const OPTSR_BKPRAM_ECC = enum(u1) {
    /// BKPRAM ECC check enabled
    B_0x0 = 0x0,
    /// BKPRAM ECC check disabled
    B_0x1 = 0x1,
};

pub const OPTSR_BOOT_UBE = enum(u8) {
    /// OEM-iRoT (user flash) selected. In Open PRODUCT_STATE this value selects bootloader. Defaut value.
    B_0xB4 = 0xb4,
    /// ST-iRoT (system flash) selected
    B_0xC3 = 0xc3,
    _,
};

pub const OPTSR_BOR_LEV = enum(u2) {
    /// BOR Level 2, the threshold level is medium (around 2.4 V)
    B_0x1 = 0x1,
    /// BOR Level 3, the threshold level is high (around 2.7 V)
    B_0x2 = 0x2,
    _,
};

pub const OPTSR_IO_VDDIO_HSLV = enum(u1) {
    /// High-speed IO at low V<sub>DDIO2</sub> voltage feature disabled (V<sub>DDIO2</sub> can exceed 2.7�V)
    B_0x0 = 0x0,
    /// High-speed IO at low V<sub>DDIO2</sub> voltage feature enabled (V<sub>DDIO2</sub> remains below 2.7�V)
    B_0x1 = 0x1,
};

pub const OPTSR_IO_VDD_HSLV = enum(u1) {
    /// High-speed IO at low V<sub>DD</sub> voltage feature disabled (V<sub>DD</sub> can exceed 2.7�V)
    B_0x0 = 0x0,
    /// High-speed IO at low V<sub>DD</sub> voltage feature enabled (V<sub>DD</sub> remains below 2.7�V)
    B_0x1 = 0x1,
};

pub const OPTSR_IWDG_STDBY = enum(u1) {
    /// Independent watchdog frozen in Standby mode
    B_0x0 = 0x0,
    /// Independent watchdog keep running in Standby mode.
    B_0x1 = 0x1,
};

pub const OPTSR_IWDG_STOP = enum(u1) {
    /// Independent watchdog frozen in system Stop mode
    B_0x0 = 0x0,
    /// Independent watchdog keep running in system Stop mode.
    B_0x1 = 0x1,
};

pub const OPTSR_IWDG_SW = enum(u1) {
    /// IWDG watchdog is controlled by hardware
    B_0x0 = 0x0,
    /// IWDG watchdog is controlled by software
    B_0x1 = 0x1,
};

pub const OPTSR_NRST_STDBY = enum(u1) {
    /// a reset is generated when entering Standby mode on core domain
    B_0x0 = 0x0,
    /// no reset generated when entering Standby mode on core domain.
    B_0x1 = 0x1,
};

pub const OPTSR_NRST_STOP = enum(u1) {
    /// a reset is generated when entering Stop mode on core domain
    B_0x0 = 0x0,
    /// no reset generated when entering Stop mode on core domain.
    B_0x1 = 0x1,
};

pub const OPTSR_SRAM_ECC = enum(u1) {
    /// SRAM2 ECC check enabled
    B_0x0 = 0x0,
    /// SRAM2 ECC check disabled
    B_0x1 = 0x1,
};

pub const OPTSR_SWAP_BANK = enum(u1) {
    /// Bank1 and Bank2 not swapped
    B_0x0 = 0x0,
    /// Bank1 and Bank2 swapped
    B_0x1 = 0x1,
};

pub const OPTSR_TZEN = enum(u8) {
    /// TrustZone enabled.
    B_0xB4 = 0xb4,
    /// TrustZone disabled
    B_0xC3 = 0xc3,
    _,
};

pub const OPTSR_WWDG_SW = enum(u1) {
    /// WWDG watchdog is controlled by hardware
    B_0x0 = 0x0,
    /// WWDG watchdog is controlled by software
    B_0x1 = 0x1,
};

pub const PRIVBBR_PRIVBB = enum(u32) {
    /// sectors (32 * (x-1) + y) in bank 2 is unprivileged
    B_0x0 = 0x0,
    /// sector (32 * (x-1) + y) in bank 2 is privileged
    B_0x1 = 0x1,
    _,
};

pub const SECBBR_SECBB = enum(u32) {
    /// sectors (32 * (x-1) + y) in bank 2 is non secure
    B_0x0 = 0x0,
    /// sector (32 * (x-1) + y) in bank 2 is secure
    B_0x1 = 0x1,
    _,
};

pub const SECBOOTR_SECBOOT_LOCK = enum(u8) {
    /// The BOOT_UBE and SECBOOTADD are frozen. SWAP_ BANK can only be modified with TZEN set to 0xC3 (disabled).
    B_0xB4 = 0xb4,
    /// The BOOT_UBE, SWAP_BANK and SECBOOTADD can still be modified following their individual rules.
    B_0xC3 = 0xc3,
    _,
};

pub const SECCR_BKSEL = enum(u1) {
    /// Bank1 is selected for Bank erase / sector erase / interrupt enable
    B_0x0 = 0x0,
    /// Bank2 is selected for BER / SER
    B_0x1 = 0x1,
};

pub const SPRIV = enum(u1) {
    /// access to secure registers is always granted
    B_0x0 = 0x0,
    /// access to secure registers is denied in case of unprivileged access.
    B_0x1 = 0x1,
};

/// FLASH address block description
pub const FLASH = extern struct {
    /// FLASH access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Read latency These bits are used to control the number of wait states used during read operations on both nonvolatile memory banks. The application software has to program them to the correct value depending on the embedded flash memory interface frequency and voltage conditions. ... Note: No check is performed by hardware to verify that the configuration is correct.
        LATENCY: u4,
        /// Flash signal delay These bits are used to control the delay between nonvolatile memory signals during programming operations. Application software has to program them to the correct value depending on the embedded flash memory interface frequency. Please refer to Table�44 for details. Note: No check is performed to verify that the configuration is correct. Note: Two WRHIGHFREQ values can be selected for some frequencies.
        WRHIGHFREQ: u2,
        reserved8: u2 = 0,
        /// Prefetch enable. When bit value is modified, user must read back ACR register to be sure PRFTEN has been taken into account. Bits used to control the prefetch.
        PRFTEN: u1,
        padding: u23 = 0,
    }),
    /// FLASH non-secure key register
    /// offset: 0x04
    NSKEYR: u32,
    /// FLASH secure key register
    /// offset: 0x08
    SECKEYR: u32,
    /// FLASH option key register
    /// offset: 0x0c
    OPTKEYR: u32,
    /// FLASH non-secure OBK key register
    /// offset: 0x10
    NSOBKKEYR: u32,
    /// FLASH secure OBK key register
    /// offset: 0x14
    SECOBKKEYR: u32,
    /// FLASH operation status register
    /// offset: 0x18
    OPSR: mmio.Mmio(packed struct(u32) {
        /// Interrupted operation address
        ADDR_OP: u20,
        reserved21: u1 = 0,
        /// Flash high-cycle data area operation interrupted It indicates if flash high-cycle data area is concerned by operation.
        DATA_OP: u1,
        /// Interrupted operation bank It indicates which bank was concerned by operation.
        BK_OP: u1,
        /// Operation in system flash memory interrupted Indicates that reset interrupted an ongoing operation in system flash.
        SYSF_OP: u1,
        /// OTP operation interrupted Indicates that reset interrupted an ongoing operation in OTP area (or OBKeys area).
        OTP_OP: u1,
        reserved29: u4 = 0,
        /// Flash memory operation code
        CODE_OP: CODE_OP,
    }),
    /// FLASH option control register
    /// offset: 0x1c
    OPTCR: mmio.Mmio(packed struct(u32) {
        /// FLASH_OPTCR lock option configuration bit The OPTLOCK bit locks the FLASH_OPTCR register as well as all _PRG registers. The correct write sequence to FLASH_OPTKEYR register unlocks this bit. If a wrong sequence is executed, or the unlock sequence to FLASH_OPTKEYR is performed twice, this bit remains locked until next system reset. It is possible to set OPTLOCK by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When OPTLOCK changes from 0 to 1, the others bits of FLASH_OPTCR register do not change.
        OPTLOCK: u1,
        /// Option byte start change option configuration bit OPTSTRT triggers an option byte change operation. The user can set OPTSTRT only when the OPTLOCK bit is cleared to 0. It is set only by Software and cleared when the option byte change is completed or an error occurs (PGSERR or OPTCHANGEERR). It is reseted at the same time as BSY bit. The user application cannot modify any FLASH_XXX_PRG flash interface register until the option change operation has been completed. Before setting this bit, the user has to write the required values in the FLASH_XXX_PRG registers. The FLASH_XXX_PRG registers are locked until the option byte change operation has been executed in nonvolatile memory.
        OPTSTRT: u1,
        reserved31: u29 = 0,
        /// Bank swapping option configuration bit SWAP_BANK controls whether Bank1 and Bank2 are swapped or not. This bit is loaded with the SWAP_BANK bit of FLASH_OPTSR_CUR register only after reset or POR.
        SWAP_BANK: OPTCR_SWAP_BANK,
    }),
    /// FLASH non-secure status register
    /// offset: 0x20
    NSSR: mmio.Mmio(packed struct(u32) {
        /// busy flag BSY flag indicates that a flash memory is busy by an operation (write, erase, option byte change, OBK operation). It is set at the beginning of a flash memory operation and cleared when the operation finishes, or an error occurs.
        BSY: u1,
        /// write buffer not empty flag WBNE flag is set when the flash interface is waiting for new data to complete the write buffer. In this state, the write buffer is not empty. WBNE is reset by hardware each time the write buffer is complete or the write buffer is emptied following one of the event below: the application software forces the write operation using FW bit in FLASH_NSCR the embedded flash memory detects an error that involves data loss This bit cannot be reset by software writing 0 directly. To reset it, clear the write buffer by performing any of the above listed actions, or send the missing data.
        WBNE: u1,
        reserved3: u1 = 0,
        /// data buffer not empty flag DBNE flag is set when the flash interface is processing 6-bits ECC data in dedicated buffer. This bit cannot be set to 0 by software. The hardware resets it once the buffer is free.
        DBNE: u1,
        reserved16: u12 = 0,
        /// end of operation flag EOP flag is set when a operation (program/erase) completes. An interrupt is generated if the EOPIE is set to 1. It is not necessary to reset EOP before starting a new operation. EOP bit is cleared by writing 1 to CLR_EOP bit in FLASH_NSCCR register.
        EOP: u1,
        /// write protection error flag WRPERR flag is raised when a protection error occurs during a program operation. An interrupt is also generated if the WRPERRIE is set to 1. Writing 1 to CLR_WRPERR bit in FLASH_NSCCR register clears WRPERR.
        WRPERR: u1,
        /// programming sequence error flag PGSERR flag is raised when a sequence error occurs. An interrupt is generated if the PGSERRIE bit is set to 1. Writing 1 to CLR_PGSERR bit in FLASH_NSCCR register clears PGSERR.
        PGSERR: u1,
        /// strobe error flag STRBERR flag is raised when a strobe error occurs (when the master attempts to write several times the same byte in the write buffer). An interrupt is generated if the STRBERRIE bit is set to 1. Writing 1 to CLR_STRBERR bit in FLASH_NSCCR register clears STRBERR.
        STRBERR: u1,
        /// inconsistency error flag NSINCERR flag is raised when a inconsistency error occurs. An interrupt is generated if INCERRIE is set to 1. Writing 1 to CLR_INCERR bit in the FLASH_NSCCR register clears NSINCERR.
        INCERR: u1,
        /// OBK general error flag OBKERR flag is raised when the OBK-HDPL signal from the SBS does not match the HDPL value associated with the key slot during access to the key location. Alternatively also when the ALT_SECT is unexpectedly changed while the write buffer is being filled.
        OBKERR: u1,
        /// OBK write error flag OBKWERR flag is raised when the address is not virgin on a write access to the OBK storage. Alternatively also when the OBK selector in the alternate sector is not virgin during a swap operation.
        OBKWERR: u1,
        /// Option byte change error flag OPTCHANGEERR flag indicates that an error occurred during an option byte change operation. When OPTCHANGEERR is set to 1, the option byte change operation did not successfully complete. An interrupt is generated when this flag is raised if the OPTCHANGEERRIE bit of FLASH_NSCR register is set to 1. Writing 1 to CLR_OPTCHANGEERR of register FLASH_NSCCR clears OPTCHANGEERR. Note: The OPTSTRT bit in FLASH_OPTCR cannot be set while OPTCHANGEERR is set.
        OPTCHANGEERR: u1,
        padding: u8 = 0,
    }),
    /// FLASH secure status register
    /// offset: 0x24
    SECSR: mmio.Mmio(packed struct(u32) {
        /// busy flag BSY flag indicates that a FLASH memory is busy (write, erase, option byte change, OBK operations). It is set at the beginning of a flash memory operation and cleared when the operation finishes or an error occurs.
        BSY: u1,
        /// write buffer not empty flag WBNE flag is set when the flash interface is waiting for new data to complete the write buffer. In this state, the write buffer is not empty. WBNE is reset by hardware each time the write buffer is complete or the write buffer is emptied following one of the event below: the application software forces the write operation using FW bit in FLASH_SECCR the flash interface detects an error that involves data loss This bit cannot be reset by writing 0 directly by software. To reset it, clear the write buffer by performing any of the above listed actions, or send the missing data.
        WBNE: u1,
        reserved3: u1 = 0,
        /// data buffer not empty flag DBNE flag is set when the embedded flash memory interface is processing 6-bits ECC data in dedicated buffer. This bit cannot be set to 0 by software. The hardware resets it once the buffer is free.
        DBNE: u1,
        reserved16: u12 = 0,
        /// end of operation flag EOP flag is set when a operation (program/erase) completes. An interrupt is generated if the EOPIE is set to. It is not necessary to reset EOP before starting a new operation. EOP bit is cleared by writing 1 to CLR_EOP bit in FLASH_SECCCR register.
        EOP: u1,
        /// write protection error flag WRPERR flag is raised when a protection error occurs during a program operation. An interrupt is also generated if the WRPERRIE is set to 1. Writing 1 to CLR_WRPERR bit in FLASH_SECCCR register clears WRPERR.
        WRPERR: u1,
        /// programming sequence error flag PGSERR flag is raised when a sequence error occurs. An interrupt is generated if the PGSERRIE bit is set to 1. Writing 1 to CLR_PGSERR bit in FLASH_SECCCR register clears PGSERR.
        PGSERR: u1,
        /// strobe error flag STRBERR flag is raised when a strobe error occurs (when the master attempts to write several times the same byte in the write buffer). An interrupt is generated if the STRBERRIE bit is set to 1. Writing 1 to CLR_STRBERR bit in FLASH_SECCCR register clears STRBERR.
        STRBERR: u1,
        /// inconsistency error flag INCERR flag is raised when a inconsistency error occurs. An interrupt is generated if INCERRIE is set to 1. Writing 1 to CLR_INCERR bit in the FLASH_SECCCR register clears INCERR.
        INCERR: u1,
        /// OBK general error flag OBKERR flag is raised when the OBK-HDPL signal from the SBS does not match the HDPL value associated with the key slot during access to the key location. Alternatively also when the ALT_SECT is unexpectedly changed while the write buffer is being filled.
        OBKERR: u1,
        /// OBK write error flag OBKWERR flag is raised when the address is not virgin on a write access to the OBK storage. Alternatively also when the OBK selector in the alternate sector is not virgin during a swap operation.
        OBKWERR: u1,
        padding: u9 = 0,
    }),
    /// FLASH non-secure control register
    /// offset: 0x28
    NSCR: mmio.Mmio(packed struct(u32) {
        /// configuration lock bit This bit locks the FLASH_NSCR register. The correct write sequence to FLASH_NSKEYR register unlocks this bit. If a wrong sequence is executed, or if the unlock sequence to FLASH_NSKEYR is performed twice, this bit remains locked until the next system reset. LOCK can be set by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When LOCK changes from 0 to 1, the other bits of FLASH_NSCR register do not change.
        LOCK: u1,
        /// programming control bit PG can be programmed only when LOCK is cleared to 0. PG allows programming in Bank1 and Bank2.
        PG: u1,
        /// sector erase request Setting SER bit to 1 requests a sector erase. SER can be programmed only when LOCK is cleared to 0. If MER and SER are also set, a PGSERR is raised.
        SER: u1,
        /// erase request Setting BER bit to 1 requests a bank erase operation (user flash memory only). BER can be programmed only when LOCK is cleared to 0. If MER and SER are also set, a PGSERR is raised. Note: Write protection error is triggered when a bank erase is required and some sectors are protected.
        BER: u1,
        /// write forcing control bit FW forces a write operation even if the write buffer is not full. In this case all bits not written are set to 1 by hardware. FW can be programmed only when LOCK is cleared to 0. The embedded flash memory resets FW when the corresponding operation has been acknowledged. Note: Using a force-write operation prevents the application from updating later the missing bits with something else than 1, because it is likely that it leads to permanent ECC error. Write forcing is effective only if the write buffer is not empty and was filled by non-secure access (in particular, FW does not start several write operations when the force-write operations are performed consecutively). Since there is just one write buffer, FW can force a write in bank1 or bank2.
        FW: u1,
        /// erase start control bit STRT bit is used to start a sector erase or a bank erase operation. STRT can be programmed only when LOCK is cleared to 0. STRT is reset at the end of the operation or when an error occurs. It cannot be reseted by software.
        STRT: u1,
        /// sector erase selection number These bits are used to select the target sector for an erase operation (they are unused otherwise). SNB can be programmed only when LOCK is cleared to 0. ..
        SNB: u7,
        reserved15: u2 = 0,
        /// Mass erase request Setting MER bit to 1 requests a mass erase operation (user flash memory only). MER can be programmed only when LOCK is cleared to 0. If BER or SER are both set, a PGSERR is raised. Error is triggered when a mass erase is required and some sectors are protected.
        MER: u1,
        /// end of operation interrupt control bit Setting EOPIE bit to 1 enables the generation of an interrupt at the end of a program or erase operation. EOPIE can be programmed only when LOCK is cleared to 0.
        EOPIE: u1,
        /// write protection error interrupt enable bit When this bit is set to 1, an interrupt is generated when a protection error occurs during a program operation. WRPERRIE can be programmed only when LOCK is cleared to 0.
        WRPERRIE: u1,
        /// programming sequence error interrupt enable bit When this bit is set to 1, an interrupt is generated when a sequence error occurs during a program operation. PGSERRIE can be programmed only when LOCK is cleared to 0.
        PGSERRIE: u1,
        /// strobe error interrupt enable bit When STRBERRIE bit is set to 1, an interrupt is generated when a strobe error occurs (the master programs several times the same byte in the write buffer) during a write operation. STRBERRIE can be programmed only when LOCK is cleared to 0.
        STRBERRIE: u1,
        /// inconsistency error interrupt enable bit When INCERRIE bit is set to 1, an interrupt is generated when an inconsistency error occurs during a write operation. INCERRIE can be programmed only when LOCK is cleared to 0.
        INCERRIE: u1,
        /// OBK general error interrupt enable bit OBKERRIE enables generating an interrupt in case of OBK specific access error. This bit can be programmed only when LOCK bit is cleared to 0.
        OBKERRIE: u1,
        /// OBK write error interrupt enable bit OBKWERRIE enables generation of interrupt in case of OBK specific write error. This bit can be programmed only when LOCK bit is cleared to 0.
        OBKWERRIE: u1,
        /// Option byte change error interrupt enable bit This bit controls if an interrupt must be generated when an error occurs during an option byte change. It can be programmed only when LOCK bit is cleared to 0.
        OPTCHANGEERRIE: u1,
        reserved31: u7 = 0,
        /// Bank selector bit BKSEL can only be programmed when LOCK is cleared to 0. The bit selects physical bank, SWAP_BANK setting is ignored.
        BKSEL: NSCR_BKSEL,
    }),
    /// FLASH secure control register
    /// offset: 0x2c
    SECCR: mmio.Mmio(packed struct(u32) {
        /// configuration lock bit This bit locks the FLASH_SECCR register. The correct write sequence to FLASH_SECKEYR register unlocks this bit. If a wrong sequence is executed, or if the unlock sequence to FLASH_NSKEYR is performed twice, this bit remains locked until the next system reset. LOCK can be set by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When LOCK changes from 0 to 1, the other bits of FLASH_SECCR register do not change.
        LOCK: u1,
        /// programming control bit PG can be programmed only when LOCK is cleared to 0. PG allows programming in Bank1 and Bank2.
        PG: u1,
        /// sector erase request Setting SER bit to 1 requests a sector erase. SER can be programmed only when LOCK is cleared to 0. If BER and MER are also set, a PGSERR is raised.
        SER: u1,
        /// erase request Setting BER bit to 1 requests a bank erase operation (user flash memory only). BER can be programmed only when LOCK is cleared to 0. If MER and SER are also set, a PGSERR is raised. Note: Write protection error is triggered when a bank erase is required and some sectors are protected.
        BER: u1,
        /// write forcing control bit FW forces a write operation even if the write buffer is not full. In this case all bits not written are set to 1 by hardware. FW can be programmed only when LOCK is cleared to 0. The embedded flash memory resets FW when the corresponding operation has been acknowledged. Note: Using a force-write operation prevents the application from updating later the missing bits with something else than 1, because it is likely that it leads to permanent ECC error. Write forcing is effective only if the write buffer is not empty and was filled by secure access (in particular, FW does not start several write operations when the force-write operations are performed consecutively). Since there is just one write buffer, FW can force a write in bank1 or bank2.
        FW: u1,
        /// erase start control bit STRT bit is used to start a sector erase or a bank erase operation. STRT can be programmed only when LOCK is cleared to 0. STRT is reseted at the end of the operation or when an error occurs. It cannot be reset by software.
        STRT: u1,
        /// sector erase selection number These bits are used to select the target sector for an erase operation (they are unused otherwise). SNB can be programmed only when LOCK is cleared to 0. ..
        SNB: u7,
        reserved15: u2 = 0,
        /// mass erase request Setting MER bit to 1 requests a mass erase operation (user flash memory only). MER can be programmed only when LOCK is cleared to 0. If BER or SER are also set, a PGSERR is raised. Error is triggered when a mass erase is required and some sectors are protected.
        MER: u1,
        /// end of operation interrupt control bit Setting EOPIE bit to 1 enables the generation of an interrupt at the end of a program/erase operation. EOPIE can be programmed only when LOCK is cleared to 0.
        EOPIE: u1,
        /// write protection error interrupt enable bit When WRPERRIE bit is set to 1, an interrupt is generated when a protection error occurs during a program operation. WRPERRIE can be programmed only when LOCK is cleared to 0.
        WRPERRIE: u1,
        /// programming sequence error interrupt enable bit When PGSERRIE bit is set to 1, an interrupt is generated when a sequence error occurs during a program operation. PGSERRIE can be programmed only when LOCK is cleared to 0.
        PGSERRIE: u1,
        /// strobe error interrupt enable bit When STRBERRIE bit is set to 1, an interrupt is generated when a strobe error occurs (the master programs several times the same byte in the write buffer) during a write operation. STRBERRIE can be programmed only when LOCK is cleared to 0.
        STRBERRIE: u1,
        /// inconsistency error interrupt enable bit When INCERRIE bit is set to 1, an interrupt is generated when an inconsistency error occurs during a write operation. INCERRIE can be programmed only when LOCK is cleared to 0.
        INCERRIE: u1,
        /// OBK general error interrupt enable bit OBKERRIE enables generating an interrupt in case of OBK specific access error. OBKERRIE can be programmed only when LOCK is cleared to 0.
        OBKERRIE: u1,
        /// OBK write error interrupt enable bit OBKWERRIE enables generation of interrupt in case of OBK specific write error. OBKWERRIE can be programmed only when LOCK is cleared to 0.
        OBKWERRIE: u1,
        reserved29: u6 = 0,
        /// Flash memory security state invert. This bit inverts the flash memory security state.
        INV: u1,
        reserved31: u1 = 0,
        /// bank selector bit BKSEL can only be programmed when LOCK is cleared to 0. The bit selects physical bank, SWAP_BANK setting is ignored.
        BKSEL: SECCR_BKSEL,
    }),
    /// FLASH non-secure clear control register
    /// offset: 0x30
    NSCCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// EOP flag clear bit Setting this bit to 1 resets to 0 EOP flag in FLASH_NSSR register.
        CLR_EOP: u1,
        /// WRPERR flag clear bit Setting this bit to 1 resets to 0 WRPERR flag in FLASH_NSSR register.
        CLR_WRPERR: u1,
        /// PGSERR flag clear bit Setting this bit to 1 resets to 0 PGSERR flag in FLASH_NSSR register.
        CLR_PGSERR: u1,
        /// STRBERR flag clear bit Setting this bit to 1 resets to 0 STRBERR flag in FLASH_NSSR register.
        CLR_STRBERR: u1,
        /// INCERR flag clear bit Setting this bit to 1 resets to 0 INCERR flag in FLASH_NSSR register.
        CLR_INCERR: u1,
        /// OBKERR flag clear bit. Setting this bit to 1 resets to 0 OBKERR flag in FLASH_NSSR register.
        CLR_OBKERR: u1,
        /// OBKWERR flag clear bit. Setting this bit to 1 resets to 0 OBKWERR flag in FLASH_NSSR register.
        CLR_OBKWERR: u1,
        /// Clear the flag corresponding flag in FLASH_NSSR by writing this bit.
        CLR_OPTCHANGEERR: u1,
        padding: u8 = 0,
    }),
    /// FLASH secure clear control register
    /// offset: 0x34
    SECCCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// EOP flag clear bit Setting this bit to 1 resets to 0 EOP flag in FLASH_SECSR register.
        CLR_EOP: u1,
        /// WRPERR flag clear bit Setting this bit to 1 resets to 0 WRPERR flag in FLASH_SECSR register.
        CLR_WRPERR: u1,
        /// PGSERR flag clear bit Setting this bit to 1 resets to 0 PGSERR flag in FLASH_SECSR register.
        CLR_PGSERR: u1,
        /// STRBERR flag clear bit Setting this bit to 1 resets to 0 STRBERR flag in FLASH_SECSR register.
        CLR_STRBERR: u1,
        /// INCERR flag clear bit Setting this bit to 1 resets to 0 INCERR flag in FLASH_SECSR register.
        CLR_INCERR: u1,
        /// OBKWERR flag clear bit Setting this bit to 1 resets to 0 OBKWERR flag in FLASH_SECSR register.
        CLR_OBKERR: u1,
        /// OBKWERR flag clear bit Setting this bit to 1 resets to 0 OBKWERR flag in FLASH_SECSR register.
        CLR_OBKWERR: u1,
        padding: u9 = 0,
    }),
    /// offset: 0x38
    reserved56: [4]u8,
    /// FLASH privilege configuration register
    /// offset: 0x3c
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// privilege attribute for secure registers
        SPRIV: SPRIV,
        /// privilege attribute for non secure registers
        NSPRIV: NSPRIV,
        padding: u30 = 0,
    }),
    /// FLASH non-secure OBK configuration register
    /// offset: 0x40
    NSOBKCFGR: mmio.Mmio(packed struct(u32) {
        /// OBKCFGR lock option configuration bit This bit locks the FLASH_NSOBKCFGR register. The correct write sequence to FLASH_NSOBKKEYR register unlocks this bit. If a wrong sequence is executed, or if the unlock sequence to FLASH_NSOBKKEYR is performed twice, this bit remains locked until the next system reset. LOCK can be set by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When LOCK changes from 0 to 1, the other bits of FLASH_NSCR register do not change.
        LOCK: u1,
        /// OBK swap sector request bit When set, all the OBKs which have not been updated in the alternate sector is copied from current sector to alternate one. The SWAP_OFFSET value must be a certain minimum value in order for the swap to be launched in OBK-HDPL ≠ 0. Minimum value is 16 for OBK-HDPL = 1, 144 for OBK-HDPL = 2 and 192 for OBK-HDPL = 3.
        SWAP_SECT_REQ: u1,
        /// alternate sector bit This bit must not change while filling the write buffer, otherwise an error (OBKERR) is generated
        ALT_SECT: u1,
        /// alternate sector erase bit When ALT_SECT bit is set, use this bit to generate an erase command for the OBK alternate sector. It is set only by Software and cleared when the OBK swap operation is completed or an error occurs (PGSERR). It is reseted at the same time as BUSY bit.
        ALT_SECT_ERASE: u1,
        reserved16: u12 = 0,
        /// Key index (offset /16 bits) pointing for next swap. 0x01 means that only the first OBK data (128 bits) is copied from current to alternate OBK sector 0x02 means that the two first OBK data is copied … …
        SWAP_OFFSET: u9,
        padding: u7 = 0,
    }),
    /// FLASH secure OBK configuration register
    /// offset: 0x44
    SECOBKCFGR: mmio.Mmio(packed struct(u32) {
        /// OBKCFGR lock option configuration bit This bit locks the FLASH_OBKCFGR register. The correct write sequence to FLASH_SECOBKKEYR register unlocks this bit. If a wrong sequence is executed, or if the unlock sequence to FLASH_SECOBKKEYR is performed twice, this bit remains locked until the next system reset. LOCK can be set by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When LOCK changes from 0 to 1, the other bits of FLASH_NSCR register do not change.
        LOCK: u1,
        /// OBK swap sector request bit When set, all the OBKs which have not been updated in the alternate sector is copied from current sector to alternate one. The SWAP_OFFSET value must be a certain minimum value in order for the swap to be launched in OBK-HDPL ≠ 0. Minimum value is 16 for OBK-HDPL = 1, 144 for OBK-HDPL = 2 and 192 for OBK-HDPL = 3.
        SWAP_SECT_REQ: u1,
        /// alternate sector bit This bit must not change while filling the write buffer, otherwise an error is generated
        ALT_SECT: u1,
        /// alternate sector erase bit When ALT_SECT bit is set, use this bit to generate an erase command for the OBK alternate sector. It is set only by Software and cleared when the OBK swap operation is completed or an error occurs (PGSERR). It is reseted at the same time as the BUSY bit.
        ALT_SECT_ERASE: u1,
        reserved16: u12 = 0,
        /// key index (offset /16 bits) pointing for next swap. …
        SWAP_OFFSET: u9,
        padding: u7 = 0,
    }),
    /// FLASH HDP extension register
    /// offset: 0x48
    HDPEXTR: mmio.Mmio(packed struct(u32) {
        /// HDP area extension in 8�Kbytes sectors in Bank1. Extension is added after the HDP1_END sector (included).
        HDP1_EXT: u7,
        reserved16: u9 = 0,
        /// HDP area extension in 8�Kbytes sectors in bank 2. Extension is added after the HDP2_END sector (included).
        HDP2_EXT: u7,
        padding: u9 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// FLASH option status register
    /// offset: 0x50
    OPTSR_CUR: mmio.Mmio(packed struct(u32) {
        /// Brownout level option status bit These bits reflects the power level that generates a system reset. 00 or 11: BOR Level 1, the threshold level is low (around 2.1�V)
        BOR_LEV: OPTSR_BOR_LEV,
        /// Brownout high enable
        BORH_EN: u1,
        /// IWDG control mode option status bit
        IWDG_SW: OPTSR_IWDG_SW,
        /// WWDG control mode option status bit
        WWDG_SW: OPTSR_WWDG_SW,
        reserved6: u1 = 0,
        /// Core domain Stop entry reset option status bit
        NRST_STOP: OPTSR_NRST_STOP,
        /// Core domain Standby entry reset option status bit
        NRST_STDBY: OPTSR_NRST_STDBY,
        /// Life state code (based on Hamming 8,4). More information in Section�7.6.11: Product state transitions.
        PRODUCT_STATE: u8,
        /// High-speed IO at low V<sub>DD</sub> voltage configuration bit. This bit can be set only with V<sub>DD</sub> below 2.7�V.
        IO_VDD_HSLV: OPTSR_IO_VDD_HSLV,
        /// High-speed IO at low V<sub>DDIO2</sub> voltage configuration bit. This bit can be set only with V<sub>DDIO2</sub> below 2.7�V.
        IO_VDDIO2_HSLV: OPTSR_IO_VDDIO_HSLV,
        reserved20: u2 = 0,
        /// IWDG Stop mode freeze option status bit When set the independent watchdog IWDG is in system Stop mode.
        IWDG_STOP: OPTSR_IWDG_STOP,
        /// IWDG Standby mode freeze option status bit When set the independent watchdog IWDG is frozen in system Standby mode.
        IWDG_STDBY: OPTSR_IWDG_STDBY,
        /// Available only on cryptography enabled devices. Unique boot entry control, selects either ST or OEM iRoT for secure boot.
        BOOT_UBE: OPTSR_BOOT_UBE,
        reserved31: u1 = 0,
        /// Bank swapping option status bit SWAP_BANK reflects whether Bank1 and Bank2 are swapped or not. SWAP_BANK is loaded to SWAP_BANK of FLASH_OPTCR after a reset.
        SWAP_BANK: OPTSR_SWAP_BANK,
    }),
    /// FLASH option status register
    /// offset: 0x54
    OPTSR_PRG: mmio.Mmio(packed struct(u32) {
        /// Brownout level option status bit These bits reflects the power level that generates a system reset. 00 or 11: BOR Level 1, the threshold level is low (around 2.1�V)
        BOR_LEV: OPTSR_BOR_LEV,
        /// Brownout high enable
        BORH_EN: u1,
        /// IWDG control mode option status bit
        IWDG_SW: OPTSR_IWDG_SW,
        /// WWDG control mode option status bit
        WWDG_SW: OPTSR_WWDG_SW,
        reserved6: u1 = 0,
        /// Core domain Stop entry reset option status bit
        NRST_STOP: OPTSR_NRST_STOP,
        /// Core domain Standby entry reset option status bit
        NRST_STDBY: OPTSR_NRST_STDBY,
        /// Life state code (based on Hamming 8,4). More information in Section�7.6.11: Product state transitions.
        PRODUCT_STATE: u8,
        /// High-speed IO at low V<sub>DD</sub> voltage configuration bit. This bit can be set only with V<sub>DD</sub> below 2.7�V.
        IO_VDD_HSLV: OPTSR_IO_VDD_HSLV,
        /// High-speed IO at low V<sub>DDIO2</sub> voltage configuration bit. This bit can be set only with V<sub>DDIO2</sub> below 2.7�V.
        IO_VDDIO2_HSLV: OPTSR_IO_VDDIO_HSLV,
        reserved20: u2 = 0,
        /// IWDG Stop mode freeze option status bit When set the independent watchdog IWDG is in system Stop mode.
        IWDG_STOP: OPTSR_IWDG_STOP,
        /// IWDG Standby mode freeze option status bit When set the independent watchdog IWDG is frozen in system Standby mode.
        IWDG_STDBY: OPTSR_IWDG_STDBY,
        /// Available only on cryptography enabled devices. Unique boot entry control, selects either ST or OEM iRoT for secure boot.
        BOOT_UBE: OPTSR_BOOT_UBE,
        reserved31: u1 = 0,
        /// Bank swapping option status bit SWAP_BANK reflects whether Bank1 and Bank2 are swapped or not. SWAP_BANK is loaded to SWAP_BANK of FLASH_OPTCR after a reset.
        SWAP_BANK: OPTSR_SWAP_BANK,
    }),
    /// offset: 0x58
    reserved88: [8]u8,
    /// FLASH non-secure EPOCH register
    /// offset: 0x60
    NSEPOCHR_CUR: mmio.Mmio(packed struct(u32) {
        /// Non-volatile non-secure EPOCH counter
        NS_EPOCH: u24,
        padding: u8 = 0,
    }),
    /// offset: 0x64
    reserved100: [4]u8,
    /// FLASH secure EPOCH register
    /// offset: 0x68
    SECEPOCHR_CUR: mmio.Mmio(packed struct(u32) {
        /// Non-volatile secure EPOCH counter
        SEC_EPOCH: u24,
        padding: u8 = 0,
    }),
    /// offset: 0x6c
    reserved108: [4]u8,
    /// FLASH option status register 2
    /// offset: 0x70
    OPTSR2_CUR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// SRAM1 and SRAM3 erase upon system reset
        SRAM13_RST: u1,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Backup RAM ECC detection and correction disable
        BKPRAM_ECC: OPTSR_BKPRAM_ECC,
        /// SRAM3 ECC detection and correction disable
        SRAM3_ECC: OPTSR_SRAM_ECC,
        /// SRAM2 ECC detection and correction disable
        SRAM2_ECC: OPTSR_SRAM_ECC,
        reserved8: u1 = 0,
        /// USB power delivery configuration option bit
        USBPD_DIS: u1,
        reserved24: u15 = 0,
        /// TrustZone enable configuration bits This bit enables the device is in TrustZone mode during an option byte change.
        TZEN: OPTSR_TZEN,
    }),
    /// FLASH option status register 2
    /// offset: 0x74
    OPTSR2_PRG: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// SRAM1 and SRAM3 erase upon system reset
        SRAM13_RST: u1,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Backup RAM ECC detection and correction disable
        BKPRAM_ECC: OPTSR_BKPRAM_ECC,
        /// SRAM3 ECC detection and correction disable
        SRAM3_ECC: OPTSR_SRAM_ECC,
        /// SRAM2 ECC detection and correction disable
        SRAM2_ECC: OPTSR_SRAM_ECC,
        reserved8: u1 = 0,
        /// USB power delivery configuration option bit
        USBPD_DIS: u1,
        reserved24: u15 = 0,
        /// TrustZone enable configuration bits This bit enables the device is in TrustZone mode during an option byte change.
        TZEN: OPTSR_TZEN,
    }),
    /// offset: 0x78
    reserved120: [8]u8,
    /// FLASH non-secure boot register
    /// offset: 0x80
    NSBOOTR_CUR: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of SWAP_ BANK, and NSBOOTADD settings.
        NSBOOT_LOCK: NSBOOTR_NSBOOT_LOCK,
        /// Non secure unique boot entry address These bits allow configuring the Non secure BOOT address
        NSBOOTADD: u24,
    }),
    /// FLASH non-secure boot register
    /// offset: 0x84
    NSBOOTR_PRG: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of SWAP_ BANK, and NSBOOTADD settings.
        NSBOOT_LOCK: NSBOOTR_NSBOOT_LOCK,
        /// Non secure unique boot entry address These bits allow configuring the Non secure BOOT address
        NSBOOTADD: u24,
    }),
    /// FLASH secure boot register
    /// offset: 0x88
    SECBOOTR_CUR: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of UBE, SWAP_BANK, and SECBOOTADD settings.
        SECBOOT_LOCK: SECBOOTR_SECBOOT_LOCK,
        /// Unique boot entry secure address These bits reflect the Secure UBE address
        SECBOOTADD: u24,
    }),
    /// FLASH secure boot register
    /// offset: 0x8c
    BOOTR_PRG: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of UBE, SWAP_ BANK, and SECBOOTADD setting.
        SECBOOT_LOCK: BOOTR_SECBOOT_LOCK,
        /// Secure unique boot entry address. These bits allow configuring the secure UBE address.
        SECBOOTADD: u24,
    }),
    /// FLASH non-secure OTP block lock
    /// offset: 0x90
    OTPBLR_CUR: mmio.Mmio(packed struct(u32) {
        /// OTP block lock Block n corresponds to OTP 16-bit word 32 x n to 32 x n + 31. LOCKBL[n] = 1 indicates that all OTP 16-bit words in OTP Block n are locked and attempt to program them results in WRPERR. LOCKBL[n] = 0 indicates that all OTP 16-bit words in OTP Block n are not locked. When one block is locked, it’s not possible to remove the write protection. Also if not locked, it is not possible to erase OTP words.
        LOCKBL: u32,
    }),
    /// FLASH non-secure OTP block lock
    /// offset: 0x94
    OTPBLR_PRG: mmio.Mmio(packed struct(u32) {
        /// OTP block lock Block n corresponds to OTP 16-bit word 32 x n to 32 x n + 31. LOCKBL[n] = 1 indicates that all OTP 16-bit words in OTP Block n are locked and attempt to program them results in WRPERR. LOCKBL[n] = 0 indicates that all OTP 16-bit words in OTP Block n are not locked. When one block is locked, it’s not possible to remove the write protection. Also if not locked, it is not possible to erase OTP words.
        LOCKBL: u32,
    }),
    /// offset: 0x98
    reserved152: [8]u8,
    /// FLASH secure block based register for Bank 1
    /// offset: 0xa0
    SECBB1R1: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block based register for Bank 1
    /// offset: 0xa4
    SECBB1R2: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block based register for Bank 1
    /// offset: 0xa8
    SECBB1R3: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block based register for Bank 1
    /// offset: 0xac
    SECBB1R4: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// offset: 0xb0
    reserved176: [16]u8,
    /// FLASH privilege block based register for Bank 1
    /// offset: 0xc0
    PRIVBB1R1: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block based register for Bank 1
    /// offset: 0xc4
    PRIVBB1R2: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block based register for Bank 1
    /// offset: 0xc8
    PRIVBB1R3: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block based register for Bank 1
    /// offset: 0xcc
    PRIVBB1R4: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// offset: 0xd0
    reserved208: [16]u8,
    /// FLASH security watermark for Bank 1
    /// offset: 0xe0
    SECWM1R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank2 security WM area start sector
        SECWMSTRT: u7,
        reserved16: u9 = 0,
        /// Bank2 security WM end sector
        SECWMEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH security watermark for Bank 1
    /// offset: 0xe4
    SECWM1R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank2 security WM area start sector
        SECWMSTRT: u7,
        reserved16: u9 = 0,
        /// Bank2 security WM end sector
        SECWMEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH write sector group protection for Bank 1
    /// offset: 0xe8
    WRP1R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank1 sector group protection option status byte Setting WRPSG1 bits to 0 write protects the corresponding group of four consecutive sectors in bank 1 (0: the group is write protected; 1: the group is not write protected) Bit 0: Group embedding sectors 0 to 3 Bit 1: Group embedding sectors 4 to 7 Bit N: Group embedding sectors 4 x N to 4 x N + 3 Bit 31: Group embedding sectors 124 to 127
        WRPSG: u32,
    }),
    /// FLASH write sector group protection for Bank 1
    /// offset: 0xec
    WRP1R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank1 sector group protection option status byte Setting WRPSG1 bits to 0 write protects the corresponding group of four consecutive sectors in bank 1 (0: the group is write protected; 1: the group is not write protected) Bit 0: Group embedding sectors 0 to 3 Bit 1: Group embedding sectors 4 to 7 Bit N: Group embedding sectors 4 x N to 4 x N + 3 Bit 31: Group embedding sectors 124 to 127
        WRPSG: u32,
    }),
    /// FLASH data sector configuration Bank 1
    /// offset: 0xf0
    EDATA1R_CUR: mmio.Mmio(packed struct(u32) {
        /// EDATA1_STRT contains the start sectors of the flash high-cycle data area in Bank 1 There is no hardware effect to those bits. They shall be managed by ST tools in Flasher. ... Note: 111: The eight last sectors of the Bank 1 are reserved for flash high-cycle data
        EDATA1_STRT: u3,
        reserved15: u12 = 0,
        /// Bank 1 flash high-cycle data enable
        EDATA1_EN: u1,
        padding: u16 = 0,
    }),
    /// FLASH data sector configuration Bank 1
    /// offset: 0xf4
    EDATA1R_PRG: mmio.Mmio(packed struct(u32) {
        /// EDATA1_STRT contains the start sectors of the flash high-cycle data area in Bank 1 There is no hardware effect to those bits. They shall be managed by ST tools in Flasher. ... Note: 111: The eight last sectors of the Bank 1 are reserved for flash high-cycle data
        EDATA1_STRT: u3,
        reserved15: u12 = 0,
        /// Bank 1 flash high-cycle data enable
        EDATA1_EN: u1,
        padding: u16 = 0,
    }),
    /// FLASH HDP Bank 1 configuration
    /// offset: 0xf8
    HDP1R_CUR: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8-Kbyte sectors
        HDP1_STRT: u7,
        reserved16: u9 = 0,
        /// HDPL barrier end set in number of 8-Kbyte sectors
        HDP1_END: u7,
        padding: u9 = 0,
    }),
    /// FLASH HDP Bank 1 configuration
    /// offset: 0xfc
    HDP1R_PRG: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8-Kbyte sectors
        HDP1_STRT: u7,
        reserved16: u9 = 0,
        /// HDPL barrier end set in number of 8-Kbyte sectors
        HDP1_END: u7,
        padding: u9 = 0,
    }),
    /// FLASH ECC correction register
    /// offset: 0x100
    ECCCORR: mmio.Mmio(packed struct(u32) {
        /// ECC error address When an ECC error occurs (for single correction) during a read operation, the ADDR_ECC contains the address that generated the error. ADDR_ECC is reset when the flag error is reset. The flash interface programs the address in this register only when no ECC error flags are set. This means that only the first address that generated an ECC error is saved. The address in ADDR_ECC is relative to the flash memory area where the error occurred (user flash memory, system flash memory, data area, read-only/OTP area).
        ADDR_ECC: u16,
        reserved20: u4 = 0,
        /// Single ECC error corrected in flash OB Keys storage area. It indicates the OBK storage concerned by ECC error.
        OBK_ECC: u1,
        /// ECC fail for corrected ECC error in flash high-cycle data area It indicates if flash high-cycle data area is concerned by ECC error.
        EDATA_ECC: u1,
        /// ECC fail bank for corrected ECC error It indicates which bank is concerned by ECC error
        BK_ECC: u1,
        /// ECC fail for corrected ECC error in system flash memory It indicates if system flash memory is concerned by ECC error.
        SYSF_ECC: u1,
        /// OTP ECC error bit This bit is set to 1 when one single ECC correction occurred during the last successful read operation from the read-only/ OTP area. The address of the ECC error is available in ADDR_ECC bitfield.
        OTP_ECC: u1,
        /// ECC single correction error interrupt enable bit When ECCCIE bit is set to 1, an interrupt is generated when an ECC single correction error occurs during a read operation.
        ECCCIE: u1,
        reserved30: u4 = 0,
        /// ECC correction set by hardware when single ECC error has been detected and corrected. Cleared by writing 1.
        ECCC: u1,
        padding: u1 = 0,
    }),
    /// FLASH ECC detection register
    /// offset: 0x104
    ECCDETR: mmio.Mmio(packed struct(u32) {
        /// ECC error address When an ECC error occurs (double detection) during a read operation, the ADDR_ECC contains the address that generated the error. ADDR_ECC is reset when the flag error is reset. The flash interface programs the address in this register only when no ECC error flags are set. This means that only the first address that generated an double ECC error is saved. The address in ADDR_ECC is relative to the flash memory area where the error occurred (user flash memory, system flash memory, data area, read-only/OTP area).
        ADDR_ECC: u16,
        reserved20: u4 = 0,
        /// ECC fail double ECC error in flash OB Keys storage area. It indicates the OBK storage concerned by ECC error.
        OBK_ECC: u1,
        /// ECC fail double ECC error in flash high-cycle data area It indicates if flash high-cycle data area is concerned by ECC error.
        EDATA_ECC: u1,
        /// ECC fail bank for double ECC error It indicates which bank is concerned by ECC error
        BK_ECC: u1,
        /// ECC fail for double ECC error in system flash memory It indicates if system flash memory is concerned by ECC error.
        SYSF_ECC: u1,
        /// OTP ECC error bit This bit is set to 1 when double ECC detection occurred during the last read operation from the read-only/ OTP area. The address of the ECC error is available in ADDR_ECC bitfield.
        OTP_ECC: u1,
        reserved31: u6 = 0,
        /// ECC detection Set by hardware when two ECC error has been detected. When this bit is set, a NMI is generated. Cleared by writing 1. Needs to be cleared in order to detect subsequent double ECC errors.
        ECCD: u1,
    }),
    /// FLASH ECC data
    /// offset: 0x108
    ECCDR: mmio.Mmio(packed struct(u32) {
        /// ECC error data When an double detection ECC error occurs on special areas with 6-bit ECC on 16-bit data (data area, read-only/OTP area), the failing data is read to this register. By checking if it is possible to determine whether the failure was on a real data, or due to access to uninitialized memory.
        DATA_ECC: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x10c
    reserved268: [148]u8,
    /// FLASH secure block-based register for Bank 2
    /// offset: 0x1a0
    SECBB2R1: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block-based register for Bank 2
    /// offset: 0x1a4
    SECBB2R2: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block-based register for Bank 2
    /// offset: 0x1a8
    SECBB2R3: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// FLASH secure block-based register for Bank 2
    /// offset: 0x1ac
    SECBB2R4: mmio.Mmio(packed struct(u32) {
        /// Secure/non-secure flash Bank 2 sector attribute
        SECBB: SECBBR_SECBB,
    }),
    /// offset: 0x1b0
    reserved432: [16]u8,
    /// FLASH privilege block-based register for Bank 2
    /// offset: 0x1c0
    PRIVBB2R1: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block-based register for Bank 2
    /// offset: 0x1c4
    PRIVBB2R2: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block-based register for Bank 2
    /// offset: 0x1c8
    PRIVBB2R3: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// FLASH privilege block-based register for Bank 2
    /// offset: 0x1cc
    PRIVBB2R4: mmio.Mmio(packed struct(u32) {
        /// Privileged / non-privileged 8-Kbyte flash Bank 2 sector attribute
        PRIVBB: PRIVBBR_PRIVBB,
    }),
    /// offset: 0x1d0
    reserved464: [16]u8,
    /// FLASH security watermark for Bank 2
    /// offset: 0x1e0
    SECWM2R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank2 security WM area start sector
        SECWMSTRT: u7,
        reserved16: u9 = 0,
        /// Bank2 security WM end sector
        SECWMEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH security watermark for Bank 2
    /// offset: 0x1e4
    SECWM2R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank2 security WM area start sector
        SECWMSTRT: u7,
        reserved16: u9 = 0,
        /// Bank2 security WM end sector
        SECWMEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH write sector group protection for Bank 2
    /// offset: 0x1e8
    WRP2R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank1 sector group protection option status byte Setting WRPSG1 bits to 0 write protects the corresponding group of four consecutive sectors in bank 1 (0: the group is write protected; 1: the group is not write protected) Bit 0: Group embedding sectors 0 to 3 Bit 1: Group embedding sectors 4 to 7 Bit N: Group embedding sectors 4 x N to 4 x N + 3 Bit 31: Group embedding sectors 124 to 127
        WRPSG: u32,
    }),
    /// FLASH write sector group protection for Bank 2
    /// offset: 0x1ec
    WRP2R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank1 sector group protection option status byte Setting WRPSG1 bits to 0 write protects the corresponding group of four consecutive sectors in bank 1 (0: the group is write protected; 1: the group is not write protected) Bit 0: Group embedding sectors 0 to 3 Bit 1: Group embedding sectors 4 to 7 Bit N: Group embedding sectors 4 x N to 4 x N + 3 Bit 31: Group embedding sectors 124 to 127
        WRPSG: u32,
    }),
    /// FLASH data sectors configuration Bank 2
    /// offset: 0x1f0
    EDATA2R_CUR: mmio.Mmio(packed struct(u32) {
        /// EDATA2_STRT contains the start sectors of the flash high-cycle data area in Bank 2 There is no hardware effect to those bits. They shall be managed by ST tools in Flasher. ... Note: 111: The eight last sectors of the Bank 2 are reserved for flash high-cycle data.
        EDATA2_STRT: u3,
        reserved15: u12 = 0,
        /// Bank 2 flash high-cycle data enable
        EDATA2_EN: u1,
        padding: u16 = 0,
    }),
    /// FLASH data sector configuration Bank 2
    /// offset: 0x1f4
    EDATA2R_PRG: mmio.Mmio(packed struct(u32) {
        /// EDATA2_STRT contains the start sectors of the flash high-cycle data area in Bank 2 There is no hardware effect to those bits. They shall be managed by ST tools in Flasher. ... Note: 111: The eight last sectors of the Bank 2 are reserved for flash high-cycle data.
        EDATA2_STRT: u3,
        reserved15: u12 = 0,
        /// Bank 2 flash high-cycle data enable
        EDATA2_EN: u1,
        padding: u16 = 0,
    }),
    /// FLASH HDP Bank 2 configuration
    /// offset: 0x1f8
    HDP2R_CUR: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8-Kbyte sectors
        HDP2_STRT: u7,
        reserved16: u9 = 0,
        /// HDPL barrier end set in number of 8-Kbyte sectors
        HDP2_END: u7,
        padding: u9 = 0,
    }),
    /// FLASH HDP Bank 2 configuration
    /// offset: 0x1fc
    HDP2R_PRG: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8-Kbyte sectors
        HDP2_STRT: u7,
        reserved16: u9 = 0,
        /// HDPL barrier end set in number of 8-Kbyte sectors
        HDP2_END: u7,
        padding: u9 = 0,
    }),
};
