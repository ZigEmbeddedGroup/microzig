// CH32V103最小系統
// CH32V103
pub const chip = @import("chip");
pub const microzig = @import("microzig");
const ch32v = microzig.hal;

/// Clock configuration for this board
pub const clock_config: ch32v.clocks.Config = .{
    .source = .hsi,
    .target_frequency = 48_000_000,
};

/// CPU frequency is derived from clock config
pub const cpu_frequency = clock_config.target_frequency;

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init(clock_config);
    ch32v.time.init();
}
