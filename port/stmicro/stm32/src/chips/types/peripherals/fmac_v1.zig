const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Filter math accelerator
pub const FMAC = extern struct {
    /// X1 buffer configuration register
    /// offset: 0x00
    X1BUFCFG: mmio.Mmio(packed struct(u32) {
        /// Base address of X1 buffer
        X1_BASE: u8,
        /// Allocated size of X1 buffer in 16-bit words
        X1_BUF_SIZE: u8,
        reserved24: u8 = 0,
        /// Watermark for buffer full flag
        FULL_WM: u2,
        padding: u6 = 0,
    }),
    /// X2 buffer configuration register
    /// offset: 0x04
    X2BUFCFG: mmio.Mmio(packed struct(u32) {
        /// Base address of X2 buffer
        X2_BASE: u8,
        /// Size of X2 buffer in 16-bit words
        X2_BUF_SIZE: u8,
        padding: u16 = 0,
    }),
    /// Y buffer configuration register
    /// offset: 0x08
    YBUFCFG: mmio.Mmio(packed struct(u32) {
        /// Base address of Y buffer
        Y_BASE: u8,
        /// Size of Y buffer in 16-bit words
        Y_BUF_SIZE: u8,
        reserved24: u8 = 0,
        /// Watermark for buffer empty flag
        EMPTY_WM: u2,
        padding: u6 = 0,
    }),
    /// Parameter register
    /// offset: 0x0c
    PARAM: mmio.Mmio(packed struct(u32) {
        /// Input parameter P
        P: u8,
        /// Input parameter Q
        Q: u8,
        /// Input parameter R
        R: u8,
        /// Function
        FUNC: u7,
        /// Enable execution
        START: u1,
    }),
    /// Control register
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// Enable read interrupt
        RIEN: u1,
        /// Enable write interrupt
        WIEN: u1,
        /// Enable overflow error interrupts
        OVFLIEN: u1,
        /// Enable underflow error interrupts
        UNFLIEN: u1,
        /// Enable saturation error interrupts
        SATIEN: u1,
        reserved8: u3 = 0,
        /// Enable DMA read channel requests
        DMAREN: u1,
        /// Enable DMA write channel requests
        DMAWEN: u1,
        reserved15: u5 = 0,
        /// Enable clipping
        CLIPEN: u1,
        /// Reset FMAC unit
        RESET: u1,
        padding: u15 = 0,
    }),
    /// Status register
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Y buffer empty flag
        YEMPTY: u1,
        /// X1 buffer full flag
        X1FULL: u1,
        reserved8: u6 = 0,
        /// Overflow error flag
        OVFL: u1,
        /// Underflow error flag
        UNFL: u1,
        /// Saturation error flag
        SAT: u1,
        padding: u21 = 0,
    }),
    /// Write data register
    /// offset: 0x18
    WDATA: mmio.Mmio(packed struct(u32) {
        /// Write data (write data are transferred to the address indicated by the write pointer)
        WDATA: u16,
        padding: u16 = 0,
    }),
    /// Read data register
    /// offset: 0x1c
    RDATA: mmio.Mmio(packed struct(u32) {
        /// Read data (contents of the Y output buffer at the address indicated by the READ pointer)
        RES: u16,
        padding: u16 = 0,
    }),
};
