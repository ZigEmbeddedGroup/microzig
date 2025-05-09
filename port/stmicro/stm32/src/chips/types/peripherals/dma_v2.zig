const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BURST = enum(u2) {
    /// Single transfer
    Single = 0x0,
    /// Incremental burst of 4 beats
    INCR4 = 0x1,
    /// Incremental burst of 8 beats
    INCR8 = 0x2,
    /// Incremental burst of 16 beats
    INCR16 = 0x3,
};

pub const CT = enum(u1) {
    /// The current target memory is Memory 0
    Memory0 = 0x0,
    /// The current target memory is Memory 1
    Memory1 = 0x1,
};

pub const DIR = enum(u2) {
    /// Peripheral-to-memory
    PeripheralToMemory = 0x0,
    /// Memory-to-peripheral
    MemoryToPeripheral = 0x1,
    /// Memory-to-memory
    MemoryToMemory = 0x2,
    _,
};

pub const DMDIS = enum(u1) {
    /// Direct mode is enabled
    Enabled = 0x0,
    /// Direct mode is disabled
    Disabled = 0x1,
};

pub const FS = enum(u3) {
    /// 0 < fifo_level < 1/4
    Quarter1 = 0x0,
    /// 1/4 <= fifo_level < 1/2
    Quarter2 = 0x1,
    /// 1/2 <= fifo_level < 3/4
    Quarter3 = 0x2,
    /// 3/4 <= fifo_level < full
    Quarter4 = 0x3,
    /// FIFO is empty
    Empty = 0x4,
    /// FIFO is full
    Full = 0x5,
    _,
};

pub const FTH = enum(u2) {
    /// 1/4 full FIFO
    Quarter = 0x0,
    /// 1/2 full FIFO
    Half = 0x1,
    /// 3/4 full FIFO
    ThreeQuarters = 0x2,
    /// Full FIFO
    Full = 0x3,
};

pub const PFCTRL = enum(u1) {
    /// The DMA is the flow controller
    DMA = 0x0,
    /// The peripheral is the flow controller
    Peripheral = 0x1,
};

pub const PINCOS = enum(u1) {
    /// The offset size for the peripheral address calculation is linked to the PSIZE
    PSIZE = 0x0,
    /// The offset size for the peripheral address calculation is fixed to 4 (32-bit alignment)
    Fixed4 = 0x1,
};

pub const PL = enum(u2) {
    /// Low
    Low = 0x0,
    /// Medium
    Medium = 0x1,
    /// High
    High = 0x2,
    /// Very high
    VeryHigh = 0x3,
};

pub const SIZE = enum(u2) {
    /// Byte (8-bit)
    Bits8 = 0x0,
    /// Half-word (16-bit)
    Bits16 = 0x1,
    /// Word (32-bit)
    Bits32 = 0x2,
    _,
};

/// DMA controller
pub const DMA = extern struct {
    /// low interrupt status register
    /// offset: 0x00
    ISR: [2]mmio.Mmio(packed struct(u32) {
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[0]": u1,
        reserved2: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[0]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[0]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[0]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[0]": u1,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[1]": u1,
        reserved8: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[1]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[1]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[1]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[1]": u1,
        reserved16: u4 = 0,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[2]": u1,
        reserved18: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[2]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[2]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[2]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[2]": u1,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[3]": u1,
        reserved24: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[3]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[3]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[3]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[3]": u1,
        padding: u4 = 0,
    }),
    /// low interrupt flag clear register
    /// offset: 0x08
    IFCR: [2]mmio.Mmio(packed struct(u32) {
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[0]": u1,
        reserved2: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[0]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[0]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[0]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[0]": u1,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[1]": u1,
        reserved8: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[1]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[1]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[1]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[1]": u1,
        reserved16: u4 = 0,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[2]": u1,
        reserved18: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[2]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[2]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[2]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[2]": u1,
        /// Stream x FIFO error interrupt flag (x=3..0)
        @"FEIF[3]": u1,
        reserved24: u1 = 0,
        /// Stream x direct mode error interrupt flag (x=3..0)
        @"DMEIF[3]": u1,
        /// Stream x transfer error interrupt flag (x=3..0)
        @"TEIF[3]": u1,
        /// Stream x half transfer interrupt flag (x=3..0)
        @"HTIF[3]": u1,
        /// Stream x transfer complete interrupt flag (x = 3..0)
        @"TCIF[3]": u1,
        padding: u4 = 0,
    }),
    /// Stream cluster: S?CR, S?NDTR, S?M0AR, S?M1AR and S?FCR registers
    /// offset: 0x10
    ST: u32,
};

/// Stream cluster: S?CR, S?NDTR, S?M0AR, S?M1AR and S?FCR registers
pub const ST = extern struct {
    /// stream x configuration register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Stream enable / flag stream ready when read low
        EN: u1,
        /// Direct mode error interrupt enable
        DMEIE: u1,
        /// Transfer error interrupt enable
        TEIE: u1,
        /// Half transfer interrupt enable
        HTIE: u1,
        /// Transfer complete interrupt enable
        TCIE: u1,
        /// Peripheral flow controller
        PFCTRL: PFCTRL,
        /// Data transfer direction
        DIR: DIR,
        /// Circular mode enabled
        CIRC: u1,
        /// Peripheral increment mode enabled
        PINC: u1,
        /// Memory increment mode enabled
        MINC: u1,
        /// Peripheral data size
        PSIZE: SIZE,
        /// Memory data size
        MSIZE: SIZE,
        /// Peripheral increment offset size
        PINCOS: PINCOS,
        /// Priority level
        PL: PL,
        /// Double buffer mode enabled
        DBM: u1,
        /// Current target (only in double buffer mode)
        CT: CT,
        reserved21: u1 = 0,
        /// Peripheral burst transfer configuration
        PBURST: BURST,
        /// Memory burst transfer configuration
        MBURST: BURST,
        /// Channel selection
        CHSEL: u4,
        padding: u3 = 0,
    }),
    /// stream x number of data register
    /// offset: 0x04
    NDTR: mmio.Mmio(packed struct(u32) {
        /// Number of data items to transfer
        NDT: u16,
        padding: u16 = 0,
    }),
    /// stream x peripheral address register
    /// offset: 0x08
    PAR: u32,
    /// stream x memory 0 address register
    /// offset: 0x0c
    M0AR: u32,
    /// stream x memory 1 address register
    /// offset: 0x10
    M1AR: u32,
    /// stream x FIFO control register
    /// offset: 0x14
    FCR: mmio.Mmio(packed struct(u32) {
        /// FIFO threshold selection
        FTH: FTH,
        /// Direct mode disable
        DMDIS: DMDIS,
        /// FIFO status
        FS: FS,
        reserved7: u1 = 0,
        /// FIFO error interrupt enable
        FEIE: u1,
        padding: u24 = 0,
    }),
};
