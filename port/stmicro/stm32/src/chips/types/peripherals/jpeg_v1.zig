const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// JPEG codec
pub const JPEG = extern struct {
    /// JPEG codec configuration register 0
    /// offset: 0x00
    JPEG_CONFR0: mmio.Mmio(packed struct(u32) {
        /// Start
        START: u1,
        padding: u31 = 0,
    }),
    /// JPEG codec configuration register 1
    /// offset: 0x04
    JPEG_CONFR1: mmio.Mmio(packed struct(u32) {
        /// Number of color components
        NF: u2,
        reserved3: u1 = 0,
        /// Decoding Enable
        DE: u1,
        /// Color Space
        COLORSPACE: u2,
        /// Number of components for Scan
        NS: u2,
        /// Header Processing
        HDR: u1,
        reserved16: u7 = 0,
        /// Y Size
        YSIZE: u16,
    }),
    /// JPEG codec configuration register 2
    /// offset: 0x08
    JPEG_CONFR2: mmio.Mmio(packed struct(u32) {
        /// Number of MCU
        NMCU: u26,
        padding: u6 = 0,
    }),
    /// JPEG codec configuration register 3
    /// offset: 0x0c
    JPEG_CONFR3: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// X size
        XSIZE: u16,
    }),
    /// JPEG codec configuration register 4
    /// offset: 0x10
    JPEG_CONFR4: mmio.Mmio(packed struct(u32) {
        /// Huffman DC
        HD: u1,
        /// Huffman AC
        HA: u1,
        /// Quantization Table
        QT: u2,
        /// Number of Block
        NB: u4,
        /// Vertical Sampling Factor
        VSF: u4,
        /// Horizontal Sampling Factor
        HSF: u4,
        padding: u16 = 0,
    }),
    /// JPEG codec configuration register 5
    /// offset: 0x14
    JPEG_CONFR5: mmio.Mmio(packed struct(u32) {
        /// Huffman DC
        HD: u1,
        /// Huffman AC
        HA: u1,
        /// Quantization Table
        QT: u2,
        /// Number of Block
        NB: u4,
        /// Vertical Sampling Factor
        VSF: u4,
        /// Horizontal Sampling Factor
        HSF: u4,
        padding: u16 = 0,
    }),
    /// JPEG codec configuration register 6
    /// offset: 0x18
    JPEG_CONFR6: mmio.Mmio(packed struct(u32) {
        /// Huffman DC
        HD: u1,
        /// Huffman AC
        HA: u1,
        /// Quantization Table
        QT: u2,
        /// Number of Block
        NB: u4,
        /// Vertical Sampling Factor
        VSF: u4,
        /// Horizontal Sampling Factor
        HSF: u4,
        padding: u16 = 0,
    }),
    /// JPEG codec configuration register 7
    /// offset: 0x1c
    JPEG_CONFR7: mmio.Mmio(packed struct(u32) {
        /// Huffman DC
        HD: u1,
        /// Huffman AC
        HA: u1,
        /// Quantization Table
        QT: u2,
        /// Number of Block
        NB: u4,
        /// Vertical Sampling Factor
        VSF: u4,
        /// Horizontal Sampling Factor
        HSF: u4,
        padding: u16 = 0,
    }),
    /// offset: 0x20
    reserved32: [16]u8,
    /// JPEG control register
    /// offset: 0x30
    JPEG_CR: mmio.Mmio(packed struct(u32) {
        /// JPEG Core Enable
        JCEN: u1,
        /// Input FIFO Threshold Interrupt Enable
        IFTIE: u1,
        /// Input FIFO Not Full Interrupt Enable
        IFNFIE: u1,
        /// Output FIFO Threshold Interrupt Enable
        OFTIE: u1,
        /// Output FIFO Not Empty Interrupt Enable
        OFNEIE: u1,
        /// End of Conversion Interrupt Enable
        EOCIE: u1,
        /// Header Parsing Done Interrupt Enable
        HPDIE: u1,
        reserved11: u4 = 0,
        /// Input DMA Enable
        IDMAEN: u1,
        /// Output DMA Enable
        ODMAEN: u1,
        /// Input FIFO Flush
        IFF: u1,
        /// Output FIFO Flush
        OFF: u1,
        padding: u17 = 0,
    }),
    /// JPEG status register
    /// offset: 0x34
    JPEG_SR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Input FIFO Threshold Flag
        IFTF: u1,
        /// Input FIFO Not Full Flag
        IFNFF: u1,
        /// Output FIFO Threshold Flag
        OFTF: u1,
        /// Output FIFO Not Empty Flag
        OFNEF: u1,
        /// End of Conversion Flag
        EOCF: u1,
        /// Header Parsing Done Flag
        HPDF: u1,
        /// Codec Operation Flag
        COF: u1,
        padding: u24 = 0,
    }),
    /// JPEG clear flag register
    /// offset: 0x38
    JPEG_CFR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Clear End of Conversion Flag
        CEOCF: u1,
        /// Clear Header Parsing Done Flag
        CHPDF: u1,
        padding: u25 = 0,
    }),
    /// offset: 0x3c
    reserved60: [4]u8,
    /// JPEG data input register
    /// offset: 0x40
    JPEG_DIR: mmio.Mmio(packed struct(u32) {
        /// Data Input FIFO
        DATAIN: u32,
    }),
    /// JPEG data output register
    /// offset: 0x44
    JPEG_DOR: mmio.Mmio(packed struct(u32) {
        /// Data Output FIFO
        DATAOUT: u32,
    }),
    /// offset: 0x48
    reserved72: [8]u8,
    /// JPEG quantization tables
    /// offset: 0x50
    QMEM0_0: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x54
    QMEM0_1: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x58
    QMEM0_2: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x5c
    QMEM0_3: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x60
    QMEM0_4: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x64
    QMEM0_5: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x68
    QMEM0_6: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x6c
    QMEM0_7: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x70
    QMEM0_8: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x74
    QMEM0_9: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x78
    QMEM0_10: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x7c
    QMEM0_11: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x80
    QMEM0_12: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x84
    QMEM0_13: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x88
    QMEM0_14: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x8c
    QMEM0_15: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x90
    QMEM1_0: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x94
    QMEM1_1: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x98
    QMEM1_2: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x9c
    QMEM1_3: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xa0
    QMEM1_4: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xa4
    QMEM1_5: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xa8
    QMEM1_6: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xac
    QMEM1_7: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xb0
    QMEM1_8: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xb4
    QMEM1_9: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xb8
    QMEM1_10: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xbc
    QMEM1_11: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xc0
    QMEM1_12: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xc4
    QMEM1_13: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xc8
    QMEM1_14: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xcc
    QMEM1_15: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xd0
    QMEM2_0: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xd4
    QMEM2_1: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xd8
    QMEM2_2: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xdc
    QMEM2_3: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xe0
    QMEM2_4: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xe4
    QMEM2_5: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xe8
    QMEM2_6: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xec
    QMEM2_7: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xf0
    QMEM2_8: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xf4
    QMEM2_9: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xf8
    QMEM2_10: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0xfc
    QMEM2_11: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x100
    QMEM2_12: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x104
    QMEM2_13: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x108
    QMEM2_14: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x10c
    QMEM2_15: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x110
    QMEM3_0: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x114
    QMEM3_1: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x118
    QMEM3_2: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x11c
    QMEM3_3: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x120
    QMEM3_4: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x124
    QMEM3_5: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x128
    QMEM3_6: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x12c
    QMEM3_7: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x130
    QMEM3_8: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x134
    QMEM3_9: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x138
    QMEM3_10: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x13c
    QMEM3_11: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x140
    QMEM3_12: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x144
    QMEM3_13: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x148
    QMEM3_14: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG quantization tables
    /// offset: 0x14c
    QMEM3_15: mmio.Mmio(packed struct(u32) {
        /// QMem RAM
        QMem_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x150
    HUFFMIN_0: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x154
    HUFFMIN_1: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x158
    HUFFMIN_2: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x15c
    HUFFMIN_3: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x160
    HUFFMIN_4: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x164
    HUFFMIN_5: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x168
    HUFFMIN_6: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x16c
    HUFFMIN_7: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x170
    HUFFMIN_8: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x174
    HUFFMIN_9: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x178
    HUFFMIN_10: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x17c
    HUFFMIN_11: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x180
    HUFFMIN_12: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x184
    HUFFMIN_13: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x188
    HUFFMIN_14: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffMin tables
    /// offset: 0x18c
    HUFFMIN_15: mmio.Mmio(packed struct(u32) {
        /// HuffMin RAM
        HuffMin_RAM: u32,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x190
    HUFFBASE0: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x194
    HUFFBASE1: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x198
    HUFFBASE2: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x19c
    HUFFBASE3: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1a0
    HUFFBASE4: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1a4
    HUFFBASE5: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1a8
    HUFFBASE6: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1ac
    HUFFBASE7: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1b0
    HUFFBASE8: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1b4
    HUFFBASE9: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1b8
    HUFFBASE10: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1bc
    HUFFBASE11: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1c0
    HUFFBASE12: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1c4
    HUFFBASE13: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1c8
    HUFFBASE14: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1cc
    HUFFBASE15: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1d0
    HUFFBASE16: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1d4
    HUFFBASE17: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1d8
    HUFFBASE18: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1dc
    HUFFBASE19: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1e0
    HUFFBASE20: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1e4
    HUFFBASE21: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1e8
    HUFFBASE22: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1ec
    HUFFBASE23: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1f0
    HUFFBASE24: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1f4
    HUFFBASE25: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1f8
    HUFFBASE26: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x1fc
    HUFFBASE27: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x200
    HUFFBASE28: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x204
    HUFFBASE29: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x208
    HUFFBASE30: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HuffSymb tables
    /// offset: 0x20c
    HUFFBASE31: mmio.Mmio(packed struct(u32) {
        /// HuffBase RAM
        HuffBase_RAM_0: u9,
        reserved16: u7 = 0,
        /// HuffBase RAM
        HuffBase_RAM_1: u9,
        padding: u7 = 0,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x210
    HUFFSYMB0: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x214
    HUFFSYMB1: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x218
    HUFFSYMB2: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x21c
    HUFFSYMB3: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x220
    HUFFSYMB4: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x224
    HUFFSYMB5: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x228
    HUFFSYMB6: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x22c
    HUFFSYMB7: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x230
    HUFFSYMB8: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x234
    HUFFSYMB9: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x238
    HUFFSYMB10: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x23c
    HUFFSYMB11: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x240
    HUFFSYMB12: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x244
    HUFFSYMB13: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x248
    HUFFSYMB14: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x24c
    HUFFSYMB15: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x250
    HUFFSYMB16: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x254
    HUFFSYMB17: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x258
    HUFFSYMB18: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x25c
    HUFFSYMB19: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x260
    HUFFSYMB20: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x264
    HUFFSYMB21: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x268
    HUFFSYMB22: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x26c
    HUFFSYMB23: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x270
    HUFFSYMB24: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x274
    HUFFSYMB25: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x278
    HUFFSYMB26: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x27c
    HUFFSYMB27: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x280
    HUFFSYMB28: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x284
    HUFFSYMB29: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x288
    HUFFSYMB30: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x28c
    HUFFSYMB31: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x290
    HUFFSYMB32: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x294
    HUFFSYMB33: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x298
    HUFFSYMB34: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x29c
    HUFFSYMB35: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2a0
    HUFFSYMB36: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2a4
    HUFFSYMB37: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2a8
    HUFFSYMB38: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2ac
    HUFFSYMB39: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2b0
    HUFFSYMB40: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2b4
    HUFFSYMB41: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2b8
    HUFFSYMB42: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2bc
    HUFFSYMB43: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2c0
    HUFFSYMB44: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2c4
    HUFFSYMB45: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2c8
    HUFFSYMB46: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2cc
    HUFFSYMB47: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2d0
    HUFFSYMB48: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2d4
    HUFFSYMB49: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2d8
    HUFFSYMB50: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2dc
    HUFFSYMB51: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2e0
    HUFFSYMB52: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2e4
    HUFFSYMB53: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2e8
    HUFFSYMB54: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2ec
    HUFFSYMB55: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2f0
    HUFFSYMB56: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2f4
    HUFFSYMB57: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2f8
    HUFFSYMB58: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x2fc
    HUFFSYMB59: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x300
    HUFFSYMB60: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x304
    HUFFSYMB61: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x308
    HUFFSYMB62: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x30c
    HUFFSYMB63: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x310
    HUFFSYMB64: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x314
    HUFFSYMB65: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x318
    HUFFSYMB66: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x31c
    HUFFSYMB67: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x320
    HUFFSYMB68: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x324
    HUFFSYMB69: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x328
    HUFFSYMB70: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x32c
    HUFFSYMB71: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x330
    HUFFSYMB72: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x334
    HUFFSYMB73: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x338
    HUFFSYMB74: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x33c
    HUFFSYMB75: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x340
    HUFFSYMB76: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x344
    HUFFSYMB77: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x348
    HUFFSYMB78: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x34c
    HUFFSYMB79: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x350
    HUFFSYMB80: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x354
    HUFFSYMB81: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x358
    HUFFSYMB82: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG HUFFSYMB tables
    /// offset: 0x35c
    HUFFSYMB83: mmio.Mmio(packed struct(u32) {
        /// DHTSymb RAM
        HuffSymb_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x360
    DHTMEM0: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x364
    DHTMEM2: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x368
    DHTMEM3: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x36c
    DHTMEM4: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x370
    DHTMEM5: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x374
    DHTMEM6: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x378
    DHTMEM7: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x37c
    DHTMEM8: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x380
    DHTMEM9: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x384
    DHTMEM10: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x388
    DHTMEM11: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x38c
    DHTMEM12: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x390
    DHTMEM13: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x394
    DHTMEM14: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x398
    DHTMEM15: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x39c
    DHTMEM16: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3a0
    DHTMEM17: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3a4
    DHTMEM18: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3a8
    DHTMEM19: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3ac
    DHTMEM20: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3b0
    DHTMEM21: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3b4
    DHTMEM22: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3b8
    DHTMEM23: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3bc
    DHTMEM24: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3c0
    DHTMEM25: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3c4
    DHTMEM26: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3c8
    DHTMEM27: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3cc
    DHTMEM28: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3d0
    DHTMEM29: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3d4
    DHTMEM30: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3d8
    DHTMEM31: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3dc
    DHTMEM32: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3e0
    DHTMEM33: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3e4
    DHTMEM34: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3e8
    DHTMEM35: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3ec
    DHTMEM36: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3f0
    DHTMEM37: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3f4
    DHTMEM38: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3f8
    DHTMEM39: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x3fc
    DHTMEM40: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x400
    DHTMEM41: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x404
    DHTMEM42: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x408
    DHTMEM43: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x40c
    DHTMEM44: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x410
    DHTMEM45: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x414
    DHTMEM46: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x418
    DHTMEM47: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x41c
    DHTMEM48: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x420
    DHTMEM49: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x424
    DHTMEM50: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x428
    DHTMEM51: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x42c
    DHTMEM52: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x430
    DHTMEM53: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x434
    DHTMEM54: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x438
    DHTMEM55: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x43c
    DHTMEM56: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x440
    DHTMEM57: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x444
    DHTMEM58: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x448
    DHTMEM59: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x44c
    DHTMEM60: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x450
    DHTMEM61: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x454
    DHTMEM62: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x458
    DHTMEM63: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x45c
    DHTMEM64: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x460
    DHTMEM65: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x464
    DHTMEM66: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x468
    DHTMEM67: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x46c
    DHTMEM68: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x470
    DHTMEM69: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x474
    DHTMEM70: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x478
    DHTMEM71: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x47c
    DHTMEM72: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x480
    DHTMEM73: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x484
    DHTMEM74: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x488
    DHTMEM75: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x48c
    DHTMEM76: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x490
    DHTMEM77: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x494
    DHTMEM78: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x498
    DHTMEM79: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x49c
    DHTMEM80: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4a0
    DHTMEM81: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4a4
    DHTMEM82: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4a8
    DHTMEM83: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4ac
    DHTMEM84: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4b0
    DHTMEM85: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4b4
    DHTMEM86: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4b8
    DHTMEM87: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4bc
    DHTMEM88: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4c0
    DHTMEM89: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4c4
    DHTMEM90: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4c8
    DHTMEM91: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4cc
    DHTMEM92: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4d0
    DHTMEM93: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4d4
    DHTMEM94: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4d8
    DHTMEM95: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4dc
    DHTMEM96: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4e0
    DHTMEM97: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4e4
    DHTMEM98: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4e8
    DHTMEM99: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4ec
    DHTMEM100: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4f0
    DHTMEM101: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4f4
    DHTMEM102: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG DHTMem tables
    /// offset: 0x4f8
    DHTMEM103: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// offset: 0x4fc
    reserved1276: [4]u8,
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x500
    HUFFENC_AC0_0: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x504
    HUFFENC_AC0_1: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x508
    HUFFENC_AC0_2: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x50c
    HUFFENC_AC0_3: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x510
    HUFFENC_AC0_4: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x514
    HUFFENC_AC0_5: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x518
    HUFFENC_AC0_6: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x51c
    HUFFENC_AC0_7: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x520
    HUFFENC_AC0_8: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x524
    HUFFENC_AC0_9: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x528
    HUFFENC_AC0_10: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x52c
    HUFFENC_AC0_11: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x530
    HUFFENC_AC0_12: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x534
    HUFFENC_AC0_13: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x538
    HUFFENC_AC0_14: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x53c
    HUFFENC_AC0_15: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x540
    HUFFENC_AC0_16: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x544
    HUFFENC_AC0_17: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x548
    HUFFENC_AC0_18: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x54c
    HUFFENC_AC0_19: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x550
    HUFFENC_AC0_20: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x554
    HUFFENC_AC0_21: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x558
    HUFFENC_AC0_22: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x55c
    HUFFENC_AC0_23: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x560
    HUFFENC_AC0_24: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x564
    HUFFENC_AC0_25: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x568
    HUFFENC_AC0_26: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x56c
    HUFFENC_AC0_27: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x570
    HUFFENC_AC0_28: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x574
    HUFFENC_AC0_29: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x578
    HUFFENC_AC0_30: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x57c
    HUFFENC_AC0_31: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x580
    HUFFENC_AC0_32: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x584
    HUFFENC_AC0_33: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x588
    HUFFENC_AC0_34: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x58c
    HUFFENC_AC0_35: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x590
    HUFFENC_AC0_36: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x594
    HUFFENC_AC0_37: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x598
    HUFFENC_AC0_38: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x59c
    HUFFENC_AC0_39: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5a0
    HUFFENC_AC0_40: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5a4
    HUFFENC_AC0_41: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5a8
    HUFFENC_AC0_42: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5ac
    HUFFENC_AC0_43: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5b0
    HUFFENC_AC0_44: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5b4
    HUFFENC_AC0_45: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5b8
    HUFFENC_AC0_46: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5bc
    HUFFENC_AC0_47: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5c0
    HUFFENC_AC0_48: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5c4
    HUFFENC_AC0_49: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5c8
    HUFFENC_AC0_50: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5cc
    HUFFENC_AC0_51: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5d0
    HUFFENC_AC0_52: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5d4
    HUFFENC_AC0_53: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5d8
    HUFFENC_AC0_54: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5dc
    HUFFENC_AC0_55: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5e0
    HUFFENC_AC0_56: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5e4
    HUFFENC_AC0_57: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5e8
    HUFFENC_AC0_58: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5ec
    HUFFENC_AC0_59: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5f0
    HUFFENC_AC0_60: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5f4
    HUFFENC_AC0_61: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5f8
    HUFFENC_AC0_62: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x5fc
    HUFFENC_AC0_63: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x600
    HUFFENC_AC0_64: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x604
    HUFFENC_AC0_65: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x608
    HUFFENC_AC0_66: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x60c
    HUFFENC_AC0_67: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x610
    HUFFENC_AC0_68: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x614
    HUFFENC_AC0_69: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x618
    HUFFENC_AC0_70: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x61c
    HUFFENC_AC0_71: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x620
    HUFFENC_AC0_72: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x624
    HUFFENC_AC0_73: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x628
    HUFFENC_AC0_74: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x62c
    HUFFENC_AC0_75: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x630
    HUFFENC_AC0_76: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x634
    HUFFENC_AC0_77: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x638
    HUFFENC_AC0_78: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x63c
    HUFFENC_AC0_79: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x640
    HUFFENC_AC0_80: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x644
    HUFFENC_AC0_81: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x648
    HUFFENC_AC0_82: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x64c
    HUFFENC_AC0_83: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x650
    HUFFENC_AC0_84: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x654
    HUFFENC_AC0_85: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x658
    HUFFENC_AC0_86: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 0
    /// offset: 0x65c
    HUFFENC_AC0_87: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x660
    HUFFENC_AC1_0: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x664
    HUFFENC_AC1_1: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x668
    HUFFENC_AC1_2: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x66c
    HUFFENC_AC1_3: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x670
    HUFFENC_AC1_4: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x674
    HUFFENC_AC1_5: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x678
    HUFFENC_AC1_6: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x67c
    HUFFENC_AC1_7: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x680
    HUFFENC_AC1_8: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x684
    HUFFENC_AC1_9: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x688
    HUFFENC_AC1_10: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x68c
    HUFFENC_AC1_11: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x690
    HUFFENC_AC1_12: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x694
    HUFFENC_AC1_13: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x698
    HUFFENC_AC1_14: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x69c
    HUFFENC_AC1_15: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6a0
    HUFFENC_AC1_16: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6a4
    HUFFENC_AC1_17: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6a8
    HUFFENC_AC1_18: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6ac
    HUFFENC_AC1_19: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6b0
    HUFFENC_AC1_20: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6b4
    HUFFENC_AC1_21: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6b8
    HUFFENC_AC1_22: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6bc
    HUFFENC_AC1_23: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6c0
    HUFFENC_AC1_24: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6c4
    HUFFENC_AC1_25: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6c8
    HUFFENC_AC1_26: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6cc
    HUFFENC_AC1_27: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6d0
    HUFFENC_AC1_28: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6d4
    HUFFENC_AC1_29: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6d8
    HUFFENC_AC1_30: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6dc
    HUFFENC_AC1_31: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6e0
    HUFFENC_AC1_32: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6e4
    HUFFENC_AC1_33: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6e8
    HUFFENC_AC1_34: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6ec
    HUFFENC_AC1_35: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6f0
    HUFFENC_AC1_36: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6f4
    HUFFENC_AC1_37: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6f8
    HUFFENC_AC1_38: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x6fc
    HUFFENC_AC1_39: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x700
    HUFFENC_AC1_40: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x704
    HUFFENC_AC1_41: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x708
    HUFFENC_AC1_42: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x70c
    HUFFENC_AC1_43: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x710
    HUFFENC_AC1_44: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x714
    HUFFENC_AC1_45: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x718
    HUFFENC_AC1_46: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x71c
    HUFFENC_AC1_47: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x720
    HUFFENC_AC1_48: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x724
    HUFFENC_AC1_49: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x728
    HUFFENC_AC1_50: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x72c
    HUFFENC_AC1_51: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x730
    HUFFENC_AC1_52: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x734
    HUFFENC_AC1_53: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x738
    HUFFENC_AC1_54: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x73c
    HUFFENC_AC1_55: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x740
    HUFFENC_AC1_56: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x744
    HUFFENC_AC1_57: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x748
    HUFFENC_AC1_58: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x74c
    HUFFENC_AC1_59: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x750
    HUFFENC_AC1_60: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x754
    HUFFENC_AC1_61: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x758
    HUFFENC_AC1_62: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x75c
    HUFFENC_AC1_63: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x760
    HUFFENC_AC1_64: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x764
    HUFFENC_AC1_65: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x768
    HUFFENC_AC1_66: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x76c
    HUFFENC_AC1_67: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x770
    HUFFENC_AC1_68: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x774
    HUFFENC_AC1_69: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x778
    HUFFENC_AC1_70: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x77c
    HUFFENC_AC1_71: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x780
    HUFFENC_AC1_72: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x784
    HUFFENC_AC1_73: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x788
    HUFFENC_AC1_74: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x78c
    HUFFENC_AC1_75: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x790
    HUFFENC_AC1_76: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x794
    HUFFENC_AC1_77: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x798
    HUFFENC_AC1_78: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x79c
    HUFFENC_AC1_79: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7a0
    HUFFENC_AC1_80: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7a4
    HUFFENC_AC1_81: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7a8
    HUFFENC_AC1_82: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7ac
    HUFFENC_AC1_83: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7b0
    HUFFENC_AC1_84: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7b4
    HUFFENC_AC1_85: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7b8
    HUFFENC_AC1_86: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, AC Huffman table 1
    /// offset: 0x7bc
    HUFFENC_AC1_87: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7c0
    HUFFENC_DC0_0: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7c4
    HUFFENC_DC0_1: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7c8
    HUFFENC_DC0_2: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7cc
    HUFFENC_DC0_3: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7d0
    HUFFENC_DC0_4: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7d4
    HUFFENC_DC0_5: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7d8
    HUFFENC_DC0_6: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 0
    /// offset: 0x7dc
    HUFFENC_DC0_7: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7e0
    HUFFENC_DC1_0: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7e4
    HUFFENC_DC1_1: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7e8
    HUFFENC_DC1_2: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7ec
    HUFFENC_DC1_3: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7f0
    HUFFENC_DC1_4: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7f4
    HUFFENC_DC1_5: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7f8
    HUFFENC_DC1_6: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
    /// JPEG encoder, DC Huffman table 1
    /// offset: 0x7fc
    HUFFENC_DC1_7: mmio.Mmio(packed struct(u32) {
        /// DHTMem RAM
        DHTMem_RAM: u32,
    }),
};
