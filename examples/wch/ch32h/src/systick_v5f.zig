const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const gpio = microzig.hal.gpio;
const time = microzig.hal.time;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .SysTick0 = systick_handler,
    },
};

const pc3: gpio.Pin = .{ .port = .c, .number = 3 };
const stk = time.systick0;

fn systick_handler() callconv(cpu.riscv_calling_convention) void {
    stk.clear_pending();
    pc3.toggle();
}

pub fn main() !void {
    pc3.apply(.{
        .mode = .{ .output = .general_purpose_open_drain },
        .speed = .max_50MHz,
        .pull = .disabled,
    });

    stk.apply(.{
        .core = .v5f,
        .mode = .up,
        .clock_source = .hclk,
        .auto_reload = true,
        .compare_value = 50_000_000,
    });
    stk.enable_interrupt();
    stk.enable();

    while (true) {}
}
