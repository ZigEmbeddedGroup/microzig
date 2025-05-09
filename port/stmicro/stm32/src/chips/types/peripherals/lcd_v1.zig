const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Liquid crystal display controller
pub const LCD = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// LCD controller enable
        LCDEN: u1,
        /// Voltage source selection
        VSEL: u1,
        /// Duty selection
        DUTY: u3,
        /// Bias selector
        BIAS: u2,
        /// Mux segment enable
        MUX_SEG: u1,
        padding: u24 = 0,
    }),
    /// frame control register
    /// offset: 0x04
    FCR: mmio.Mmio(packed struct(u32) {
        /// High drive enable
        HD: u1,
        /// Start of frame interrupt enable
        SOFIE: u1,
        reserved3: u1 = 0,
        /// Update display done interrupt enable
        UDDIE: u1,
        /// Pulse ON duration
        PON: u3,
        /// Dead time duration
        DEAD: u3,
        /// Contrast control
        CC: u3,
        /// Blink frequency selection
        BLINKF: u3,
        /// Blink mode selection
        BLINK: u2,
        /// DIV clock divider
        DIV: u4,
        /// PS 16-bit prescaler
        PS: u4,
        padding: u6 = 0,
    }),
    /// status register
    /// offset: 0x08
    SR: mmio.Mmio(packed struct(u32) {
        /// LCD enabled status
        ENS: u1,
        /// Start of frame flag
        SOF: u1,
        /// Update display request
        UDR: u1,
        /// Update Display Done
        UDD: u1,
        /// Ready flag
        RDY: u1,
        /// LCD Frame Control Register Synchronization flag
        FCRSF: u1,
        padding: u26 = 0,
    }),
    /// clear register
    /// offset: 0x0c
    CLR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Start of frame flag clear
        SOFC: u1,
        reserved3: u1 = 0,
        /// Update display done clear
        UDDC: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x10
    reserved16: [4]u8,
    /// display memory
    /// offset: 0x14
    RAM_COM: u32,
};

/// display memory
pub const RAM_COM = extern struct {
    /// display memory low word
    /// offset: 0x00
    LOW: u32,
    /// display memory high word
    /// offset: 0x04
    HIGH: u32,
};
