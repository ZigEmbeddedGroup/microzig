const std = @import("std");

pub fn build(b: *std.Build) void {
    const drivers_mod = b.addModule("drivers", .{
        .source_file = .{ .path = "driver/framework.zig" },
    });

    _ = drivers_mod;
}
