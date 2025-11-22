const std = @import("std");
const microzig = @import("microzig");

const crc = microzig.chip.peripherals.CRC;

///load a 32-bit value into the CRC data register
pub inline fn load(val: u32) void {
    crc.DR = val;
}

///read the current CRC value
pub inline fn read() u32 {
    return crc.DR;
}

///reset the CRC calculation unit
pub inline fn reset() void {
    crc.CR.raw = 0x1; // reset bit
}

///load a value into the CRC independent data register (just a single byte)
pub inline fn idr_load(val: u8) void {
    crc.IDR = val;
}

///read the current value of the CRC independent data register
pub inline fn idr_read() u8 {
    return @intCast(crc.IDR);
}
