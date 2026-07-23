// CH32V307V_MINI
// CH32V307
pub const microzig = @import("microzig");
pub const chip = @import("chip");
const ch32v = microzig.hal;

pub const product_string = "ch32v307 Demo Device";

/// Clock configuration for this board
pub const clock_config: ch32v.clocks.Config = .{
    .source = .hse,
    .hse_frequency = 8_000_000,
    .target_frequency = 48_000_000,
};

/// CPU frequency is derived from clock config
pub const cpu_frequency = clock_config.target_frequency;

/// Board-specific init: set 48 MHz clocks for the CPU and USBHS, enable SysTick time
pub fn init() void {
    ch32v.clocks.init(clock_config);
    ch32v.clocks.enable_usbhs_clock(.{
        .ref_source_hz = clock_config.hse_frequency.?,
        .ref_source = .hse,
    });
    ch32v.time.init();
}
