const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const BLANKING = enum(u4) {
    NoBlanking = 0x0,
    Tim1Oc5 = 0x1,
    Tim2Oc3 = 0x2,
    Tim3Oc3 = 0x3,
    Tim3Oc4 = 0x4,
    Tim8Oc5 = 0x5,
    Tim15Oc1 = 0x6,
    _,
};

pub const HYST = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const INMSEL = enum(u4) {
    VRef_1over4 = 0x0,
    VRef_1over2 = 0x1,
    VRef_3over4 = 0x2,
    VRef = 0x3,
    Inm4 = 0x4,
    Inm5 = 0x5,
    Inm6 = 0x6,
    Inm7 = 0x7,
    Inm8 = 0x8,
    Inm9 = 0x9,
    _,
};

pub const INPSEL = enum(u1) {
    INP1 = 0x0,
    INP2 = 0x1,
};

pub const PWRMODE = enum(u2) {
    /// High speed / full power
    High = 0x0,
    /// Medium speed / medium power
    Medium = 0x1,
    /// Medium speed / medium power
    MediumEither = 0x2,
    /// Ultra low power / ultra-low-power
    Low = 0x3,
};

/// COMP1.
pub const COMP = extern struct {
    /// Comparator status register.
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of CVAL) COMP channel 1 output status bit.
        @"CVAL[0]": u1,
        /// (2/2 of CVAL) COMP channel 1 output status bit.
        @"CVAL[1]": u1,
        reserved16: u14 = 0,
        /// (1/2 of CIF) COMP channel 1 Interrupt Flag.
        @"CIF[0]": u1,
        /// (2/2 of CIF) COMP channel 1 Interrupt Flag.
        @"CIF[1]": u1,
        padding: u14 = 0,
    }),
    /// Comparator interrupt clear flag register.
    /// offset: 0x04
    ICFR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// (1/2 of CCIF) Clear COMP channel 1 Interrupt Flag.
        @"CCIF[0]": u1,
        /// (2/2 of CCIF) Clear COMP channel 1 Interrupt Flag.
        @"CCIF[1]": u1,
        padding: u14 = 0,
    }),
    /// Comparator option register.
    /// offset: 0x08
    OR: mmio.Mmio(packed struct(u32) {
        /// Selection of source for alternate function of output ports.
        AFOP: u11,
        padding: u21 = 0,
    }),
    /// Comparator configuration register 1.
    /// offset: 0x0c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// COMP channel 1 enable bit.
        EN: u1,
        /// Scaler bridge enable.
        BRGEN: u1,
        /// Voltage scaler enable bit.
        SCALEN: u1,
        /// COMP channel 1 polarity selection bit.
        POLARITY: u1,
        reserved6: u2 = 0,
        /// COMP channel 1 interrupt enable.
        ITEN: u1,
        reserved8: u1 = 0,
        /// COMP channel 1 hysteresis selection bits.
        HYST: HYST,
        reserved12: u2 = 0,
        /// Power Mode of the COMP channel 1.
        PWRMODE: PWRMODE,
        reserved16: u2 = 0,
        /// COMP channel 1 inverting input selection field.
        INMSEL: INMSEL,
        /// COMP channel 1 non-inverting input selection bit.
        INPSEL: INPSEL,
        reserved24: u3 = 0,
        /// COMP channel 1 blanking source selection bits.
        BLANKING: BLANKING,
        reserved31: u3 = 0,
        /// Lock bit.
        LOCK: u1,
    }),
    /// Comparator configuration register 2.
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// COMP channel 1 enable bit.
        EN: u1,
        /// Scaler bridge enable.
        BRGEN: u1,
        /// Voltage scaler enable bit.
        SCALEN: u1,
        /// COMP channel 1 polarity selection bit.
        POLARITY: u1,
        /// Window comparator mode selection bit.
        WINMODE: u1,
        reserved6: u1 = 0,
        /// COMP channel 1 interrupt enable.
        ITEN: u1,
        reserved8: u1 = 0,
        /// COMP channel 1 hysteresis selection bits.
        HYST: HYST,
        reserved12: u2 = 0,
        /// Power Mode of the COMP channel 1.
        PWRMODE: PWRMODE,
        reserved16: u2 = 0,
        /// COMP channel 1 inverting input selection field.
        INMSEL: INMSEL,
        /// COMP channel 1 non-inverting input selection bit.
        INPSEL: INPSEL,
        reserved24: u3 = 0,
        /// COMP channel 1 blanking source selection bits.
        BLANKING: BLANKING,
        reserved31: u3 = 0,
        /// Lock bit.
        LOCK: u1,
    }),
};
