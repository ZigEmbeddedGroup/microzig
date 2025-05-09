const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const CALON = enum(u1) {
    /// Normal mode.
    Normal = 0x0,
    /// Calibration mode (all switches opened by HW).
    Calibration = 0x1,
};

pub const CALSEL = enum(u1) {
    /// NMOS calibration (200mV applied on OPAMP inputs).
    NMOS = 0x0,
    /// PMOS calibration (VDDA-200mV applied on OPAMP inputs).
    PMOS = 0x1,
};

pub const OPALPM = enum(u1) {
    /// operational amplifier in normal mode.
    Normal = 0x0,
    /// operational amplifier in low-power mode.
    LowPower = 0x1,
};

pub const OPAMODE = enum(u2) {
    /// internal PGA disable.
    Disable = 0x0,
    /// internal PGA disable. (Duplicate)
    Disable2 = 0x1,
    /// internal PGA enable, gain programmed in PGA_GAIN.
    Enable = 0x2,
    /// internal follower.
    Follower = 0x3,
};

pub const OPA_RANGE = enum(u1) {
    /// Low range (VDDA < 2.4V).
    Low = 0x0,
    /// High range (VDDA > 2.4V).
    High = 0x1,
};

pub const PGA_GAIN = enum(u2) {
    /// internal PGA Gain 2.
    Gain2 = 0x0,
    /// internal PGA Gain 4.
    Gain4 = 0x1,
    /// internal PGA Gain 8.
    Gain8 = 0x2,
    /// internal PGA Gain 16.
    Gain16 = 0x3,
};

pub const USERTRIM = enum(u1) {
    /// Factory trim code used.
    Factory = 0x0,
    /// User trim code used.
    User = 0x1,
};

pub const VM_SEL = enum(u2) {
    /// GPIO connected to VINM (valid also in PGA mode for filtering).
    VINM = 0x0,
    /// Inverting input not externally connected. These configurations are valid only when OPAMODE = 10 (PGA mode)
    NotConnected = 0x2,
    _,
};

pub const VP_SEL = enum(u1) {
    /// GPIO connected to VINP.
    VINP = 0x0,
    /// DAC connected to VINP.
    DAC = 0x1,
};

/// OPAMP address block description.
pub const OPAMP = extern struct {
    /// OPAMP control/status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Operational amplifier Enable.
        OPAMPEN: u1,
        /// Operational amplifier Low Power Mode. The operational amplifier must be disable to change this configuration.
        OPALPM: OPALPM,
        /// Operational amplifier PGA mode.
        OPAMODE: OPAMODE,
        /// Operational amplifier Programmable amplifier gain value.
        PGA_GAIN: PGA_GAIN,
        reserved8: u2 = 0,
        /// Inverting input selection. These bits are used only when OPAMODE = 00, 01 or 10. 1x: Inverting input not externally connected. These configurations are valid only when OPAMODE = 10 (PGA mode).
        VM_SEL: VM_SEL,
        /// Non inverted input selection.
        VP_SEL: VP_SEL,
        reserved12: u1 = 0,
        /// Calibration mode enabled.
        CALON: CALON,
        /// Calibration selection.
        CALSEL: CALSEL,
        /// allows to switch from factory AOP offset trimmed values to AOP offset user trimmed values This bit is active for both mode normal and low-power.
        USERTRIM: USERTRIM,
        /// Operational amplifier calibration output During calibration mode offset is trimmed when this signal toggle.
        CALOUT: u1,
        reserved31: u15 = 0,
        /// Operational amplifier power supply range for stability All AOP must be in power down to allow AOP-RANGE bit write. It applies to all AOP embedded in the product.
        OPA_RANGE: OPA_RANGE,
    }),
    /// OPAMP offset trimming register in normal mode.
    /// offset: 0x04
    OTR: mmio.Mmio(packed struct(u32) {
        /// Trim for NMOS differential pairs.
        TRIMOFFSETN: u5,
        reserved8: u3 = 0,
        /// Trim for PMOS differential pairs.
        TRIMOFFSETP: u5,
        padding: u19 = 0,
    }),
    /// OPAMP offset trimming register in low-power mode.
    /// offset: 0x08
    LPOTR: mmio.Mmio(packed struct(u32) {
        /// Low-power mode trim for NMOS differential pairs.
        TRIMLPOFFSETN: u5,
        reserved8: u3 = 0,
        /// Low-power mode trim for PMOS differential pairs.
        TRIMLPOFFSETP: u5,
        padding: u19 = 0,
    }),
};
