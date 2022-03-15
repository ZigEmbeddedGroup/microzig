const micro = @import("microzig");
const builtin = @import("builtin");

// this program will only work on arm microcontrollers, and it might not
// actually run correctly at first, it's just a test for declaring interrupts
// right now.

pub const panic = micro.panic;

pub const interrupts = switch (builtin.cpu.arch) {
    .avr => struct {
        pub fn INT0() void {
            @panic("hit PCINT0");
        }
    },
    else => struct {
        pub fn SysTick() void {
            @panic("hit systick!");
        }
    },
};

pub fn main() void {
    while (true) {}
}
