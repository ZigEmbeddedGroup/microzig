const std = @import("std");
const Build = std.Build;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const elf2uf2 = b.addExecutable(.{
        .name = "elf2uf2",
        .root_source_file = b.path("src/elf2uf2.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(elf2uf2);

    _ = b.addModule("uf2", .{
        .root_source_file = b.path("src/uf2.zig"),
    });

    const main_tests = b.addTest(.{
        .root_source_file = b.path("src/uf2.zig"),
    });
    const run_main_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);

    const gen = b.addExecutable(.{
        .name = "gen",
        .root_source_file = b.path("src/gen.zig"),
        .target = b.host,
    });
    const gen_run_step = b.addRunArtifact(gen);
    const gen_step = b.step("gen", "Generate family id enum");
    gen_step.dependOn(&gen_run_step.step);

    const example = b.addExecutable(.{
        .name = "example",
        .root_source_file = b.path("src/example.zig"),
        .target = b.host,
    });
    b.installArtifact(example);
}
