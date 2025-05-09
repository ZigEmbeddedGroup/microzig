const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ABORT = enum(u1) {
    /// Transfer abort requested
    AbortRequest = 0x1,
    _,
};

pub const BGPFCCR_AM = enum(u2) {
    /// No modification of alpha channel
    NoModify = 0x0,
    /// Replace with value in ALPHA[7:0]
    Replace = 0x1,
    /// Multiply with value in ALPHA[7:0]
    Multiply = 0x2,
    _,
};

pub const BGPFCCR_CCM = enum(u1) {
    /// CLUT color format ARGB8888
    ARGB8888 = 0x0,
    /// CLUT color format RGB888
    RGB888 = 0x1,
};

pub const BGPFCCR_CM = enum(u4) {
    /// Color mode ARGB8888
    ARGB8888 = 0x0,
    /// Color mode RGB888
    RGB888 = 0x1,
    /// Color mode RGB565
    RGB565 = 0x2,
    /// Color mode ARGB1555
    ARGB1555 = 0x3,
    /// Color mode ARGB4444
    ARGB4444 = 0x4,
    /// Color mode L8
    L8 = 0x5,
    /// Color mode AL44
    AL44 = 0x6,
    /// Color mode AL88
    AL88 = 0x7,
    /// Color mode L4
    L4 = 0x8,
    /// Color mode A8
    A8 = 0x9,
    /// Color mode A4
    A4 = 0xa,
    _,
};

pub const BGPFCCR_START = enum(u1) {
    /// Start the automatic loading of the CLUT
    Start = 0x1,
    _,
};

pub const CAECIF = enum(u1) {
    /// Clear the CAEIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CCEIF = enum(u1) {
    /// Clear the CEIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CCTCIF = enum(u1) {
    /// Clear the CTCIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CR_START = enum(u1) {
    /// Launch the DMA2D
    Start = 0x1,
    _,
};

pub const CTCIF = enum(u1) {
    /// Clear the TCIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CTEIF = enum(u1) {
    /// Clear the TEIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CTWIF = enum(u1) {
    /// Clear the TWIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const FGPFCCR_AM = enum(u2) {
    /// No modification of alpha channel
    NoModify = 0x0,
    /// Replace with value in ALPHA[7:0]
    Replace = 0x1,
    /// Multiply with value in ALPHA[7:0]
    Multiply = 0x2,
    _,
};

pub const FGPFCCR_CCM = enum(u1) {
    /// CLUT color format ARGB8888
    ARGB8888 = 0x0,
    /// CLUT color format RGB888
    RGB888 = 0x1,
};

pub const FGPFCCR_CM = enum(u4) {
    /// Color mode ARGB8888
    ARGB8888 = 0x0,
    /// Color mode RGB888
    RGB888 = 0x1,
    /// Color mode RGB565
    RGB565 = 0x2,
    /// Color mode ARGB1555
    ARGB1555 = 0x3,
    /// Color mode ARGB4444
    ARGB4444 = 0x4,
    /// Color mode L8
    L8 = 0x5,
    /// Color mode AL44
    AL44 = 0x6,
    /// Color mode AL88
    AL88 = 0x7,
    /// Color mode L4
    L4 = 0x8,
    /// Color mode A8
    A8 = 0x9,
    /// Color mode A4
    A4 = 0xa,
    _,
};

pub const FGPFCCR_START = enum(u1) {
    /// Start the automatic loading of the CLUT
    Start = 0x1,
    _,
};

pub const MODE = enum(u2) {
    /// Memory-to-memory (FG fetch only)
    MemoryToMemory = 0x0,
    /// Memory-to-memory with PFC (FG fetch only with FG PFC active)
    MemoryToMemoryPFC = 0x1,
    /// Memory-to-memory with blending (FG and BG fetch with PFC and blending)
    MemoryToMemoryPFCBlending = 0x2,
    /// Register-to-memory
    RegisterToMemory = 0x3,
};

pub const OPFCCR_CM = enum(u3) {
    /// ARGB8888
    ARGB8888 = 0x0,
    /// RGB888
    RGB888 = 0x1,
    /// RGB565
    RGB565 = 0x2,
    /// ARGB1555
    ARGB1555 = 0x3,
    /// ARGB4444
    ARGB4444 = 0x4,
    _,
};

