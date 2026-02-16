const std = @import("std");
const microzig = @import("microzig");
const RNG = microzig.chip.peripherals.RNG;

pub fn random_u32() u32 {
    return RNG.DATA.raw;
}

pub fn read(buf: []u8) void {
    var i: usize = 0;
    while (i < buf.len) : (i += 4) {
        const count = @min(buf.len - i, 4);
        const value = random_u32();
        @memcpy(buf[i .. i + count], std.mem.asBytes(&value)[0..count]);
    }
}
