const std = @import("std");
const microzig = @import("microzig");

pub fn main() !void {
    while (true) {
        asm volatile ("" ::: "memory");
    }
}
