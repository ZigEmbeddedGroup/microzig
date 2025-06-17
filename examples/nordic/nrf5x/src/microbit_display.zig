const std = @import("std");
const microzig = @import("microzig");
const nrf = microzig.hal;
const time = nrf.time;
const microbit = microzig.board;

pub const heart: [5][5]u3 = .{
    .{0, 1, 0, 1, 0},
    .{1, 0, 1, 0, 1},
    .{1, 0, 0, 0, 1},
    .{0, 1, 0, 1, 0},
    .{0, 0, 1, 0, 0},
};

pub fn main() !void {
    microbit.display.init();

    while (true) {
        microbit.display.render(heart, .from_ms(1_000));
        time.sleep_ms(1_000);
    }
}
