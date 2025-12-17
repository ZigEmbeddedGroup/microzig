// CH32V003F4P6_MINI
// CH32V003
pub const chip = @import("chip");
pub const microzig = @import("microzig");
const ch32v = microzig.hal;

/// Clock configuration for this board
/// CH32V003 runs at 24 MHz when using HSI with PLL
pub const clock_config: ch32v.clocks.Config = .{
    .source = .hsi,
    .target_frequency = 24_000_000,
};

/// CPU frequency is derived from clock config
pub const cpu_frequency = clock_config.target_frequency;
