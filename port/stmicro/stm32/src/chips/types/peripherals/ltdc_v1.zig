const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const BF1 = enum(u3) {
    /// BF1 = constant alpha
    Constant = 0x4,
    /// BF1 = pixel alpha * constant alpha
    Pixel = 0x7,
    _,
};

pub const BF2 = enum(u3) {
    /// BF2 = 1 - constant alpha
    Constant = 0x5,
    /// BF2 = 1 - pixel alpha * constant alpha
    Pixel = 0x7,
    _,
};

pub const CFUIF = enum(u1) {
    /// Clears the FUIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CLIF = enum(u1) {
    /// Clears the LIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CRRIF = enum(u1) {
    /// Clears the RRIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const CTERRIF = enum(u1) {
    /// Clears the TERRIF flag in the ISR register
    Clear = 0x1,
    _,
};

pub const DEPOL = enum(u1) {
    /// Data enable polarity is active low
    ActiveLow = 0x0,
    /// Data enable polarity is active high
    ActiveHigh = 0x1,
};

pub const HSPOL = enum(u1) {
    /// Horizontal synchronization polarity is active low
    ActiveLow = 0x0,
    /// Horizontal synchronization polarity is active high
    ActiveHigh = 0x1,
};

pub const IMR = enum(u1) {
    /// This bit is set by software and cleared only by hardware after reload (it cannot be cleared through register write once it is set)
    NoEffect = 0x0,
    /// The shadow registers are reloaded immediately. This bit is set by software and cleared only by hardware after reload
    Reload = 0x1,
};

pub const PCPOL = enum(u1) {
    /// Pixel clock on rising edge
    RisingEdge = 0x0,
    /// Pixel clock on falling edge
    FallingEdge = 0x1,
};

pub const PF = enum(u3) {
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
    /// L8 (8-bit luminance)
    L8 = 0x5,
    /// AL44 (4-bit alpha, 4-bit luminance)
    AL44 = 0x6,
    /// AL88 (8-bit alpha, 8-bit luminance)
    AL88 = 0x7,
};

pub const VBR = enum(u1) {
    /// This bit is set by software and cleared only by hardware after reload (it cannot be cleared through register write once it is set)
    NoEffect = 0x0,
    /// The shadow registers are reloaded during the vertical blanking period (at the beginning of the first line after the active display area).
    Reload = 0x1,
};

pub const VSPOL = enum(u1) {
    /// Vertical synchronization polarity is active low
    ActiveLow = 0x0,
    /// Vertical synchronization polarity is active high
    ActiveHigh = 0x1,
};