/// DMA2D controller
pub const DMA2D = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Start
        START: CR_START,
        /// Suspend
        SUSP: u1,
        /// Abort
        ABORT: ABORT,
        reserved8: u5 = 0,
        /// Transfer error interrupt enable
        TEIE: u1,
        /// Transfer complete interrupt enable
        TCIE: u1,
        /// Transfer watermark interrupt enable
        TWIE: u1,
        /// CLUT access error interrupt enable
        CAEIE: u1,
        /// CLUT transfer complete interrupt enable
        CTCIE: u1,
        /// Configuration Error Interrupt Enable
        CEIE: u1,
        reserved16: u2 = 0,
        /// DMA2D mode
        MODE: MODE,
        padding: u14 = 0,
    }),
    /// Interrupt Status Register
    /// offset: 0x04
    ISR: mmio.Mmio(packed struct(u32) {
        /// Transfer error interrupt flag
        TEIF: u1,
        /// Transfer complete interrupt flag
        TCIF: u1,
        /// Transfer watermark interrupt flag
        TWIF: u1,
        /// CLUT access error interrupt flag
        CAEIF: u1,
        /// CLUT transfer complete interrupt flag
        CTCIF: u1,
        /// Configuration error interrupt flag
        CEIF: u1,
        padding: u26 = 0,
    }),
    /// interrupt flag clear register
    /// offset: 0x08
    IFCR: mmio.Mmio(packed struct(u32) {
        /// Clear Transfer error interrupt flag
        CTEIF: CTEIF,
        /// Clear transfer complete interrupt flag
        CTCIF: CTCIF,
        /// Clear transfer watermark interrupt flag
        CTWIF: CTWIF,
        /// Clear CLUT access error interrupt flag
        CAECIF: CAECIF,
        /// Clear CLUT transfer complete interrupt flag
        CCTCIF: CCTCIF,
        /// Clear configuration error interrupt flag
        CCEIF: CCEIF,
        padding: u26 = 0,
    }),
    /// foreground memory address register
    /// offset: 0x0c
    FGMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address
        MA: u32,
    }),
    /// foreground offset register
    /// offset: 0x10
    FGOR: mmio.Mmio(packed struct(u32) {
        /// Line offset
        LO: u14,
        padding: u18 = 0,
    }),
    /// background memory address register
    /// offset: 0x14
    BGMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address
        MA: u32,
    }),
    /// background offset register
    /// offset: 0x18
    BGOR: mmio.Mmio(packed struct(u32) {
        /// Line offset
        LO: u14,
        padding: u18 = 0,
    }),
    /// foreground PFC control register
    /// offset: 0x1c
    FGPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode
        CM: FGPFCCR_CM,
        /// CLUT color mode
        CCM: FGPFCCR_CCM,
        /// Start
        START: FGPFCCR_START,
        reserved8: u2 = 0,
        /// CLUT size
        CS: u8,
        /// Alpha mode
        AM: FGPFCCR_AM,
        reserved24: u6 = 0,
        /// Alpha value
        ALPHA: u8,
    }),
    /// foreground color register
    /// offset: 0x20
    FGCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value
        BLUE: u8,
        /// Green Value
        GREEN: u8,
        /// Red Value
        RED: u8,
        padding: u8 = 0,
    }),
    /// background PFC control register
    /// offset: 0x24
    BGPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode
        CM: BGPFCCR_CM,
        /// CLUT Color mode
        CCM: BGPFCCR_CCM,
        /// Start
        START: BGPFCCR_START,
        reserved8: u2 = 0,
        /// CLUT size
        CS: u8,
        /// Alpha mode
        AM: BGPFCCR_AM,
        reserved24: u6 = 0,
        /// Alpha value
        ALPHA: u8,
    }),
    /// background color register
    /// offset: 0x28
    BGCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value
        BLUE: u8,
        /// Green Value
        GREEN: u8,
        /// Red Value
        RED: u8,
        padding: u8 = 0,
    }),
    /// foreground CLUT memory address register
    /// offset: 0x2c
    FGCMAR: mmio.Mmio(packed struct(u32) {
        /// Memory Address
        MA: u32,
    }),
    /// background CLUT memory address register
    /// offset: 0x30
    BGCMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address
        MA: u32,
    }),
    /// output PFC control register
    /// offset: 0x34
    OPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode
        CM: OPFCCR_CM,
        padding: u29 = 0,
    }),
    /// output color register
    /// offset: 0x38
    OCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value
        BLUE: u8,
        /// Green Value
        GREEN: u8,
        /// Red Value
        RED: u8,
        /// Alpha Channel Value
        APLHA: u8,
    }),
    /// output memory address register
    /// offset: 0x3c
    OMAR: mmio.Mmio(packed struct(u32) {
        /// Memory Address
        MA: u32,
    }),
    /// output offset register
    /// offset: 0x40
    OOR: mmio.Mmio(packed struct(u32) {
        /// Line Offset
        LO: u14,
        padding: u18 = 0,
    }),
    /// number of line register
    /// offset: 0x44
    NLR: mmio.Mmio(packed struct(u32) {
        /// Number of lines
        NL: u16,
        /// Pixel per lines
        PL: u14,
        padding: u2 = 0,
    }),
    /// line watermark register
    /// offset: 0x48
    LWR: mmio.Mmio(packed struct(u32) {
        /// Line watermark
        LW: u16,
        padding: u16 = 0,
    }),
    /// AHB master timer configuration register
    /// offset: 0x4c
    AMTCR: mmio.Mmio(packed struct(u32) {
        /// Enable
        EN: u1,
        reserved8: u7 = 0,
        /// Dead Time
        DT: u8,
        padding: u16 = 0,
    }),
    /// offset: 0x50
    reserved80: [944]u8,
    /// FGCLUT
    /// offset: 0x400
    FGCLUT: mmio.Mmio(packed struct(u32) {
        /// BLUE
        BLUE: u8,
        /// GREEN
        GREEN: u8,
        /// RED
        RED: u8,
        /// APLHA
        APLHA: u8,
    }),
    /// offset: 0x404
    reserved1028: [1020]u8,
    /// BGCLUT
    /// offset: 0x800
    BGCLUT: mmio.Mmio(packed struct(u32) {
        /// BLUE
        BLUE: u8,
        /// GREEN
        GREEN: u8,
        /// RED
        RED: u8,
        /// APLHA
        APLHA: u8,
    }),
};
