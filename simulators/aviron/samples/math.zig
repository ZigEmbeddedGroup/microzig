const std = @import("std");

pub export fn _start() callconv(.Naked) noreturn {
    var a: usize = 1 + 2;

    for (0..10) |p| {
        var k = p;
        std.mem.doNotOptimizeAway(k);
        a += k;
    }

    @as(*const fn () void, @ptrFromInt(a))();

    while (true) {}
}
