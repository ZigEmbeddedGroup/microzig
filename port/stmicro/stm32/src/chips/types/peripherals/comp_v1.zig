const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BLANKSEL = enum(u5) {
    None = 0x0,
    /// TIM1 OC4
    Tim1Oc4 = 0x1,
    /// TIM1 OC5
    Tim1Oc5 = 0x2,
    /// TIM2 OC3
    Tim2Oc3 = 0x4,
    /// TIM3 OC3
    Tim3Oc3 = 0x8,
    /// TIM15 OC2
    Tim15Oc2 = 0x10,
    _,
};

pub const HYST = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const POLARITY = enum(u1) {
    NonInverted = 0x0,
    Inverted = 0x1,
};

pub const PWRMODE = enum(u2) {
    HighSpeed = 0x0,
    MediumSpeed = 0x1,
    _,
};

/// Comparator v1. (RM0444 18)
pub const COMP = extern struct {
    /// Comparator control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// COMP enable bit.
        EN: u1,
        reserved4: u3 = 0,
        /// Comparator signal selector for inverting input INM.
        INMSEL: u4,
        /// Comparator signal selector for non-inverting input INP.
        INPSEL: u2,
        reserved11: u1 = 0,
        /// Comparator non-inverting input selector for window mode.
        WINMODE: u1,
        reserved14: u2 = 0,
        /// Comparator output selector.
        WINOUT: u1,
        /// Comparator polarity selector.
        POLARITY: POLARITY,
        /// Comparator hysteresis selector.
        HYST: HYST,
        /// Comparator power mode selector.
        PWRMODE: PWRMODE,
        /// Comparator blanking source selector.
        BLANKSEL: BLANKSEL,
        reserved30: u5 = 0,
        /// Comparator output status. (READ ONLY)
        VALUE_DO_NOT_SET: u1,
        /// CSR register lock.
        LOCK: u1,
    }),
};
