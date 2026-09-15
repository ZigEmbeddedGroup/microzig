const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const gpio = microzig.hal.gpio;
const clock = microzig.hal.clock;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clock.enable_gpio(.c);

    if (cpu.interrupt.current_core() != .v5f)
        @panic("unexpected current core");

    const pc3 = gpio.Pin.init(.{
        .port = .c,
        .number = 3,
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    while (true) {
        pc3.write(1);
        delay(200_000);
        pc3.write(0);
        delay(200_000);
    }
}
