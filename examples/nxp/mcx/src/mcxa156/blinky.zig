const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

const time = hal.time;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    board.Digital_RGB_Led.init();

    while (true) {
        for (0..7) |rgb| {
            board.Digital_RGB_Led.set_color(@fromBackingInt(@intCast(rgb)));
            time.sleep_ms(1000);
        }
    }
}
