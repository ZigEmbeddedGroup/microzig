const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BKSEL = enum(u1) {
    /// Bank1 is selected for Bank erase / sector erase / interrupt enable
    BANK1 = 0x0,
    /// Bank1 is selected for Bank erase / sector erase / interrupt enable
    BANK2 = 0x1,
};

pub const CODE_OP = enum(u3) {
    /// No Flash operation on going during previous reset
    B_0x0 = 0x0,
    /// Single write operation interrupted
    B_0x1 = 0x1,
    /// Sector erase operation interrupted
    B_0x3 = 0x3,
    /// Bank erase operation interrupted
    B_0x4 = 0x4,
    /// Mass erase operation interrupted
    B_0x5 = 0x5,
    /// Option change operation interrupted
    B_0x6 = 0x6,
    _,
};

pub const NSBOOTR_NSBOOT_LOCK = enum(u8) {
    /// The NSBOOTADD and SWAP_BANK are frozen.
    B_0xB4 = 0xb4,
    /// The SWAP_BANK and NSBOOTADD can still be modified following their individual rules.
    B_0xC3 = 0xc3,
    _,
};

pub const NSPRIV = enum(u1) {
    /// access to non secure registers is always granted
    B_0x0 = 0x0,
    /// access to non secure registers is denied in case of non privileged access.
    B_0x1 = 0x1,
};

pub const OPTSR_BKPRAM_ECC = enum(u1) {
    /// BKPRAM ECC check enabled
    B_0x0 = 0x0,
    /// BKPRAM ECC check disabled
    B_0x1 = 0x1,
};

pub const OPTSR_BOR_LEV = enum(u2) {
    /// BOR OFF, POR/PDR reset threshold level is applied
    B_0x0 = 0x0,
    /// BOR Level 1, the threshold level is low (around 2.1 V)
    B_0x1 = 0x1,
    /// BOR Level 2, the threshold level is medium (around 2.4 V)
    B_0x2 = 0x2,
    /// BOR Level 3, the threshold level is high (around 2.7 V)
    B_0x3 = 0x3,
};

pub const OPTSR_IO_VDDIO_HSLV = enum(u1) {
    /// High-speed IO at low VDDIO2 voltage feature disabled (VDDIO2 can exceed 2.5 V)
    B_0x0 = 0x0,
    /// High-speed IO at low VDDIO2 voltage feature enabled (VDDIO2 remains below 2.5 V)
    B_0x1 = 0x1,
};

