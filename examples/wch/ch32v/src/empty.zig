const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    asm volatile ("nop");
    // while (true) {
    //     asm volatile ("" ::: "memory");
    // }
}
