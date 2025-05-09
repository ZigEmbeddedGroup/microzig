const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BKPSRAM_ECC = enum(u1) {
    /// Backup RAM ECC check enabled
    B_0x0 = 0x0,
    /// Backup RAM ECC check disabled
    B_0x1 = 0x1,
};

pub const BK_ECC = enum(u1) {
    /// Bank 1
    B_0x0 = 0x0,
    /// Bank 2
    B_0x1 = 0x1,
};

pub const BK_OP = enum(u1) {
    /// Bank 1
    B_0x0 = 0x0,
    /// Bank 2
    B_0x1 = 0x1,
};

pub const BOR_LEV = enum(u3) {
    /// BOR level 0 (reset level threshold around 1.7 V)
    B_0x0 = 0x0,
    /// BOR level 1 (reset level threshold around 2.0 V)
    B_0x1 = 0x1,
    /// BOR level 2 (reset level threshold around 2.2 V)
    B_0x2 = 0x2,
    /// BOR level 3 (reset level threshold around 2.5 V)
    B_0x3 = 0x3,
    /// BOR level 4 (reset level threshold around 2.8 V)
    B_0x4 = 0x4,
    _,
};

pub const CODE_OP = enum(u3) {
    /// No Flash operation interrupted by previous reset
    B_0x0 = 0x0,
    /// Single write operation interrupted
    B_0x1 = 0x1,
    /// Burst write operation interrupted
    B_0x2 = 0x2,
    /// Page erase operation interrupted
    B_0x3 = 0x3,
    /// Bank erase operation interrupted
    B_0x4 = 0x4,
    /// Mass erase operation interrupted
    B_0x5 = 0x5,
    /// Option change operation interrupted
    B_0x6 = 0x6,
    _,
};

pub const DUALBANK = enum(u1) {
    /// Single bank Flash with contiguous address in bank 1
    B_0x0 = 0x0,
    /// Dual-bank Flash with contiguous addresses
    B_0x1 = 0x1,
};

pub const ECCIE = enum(u1) {
    /// ECCC interrupt disabled
    B_0x0 = 0x0,
    /// ECCC interrupt enabled.
    B_0x1 = 0x1,
};

pub const HDP_ACCDIS = enum(u1) {
    /// Access to HDP2 area granted
    B_0x0 = 0x0,
    /// Access to HDP2 area denied (SECWM2Ry option bytes modification bocked -refer to )
    B_0x1 = 0x1,
};

pub const IO_VDDIO_HSLV = enum(u1) {
    /// High-speed IO at low VDDIO2 voltage feature disabled (VDDIO2 can exceed 2.5 V)
    B_0x0 = 0x0,
    /// High-speed IO at low VDDIO2 voltage feature enabled (VDDIO2 remains below 2.5 V)
    B_0x1 = 0x1,
};

pub const IO_VDD_HSLV = enum(u1) {
    /// High-speed IO at low VDD voltage feature disabled (VDD can exceed 2.5 V)
    B_0x0 = 0x0,
    /// High-speed IO at low VDD voltage feature enabled (VDD remains below 2.5 V)
    B_0x1 = 0x1,
};

pub const IWDG_STDBY = enum(u1) {
    /// Independent watchdog counter frozen in Standby mode
    B_0x0 = 0x0,
    /// Independent watchdog counter running in Standby mode
    B_0x1 = 0x1,
};

pub const IWDG_STOP = enum(u1) {
    /// Independent watchdog counter frozen in Stop mode
    B_0x0 = 0x0,
    /// Independent watchdog counter running in Stop mode
    B_0x1 = 0x1,
};

pub const IWDG_SW = enum(u1) {
    /// Hardware independent watchdog selected
    B_0x0 = 0x0,
    /// Software independent watchdog selected
    B_0x1 = 0x1,
};

pub const LPM = enum(u1) {
    /// Flash not in low-power read mode
    B_0x0 = 0x0,
    /// Flash in low-power read mode
    B_0x1 = 0x1,
};

pub const NSCR_BKER = enum(u1) {
    /// Bank 1 selected for non-secure page erase
    B_0x0 = 0x0,
    /// Bank 2 selected for non-secure page erase
    B_0x1 = 0x1,
};

pub const NSCR_EOPIE = enum(u1) {
    /// Non-secure EOP Interrupt disabled
    B_0x0 = 0x0,
    /// Non-secure EOP Interrupt enabled
    B_0x1 = 0x1,
};

pub const NSCR_ERRIE = enum(u1) {
    /// Non-secure OPERR error interrupt disabled
    B_0x0 = 0x0,
    /// Non-secure OPERR error interrupt enabled
    B_0x1 = 0x1,
};

pub const NSCR_PER = enum(u1) {
    /// Non-secure page erase disabled
    B_0x0 = 0x0,
    /// Non-secure page erase enabled
    B_0x1 = 0x1,
};

pub const NSCR_PG = enum(u1) {
    /// Non-secure Flash programming disabled
    B_0x0 = 0x0,
    /// Non-secure Flash programming enabled
    B_0x1 = 0x1,
};

pub const NSPRIV = enum(u1) {
    /// Non-secure Flash registers can be read and written by privileged or unprivileged access.
    B_0x0 = 0x0,
    /// Non-secure Flash registers can be read and written by privileged access only.
    B_0x1 = 0x1,
};

pub const OBL_LAUNCH = enum(u1) {
    /// Option byte loading complete
    B_0x0 = 0x0,
    /// Option byte loading requested
    B_0x1 = 0x1,
};

pub const PDREQ = enum(u1) {
    /// No request for bank 2 to enter power-down mode
    B_0x0 = 0x0,
    /// Bank 2 requested to enter power-down mode
    B_0x1 = 0x1,
};

pub const RDP = enum(u8) {
    /// Level 0.5 (readout protection not active, only non-secure debug access is possible). Only available when TrustZone is active (TZEN=1)
    B_0x55 = 0x55,
    /// Level 0 (readout protection not active)
    B_0xAA = 0xaa,
    /// Level 2 (chip readout protection active)
    B_0xCC = 0xcc,
    _,
};

pub const SECCR_BKER = enum(u1) {
    /// Bank 1 selected for secure page erase
    B_0x0 = 0x0,
    /// Bank 2 selected for secure page erase
    B_0x1 = 0x1,
};

pub const SECCR_EOPIE = enum(u1) {
    /// Secure EOP Interrupt disabled
    B_0x0 = 0x0,
    /// Secure EOP Interrupt enabled
    B_0x1 = 0x1,
};

pub const SECCR_ERRIE = enum(u1) {
    /// Secure OPERR error interrupt disabled
    B_0x0 = 0x0,
    /// Secure OPERR error interrupt enabled
    B_0x1 = 0x1,
};

