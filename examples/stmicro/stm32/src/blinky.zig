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
            const pins = (stm32.pins.GlobalConfiguration{
                .GPIOE = .{
                    .PIN8 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN9 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN10 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN11 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN12 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN13 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN14 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                    .PIN15 = .{ .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
                },
            }).apply();
            const all_leds = .{
                pins.PIN8,
                pins.PIN9,
                pins.PIN10,
                pins.PIN11,
                pins.PIN12,
                pins.PIN13,
                pins.PIN14,
                pins.PIN15,
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
