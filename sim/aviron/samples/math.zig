const std = @import("std");

pub export fn _start() callconv(.c) noreturn {
    var a: usize = 1 + 2;

    for (0..10) |p| {
        const k = p;
        std.mem.doNotOptimizeAway(k);
        a += k;
    }

    // @as(*const fn () void, @ptrFromInt(a))();

    asm volatile ("out 0x00, 0x00");

    unreachable;
}
