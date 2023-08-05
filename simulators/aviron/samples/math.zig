const std = @import("std");

pub export fn _start() callconv(.Naked) noreturn {
    var a: u8 = 1 + 2;
    var b: u8 = a * 3;
    a = b * a - a + b;

    std.mem.doNotOptimizeAway(a);
    std.mem.doNotOptimizeAway(b);

    while (true) {}
}
