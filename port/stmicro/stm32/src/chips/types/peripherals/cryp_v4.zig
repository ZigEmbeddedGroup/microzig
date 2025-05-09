const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const KMOD = enum(u2) {
    /// Normal-key mode. Key registers are freely usable.
    Normal = 0x0,
    /// Shared-key mode. If shared-key mode is properly initialized in SAES peripheral, the CRYP peripheral automatically loads its key registers with the data stored in the SAES key registers. The key value is available in CRYP key registers when BUSY bit is cleared and KEYVALID is set in the CRYP_SR register. Key error flag KERF is set otherwise in the CRYP_SR register.
    Shared = 0x2,
    _,
};

/// Cryptographic processor.
pub const CRYP = extern struct {
    /// control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Algorithm direction.
        ALGODIR: u1,
        /// Algorithm mode.
        ALGOMODE0: u3,
        /// Data type selection.
        DATATYPE: u2,
        /// Key size selection (AES mode only).
        KEYSIZE: u2,
        reserved14: u4 = 0,
        /// FIFO flush.
        FFLUSH: u1,
        /// Cryptographic processor enable.
        CRYPEN: u1,
        /// GCM_CCMPH.
        GCM_CCMPH: u2,
        reserved19: u1 = 0,
        /// ALGOMODE.
        ALGOMODE3: u1,
        /// Number of Padding Bytes in Last Block of payload.
        NPBLB: u4,
        /// Key mode selection This bitfield defines how the CRYP key can be used by the application. KEYSIZE must be correctly initialized when setting KMOD[1:0] different from zero. Others: Reserved Attempts to write the bitfield are ignored when BUSY is set.
        KMOD: KMOD,
        reserved31: u5 = 0,
        /// CRYP peripheral software reset Setting the bit resets the CRYP peripheral, putting all registers to their default values, except the IPRST bit itself. This bit must be kept cleared while writing any configuration registers.
        IPRST: u1,
    }),
    /// status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// Input FIFO empty.
        IFEM: u1,
        /// Input FIFO not full.
        IFNF: u1,
        /// Output FIFO not empty.
        OFNE: u1,
        /// Output FIFO full.
        OFFU: u1,
        /// Busy bit.
        BUSY: u1,
        reserved6: u1 = 0,
        /// Key error flag This read-only bit is set by hardware when key information failed to load into key registers. KERF is triggered upon any of the following errors: CRYP_KxR/LR register write does not respect the correct order (refer to Section 60.4.16: CRYP key registers for details). CRYP fails to load the key shared by SAES peripheral (KMOD = 0x2). KERF must be cleared by the application software, otherwise KEYVALID cannot be set. It can be done through IPRST bit of CRYP_CR, or when a correct key writing sequence starts.
        KERF: u1,
        /// Key valid flag This read-only bit is set by hardware when the key of size defined by KEYSIZE is loaded in CRYP_KxR/LR key registers. The CRYPEN bit can only be set when KEYVALID is set. In normal mode when KMOD[1:0] is at zero, the key must be written in the key registers in the correct sequence, otherwise the KERF flag is set and KEYVALID remains cleared. When KMOD[1:0] is different from zero, the BUSY flag is automatically set by CRYP. When the key is loaded successfully, BUSY is cleared and KEYVALID set. Upon an error, KERF is set, BUSY cleared and KEYVALID remains cleared. If set, KERF must be cleared, otherwise KEYVALID cannot be set. For further information on key loading, refer to Section 60.4.16: CRYP key registers.
        KEYVALID: u1,
        padding: u24 = 0,
    }),
    /// data input register.
    /// offset: 0x08
    DIN: u32,
    /// data output register.
    /// offset: 0x0c
    DOUT: u32,
    /// DMA control register.
    /// offset: 0x10
    DMACR: mmio.Mmio(packed struct(u32) {
        /// DMA input enable.
        DIEN: u1,
        /// DMA output enable.
        DOEN: u1,
        padding: u30 = 0,
    }),
    /// interrupt mask set/clear register.
    /// offset: 0x14
    IMSCR: mmio.Mmio(packed struct(u32) {
        /// Input FIFO service interrupt mask.
        INIM: u1,
        /// Output FIFO service interrupt mask.
        OUTIM: u1,
        padding: u30 = 0,
    }),
    /// raw interrupt status register.
    /// offset: 0x18
    RISR: mmio.Mmio(packed struct(u32) {
        /// Input FIFO service raw interrupt status.
        INRIS: u1,
        /// Output FIFO service raw interrupt status.
        OUTRIS: u1,
        padding: u30 = 0,
    }),
    /// masked interrupt status register.
    /// offset: 0x1c
    MISR: mmio.Mmio(packed struct(u32) {
        /// Input FIFO service masked interrupt status.
        INMIS: u1,
        /// Output FIFO service masked interrupt status.
        OUTMIS: u1,
        padding: u30 = 0,
    }),
    /// Cluster KEY%s, containing K?LR, K?RR.
    /// offset: 0x20
    KEY: u32,
    /// offset: 0x24
    reserved36: [28]u8,
    /// Cluster INIT%s, containing IV?LR, IV?RR.
    /// offset: 0x40
    INIT: u32,
    /// offset: 0x44
    reserved68: [12]u8,
    /// context swap register.
    /// offset: 0x50
    CSGCMCCMR: [8]u32,
    /// context swap register.
    /// offset: 0x70
    CSGCMR: [8]u32,
};

/// Cluster INIT%s, containing IV?LR, IV?RR.
pub const INIT = extern struct {
    /// initialization vector registers.
    /// offset: 0x00
    IVLR: u32,
    /// initialization vector registers.
    /// offset: 0x04
    IVRR: u32,
};

/// Cluster KEY%s, containing K?LR, K?RR.
pub const KEY = extern struct {
    /// key registers.
    /// offset: 0x00
    KLR: u32,
    /// key registers.
    /// offset: 0x04
    KRR: u32,
};
