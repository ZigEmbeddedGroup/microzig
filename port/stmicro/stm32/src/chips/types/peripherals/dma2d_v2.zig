const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ABORT = enum(u1) {
    /// Transfer abort requested
    AbortRequest = 0x1,
    _,
};

pub const BGPFCCR_AI = enum(u1) {
    /// Regular alpha
    RegularAlpha = 0x0,
    /// Inverted alpha
    InvertedAlpha = 0x1,
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

pub const BGPFCCR_RBS = enum(u1) {
    /// No Red Blue Swap (RGB or ARGB)
    Regular = 0x0,
    /// Red Blue Swap (BGR or ABGR)
    Swap = 0x1,
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

pub const FGPFCCR_AI = enum(u1) {
    /// Regular alpha
    RegularAlpha = 0x0,
    /// Inverted alpha
    InvertedAlpha = 0x1,
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
    /// Color mode YCbCr
    YCbCr = 0xb,
    _,
};

pub const FGPFCCR_RBS = enum(u1) {
    /// No Red Blue Swap (RGB or ARGB)
    Regular = 0x0,
    /// Red Blue Swap (BGR or ABGR)
    Swap = 0x1,
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

pub const OPFCCR_AI = enum(u1) {
    /// Regular alpha
    RegularAlpha = 0x0,
    /// Inverted alpha
    InvertedAlpha = 0x1,
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

pub const OPFCCR_RBS = enum(u1) {
    /// No Red Blue Swap (RGB or ARGB)
    Regular = 0x0,
    /// Red Blue Swap (BGR or ABGR)
    Swap = 0x1,
};

pub const SB = enum(u1) {
    /// Regular byte order
    Regular = 0x0,
    /// Bytes are swapped two by two
    SwapBytes = 0x1,
};

/// DMA2D
pub const DMA2D = extern struct {
    /// DMA2D control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Start This bit can be used to launch the DMA2D according to the parameters loaded in the various configuration registers
        START: CR_START,
        /// Suspend This bit can be used to suspend the current transfer. This bit is set and reset by software. It is automatically reset by hardware when the START bit is reset.
        SUSP: u1,
        /// Abort This bit can be used to abort the current transfer. This bit is set by software and is automatically reset by hardware when the START bit is reset.
        ABORT: ABORT,
        reserved8: u5 = 0,
        /// Transfer error interrupt enable This bit is set and cleared by software.
        TEIE: u1,
        /// Transfer complete interrupt enable This bit is set and cleared by software.
        TCIE: u1,
        /// Transfer watermark interrupt enable This bit is set and cleared by software.
        TWIE: u1,
        /// CLUT access error interrupt enable This bit is set and cleared by software.
        CAEIE: u1,
        /// CLUT transfer complete interrupt enable This bit is set and cleared by software.
        CTCIE: u1,
        /// Configuration Error Interrupt Enable This bit is set and cleared by software.
        CEIE: u1,
        reserved16: u2 = 0,
        /// DMA2D mode This bit is set and cleared by software. It cannot be modified while a transfer is ongoing.
        MODE: MODE,
        padding: u14 = 0,
    }),
    /// DMA2D Interrupt Status Register
    /// offset: 0x04
    ISR: mmio.Mmio(packed struct(u32) {
        /// Transfer error interrupt flag This bit is set when an error occurs during a DMA transfer (data transfer or automatic CLUT loading).
        TEIF: u1,
        /// Transfer complete interrupt flag This bit is set when a DMA2D transfer operation is complete (data transfer only).
        TCIF: u1,
        /// Transfer watermark interrupt flag This bit is set when the last pixel of the watermarked line has been transferred.
        TWIF: u1,
        /// CLUT access error interrupt flag This bit is set when the CPU accesses the CLUT while the CLUT is being automatically copied from a system memory to the internal DMA2D.
        CAEIF: u1,
        /// CLUT transfer complete interrupt flag This bit is set when the CLUT copy from a system memory area to the internal DMA2D memory is complete.
        CTCIF: u1,
        /// Configuration error interrupt flag This bit is set when the START bit of DMA2D_CR, DMA2DFGPFCCR or DMA2D_BGPFCCR is set and a wrong configuration has been programmed.
        CEIF: u1,
        padding: u26 = 0,
    }),
    /// DMA2D interrupt flag clear register
    /// offset: 0x08
    IFCR: mmio.Mmio(packed struct(u32) {
        /// Clear Transfer error interrupt flag Programming this bit to 1 clears the TEIF flag in the DMA2D_ISR register
        CTEIF: CTEIF,
        /// Clear transfer complete interrupt flag Programming this bit to 1 clears the TCIF flag in the DMA2D_ISR register
        CTCIF: CTCIF,
        /// Clear transfer watermark interrupt flag Programming this bit to 1 clears the TWIF flag in the DMA2D_ISR register
        CTWIF: CTWIF,
        /// Clear CLUT access error interrupt flag Programming this bit to 1 clears the CAEIF flag in the DMA2D_ISR register
        CAECIF: CAECIF,
        /// Clear CLUT transfer complete interrupt flag Programming this bit to 1 clears the CTCIF flag in the DMA2D_ISR register
        CCTCIF: CCTCIF,
        /// Clear configuration error interrupt flag Programming this bit to 1 clears the CEIF flag in the DMA2D_ISR register
        CCEIF: CCEIF,
        padding: u26 = 0,
    }),
    /// DMA2D foreground memory address register
    /// offset: 0x0c
    FGMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address Address of the data used for the foreground image. This register can only be written when data transfers are disabled. Once the data transfer has started, this register is read-only. The address alignment must match the image format selected e.g. a 32-bit per pixel format must be 32-bit aligned, a 16-bit per pixel format must be 16-bit aligned and a 4-bit per pixel format must be 8-bit aligned.
        MA: u32,
    }),
    /// DMA2D foreground offset register
    /// offset: 0x10
    FGOR: mmio.Mmio(packed struct(u32) {
        /// Line offset Line offset used for the foreground expressed in pixel. This value is used to generate the address. It is added at the end of each line to determine the starting address of the next line. These bits can only be written when data transfers are disabled. Once a data transfer has started, they become read-only. If the image format is 4-bit per pixel, the line offset must be even.
        LO: u16,
        padding: u16 = 0,
    }),
    /// DMA2D background memory address register
    /// offset: 0x14
    BGMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address Address of the data used for the background image. This register can only be written when data transfers are disabled. Once a data transfer has started, this register is read-only. The address alignment must match the image format selected e.g. a 32-bit per pixel format must be 32-bit aligned, a 16-bit per pixel format must be 16-bit aligned and a 4-bit per pixel format must be 8-bit aligned.
        MA: u32,
    }),
    /// DMA2D background offset register
    /// offset: 0x18
    BGOR: mmio.Mmio(packed struct(u32) {
        /// Line offset Line offset used for the background image (expressed in pixel). This value is used for the address generation. It is added at the end of each line to determine the starting address of the next line. These bits can only be written when data transfers are disabled. Once data transfer has started, they become read-only. If the image format is 4-bit per pixel, the line offset must be even.
        LO: u16,
        padding: u16 = 0,
    }),
    /// DMA2D foreground PFC control register
    /// offset: 0x1c
    FGPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode These bits defines the color format of the foreground image. They can only be written when data transfers are disabled. Once the transfer has started, they are read-only. others: meaningless
        CM: FGPFCCR_CM,
        /// CLUT color mode This bit defines the color format of the CLUT. It can only be written when the transfer is disabled. Once the CLUT transfer has started, this bit is read-only.
        CCM: FGPFCCR_CCM,
        /// Start This bit can be set to start the automatic loading of the CLUT. It is automatically reset: ** at the end of the transfer ** when the transfer is aborted by the user application by setting the ABORT bit in DMA2D_CR ** when a transfer error occurs ** when the transfer has not started due to a configuration error or another transfer operation already ongoing (data transfer or automatic background CLUT transfer).
        START: FGPFCCR_START,
        reserved8: u2 = 0,
        /// CLUT size These bits define the size of the CLUT used for the foreground image. Once the CLUT transfer has started, this field is read-only. The number of CLUT entries is equal to CS[7:0] + 1.
        CS: u8,
        /// Alpha mode These bits select the alpha channel value to be used for the foreground image. They can only be written data the transfer are disabled. Once the transfer has started, they become read-only. other configurations are meaningless
        AM: FGPFCCR_AM,
        /// Chroma Sub-Sampling These bits define the chroma sub-sampling mode for YCbCr color mode. Once the transfer has started, these bits are read-only. others: meaningless
        CSS: u2,
        /// Alpha Inverted This bit inverts the alpha value. Once the transfer has started, this bit is read-only.
        AI: FGPFCCR_AI,
        /// Red Blue Swap This bit allows to swap the R &amp; B to support BGR or ABGR color formats. Once the transfer has started, this bit is read-only.
        RBS: FGPFCCR_RBS,
        reserved24: u2 = 0,
        /// Alpha value These bits define a fixed alpha channel value which can replace the original alpha value or be multiplied by the original alpha value according to the alpha mode selected through the AM[1:0] bits. These bits can only be written when data transfers are disabled. Once a transfer has started, they become read-only.
        ALPHA: u8,
    }),
    /// DMA2D foreground color register
    /// offset: 0x20
    FGCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value These bits defines the blue value for the A4 or A8 mode of the foreground image. They can only be written when data transfers are disabled. Once the transfer has started, They are read-only.
        BLUE: u8,
        /// Green Value These bits defines the green value for the A4 or A8 mode of the foreground image. They can only be written when data transfers are disabled. Once the transfer has started, They are read-only.
        GREEN: u8,
        /// Red Value These bits defines the red value for the A4 or A8 mode of the foreground image. They can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        RED: u8,
        padding: u8 = 0,
    }),
    /// DMA2D background PFC control register
    /// offset: 0x24
    BGPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode These bits define the color format of the foreground image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only. others: meaningless
        CM: BGPFCCR_CM,
        /// CLUT Color mode These bits define the color format of the CLUT. This register can only be written when the transfer is disabled. Once the CLUT transfer has started, this bit is read-only.
        CCM: BGPFCCR_CCM,
        /// Start This bit is set to start the automatic loading of the CLUT. This bit is automatically reset: ** at the end of the transfer ** when the transfer is aborted by the user application by setting the ABORT bit in the DMA2D_CR ** when a transfer error occurs ** when the transfer has not started due to a configuration error or another transfer operation already on going (data transfer or automatic BackGround CLUT transfer).
        START: BGPFCCR_START,
        reserved8: u2 = 0,
        /// CLUT size These bits define the size of the CLUT used for the BG. Once the CLUT transfer has started, this field is read-only. The number of CLUT entries is equal to CS[7:0] + 1.
        CS: u8,
        /// Alpha mode These bits define which alpha channel value to be used for the background image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only. others: meaningless
        AM: BGPFCCR_AM,
        reserved20: u2 = 0,
        /// Alpha Inverted This bit inverts the alpha value. Once the transfer has started, this bit is read-only.
        AI: BGPFCCR_AI,
        /// Red Blue Swap This bit allows to swap the R &amp; B to support BGR or ABGR color formats. Once the transfer has started, this bit is read-only.
        RBS: BGPFCCR_RBS,
        reserved24: u2 = 0,
        /// Alpha value These bits define a fixed alpha channel value which can replace the original alpha value or be multiplied with the original alpha value according to the alpha mode selected with bits AM[1: 0]. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        ALPHA: u8,
    }),
    /// DMA2D background color register
    /// offset: 0x28
    BGCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value These bits define the blue value for the A4 or A8 mode of the background. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        BLUE: u8,
        /// Green Value These bits define the green value for the A4 or A8 mode of the background. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        GREEN: u8,
        /// Red Value These bits define the red value for the A4 or A8 mode of the background. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        RED: u8,
        padding: u8 = 0,
    }),
    /// DMA2D foreground CLUT memory address register
    /// offset: 0x2c
    FGCMAR: mmio.Mmio(packed struct(u32) {
        /// Memory Address Address of the data used for the CLUT address dedicated to the foreground image. This register can only be written when no transfer is ongoing. Once the CLUT transfer has started, this register is read-only. If the foreground CLUT format is 32-bit, the address must be 32-bit aligned.
        MA: u32,
    }),
    /// DMA2D background CLUT memory address register
    /// offset: 0x30
    BGCMAR: mmio.Mmio(packed struct(u32) {
        /// Memory address Address of the data used for the CLUT address dedicated to the background image. This register can only be written when no transfer is on going. Once the CLUT transfer has started, this register is read-only. If the background CLUT format is 32-bit, the address must be 32-bit aligned.
        MA: u32,
    }),
    /// DMA2D output PFC control register
    /// offset: 0x34
    OPFCCR: mmio.Mmio(packed struct(u32) {
        /// Color mode These bits define the color format of the output image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only. others: meaningless
        CM: OPFCCR_CM,
        reserved8: u5 = 0,
        /// Swap Bytes
        SB: SB,
        reserved20: u11 = 0,
        /// Alpha Inverted This bit inverts the alpha value. Once the transfer has started, this bit is read-only.
        AI: OPFCCR_AI,
        /// Red Blue Swap This bit allows to swap the R &amp; B to support BGR or ABGR color formats. Once the transfer has started, this bit is read-only.
        RBS: OPFCCR_RBS,
        padding: u10 = 0,
    }),
    /// DMA2D output color register
    /// offset: 0x38
    OCOLR: mmio.Mmio(packed struct(u32) {
        /// Blue Value These bits define the blue value of the output image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        BLUE: u8,
        /// Green Value These bits define the green value of the output image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        GREEN: u8,
        /// Red Value These bits define the red value of the output image. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        RED: u8,
        /// Alpha Channel Value These bits define the alpha channel of the output color. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        ALPHA: u8,
    }),
    /// DMA2D output memory address register
    /// offset: 0x3c
    OMAR: mmio.Mmio(packed struct(u32) {
        /// Memory Address Address of the data used for the output FIFO. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only. The address alignment must match the image format selected e.g. a 32-bit per pixel format must be 32-bit aligned and a 16-bit per pixel format must be 16-bit aligned.
        MA: u32,
    }),
    /// DMA2D output offset register
    /// offset: 0x40
    OOR: mmio.Mmio(packed struct(u32) {
        /// Line Offset Line offset used for the output (expressed in pixels). This value is used for the address generation. It is added at the end of each line to determine the starting address of the next line. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        LO: u16,
        padding: u16 = 0,
    }),
    /// DMA2D number of line register
    /// offset: 0x44
    NLR: mmio.Mmio(packed struct(u32) {
        /// Number of lines Number of lines of the area to be transferred. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        NL: u16,
        /// Pixel per lines Number of pixels per lines of the area to be transferred. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only. If any of the input image format is 4-bit per pixel, pixel per lines must be even.
        PL: u14,
        padding: u2 = 0,
    }),
    /// DMA2D line watermark register
    /// offset: 0x48
    LWR: mmio.Mmio(packed struct(u32) {
        /// Line watermark These bits allow to configure the line watermark for interrupt generation. An interrupt is raised when the last pixel of the watermarked line has been transferred. These bits can only be written when data transfers are disabled. Once the transfer has started, they are read-only.
        LW: u16,
        padding: u16 = 0,
    }),
    /// DMA2D AXI master timer configuration register
    /// offset: 0x4c
    AMTCR: mmio.Mmio(packed struct(u32) {
        /// Enable Enables the dead time functionality.
        EN: u1,
        reserved8: u7 = 0,
        /// Dead Time Dead time value in the AXI clock cycle inserted between two consecutive accesses on the AXI master port. These bits represent the minimum guaranteed number of cycles between two consecutive AXI accesses.
        DT: u8,
        padding: u16 = 0,
    }),
};
