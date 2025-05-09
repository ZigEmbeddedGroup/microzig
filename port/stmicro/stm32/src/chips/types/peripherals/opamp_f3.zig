const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CALSEL = enum(u2) {
    /// VREFOPAMP=3.3% VDDA
    Percent3_3 = 0x0,
    /// VREFOPAMP=10% VDDA
    Percent10 = 0x1,
    /// VREFOPAMP=50% VDDA
    Percent50 = 0x2,
    /// VREFOPAMP=90% VDDA
    Percent90 = 0x3,
};

pub const FORCE_VP = enum(u1) {
    /// Normal operating mode
    Normal = 0x0,
    /// Calibration mode. Non-inverting input connected to calibration reference
    Calibration = 0x1,
};

pub const OUTCAL = enum(u1) {
    /// Non-inverting < inverting
    Low = 0x0,
    /// Non-inverting > inverting
    High = 0x1,
};

pub const PGA_GAIN = enum(u4) {
    /// Gain 2
    Gain2 = 0x0,
    /// Gain 4
    Gain4 = 0x1,
    /// Gain 8
    Gain8 = 0x2,
    /// Gain 16
    Gain16 = 0x4,
    /// Gain 2, feedback connected to VM0
    Gain2_VM0 = 0x8,
    /// Gain 4, feedback connected to VM0
    Gain4_VM0 = 0x9,
    /// Gain 8, feedback connected to VM0
    Gain8_VM0 = 0xa,
    /// Gain 16, feedback connected to VM0
    Gain16_VM0 = 0xb,
    /// Gain 2, feedback connected to VM1
    Gain2_VM1 = 0xc,
    /// Gain 4, feedback connected to VM1
    Gain4_VM1 = 0xd,
    /// Gain 8, feedback connected to VM1
    Gain8_VM1 = 0xe,
    /// Gain 16, feedback connected to VM1
    Gain16_VM1 = 0xf,
    _,
};

pub const VMS_SEL = enum(u1) {
    /// PC5 (VM0) used as OPAMP2 inverting input when TCM_EN=1
    PC5 = 0x0,
    /// PA5 (VM1) used as OPAMP2 inverting input when TCM_EN=1
    PA5 = 0x1,
};

pub const VM_SEL = enum(u2) {
    /// PC5 (VM0) used as OPAMP2 inverting input
    PC5 = 0x0,
    /// PA5 (VM1) used as OPAMP2 inverting input
    PA5 = 0x1,
    /// Resistor feedback output (PGA mode)
    PGA = 0x2,
    /// Follower mode
    Follower = 0x3,
};

pub const VPS_SEL = enum(u2) {
    /// PB14 used as OPAMP2 non-inverting input when TCM_EN=1
    PB14 = 0x1,
    /// PB0 used as OPAMP2 non-inverting input when TCM_EN=1
    PB0 = 0x2,
    /// PA7 used as OPAMP2 non-inverting input when TCM_EN=1
    PA7 = 0x3,
    _,
};

pub const VP_SEL = enum(u2) {
    /// PB14 used as OPAMP2 non-inverting input
    PB14 = 0x1,
    /// PB0 used as OPAMP2 non-inverting input
    PB0 = 0x2,
    /// PA7 used as OPAMP2 non-inverting input
    PA7 = 0x3,
    _,
};

/// Operational Amplifier
pub const OPAMP = extern struct {
    /// OPAMP control/status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// OPAMP enable
        OPAMPEN: u1,
        /// Forces a calibration reference voltage on non-inverting input and disables external connections.
        FORCE_VP: FORCE_VP,
        /// OPAMP Non inverting input selection
        VP_SEL: VP_SEL,
        reserved5: u1 = 0,
        /// OPAMP inverting input selection
        VM_SEL: VM_SEL,
        /// Timer controlled Mux mode enable
        TCM_EN: u1,
        /// OPAMP inverting input secondary selection
        VMS_SEL: VMS_SEL,
        /// OPAMP Non inverting input secondary selection
        VPS_SEL: VPS_SEL,
        /// Calibration mode enable
        CALON: u1,
        /// Calibration selection
        CALSEL: CALSEL,
        /// Gain in PGA mode
        PGA_GAIN: PGA_GAIN,
        /// User trimming enable
        USER_TRIM: u1,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5,
        /// Output the internal reference voltage
        TSTREF: u1,
        /// OPAMP ouput status flag
        OUTCAL: OUTCAL,
        /// OPAMP lock
        LOCK: u1,
    }),
};
