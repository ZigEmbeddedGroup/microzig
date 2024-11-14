const microzig = @import("microzig");

pub fn main() void {
    while (true) {
        asm volatile ("" ::: "memory");
        // asm volatile ("nop");
    }
}
