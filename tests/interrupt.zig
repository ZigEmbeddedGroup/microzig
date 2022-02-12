const micro = @import("microzig");

// this program will only work on arm microcontrollers, and it might not
// actually run correctly at first, it's just a test for declaring interrupts
// right now.

pub const panic = micro.panic;
pub const vector_table = struct {
    pub fn systick() void {
        @panic("hit systick!");
    }
};

pub fn main() void {
    while (true) {
        micro.cpu.wfi();
    }
}
