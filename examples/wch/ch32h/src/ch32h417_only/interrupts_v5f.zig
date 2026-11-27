const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const gpio = microzig.hal.gpio;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    if (cpu.current_core() != .v5f)
        @panic("unexpected current core");

    const pc3 = gpio.Pin{ .gpio = .GPIOC, .number = 3 };
    pc3.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    while (true) {
        pc3.toggle();
        delay(120_000_000);
    }
}
