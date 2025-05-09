const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BOR_LEV = enum(u3) {
    /// BOR level 0 (reset level threshold around 1.7�V)
    Level0 = 0x0,
    /// BOR level 1 (reset level threshold around 2.0�V)
    Level1 = 0x1,
    /// BOR level 2 (reset level threshold around 2.2�V)
    Level2 = 0x2,
    /// BOR level 3 (reset level threshold around 2.5�V)
    Level3 = 0x3,
    /// BOR level 4 (reset level threshold around 2.8�V)
    Level4 = 0x4,
    _,
};

pub const CODE_OP = enum(u3) {
    /// No operation interrupted by previous reset
    B_0x0 = 0x0,
    /// Single write operation interrupted
    B_0x1 = 0x1,
    /// Burst write operation interrupted
    B_0x2 = 0x2,
    /// Page erase operation interrupted
    B_0x3 = 0x3,
    /// Reserved
    B_0x4 = 0x4,
    /// Mass erase operation interrupted
    B_0x5 = 0x5,
    /// Option change operation interrupted
    B_0x6 = 0x6,
    /// Reserved
    B_0x7 = 0x7,
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

/// Embedded memory
pub const FLASH = extern struct {
    /// access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency These bits represent the ratio between the AHB hclk1 clock period and the memory access time. Access to the bit can be secured by RCC SYSCLKSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. ... Note: Before entering Stop 1 mode software must set wait state latency to at least 1.
        LATENCY: u4,
        reserved8: u4 = 0,
        /// Prefetch enable This bit enables the prefetch buffer in the embedded memory. This bit can be protected against unprivileged access by NSPRIV.
        PRFTEN: u1,
        reserved11: u2 = 0,
        /// Low-power read mode This bit puts the memory in low-power read mode. Access to the bit can be secured by PWR LPMSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. This bit can’t be written when a program or erase operation is busy (BSY = 1) or when the write buffer is not empty (WDW = 1). Changing this bit while a program or erase operation is busy (BSY = 1) is rejected.
        LPM: u1,
        /// power-down mode request This bit requests to enter power-down mode. When enters power-down mode, this bit is cleared by hardware and the PDKEYR is locked. This bit is write-protected with PDKEYR. Access to the bit can be secured by PWR LPMSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        PDREQ: u1,
        reserved14: u1 = 0,
        /// memory power-down mode during Sleep mode This bit determines whether the memory is in power-down mode or Idle mode when the device is in Sleep mode. Access to the bit can be secured by PWR LPMSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. The must not be put in power-down while a program or an erase operation is ongoing.
        SLEEP_PD: u1,
        padding: u17 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// key register
    /// offset: 0x08
    NSKEYR: u32,
    /// secure key register
    /// offset: 0x0c
    SECKEYR: u32,
    /// option key register
    /// offset: 0x10
    OPTKEYR: u32,
    /// offset: 0x14
    reserved20: [4]u8,
    /// power-down key register
    /// offset: 0x18
    PDKEYR: u32,
    /// offset: 0x1c
    reserved28: [4]u8,
    /// status register
    /// offset: 0x20
    NSSR: mmio.Mmio(packed struct(u32) {
        /// Non-secure end of operation This bit is set by hardware when one or more memory non-secure operation (program/erase) has been completed successfully. This bit is set only if the non-secure end of operation interrupts are enabled (EOPIE = 1 in NSCR1). This bit is cleared by writing�1.
        EOP: u1,
        /// Non-secure operation error This bit is set by hardware when a memory non-secure operation (program/erase) completes unsuccessfully. This bit is set only if non-secure error interrupts are enabled (NSERRIE = 1). This bit is cleared by writing 1.
        OPERR: u1,
        reserved3: u1 = 0,
        /// Non-secure programming error This bit is set by hardware when a non-secure quad-word address to be programmed contains a value different from all 1 before programming, except if the data to write is all 0. This bit is cleared by writing 1.
        PROGERR: u1,
        /// Non-secure write protection error This bit is set by hardware when a non-secure address to be erased/programmed belongs to a write-protected part (by WRP or HDP) of the memory. This bit is cleared by writing 1. Refer to Section�7.3.10: memory errors flags for full conditions of error flag setting.
        WRPERR: u1,
        /// Non-secure programming alignment error This bit is set by hardware when the first word to be programmed is not aligned with a quad-word address, or the second, third or forth word does not belong to the same quad-word address. This bit is cleared by writing 1.
        PGAERR: u1,
        /// Non-secure size error This bit is set by hardware when the size of the access is a byte or half-word during a non-secure program sequence. Only quad-word programming is allowed by means of successive word accesses. This bit is cleared by writing 1.
        SIZERR: u1,
        /// Non-secure programming sequence error This bit is set by hardware when programming sequence is not correct. It is cleared by writing 1. Refer to Section�7.3.10: memory errors flags for full conditions of error flag setting.
        PGSERR: u1,
        reserved13: u5 = 0,
        /// Option write error This bit is set by hardware when the options bytes are written with an invalid configuration or when modifying options in RDP level 2.. It is cleared by writing 1. Refer to Section�7.3.10: memory errors flags for full conditions of error flag setting.
        OPTWERR: u1,
        reserved16: u2 = 0,
        /// Non-secure busy This indicates that a memory secure or non-secure operation is in progress. This bit is set at the beginning of a operation and reset when the operation finishes or when an error occurs.
        BSY: u1,
        /// Non-secure wait data to write This bit indicates that the memory write buffer has been written by a secure or non-secure operation. It is set when the first data is stored in the buffer and cleared when the write is performed in the memory.
        WDW: u1,
        /// OEM1 key RDP lock This bit indicates that the OEM1 key read during the OBL is not virgin. When set, the OEM1 key RDP lock mechanism is active.
        OEM1LOCK: u1,
        /// OEM2 key RDP lock This bit indicates that the OEM2 key read during the OBL is not virgin. When set, the OEM2 key RDP lock mechanism is active.
        OEM2LOCK: u1,
        /// in power-down mode This bit indicates that the memory is in power-down state. It is reset when is in normal mode or being awaken.
        PD: u1,
        padding: u11 = 0,
    }),
    /// secure status register
    /// offset: 0x24
    SECSR: mmio.Mmio(packed struct(u32) {
        /// Secure end of operation This bit is set by hardware when one or more memory secure operation (program/erase) has been completed successfully. This bit is set only if the secure end of operation interrupts are enabled (EOPIE = 1 in SECCR1). This bit is cleared by writing�1.
        EOP: u1,
        /// Secure operation error This bit is set by hardware when a memory secure operation (program/erase) completes unsuccessfully. This bit is set only if secure error interrupts are enabled (SECERRIE = 1). This bit is cleared by writing 1.
        OPERR: u1,
        reserved3: u1 = 0,
        /// Secure programming error This bit is set by hardware when a secure quad-word address to be programmed contains a value different from all 1 before programming, except if the data to write is all 0. This bit is cleared by writing 1.
        PROGERR: u1,
        /// Secure write protection error This bit is set by hardware when an secure address to be erased/programmed belongs to a write-protected part (by WRP or HDP) of the memory. This bit is cleared by writing 1. Refer to Section�7.3.10: memory errors flags for full conditions of error flag setting.
        WRPERR: u1,
        /// Secure programming alignment error This bit is set by hardware when the first word to be programmed is not aligned with a quad-word address, or the second, third or forth word does not belong to the same quad-word address.This bit is cleared by writing 1.
        PGAERR: u1,
        /// Secure size error This bit is set by hardware when the size of the access is a byte or half-word during a secure program sequence. Only quad-word programming is allowed by means of successive word accesses.This bit is cleared by writing 1.
        SIZERR: u1,
        /// Secure programming sequence error This bit is set by hardware when programming sequence is not correct. It is cleared by writing 1. Refer to Section�7.3.10: memory errors flags for full conditions of error flag setting.
        PGSERR: u1,
        reserved16: u8 = 0,
        /// Secure busy This bit indicates that a memory secure or non-secure operation is in progress. This is set on the beginning of a operation and reset when the operation finishes or when an error occurs.
        BSY: u1,
        /// Secure wait data to write This bit indicates that the memory write buffer has been written by a secure or non-secure operation. It is set when the first data is stored in the buffer and cleared when the write is performed in the memory.
        WDW: u1,
        padding: u14 = 0,
    }),
    /// control register
    /// offset: 0x28
    NSCR1: mmio.Mmio(packed struct(u32) {
        /// Non-secure programming
        PG: u1,
        /// Non-secure page erase
        PER: u1,
        /// Non-secure mass erase This bit triggers the non-secure mass erase (all user pages) when set.
        MER: u1,
        /// Non-secure page number selection These bits select the page to erase. ... Note that bit 9 is reserved on STM32WBA5xEx devices.
        PNB: u7,
        reserved14: u4 = 0,
        /// Non-secure burst write programming mode When set, this bit selects the burst write programming mode.
        BWR: u1,
        reserved16: u1 = 0,
        /// Non-secure operation start This bit triggers a non-secure erase operation when set. If MER and PER bits are reset and the STRT bit is set, the PGSERR bit in NSSR is set (this condition is forbidden). This bit is set only by software and is cleared when the BSY bit is cleared in NSSR.
        STRT: u1,
        /// Options modification start This bit triggers an option bytes erase and program operation when set. This bit is write-protected with OPTLOCK.. This bit is set only by software, and is cleared when the BSY bit is cleared in NSSR.
        OPTSTRT: u1,
        reserved24: u6 = 0,
        /// Non-secure end of operation interrupt enable This bit enables the interrupt generation when the EOP bit in the NSSR is set to 1.
        EOPIE: u1,
        /// Non-secure error interrupt enable This bit enables the interrupt generation when the OPERR bit in the NSSR is set to 1.
        ERRIE: u1,
        reserved27: u1 = 0,
        /// Force the option byte loading When set to 1, this bit forces the option byte reloading. This bit is cleared only when the option byte loading is complete. This bit is write-protected with OPTLOCK. Note: The LSE oscillator must be disabled, LSEON = 0 and LSERDY = 0, before starting OBL_LAUNCH.
        OBL_LAUNCH: u1,
        reserved30: u2 = 0,
        /// Option lock This bit is set only. When set, the NSCR1.OPTSRT and OBL_LAUNCH bits concerning user options write access is locked. This bit is cleared by hardware after detecting the unlock sequence in OPTKEYR. The NSCR1.LOCK bit must be cleared before doing the OPTKEYR unlock sequence. In case of an unsuccessful unlock operation, this bit remains set until the next reset.
        OPTLOCK: u1,
        /// Non-secure lock This bit is set only. When set, the NSCR1 register write access is locked. This bit is cleared by hardware after detecting the unlock sequence in NSKEYR. In case of an unsuccessful unlock operation, this bit remains set until the next system reset.
        LOCK: u1,
    }),
    /// secure control register
    /// offset: 0x2c
    SECCR1: mmio.Mmio(packed struct(u32) {
        /// Secure programming
        PG: u1,
        /// Secure page erase
        PER: u1,
        /// Secure mass erase This bit triggers the secure mass erase (all user pages) when set.
        MER: u1,
        /// Secure page number selection These bits select the page to erase: ... Note that bit 9 is reserved on STM32WBA5xEx devices.
        PNB: u7,
        reserved14: u4 = 0,
        /// Secure burst write programming mode When set, this bit selects the burst write programming mode.
        BWR: u1,
        reserved16: u1 = 0,
        /// Secure start This bit triggers a secure erase operation when set. If MER and PER bits are reset and the STRT bit is set, the PGSERR in the SECSR is set (this condition is forbidden). This bit is set only by software and is cleared when the BSY bit is cleared in SECSR.
        STRT: u1,
        reserved24: u7 = 0,
        /// Secure End of operation interrupt enable This bit enables the interrupt generation when the EOP bit in SECSR is set to 1.
        EOPIE: u1,
        /// Secure error interrupt enable This bit enables the interrupt generation when the OPERR bit in SECSR is set to 1.
        ERRIE: u1,
        reserved29: u3 = 0,
        /// memory security state invert This bit inverts the memory security state.
        INV: u1,
        reserved31: u1 = 0,
        /// Secure lock This bit is set only. When set, the SECCR1 register is locked. It is cleared by hardware after detecting the unlock sequence in SECKEYR register. In case of an unsuccessful unlock operation, this bit remains set until the next system reset.
        LOCK: u1,
    }),
    /// ECC register
    /// offset: 0x30
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC fail address This field indicates which address is concerned by the ECC error correction or by the double ECC error detection. The address is given relative to base address, from offset 0x0�0000 to 0xF�FFF0. Note that bit 19 is reserved on STM32WBAxEx devices.
        ADDR_ECC: u20,
        reserved22: u2 = 0,
        /// System memory ECC fail This bit indicates that the ECC error correction or double ECC error detection is located in the system memory.
        SYSF_ECC: u1,
        reserved24: u1 = 0,
        /// ECC correction interrupt enable This bit enables the interrupt generation when the ECCC bit in the ECCR register is set.
        ECCIE: u1,
        reserved30: u5 = 0,
        /// ECC correction This bit is set by hardware when one ECC error has been detected and corrected (only if ECCC and ECCD were previously cleared). An interrupt is generated if ECCIE is set. This bit is cleared by writing 1.
        ECCC: u1,
        /// ECC detection This bit is set by hardware when two ECC errors have been detected (only if ECCC and ECCD were previously cleared). When this bit is set, a NMI is generated. This bit is cleared by writing 1.
        ECCD: u1,
    }),
    /// operation status register
    /// offset: 0x34
    OPSR: mmio.Mmio(packed struct(u32) {
        /// Interrupted operation address This field indicates which address in the memory was accessed when reset occurred. The address is given relative to the base address, from offset 0x0�0000 to 0xF�FFF0. Note that bit 19 is reserved on STM32WBAxEx devices.
        ADDR_OP: u20,
        reserved22: u2 = 0,
        /// Operation in system memory interrupted This bit indicates that the reset occurred during an operation in the system memory.
        SYSF_OP: u1,
        reserved29: u6 = 0,
        /// memory operation code This field indicates which memory operation has been interrupted by a system reset:
        CODE_OP: CODE_OP,
    }),
    /// control 2 register
    /// offset: 0x38
    NSCR2: mmio.Mmio(packed struct(u32) {
        /// Program suspend request
        PS: u1,
        /// Erase suspend request
        ES: u1,
        padding: u30 = 0,
    }),
    /// secure control 2 register
    /// offset: 0x3c
    SECCR2: mmio.Mmio(packed struct(u32) {
        /// Program suspend request
        PS: u1,
        /// Erase suspend request
        ES: u1,
        padding: u30 = 0,
    }),
    /// option register
    /// offset: 0x40
    OPTR: mmio.Mmio(packed struct(u32) {
        /// Readout protection level Others: Level 1 (memories readout protection active) Note: Refer to Section�7.6.2: Readout protection (RDP) for more details.
        RDP: RDP,
        /// BOR reset level These bits contain the V<sub>DD</sub> supply level threshold that activates/releases the reset.
        BOR_LEV: BOR_LEV,
        reserved12: u1 = 0,
        /// Reset generation in Stop mode
        NRST_STOP: u1,
        /// Reset generation in Standby mode
        NRST_STDBY: u1,
        reserved15: u1 = 0,
        /// SRAM1 erase upon system reset
        SRAM1_RST: u1,
        /// Independent watchdog enable selection
        IWDG_SW: u1,
        /// Independent watchdog counter freeze in Stop mode
        IWDG_STOP: u1,
        /// Independent watchdog counter freeze in Standby mode
        IWDG_STDBY: u1,
        /// Window watchdog selection
        WWDG_SW: u1,
        reserved24: u4 = 0,
        /// SRAM2 parity check enable
        SRAM2_PE: u1,
        /// SRAM2 erase when system reset
        SRAM2_RST: u1,
        /// Software BOOT0
        NSWBOOT0: u1,
        /// NBOOT0 option bit
        NBOOT0: u1,
        reserved31: u3 = 0,
        /// Global TrustZone security enable
        TZEN: u1,
    }),
    /// boot address 0 register
    /// offset: 0x44
    NSBOOTADD0R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Non-secure boot base address 0 This address is only used when TZEN = 0. The non-secure boot memory address can be programmed to any address in the valid address range (see Table 28: Boot space versus RDP protection) with a granularity of 128 bytes. These bits correspond to address [31:7]. The NSBOOTADD0 option bytes are selected following the BOOT0 pin or NSWBOOT0 state. Examples: NSBOOTADD0[24:0] = 0x0100000: Boot from memory (0x0800 0000) NSBOOTADD0[24:0] = 0x017F100: Boot from system memory bootloader (0x0BF8 8000) NSBOOTADD0[24:0] = 0x0400200: Boot from SRAM2 on S-Bus (0x2001 0000)
        NSBOOTADD0: u25,
    }),
    /// boot address 1 register
    /// offset: 0x48
    NSBOOTADD1R: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Non-secure boot address 1 This address is only used when TZEN = 0. The non-secure boot memory address can be programmed to any address in the valid address range (see Table 28: Boot space versus RDP protection) with a granularity of 128 bytes. These bits correspond to address [31:7]. The NSBOOTADD0 option bytes are selected following the BOOT0 pin or NSWBOOT0 state. Examples: NSBOOTADD1[24:0] = 0x0100000: Boot from memory (0x0800 0000) NSBOOTADD1[24:0] = 0x017F100: Boot from system memory bootloader (0x0BF8 8000) NSBOOTADD1[24:0] = 0x0400200: Boot from SRAM2 (0x2001 0000)
        NSBOOTADD1: u25,
    }),
    /// secure boot address 0 register
    /// offset: 0x4c
    SECBOOTADD0R: mmio.Mmio(packed struct(u32) {
        /// Boot lock This lock is only used when TZEN = 0. When set, the boot is always forced to base address value programmed in SECBOOTADD0[24:0] option bytes whatever the boot selection option. When set, this bit can only be cleared by an RDP regression level 1 to level 0.
        BOOT_LOCK: u1,
        reserved7: u6 = 0,
        /// Secure boot base address 0 This address is only used when TZEN = 1. The secure boot memory address can be programmed to any address in the valid address range (see Table�28: Boot space versus RDP protection) with a granularity of 128 bytes. This bits correspond to address [31:7] The SECBOOTADD0 option bytes are selected following the BOOT0 pin or NSWBOOT0 state. Examples: SECBOOTADD0[24:0] = 0x018 0000: Boot from secure user memory (0x0C00 0000) SECBOOTADD0[24:0] = 0x01F F000: Boot from RSS system memory (0x0FF8 0000) SECBOOTADD0[24:0] = 0x060 0000: Boot from secure SRAM1 on S-Bus (0x3000 0000)
        SECBOOTADD0: u25,
    }),
    /// secure watermark register 1
    /// offset: 0x50
    SECWMR1: mmio.Mmio(packed struct(u32) {
        /// Start page of secure area This field contains the first page of the secure area.
        SECWM_PSTRT: u7,
        reserved16: u9 = 0,
        /// End page of secure area This field contains the last page of the secure area.
        SECWM_PEND: u7,
        padding: u9 = 0,
    }),
    /// secure watermark register 2
    /// offset: 0x54
    SECWMR2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End page of secure hide protection area This field contains the last page of the secure HDP area.
        HDP_PEND: u7,
        reserved31: u8 = 0,
        /// Secure Hide protection area enable
        HDPEN: u1,
    }),
    /// WRP area A address register
    /// offset: 0x58
    WRPAR: mmio.Mmio(packed struct(u32) {
        /// WPR area A start page This field contains the first page of the WPR area A. Note that bit 6 is reserved on STM32WBAxEx devices.
        WRPA_PSTRT: u7,
        reserved16: u9 = 0,
        /// WPR area A end page This field contains the last page of the WPR area A. Note that bit 22 is reserved on STM32WBAxEx devices.
        WRPA_PEND: u7,
        reserved31: u8 = 0,
        /// WPR area A unlock
        UNLOCK: u1,
    }),
    /// WRP area B address register
    /// offset: 0x5c
    WRPBR: mmio.Mmio(packed struct(u32) {
        /// WRP area B start page This field contains the first page of the WRP area B. Note that bit 6 is reserved on STM32WBAxEx devices.
        WRPB_PSTRT: u7,
        reserved16: u9 = 0,
        /// WRP area B end page This field contains the last page of the WRP area B. Note that bit 22 is reserved on STM32WBAxEx devices.
        WRPB_PEND: u7,
        reserved31: u8 = 0,
        /// WPR area B unlock
        UNLOCK: u1,
    }),
    /// offset: 0x60
    reserved96: [16]u8,
    /// OEM1 key register 1
    /// offset: 0x70
    OEM1KEYR1: u32,
    /// OEM1 key register 2
    /// offset: 0x74
    OEM1KEYR2: u32,
    /// OEM2 key register 1
    /// offset: 0x78
    OEM2KEYR1: u32,
    /// OEM2 key register 2
    /// offset: 0x7c
    OEM2KEYR2: u32,
    /// secure block based register 1
    /// offset: 0x80
    SECBBR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/32 of BLOCK)
        @"BLOCK[0]": u1,
        /// (2/32 of BLOCK)
        @"BLOCK[1]": u1,
        /// (3/32 of BLOCK)
        @"BLOCK[2]": u1,
        /// (4/32 of BLOCK)
        @"BLOCK[3]": u1,
        /// (5/32 of BLOCK)
        @"BLOCK[4]": u1,
        /// (6/32 of BLOCK)
        @"BLOCK[5]": u1,
        /// (7/32 of BLOCK)
        @"BLOCK[6]": u1,
        /// (8/32 of BLOCK)
        @"BLOCK[7]": u1,
        /// (9/32 of BLOCK)
        @"BLOCK[8]": u1,
        /// (10/32 of BLOCK)
        @"BLOCK[9]": u1,
        /// (11/32 of BLOCK)
        @"BLOCK[10]": u1,
        /// (12/32 of BLOCK)
        @"BLOCK[11]": u1,
        /// (13/32 of BLOCK)
        @"BLOCK[12]": u1,
        /// (14/32 of BLOCK)
        @"BLOCK[13]": u1,
        /// (15/32 of BLOCK)
        @"BLOCK[14]": u1,
        /// (16/32 of BLOCK)
        @"BLOCK[15]": u1,
        /// (17/32 of BLOCK)
        @"BLOCK[16]": u1,
        /// (18/32 of BLOCK)
        @"BLOCK[17]": u1,
        /// (19/32 of BLOCK)
        @"BLOCK[18]": u1,
        /// (20/32 of BLOCK)
        @"BLOCK[19]": u1,
        /// (21/32 of BLOCK)
        @"BLOCK[20]": u1,
        /// (22/32 of BLOCK)
        @"BLOCK[21]": u1,
        /// (23/32 of BLOCK)
        @"BLOCK[22]": u1,
        /// (24/32 of BLOCK)
        @"BLOCK[23]": u1,
        /// (25/32 of BLOCK)
        @"BLOCK[24]": u1,
        /// (26/32 of BLOCK)
        @"BLOCK[25]": u1,
        /// (27/32 of BLOCK)
        @"BLOCK[26]": u1,
        /// (28/32 of BLOCK)
        @"BLOCK[27]": u1,
        /// (29/32 of BLOCK)
        @"BLOCK[28]": u1,
        /// (30/32 of BLOCK)
        @"BLOCK[29]": u1,
        /// (31/32 of BLOCK)
        @"BLOCK[30]": u1,
        /// (32/32 of BLOCK)
        @"BLOCK[31]": u1,
    }),
    /// offset: 0x90
    reserved144: [48]u8,
    /// secure HDP control register
    /// offset: 0xc0
    SECHDPCR: mmio.Mmio(packed struct(u32) {
        /// Secure HDP area access disable When set, this bit is only cleared by a system reset.
        HDP_ACCDIS: u1,
        padding: u31 = 0,
    }),
    /// privilege configuration register
    /// offset: 0xc4
    PRIFCFGR: mmio.Mmio(packed struct(u32) {
        /// Privileged protection for secure registers This bit is secure write protected. It can only be written by a secure privileged access when TrustZone is enabled (TZEN�=�1).
        SPRIV: u1,
        /// Privileged protection for non-secure registers
        NSPRIV: u1,
        padding: u30 = 0,
    }),
    /// offset: 0xc8
    reserved200: [8]u8,
    /// privilege block based register 1
    /// offset: 0xd0
    PRIVBBR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/32 of BLOCK)
        @"BLOCK[0]": u1,
        /// (2/32 of BLOCK)
        @"BLOCK[1]": u1,
        /// (3/32 of BLOCK)
        @"BLOCK[2]": u1,
        /// (4/32 of BLOCK)
        @"BLOCK[3]": u1,
        /// (5/32 of BLOCK)
        @"BLOCK[4]": u1,
        /// (6/32 of BLOCK)
        @"BLOCK[5]": u1,
        /// (7/32 of BLOCK)
        @"BLOCK[6]": u1,
        /// (8/32 of BLOCK)
        @"BLOCK[7]": u1,
        /// (9/32 of BLOCK)
        @"BLOCK[8]": u1,
        /// (10/32 of BLOCK)
        @"BLOCK[9]": u1,
        /// (11/32 of BLOCK)
        @"BLOCK[10]": u1,
        /// (12/32 of BLOCK)
        @"BLOCK[11]": u1,
        /// (13/32 of BLOCK)
        @"BLOCK[12]": u1,
        /// (14/32 of BLOCK)
        @"BLOCK[13]": u1,
        /// (15/32 of BLOCK)
        @"BLOCK[14]": u1,
        /// (16/32 of BLOCK)
        @"BLOCK[15]": u1,
        /// (17/32 of BLOCK)
        @"BLOCK[16]": u1,
        /// (18/32 of BLOCK)
        @"BLOCK[17]": u1,
        /// (19/32 of BLOCK)
        @"BLOCK[18]": u1,
        /// (20/32 of BLOCK)
        @"BLOCK[19]": u1,
        /// (21/32 of BLOCK)
        @"BLOCK[20]": u1,
        /// (22/32 of BLOCK)
        @"BLOCK[21]": u1,
        /// (23/32 of BLOCK)
        @"BLOCK[22]": u1,
        /// (24/32 of BLOCK)
        @"BLOCK[23]": u1,
        /// (25/32 of BLOCK)
        @"BLOCK[24]": u1,
        /// (26/32 of BLOCK)
        @"BLOCK[25]": u1,
        /// (27/32 of BLOCK)
        @"BLOCK[26]": u1,
        /// (28/32 of BLOCK)
        @"BLOCK[27]": u1,
        /// (29/32 of BLOCK)
        @"BLOCK[28]": u1,
        /// (30/32 of BLOCK)
        @"BLOCK[29]": u1,
        /// (31/32 of BLOCK)
        @"BLOCK[30]": u1,
        /// (32/32 of BLOCK)
        @"BLOCK[31]": u1,
    }),
};
