const std = @import("std");
const b = @import("b");

pub fn main() !void {
    std.log.info("fibonnaci of 4 is {}", .{b.fibonacci(4)});
}
