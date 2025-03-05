const std = @import("std");
const c = @import("c");

pub fn fibonacci(n: u32) u32 {
    return switch (n) {
        0 => 0,
        1 => 1,
        else => c.add(fibonacci(n - 1), fibonacci(n - 2)),
    };
}
