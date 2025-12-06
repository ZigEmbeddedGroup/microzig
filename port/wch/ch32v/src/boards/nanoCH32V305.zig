// nanoCH32V305
// https://github.com/wuxx/nanoCH32V305
// CH32V305RBT6
pub const chip = @import("chip");
pub const microzig = @import("microzig");
const ch32v = microzig.hal;

pub const cpu_frequency = 48_000_000; // 48 MHz

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN3 = .{
            .name = "led",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};

/// Board-specific init: set 48 MHz clock, enable SysTick time
pub fn init() void {
    ch32v.clocks.init_48mhz_hsi();
    ch32v.time.init();
}
