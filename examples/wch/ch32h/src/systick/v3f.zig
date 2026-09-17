const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clock = microzig.hal.clock;
const gpio = microzig.hal.gpio;
const time = microzig.hal.time;

const PFIC = microzig.chip.peripherals.PFIC;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .SysTick1 = systick_handler,
    },
};

var pc2: gpio.Pin = undefined;
const stk = time.systick1;

fn systick_handler() callconv(cpu.riscv_calling_convention) void {
    stk.clear_pending();
    pc2.toggle();
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
