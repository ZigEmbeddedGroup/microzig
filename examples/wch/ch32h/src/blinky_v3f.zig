const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clock = microzig.hal.clock;
const gpio = microzig.hal.gpio;

const PFIC = microzig.chip.peripherals.PFIC;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clock.init();
    clock.enable_gpio(.c);

    const pc2: gpio.Pin = .{ .port = .c, .number = 2 };
    pc2.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    cpu.wakeup_v5f();

    while (true) {
        pc2.toggle();
        delay(20_000_000);
    }
}
