const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("bounded-array", .{
        .root_source_file = b.path("src/bounded_array.zig"),
        .target = target,
        .optimize = optimize,
    });
}
