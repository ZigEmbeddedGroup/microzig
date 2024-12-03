const microzig = @import("microzig");

pub fn main() !void {
    asm volatile ("nop");
    // while (true) {
    //     asm volatile ("" ::: "memory");
    // }
}
