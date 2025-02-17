const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const BUF_LEN = 0x100;
const spi = rp2xxx.spi.instance.SPI0;

// These will change depending on which GPIO pins you have your SPI device routed to.
const CS_PIN = 17;
const SCK_PIN = 18;
// NOTE: rp2xxx doesn't label pins as MOSI/MISO. Instead a pin is always for
// either receiving or transmitting SPI data, no matter whether the chip is in
// master or slave mode.
const RX_PIN = 16;

// Communicate with another RP2040 over spi
pub fn main() !void {
    // Set pin functions for CS, SCK, RX
    const csn = rp2xxx.gpio.num(CS_PIN);
    const miso = rp2xxx.gpio.num(RX_PIN);
    const sck = rp2xxx.gpio.num(SCK_PIN);
    inline for (&.{ csn, miso, sck }) |pin| {
        pin.set_function(.spi);
    }

    // 8 bit data words
    try spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .data_width = .eight,
        .baud_rate = 500_000,
    });
    var out_buf_eight: [BUF_LEN]u8 = .{ 'h', 'e', 'l', 'o' } ** (BUF_LEN / 4);

    while (true) {
        std.log.info("Sending some data\n", .{});
        spi.write_blocking(u8, &out_buf_eight);
        time.sleep_ms(1 * 1000);
    }
}
