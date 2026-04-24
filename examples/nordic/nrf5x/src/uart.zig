const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const nrf = microzig.hal;

const uart = nrf.uart.num(0);

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = nrf.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
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
