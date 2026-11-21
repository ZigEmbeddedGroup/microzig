const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;
const gpio = microzig.hal.gpio;

const PFIC = microzig.chip.peripherals.PFIC;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .SW = sw_handler },
};

const pc2: gpio.Pin = .{ .gpio = .GPIOC, .number = 2 };

fn sw_handler() callconv(cpu.riscv_calling_convention) void {
    cpu.interrupt.clear_pending(.SW);

    pc2.toggle();
}

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clocks.init();

    pc2.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    cpu.interrupt.enable(.SW);

    if (cpu.current_core() != .v3f)
        @panic("unexpected current core");

    cpu.wakeup_v5f();

    while (true) {
        cpu.interrupt.set_pending(.SW);
        delay(20_000_000);
    }
}
