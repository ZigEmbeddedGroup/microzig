const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BLANKING = enum(u3) {
    /// No blanking.
    NoBlanking = 0x0,
    /// TIM1 OC5 selected as blanking source.
    TIM1OC5 = 0x1,
    /// TIM2 OC3 selected as blanking source.
    TIM2OC3 = 0x2,
    _,
};

pub const HYST = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const POLARITY = enum(u1) {
    /// Output is not inverted.
    NotInverted = 0x0,
    /// Output is inverted.
    Inverted = 0x1,
};

pub const PWRMODE = enum(u2) {
    /// High speed / full power.
    HighSpeed = 0x0,
    /// Medium speed / medium power.
    MediumSpeed = 0x1,
    /// Low speed / low power.
    LowSpeed = 0x2,
    /// Very-low speed / ultra-low power.
    VeryLowSpeed = 0x3,
};

/// Comparator.
pub const COMP = extern struct {
    /// Comparator control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Enable
        EN: u1,
        reserved2: u1 = 0,
        /// Power Mode.
        PWRMODE: PWRMODE,
        /// Input minus selection bits.
        INMSEL: u3,
        /// Input plus selection bit.
        INPSEL: u2,
        reserved15: u6 = 0,
        /// Polarity selection bit.
        POLARITY: POLARITY,
        /// Hysteresis selection bits.
        HYST: HYST,
        /// Blanking source selection bits.
        BLANKING: BLANKING,
        reserved22: u1 = 0,
        /// Scaler bridge enable.
        BRGEN: u1,
        /// Voltage scaler enable bit.
        SCALEN: u1,
        reserved25: u1 = 0,
        /// Input minus extended selection bits.
        INMESEL: u2,
        reserved30: u3 = 0,
        /// Output status bit.
        VALUE: u1,
        /// Register lock bit.
        LOCK: u1,
    }),
};
