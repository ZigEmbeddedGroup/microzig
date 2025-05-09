const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

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
        padding: u8 = 0,
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
        padding: u27 = 0,
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
