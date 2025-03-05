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
        } else if (comptime microzig.config.board_name != null and std.mem.eql(u8, microzig.config.board_name.?, "STM32F3DISCOVERY")) {
            const pins = (stm32.pins.GlobalConfiguration{ .GPIOE = .{
                .PE8 = .{ .mode = .{ .output = .push_pull } },
                .PE9 = .{ .mode = .{ .output = .push_pull } },
                .PE10 = .{ .mode = .{ .output = .push_pull } },
                .PE11 = .{ .mode = .{ .output = .push_pull } },
                .PE12 = .{ .mode = .{ .output = .push_pull } },
                .PE13 = .{ .mode = .{ .output = .push_pull } },
                .PE14 = .{ .mode = .{ .output = .push_pull } },
                .PE15 = .{ .mode = .{ .output = .push_pull } },
            } }).apply();
            const all_leds = .{
                pins.PE8,
                pins.PE9,
                pins.PE10,
                pins.PE11,
                pins.PE12,
                pins.PE13,
                pins.PE14,
                pins.PE15,
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
