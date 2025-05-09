const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BLANKING = enum(u5) {
    /// No blanking.
    NoBlanking = 0x0,
    /// TIM1 OC4 enabled as blanking source
    TIM1OC4 = 0x1,
    /// TIM1 OC5 enabled as blanking source
    TIM1OC5 = 0x2,
    /// TIM5 OC3 enabled as blanking source
    TIM2OC3 = 0x4,
    /// TIM3 OC3 enabled as blanking source
    TIM3OC3 = 0x8,
    /// TIM15 OC2 enabled as blanking source
    TIM15OC2 = 0x10,
    _,
};

pub const HYST = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const PWRMODE = enum(u2) {
    /// High speed / full power.
    HighSpeed = 0x0,
    /// Medium speed / medium power.
    MediumSpeed = 0x1,
    /// Very-low speed / ultra-low power.
    LowSpeed = 0x3,
    _,
};

pub const Polarity = enum(u1) {
    /// Output is not inverted.
    NotInverted = 0x0,
    /// Output is inverted.
    Inverted = 0x1,
};

pub const WindowMode = enum(u1) {
    /// Signal selected with INPSEL[2:0] bitfield of this register.
    ThisInpsel = 0x0,
    /// Signal selected with INPSEL[2:0] bitfield of the other register (required for window mode).
    OtherInpsel = 0x1,
};

pub const WindowOut = enum(u1) {
    /// Comparator 1 value.
    COMP1_VALUE = 0x0,
    /// Comparator 1 value XOR comparator 2 value (required for window mode).
    @"COMP1_VALUE XOR COMP2_VALUE" = 0x1,
};

/// Comparator.
pub const COMP = extern struct {
    /// Comparator control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Enable
        EN: u1,
        reserved4: u3 = 0,
        /// Input minus selection bits.
        INMSEL: u4,
        /// Input plus selection bit.
        INPSEL: u3,
        /// Comparator 1 noninverting input selector for window mode.
        WINMODE: WindowMode,
        reserved14: u2 = 0,
        /// Comparator 1 output selector.
        WINOUT: WindowOut,
        /// Polarity selection bit.
        POLARITY: Polarity,
        /// Hysteresis selection bits.
        HYST: HYST,
        /// Power Mode.
        PWRMODE: PWRMODE,
        /// Blanking source selection bits.
        BLANKSEL: BLANKING,
        reserved30: u5 = 0,
        /// Output status bit.
        VALUE: u1,
        /// Register lock bit.
        LOCK: u1,
    }),
};
