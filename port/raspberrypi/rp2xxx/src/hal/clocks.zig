const std = @import("std");

const microzig = @import("microzig");
const CLOCKS = microzig.chip.peripherals.CLOCKS;

const chip = @import("compatibility.zig").chip;

// Re-export of platform rectified clocks implementation
const chip_specific = switch (chip) {
    .RP2040 => @import("clocks/rp2040.zig"),
    .RP2350, .RP2350_QFN80 => @import("clocks/rp2350.zig"),
};

/// Defines the potential sources a clock generator can take. Different clock generators will support
/// a subset of these, so comptime checks are used to ensure correct configuration.
pub const Source = chip_specific.Source;

pub const config = struct {
    /// Represents a full system clock configuration that can be applied to the sytem
    /// via the apply() method.
    pub const Global = chip_specific.config.Global;

    /// Parameters needed to configure a specific clock generator
    pub const Generator = Global.GeneratorConfig;

    /// Convenience functions for generating Global clock configs from simple inputs.
    /// For instance, this HAL uses preset.default() to get the config
    /// used in its init() function.
    pub const preset = chip_specific.config.preset;
};

pub const xosc = chip_specific.xosc;

/// Start tick timers based on CLK_REF
pub const start_ticks = chip_specific.start_ticks;

/// A standard startup procedure for clocks that assumes XOSC will be used, and that tick counters
/// should be initialized.
pub fn default_startup_procedure(comptime cfg: config.Global) void {

    // disable resus if it has been turned on elsewhere
    CLOCKS.CLK_SYS_RESUS_CTRL.raw = 0;

    xosc.init();
    cfg.apply();
    start_ticks(1, cfg.get_frequency(.clk_ref).?);
}
