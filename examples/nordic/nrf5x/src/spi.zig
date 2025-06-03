const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const spi = nrf.spim;

const BUF_LEN = 0x100;

const uart = nrf.uart.num(0);
const spi0 = spi.num(0);

const sleep_ms = nrf.time.sleep_ms;

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

    // defer spi0.reset();

    // TODO: Maybe have the HAL manage CSn
    var csn = gpio.num(0, 7);
    csn.set_direction(.out);
    csn.put(1);

    try spi0.apply(.{
        .sck_pin = gpio.num(0, 8),
        .miso_pin = gpio.num(0, 9),
        .mosi_pin = gpio.num(0, 10),
        .frequency = .K125,
        .mode = .mode0,
    });

    var out_buf: [BUF_LEN]u8 = .{ 'h', 'e', 'y', ' ', 'y', 'o', 'u', '!' } ** (BUF_LEN / 8);

    while (true) {
        std.log.info("Sending some data\n", .{});
        csn.put(0);
        try spi0.write_blocking(&out_buf, null);
        csn.put(1);
        sleep_ms(1000);
    }
    std.log.info("Done!", .{});
}
