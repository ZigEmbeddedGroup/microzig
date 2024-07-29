const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const time = rp2040.time;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const peripherals = microzig.chip.peripherals;

const BUF_LEN = 0x100;
const spi = rp2040.spi.instance.SPI0;

// Communicate with another RP2040 over spi
// Slave implementation: https://github.com/raspberrypi/pico-examples/blob/master/spi/spi_master_slave/spi_slave/spi_slave.c
pub fn main() !void {

    // 8 bit data words
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .eight,
    });
    var out_buf_eight: [BUF_LEN]u8 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    var in_buf_eight: [BUF_LEN]u8 = undefined;
    _ = spi.transceive_blocking(u8, &out_buf_eight, &in_buf_eight);

    // 12 bit data words
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .twelve,
    });
    var out_buf_twelve: [BUF_LEN]u12 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    var in_buf_twelve: [BUF_LEN]u12 = undefined;
    _ = spi.transceive_blocking(u12, &out_buf_twelve, &in_buf_twelve);

    // Back to 8 bit mode
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .eight,
    });
    while (true) {
        _ = spi.transceive_blocking(u8, &out_buf_eight, &in_buf_eight);
        time.sleep_ms(1 * 1000);
    }
}
