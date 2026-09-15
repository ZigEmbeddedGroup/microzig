const microzig = @import("microzig");
const std = @import("std");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .SW = sw_handler },
};

const cpu = microzig.cpu;
const clock = microzig.hal.clock;
const gpio = microzig.hal.gpio;

const PFIC = microzig.chip.peripherals.PFIC;

var pc2: gpio.Pin = undefined;
var level: u1 = 0;

fn sw_handler() callconv(cpu.riscv_calling_convention) void {
    cpu.interrupt.clear_pending(.SW);

    level ^= 1;
    pc2.write(level);
}

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clock.init();
    clock.enable_gpio(.c);

    pc2 = gpio.Pin.init(.{
        .port = .c,
        .number = 2,
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    // `interrupt.enable` verifies at compile time that a handler for this
    // interrupt was registered in `microzig_options.interrupts` above.
    cpu.interrupt.enable(.SW);

    // TODO: move this into a dedicated example.
    cpu.interrupt.set_priority(.SW, 0b1000);
    if (cpu.interrupt.get_priority(.SW) != 0b1000)
        @panic("SW interrupt priority readback failed");

    if (cpu.interrupt.current_core() != .v3f)
        @panic("unexpected current core");

    cpu.interrupt.set_allocation(.UHSIF, .v5f);
    if (cpu.interrupt.get_allocation(.UHSIF) != .v5f)
        @panic("UHSIF interrupt allocation readback failed");
    if (cpu.interrupt.owned_by_current_core(.UHSIF))
        @panic("UHSIF interrupt should not be owned by V3F");

    // Wakeup V5F
    PFIC.WAKEIP1.raw = 0x10000 & ~@as(u32, 0x3FF);
    PFIC.SCTLR.raw |= (1 << 5);

    while (true) {
        cpu.interrupt.set_pending(.SW);
        delay(50_000); // 500ms at 100MHz
    }
}
