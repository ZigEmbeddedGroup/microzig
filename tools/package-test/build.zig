const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const microzig_dep = b.dependency("microzig", .{
        .optimize = optimize,
    });
    b.getInstallStep().dependOn(microzig_dep.builder.getInstallStep());

    const test_bsps_step = b.step("run-bsp-tests", "Run all platform agnostic tests for BSPs");
    test_bsps_step.dependOn(&microzig_dep.builder.top_level_steps.get("run-bsp-tests").?.step);
}
