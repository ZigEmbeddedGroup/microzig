const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const release_mod = b.addModule("release", .{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const release_exe = b.addExecutable(.{
        .name = "release",
        .root_module = release_mod,
    });
    b.installArtifact(release_exe);

    const run_cmd = b.addRunArtifact(release_exe);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = release_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);

    // Integration tests that verify hash compatibility with zig fetch
    const hash_test_mod = b.addModule("hash_test", .{
        .root_source_file = b.path("src/hash_test.zig"),
        .target = target,
        .optimize = optimize,
    });

    const hash_tests = b.addTest(.{
        .root_module = hash_test_mod,
    });

    const run_hash_tests = b.addRunArtifact(hash_tests);
    const integration_test_step = b.step("test-integration", "Run integration tests (requires zig on PATH)");
    integration_test_step.dependOn(&run_hash_tests.step);
    test_step.dependOn(&run_hash_tests.step);
}
