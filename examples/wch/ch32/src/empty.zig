const std = @import("std");
const microzig = @import("microzig");

pub fn main() !void {
    asm volatile ("nop");
}
