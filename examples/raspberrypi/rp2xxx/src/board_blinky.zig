const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const board = microzig.board;

pub fn main() !void {
    const pins = board.pin_config.apply();

    while (true) {
        pins.led.toggle();
        rp2xxx.time.sleep_ms(250);
    }
}
