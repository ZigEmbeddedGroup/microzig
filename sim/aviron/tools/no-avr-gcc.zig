const std = @import("std");

pub fn main() !u8 {
    try std.io.getStdErr().writeAll("avr-gcc not found. Please install avr-gcc!\n");
    return 1;
}
