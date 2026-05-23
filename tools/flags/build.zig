const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const flags_module = b.addModule("flags", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const unit_tests = b.addTest(.{
        .root_module = flags_module,
    });

    const tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "");
    test_step.dependOn(&tests_run.step);
}
