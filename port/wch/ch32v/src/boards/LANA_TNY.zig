// LANA TNY Board
// https://learn.adafruit.com/phyx-lana-tny-ch32v203/pinouts
// CH32V203
pub const microzig = @import("microzig");
pub const chip = @import("chip");
const ch32v = microzig.hal;

pub const cpu_frequency = 48_000_000; // 48 MHz

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init_48mhz_hsi();
    ch32v.time.init();
}

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOD = .{
        .PIN0 = .{
            .name = "ws2812",
            .mode = .{ .output = .general_purpose_push_pull },
            .speed = .max_50MHz,
        },
    },
};
