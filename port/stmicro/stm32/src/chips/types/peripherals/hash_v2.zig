const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Hash processor.
pub const HASH = extern struct {
    /// control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Initialize message digest calculation.
        INIT: u1,
        /// DMA enable.
        DMAE: u1,
        /// Data type selection.
        DATATYPE: u2,
        /// Mode selection.
        MODE: u1,
        /// Algorithm selection.
        ALGO0: u1,
        /// Number of words already pushed.
        NBW: u4,
        /// DIN not empty.
        DINNE: u1,
        /// Multiple DMA Transfers.
        MDMAT: u1,
        reserved16: u2 = 0,
        /// Long key selection.
        LKEY: u1,
        reserved18: u1 = 0,
        /// ALGO.
        ALGO1: u1,
        padding: u13 = 0,
    }),
    /// data input register.
    /// offset: 0x04
    DIN: u32,
    /// start register.
    /// offset: 0x08
    STR: mmio.Mmio(packed struct(u32) {
        /// Number of valid bits in the last word of the message.
        NBLW: u5,
        reserved8: u3 = 0,
        /// Digest calculation.
        DCAL: u1,
        padding: u23 = 0,
    }),
    /// digest registers.
    /// offset: 0x0c
    HRA: [5]u32,
    /// interrupt enable register.
    /// offset: 0x20
    IMR: mmio.Mmio(packed struct(u32) {
        /// Data input interrupt enable.
        DINIE: u1,
        /// Digest calculation completion interrupt enable.
        DCIE: u1,
        padding: u30 = 0,
    }),
    /// status register.
    /// offset: 0x24
    SR: mmio.Mmio(packed struct(u32) {
        /// Data input interrupt status.
        DINIS: u1,
        /// Digest calculation completion interrupt status.
        DCIS: u1,
        /// DMA Status.
        DMAS: u1,
        /// Busy bit.
        BUSY: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x28
    reserved40: [208]u8,
    /// context swap registers.
    /// offset: 0xf8
    CSR: [54]u32,
    /// offset: 0x1d0
    reserved464: [320]u8,
    /// HASH digest register.
    /// offset: 0x310
    HR: [8]u32,
};
