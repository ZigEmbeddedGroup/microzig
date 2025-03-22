const std = @import("std");
const elf2image = @import("src/elf2image.zig");
pub const ChipId = elf2image.ChipId;
pub const FlashMode = elf2image.FlashMode;
pub const FlashFreq = elf2image.FlashFreq;
pub const FlashSize = elf2image.FlashSize;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const elf2image_exe = b.addExecutable(.{
        .name = "elf2image",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/elf2image.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const clap = b.dependency("clap", .{});
    elf2image_exe.root_module.addImport("clap", clap.module("clap"));

    const elf2image_test = b.addTest(.{
        .name = "elf2image",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/elf2image.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(elf2image_exe);

    const test_step = b.step("test", "Run tests.");
    const test_run = b.addRunArtifact(elf2image_test);
    test_step.dependOn(&test_run.step);
}
