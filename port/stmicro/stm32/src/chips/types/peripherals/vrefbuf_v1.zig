const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const HIZ = enum(u1) {
    /// VREF+ pin is internally connected to the voltage reference buffer output.
    Connected = 0x0,
    /// VREF+ pin is high impedance.
    HighZ = 0x1,
};

pub const VRS = enum(u1) {
    /// Voltage reference set to VREF_OUT1 (around 2.048 V).
    Vref0 = 0x0,
    /// Voltage reference set to VREF_OUT2 (around 2.5 V).
    Vref1 = 0x1,
};

/// Voltage reference buffer.
pub const VREFBUF = extern struct {
    /// control and status register.
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Voltage reference buffer mode enable.
        ENVR: u1,
        /// High impedance mode.
        HIZ: HIZ,
        /// Voltage reference scale.
        VRS: VRS,
        /// Voltage reference buffer ready.
        VRR: u1,
        padding: u28 = 0,
    }),
    /// calibration control register.
    /// offset: 0x04
    CCR: mmio.Mmio(packed struct(u32) {
        /// Trimming code.
        TRIM: u6,
        padding: u26 = 0,
    }),
};
