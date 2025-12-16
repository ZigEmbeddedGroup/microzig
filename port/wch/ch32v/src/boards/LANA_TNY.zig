// LANA TNY Board
// https://learn.adafruit.com/phyx-lana-tny-ch32v203/pinouts
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

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init(clock_config);
    ch32v.time.init();
}

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOD = .{
        .PIN0 = .{
            .name = "ws2812",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};
