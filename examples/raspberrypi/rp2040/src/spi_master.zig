const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const time = rp2040.time;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const peripherals = microzig.chip.peripherals;

const BUF_LEN = 0x100;
const spi = rp2040.spi.from_instance_number(0);

// Communicate with another RP2040 over spi
// Slave implementation: https://github.com/raspberrypi/pico-examples/blob/master/spi/spi_master_slave/spi_slave/spi_slave.c
pub fn main() !void {
    try spi.apply(.{
        .clock_config = rp2040.clock_config,
    });
    var out_buf: [BUF_LEN]u8 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    var in_buf: [BUF_LEN]u8 = undefined;

    while (true) {
        _ = spi.transceive(u8, &out_buf, &in_buf);
        time.sleep_ms(1 * 1000);
    }
}
