const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ENC = enum(u1) {
    /// OTFDEC working in decryption mode
    Decryption = 0x0,
    /// OTFDEC working in encryption mode
    Encryption = 0x1,
};

pub const MODE = enum(u2) {
    /// All read accesses are decrypted (instruction or data).
    Standard = 0x2,
    /// Enhanced encryption mode is activated, and only instruction accesses are decrypted
    Enhanced = 0x3,
    _,
};

/// On-The-Fly Decryption engine.
pub const OTFDEC = extern struct {
    /// OTFDEC control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Encryption mode bit When this bit is set, OTFDEC is used in encryption mode, during which application can write clear text data then read back encrypted data. When this bit is cleared (default), OTFDEC is used in decryption mode, during which application only read back decrypted data. For both modes, cryptographic context (keys, nonces, firmware versions) must be properly initialized. When this bit is set, only data accesses are allowed (zeros are returned otherwise, and XONEIF is set). When MODE = 11, enhanced encryption mode is automatically selected. Note: When ENC bit is set, no access to OCTOSPI must be done (registers and Memory‑mapped region).
        ENC: ENC,
        padding: u31 = 0,
    }),
    /// offset: 0x04
    reserved4: [12]u8,
    /// OTFDEC_PRIVCFGR.
    /// offset: 0x10
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// Privileged access protection. Unprivileged read accesses to registers return zeros Unprivileged write accesses to registers are ignored. Note: This bit can only be written in privileged mode. There is no limitations on reads.
        PRIV: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x14
    reserved20: [12]u8,
    /// offset: 0x20
    Region: u32,
    /// offset: 0x24
    reserved36: [732]u8,
    /// OTFDEC interrupt status register.
    /// offset: 0x300
    ISR: mmio.Mmio(packed struct(u32) {
        /// Security error interrupt flag status This bit is set by hardware and read only by application. This bit is set when at least one security error has been detected. This bit is cleared when application sets in OTFDEC_ICR the corresponding bit to 1.
        SEIF: u1,
        /// Execute-only execute-never error interrupt flag status This bit is set by hardware and read only by application. This bit is set when a read access and not an instruction fetch is detected on any encrypted region with MODE bits set to 11. Lastly, XONEIF is also set when an execute access is detected while encryption mode is enabled. This bit is cleared when application sets in OTFDEC_ICR the corresponding bit to 1.
        XONEIF: u1,
        /// Key error interrupt flag status This bit is set by hardware and read only by application. The bit is set when a read access occurs on an encrypted region, while its key registers is null or not properly initialized (KEYCRC = 0x0). This bit is cleared when the application sets in OTFDEC_ICR the corresponding bit to 1. After KEIF is set any subsequent read to the region with bad key registers returns a zeroed value. This state remains until those key registers are properly initialized (KEYCRC not zero).
        KEIF: u1,
        padding: u29 = 0,
    }),
    /// OTFDEC interrupt clear register.
    /// offset: 0x304
    ICR: mmio.Mmio(packed struct(u32) {
        /// Security error interrupt flag clear This bit is written by application, and always read as 0.
        SEIF: u1,
        /// Execute-only execute-never error interrupt flag clear This bit is written by application, and always read as 0.
        XONEIF: u1,
        /// Key error interrupt flag clear This bit is written by application, and always read as 0. Note: Clearing KEIF does not solve the source of the problem (bad key registers). To be able to access again any encrypted region, OTFDEC key registers must be properly initialized again.
        KEIF: u1,
        padding: u29 = 0,
    }),
    /// OTFDEC interrupt enable register.
    /// offset: 0x308
    IER: mmio.Mmio(packed struct(u32) {
        /// Security error interrupt enable This bit is read and written by application. It controls the OTFDEC interrupt generation when SEIF flag status is set.
        SEIE: u1,
        /// Execute-only execute-never error interrupt enable This bit is read and written by application. It controls the OTFDEC interrupt generation when XONEIF flag status is set.
        XONEIE: u1,
        /// Key error interrupt enable This bit is read and written by application. It controls the OTFDEC interrupt generation when KEIF flag status is set.
        KEIE: u1,
        padding: u29 = 0,
    }),
};

pub const Region = extern struct {
    /// OTFDEC region 3 configuration register.
    /// offset: 0x00
    CFGR: mmio.Mmio(packed struct(u32) {
        /// region on-the-fly decryption enable Note: Garbage is decrypted if region context (version, key, nonce) is not valid when this bit is set.
        REG_EN: u1,
        /// region config lock Note: This bit is set once. If this bit is set, it can only be reset to 0 if OTFDEC is reset. Setting this bit forces KEYLOCK bit to 1.
        CONFIGLOCK: u1,
        /// region key lock Note: This bit is set once: if this bit is set, it can only be reset to 0 if the OTFDEC is reset.
        KEYLOCK: u1,
        reserved4: u1 = 0,
        /// operating mode This bitfield selects the OTFDEC operating mode for this region: Others: Reserved When MODE ≠ 11, the standard AES encryption mode is activated. When either of the MODE bits are changed, the region key and associated CRC are zeroed.
        MODE: MODE,
        reserved8: u2 = 0,
        /// region key 8-bit CRC When KEYLOCK = 0, KEYCRC bitfield is automatically computed by hardware while loading the key of this region in this exact sequence: KEYR0 then KEYR1 then KEYR2 then finally KEYR3 (all written once). A new computation starts as soon as a new valid sequence is initiated, and KEYCRC is read as zero until a valid sequence is completed. When KEYLOCK = 1, KEYCRC remains unchanged until the next reset. CRC computation is an 8-bit checksum using the standard CRC-8-CCITT algorithm X8 + X2 + X + 1 (according the convention). Source code is available in . This field is read only. Note: CRC information is updated only after the last bit of the key has been written.
        KEYCRC: u8,
        /// region firmware version This 16-bit bitfield must be correctly initialized before the region corresponding REG_EN bit is set in OTFDEC_RxCFGR.
        REG_VERSION: u16,
    }),
    /// OTFDEC region 3 start address register.
    /// offset: 0x04
    STARTADDR: u32,
    /// OTFDEC region 3 end address register.
    /// offset: 0x08
    ENDADDR: u32,
    /// OTFDEC region 3 nonce register 0.
    /// offset: 0x0c
    NONCER: [2]u32,
    /// OTFDEC region 3 key register 0.
    /// offset: 0x14
    KEYR: [4]u32,
};
