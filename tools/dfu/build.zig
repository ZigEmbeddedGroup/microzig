const std = @import("std");
const Dependency = std.Build.Dependency;

pub const Format = @import("src/dfu.zig").Format;
pub const Options = @import("src/dfu.zig").Options;

/// Create a DFU file from an ELF file.
/// For DfuSe format, converts ELF directly.
/// For standard DFU format, uses objcopy to extract binary first.
pub fn from_elf(dep: *Dependency, elf_file: std.Build.LazyPath, opts: Options) std.Build.LazyPath {
    const b = dep.builder;

    return switch (opts.format) {
        .dfuse => blk: {
            const elf2dfuse = dep.artifact("elf2dfuse");
            const run = b.addRunArtifact(elf2dfuse);

            run.addArgs(&.{ "--vendor-id", b.fmt("0x{x:0>4}", .{opts.vendor_id}) });
            run.addArgs(&.{ "--product-id", b.fmt("0x{x:0>4}", .{opts.product_id}) });
            run.addArgs(&.{ "--device-id", b.fmt("0x{x:0>4}", .{opts.device_id}) });
            run.addArg("--elf-path");
            run.addFileArg(elf_file);
            run.addArg("--output-path");
            break :blk run.addOutputFileArg("output.dfu");
        },
        .standard => blk: {
            // Use objcopy to extract binary from ELF
            const objcopy = b.addObjCopy(elf_file, .{
                .format = .bin,
            });
            const bin_file = objcopy.getOutput();

            // Then convert binary to DFU
            break :blk from_bin(dep, bin_file, opts);
        },
    };
}

/// Create a standard DFU file from a raw binary file.
pub fn from_bin(dep: *Dependency, bin_file: std.Build.LazyPath, opts: Options) std.Build.LazyPath {
    const b = dep.builder;
    const bin2dfu = dep.artifact("bin2dfu");
    const run = b.addRunArtifact(bin2dfu);

    run.addArgs(&.{ "--vendor-id", b.fmt("0x{x:0>4}", .{opts.vendor_id}) });
    run.addArgs(&.{ "--product-id", b.fmt("0x{x:0>4}", .{opts.product_id}) });
    run.addArgs(&.{ "--device-id", b.fmt("0x{x:0>4}", .{opts.device_id}) });
    run.addArg("--bin-path");
    run.addFileArg(bin_file);
    run.addArg("--output-path");
    return run.addOutputFileArg("output.dfu");
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const dfu_mod = b.addModule("dfu", .{
        .root_source_file = b.path("src/dfu.zig"),
    });

    const dfuse_mod = b.createModule(.{
        .root_source_file = b.path("src/dfuse.zig"),
        .imports = &.{
            .{ .name = "dfu", .module = dfu_mod },
        },
    });

    const elf2dfuse = b.addExecutable(.{
        .name = "elf2dfuse",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/elf2dfuse.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "dfuse", .module = dfuse_mod },
            },
        }),
    });
    b.installArtifact(elf2dfuse);

    const bin2dfu = b.addExecutable(.{
        .name = "bin2dfu",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/bin2dfu.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "dfu", .module = dfu_mod },
            },
        }),
    });
    b.installArtifact(bin2dfu);

    const main_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/dfu.zig"),
            .target = target,
        }),
    });
    const run_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_tests.step);
}