pub const OPTSR_IO_VDD_HSLV = enum(u1) {
    /// High-speed IO at low VDD voltage feature disabled (VDD can exceed 2.5 V)
    B_0x0 = 0x0,
    /// High-speed IO at low VDD voltage feature enabled (VDD remains below 2.5 V)
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

pub const OPTSR_NRST_SHDW = enum(u1) {
    /// a reset is generated when entering Shutdown mode on core domain
    B_0x0 = 0x0,
    /// no reset generated when entering Shutdown mode on core domain.
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

pub const OPTSR_WWDG_SW = enum(u1) {
    /// WWDG watchdog is controlled by hardware
    B_0x0 = 0x0,
    /// WWDG watchdog is controlled by software
    B_0x1 = 0x1,
};

pub const PRIVBB = enum(u8) {
    /// sectors y in bank 1 is non privileged
    B_0x0 = 0x0,
    /// sector y in bank 1 is privileged
    B_0x1 = 0x1,
    _,
};

pub const PRODUCT_STATE = enum(u8) {
    /// Provisioning
    PROVISIONING = 0x17,
    /// iROT-Provisioned
    IROT_PROVISIONED = 0x2e,
    /// Locked
    LOCKED = 0x5c,
    /// Closed
    CLOSED = 0x72,
    /// Regression
    REGRESSION = 0x9a,
    /// Open
    OPEN = 0xed,
    _,
};

/// FLASH address block description
pub const FLASH = extern struct {
    /// FLASH access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Read latency These bits are used to control the number of wait states used during read operations on both non-volatile memory banks. The application software has to program them to the correct value depending on the embedded Flash memory interface frequency and voltage conditions. ... Note: No check is performed by hardware to verify that the configuration is correct.
        LATENCY: u4,
        /// Flash signal delay These bits are used to control the delay between non-volatile memory signals during programming operations. Application software has to program them to the correct value depending on the embedded Flash memory interface frequency. Please refer to for details. Note: No check is performed to verify that the configuration is correct. Two WRHIGHFREQ values can be selected for some frequencies.
        WRHIGHFREQ: u2,
        reserved8: u2 = 0,
        /// Prefetch enable. When bit value is modified, user must read back ACR register to be sure PRFTEN has been taken into account. Bits used to control the prefetch.
        PRFTEN: u1,
        /// Smart prefetch enable. When bit value is modified, user must read back ACR register to be sure S_PRFTEN has been taken into account. Bits used to control the prefetch functionality.
        S_PRFTEN: u1,
        padding: u22 = 0,
    }),
    /// FLASH key register
    /// offset: 0x04
    NSKEYR: u32,
    /// offset: 0x08
    reserved8: [4]u8,
    /// FLASH option key register
    /// offset: 0x0c
    OPTKEYR: u32,
    /// offset: 0x10
    reserved16: [8]u8,
    /// FLASH operation status register
    /// offset: 0x18
    OPSR: mmio.Mmio(packed struct(u32) {
        /// Interrupted operation address.
        ADDR_OP: u20,
        reserved22: u2 = 0,
        /// Interrupted operation bank It indicates which bank was concerned by operation.
        BK_OP: u1,
        /// Operation in system Flash memory interrupted Indicates that reset interrupted an ongoing operation in System Flash.
        SYSF_OP: u1,
        /// OTP operation interrupted Indicates that reset interrupted an ongoing operation in OTP area.
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
        /// Option byte start change option configuration bit OPTSTRT triggers an option byte change operation. The user can set OPTSTRT only when the OPTLOCK bit is cleared to 0. It’s set only by Software and cleared when the option byte change is completed or an error occurs (PGSERR or OPTCHANGEERR). It’s reseted at the same time as BSY bit. The user application cannot modify any FLASH_XXX_PRG embedded Flash memory register until the option change operation has been completed. Before setting this bit, the user has to write the required values in the FLASH_XXX_PRG registers. The FLASH_XXX_PRG registers are locked until the option byte change operation has been executed in non-volatile memory.
        OPTSTRT: u1,
        reserved31: u29 = 0,
        /// Bank swapping option configuration bit SWAP_BANK controls whether Bank1 and Bank2 are swapped or not. This bit is loaded with the SWAP_BANK bit of FLASH_OPTSR_CUR register only after reset or POR.
        SWAP_BANK: u1,
    }),
    /// FLASH non-secure status register
    /// offset: 0x20
    NSSR: mmio.Mmio(packed struct(u32) {
        /// busy flag BSY flag indicates that a Flash memory is busy by an operation (write, erase, option byte change). It is set at the beginning of a Flash memory operation and cleared when the operation finishes or an error occurs.
        BSY: u1,
        /// write buffer not empty flag WBNE flag is set when the embedded Flash memory is waiting for new data to complete the write buffer. In this state, the write buffer is not empty. WBNE is reset by hardware each time the write buffer is complete or the write buffer is emptied following one of the event below: the application software forces the write operation using FW bit in FLASH_NSCR the embedded Flash memory detects an error that involves data loss This bit cannot be reset by software writing 0 directly. To reset it, clear the write buffer by performing any of the above listed actions, or send the missing data.
        WBNE: u1,
        reserved3: u1 = 0,
        /// data buffer not empty flag DBNE flag is set when the embedded Flash memory interface is processing 6-bits ECC data in dedicated buffer. This bit cannot be set to 0 by software. The hardware resets it once the buffer is free.
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
        /// inconsistency error flag INCERR flag is raised when a inconsistency error occurs. An interrupt is generated if INCERRIE is set to 1. Writing 1 to CLR_INCERR bit in the FLASH_NSCCR register clears INCERR.
        INCERR: u1,
        reserved23: u2 = 0,
        /// Option byte change error flag OPTCHANGEERR flag indicates that an error occurred during an option byte change operation. When OPTCHANGEERR is set to 1, the option byte change operation did not successfully complete. An interrupt is generated when this flag is raised if the OPTCHANGEERRIE bit of FLASH_NSCR register is set to 1. Writing 1 to CLR_OPTCHANGEERR of register FLASH_CCR clears OPTCHANGEERR. Note: The OPTSTRT bit in FLASH_OPTCR cannot be set while OPTCHANGEERR is set.
        OPTCHANGEERR: u1,
        padding: u8 = 0,
    }),
    /// FLASH secure status register
    /// offset: 0x24
    SECSR: mmio.Mmio(packed struct(u32) {
        /// busy flag BSY flag indicates that a FLASH memory is busy by an operation (write, erase, option byte change, OBK operations, PUF operation). It is set at the beginning of a Flash memory operation and cleared when the operation finishes or an error occurs.
        SECBSY: u1,
        /// write buffer not empty flag WBNE flag is set when the embedded Flash memory is waiting for new data to complete the write buffer. In this state, the write buffer is not empty. WBNE is reset by hardware each time the write buffer is complete or the write buffer is emptied following one of the event below: the application software forces the write operation using FW bit in FLASH_SECCR the embedded Flash memory detects an error that involves data loss This bit cannot be reset by writing 0 directly by software. To reset it, clear the write buffer by performing any of the above listed actions, or send the missing data.
        SECWBNE: u1,
        reserved3: u1 = 0,
        /// data buffer not empty flag DBNE flag is set when the embedded Flash memory interface is processing 6-bits ECC data in dedicated buffer. This bit cannot be set to 0 by software. The hardware resets it once the buffer is free.
        SECDBNE: u1,
        reserved16: u12 = 0,
        /// end of operation flag EOP flag is set when a operation (program/erase) completes. An interrupt is generated if the EOPIE is set to. It is not necessary to reset EOP before starting a new operation. EOP bit is cleared by writing 1 to CLR_EOP bit in FLASH_SECCCR register.
        SECEOP: u1,
        /// write protection error flag WRPERR flag is raised when a protection error occurs during a program operation. An interrupt is also generated if the WRPERRIE is set to 1. Writing 1 to CLR_WRPERR bit in FLASH_SECCCR register clears WRPERR.
        SECWRPERR: u1,
        /// programming sequence error flag PGSERR flag is raised when a sequence error occurs. An interrupt is generated if the PGSERRIE bit is set to 1. Writing 1 to CLR_PGSERR bit in FLASH_SECCCR register clears PGSERR.
        SECPGSERR: u1,
        /// strobe error flag STRBERR flag is raised when a strobe error occurs (when the master attempts to write several times the same byte in the write buffer). An interrupt is generated if the STRBERRIE bit is set to 1. Writing 1 to CLR_STRBERR bit in FLASH_SECCCR register clears STRBERR.
        SECSTRBERR: u1,
        /// inconsistency error flag INCERR flag is raised when a inconsistency error occurs. An interrupt is generated if INCERRIE is set to 1. Writing 1 to CLR_INCERR bit in the FLASH_SECCCR register clears INCERR.
        SECINCERR: u1,
        padding: u11 = 0,
    }),
    /// FLASH Non Secure control register
    /// offset: 0x28
    NSCR: mmio.Mmio(packed struct(u32) {
        /// configuration lock bit This bit locks the FLASH_NSCR register. The correct write sequence to FLASH_NSKEYR register unlocks this bit. If a wrong sequence is executed, or if the unlock sequence to FLASH_NSKEYR is performed twice, this bit remains locked until the next system reset. LOCK can be set by programming it to 1. When set to 1, a new unlock sequence is mandatory to unlock it. When LOCK changes from 0 to 1, the other bits of FLASH_NSCR register do not change.
        LOCK: u1,
        /// programming control bit PG can be programmed only when LOCK is cleared to 0. PG allows programming in Bank1 and Bank2.
        PG: u1,
        /// sector erase request Setting SER bit to 1 requests a sector erase. SER can be programmed only when LOCK is cleared to 0. If MER and SER are also set, a PGSERR is raised.
        SER: u1,
        /// erase request Setting BER bit to 1 requests a bank erase operation (user Flash memory only). BER can be programmed only when LOCK is cleared to 0. If MER and SER are also set, a PGSERR is raised. Note: Write protection error is triggered when a bank erase is required and some sectors are protected.
        BER: u1,
        /// write forcing control bit FW forces a write operation even if the write buffer is not full. In this case all bits not written are set to 1 by hardware. FW can be programmed only when LOCK is cleared to 0. The embedded Flash memory resets FW when the corresponding operation has been acknowledged. Note: Using a force-write operation prevents the application from updating later the missing bits with something else than 1, because it is likely that it leads to permanent ECC error. Write forcing is effective only if the write buffer is not empty (in particular, FW does not start several write operations when the force-write operations are performed consecutively). Since there is just one write buffer, FW can force a write in bank1 or bank2.
        FW: u1,
        /// erase start control bit STRT bit is used to start a sector erase or a bank erase operation. STRT can be programmed only when LOCK is cleared to 0. STRT is reset at the end of the operation or when an error occurs. It cannot be reseted by software.
        STRT: u1,
        /// sector erase selection number These bits are used to select the target sector for an erase operation (they are unused otherwise). SNB can be programmed only when LOCK is cleared to 0. ...
        SNB: u3,
        reserved15: u6 = 0,
        /// Mass erase request Setting MER bit to 1 requests a mass erase operation (user Flash memory only). MER can be programmed only when LOCK is cleared to 0. If BER or SER are both set, a PGSERR is raised. Error is triggered when a mass erase is required and some sectors are protected.
        MER: u1,
        /// end of operation interrupt control bit Setting EOPIE bit to 1 enables the generation of an interrupt at the end of a program or erase operation. EOPIE can be programmed only when LOCK is cleared to 0.
        EOPIE: u1,
        /// write protection error interrupt enable bit When WRPERRIE bit is set to 1, an interrupt is generated when a protection error occurs during a program operation. WRPERRIE can be programmed only when LOCK is cleared to 0.
        WRPERRIE: u1,
        /// programming sequence error interrupt enable bit When PGSERRIE bit is set to 1, an interrupt is generated when a sequence error occurs during a program operation. PGSERRIE can be programmed only when LOCK is cleared to 0.
        PGSERRIE: u1,
        /// strobe error interrupt enable bit When STRBERRIE bit is set to 1, an interrupt is generated when a strobe error occurs (the master programs several times the same byte in the write buffer) during a write operation. STRBERRIE can be programmed only when LOCK is cleared to 0.
        STRBERRIE: u1,
        /// inconsistency error interrupt enable bit When INCERRIE bit is set to 1, an interrupt is generated when an inconsistency error occurs during a write operation. INCERRIE can be programmed only when LOCK is cleared to 0.
        INCERRIE: u1,
        reserved23: u2 = 0,
        /// Option byte change error interrupt enable bit OPTCHANGEERRIE bit controls if an interrupt has to be generated when an error occurs during an option byte change. This bit can be programmed only when LOCK bit is cleared to 0.
        OPTCHANGEERRIE: u1,
        reserved31: u7 = 0,
        /// Bank selector bit BKSEL can only be programmed when LOCK is cleared to 0. The bit selects physical bank, SWAP_BANK setting is ignored.
        BKSEL: BKSEL,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
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
        reserved23: u2 = 0,
        /// Clear the flag corresponding flag in FLASH_NSSR by writing this bit.
        CLR_OPTCHANGEERR: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x34
    reserved52: [8]u8,
    /// FLASH privilege configuration register
    /// offset: 0x3c
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// privilege attribute for non secure registers
        NSPRIV: NSPRIV,
        padding: u30 = 0,
    }),
    /// offset: 0x40
    reserved64: [8]u8,
    /// FLASH HDP extension register
    /// offset: 0x48
    HDPEXTR: mmio.Mmio(packed struct(u32) {
        /// HDP area extension in 8 Kbytes sectors in Bank1. Extension is added after the HDP1_END sector.
        HDP1_EXT: u3,
        reserved16: u13 = 0,
        /// HDP area extension in 8 Kbytes sectors in Bank2. Extension is added after the HDP2_END sector.
        HDP2_EXT: u3,
        padding: u13 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// FLASH option status register
    /// offset: 0x50
    OPTSR_CUR: mmio.Mmio(packed struct(u32) {
        /// Brownout level option status bit These bits reflects the power level that generates a system reset.
        BOR_LEV: OPTSR_BOR_LEV,
        /// Brownout high enable status bit
        BORH_EN: u1,
        /// IWDG control mode option status bit
        IWDG_SW: OPTSR_IWDG_SW,
        /// WWDG control mode option status bit
        WWDG_SW: OPTSR_WWDG_SW,
        /// Core domain Shutdown entry reset option status bit
        NRST_SHDW: OPTSR_NRST_SHDW,
        /// Core domain Stop entry reset option status bit
        NRST_STOP: OPTSR_NRST_STOP,
        /// Core domain Standby entry reset option status bit
        NRST_STDBY: OPTSR_NRST_STDBY,
        /// Life state code (based on Hamming 8,4).
        PRODUCT_STATE: PRODUCT_STATE,
        /// High-speed IO at low VDD voltage status bit. This bit can be set only with VDD below 2.5 V.
        IO_VDD_HSLV: OPTSR_IO_VDD_HSLV,
        /// High-speed IO at low VDDIO2 voltage status bit. This bit can be set only with VDDIO2 below 2.5 V.
        IO_VDDIO2_HSLV: OPTSR_IO_VDDIO_HSLV,
        reserved20: u2 = 0,
        /// IWDG Stop mode freeze option status bit When set the independent watchdog IWDG is in system Stop mode.
        IWDG_STOP: OPTSR_IWDG_STOP,
        /// IWDG Standby mode freeze option status bit When set the independent watchdog IWDG is frozen in system Standby mode.
        IWDG_STDBY: OPTSR_IWDG_STDBY,
        reserved31: u9 = 0,
        /// Bank swapping option status bit SWAP_BANK reflects whether Bank1 and Bank2 are swapped or not. SWAP_BANK is loaded to SWAP_BANK of FLASH_OPTCR after a reset.
        SWAP_BANK: u1,
    }),
    /// FLASH option status register
    /// offset: 0x54
    OPTSR_PRG: mmio.Mmio(packed struct(u32) {
        /// Brownout level option status bit These bits reflects the power level that generates a system reset.
        BOR_LEV: OPTSR_BOR_LEV,
        /// Brownout high enable status bit
        BORH_EN: u1,
        /// IWDG control mode option status bit
        IWDG_SW: OPTSR_IWDG_SW,
        /// WWDG control mode option status bit
        WWDG_SW: OPTSR_WWDG_SW,
        /// Core domain Shutdown entry reset option status bit
        NRST_SHDW: OPTSR_NRST_SHDW,
        /// Core domain Stop entry reset option status bit
        NRST_STOP: OPTSR_NRST_STOP,
        /// Core domain Standby entry reset option status bit
        NRST_STDBY: OPTSR_NRST_STDBY,
        /// Life state code (based on Hamming 8,4).
        PRODUCT_STATE: PRODUCT_STATE,
        /// High-speed IO at low VDD voltage status bit. This bit can be set only with VDD below 2.5 V.
        IO_VDD_HSLV: OPTSR_IO_VDD_HSLV,
        /// High-speed IO at low VDDIO2 voltage status bit. This bit can be set only with VDDIO2 below 2.5 V.
        IO_VDDIO2_HSLV: OPTSR_IO_VDDIO_HSLV,
        reserved20: u2 = 0,
        /// IWDG Stop mode freeze option status bit When set the independent watchdog IWDG is in system Stop mode.
        IWDG_STOP: OPTSR_IWDG_STOP,
        /// IWDG Standby mode freeze option status bit When set the independent watchdog IWDG is frozen in system Standby mode.
        IWDG_STDBY: OPTSR_IWDG_STDBY,
        reserved31: u9 = 0,
        /// Bank swapping option status bit SWAP_BANK reflects whether Bank1 and Bank2 are swapped or not. SWAP_BANK is loaded to SWAP_BANK of FLASH_OPTCR after a reset.
        SWAP_BANK: u1,
    }),
    /// offset: 0x58
    reserved88: [24]u8,
    /// FLASH option status register 2
    /// offset: 0x70
    OPTSR2_CUR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Backup RAM ECC detection and correction disable
        BKPRAM_ECC: OPTSR_BKPRAM_ECC,
        reserved6: u1 = 0,
        /// SRAM2 ECC detection and correction disable
        SRAM2_ECC: OPTSR_SRAM_ECC,
        reserved9: u2 = 0,
        /// SRAM1 erase upon system reset
        SRAM1_RST: u1,
        /// SRAM1 ECC detection and correction disable
        SRAM1_ECC: OPTSR_SRAM_ECC,
        padding: u21 = 0,
    }),
    /// FLASH option status register 2
    /// offset: 0x74
    OPTSR2_PRG: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Backup RAM ECC detection and correction disable
        BKPRAM_ECC: OPTSR_BKPRAM_ECC,
        reserved6: u1 = 0,
        /// SRAM2 ECC detection and correction disable
        SRAM2_ECC: OPTSR_SRAM_ECC,
        reserved9: u2 = 0,
        /// SRAM1 erase upon system reset
        SRAM1_RST: u1,
        /// SRAM1 ECC detection and correction disable
        SRAM1_ECC: OPTSR_SRAM_ECC,
        padding: u21 = 0,
    }),
    /// offset: 0x78
    reserved120: [8]u8,
    /// FLASH non-secure unique boot entry register
    /// offset: 0x80
    NSBOOTR_CUR: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of SWAP_BANK, and NSBOOTADD settings.
        NSBOOT_LOCK: NSBOOTR_NSBOOT_LOCK,
        /// unique boot entry address These bits reflect the UBE address
        NSBOOTADD: u24,
    }),
    /// FLASH non-secure unique boot entry address
    /// offset: 0x84
    NSBOOTR_PRG: mmio.Mmio(packed struct(u32) {
        /// A field locking the values of SWAP_BANK, and NSBOOTADD settings.
        NSBOOT_LOCK: NSBOOTR_NSBOOT_LOCK,
        /// unique boot entry address These bits reflect the UBE address
        NSBOOTADD: u24,
    }),
    /// offset: 0x88
    reserved136: [8]u8,
    /// FLASH non-secure OTP block lock
    /// offset: 0x90
    OTPBLR_CUR: mmio.Mmio(packed struct(u32) {
        /// OTP block lock Block n corresponds to OTP 16-bit word 32 x n to 32 x n + 31. LOCKBL[n] = 1 indicates that all OTP 16-bit words in OTP Block n are locked and attempt to program them results in WRPERR. LOCKBL[n] = 0 indicates that all OTP 16-bit words in OTP Block n are not locked. When one block is locked, it is not possible to remove the write protection. LOCKBL bits can be set if the corresponding bit in FLASH_OTPBLR_CUR is cleared.
        LOCKBL: u32,
    }),
    /// FLASH non-secure OTP block lock
    /// offset: 0x94
    OTPBLR_PRG: mmio.Mmio(packed struct(u32) {
        /// OTP block lock Block n corresponds to OTP 16-bit word 32 x n to 32 x n + 31. LOCKBL[n] = 1 indicates that all OTP 16-bit words in OTP Block n are locked and attempt to program them results in WRPERR. LOCKBL[n] = 0 indicates that all OTP 16-bit words in OTP Block n are not locked. When one block is locked, it is not possible to remove the write protection. LOCKBL bits can be set if the corresponding bit in FLASH_OTPBLR_CUR is cleared.
        LOCKBL: u32,
    }),
    /// offset: 0x98
    reserved152: [40]u8,
    /// FLASH privilege register for bank 1
    /// offset: 0xc0
    PRIVBB1R: mmio.Mmio(packed struct(u32) {
        /// Privileged / unprivileged 8 Kbytes Flash Bank1 sector attribute (y = 0 to 7)
        PRIVBB: PRIVBB,
        padding: u24 = 0,
    }),
    /// offset: 0xc4
    reserved196: [36]u8,
    /// FLASH write sector protection for Bank1
    /// offset: 0xe8
    WRPSGN1R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank2 sector protection option status byte Setting WRPSG2 bits to 0 write protects the corresponding sectors in bank 2 (0: write protected; 1: not write protected)
        WRPSG: u8,
        padding: u24 = 0,
    }),
    /// FLASH write sector protection for Bank1
    /// offset: 0xec
    WRPSGN1R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank2 sector protection option status byte Setting WRPSG2 bits to 0 write protects the corresponding sectors in bank 2 (0: write protected; 1: not write protected)
        WRPSG: u8,
        padding: u24 = 0,
    }),
    /// offset: 0xf0
    reserved240: [8]u8,
    /// FLASH HDP Bank1 register
    /// offset: 0xf8
    HDP1R_CUR: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8 Kbytes sectors
        HDP1_STRT: u3,
        reserved16: u13 = 0,
        /// HDPL barrier end set in number of 8 Kbytes sectors
        HDP1_END: u3,
        padding: u13 = 0,
    }),
    /// FLASH HDP Bank1 register
    /// offset: 0xfc
    HDP1R_PRG: mmio.Mmio(packed struct(u32) {
        /// HDPL barrier start set in number of 8 Kbytes sectors
        HDP1_STRT: u3,
        reserved16: u13 = 0,
        /// HDPL barrier end set in number of 8 Kbytes sectors
        HDP1_END: u3,
        padding: u13 = 0,
    }),
    /// FLASH Flash ECC correction register
    /// offset: 0x100
    ECCCORR: mmio.Mmio(packed struct(u32) {
        /// ECC error address When an ECC error occurs (for single correction) during a read operation, the ADDR_ECC contains the address that generated the error. ADDR_ECC is reset when the flag error is reset. The embedded Flash memory programs the address in this register only when no ECC error flags are set. This means that only the first address that generated an ECC error is saved. The address in ADDR_ECC is relative to the Flash memory area where the error occurred (user Flash memory, system Flash memory, data area, read-only/OTP area).
        ADDR_ECC: u16,
        reserved22: u6 = 0,
        /// ECC bank flag for corrected ECC error It indicates which bank is concerned by ECC error
        BK_ECC: u1,
        /// ECC flag for corrected ECC error in system FLASH It indicates if system Flash memory is concerned by ECC error.
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
        /// ECC error address When an ECC error occurs (double detection) during a read operation, the ADDR_ECC contains the address that generated the error. ADDR_ECC is reset when the flag error is reset. The embedded Flash memory programs the address in this register only when no ECC error flags are set. This means that only the first address that generated an double ECC error is saved. The address in ADDR_ECC is relative to the Flash memory area where the error occurred (user Flash memory, system Flash memory, data area, read-only/OTP area).
        ADDR_ECC: u16,
        reserved22: u6 = 0,
        /// ECC fail bank for double ECC Error It indicates which bank is concerned by ECC error
        BK_ECC: u1,
        /// ECC fail for double ECC error in system Flash memory It indicates if system Flash memory is concerned by ECC error.
        SYSF_ECC: u1,
        /// OTP ECC error bit This bit is set to 1 when double ECC detection occurred during the last read operation from the read-only/ OTP area. The address of the ECC error is available in ADDR_ECC bit field.
        OTP_ECC: u1,
        reserved31: u6 = 0,
        /// ECC detection set by hardware when two ECC error has been detected. When this bit is set, a NMI is generated. Cleared by writing 1. Needs to be cleared in order to detect subsequent double ECC errors.
        ECCD: u1,
    }),
    /// FLASH ECC data
    /// offset: 0x108
    ECCDR: mmio.Mmio(packed struct(u32) {
        /// ECC error data When an double detection ECC error occurs on special areas with 6-bit ECC on 16-bit of data (data area, read-only/OTP area), the failing data is read to this register. By checking if it is possible to determine whether the failure was on a real data, or due to access to uninitialized memory.
        DATA_ECC: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x10c
    reserved268: [220]u8,
    /// FLASH write sector protection for Bank2
    /// offset: 0x1e8
    WRPSGN2R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank2 sector protection option status byte Setting WRPSG2 bits to 0 write protects the corresponding sectors in bank 2 (0: write protected; 1: not write protected)
        WRPSG: u8,
        padding: u24 = 0,
    }),
    /// FLASH write sector protection for Bank2
    /// offset: 0x1ec
    WRPSGN2R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank2 sector protection option status byte Setting WRPSG2 bits to 0 write protects the corresponding sectors in bank 2 (0: write protected; 1: not write protected)
        WRPSG: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x1f0
    reserved496: [8]u8,
    /// FLASH HDP Bank2 register
    /// offset: 0x1f8
    HDP2R_CUR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 HDPL barrier start set in number of 8 Kbytes sectors
        HDP2_STRT: u3,
        reserved16: u13 = 0,
        /// Bank 2 HDPL barrier end set in number of 8 Kbytes sectors
        HDP2_END: u3,
        padding: u13 = 0,
    }),
    /// FLASH HDP Bank2 register
    /// offset: 0x1fc
    HDP2R_PRG: mmio.Mmio(packed struct(u32) {
        /// Bank 2 HDPL barrier start set in number of 8 Kbytes sectors
        HDP2_STRT: u3,
        reserved16: u13 = 0,
        /// Bank 2 HDPL barrier end set in number of 8 Kbytes sectors
        HDP2_END: u3,
        padding: u13 = 0,
    }),
};
