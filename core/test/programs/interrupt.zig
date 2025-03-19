const builtin = @import("builtin");

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
