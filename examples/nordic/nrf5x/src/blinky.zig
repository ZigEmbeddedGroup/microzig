const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;
const time = nrf.time;

const rtc_overflow_interrupt = nrf.time.rtc_overflow_interrupt;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.log,
    .interrupts = .{ .RTC0 = .{ .c = rtc_overflow_interrupt } },
};

pub fn main() !void {
    board.init();

    while (true) {
        board.led1.toggle();
        // std.log.info("Now: {}", .{time.get_time_since_boot()});
        std.log.info("Counter: {}", .{microzig.chip.peripherals.RTC0.COUNTER});
        // time.sleep_ms(500);

        board.led1.toggle();
        board.led2.toggle();
        // std.log.info("Now: {}", .{time.get_time_since_boot()});
        // time.sleep_ms(500);

        board.led2.toggle();
        board.led3.toggle();
        // std.log.info("Now: {}", .{time.get_time_since_boot()});
        // time.sleep_ms(500);
    }
}
