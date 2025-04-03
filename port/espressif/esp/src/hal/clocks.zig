const std = @import("std");
const microzig = @import("microzig");
const compatibility = microzig.hal.compatibility;

// NOTE: maybe we should make xtal clock frequency comptime known (and configurable
// for other chips that require it)?

var maybe_active: ?Config = null;

/// Gets the active clock config. Asserts **there is** an active clock config (this
/// is the case if the `init` function hasn't been overwritten);
pub fn active_config() Config {
    return maybe_active.?;
}

/// Applies the given clock config.
pub fn apply(config: Config) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    config.apply();
    maybe_active = config;
}

/// Clock config init error.
pub const Error = error{
    InvalidCpuClockFrequency,
};

/// Cpu clock source descriptor for this specific chip. May vary from chip to chip with platform.
pub const CpuClockSource = chip_specific.CpuClockSource;

/// Clock config for this specific chip.
/// Required fields:
/// - `cpu_clk_freq`: cpu clock frequency
/// - `xtal_clk_freq`: xtal clock frequency
/// - `apb_clk_freq`: xtal clock frequency
/// - `cpu_clk_source`: platform specific cpu clock source
/// Required methods:
/// - `init_from_cpu_clock_source`
/// - `init_from_cpu_freq`
/// - `apply`: internal use only
pub const Config = chip_specific.Config;

const chip_specific = switch (compatibility.chip) {
    .esp32_c3 => @import("clocks/esp32_c3.zig"),
};
