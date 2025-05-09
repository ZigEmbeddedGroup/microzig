const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const HYST = enum(u3) {
    None = 0x0,
    /// 10mV hysteresis
    Hyst10m = 0x1,
    /// 20mV hysteresis
    Hyst20m = 0x2,
    /// 30mV hysteresis
    Hyst30m = 0x3,
    /// 40mV hysteresis
    Hyst40m = 0x4,
    /// 50mV hysteresis
    Hyst50m = 0x5,
    /// 60mV hysteresis
    Hyst60m = 0x6,
    /// 70mV hysteresis
    Hyst70m = 0x7,
};

pub const POLARITY = enum(u1) {
    /// Non-inverted polarity
    NonInverted = 0x0,
    /// Inverted polarity
    Inverted = 0x1,
};

/// Comparator v2. (RM0440 24)
pub const COMP = extern struct {
    /// Comparator control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// COMP enable bit.
        EN: u1,
        reserved4: u3 = 0,
        /// Comparator signal selector for inverting input INM. (RM0440 24.3.2 Table 197)
        INMSEL: u3,
        reserved8: u1 = 0,
        /// Comparator signal selector for non-inverting input INP. (RM0440 24.3.2 Table 196)
        INPSEL: u1,
        reserved15: u6 = 0,
        /// Comparator polarity selector.
        POLARITY: POLARITY,
        /// Comparator hysteresis selector.
        HYST: HYST,
        /// Comparator blanking source selector. (RM0440 24.3.6 Table 198)
        BLANKSEL: u3,
        /// Vrefint resistor bridge enable. (RM0440 24.6)
        BRGEN: u1,
        /// Vrefint scaled input enable. (RM0440 24.6)
        SCALEN: u1,
        reserved30: u6 = 0,
        /// Comparator output status. (READ ONLY)
        VALUE_DO_NOT_SET: u1,
        /// CSR register lock.
        LOCK: u1,
    }),
};
