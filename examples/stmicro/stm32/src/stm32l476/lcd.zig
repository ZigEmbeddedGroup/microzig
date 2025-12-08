const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

fn delay() void {
    var i: u32 = 0;
    while (i < 80_000) {
        asm volatile ("nop");
        i += 1;
    }
}

pub fn init() void {
    hal.rcc.enable_rtc_lcd();
}

pub fn main() !void {
    const hello = "Hello World !";
    var lcd = board.Lcd.init();
    var step: usize = 0;

    while (true) {
        delay();

        for (0..6) |index| {
            const char = hello[(index + step) % (hello.len)];
            lcd.add_digit(index, board.Lcd.ASCII_MAP[char]);
        }
        lcd.flush();

        step = (step + 1) % (hello.len - 1);
    }
}
