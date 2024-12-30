const std = @import("std");
const microzig = @import("microzig");
const stm32 = microzig.hal;

fn delay() void {
    var i: u32 = 0;
    while (i < 800_000) {
        asm volatile ("nop");
        i += 1;
    }
}

pub fn main() !void {
    const pins, const all_leds = res: {
        if (comptime std.mem.eql(u8, microzig.config.chip_name, "STM32F103C8")) {
            const pins = (stm32.pins.GlobalConfiguration{ .GPIOC = .{
                .PIN13 = .{ .name = "led", .mode = .{ .output = .general_purpose_push_pull } },
            } }).apply();
            const all_leds = .{
                pins.led,
            };
            break :res .{ pins, all_leds };
        } else {
            @compileError("blinky is not (yet?) implemented for this target");
        }
    };
    _ = pins;

    while (true) {
        delay();
        for (0..all_leds.len) |k| {
            switch (@as(u3, @intCast(k))) {
                inline else => |i| {
                    if (i >= all_leds.len) unreachable;
                    all_leds[i].toggle();
                },
            }
        }
    }
}
