const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const drivers_mod = b.addModule("drivers", .{
        .root_source_file = b.path("framework.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_suite = b.addTest(.{
        .root_module = drivers_mod,
        .target = b.graph.host,
    });

    const run_tests = b.addRunArtifact(test_suite);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
