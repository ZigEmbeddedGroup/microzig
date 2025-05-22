const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;

const uart = nrf.uart.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.logFn,
};

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
        // .control_flow = .{
        //     .cts_pin = board.uart_cts,
        //     .rts_pin = board.uart_rts,
        // },
        .baud_rate = .@"115200",
    });

    nrf.uart.init_logger(uart);
    std.log.info("Hello world, I will send back bytes you send me", .{});

    // now echo any bytes sent
    var buf: [1]u8 = undefined;
    while (true) {
        uart.read_blocking(&buf);
        uart.write_blocking(buf[0..]);
    }
}
