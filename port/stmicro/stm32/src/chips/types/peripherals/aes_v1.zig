const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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

pub const MODE = enum(u2) {
    /// Encryption
    Mode1 = 0x0,
    /// Key derivation (or key preparation for ECB/CBC decryption)
    Mode2 = 0x1,
    /// Decryption
    Mode3 = 0x2,
    /// Key derivation then single decryption
    Mode4 = 0x3,
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
        /// Chaining mode bit1 bit0
        CHMOD10: u2,
        /// Computation Complete Flag Clear
        CCFC: u1,
        /// Error clear
        ERRC: u1,
        /// CCF flag interrupt enable
        CCFIE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        /// Enable DMA management of data input phase
        DMAINEN: u1,
        /// Enable DMA management of data output phase
        DMAOUTEN: u1,
        padding: u19 = 0,
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
        padding: u29 = 0,
    }),
    /// Data input register
    /// offset: 0x08
    DINR: mmio.Mmio(packed struct(u32) {
        /// Input data word
        DIN: u32,
    }),
    /// Data output register
    /// offset: 0x0c
    DOUTR: mmio.Mmio(packed struct(u32) {
        /// Output data word
        DOUT: u32,
    }),
    /// Key register
    /// offset: 0x10
    KEYR: [4]mmio.Mmio(packed struct(u32) {
        /// Cryptographic key
        KEY: u32,
    }),
    /// Initialization vector register
    /// offset: 0x20
    IVR: [4]mmio.Mmio(packed struct(u32) {
        /// Initialization vector input
        IVI: u32,
    }),
};
