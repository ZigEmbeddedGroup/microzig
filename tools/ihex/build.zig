const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const ihex_mod = b.addModule("ihex", .{
        .root_source_file = b.path("ihex.zig"),
        .target = target,
        .optimize = optimize,
    });

    var main_tests = b.addTest(.{
        .root_module = ihex_mod,
    });

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