/// Cluster LAYER%s, containing L?CR, L?WHPCR, L?WVPCR, L?CKCR, L?PFCR, L?CACR, L?DCCR, L?BFCR, L?CFBAR, L?CFBLR, L?CFBLNR, L?CLUTWR
pub const LAYER = extern struct {
    /// Layerx Control Register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Layer Enable
        LEN: u1,
        /// Color Keying Enable
        COLKEN: u1,
        reserved4: u2 = 0,
        /// Color Look-Up Table Enable
        CLUTEN: u1,
        padding: u27 = 0,
    }),
    /// Layerx Window Horizontal Position Configuration Register
    /// offset: 0x04
    WHPCR: mmio.Mmio(packed struct(u32) {
        /// Window Horizontal Start Position
        WHSTPOS: u12,
        reserved16: u4 = 0,
        /// Window Horizontal Stop Position
        WHSPPOS: u12,
        padding: u4 = 0,
    }),
    /// Layerx Window Vertical Position Configuration Register
    /// offset: 0x08
    WVPCR: mmio.Mmio(packed struct(u32) {
        /// Window Vertical Start Position
        WVSTPOS: u11,
        reserved16: u5 = 0,
        /// Window Vertical Stop Position
        WVSPPOS: u11,
        padding: u5 = 0,
    }),
    /// Layerx Color Keying Configuration Register
    /// offset: 0x0c
    CKCR: mmio.Mmio(packed struct(u32) {
        /// Color Key Blue value
        CKBLUE: u8,
        /// Color Key Green value
        CKGREEN: u8,
        /// Color Key Red value
        CKRED: u8,
        padding: u8 = 0,
    }),
    /// Layerx Pixel Format Configuration Register
    /// offset: 0x10
    PFCR: mmio.Mmio(packed struct(u32) {
        /// Pixel Format
        PF: PF,
        padding: u29 = 0,
    }),
    /// Layerx Constant Alpha Configuration Register
    /// offset: 0x14
    CACR: mmio.Mmio(packed struct(u32) {
        /// Constant Alpha
        CONSTA: u8,
        padding: u24 = 0,
    }),
    /// Layerx Default Color Configuration Register
    /// offset: 0x18
    DCCR: mmio.Mmio(packed struct(u32) {
        /// Default Color Blue
        DCBLUE: u8,
        /// Default Color Green
        DCGREEN: u8,
        /// Default Color Red
        DCRED: u8,
        /// Default Color Alpha
        DCALPHA: u8,
    }),
    /// Layerx Blending Factors Configuration Register
    /// offset: 0x1c
    BFCR: mmio.Mmio(packed struct(u32) {
        /// Blending Factor 2
        BF2: BF2,
        reserved8: u5 = 0,
        /// Blending Factor 1
        BF1: BF1,
        padding: u21 = 0,
    }),
    /// offset: 0x20
    reserved32: [8]u8,
    /// Layerx Color Frame Buffer Address Register
    /// offset: 0x28
    CFBAR: mmio.Mmio(packed struct(u32) {
        /// Color Frame Buffer Start Address
        CFBADD: u32,
    }),
    /// Layerx Color Frame Buffer Length Register
    /// offset: 0x2c
    CFBLR: mmio.Mmio(packed struct(u32) {
        /// Color Frame Buffer Line Length
        CFBLL: u13,
        reserved16: u3 = 0,
        /// Color Frame Buffer Pitch in bytes
        CFBP: u13,
        padding: u3 = 0,
    }),
    /// Layerx ColorFrame Buffer Line Number Register
    /// offset: 0x30
    CFBLNR: mmio.Mmio(packed struct(u32) {
        /// Frame Buffer Line Number
        CFBLNBR: u11,
        padding: u21 = 0,
    }),
    /// offset: 0x34
    reserved52: [12]u8,
    /// Layerx CLUT Write Register
    /// offset: 0x40
    CLUTWR: mmio.Mmio(packed struct(u32) {
        /// Blue value
        BLUE: u8,
        /// Green value
        GREEN: u8,
        /// Red value
        RED: u8,
        /// CLUT Address
        CLUTADD: u8,
    }),
};

