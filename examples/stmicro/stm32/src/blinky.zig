const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

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
            const pins = (hal.pins.GlobalConfiguration{ .GPIOC = .{
                .PIN13 = .{ .name = "led", .mode = .{ .output = .general_purpose_push_pull } },
            } }).apply();
            const all_leds = .{
                pins.led,
            };
            break :res .{ pins, all_leds };
        } else if (comptime microzig.config.board_name != null and std.mem.eql(u8, microzig.config.board_name.?, "STM32F303NUCLEO")) {
            const pins = board.leds_config.apply();
            const all_leds = .{
                pins.LD2,
            };
            break :res .{ pins, all_leds };
        } else if (comptime microzig.config.board_name != null and std.mem.eql(u8, microzig.config.board_name.?, "STM32F3DISCOVERY")) {
            const pins = board.leds_config.apply();
            const all_leds = .{
                pins.LD3,
                pins.LD4,
                pins.LD5,
                pins.LD6,
                pins.LD7,
                pins.LD8,
                pins.LD9,
                pins.LD10,
            };
            break :res .{ pins, all_leds };
        } else if (comptime microzig.config.board_name != null and std.mem.eql(u8, microzig.config.board_name.?, "STM32L476DISCOVERY")) {
            const pins = board.leds_config.apply();
            const all_leds = .{
                pins.LD4,
                pins.LD5,
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
