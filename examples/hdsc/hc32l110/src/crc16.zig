const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const clocks = hal.clocks;
const crc16 = hal.crc16;

pub fn main() !void {
    clocks.gate.enable(.Crc);

    const value = crc16.calculate(u8, &.{ 0xDE, 0xAD, 0xBE, 0xEF });
    if (value != 0xE5CB) @panic("invalid value");

    if (!crc16.check(u8, &.{ 0xDE, 0xAD, 0xBE, 0xEF }, 0xE5CB))
        @panic("invalid value");

    while (true) {}
}
