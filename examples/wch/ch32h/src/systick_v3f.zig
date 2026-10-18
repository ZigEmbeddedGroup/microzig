const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;
const gpio = microzig.hal.gpio;
const time = microzig.hal.time;

const PFIC = microzig.chip.peripherals.PFIC;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .SysTick1 = systick_handler,
    },
};

const pc2: gpio.Pin = .{ .port = .c, .number = 2 };

// By default, systick1 is allocated to v5f.
// Here we demonstrate how to change this!
const stk = time.systick1;

fn systick_handler() callconv(cpu.riscv_calling_convention) void {
    stk.clear_pending();
    pc2.toggle();
}

pub fn main() !void {
    clocks.init();
    clocks.enable_gpio(.c);

    pc2.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    stk.apply(.{
        .core = .v3f,
        .mode = .up,
        .clock_source = .hclk,
        .auto_reload = true,
        .compare_value = 100_000_000,
    });
    stk.enable_interrupt();
    stk.enable();

    cpu.wakeup_v5f();

    while (true) {}
}
