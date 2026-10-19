const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

const led_pin = gpio.pin(.b, 5);

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    led_pin.set_direction(.output);

    while (true) {
        busy_sleep(1_000_000);
        led_pin.toggle();
    }
}

pub fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be positive!");

    const outer = std.math.divCeil(comptime_int, limit, std.math.maxInt(u16)) catch unreachable;
    const inner = limit / outer;

    for (0..outer) |_| {
        var i: std.math.IntFittingRange(0, inner) = 0;
        while (i < inner) : (i += 1) {
            std.mem.doNotOptimizeAway(i);
        }
    }
}
