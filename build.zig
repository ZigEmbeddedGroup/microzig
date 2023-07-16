const std = @import("std");

pub fn build(b: *std.Build) void {
    const test_step = b.step("test", "Runs the test suite");

    const drivers_mod = b.addModule("drivers", .{
        .source_file = .{ .path = "driver/framework.zig" },
    });

    _ = drivers_mod;

    const test_suite = b.addTest(.{
        .root_source_file = .{ .path = "driver/framework.zig" },
        .target = .{},
        .optimize = .Debug,
    });

    test_step.dependOn(&b.addRunArtifact(test_suite).step);
}
