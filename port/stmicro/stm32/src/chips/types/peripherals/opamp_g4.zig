const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

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

pub const OPAHSM = enum(u1) {
    /// OpAmp in normal mode
    Normal = 0x0,
    /// OpAmp in high speed mode
    HighSpeed = 0x1,
};

pub const OPAINTOEN = enum(u1) {
    /// Output is connected to the output Pin
    OutputPin = 0x0,
    /// Output is connected internally to ADC channel
    ADCChannel = 0x1,
};

pub const OUTCAL = enum(u1) {
    /// Non-inverting < inverting
    Low = 0x0,
    /// Non-inverting > inverting
    High = 0x1,
};

pub const PGA_GAIN = enum(u5) {
    /// Gain 2
    Gain2 = 0x0,
    /// Gain 4
    Gain4 = 0x1,
    /// Gain 8
    Gain8 = 0x2,
    /// Gain 16
    Gain16 = 0x3,
    /// Gain 32
    Gain32 = 0x4,
    /// Gain 64
    Gain64 = 0x5,
    /// Gain 2, input/bias connected to VINM0 or inverting gain
    Gain2_InputVINM0 = 0x8,
    /// Gain 4, input/bias connected to VINM0 or inverting gain
    Gain4_InputVINM0 = 0x9,
    /// Gain 8, input/bias connected to VINM0 or inverting gain
    Gain8_InputVINM0 = 0xa,
    /// Gain 16, input/bias connected to VINM0 or inverting gain
    Gain16_InputVINM0 = 0xb,
    /// Gain 32, input/bias connected to VINM0 or inverting gain
    Gain32_InputVINM0 = 0xc,
    /// Gain 64, input/bias connected to VINM0 or inverting gain
    Gain64_InputVINM0 = 0xd,
    /// Gain 2, with filtering on VINM0
    Gain2_FilteringVINM0 = 0x10,
    /// Gain 4, with filtering on VINM0
    Gain4_FilteringVINM0 = 0x11,
    /// Gain 8, with filtering on VINM0
    Gain8_FilteringVINM0 = 0x12,
    /// Gain 16, with filtering on VINM0
    Gain16_FilteringVINM0 = 0x13,
    /// Gain 32, with filtering on VINM0
    Gain32_FilteringVINM0 = 0x14,
    /// Gain 64, with filtering on VINM0
    Gain64_FilteringVINM0 = 0x15,
    /// Gain 2, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain2_InputVINM0FilteringVINM1 = 0x18,
    /// Gain 4, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain4_InputVINM0FilteringVINM1 = 0x19,
    /// Gain 8, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain8_InputVINM0FilteringVINM1 = 0x1a,
    /// Gain 16, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain16_InputVINM0FilteringVINM1 = 0x1b,
    /// Gain 32, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain32_InputVINM0FilteringVINM1 = 0x1c,
    /// Gain 64, input/bias connected to VINM0 with filtering on VINM1 or inverting gain
    Gain64_InputVINM0FilteringVINM1 = 0x1d,
    _,
};

pub const USERTRIM = enum(u1) {
    /// Factory trim used
    Factory = 0x0,
    /// User trim used
    User = 0x1,
};

pub const VM_SEL = enum(u2) {
    /// VINM0 connected to VINM input
    VINM0 = 0x0,
    /// VINM1 connected to VINM input
    VINM1 = 0x1,
    /// Feedback resistor connected to VINM (PGA mode)
    PGA = 0x2,
    /// OpAmp output connected to VINM (Follower mode)
    Output = 0x3,
};

pub const VPS_SEL = enum(u2) {
    /// VINP0 connected to VINP input
    VINP0 = 0x0,
    /// VINP1 connected to VINP input
    VINP1 = 0x1,
    /// VINP2 connected to VINP input
    VINP2 = 0x2,
    /// DAC3_CH1 connected to VINP input
    DAC3_CH1 = 0x3,
};

pub const VP_SEL = enum(u2) {
    /// VINP0 connected to VINP input
    VINP0 = 0x0,
    /// VINP1 connected to VINP input
    VINP1 = 0x1,
    /// VINP2 connected to VINP input
    VINP2 = 0x2,
    /// DAC3_CH1 connected to VINP input
    DAC3_CH1 = 0x3,
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
        /// VP_SEL
        VP_SEL: VP_SEL,
        /// USERTRIM
        USERTRIM: USERTRIM,
        /// OPAMP inverting input selection
        VM_SEL: VM_SEL,
        /// OPAHSM
        OPAHSM: OPAHSM,
        /// OPAINTOEN
        OPAINTOEN: OPAINTOEN,
        reserved11: u2 = 0,
        /// Calibration mode enable
        CALON: u1,
        /// Calibration selection
        CALSEL: CALSEL,
        /// Gain in PGA mode
        PGA_GAIN: PGA_GAIN,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5,
        reserved30: u1 = 0,
        /// OPAMP ouput status flag
        OUTCAL: OUTCAL,
        /// LOCK
        LOCK: u1,
    }),
    /// offset: 0x04
    reserved4: [20]u8,
    /// OPAMP control/status register
    /// offset: 0x18
    TCMR: mmio.Mmio(packed struct(u32) {
        /// VMS_SEL
        VMS_SEL: u1,
        /// VPS_SEL
        VPS_SEL: VPS_SEL,
        /// T1CM_EN
        T1CM_EN: u1,
        /// T8CM_EN
        T8CM_EN: u1,
        /// T20CM_EN
        T20CM_EN: u1,
        reserved31: u25 = 0,
        /// TCMR LOCK
        LOCK: u1,
    }),
};
