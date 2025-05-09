const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BOR_LEV = enum(u2) {
    /// BOR OFF, POR/PDR reset threshold level is applied.
    Disabled = 0x0,
    /// BOR Level 1, the threshold level is low (around 2.1 V).
    Level1 = 0x1,
    /// BOR Level 2, the threshold level is medium (around 2.4 V).
    Level2 = 0x2,
    /// BOR Level 3, the threshold level is high (around 2.7 V).
    Level3 = 0x3,
};

pub const CRC_BURST = enum(u2) {
    /// every burst has a size of 4 Flash words (64 Bytes).
    Word4 = 0x0,
    /// every burst has a size of 16 Flash words (256 Bytes).
    Word16 = 0x1,
    /// every burst has a size of 64 Flash words (1 Kbytes).
    Word64 = 0x2,
    /// every burst has a size of 256 Flash words (4 Kbytes).
    Word256 = 0x3,
};

pub const DBG_AUTH = enum(u8) {
    /// Authentication method using ECDSA signature (NIST P256).
    ECDSA = 0x51,
    /// Delegated debug (to OEM iRoT code in user Flash).
    Delegated = 0x6f,
    /// Authentication method using password.
    Password = 0x8a,
    /// Locked device (no debug allowed).
    Locked = 0xb4,
    _,
};

pub const IROT_SELECT = enum(u8) {
    /// ST iRoT is selected at boot.
    Selected = 0xb4,
    _,
};

pub const NEXTKL = enum(u2) {
    /// OBKINDEX represents the index of the option byte key stored for the hide protection level indicated in SBS_HDPLSR.
    Plus0 = 0x0,
    /// OBKINDEX represents the index of the option byte key stored for the hide protection level indicated in SBS_HDPLSR plus one (e.g. if HDPL=1 in SBS_HDPLR the key of level 2 is selected).
    Plus1 = 0x1,
    _,
};

pub const NVSRP_NVSTATE = enum(u8) {
    /// CLOSE.
    Close = 0x51,
    /// OPEN.
    Open = 0xb4,
    _,
};

pub const NVSR_NVSTATE = enum(u8) {
    /// CLOSED device.
    Closed = 0x51,
    /// OPEN device.
    Open = 0xb4,
    _,
};

pub const OBKSIZE = enum(u2) {
    /// Key size is 32 bits.
    Bits32 = 0x0,
    /// Key size is 64 bits.
    Bits64 = 0x1,
    /// Key size is 128 bits.
    Bits128 = 0x2,
    /// Key size is 256 bits.
    Bits256 = 0x3,
};

pub const OEM_PROVD = enum(u8) {
    /// Device has been provisioned by the OEM.
    Provisioned = 0xb4,
    _,
};

