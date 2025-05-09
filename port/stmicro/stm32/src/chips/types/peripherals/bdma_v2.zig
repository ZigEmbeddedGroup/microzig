const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const DIR = enum(u1) {
    /// Read from peripheral
    FromPeripheral = 0x0,
    /// Read from memory
    FromMemory = 0x1,
};

pub const PL = enum(u2) {
    /// Low priority
    Low = 0x0,
    /// Medium priority
    Medium = 0x1,
    /// High priority
    High = 0x2,
    /// Very high priority
    VeryHigh = 0x3,
};

pub const SIZE = enum(u2) {
    /// 8-bit size
    Bits8 = 0x0,
    /// 16-bit size
    Bits16 = 0x1,
    /// 32-bit size
    Bits32 = 0x2,
    _,
};

/// Channel cluster: CCR?, CNDTR?, CPAR?, and CMAR? registers
pub const CH = extern struct {
    /// DMA channel configuration register (DMA_CCR)
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Channel enable
        EN: u1,
        /// Transfer complete interrupt enable
        TCIE: u1,
        /// Half Transfer interrupt enable
        HTIE: u1,
        /// Transfer error interrupt enable
        TEIE: u1,
        /// Data transfer direction
        DIR: DIR,
        /// Circular mode enabled
        CIRC: u1,
        /// Peripheral increment mode enabled
        PINC: u1,
        /// Memory increment mode enabled
        MINC: u1,
        /// Peripheral size
        PSIZE: SIZE,
        /// Memory size
        MSIZE: SIZE,
        /// Channel Priority level
        PL: PL,
        /// Memory to memory mode enabled
        MEM2MEM: u1,
        padding: u17 = 0,
    }),
    /// DMA channel 1 number of data register
    /// offset: 0x04
    NDTR: mmio.Mmio(packed struct(u32) {
        /// Number of data to transfer
        NDT: u16,
        padding: u16 = 0,
    }),
    /// DMA channel 1 peripheral address register
    /// offset: 0x08
    PAR: u32,
    /// DMA channel 1 memory address register
    /// offset: 0x0c
    MAR: u32,
};

/// DMA controller
pub const DMA = extern struct {
    /// DMA interrupt status register (DMA_ISR)
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[0]": u1,
        /// (1/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[0]": u1,
        /// (1/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[0]": u1,
        /// (1/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[0]": u1,
        /// (2/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[1]": u1,
        /// (2/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[1]": u1,
        /// (2/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[1]": u1,
        /// (2/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[1]": u1,
        /// (3/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[2]": u1,
        /// (3/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[2]": u1,
        /// (3/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[2]": u1,
        /// (3/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[2]": u1,
        /// (4/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[3]": u1,
        /// (4/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[3]": u1,
        /// (4/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[3]": u1,
        /// (4/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[3]": u1,
        /// (5/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[4]": u1,
        /// (5/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[4]": u1,
        /// (5/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[4]": u1,
        /// (5/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[4]": u1,
        /// (6/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[5]": u1,
        /// (6/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[5]": u1,
        /// (6/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[5]": u1,
        /// (6/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[5]": u1,
        /// (7/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[6]": u1,
        /// (7/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[6]": u1,
        /// (7/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[6]": u1,
        /// (7/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[6]": u1,
        /// (8/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[7]": u1,
        /// (8/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[7]": u1,
        /// (8/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[7]": u1,
        /// (8/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[7]": u1,
    }),
    /// DMA interrupt flag clear register (DMA_IFCR)
    /// offset: 0x04
    IFCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[0]": u1,
        /// (1/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[0]": u1,
        /// (1/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[0]": u1,
        /// (1/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[0]": u1,
        /// (2/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[1]": u1,
        /// (2/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[1]": u1,
        /// (2/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[1]": u1,
        /// (2/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[1]": u1,
        /// (3/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[2]": u1,
        /// (3/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[2]": u1,
        /// (3/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[2]": u1,
        /// (3/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[2]": u1,
        /// (4/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[3]": u1,
        /// (4/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[3]": u1,
        /// (4/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[3]": u1,
        /// (4/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[3]": u1,
        /// (5/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[4]": u1,
        /// (5/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[4]": u1,
        /// (5/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[4]": u1,
        /// (5/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[4]": u1,
        /// (6/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[5]": u1,
        /// (6/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[5]": u1,
        /// (6/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[5]": u1,
        /// (6/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[5]": u1,
        /// (7/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[6]": u1,
        /// (7/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[6]": u1,
        /// (7/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[6]": u1,
        /// (7/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[6]": u1,
        /// (8/8 of GIF) Channel 1 Global interrupt flag
        @"GIF[7]": u1,
        /// (8/8 of TCIF) Channel 1 Transfer Complete flag
        @"TCIF[7]": u1,
        /// (8/8 of HTIF) Channel 1 Half Transfer Complete flag
        @"HTIF[7]": u1,
        /// (8/8 of TEIF) Channel 1 Transfer Error flag
        @"TEIF[7]": u1,
    }),
    /// Channel cluster: CCR?, CNDTR?, CPAR?, and CMAR? registers
    /// offset: 0x08
    CH: u32,
    /// offset: 0x0c
    reserved12: [156]u8,
    /// channel selection register
    /// offset: 0xa8
    CSELR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CS) DMA channel selection
        @"CS[0]": u4,
        /// (2/8 of CS) DMA channel selection
        @"CS[1]": u4,
        /// (3/8 of CS) DMA channel selection
        @"CS[2]": u4,
        /// (4/8 of CS) DMA channel selection
        @"CS[3]": u4,
        /// (5/8 of CS) DMA channel selection
        @"CS[4]": u4,
        /// (6/8 of CS) DMA channel selection
        @"CS[5]": u4,
        /// (7/8 of CS) DMA channel selection
        @"CS[6]": u4,
        /// (8/8 of CS) DMA channel selection
        @"CS[7]": u4,
    }),
};
