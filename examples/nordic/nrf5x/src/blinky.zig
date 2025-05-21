const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;

fn delay(cycles: u32) void {
    var i: u32 = 0;
    while (i < cycles) : (i += 1) {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    board.init();

    while (true) {
        board.led1.toggle();
        delay(2000000);

        board.led1.toggle();
        board.led2.toggle();
        delay(2000000);

        board.led2.toggle();
        board.led3.toggle();
        delay(2000000);
    }
}
