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
    .interrupts = .{
        .RTC0 = .{ .c = rtc_overflow_interrupt },
    },
};

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
    });

    nrf.uart.init_logger(uart);

    while (true) {
        board.led1.toggle();
        std.log.info("Now: {}uS", .{time.get_time_since_boot().to_us()});
        std.log.info("period: {x}", .{time.period});
        std.log.info("INTENSET: {x:0>8}", .{microzig.chip.peripherals.RTC0.INTENSET.raw});
        std.log.info("Counter: {x:0>6}", .{microzig.chip.peripherals.RTC0.COUNTER.read().COUNTER});
        std.log.info("Interrupt en {}", .{microzig.cpu.interrupt.is_enabled(.RTC0)});
        std.log.info("Interrupt prio{}", .{microzig.cpu.interrupt.get_priority(.RTC0)});
        time.sleep_ms(500);

        // board.led1.toggle();
        // board.led2.toggle();
        // std.log.info("Now: {}", .{time.get_time_since_boot()});
        // time.sleep_ms(500);
        //
        // board.led2.toggle();
        // board.led3.toggle();
        // std.log.info("Now: {}", .{time.get_time_since_boot()});
        // time.sleep_ms(500);
    }
}
