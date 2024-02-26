const std = @import("std");
const microzig = @import("microzig");
const stm32 = microzig.hal;

const pin_config = stm32.pins.GlobalConfiguration{
    .GPIOC = .{
        .PIN13 = .{ .name = "led", .mode = .{ .output = .general_purpose_push_pull } },
    },
};

pub fn main() !void {
    const pins = pin_config.apply();

    while (true) {
        var i: u32 = 0;
        while (i < 800_000) {
            asm volatile ("nop");
            i += 1;
        }
        pins.led.toggle();
    }
}
