const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;

pub fn main() !void {
    if (cpu.current_core() != .v5f)
        @panic("unexpected current core");

    while (true) {}
}
