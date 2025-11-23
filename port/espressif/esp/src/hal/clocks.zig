const std = @import("std");
const microzig = @import("microzig");

const compatibility = @import("compatibility.zig");

/// Clock config init error.
pub const Error = error{
    InvalidCpuClockFrequency,
};

/// Xtal clock frequency.
pub const xtal_clk_freq = chip_specific.xtal_clk_freq;

/// Cpu clock source descriptor for this specific chip. May vary from chip to chip with platform.
pub const CpuClockSource = chip_specific.CpuClockSource;

/// Clock config for this specific chip.
/// Required decls:
/// - `default`: default clock configuration
/// Required fields:
/// - `cpu_clk_freq`
/// - `xtal_clk_freq`
/// - `apb_clk_freq`
/// - `cpu_clk_source`
/// Required methods:
/// - `init`
/// - `init_comptime`
/// - `init_from_cpu_clock_source`
/// - `apply`
pub const Config = chip_specific.Config;

const chip_specific = switch (compatibility.chip) {
    .esp32_c3 => @import("clocks/esp32_c3.zig"),
};
