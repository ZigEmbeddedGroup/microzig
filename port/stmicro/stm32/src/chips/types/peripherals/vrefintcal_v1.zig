const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// VREFINT Factory Calibration
pub const VREFINTCAL = extern struct {
    /// Factory calibration
    /// offset: 0x00
    DATA: u32,
};