pub const SECCR_PER = enum(u1) {
    /// Secure page erase disabled
    B_0x0 = 0x0,
    /// Secure page erase enabled
    B_0x1 = 0x1,
};

pub const SECCR_PG = enum(u1) {
    /// Secure Flash programming disabled
    B_0x0 = 0x0,
    /// Secure Flash programming enabled
    B_0x1 = 0x1,
};

pub const SLEEP_PD = enum(u1) {
    /// Flash in Idle mode during Sleep mode
    B_0x0 = 0x0,
    /// Flash in power-down mode during Sleep mode
    B_0x1 = 0x1,
};

pub const SPRIV = enum(u1) {
    /// Secure Flash registers can be read and written by privileged or unprivileged access.
    B_0x0 = 0x0,
    /// Secure Flash registers can be read and written by privileged access only.
    B_0x1 = 0x1,
};

pub const SRAM_ECC = enum(u1) {
    /// SRAM3 ECC check enabled
    B_0x0 = 0x0,
    /// SRAM3 ECC check disabled
    B_0x1 = 0x1,
};

pub const SWAP_BANK = enum(u1) {
    /// Bank 1 and bank 2 addresses not swapped
    B_0x0 = 0x0,
    /// Bank 1 and bank 2 addresses swapped
    B_0x1 = 0x1,
};

pub const WRPAR_UNLOCK = enum(u1) {
    /// WRP2A start and end pages locked
    B_0x0 = 0x0,
    /// WRP2A start and end pages unlocked
    B_0x1 = 0x1,
};

pub const WRPBR_UNLOCK = enum(u1) {
    /// WRP2B start and end pages locked
    B_0x0 = 0x0,
    /// WRP2B start and end pages unlocked
    B_0x1 = 0x1,
};

pub const WWDG_SW = enum(u1) {
    /// Hardware window watchdog selected
    B_0x0 = 0x0,
    /// Software window watchdog selected
    B_0x1 = 0x1,
};

pub const nBOOT = enum(u1) {
    /// nBOOT0 = 0
    B_0x0 = 0x0,
    /// nBOOT0 = 1
    B_0x1 = 0x1,
};

pub const nRST_SHDW = enum(u1) {
    /// Reset generated when entering the Shutdown mode
    B_0x0 = 0x0,
    /// No reset generated when entering the Shutdown mode
    B_0x1 = 0x1,
};

pub const nRST_STDBY = enum(u1) {
    /// Reset generated when entering the Standby mode
    B_0x0 = 0x0,
    /// No reset generate when entering the Standby mode
    B_0x1 = 0x1,
};

pub const nRST_STOP = enum(u1) {
    /// Reset generated when entering the Stop mode
    B_0x0 = 0x0,
    /// No reset generated when entering the Stop mode
    B_0x1 = 0x1,
};

pub const nSWBOOT = enum(u1) {
    /// BOOT0 taken from the option bit nBOOT0
    B_0x0 = 0x0,
    /// BOOT0 taken from PH3/BOOT0 pin
    B_0x1 = 0x1,
};

