const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const HYST = enum(u2) {
    None = 0x0,
    /// Low hysteresis
    Low = 0x1,
    /// Medium hysteresis
    Medium = 0x2,
    /// High hysteresis
    High = 0x3,
};

pub const MODE = enum(u2) {
    /// High Speed mode
    HighSpeed = 0x0,
    /// Medium Speed mode
    MediumSpeed = 0x1,
    /// Low Speed mode
    LowSpeed = 0x2,
    /// Very Low Speed mode
    VeryLowSpeed = 0x3,
};

/// General purpose comparators.
pub const COMP = extern struct {
    /// control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Comparator enable.
        EN: u1,
        /// Comparator 1 non inverting input connection to DAC output. Only available on COMP1
        INP_DAC: u1,
        /// Comparator mode.
        MODE: MODE,
        /// Comparator inverting input selection.
        INSEL: u3,
        /// Window mode enable. Only available on COMP2
        WNDWEN: u1,
        /// Comparator output selection.
        OUTSEL: u3,
        /// Comparator output polarity.
        POL: u1,
        /// Comparator hysteresis.
        HYST: HYST,
        /// Comparator output.
        OUT: u1,
        /// Comparator lock.
        LOCK: u1,
        padding: u16 = 0,
    }),
};
