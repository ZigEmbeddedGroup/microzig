const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const CALON = enum(u1) {
    /// Normal mode
    Normal = 0x0,
    /// Calibration mode (all switches opened by HW)
    Calibration = 0x1,
};

pub const CALOUT = enum(u1) {
    /// Non-inverting < inverting
    Less = 0x0,
    /// Non-inverting > inverting
    Greater = 0x1,
};

pub const CALSEL = enum(u2) {
    /// VREFOPAMP=3.3% VDDA.
    Percent3_3 = 0x0,
    /// VREFOPAMP=10% VDDA.
    Percent10 = 0x1,
    /// VREFOPAMP=50% VDDA.
    Percent50 = 0x2,
    /// VREFOPAMP=90% VDDA.
    Percent90 = 0x3,
};

pub const FORCE_VP = enum(u1) {
    /// Normal operating mode. Non-inverting input connected to inputs.
    NormalOperating = 0x0,
    /// Calibration verification mode. Non-inverting input connected to calibration reference voltage.
    CalibrationVerification = 0x1,
};

pub const OPAHSM = enum(u1) {
    /// operational amplifier in normal mode
    Normal = 0x0,
    /// operational amplifier in high-speed mode
    HighSpeed = 0x1,
};

pub const PGA_GAIN = enum(u4) {
    /// Non-inverting internal Gain 2, VREF- referenced
    Gain2 = 0x0,
    /// Non-inverting internal Gain 4, VREF- referenced
    Gain4 = 0x1,
    /// Non-inverting internal Gain 8, VREF- referenced
    Gain8 = 0x2,
    /// Non-inverting internal Gain 16, VREF- referenced
    Gain16 = 0x3,
    /// Non-inverting internal Gain 2 with filtering on INM0, VREF- referenced
    Gain2_FilteringVINM0 = 0x4,
    /// Non-inverting internal Gain 4 with filtering on INM0, VREF- referenced
    Gain4_FilteringVINM0 = 0x5,
    /// Non-inverting internal Gain 8 with filtering on INM0, VREF- referenced
    Gain8_FilteringVINM0 = 0x6,
    /// Non-inverting internal Gain 8 with filtering on INM0, VREF- referenced
    Gain16_FilteringVINM0 = 0x7,
    /// Inverting gain=-1/ Non-inverting gain =2 with INM0 node for input or bias
    Gain2InvGainNeg1_InputVINM0 = 0x8,
    /// Inverting gain=-3/ Non-inverting gain =4 with INM0 node for input or bias
    Gain4InvGainNeg3_InputVINM0 = 0x9,
    /// Inverting gain=-7/ Non-inverting gain =8 with INM0 node for input or bias
    Gain8InvGainNeg7_InputVINM0 = 0xa,
    /// Inverting gain=-15/ Non-inverting gain =16 with INM0 node for input or bias
    Gain16InvGainNeg15_InputVINM0 = 0xb,
    /// Inverting gain=-1/ Non-inverting gain =2 with INM0 node for input or bias, INM1 node for filtering
    Gain2InvGainNeg1_InputVINM0FilteringVINM1 = 0xc,
    /// Inverting gain=-3/ Non-inverting gain =4 with INM0 node for input or bias, INM1 node for filtering
    Gain4InvGainNeg3_InputVINM0FilteringVINM1 = 0xd,
    /// Inverting gain=-7/ Non-inverting gain =8 with INM0 node for input or bias, INM1 node for filtering
    Gain8InvGainNeg7_InputVINM0FilteringVINM1 = 0xe,
    /// Inverting gain=-15/ Non-inverting gain =16 with INM0 node for input or bias, INM1 node for filtering
    Gain16InvGainNeg15_InputVINM0FilteringVINM1 = 0xf,
};

pub const USERTRIM = enum(u1) {
    /// \'factory\' trim code used
    Factory = 0x0,
    /// \'user\' trim code used
    User = 0x1,
};

pub const VM_SEL = enum(u2) {
    /// INM0 connected to OPAMP_VINM input
    Inm0 = 0x0,
    /// INM1 connected to OPAMP_VINM input
    Inm1 = 0x1,
    /// Feedback resistor is connected to the OPAMP_VINM input (PGA mode), Inverting input selection depends on the PGA_GAIN setting
    Pga = 0x2,
    /// opamp_out connected to OPAMP_VINM input (Follower mode)
    Follower = 0x3,
};

pub const VP_SEL = enum(u2) {
    /// GPIO connected to OPAMPx_VINP
    Gpio = 0x0,
    /// dac_outx connected to OPAMPx_VINP
    DacOut = 0x1,
    _,
};

/// Operational amplifiers.
pub const OPAMP = extern struct {
    /// OPAMP1 control/status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Operational amplifier Enable.
        OPAMPEN: u1,
        /// Force internal reference on VP (reserved for test.
        FORCE_VP: FORCE_VP,
        /// Operational amplifier PGA mode.
        VP_SEL: VP_SEL,
        reserved5: u1 = 0,
        /// Inverting input selection.
        VM_SEL: VM_SEL,
        reserved8: u1 = 0,
        /// Operational amplifier high-speed mode.
        OPAHSM: OPAHSM,
        reserved11: u2 = 0,
        /// Calibration mode enabled.
        CALON: CALON,
        /// Calibration selection.
        CALSEL: CALSEL,
        /// allows to switch from AOP offset trimmed values to AOP offset.
        PGA_GAIN: PGA_GAIN,
        /// User trimming enable.
        USERTRIM: USERTRIM,
        reserved29: u10 = 0,
        /// OPAMP calibration reference voltage output control (reserved for test).
        TSTREF: u1,
        /// Operational amplifier calibration output.
        CALOUT: CALOUT,
        padding: u1 = 0,
    }),
    /// OPAMP1 offset trimming register in normal mode.
    /// offset: 0x04
    OTR: mmio.Mmio(packed struct(u32) {
        /// Trim for NMOS differential pairs.
        TRIMOFFSETN: u5,
        reserved8: u3 = 0,
        /// Trim for PMOS differential pairs.
        TRIMOFFSETP: u5,
        padding: u19 = 0,
    }),
    /// OPAMP1 offset trimming register in low-power mode.
    /// offset: 0x08
    HSOTR: mmio.Mmio(packed struct(u32) {
        /// Trim for NMOS differential pairs.
        TRIMLPOFFSETN: u5,
        reserved8: u3 = 0,
        /// Trim for PMOS differential pairs.
        TRIMLPOFFSETP: u5,
        padding: u19 = 0,
    }),
};