/// LCD-TFT Controller
pub const LTDC = extern struct {
    /// offset: 0x00
    reserved0: [8]u8,
    /// Synchronization Size Configuration Register
    /// offset: 0x08
    SSCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Synchronization Height (in units of horizontal scan line)
        VSH: u11,
        reserved16: u5 = 0,
        /// Horizontal Synchronization Width (in units of pixel clock period)
        HSW: u12,
        padding: u4 = 0,
    }),
    /// Back Porch Configuration Register
    /// offset: 0x0c
    BPCR: mmio.Mmio(packed struct(u32) {
        /// Accumulated Vertical back porch (in units of horizontal scan line)
        AVBP: u11,
        reserved16: u5 = 0,
        /// Accumulated Horizontal back porch (in units of pixel clock period)
        AHBP: u12,
        padding: u4 = 0,
    }),
    /// Active Width Configuration Register
    /// offset: 0x10
    AWCR: mmio.Mmio(packed struct(u32) {
        /// Accumulated Active Height (in units of horizontal scan line)
        AAH: u11,
        reserved16: u5 = 0,
        /// Accumulated Active Width (in units of pixel clock period)
        AAW: u12,
        padding: u4 = 0,
    }),
    /// Total Width Configuration Register
    /// offset: 0x14
    TWCR: mmio.Mmio(packed struct(u32) {
        /// Total Height (in units of horizontal scan line)
        TOTALH: u11,
        reserved16: u5 = 0,
        /// Total Width (in units of pixel clock period)
        TOTALW: u12,
        padding: u4 = 0,
    }),
    /// Global Control Register
    /// offset: 0x18
    GCR: mmio.Mmio(packed struct(u32) {
        /// LCD-TFT controller enable bit
        LTDCEN: u1,
        reserved4: u3 = 0,
        /// Dither Blue Width
        DBW: u3,
        reserved8: u1 = 0,
        /// Dither Green Width
        DGW: u3,
        reserved12: u1 = 0,
        /// Dither Red Width
        DRW: u3,
        reserved16: u1 = 0,
        /// Dither Enable
        DEN: u1,
        reserved28: u11 = 0,
        /// Pixel Clock Polarity
        PCPOL: PCPOL,
        /// Data Enable Polarity
        DEPOL: DEPOL,
        /// Vertical Synchronization Polarity
        VSPOL: VSPOL,
        /// Horizontal Synchronization Polarity
        HSPOL: HSPOL,
    }),
    /// offset: 0x1c
    reserved28: [8]u8,
    /// Shadow Reload Configuration Register
    /// offset: 0x24
    SRCR: mmio.Mmio(packed struct(u32) {
        /// Immediate Reload
        IMR: IMR,
        /// Vertical Blanking Reload
        VBR: VBR,
        padding: u30 = 0,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// Background Color Configuration Register
    /// offset: 0x2c
    BCCR: mmio.Mmio(packed struct(u32) {
        /// Background color blue value
        BCBLUE: u8,
        /// Background color green value
        BCGREEN: u8,
        /// Background color red value
        BCRED: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x30
    reserved48: [4]u8,
    /// Interrupt Enable Register
    /// offset: 0x34
    IER: mmio.Mmio(packed struct(u32) {
        /// Line Interrupt Enable
        LIE: u1,
        /// FIFO Underrun Interrupt Enable
        FUIE: u1,
        /// Transfer Error Interrupt Enable
        TERRIE: u1,
        /// Register Reload interrupt enable
        RRIE: u1,
        padding: u28 = 0,
    }),
    /// Interrupt Status Register
    /// offset: 0x38
    ISR: mmio.Mmio(packed struct(u32) {
        /// Line Interrupt flag
        LIF: u1,
        /// FIFO Underrun Interrupt flag
        FUIF: u1,
        /// Transfer Error interrupt flag
        TERRIF: u1,
        /// Register Reload Interrupt Flag
        RRIF: u1,
        padding: u28 = 0,
    }),
    /// Interrupt Clear Register
    /// offset: 0x3c
    ICR: mmio.Mmio(packed struct(u32) {
        /// Clears the Line Interrupt Flag
        CLIF: CLIF,
        /// Clears the FIFO Underrun Interrupt flag
        CFUIF: CFUIF,
        /// Clears the Transfer Error Interrupt Flag
        CTERRIF: CTERRIF,
        /// Clears Register Reload Interrupt Flag
        CRRIF: CRRIF,
        padding: u28 = 0,
    }),
    /// Line Interrupt Position Configuration Register
    /// offset: 0x40
    LIPCR: mmio.Mmio(packed struct(u32) {
        /// Line Interrupt Position
        LIPOS: u11,
        padding: u21 = 0,
    }),
    /// Current Position Status Register
    /// offset: 0x44
    CPSR: mmio.Mmio(packed struct(u32) {
        /// Current Y Position
        CYPOS: u16,
        /// Current X Position
        CXPOS: u16,
    }),
    /// Current Display Status Register
    /// offset: 0x48
    CDSR: mmio.Mmio(packed struct(u32) {
        /// Vertical Data Enable display Status
        VDES: u1,
        /// Horizontal Data Enable display Status
        HDES: u1,
        /// Vertical Synchronization display Status
        VSYNCS: u1,
        /// Horizontal Synchronization display Status
        HSYNCS: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x4c
    reserved76: [56]u8,
    /// Cluster LAYER%s, containing L?CR, L?WHPCR, L?WVPCR, L?CKCR, L?PFCR, L?CACR, L?DCCR, L?BFCR, L?CFBAR, L?CFBLR, L?CFBLNR, L?CLUTWR
    /// offset: 0x84
    LAYER: u32,
};
