const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("riscv32-common", .{
        .root_source_file = b.path("src/riscv32_common.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run unit tests");
    const lib_tests = b.addTest(.{
        .name = "riscv32-common-tests",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/riscv32_common.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_lib_tests = b.addRunArtifact(lib_tests);
    test_step.dependOn(&run_lib_tests.step);
}
