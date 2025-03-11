const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const chip = rp2xxx.compatibility.chip;

const BUF_LEN = 0x100;
const spi = rp2xxx.spi.instance.SPI0;

const uart = rp2xxx.uart.instance.num(0);
const uart_baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

// These may change depending on which GPIO pins you have your SPI device routed to.
const CS_PIN = 17;
const SCK_PIN = 18;
// NOTE: rp2xxx doesn't label pins as MOSI/MISO. Instead a pin is always for
// either receiving or transmitting SPI data, no matter whether the chip is in
// master or slave mode.
const RX_PIN = 16;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};

pub fn main() !void {
    // Set pin functions for CS, SCK, RX
    const csn = gpio.num(CS_PIN);
    const mosi = gpio.num(RX_PIN);
    const sck = gpio.num(SCK_PIN);
    inline for (&.{ csn, mosi, sck }) |pin| {
        pin.set_function(.spi);
    }

    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = uart_baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    std.log.info("Setting SPI as slave device", .{});
    spi.set_slave(true);

    try spi.apply(.{ .clock_config = rp2xxx.clock_config });
    var in_buf: [BUF_LEN]u8 = undefined;

    std.log.info("Reading", .{});

    while (true) {
        spi.read_blocking(u8, 0, &in_buf);
        std.log.info("Got: {s}", .{in_buf});
        time.sleep_ms(1 * 1000);
    }
}
