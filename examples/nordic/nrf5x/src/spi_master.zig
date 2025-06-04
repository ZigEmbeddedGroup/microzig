const std = @import("std");
const microzig = @import("microzig");

const nrf = microzig.hal;
const time = nrf.time;
const board = microzig.board;
const gpio = nrf.gpio;

const uart = nrf.uart.num(0);

const BUF_LEN = 0x100;
const spi = nrf.spim.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.log,
};

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
        .baud_rate = .@"115200",
    });

    nrf.uart.init_logger(uart);

    var csn = gpio.num(0, 7);
    csn.set_direction(.out);
    csn.put(1);

    try spi.apply(.{
        .sck_pin = gpio.num(0, 8),
        .mosi_pin = gpio.num(0, 10),
    });

    var out_buf: [BUF_LEN]u8 = .{ 'h', 'e', 'y', ' ', 'y', 'o', 'u', '!' } ** (BUF_LEN / 8);

    while (true) {
        std.log.info("Sending some data", .{});
        csn.put(0);
        try spi.write_blocking(&out_buf, null);
        csn.put(1);
        time.sleep_ms(1000);
    }
}
