const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const time = nrf.time;

const rtc_overflow_interrupt = nrf.time.rtc_overflow_interrupt;
const uart = nrf.uart.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.log,
    .interrupts = .{ .RTC0 = .{ .c = rtc_interrupt } },
};

pub fn main() !void {
    board.init();

    while (true) {
        board.led1.toggle();
        time.sleep_ms(500);

        board.led1.toggle();
        board.led2.toggle();
        time.sleep_ms(500);

        board.led2.toggle();
        board.led3.toggle();
        time.sleep_ms(500);
    }
}
