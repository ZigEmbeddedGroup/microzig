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
// No device implementation yet in Zig, see Rpi Pico SDK for an example: https://github.com/raspberrypi/pico-examples/blob/master/spi/spi_master_slave/spi_slave/spi_slave.c
pub fn main() !void {

    // Note that CSN pin is manually controlled here rather than by the SPI peripheral.
    // If CSN is configured to "SPI" function, it will get toggled after every data packet by the RP2040's
    // SPI peripheral which is problematic for certain chips. It's generally easier to just toggle it
    // manually before/after every transaction.
    const csn = rp2040.gpio.num(1);
    csn.set_function(.sio);
    csn.set_direction(.out);
    csn.put(1);

    // These will change depending on which GPIO pins you have your SPI device routed to
    const hodi = rp2040.gpio.num(3);
    const hido = rp2040.gpio.num(4);
    const sck = rp2040.gpio.num(2);
    inline for (&.{ hodi, hido, sck }) |pin| {
        pin.set_function(.spi);
    }

    // 8 bit data words
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .eight,
    });
    var out_buf_eight: [BUF_LEN]u8 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    var in_buf_eight: [BUF_LEN]u8 = undefined;
    csn.put(0);
    spi.transceive_blocking(u8, &out_buf_eight, &in_buf_eight);
    csn.put(1);

    // 12 bit data words
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .twelve,
    });
    var out_buf_twelve: [BUF_LEN]u12 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    var in_buf_twelve: [BUF_LEN]u12 = undefined;
    csn.put(0);
    spi.transceive_blocking(u12, &out_buf_twelve, &in_buf_twelve);
    csn.put(1);

    // Back to 8 bit mode
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
        .data_width = .eight,
    });
    while (true) {
        csn.put(0);
        spi.transceive_blocking(u8, &out_buf_eight, &in_buf_eight);
        csn.put(1);
        time.sleep_ms(1 * 1000);
    }
}
