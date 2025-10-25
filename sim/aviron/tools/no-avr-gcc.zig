const std = @import("std");

pub fn main() !u8 {
    var stderr = std.fs.File.stderr().writer(&.{});
    try stderr.interface.writeAll("avr-gcc not found. Please install avr-gcc!\n");
    try stderr.interface.flush();
    return 1;
}
