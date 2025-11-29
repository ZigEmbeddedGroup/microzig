// CH32V103最小系統
// CH32V103
pub const chip = @import("chip");
pub const microzig = @import("microzig");
const ch32v = microzig.hal;

pub const cpu_frequency = 48_000_000; // 48 MHz

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init_48mhz_hsi();
    ch32v.time.init();
}
