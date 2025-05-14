const microzig = @import("microzig");
const hal = microzig.hal;
const cpu = microzig.cpu;

const pin_config = hal.pins.GlobalConfiguration{
    .GPIOC = .{
        .PIN0 = .{
            .name = "led",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
    .GPIOA = .{
        .PIN3 = .{
            // can access as PA3
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};

pub fn main() !void {
    const pins = pin_config.apply();

    while (true) {
        // var val = pins.led.read();
        // switch (val) {
        //     0 => pins.led.put(1),
        //     1 => pins.led.put(0),
        // }
        pins.led.toggle();
        pins.PA3.toggle();

        busy_delay(1000);
    }
}

inline fn busy_delay(comptime ms: u32) void {
    const cpu_frequency = if (@hasDecl(cpu, "cpu_frequency")) cpu.cpu_frequency else 8_000_000;
    const cycles_per_ms = cpu_frequency / 1_000;
    const loop_cycles = if (cpu.cpu_name == .@"qingkev2-rv32ec") 4 else 3;
    const limit = cycles_per_ms * ms / loop_cycles;

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        asm volatile ("" ::: "memory");
    }
}
