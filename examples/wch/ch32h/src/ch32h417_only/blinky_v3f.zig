const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const clocks = microzig.hal.clocks;
const gpio = microzig.hal.gpio;

const PFIC = microzig.chip.peripherals.PFIC;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clocks.init();
    clocks.enable_gpio(.c);

    const pc2: gpio.Pin = .{ .port = .c, .number = 2 };
    pc2.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    // Wakeup V5F
    PFIC.WAKEIP1.raw = 0x10000 & ~@as(u32, 0x3FF);
    PFIC.SCTLR.raw |= (1 << 5);

    while (true) {
        pc2.toggle();
        delay(20_000_000);
    }
}
