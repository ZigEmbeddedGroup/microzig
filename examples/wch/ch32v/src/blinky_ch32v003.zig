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

        busyloop();
    }
}

inline fn busyloop() void {
    // const limit = 5_000_000;
    // const limit = cpu.cpu_frequency / 2;
    // CPU frequency is 24MHz
    const limit = if (@hasDecl(cpu, "cpu_frequency")) cpu.cpu_frequency / 12 else 5_000_000;

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        asm volatile ("" ::: "memory");
    }
}
