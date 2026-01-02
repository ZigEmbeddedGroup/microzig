// Suzuduino Uno V1b
// https://github.com/verylowfreq/suzuduino-uno-v1
// CH32V203
pub const microzig = @import("microzig");
pub const chip = @import("chip");
const ch32v = microzig.hal;

/// Clock configuration for this board
pub const clock_config: ch32v.clocks.Config = .{
    .source = .hsi,
    .target_frequency = 48_000_000,
};

/// CPU frequency is derived from clock config
pub const cpu_frequency = clock_config.target_frequency;

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN5 = .{
            .name = "led",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init(clock_config);
    ch32v.time.init();
}