/// Embedded Flash memory.
pub const FLASH = extern struct {
    /// Access control register.
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Read latency These bits are used to control the number of wait states used during read operations on both non-volatile memory banks. The application software has to program them to the correct value depending on the embedded Flash memory interface frequency and voltage conditions. Please refer to Table 27 for details. ... Note: Embedded Flash does not verify that the configuration is correct.
        LATENCY: u4,
        /// Flash signal delay These bits are used to control the delay between non-volatile memory signals during programming operations. Application software has to program them to the correct value depending on the embedded Flash memory interface frequency. Please refer to Table 27 for details. Note: Embedded Flash does not verify that the configuration is correct.
        WRHIGHFREQ: u2,
        padding: u26 = 0,
    }),
    /// FLASH control key register.
    /// offset: 0x04
    KEYR: mmio.Mmio(packed struct(u32) {
        /// Control unlock key Following values must be written to FLASH_KEYR consecutively to unlock FLASH_CR register: 1st key = 0x4567 0123 2nd key = 0xCDEF 89AB Reads to this register returns zero. If above sequence is wrong or performed twice, the FLASH_CR register is locked until the next system reset, and access to it generates a bus error.
        CUKEY: u32,
    }),
    /// offset: 0x08
    reserved8: [8]u8,
    /// FLASH control register.
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// Configuration lock bit When this bit is set write to all other bits in this register, and to FLASH_IER register, are ignored. Clearing this bit requires the correct write sequence to FLASH_KEYR register (see this register for details). If a wrong sequence is executed, or if the unlock sequence is performed twice, this bit remains locked until the next system reset. During the write access to set LOCK bit from 0 to 1, it is possible to change the other bits of this register.
        LOCK: u1,
        /// Internal buffer control bit Setting this bit enables internal buffer for write operations. This allows preparing program operations even if a sector or bank erase is ongoing. When PG is cleared, the internal buffer is disabled for write operations, and all the data stored in the buffer but not sent to the operation queue are lost.
        PG: u1,
        /// Sector erase request Setting this bit requests a sector erase. Write protection error is triggered when a sector erase is required on at least one protected sector. BER has a higher priority than SER: if both bits are set, the embedded Flash memory executes a bank erase.
        SER: u1,
        /// Bank erase request Setting this bit requests a bank erase operation (user Flash memory only). Write protection error is triggered when a bank erase is required and some sectors are protected. BER has a higher priority than SER: if both are set, the embedded Flash memory executes a bank erase.
        BER: u1,
        /// Force write This bit forces a write operation even if the write buffer is not full. In this case all bits not written are set by hardware. The embedded Flash memory resets FW when the corresponding operation has been acknowledged. Note: Using a force-write operation prevents the application from updating later the missing bits with something else than 1, because it is likely that it will lead to permanent ECC error. Write forcing is effective only if the write buffer is not empty (in particular, FW does not start several write operations when the force-write operations are performed consecutively).
        FW: u1,
        /// Erase start control bit This bit is used to start a sector erase or a bank erase operation. The embedded Flash memory resets START when the corresponding operation has been acknowledged. The user application cannot access any embedded Flash memory register until the operation is acknowledged.
        START: u1,
        /// Sector erase selection number These bits are used to select the target sector for an erase operation (they are unused otherwise). ...
        SSN: u2,
        reserved16: u8 = 0,
        /// Program Enable for OTP Area Set this bit to enable write operations to OTP area.
        PG_OTP: u1,
        /// CRC enable Setting this bit enables the CRC calculation. CRC_EN does not start CRC calculation but enables CRC configuration through FLASH_CRCCR register. When CRC calculation is performed it can be disabled by clearing CRC_EN bit. Doing so sets CRCDATA to 0x0, clears CRC configuration and resets the content of FLASH_CRCDATAR register.
        CRC_EN: u1,
        reserved24: u6 = 0,
        /// All banks select bit When this bit is set the erase is done on all Flash Memory sectors. ALL_BANKS is used only if a bank erase is required (BER=1). In all others operations, this control bit is ignored.
        ALL_BANKS: u1,
        padding: u7 = 0,
    }),
    /// FLASH status register.
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Busy flag This bit is set when an effective write, erase or option byte change operation is ongoing. It is possible to know what type of operation is being executed reading the flags IS_PROGRAM, IS_ERASE and IS_OPTCHANGE. BUSY cannot be cleared by application. It is automatically reset by hardware every time a step in a write, erase or option byte change operation completes. It is not recommended to do software polling on BUSY to know when one operation completed because, depending of operation, more pulses are possible for one only operation. For software polling it is therefore better to use QW flag or to check the EOPF flag.
        BUSY: u1,
        /// Write buffer not empty flag This bit is set when the embedded Flash memory is waiting for new data to complete the write buffer. In this state, the write buffer is not empty. WBNE is reset by hardware each time the write buffer is complete or the write buffer is emptied following one of the event below: the application software forces the write operation using FW bit in FLASH_CR the embedded Flash memory detects an error that involves data loss the application software has disabled write operations This bit cannot be forced to 0. To reset it, clear the write buffer by performing any of the above listed actions, or send the missing data.
        WBNE: u1,
        /// Wait queue flag This bit is set when a write, erase or option byte change operation is pending in the command queue buffer. It is not possible to know what type of programming operation is present in the queue. This flag is reset by hardware when all write, erase or option byte change operations have been executed and thus removed from the waiting queue(s). This bit cannot be forced to 0. It is reset after a deterministic time if no other operations are requested.
        QW: u1,
        /// CRC busy flag This bit is set when a CRC calculation is ongoing. This bit cannot be forced to 0. The user must wait until the CRC calculation has completed or disable CRC computation using CRC_EN bit in FLASH_CR register.
        CRC_BUSY: u1,
        /// Is a program This bit is set together with BUSY when a program operation is ongoing. It is cleared when BUSY is cleared. This flag can also raise with IS_OPTCHANGE, because an program operation can happen during an option change.
        IS_PROGRAM: u1,
        /// Is an erase This bit is set together with BUSY when an erase operation is ongoing. It is cleared when BUSY is cleared. This flag can also raise with IS_OPTCHANGE, because an erase operation can happen during an option change.
        IS_ERASE: u1,
        /// Is an option change This bit is set together with BUSY when an option change operation is ongoing. It is cleared when BUSY is cleared. This flag can also raise with IS_PROGRAM or IS_ERASE, because a program or erase step is ongoing during option change.
        IS_OPTCHANGE: u1,
        reserved25: u18 = 0,
        /// Root code check flag This bit returns the status of the root code check performed following the first access to the Flash. This bit is cleared with RCHECKF bit in FLASH_FCR (optional).
        RCHECKF: u1,
        padding: u6 = 0,
    }),
    /// FLASH status register.
    /// offset: 0x18
    FCR: mmio.Mmio(packed struct(u32) {
        reserved25: u25 = 0,
        /// Root code check flag clear Set this bit to clear RCHECKF bit in FLASH_SR.
        RCHECKF: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// FLASH interrupt enable register.
    /// offset: 0x20
    IER: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End-of-program interrupt control bit.
        EOPIE: u1,
        /// Write protection error interrupt enable bit.
        WRPERRIE: u1,
        /// Programming sequence error interrupt enable bit.
        PGSERRIE: u1,
        /// Strobe error interrupt enable bit.
        STRBERRIE: u1,
        /// Option byte loading error interrupt enable bit.
        OBLERRIE: u1,
        /// Inconsistency error interrupt enable bit.
        INCERRIE: u1,
        reserved24: u2 = 0,
        /// Read security error interrupt enable bit.
        RDSERRIE: u1,
        /// ECC single correction error interrupt enable bit.
        SNECCERRIE: u1,
        /// ECC double detection error interrupt enable bit.
        DBECCERRIE: u1,
        /// CRC end of calculation interrupt enable bit.
        CRCENDIE: u1,
        /// CRC read error interrupt enable bit.
        CRCRDERRIE: u1,
        padding: u3 = 0,
    }),
    /// FLASH interrupt status register.
    /// offset: 0x24
    ISR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End-of-program flag This bit is set when a programming operation completes. An interrupt is generated if the EOPIE is set. It is not necessary to reset EOPF before starting a new operation. Setting EOPF bit in FLASH_ICR register clears this bit.
        EOPF: u1,
        /// Write protection error flag This bit is set when a protection error occurs during a program operation. An interrupt is also generated if the WRPERRIE is set. Setting WRPERRF bit in FLASH_ICR register clears this bit.
        WRPERRF: u1,
        /// Programming sequence error flag This bit is set when a sequence error occurs. An interrupt is generated if the PGSERRIE bit is set. Setting PGSERRF bit in FLASH_ICR register clears this bit.
        PGSERRF: u1,
        /// Strobe error flag This bit is set when a strobe error occurs (when the master attempts to write several times the same byte in the write buffer). An interrupt is generated if the STRBERRIE bit is set. Setting STRBERRF bit in FLASH_ICR register clears this bit.
        STRBERRF: u1,
        /// Option byte loading error flag This bit is set when an error is found during the option byte loading sequence. An interrupt is generated if OBLERRIE is set. Setting OBLERRF bit in the FLASH_ICR register clears this bit.
        OBLERRF: u1,
        /// Inconsistency error flag This bit is set when a inconsistency error occurs. An interrupt is generated if INCERRIE is set. Setting INCERRF bit in the FLASH_ICR register clears this bit.
        INCERRF: u1,
        reserved24: u2 = 0,
        /// Read security error flag This bit is set when a read security error occurs (read access to hide protected area with incorrect hide protection level). An interrupt is generated if RDSERRIE is set. Setting RDSERRF bit in FLASH_ICR register clears this bit.
        RDSERRF: u1,
        /// ECC single error flag This bit is set when an ECC single correction error occurs during a read operation. An interrupt is generated if SNECCERRIE is set. Setting SNECCERRF bit in FLASH_ICR register clears this bit.
        SNECCERRF: u1,
        /// ECC double error flag This bit is set when an ECC double detection error occurs during a read operation. An interrupt is generated if DBECCERRIE is set. Setting DBECCERRF bit in FLASH_ICR register clears this bit.
        DBECCERRF: u1,
        /// CRC end flag This bit is set when the CRC computation has completed. An interrupt is generated if CRCENDIE is set. It is not necessary to reset CRCEND before restarting CRC computation. Setting CRCENDF bit in FLASH_ICR register clears this bit.
        CRCENDF: u1,
        /// CRC read error flag This bit is set when a word is found read protected during a CRC operation. An interrupt is generated if CRCRDIE is set. Setting CRCRDERRF bit in FLASH_ICR register clears this bit. This flag is valid only when CRCEND bit is set.
        CRCRDERRF: u1,
        padding: u3 = 0,
    }),
    /// FLASH interrupt clear register.
    /// offset: 0x28
    ICR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// End-of-program flag clear Setting this bit clears EOPF flag in FLASH_ISR register.
        EOPF: u1,
        /// Write protection error flag clear Setting this bit clears WRPERRF flag in FLASH_ISR register.
        WRPERRF: u1,
        /// Programming sequence error flag clear Setting this bit clears PGSERRF flag in FLASH_ISR register.
        PGSERRF: u1,
        /// Strobe error flag clear Setting this bit clears STRBERRF flag in FLASH_ISR register.
        STRBERRF: u1,
        /// Option byte loading error flag clear Setting this bit clears OBLERRF flag in FLASH_ISR register.
        OBLERRF: u1,
        /// Inconsistency error flag clear Setting this bit clears INCERRF flag in FLASH_ISR register.
        INCERRF: u1,
        reserved24: u2 = 0,
        /// Read security error flag clear Setting this bit clears RDSERRF flag in FLASH_ISR register.
        RDSERRF: u1,
        /// ECC single error flag clear Setting this bit clears SNECCERRF flag in FLASH_ISR register. If the DBECCERRF flag of FLASH_ISR register is also cleared, FLASH_ECCFAR register is reset to zero as well.
        SNECCERRF: u1,
        /// ECC double error flag clear Setting this bit clears DBECCERRF flag in FLASH_ISR register. If the SNECCERRF flag of FLASH_ISR register is also cleared, FLASH_ECCFAR register is reset to zero as well.
        DBECCERRF: u1,
        /// CRC end flag clear Setting this bit clears CRCENDF flag in FLASH_ISR register.
        CRCENDF: u1,
        /// CRC error flag clear Setting this bit clears CRCRDERRF flag in FLASH_ISR register.
        CRCRDERRF: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// FLASH CRC control register.
    /// offset: 0x30
    CRCCR: mmio.Mmio(packed struct(u32) {
        /// CRC sector number CRC_SECT is used to select one user Flash sectors to be added to the list of sectors on which the CRC is calculated. The CRC can be computed either between two addresses (using registers FLASH_CRCSADDR and FLASH_CRCEADDR) or on a list of sectors using this register. If this latter option is selected, it is possible to add a sector to the list of sectors by programming the sector number in CRC_SECT and then setting ADD_SECT bit. The list of sectors can be erased either by setting CLEAN_SECT bit or by disabling the CRC computation. ...
        CRC_SECT: u2,
        reserved9: u7 = 0,
        /// CRC sector mode select bit When this bit is set the CRC calculation is performed at sector level, on the sectors present in the list of sectors. To add a sector to this list, use ADD_SECT and CRC_SECT bits. To clean the list, use CLEAN_SECT bit. When CRC_BY_SECT is cleared the CRC calculation is performed on all addresses defined between start and end addresses defined in FLASH_CRCSADDR and FLASH_CRCEADDR registers.
        CRC_BY_SECT: u1,
        /// CRC sector select bit When this bit is set the sector whose number is written in CRC_SECT is added to the list of sectors on which the CRC is calculated.
        ADD_SECT: u1,
        /// CRC sector list clear bit When this bit is set the list of sectors on which the CRC is calculated is cleared.
        CLEAN_SECT: u1,
        reserved16: u4 = 0,
        /// CRC start bit START_CRC bit triggers a CRC calculation using the current configuration. No CRC calculation can launched when an option byte change operation is ongoing because all read accesses to embedded Flash memory registers are put on hold until the option byte change operation has completed. This bit is cleared when CRC computation starts.
        START_CRC: u1,
        /// CRC clear bit Setting CLEAN_CRC to 1 clears the current CRC result stored in the FLASH_CRCDATAR register.
        CLEAN_CRC: u1,
        reserved20: u2 = 0,
        /// CRC burst size CRC_BURST bits set the size of the bursts that are generated by the CRC calculation unit. A Flash word is 128-bit.
        CRC_BURST: CRC_BURST,
        reserved24: u2 = 0,
        /// All sectors selection When this bit is set all the sectors in user Flash are added to list of sectors on which the CRC shall be calculated. This bit is cleared when CRC computation starts.
        ALL_SECT: u1,
        padding: u7 = 0,
    }),
    /// FLASH CRC start address register.
    /// offset: 0x34
    CRCSADDR: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// CRC start address This register is used when CRC_BY_SECT is cleared. It must be programmed to the address of the first Flash word to use for the CRC calculation, done burst by burst. CRC computation starts at an address aligned to the burst size defined in CRC_BURST of FLASH_CRCCR register. Hence least significant bits [5:0] of the address are set by hardware to 0 (minimum burst size= 64 bytes). The address is relative to the Flash bank.
        CRC_START_ADDR: u11,
        padding: u15 = 0,
    }),
    /// FLASH CRC end address register.
    /// offset: 0x38
    CRCEADDR: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// CRC end address This register is used when CRC_BY_SECT is cleared. It must be programmed to the address of the Flash word starting the last burst of the CRC calculation. The burst size is defined in CRC_BURST of FLASH_CRCCR register. The least significant bits [5:0] of the address are set by hardware to 0 (minimum burst size= 64 bytes). The address is relative to the Flash bank.
        CRC_END_ADDR: u11,
        padding: u15 = 0,
    }),
    /// FLASH CRC data register.
    /// offset: 0x3c
    CRCDATAR: mmio.Mmio(packed struct(u32) {
        /// CRC result This bitfield contains the result of the last CRC calculation. The value is valid only when CRC calculation completed (CRCENDF is set in FLASH_ISR register). CRC_DATA is cleared when CRC_EN is cleared in FLASH_CR register (CRC disabled), or when CLEAN_CRC bit is set in FLASH_CRCCR register.
        CRC_DATA: u32,
    }),
    /// FLASH ECC single error fail address.
    /// offset: 0x40
    ECCSFADDR: mmio.Mmio(packed struct(u32) {
        /// ECC single error correction fail address When a single ECC error correction occurs during a read operation, the SEC_FADD bitfield contains the system bus address that generated the error. This register is automatically cleared when SNECCERRF flag that generated the error is cleared. Note that only the first address that generated an ECC single error correction error is saved in this register.
        SEC_FADD: u32,
    }),
    /// FLASH ECC double error fail address.
    /// offset: 0x44
    ECCDFADDR: mmio.Mmio(packed struct(u32) {
        /// ECC double error detection fail address When a double ECC detection occurs during a read operation, the DED_FADD bitfield contains the system bus address that generated the error. This register is automatically cleared when the DBECCERRF flag that generated the error is cleared. Note that only the first address that generated an ECC double error detection error is saved in this register.
        DED_FADD: u32,
    }),
    /// offset: 0x48
    reserved72: [184]u8,
    /// FLASH options key register.
    /// offset: 0x100
    OPTKEYR: mmio.Mmio(packed struct(u32) {
        /// Options configuration unlock key Following values must be written to FLASH_OPTKEYR consecutively to unlock FLASH_OPTCR register: 1st key = 0x0819 2A3B 2nd key = 0x4C5D 6E7F Reads to this register returns zero. If above sequence is performed twice locks up the corresponding register/bit until the next system reset, and generates a bus error.
        OCUKEY: u32,
    }),
    /// FLASH options control register.
    /// offset: 0x104
    OPTCR: mmio.Mmio(packed struct(u32) {
        /// Options lock When this bit is set write to all other bits in this register, and write to OTP words, option bytes and option bytes keys control registers, are ignored. Clearing this bit requires the correct write sequence to FLASH_OPTKEYR register (see this register for details). If a wrong sequence is executed, or the unlock sequence is performed twice, this bit remains locked until next system reset. During the write access to set LOCK bit from 0 to 1, it is possible to change the other bits of this register.
        OPTLOCK: u1,
        /// Program options.
        PG_OPT: u1,
        reserved27: u25 = 0,
        /// Key valid error interrupt enable bit This bit controls if an interrupt has to be generated when KVEF is set in FLASH_OPTISR.
        KVEIE: u1,
        /// Key transfer error interrupt enable bit This bit controls if an interrupt has to be generated when KTEF is set in FLASH_OPTISR.
        KTEIE: u1,
        reserved30: u1 = 0,
        /// Option byte change error interrupt enable bit This bit controls if an interrupt has to be generated when an error occurs during an option byte change.
        OPTERRIE: u1,
        padding: u1 = 0,
    }),
    /// FLASH options interrupt status register.
    /// offset: 0x108
    OPTISR: mmio.Mmio(packed struct(u32) {
        reserved27: u27 = 0,
        /// Key valid error flag This bit is set when loading an unknown or corrupted option byte key. More specifically: Embedded Flash did not find an option byte key that corresponds to the given OBKINDEX[4:0] and the requested HDPL (optionally modified by NEXTKL[1:0]). It can happen for example when requested key has not being provisioned. A double error detection was found when loading the requested option byte key. In this case, if this key is provisioned again the error should disappear. When KVEF is set write to START bit in FLASH_OBKCR is ignored. An interrupt is generated when this flag is raised if the KVEIE bit of FLASH_OPTCR register is set. Setting KVEF bit of register FLASH_OPTICR clears this bit.
        KVEF: u1,
        /// Key transfer error flag This bit is set when embedded Flash signals an error to the SAES peripheral. It happens when the key size (128-bit or 256-bit) is not matching between embedded Flash OBKSIZE[1:0] and KEYSIZE bit in SAES_CR register. It also happen when an ECC dual error detection occurred while embedded Flash loaded an option byte key for the SAES peripheral. When KTEF is set write to START bit in FLASH_OBKCR is ignored. An interrupt is generated when this flag is raised if the KTEIE bit of FLASH_OPTCR register is set. Setting KTEF bit of register FLASH_OPTICR clears this bit.
        KTEF: u1,
        reserved30: u1 = 0,
        /// Option byte change error flag When OPTERRF is set, the option byte change operation did not successfully complete. An interrupt is generated when this flag is raised if the OPTERRIE bit of FLASH_OPTCR register is set. Setting OPTERRF of register FLASH_OPTICR clears this bit.
        OPTERRF: u1,
        padding: u1 = 0,
    }),
    /// FLASH options interrupt clear register.
    /// offset: 0x10c
    OPTICR: mmio.Mmio(packed struct(u32) {
        reserved27: u27 = 0,
        /// key valid error flag Set this bit to clear KVEF flag in FLASH_OPTISR register.
        KVEF: u1,
        /// key transfer error flag Set this bit to clear KTEF flag in FLASH_OPTISR register.
        KTEF: u1,
        reserved30: u1 = 0,
        /// Option byte change error flag Set this bit to clear OPTERRF flag in FLASH_OPTISR register.
        OPTERRF: u1,
        padding: u1 = 0,
    }),
    /// FLASH option byte key control register.
    /// offset: 0x110
    OBKCR: mmio.Mmio(packed struct(u32) {
        /// Option byte key index This bitfield represents the index of the option byte key in a given hide protection level. Reading keys with index lower that 8, the value is not be available in OBKDRx registers. It is instead sent directly to SAES peripheral. All others keys can be read using OBKDRx registers. Up to 32 keys can be provisioned per hide protection level (0, 1 or 2), provided there is enough space left in the Flash to store them.
        OBKINDEX: u5,
        reserved8: u3 = 0,
        /// Next key level 10 or 11: reserved.
        NEXTKL: NEXTKL,
        /// Option byte key size Application must use this bitfield to specify how many bits must be used for the new key. Embedded Flash ignores OBKSIZE during read of option keys because size is stored with the key.
        OBKSIZE: OBKSIZE,
        reserved14: u2 = 0,
        /// Key program This bit must be set to write option byte keys (keys are read otherwise).
        KEYPROG: u1,
        /// Key option start This bit is used to start the option byte key operation defined by the PROG bit. The embedded Flash memory resets START when the corresponding operation has been acknowledged.
        KEYSTART: u1,
        padding: u16 = 0,
    }),
    /// offset: 0x114
    reserved276: [4]u8,
    /// FLASH option bytes key data register 0.
    /// offset: 0x118
    OBKDR: [8]u32,
    /// offset: 0x138
    reserved312: [200]u8,
    /// FLASH non-volatile status register.
    /// offset: 0x200
    NVSR: mmio.Mmio(packed struct(u32) {
        /// Non-volatile state others: invalid configuration.
        NVSTATE: NVSR_NVSTATE,
        padding: u24 = 0,
    }),
    /// FLASH security status register programming.
    /// offset: 0x204
    NVSRP: mmio.Mmio(packed struct(u32) {
        /// Non-volatile state programming Write to change corresponding bits in FLASH_NVSR register: Actual option byte change from close to open is triggered only after memory clear hardware process is confirmed. When NVSTATE=0xB4 (resp. 0x51) writing any other value than 0x51 (resp. 0xB4) triggers an option byte change error (OPTERRF).
        NVSTATE: NVSRP_NVSTATE,
        padding: u24 = 0,
    }),
    /// FLASH RoT status register.
    /// offset: 0x208
    ROTSR: mmio.Mmio(packed struct(u32) {
        /// OEM provisioned device Any other value: device is not provisioned by the OEM.
        OEM_PROVD: OEM_PROVD,
        /// Debug authentication method Any other value: no authentication method selected (NotSet).
        DBG_AUTH: DBG_AUTH,
        reserved24: u8 = 0,
        /// iRoT selection This option is ignored for STM32H7R devices (OEM iRoT is always selected). Any other value: OEM iRoT is selected at boot.
        IROT_SELECT: IROT_SELECT,
    }),
    /// FLASH RoT status register programming.
    /// offset: 0x20c
    ROTSRP: mmio.Mmio(packed struct(u32) {
        /// OEM provisioned device Write to change corresponding bits in FLASH_ROTSR register. Write are ignored if HDPL is greater than 1.
        OEM_PROVD: u8,
        /// Debug authentication method programming Write to change corresponding bits in FLASH_ROTSR register. Write are ignored if HDPL is greater than 0.
        DBG_AUTH: u8,
        reserved24: u8 = 0,
        /// iRoT selection This option is ignored for STM32H7R devices. Write to change corresponding bits in FLASH_ROTSR register. Write are ignored if HDPL is greater than 1 and if NVSTATE is not 0xB4 (OPEN).
        IROT_SELECT: u8,
    }),
    /// FLASH OTP lock status register.
    /// offset: 0x210
    OTPLSR: mmio.Mmio(packed struct(u32) {
        /// OTP lock n Block n corresponds to OTP 16-bit word 32 x n to 32 x n + 31. OTPL[n] = 1 indicates that all OTP 16-bit words in OTP Block n are locked and can no longer be programmed. OTPL[n] = 0 indicates that all OTP 16-bit words in OTP Block n are not locked and can still be modified.
        OTPL: u16,
        padding: u16 = 0,
    }),
    /// FLASH OTP lock status register programming.
    /// offset: 0x214
    OTPLSRP: mmio.Mmio(packed struct(u32) {
        /// OTP lock n programming Write to change corresponding option byte bit in FLASH_OTPLSR. OTPL bits can be only be set, not cleared.
        OTPL: u16,
        padding: u16 = 0,
    }),
    /// FLASH write protection status register.
    /// offset: 0x218
    WRPSR: mmio.Mmio(packed struct(u32) {
        /// Write protection for sector n This bit reflects the write protection status of user Flash sector n.
        WRPS: u8,
        padding: u24 = 0,
    }),
    /// FLASH write protection status register programming.
    /// offset: 0x21c
    WRPSRP: mmio.Mmio(packed struct(u32) {
        /// Write protection for sector n programming Write to change corresponding bit in FLASH_WRPSR.
        WRPS: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x220
    reserved544: [16]u8,
    /// FLASH hide protection status register.
    /// offset: 0x230
    HDPSR: mmio.Mmio(packed struct(u32) {
        /// Hide protection user Flash area start This option sets the start address that contains the first 256-byte block of the hide protection (HDP) area in user Flash area. If HDP_AREA_END=HDP_AREA_START all the sectors are protected. If HDP_AREA_END<HDP_AREA_START no sectors are protected.
        HDP_AREA_START: u9,
        reserved16: u7 = 0,
        /// Hide protection user Flash area end This option sets the end address that contains the last 256-byte block of the hide protection (HDP) area in user Flash area. If HDP_AREA_END=HDP_AREA_START all the sectors are protected. If HDP_AREA_END<HDP_AREA_START no sectors are protected.
        HDP_AREA_END: u9,
        padding: u7 = 0,
    }),
    /// FLASH hide protection status register programming.
    /// offset: 0x234
    HDPSRP: mmio.Mmio(packed struct(u32) {
        /// Hide protection user Flash area start programming Write to change corresponding option byte bits in FLASH_HDPSR. If HDP_AREA_END=HDP_AREA_START all the sectors are protected. If HDP_AREA_END<HDP_AREA_START no sectors are protected.
        HDP_AREA_START: u9,
        reserved16: u7 = 0,
        /// Hide protection user Flash area end programming Write to change corresponding option byte bits in FLASH_HDPSR. If HDP_AREA_END=HDP_AREA_START all the sectors are protected. If HDP_AREA_END<HDP_AREA_START no sectors are protected.
        HDP_AREA_END: u9,
        padding: u7 = 0,
    }),
    /// offset: 0x238
    reserved568: [24]u8,
    /// FLASH epoch status register.
    /// offset: 0x250
    EPOCHSR: mmio.Mmio(packed struct(u32) {
        /// Epoch This value is distributed by hardware to the SAES peripheral.
        EPOCH: u24,
        padding: u8 = 0,
    }),
    /// FLASH RoT status register programming.
    /// offset: 0x254
    EPOCHSRP: mmio.Mmio(packed struct(u32) {
        /// Epoch programming Write to change corresponding bits in FLASH_EPOCHSR register.
        EPOCH: u24,
        padding: u8 = 0,
    }),
    /// offset: 0x258
    reserved600: [8]u8,
    /// FLASH option byte word 1 status register.
    /// offset: 0x260
    OBW1SR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Brownout level These bits reflects the power level that generates a system reset.
        BOR_LEV: BOR_LEV,
        /// Independent watchdog HW Control.
        IWDG_HW: u1,
        reserved6: u1 = 0,
        /// Reset on stop mode.
        NRST_STOP: u1,
        /// Reset on standby mode.
        NRST_STBY: u1,
        /// XSPIM_P1 High-Speed at Low-Voltage.
        OCTO1_HSLV: u1,
        /// XSPIM_P2 High-Speed at Low-Voltage.
        OCTO2_HSLV: u1,
        reserved17: u7 = 0,
        /// IWDG stop mode freeze When set the independent watchdog IWDG is frozen in system Stop mode.
        IWDG_FZ_STOP: u1,
        /// IWDG standby mode freeze When set the independent watchdog IWDG is frozen in system Standby mode.
        IWDG_FZ_SDBY: u1,
        reserved28: u9 = 0,
        /// Personalization OK This bit is set on STMicroelectronics production line.
        PERSO_OK: u1,
        /// I/O High-Speed at Low-Voltage This bit indicates that the product operates below 2.5 V.
        VDDIO_HSLV: u1,
        padding: u2 = 0,
    }),
    /// FLASH option byte word 1 status register programming.
    /// offset: 0x264
    OBW1SRP: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Brownout level Write to change corresponding bits in FLASH_OBW1SR register.
        BOR_LEV: u2,
        /// Independent watchdog HW Control Write to change corresponding bit in FLASH_OBW1SR register.
        IWDG_HW: u1,
        reserved6: u1 = 0,
        /// Reset on stop mode programming Write to change corresponding bit in FLASH_OBW1SR register.
        NRST_STOP: u1,
        /// Reset on standby mode programming Write to change corresponding bit in FLASH_OBW1SR register.
        NRST_STBY: u1,
        /// XSPIM_P1 High-Speed at Low-Voltage Write to change corresponding bit in FLASH_OBW1SR register.
        OCTO1_HSLV: u1,
        /// XSPIM_P2 High-Speed at Low-Voltage programming Write to change corresponding bit in FLASH_OBW1SR register.
        OCTO2_HSLV: u1,
        reserved17: u7 = 0,
        /// IWDG stop mode freeze Write to change corresponding bit in FLASH_OBW1SR register.
        IWDG_FZ_STOP: u1,
        /// IWDG standby mode freeze programming Write to change corresponding bit in FLASH_OBW1SR register.
        IWDG_FZ_SDBY: u1,
        reserved29: u10 = 0,
        /// I/O High-Speed at Low-Voltage programming Write to change corresponding bit in FLASH_OBW1SR register.
        VDDIO_HSLV: u1,
        padding: u2 = 0,
    }),
    /// FLASH option byte word 2 status register.
    /// offset: 0x268
    OBW2SR: mmio.Mmio(packed struct(u32) {
        /// ITCM SRAM configuration.
        ITCM_AXI_SHARE: u3,
        reserved4: u1 = 0,
        /// DTCM SRAM configuration.
        DTCM_AXI_SHARE: u3,
        reserved8: u1 = 0,
        /// ECC on SRAM.
        ECC_ON_SRAM: u1,
        /// I2C Not I3C.
        I2C_NI3C: u1,
        padding: u22 = 0,
    }),
    /// FLASH option byte word 2 status register programming.
    /// offset: 0x26c
    OBW2SRP: mmio.Mmio(packed struct(u32) {
        /// ITCM AXI share programming Write to change corresponding bits in FLASH_OBW2SR register. Bit 2 should be kept to 0: ITCM_AXI_SHARE: = 000 or 011: ITCM 64 Kbytes ITCM_AXI_SHARE = 001: ITCM 128 Kbytes ITCM_AXI_SHARE = 010: ITCM 192 Kbytes.
        ITCM_AXI_SHARE: u3,
        reserved4: u1 = 0,
        /// DTCM AXI share programming Write to change corresponding bits in the FLASH_OBW2SR register. Bit 2 should be kept to 0: DTCM_AXI_SHARE = 000 or 011: DTCM 64 Kbytes DTCM_AXI_SHARE = 001: DTCM 128 Kbytes DTCM_AXI_SHARE = 010: DTCM 192 Kbytes.
        DTCM_AXI_SHARE: u3,
        reserved8: u1 = 0,
        /// ECC on SRAM programming Write to change corresponding bit in FLASH_OBW2SR register.
        ECC_ON_SRAM: u1,
        /// I2C Not I3C Write to change corresponding bit in FLASH_OBW2SR register.
        I2C_NI3C: u1,
        padding: u22 = 0,
    }),
};
