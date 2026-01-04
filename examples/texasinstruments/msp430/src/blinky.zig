const std = @import("std");
const microzig = @import("microzig");
const watchdog = microzig.hal.watchdog;
const launchpad = microzig.board;
const green_led = launchpad.green_led;

pub const panic = std.debug.no_panic;

pub fn main() void {
    watchdog.disable();
    green_led.set_direction(.output);

    while (true) {
        green_led.toggle();
        busy_sleep(10_000);
    }
}

pub fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be non-negative!");

    comptime var bits = 0;
    inline while ((1 << bits) <= limit) {
        bits += 1;
    }

    const I = std.meta.Int(.unsigned, bits);

    var i: I = 0;
    while (i < limit) : (i += 1) {
        std.mem.doNotOptimizeAway(i);
    }
}
