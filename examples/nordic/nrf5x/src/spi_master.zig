const std = @import("std");
const microzig = @import("microzig");

const nrf = microzig.hal;
const time = nrf.time;
const board = microzig.board;
const gpio = nrf.gpio;

const uart = nrf.uart.num(0);

const spi = nrf.spim.num(0);

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

    var csn = gpio.num(0, 7);
    csn.set_direction(.out);
    csn.put(1);

    try spi.apply(.{
        .sck_pin = gpio.num(0, 8),
        .mosi_pin = gpio.num(0, 10),
    });

    while (true) {
        std.log.info("Sending some data", .{});
        csn.put(0);
        try spi.write_blocking("hello world!\r\n", null);
        csn.put(1);
        time.sleep_ms(1000);
    }
}
