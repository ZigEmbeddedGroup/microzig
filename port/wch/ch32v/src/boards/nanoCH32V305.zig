// nanoCH32V305
// https://github.com/wuxx/nanoCH32V305
// CH32V305RBT6
pub const chip = @import("chip");
pub const microzig = @import("microzig");
const ch32v = microzig.hal;

pub const cpu_frequency = 8_000_000; // 8 MHz

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN3 = .{
            .name = "led",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};
