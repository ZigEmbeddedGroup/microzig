const std = @import("std");
const elf2image = @import("src/elf2image.zig");
pub const ChipId = elf2image.ChipId;
pub const FlashMode = elf2image.FlashMode;
pub const FlashFreq = elf2image.FlashFreq;
pub const FlashSize = elf2image.FlashSize;

pub const Options = struct {
    chip_id: ChipId,
    min_rev: ?u16 = null,
    max_rev: ?u16 = null,
    dont_append_digest: ?bool = null,
    flash_freq: ?FlashFreq = null,
    flash_mode: ?FlashMode = null,
    flash_size: ?FlashSize = null,
    use_segments: ?bool = null,
};

pub fn from_elf(dep: *std.Build.Dependency, elf_file: std.Build.LazyPath, options: Options) std.Build.LazyPath {
    const b = dep.builder;

    const elf2image_exe = dep.artifact("elf2image");
    const run = b.addRunArtifact(elf2image_exe);

    run.addFileArg(elf_file);

    run.addArgs(&.{
        "--chip-id",
        @tagName(options.chip_id),
    });

    if (options.min_rev) |min_rev| {
        run.addArgs(&.{
            "--min-rev-full",
            b.fmt("{}", .{min_rev}),
        });
    }

    if (options.max_rev) |max_rev| {
        run.addArgs(&.{
            "--max-rev-full",
            b.fmt("{}", .{max_rev}),
        });
    }

    if (options.dont_append_digest) |dont_append_digest| {
        if (dont_append_digest) {
            run.addArg("--dont-append-digest");
        }
    }

    if (options.flash_freq) |flash_freq| {
        run.addArg("--flash-freq");
        run.addArg(@tagName(flash_freq));
    }

    if (options.flash_mode) |flash_mode| {
        run.addArg("--flash-mode");
        run.addArg(@tagName(flash_mode));
    }

    if (options.flash_size) |flash_size| {
        run.addArg("--flash-size");
        run.addArg(@tagName(flash_size));
    }

    if (options.use_segments) |use_segments| {
        if (use_segments) {
            run.addArg("--use-segments");
        }
    }

    run.addArg("--output");
    return run.addOutputFileArg("output.bin");
}

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
