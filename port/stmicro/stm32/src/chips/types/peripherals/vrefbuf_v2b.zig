const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const HIZ = enum(u1) {
    /// VREF+ pin is internally connected to the voltage reference buffer output.
    Connected = 0x0,
    /// VREF+ pin is high impedance.
    HighZ = 0x1,
};

pub const VRS = enum(u2) {
    /// Voltage reference set to VREF_OUT1 (around 2.048 V).
    Vref0 = 0x0,
    /// Voltage reference set to VREF_OUT2 (around 2.5 V).
    Vref1 = 0x1,
    /// Voltage reference set to VREF_OUT2 (around 2.5 V).
    Vref2 = 0x2,
    _,
};

/// Voltage reference buffer.
pub const VREFBUF = extern struct {
    /// VREF_BUF Control and Status Register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Enable Voltage Reference.
        ENVR: u1,
        /// High impedence mode for the VREF_BUF.
        HIZ: HIZ,
        reserved3: u1 = 0,
        /// Voltage reference buffer ready.
        VRR: u1,
        /// Voltage reference scale.
        VRS: VRS,
        padding: u26 = 0,
    }),
    /// VREF_BUF Calibration Control Register.
    /// offset: 0x04
    CCR: mmio.Mmio(packed struct(u32) {
        /// Trimming code.
        TRIM: u6,
        padding: u26 = 0,
    }),
};