/// Flash
pub const FLASH = extern struct {
    /// FLASH access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency These bits represent the ratio between the HCLK (AHB clock) period and the Flash memory access time. ...
        LATENCY: u4,
        reserved8: u4 = 0,
        /// Prefetch enable This bit enables the prefetch buffer in the embedded Flash memory.
        PRFTEN: u1,
        reserved11: u2 = 0,
        /// Low-power read mode This bit puts the Flash memory in low-power read mode.
        LPM: LPM,
        /// Bank 1 power-down mode request This bit is write-protected with FLASH_PDKEY1R. This bit requests bank 1 to enter power-down mode. When bank 1 enters power-down mode, this bit is cleared by hardware and the PDKEY1R is locked.
        PDREQ1: PDREQ,
        /// Bank 2 power-down mode request This bit is write-protected with FLASH_PDKEY2R. This bit requests bank 2 to enter power-down mode. When bank 2 enters power-down mode, this bit is cleared by hardware and the PDKEY2R is locked.
        PDREQ2: PDREQ,
        /// Flash memory power-down mode during Sleep mode This bit determines whether the Flash memory is in power-down mode or Idle mode when the device is in Sleep mode. The Flash must not be put in power-down while a program or an erase operation is on-going.
        SLEEP_PD: SLEEP_PD,
        padding: u17 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// FLASH non-secure key register
    /// offset: 0x08
    NSKEYR: u32,
    /// FLASH secure key register
    /// offset: 0x0c
    SECKEYR: u32,
    /// FLASH option key register
    /// offset: 0x10
    OPTKEYR: u32,
    /// offset: 0x14
    reserved20: [4]u8,
    /// FLASH bank 1 power-down key register
    /// offset: 0x18
    PDKEY1R: mmio.Mmio(packed struct(u32) {
        /// Bank 1 power-down key
        PDKEY1: u32,
    }),
    /// FLASH bank 2 power-down key register
    /// offset: 0x1c
    PDKEY2R: mmio.Mmio(packed struct(u32) {
        /// Bank 2 power-down key
        PDKEY2: u32,
    }),
    /// FLASH non-secure status register
    /// offset: 0x20
    NSSR: mmio.Mmio(packed struct(u32) {
        /// Non-secure end of operation
        EOP: u1,
        /// Non-secure operation error
        OPERR: u1,
        reserved3: u1 = 0,
        /// Non-secure programming error This bit is set by hardware when a non-secure quad-word address to be programmed contains a value different from all 1 before programming, except if the data to write is all 0. This bit is cleared by writing 1.
        PROGERR: u1,
        /// Non-secure write protection error This bit is set by hardware when an non-secure address to be erased/programmed belongs to a write-protected part (by WRP, HDP or RDP level 1) of the Flash memory. This bit is cleared by writing 1. Refer to for full conditions of error flag setting.
        WRPERR: u1,
        /// Non-secure programming alignment error This bit is set by hardware when the first word to be programmed is not aligned with a quad-word address, or the second, third or forth word does not belong to the same quad-word address. This bit is cleared by writing 1.
        PGAERR: u1,
        /// Non-secure size error This bit is set by hardware when the size of the access is a byte or half-word during a non-secure program sequence. Only quad-word programming is allowed by means of successive word accesses. This bit is cleared by writing 1.
        SIZERR: u1,
        /// Non-secure programming sequence error This bit is set by hardware when programming sequence is not correct. It is cleared by writing 1. Refer to for full conditions of error flag setting.
        PGSERR: u1,
        reserved13: u5 = 0,
        /// Option write error This bit is set by hardware when the options bytes are written with an invalid configuration. It is cleared by writing 1. Refer to for full conditions of error flag setting.
        OPTWERR: u1,
        reserved16: u2 = 0,
        /// Non-secure busy This indicates that a Flash memory secure or non-secure operation is in progress. This bit is set at the beginning of a Flash operation and reset when the operation finishes or when an error occurs.
        BSY: u1,
        /// Non-secure wait data to write This bit indicates that the Flash memory write buffer has been written by a secure or non-secure operation. It is set when the first data is stored in the buffer and cleared when the write is performed in the Flash memory.
        WDW: u1,
        /// OEM1 lock This bit indicates that the OEM1 RDP key read during the OBL is not virgin. When set, the OEM1 RDP lock mechanism is active.
        OEM1LOCK: u1,
        /// OEM2 lock This bit indicates that the OEM2 RDP key read during the OBL is not virgin. When set, the OEM2 RDP lock mechanism is active.
        OEM2LOCK: u1,
        /// Bank 1 in power-down mode This bit indicates that the Flash memory bank 1 is in power-down state. It is reset when bank 1 is in normal mode or being awaken.
        PD1: u1,
        /// Bank 2 in power-down mode This bit indicates that the Flash memory bank 2 is in power-down state. It is reset when bank 2 is in normal mode or being awaken.
        PD2: u1,
        padding: u10 = 0,
    }),
    /// FLASH secure status register
    /// offset: 0x24
    SECSR: mmio.Mmio(packed struct(u32) {
        /// Secure end of operation This bit is set by hardware when one or more Flash memory secure operation (program/erase) has been completed successfully. This bit is set only if the secure end of operation interrupts are enabled (EOPIE = 1 in FLASH_SECCR). This bit is cleared by writing 1.
        EOP: u1,
        /// Secure operation error This bit is set by hardware when a Flash memory secure operation (program/erase) completes unsuccessfully. This bit is set only if secure error interrupts are enabled (SECERRIE = 1). This bit is cleared by writing 1.
        OPERR: u1,
        reserved3: u1 = 0,
        /// Secure programming error This bit is set by hardware when a secure quad-word address to be programmed contains a value different from all 1 before programming, except if the data to write is all 0. This bit is cleared by writing 1.
        PROGERR: u1,
        /// Secure write protection error This bit is set by hardware when an secure address to be erased/programmed belongs to a write-protected part (by WRP, PCROP, HDP or RDP level 1) of the Flash memory.This bit is cleared by writing 1. Refer to for full conditions of error flag setting.
        WRPERR: u1,
        /// Secure programming alignment error This bit is set by hardware when the first word to be programmed is not aligned with a quad-word address, or the second, third or forth word does not belong to the same quad-word address.This bit is cleared by writing 1.
        PGAERR: u1,
        /// Secure size error This bit is set by hardware when the size of the access is a byte or half-word during a secure program sequence. Only quad-word programming is allowed by means of successive word accesses.This bit is cleared by writing 1.
        SIZERR: u1,
        /// Secure programming sequence error This bit is set by hardware when programming sequence is not correct. It is cleared by writing 1. Refer to for full conditions of error flag setting.
        PGSERR: u1,
        reserved16: u8 = 0,
        /// Secure busy This bit indicates that a Flash memory secure or non-secure operation is in progress. This is set on the beginning of a Flash operation and reset when the operation finishes or when an error occurs.
        BSY: u1,
        /// Secure wait data to write This bit indicates that the Flash memory write buffer has been written by a secure or non-secure operation. It is set when the first data is stored in the buffer and cleared when the write is performed in the Flash memory.
        WDW: u1,
        padding: u14 = 0,
    }),
    /// FLASH non-secure control register
    /// offset: 0x28
    NSCR: mmio.Mmio(packed struct(u32) {
        /// Non-secure programming
        PG: NSCR_PG,
        /// Non-secure page erase
        PER: NSCR_PER,
        /// Non-secure bank 1 mass erase This bit triggers the bank 1 non-secure mass erase (all bank 1 user pages) when set.
        MER1: u1,
        /// Non-secure page number selection These bits select the page to erase. ...
        PNB: u7,
        reserved11: u1 = 0,
        /// Non-secure bank selection for page erase
        BKER: NSCR_BKER,
        reserved14: u2 = 0,
        /// Non-secure burst write programming mode When set, this bit selects the burst write programming mode.
        BWR: u1,
        /// Non-secure bank 2 mass erase This bit triggers the bank 2 non-secure mass erase (all bank 2 user pages) when set.
        MER2: u1,
        /// Non-secure start This bit triggers a non-secure erase operation when set. If MER1, MER2 and PER bits are reset and the STRT bit is set, the PGSERR bit in FLASH_NSSR is set (this condition is forbidden). This bit is set only by software and is cleared when the BSY bit is cleared in FLASH_NSSR.
        STRT: u1,
        /// Options modification start This bit triggers an options operation when set. It can not be written if OPTLOCK bit is set. This bit is set only by software, and is cleared when the BSY bit is cleared in FLASH_NSSR.
        OPTSTRT: u1,
        reserved24: u6 = 0,
        /// Non-secure end of operation interrupt enable This bit enables the interrupt generation when the EOP bit in the FLASH_NSSR is set to 1.
        EOPIE: NSCR_EOPIE,
        /// Non-secure error interrupt enable This bit enables the interrupt generation when the OPERR bit in the FLASH_NSSR is set to 1.
        ERRIE: NSCR_ERRIE,
        reserved27: u1 = 0,
        /// Force the option byte loading When set to 1, this bit forces the option byte reloading. This bit is cleared only when the option byte loading is complete. It cannot be written if OPTLOCK is set.
        OBL_LAUNCH: OBL_LAUNCH,
        reserved30: u2 = 0,
        /// Option lock This bit is set only. When set, all bits concerning user options in FLASH_NSCR register are locked. This bit is cleared by hardware after detecting the unlock sequence. The LOCK bit in the FLASH_NSCR must be cleared before doing the unlock sequence for OPTLOCK bit. In case of an unsuccessful unlock operation, this bit remains set until the next reset.
        OPTLOCK: u1,
        /// Non-secure lock This bit is set only. When set, the FLASH_NSCR register is locked. It is cleared by hardware after detecting the unlock sequence in FLASH_NSKEYR register. In case of an unsuccessful unlock operation, this bit remains set until the next system reset.
        LOCK: u1,
    }),
    /// FLASH secure control register
    /// offset: 0x2c
    SECCR: mmio.Mmio(packed struct(u32) {
        /// Secure programming
        PG: SECCR_PG,
        /// Secure page erase
        PER: SECCR_PER,
        /// Secure bank 1 mass erase This bit triggers the bank 1 secure mass erase (all bank 1 user pages) when set.
        MER1: u1,
        /// Secure page number selection These bits select the page to erase: ...
        PNB: u7,
        reserved11: u1 = 0,
        /// Secure bank selection for page erase
        BKER: SECCR_BKER,
        reserved14: u2 = 0,
        /// Secure burst write programming mode When set, this bit selects the burst write programming mode.
        BWR: u1,
        /// Secure bank 2 mass erase This bit triggers the bank 2 secure mass erase (all bank 2 user pages) when set.
        MER2: u1,
        /// Secure start This bit triggers a secure erase operation when set. If MER1, MER2 and PER bits are reset and the STRT bit is set, the PGSERR in the FLASH_SECSR is set (this condition is forbidden). This bit is set only by software and is cleared when the BSY bit is cleared in FLASH_SECSR.
        STRT: u1,
        reserved24: u7 = 0,
        /// Secure End of operation interrupt enable This bit enables the interrupt generation when the EOP bit in the FLASH_SECSR is set to 1.
        EOPIE: SECCR_EOPIE,
        /// Secure error interrupt enable
        ERRIE: SECCR_ERRIE,
        /// Secure PCROP read error interrupt enable
        RDERRIE: u1,
        reserved29: u2 = 0,
        /// Flash memory security state invert This bit inverts the Flash memory security state.
        INV: u1,
        reserved31: u1 = 0,
        /// Secure lock This bit is set only. When set, the FLASH_SECCR register is locked. It is cleared by hardware after detecting the unlock sequence in FLASH_SECKEYR register. In case of an unsuccessful unlock operation, this bit remains set until the next system reset.
        LOCK: u1,
    }),
    /// FLASH ECC register
    /// offset: 0x30
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC fail address
        ADDR_ECC: u20,
        reserved21: u1 = 0,
        /// ECC fail bank
        BK_ECC: BK_ECC,
        /// System Flash memory ECC fail This bit indicates that the ECC error correction or double ECC error detection is located in the system Flash memory.
        SYSF_ECC: u1,
        reserved24: u1 = 0,
        /// ECC correction interrupt enable This bit enables the interrupt generation when the ECCC bit in the FLASH_ECCR register is set.
        ECCIE: ECCIE,
        reserved30: u5 = 0,
        /// ECC correction This bit is set by hardware when one ECC error has been detected and corrected (only if ECCC and ECCD were previously cleared). An interrupt is generated if ECCIE is set. This bit is cleared by writing 1.
        ECCC: u1,
        /// ECC detection This bit is set by hardware when two ECC errors have been detected (only if ECCC and ECCD were previously cleared). When this bit is set, a NMI is generated. This bit is cleared by writing 1.
        ECCD: u1,
    }),
    /// FLASH operation status register
    /// offset: 0x34
    OPSR: mmio.Mmio(packed struct(u32) {
        /// Interrupted operation address This field indicates which address in the Flash memory was accessed when reset occurred. The address is given by bank from address 0x0 0000 to 0xF FFF0.
        ADDR_OP: u20,
        reserved21: u1 = 0,
        /// Interrupted operation bank This bit indicates which Flash memory bank was accessed when reset occurred
        BK_OP: BK_OP,
        /// Operation in system Flash memory interrupted This bit indicates that the reset occurred during an operation in the system Flash memory.
        SYSF_OP: u1,
        reserved29: u6 = 0,
        /// Flash memory operation code This field indicates which Flash memory operation has been interrupted by a system reset:
        CODE_OP: CODE_OP,
    }),
    /// offset: 0x38
    reserved56: [8]u8,
    /// FLASH option register
    /// offset: 0x40
    OPTR: mmio.Mmio(packed struct(u32) {
        /// Readout protection level Others: Level 1 (memories readout protection active) Note: Refer to for more details.
        RDP: RDP,
        /// BOR reset level These bits contain the VDD supply level threshold that activates/releases the reset.
        BOR_LEV: BOR_LEV,
        reserved12: u1 = 0,
        /// Reset generation in Stop mode
        nRST_STOP: nRST_STOP,
        /// Reset generation in Standby mode
        nRST_STDBY: nRST_STDBY,
        /// Reset generation in Shutdown mode
        nRST_SHDW: nRST_SHDW,
        /// SRAM1, SRAM3 and SRAM4 erase upon system reset
        SRAM1345_RST: u1,
        /// Independent watchdog selection
        IWDG_SW: IWDG_SW,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: IWDG_STOP,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: IWDG_STDBY,
        /// Window watchdog selection
        WWDG_SW: WWDG_SW,
        /// Swap banks
        SWAP_BANK: SWAP_BANK,
        /// Dual-bank on 1-Mbyte and 512-Kbyte Flash memory devices
        DUALBANK: DUALBANK,
        /// Backup RAM ECC detection and correction enable
        BKPSRAM_ECC: BKPSRAM_ECC,
        /// SRAM3 ECC detection and correction enable
        SRAM3_ECC: SRAM_ECC,
        /// SRAM2 ECC detection and correction enable
        SRAM2_ECC: SRAM_ECC,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Software BOOT0
        nSWBOOT0: nSWBOOT,
        /// nBOOT0 option bit
        nBOOT0: nBOOT,
        /// PA15 pull-up enable
        PA15_PUPEN: u1,
        /// High-speed IO at low VDD voltage configuration bit This bit can be set only with VDD below 2.5V
        IO_VDD_HSLV: IO_VDD_HSLV,
        /// High-speed IO at low VDDIO2 voltage configuration bit This bit can be set only with VDDIO2 below 2.5 V.
        IO_VDDIO2_HSLV: IO_VDDIO_HSLV,
        /// Global TrustZone security enable
        TZEN: u1,
    }),
    /// FLASH non-secure boot address 0 register
    /// offset: 0x44
    NSBOOTADD0R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Non-secure boot base address 0 The non-secure boot memory address can be programmed to any address in the valid address range with a granularity of 128 bytes. These bits correspond to address [31:7]. The NSBOOTADD0 option bytes are selected following the BOOT0 pin or nSWBOOT0 state. Examples: NSBOOTADD0[24:0] = 0x0100000: Boot from non-secure Flash memory (0x0800 0000) NSBOOTADD0[24:0] = 0x017F200: Boot from system memory bootloader (0x0BF9 0000) NSBOOTADD0[24:0] = 0x0400000: Boot from non-secure SRAM1 on S-Bus (0x2000 0000)
        NSBOOTADD0: u25,
    }),
    /// FLASH non-secure boot address 1 register
    /// offset: 0x48
    NSBOOTADD1R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Non-secure boot address 1 The non-secure boot memory address can be programmed to any address in the valid address range with a granularity of 128 bytes. These bits correspond to address [31:7]. The NSBOOTADD0 option bytes are selected following the BOOT0 pin or nSWBOOT0 state. Examples: NSBOOTADD1[24:0] = 0x0100000: Boot from non-secure Flash memory (0x0800 0000) NSBOOTADD1[24:0] = 0x017F200: Boot from system memory bootloader (0x0BF9 0000) NSBOOTADD1[24:0] = 0x0400000: Boot from non-secure SRAM1 on S-Bus (0x2000 0000)
        NSBOOTADD1: u25,
    }),
    /// FLASH secure boot address 0 register
    /// offset: 0x4c
    SECBOOTADD0R: mmio.Mmio(packed struct(u32) {
        /// Boot lock When set, the boot is always forced to base address value programmed in SECBOOTADD0[24:0] option bytes whatever the boot selection option. When set, this bit can only be cleared by an RDP at level 0.
        BOOT_LOCK: u1,
        reserved7: u6 = 0,
        /// Secure boot base address 0 The secure boot memory address can be programmed to any address in the valid address range with a granularity of 128 bytes. This bits correspond to address [31:7] The SECBOOTADD0 option bytes are selected following the BOOT0 pin or nSWBOOT0 state. Examples: SECBOOTADD0[24:0] = 0x018 0000: Boot from secure Flash memory (0x0C00 0000) SECBOOTADD0[24:0] = 0x01F F000: Boot from RSS (0x0FF8 0000) SECBOOTADD0[24:0] = 0x060 0000: Boot from secure SRAM1 on S-Bus (0x3000 0000)
        SECBOOTADD0: u25,
    }),
    /// FLASH secure watermark1 register 1
    /// offset: 0x50
    SECWM1R1: mmio.Mmio(packed struct(u32) {
        /// Start page of first secure area This field contains the first page of the secure area in bank 1.
        SECWM1_PSTRT: u7,
        reserved16: u9 = 0,
        /// End page of first secure area This field contains the last page of the secure area in bank 1.
        SECWM1_PEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH secure watermark1 register 2
    /// offset: 0x54
    SECWM1R2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End page of first hide protection area This field contains the last page of the HDP area in bank 1.
        HDP1_PEND: u7,
        reserved31: u8 = 0,
        /// Hide protection first area enable
        HDP1EN: u1,
    }),
    /// FLASH WRP1 area A address register
    /// offset: 0x58
    WRP1AR: mmio.Mmio(packed struct(u32) {
        /// bank 1 WPR first area A start page This field contains the first page of the first WPR area for bank 1.
        WRP1A_PSTRT: u7,
        reserved16: u9 = 0,
        /// Bank 1 WPR first area A end page This field contains the last page of the first WPR area in bank 1.
        WRP1A_PEND: u7,
        reserved31: u8 = 0,
        /// Bank 1 WPR first area A unlock
        UNLOCK: WRPAR_UNLOCK,
    }),
    /// FLASH WRP1 area B address register
    /// offset: 0x5c
    WRP1BR: mmio.Mmio(packed struct(u32) {
        /// Bank 1 WRP second area B start page This field contains the first page of the second WRP area for bank 1.
        WRP1B_PSTRT: u7,
        reserved16: u9 = 0,
        /// Bank 1 WRP second area B end page This field contains the last page of the second WRP area in bank 1.
        WRP1B_PEND: u7,
        reserved31: u8 = 0,
        /// Bank 1 WPR second area B unlock
        UNLOCK: WRPBR_UNLOCK,
    }),
    /// FLASH secure watermark2 register 1
    /// offset: 0x60
    SECWM2R1: mmio.Mmio(packed struct(u32) {
        /// Start page of second secure area This field contains the first page of the secure area in bank 2.
        SECWM2_PSTRT: u7,
        reserved16: u9 = 0,
        /// End page of second secure area This field contains the last page of the secure area in bank 2.
        SECWM2_PEND: u7,
        padding: u9 = 0,
    }),
    /// FLASH secure watermark2 register 2
    /// offset: 0x64
    SECWM2R2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End page of hide protection second area HDP2_PEND contains the last page of the HDP area in bank 2.
        HDP2_PEND: u7,
        reserved31: u8 = 0,
        /// Hide protection second area enable
        HDP2EN: u1,
    }),
    /// FLASH WPR2 area A address register
    /// offset: 0x68
    WRP2AR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 WPR first area A start page This field contains the first page of the first WRP area for bank 2.
        WRP2A_PSTRT: u7,
        reserved16: u9 = 0,
        /// Bank 2 WPR first area A end page This field contains the last page of the first WRP area in bank 2.
        WRP2A_PEND: u7,
        reserved31: u8 = 0,
        /// Bank 2 WPR first area A unlock
        UNLOCK: WRPAR_UNLOCK,
    }),
    /// FLASH WPR2 area B address register
    /// offset: 0x6c
    WRP2BR: mmio.Mmio(packed struct(u32) {
        /// Bank 2 WPR second area B start page This field contains the first page of the second WRP area for bank 2.
        WRP2B_PSTRT: u7,
        reserved16: u9 = 0,
        /// Bank 2 WPR second area B end page This field contains the last page of the second WRP area in bank 2.
        WRP2B_PEND: u7,
        reserved31: u8 = 0,
        /// Bank 2 WPR second area B unlock
        UNLOCK: WRPBR_UNLOCK,
    }),
    /// FLASH OEM1 key register 1
    /// offset: 0x70
    OEM1KEYR1: mmio.Mmio(packed struct(u32) {
        /// OEM1 least significant bytes key
        OEM1KEY: u32,
    }),
    /// FLASH OEM1 key register 2
    /// offset: 0x74
    OEM1KEYR2: mmio.Mmio(packed struct(u32) {
        /// OEM1 most significant bytes key
        OEM1KEY: u32,
    }),
    /// FLASH OEM2 key register 1
    /// offset: 0x78
    OEM2KEYR1: mmio.Mmio(packed struct(u32) {
        /// OEM2 least significant bytes key
        OEM2KEY: u32,
    }),
    /// FLASH OEM2 key register 2
    /// offset: 0x7c
    OEM2KEYR2: mmio.Mmio(packed struct(u32) {
        /// OEM2 most significant bytes key
        OEM2KEY: u32,
    }),
    /// FLASH secure block based bank 1 register 1
    /// offset: 0x80
    SEC1BBR1: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC1BB0: u1,
        /// page secure/non-secure attribution
        SEC1BB1: u1,
        /// page secure/non-secure attribution
        SEC1BB2: u1,
        /// page secure/non-secure attribution
        SEC1BB3: u1,
        /// page secure/non-secure attribution
        SEC1BB4: u1,
        /// page secure/non-secure attribution
        SEC1BB5: u1,
        /// page secure/non-secure attribution
        SEC1BB6: u1,
        /// page secure/non-secure attribution
        SEC1BB7: u1,
        /// page secure/non-secure attribution
        SEC1BB8: u1,
        /// page secure/non-secure attribution
        SEC1BB9: u1,
        /// page secure/non-secure attribution
        SEC1BB10: u1,
        /// page secure/non-secure attribution
        SEC1BB11: u1,
        /// page secure/non-secure attribution
        SEC1BB12: u1,
        /// page secure/non-secure attribution
        SEC1BB13: u1,
        /// page secure/non-secure attribution
        SEC1BB14: u1,
        /// page secure/non-secure attribution
        SEC1BB15: u1,
        /// page secure/non-secure attribution
        SEC1BB16: u1,
        /// page secure/non-secure attribution
        SEC1BB17: u1,
        /// page secure/non-secure attribution
        SEC1BB18: u1,
        /// page secure/non-secure attribution
        SEC1BB19: u1,
        /// page secure/non-secure attribution
        SEC1BB20: u1,
        /// page secure/non-secure attribution
        SEC1BB21: u1,
        /// page secure/non-secure attribution
        SEC1BB22: u1,
        /// page secure/non-secure attribution
        SEC1BB23: u1,
        /// page secure/non-secure attribution
        SEC1BB24: u1,
        /// page secure/non-secure attribution
        SEC1BB25: u1,
        /// page secure/non-secure attribution
        SEC1BB26: u1,
        /// page secure/non-secure attribution
        SEC1BB27: u1,
        /// page secure/non-secure attribution
        SEC1BB28: u1,
        /// page secure/non-secure attribution
        SEC1BB29: u1,
        /// page secure/non-secure attribution
        SEC1BB30: u1,
        /// page secure/non-secure attribution
        SEC1BB31: u1,
    }),
    /// FLASH secure block based bank 1 register 2
    /// offset: 0x84
    SEC1BBR2: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC1BB0: u1,
        /// page secure/non-secure attribution
        SEC1BB1: u1,
        /// page secure/non-secure attribution
        SEC1BB2: u1,
        /// page secure/non-secure attribution
        SEC1BB3: u1,
        /// page secure/non-secure attribution
        SEC1BB4: u1,
        /// page secure/non-secure attribution
        SEC1BB5: u1,
        /// page secure/non-secure attribution
        SEC1BB6: u1,
        /// page secure/non-secure attribution
        SEC1BB7: u1,
        /// page secure/non-secure attribution
        SEC1BB8: u1,
        /// page secure/non-secure attribution
        SEC1BB9: u1,
        /// page secure/non-secure attribution
        SEC1BB10: u1,
        /// page secure/non-secure attribution
        SEC1BB11: u1,
        /// page secure/non-secure attribution
        SEC1BB12: u1,
        /// page secure/non-secure attribution
        SEC1BB13: u1,
        /// page secure/non-secure attribution
        SEC1BB14: u1,
        /// page secure/non-secure attribution
        SEC1BB15: u1,
        /// page secure/non-secure attribution
        SEC1BB16: u1,
        /// page secure/non-secure attribution
        SEC1BB17: u1,
        /// page secure/non-secure attribution
        SEC1BB18: u1,
        /// page secure/non-secure attribution
        SEC1BB19: u1,
        /// page secure/non-secure attribution
        SEC1BB20: u1,
        /// page secure/non-secure attribution
        SEC1BB21: u1,
        /// page secure/non-secure attribution
        SEC1BB22: u1,
        /// page secure/non-secure attribution
        SEC1BB23: u1,
        /// page secure/non-secure attribution
        SEC1BB24: u1,
        /// page secure/non-secure attribution
        SEC1BB25: u1,
        /// page secure/non-secure attribution
        SEC1BB26: u1,
        /// page secure/non-secure attribution
        SEC1BB27: u1,
        /// page secure/non-secure attribution
        SEC1BB28: u1,
        /// page secure/non-secure attribution
        SEC1BB29: u1,
        /// page secure/non-secure attribution
        SEC1BB30: u1,
        /// page secure/non-secure attribution
        SEC1BB31: u1,
    }),
    /// FLASH secure block based bank 1 register 3
    /// offset: 0x88
    SEC1BBR3: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC1BB0: u1,
        /// page secure/non-secure attribution
        SEC1BB1: u1,
        /// page secure/non-secure attribution
        SEC1BB2: u1,
        /// page secure/non-secure attribution
        SEC1BB3: u1,
        /// page secure/non-secure attribution
        SEC1BB4: u1,
        /// page secure/non-secure attribution
        SEC1BB5: u1,
        /// page secure/non-secure attribution
        SEC1BB6: u1,
        /// page secure/non-secure attribution
        SEC1BB7: u1,
        /// page secure/non-secure attribution
        SEC1BB8: u1,
        /// page secure/non-secure attribution
        SEC1BB9: u1,
        /// page secure/non-secure attribution
        SEC1BB10: u1,
        /// page secure/non-secure attribution
        SEC1BB11: u1,
        /// page secure/non-secure attribution
        SEC1BB12: u1,
        /// page secure/non-secure attribution
        SEC1BB13: u1,
        /// page secure/non-secure attribution
        SEC1BB14: u1,
        /// page secure/non-secure attribution
        SEC1BB15: u1,
        /// page secure/non-secure attribution
        SEC1BB16: u1,
        /// page secure/non-secure attribution
        SEC1BB17: u1,
        /// page secure/non-secure attribution
        SEC1BB18: u1,
        /// page secure/non-secure attribution
        SEC1BB19: u1,
        /// page secure/non-secure attribution
        SEC1BB20: u1,
        /// page secure/non-secure attribution
        SEC1BB21: u1,
        /// page secure/non-secure attribution
        SEC1BB22: u1,
        /// page secure/non-secure attribution
        SEC1BB23: u1,
        /// page secure/non-secure attribution
        SEC1BB24: u1,
        /// page secure/non-secure attribution
        SEC1BB25: u1,
        /// page secure/non-secure attribution
        SEC1BB26: u1,
        /// page secure/non-secure attribution
        SEC1BB27: u1,
        /// page secure/non-secure attribution
        SEC1BB28: u1,
        /// page secure/non-secure attribution
        SEC1BB29: u1,
        /// page secure/non-secure attribution
        SEC1BB30: u1,
        /// page secure/non-secure attribution
        SEC1BB31: u1,
    }),
    /// FLASH secure block based bank 1 register 4
    /// offset: 0x8c
    SEC1BBR4: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC1BB0: u1,
        /// page secure/non-secure attribution
        SEC1BB1: u1,
        /// page secure/non-secure attribution
        SEC1BB2: u1,
        /// page secure/non-secure attribution
        SEC1BB3: u1,
        /// page secure/non-secure attribution
        SEC1BB4: u1,
        /// page secure/non-secure attribution
        SEC1BB5: u1,
        /// page secure/non-secure attribution
        SEC1BB6: u1,
        /// page secure/non-secure attribution
        SEC1BB7: u1,
        /// page secure/non-secure attribution
        SEC1BB8: u1,
        /// page secure/non-secure attribution
        SEC1BB9: u1,
        /// page secure/non-secure attribution
        SEC1BB10: u1,
        /// page secure/non-secure attribution
        SEC1BB11: u1,
        /// page secure/non-secure attribution
        SEC1BB12: u1,
        /// page secure/non-secure attribution
        SEC1BB13: u1,
        /// page secure/non-secure attribution
        SEC1BB14: u1,
        /// page secure/non-secure attribution
        SEC1BB15: u1,
        /// page secure/non-secure attribution
        SEC1BB16: u1,
        /// page secure/non-secure attribution
        SEC1BB17: u1,
        /// page secure/non-secure attribution
        SEC1BB18: u1,
        /// page secure/non-secure attribution
        SEC1BB19: u1,
        /// page secure/non-secure attribution
        SEC1BB20: u1,
        /// page secure/non-secure attribution
        SEC1BB21: u1,
        /// page secure/non-secure attribution
        SEC1BB22: u1,
        /// page secure/non-secure attribution
        SEC1BB23: u1,
        /// page secure/non-secure attribution
        SEC1BB24: u1,
        /// page secure/non-secure attribution
        SEC1BB25: u1,
        /// page secure/non-secure attribution
        SEC1BB26: u1,
        /// page secure/non-secure attribution
        SEC1BB27: u1,
        /// page secure/non-secure attribution
        SEC1BB28: u1,
        /// page secure/non-secure attribution
        SEC1BB29: u1,
        /// page secure/non-secure attribution
        SEC1BB30: u1,
        /// page secure/non-secure attribution
        SEC1BB31: u1,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// FLASH secure block based bank 2 register 1
    /// offset: 0xa0
    SEC2BBR1: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC2BB0: u1,
        /// page secure/non-secure attribution
        SEC2BB1: u1,
        /// page secure/non-secure attribution
        SEC2BB2: u1,
        /// page secure/non-secure attribution
        SEC2BB3: u1,
        /// page secure/non-secure attribution
        SEC2BB4: u1,
        /// page secure/non-secure attribution
        SEC2BB5: u1,
        /// page secure/non-secure attribution
        SEC2BB6: u1,
        /// page secure/non-secure attribution
        SEC2BB7: u1,
        /// page secure/non-secure attribution
        SEC2BB8: u1,
        /// page secure/non-secure attribution
        SEC2BB9: u1,
        /// page secure/non-secure attribution
        SEC2BB10: u1,
        /// page secure/non-secure attribution
        SEC2BB11: u1,
        /// page secure/non-secure attribution
        SEC2BB12: u1,
        /// page secure/non-secure attribution
        SEC2BB13: u1,
        /// page secure/non-secure attribution
        SEC2BB14: u1,
        /// page secure/non-secure attribution
        SEC2BB15: u1,
        /// page secure/non-secure attribution
        SEC2BB16: u1,
        /// page secure/non-secure attribution
        SEC2BB17: u1,
        /// page secure/non-secure attribution
        SEC2BB18: u1,
        /// page secure/non-secure attribution
        SEC2BB19: u1,
        /// page secure/non-secure attribution
        SEC2BB20: u1,
        /// page secure/non-secure attribution
        SEC2BB21: u1,
        /// page secure/non-secure attribution
        SEC2BB22: u1,
        /// page secure/non-secure attribution
        SEC2BB23: u1,
        /// page secure/non-secure attribution
        SEC2BB24: u1,
        /// page secure/non-secure attribution
        SEC2BB25: u1,
        /// page secure/non-secure attribution
        SEC2BB26: u1,
        /// page secure/non-secure attribution
        SEC2BB27: u1,
        /// page secure/non-secure attribution
        SEC2BB28: u1,
        /// page secure/non-secure attribution
        SEC2BB29: u1,
        /// page secure/non-secure attribution
        SEC2BB30: u1,
        /// page secure/non-secure attribution
        SEC2BB31: u1,
    }),
    /// FLASH secure block based bank 2 register 2
    /// offset: 0xa4
    SEC2BBR2: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC2BB0: u1,
        /// page secure/non-secure attribution
        SEC2BB1: u1,
        /// page secure/non-secure attribution
        SEC2BB2: u1,
        /// page secure/non-secure attribution
        SEC2BB3: u1,
        /// page secure/non-secure attribution
        SEC2BB4: u1,
        /// page secure/non-secure attribution
        SEC2BB5: u1,
        /// page secure/non-secure attribution
        SEC2BB6: u1,
        /// page secure/non-secure attribution
        SEC2BB7: u1,
        /// page secure/non-secure attribution
        SEC2BB8: u1,
        /// page secure/non-secure attribution
        SEC2BB9: u1,
        /// page secure/non-secure attribution
        SEC2BB10: u1,
        /// page secure/non-secure attribution
        SEC2BB11: u1,
        /// page secure/non-secure attribution
        SEC2BB12: u1,
        /// page secure/non-secure attribution
        SEC2BB13: u1,
        /// page secure/non-secure attribution
        SEC2BB14: u1,
        /// page secure/non-secure attribution
        SEC2BB15: u1,
        /// page secure/non-secure attribution
        SEC2BB16: u1,
        /// page secure/non-secure attribution
        SEC2BB17: u1,
        /// page secure/non-secure attribution
        SEC2BB18: u1,
        /// page secure/non-secure attribution
        SEC2BB19: u1,
        /// page secure/non-secure attribution
        SEC2BB20: u1,
        /// page secure/non-secure attribution
        SEC2BB21: u1,
        /// page secure/non-secure attribution
        SEC2BB22: u1,
        /// page secure/non-secure attribution
        SEC2BB23: u1,
        /// page secure/non-secure attribution
        SEC2BB24: u1,
        /// page secure/non-secure attribution
        SEC2BB25: u1,
        /// page secure/non-secure attribution
        SEC2BB26: u1,
        /// page secure/non-secure attribution
        SEC2BB27: u1,
        /// page secure/non-secure attribution
        SEC2BB28: u1,
        /// page secure/non-secure attribution
        SEC2BB29: u1,
        /// page secure/non-secure attribution
        SEC2BB30: u1,
        /// page secure/non-secure attribution
        SEC2BB31: u1,
    }),
    /// FLASH secure block based bank 2 register 3
    /// offset: 0xa8
    SEC2BBR3: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC2BB0: u1,
        /// page secure/non-secure attribution
        SEC2BB1: u1,
        /// page secure/non-secure attribution
        SEC2BB2: u1,
        /// page secure/non-secure attribution
        SEC2BB3: u1,
        /// page secure/non-secure attribution
        SEC2BB4: u1,
        /// page secure/non-secure attribution
        SEC2BB5: u1,
        /// page secure/non-secure attribution
        SEC2BB6: u1,
        /// page secure/non-secure attribution
        SEC2BB7: u1,
        /// page secure/non-secure attribution
        SEC2BB8: u1,
        /// page secure/non-secure attribution
        SEC2BB9: u1,
        /// page secure/non-secure attribution
        SEC2BB10: u1,
        /// page secure/non-secure attribution
        SEC2BB11: u1,
        /// page secure/non-secure attribution
        SEC2BB12: u1,
        /// page secure/non-secure attribution
        SEC2BB13: u1,
        /// page secure/non-secure attribution
        SEC2BB14: u1,
        /// page secure/non-secure attribution
        SEC2BB15: u1,
        /// page secure/non-secure attribution
        SEC2BB16: u1,
        /// page secure/non-secure attribution
        SEC2BB17: u1,
        /// page secure/non-secure attribution
        SEC2BB18: u1,
        /// page secure/non-secure attribution
        SEC2BB19: u1,
        /// page secure/non-secure attribution
        SEC2BB20: u1,
        /// page secure/non-secure attribution
        SEC2BB21: u1,
        /// page secure/non-secure attribution
        SEC2BB22: u1,
        /// page secure/non-secure attribution
        SEC2BB23: u1,
        /// page secure/non-secure attribution
        SEC2BB24: u1,
        /// page secure/non-secure attribution
        SEC2BB25: u1,
        /// page secure/non-secure attribution
        SEC2BB26: u1,
        /// page secure/non-secure attribution
        SEC2BB27: u1,
        /// page secure/non-secure attribution
        SEC2BB28: u1,
        /// page secure/non-secure attribution
        SEC2BB29: u1,
        /// page secure/non-secure attribution
        SEC2BB30: u1,
        /// page secure/non-secure attribution
        SEC2BB31: u1,
    }),
    /// FLASH secure block based bank 2 register 4
    /// offset: 0xac
    SEC2BBR4: mmio.Mmio(packed struct(u32) {
        /// page secure/non-secure attribution
        SEC2BB0: u1,
        /// page secure/non-secure attribution
        SEC2BB1: u1,
        /// page secure/non-secure attribution
        SEC2BB2: u1,
        /// page secure/non-secure attribution
        SEC2BB3: u1,
        /// page secure/non-secure attribution
        SEC2BB4: u1,
        /// page secure/non-secure attribution
        SEC2BB5: u1,
        /// page secure/non-secure attribution
        SEC2BB6: u1,
        /// page secure/non-secure attribution
        SEC2BB7: u1,
        /// page secure/non-secure attribution
        SEC2BB8: u1,
        /// page secure/non-secure attribution
        SEC2BB9: u1,
        /// page secure/non-secure attribution
        SEC2BB10: u1,
        /// page secure/non-secure attribution
        SEC2BB11: u1,
        /// page secure/non-secure attribution
        SEC2BB12: u1,
        /// page secure/non-secure attribution
        SEC2BB13: u1,
        /// page secure/non-secure attribution
        SEC2BB14: u1,
        /// page secure/non-secure attribution
        SEC2BB15: u1,
        /// page secure/non-secure attribution
        SEC2BB16: u1,
        /// page secure/non-secure attribution
        SEC2BB17: u1,
        /// page secure/non-secure attribution
        SEC2BB18: u1,
        /// page secure/non-secure attribution
        SEC2BB19: u1,
        /// page secure/non-secure attribution
        SEC2BB20: u1,
        /// page secure/non-secure attribution
        SEC2BB21: u1,
        /// page secure/non-secure attribution
        SEC2BB22: u1,
        /// page secure/non-secure attribution
        SEC2BB23: u1,
        /// page secure/non-secure attribution
        SEC2BB24: u1,
        /// page secure/non-secure attribution
        SEC2BB25: u1,
        /// page secure/non-secure attribution
        SEC2BB26: u1,
        /// page secure/non-secure attribution
        SEC2BB27: u1,
        /// page secure/non-secure attribution
        SEC2BB28: u1,
        /// page secure/non-secure attribution
        SEC2BB29: u1,
        /// page secure/non-secure attribution
        SEC2BB30: u1,
        /// page secure/non-secure attribution
        SEC2BB31: u1,
    }),
    /// offset: 0xb0
    reserved176: [16]u8,
    /// FLASH secure HDP control register
    /// offset: 0xc0
    SECHDPCR: mmio.Mmio(packed struct(u32) {
        /// HDP1 area access disable When set, this bit is only cleared by a system reset.
        HDP1_ACCDIS: HDP_ACCDIS,
        /// HDP2 area access disable When set, this bit is only cleared by a system reset.
        HDP2_ACCDIS: HDP_ACCDIS,
        padding: u30 = 0,
    }),
    /// FLASH privilege configuration register
    /// offset: 0xc4
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// Privileged protection for secure registers This bit can be accessed only when TrustZone is enabled (TZEN = 1). This bit can be read by both privileged or unprivileged, secure and non-secure access. The SPRIV bit can be written only by a secure privileged access. A non-secure write access on SPRIV bit is ignored. A secure unprivileged write access on SPRIV bit is ignored.
        SPRIV: SPRIV,
        /// Privileged protection for non-secure registers This bit can be read by both privileged or unprivileged, secure and non-secure access. The NSPRIV bit can be written by a secure or non-secure privileged access. A secure or non-secure unprivileged write access on NSPRIV bit is ignored.
        NSPRIV: NSPRIV,
        padding: u30 = 0,
    }),
    /// offset: 0xc8
    reserved200: [8]u8,
    /// FLASH privilege block based bank 1 register 1
    /// offset: 0xd0
    PRIV1BBR1: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV1BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB31: u1,
    }),
    /// FLASH privilege block based bank 1 register 2
    /// offset: 0xd4
    PRIV1BBR2: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV1BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB31: u1,
    }),
    /// FLASH privilege block based bank 1 register 3
    /// offset: 0xd8
    PRIV1BBR3: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV1BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB31: u1,
    }),
    /// FLASH privilege block based bank 1 register 4
    /// offset: 0xdc
    PRIV1BBR4: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV1BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV1BB31: u1,
    }),
    /// offset: 0xe0
    reserved224: [16]u8,
    /// FLASH privilege block based bank 2 register 1
    /// offset: 0xf0
    PRIV2BBR1: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV2BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB31: u1,
    }),
    /// FLASH privilege block based bank 2 register 2
    /// offset: 0xf4
    PRIV2BBR2: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV2BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB31: u1,
    }),
    /// FLASH privilege block based bank 2 register 3
    /// offset: 0xf8
    PRIV2BBR3: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV2BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB31: u1,
    }),
    /// FLASH privilege block based bank 2 register 4
    /// offset: 0xfc
    PRIV2BBR4: mmio.Mmio(packed struct(u32) {
        /// page privileged/unprivileged attribution
        PRIV2BB0: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB1: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB2: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB3: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB4: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB5: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB6: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB7: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB8: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB9: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB10: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB11: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB12: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB13: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB14: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB15: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB16: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB17: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB18: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB19: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB20: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB21: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB22: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB23: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB24: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB25: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB26: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB27: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB28: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB29: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB30: u1,
        /// page privileged/unprivileged attribution
        PRIV2BB31: u1,
    }),
};
