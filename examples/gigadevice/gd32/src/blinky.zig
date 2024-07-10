const std = @import("std");
const microzig = @import("microzig");
const gd32 = microzig.hal;

const pin_config = gd32.pins.GlobalConfiguration{
    .GPIOC = .{
        .PIN13 = .{ .name = "led", .mode = .{ .output = .general_purpose_push_pull } },
    },
    .GPIOA = .{
        .PIN1 = .{ .name = "green", .mode = .{ .output = .general_purpose_push_pull } },
        .PIN2 = .{ .name = "blue", .mode = .{ .output = .general_purpose_push_pull } },
    },
};

pub fn main() !void {
    const pins = pin_config.apply();
    pins.green.put(0);
    pins.blue.put(1);

    while (true) {
        var i: u32 = 0;
        while (i < 800_000) {
            asm volatile ("nop");
            i += 1;
        }
        pins.led.toggle();
        pins.green.toggle();
        pins.blue.toggle();
    }
}
