const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const CHMOD = enum(u3) {
    /// Electronic codebook
    ECB = 0x0,
    /// Cipher-block chaining
    CBC = 0x1,
    /// Counter mode
    CTR = 0x2,
    /// Galois counter mode and Galois message authentication code
    GCM_GMAC = 0x3,
    /// Counter with CBC-MAC
    CCM = 0x4,
    _,
};

pub const DATATYPE = enum(u2) {
    /// Word
    None = 0x0,
    /// Half-word (16-bit)
    HalfWord = 0x1,
    /// Byte (8-bit)
    Byte = 0x2,
    /// Bit
    Bit = 0x3,
};

pub const GCMPH = enum(u2) {
    /// Init phase
    @"Init phase" = 0x0,
    /// Header phase
    @"Header phase" = 0x1,
    /// Payload phase
    @"Payload phase" = 0x2,
    /// Final phase
    @"Final phase" = 0x3,
};

pub const MODE = enum(u2) {
    /// Encryption
    Mode1 = 0x0,
    /// Key derivation (or key preparation for ECB/CBC decryption)
    Mode2 = 0x1,
    /// Decryption
    Mode3 = 0x2,
    _,
};

/// Advanced encryption standard hardware accelerator
pub const AES = extern struct {
    /// Control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// AES enable
        EN: u1,
        /// Data type selection
        DATATYPE: DATATYPE,
        /// Operating mode
        MODE: MODE,
        /// Chaining mode selection
        CHMOD: u2,
        reserved11: u4 = 0,
        /// Enable DMA management of data input phase
        DMAINEN: u1,
        /// Enable DMA management of data output phase
        DMAOUTEN: u1,
        /// GCM or CCM phase selection
        GCMPH: GCMPH,
        reserved16: u1 = 0,
        /// Chaining mode selection
        CHMOD_CONT: u1,
        reserved18: u1 = 0,
        /// Key size selection
        KEYSIZE: u1,
        reserved20: u1 = 0,
        /// Number of padding bytes in last block of payload
        NPBLB: u4,
        /// Key mode selection
        KMOD: u2,
        reserved31: u5 = 0,
        /// AES peripheral software reset
        IPRST: u1,
    }),
    /// Status register
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// Computation complete flag
        CCF: u1,
        /// Read error flag
        RDERR: u1,
        /// Write error flag
        WRERR: u1,
        /// Busy flag
        BUSY: u1,
        reserved7: u3 = 0,
        /// Key valid flag
        KEYVALID: u1,
        padding: u24 = 0,
    }),
    /// Data input register
    /// offset: 0x08
    DINR: u32,
    /// Data output register
    /// offset: 0x0c
    DOUTR: u32,
    /// Key register
    /// offset: 0x10
    KEYR: u32,
    /// offset: 0x14
    reserved20: [12]u8,
    /// Initialization vector register
    /// offset: 0x20
    IVR: [4]u32,
    /// offset: 0x30
    reserved48: [16]u8,
    /// Suspend register
    /// offset: 0x40
    SUSPR: [8]u32,
    /// offset: 0x60
    reserved96: [672]u8,
    /// interrupt enable register
    /// offset: 0x300
    IER: mmio.Mmio(packed struct(u32) {
        /// Computation complete flag interrupt enable
        CCFIE: u1,
        /// Read or write error interrupt enable
        RWEIE: u1,
        /// Key error interrupt enable
        KEIE: u1,
        padding: u29 = 0,
    }),
    /// interrupt status register
    /// offset: 0x304
    ISR: mmio.Mmio(packed struct(u32) {
        /// Computation complete flag
        CCF: u1,
        /// Read or write error interrupt flag
        RWEIF: u1,
        /// Key error interrupt flag
        KEIF: u1,
        padding: u29 = 0,
    }),
    /// interrupt clear register
    /// offset: 0x308
    ICR: mmio.Mmio(packed struct(u32) {
        /// Computation complete flag clear
        CCF: u1,
        /// Read or write error interrupt flag clear
        RWEIF: u1,
        /// Key error interrupt flag clear
        KEIF: u1,
        padding: u29 = 0,
    }),
};
