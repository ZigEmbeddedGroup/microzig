const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const Blanking = enum(u5) {
    /// No blanking.
    NoBlanking = 0x0,
    /// Check data sheet for blanking options
    Blank1 = 0x1,
    /// Check data sheet for blanking options
    Blank2 = 0x2,
    /// Check data sheet for blanking options
    Blank3 = 0x4,
    _,
};

pub const Hysteresis = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const INM = enum(u4) {
    /// Inverting input set to 1/4 VRef
    QuarterVRef = 0x0,
    /// Inverting input set to 1/2 VRef
    HalfVRef = 0x1,
    /// Inverting input set to 3/4 VRef
    ThreeQuarterVRef = 0x2,
    /// Inverting input set to VRef
    VRef = 0x3,
    /// Inverting input set to DAC1 output
    DAC1 = 0x4,
    /// Inverting input set to DAC2 output
    DAC2 = 0x5,
    /// Inverting input set to IO1 (PB7)
    INM1 = 0x6,
    /// Inverting input set to IO2 (PB3)
    INM2 = 0x7,
    _,
};

pub const Polarity = enum(u1) {
    /// Output is not inverted.
    NotInverted = 0x0,
    /// Output is inverted.
    Inverted = 0x1,
};

pub const PowerMode = enum(u2) {
    /// High speed / full power.
    HighSpeed = 0x0,
    /// Medium speed / medium power.
    MediumSpeed = 0x1,
    /// Very-low speed / ultra-low power.
    UltraLow = 0x3,
    _,
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
        INMSEL: INM,
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
        HYST: Hysteresis,
        /// Power Mode.
        PWRMODE: PowerMode,
        /// Blanking source selection bits.
        BLANKSEL: Blanking,
        reserved30: u5 = 0,
        /// Output status bit.
        VALUE: u1,
        /// Register lock bit.
        LOCK: u1,
    }),
};
