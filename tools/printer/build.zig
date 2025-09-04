const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const serial_dep = b.dependency("serial", .{
        .target = target,
        .optimize = optimize,
    });

    const printer_mod = b.addModule("printer", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const printer_exe = b.addExecutable(.{
        .name = "printer",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .imports = &.{
                .{ .name = "printer", .module = printer_mod },
            },
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(printer_exe);

    const example_exe = b.addExecutable(.{
        .name = "rp2xxx_runner",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/rp2xxx_runner.zig"),
            .imports = &.{
                .{ .name = "printer", .module = printer_mod },
                .{ .name = "serial", .module = serial_dep.module("serial") },
            },
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(example_exe);

    const test_common_mod = b.createModule(.{
        .root_source_file = b.path("tests/common.zig"),
        .imports = &.{
            .{ .name = "printer", .module = printer_mod },
        },
    });

    const generate_test_data_exe = b.addExecutable(.{
        .name = "generate_results",
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/generate_test_data.zig"),
            .imports = &.{
                .{ .name = "common", .module = test_common_mod },
                .{ .name = "printer", .module = printer_mod },
            },
            .target = target,
            .optimize = optimize,
        }),
    });

    const test_runner_exe = b.addExecutable(.{
        .name = "test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/test.zig"),
            .imports = &.{
                .{ .name = "common", .module = test_common_mod },
                .{ .name = "printer", .module = printer_mod },
            },
            .target = target,
            .optimize = optimize,
        }),
    });

    const test_dwarf32_exe = b.addExecutable(.{
        .name = "test_program.dwarf32",
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/test_program.zig"),
            .optimize = .Debug,
            .target = b.resolveTargetQuery(.{
                .os_tag = .linux,
                .cpu_arch = .x86_64,
                .abi = .gnu,
                .ofmt = .elf,
            }),
            .dwarf_format = .@"32",
            .strip = false,
        }),
    });

    const test_dwarf64_exe = b.addExecutable(.{
        .name = "test_program.dwarf64",
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/test_program.zig"),
            .optimize = .Debug,
            .target = b.resolveTargetQuery(.{
                .os_tag = .linux,
                .cpu_arch = .x86_64,
                .abi = .gnu,
                .ofmt = .elf,
            }),
            .dwarf_format = .@"64",
        }),
    });

    const generate_test_data_step = b.step("generate-test-data", "regenerate test data");
    const test_step = b.step("test", "test printer");

    inline for (&.{ test_dwarf32_exe, test_dwarf64_exe }) |exe| {
        register_test(
            b,
            generate_test_data_step,
            generate_test_data_exe,
            test_step,
            test_runner_exe,
            exe,
        );
    }
}

pub fn register_test(
    b: *std.Build,
    generate_test_data_step: *std.Build.Step,
    generate_test_data_exe: *std.Build.Step.Compile,
    test_step: *std.Build.Step,
    test_runner_exe: *std.Build.Step.Compile,
    test_exe: *std.Build.Step.Compile,
) void {
    const generate_test_data_run = b.addRunArtifact(generate_test_data_exe);
    generate_test_data_run.addFileArg(test_exe.getEmittedBin());
    generate_test_data_run.addFileArg(b.path(b.fmt("tests/{s}.zon", .{test_exe.name})));
    generate_test_data_step.dependOn(&generate_test_data_run.step);

    const test_runner_run = b.addRunArtifact(test_runner_exe);
    test_runner_run.addFileArg(test_exe.getEmittedBin());
    test_runner_run.addFileArg(b.path(b.fmt("tests/{s}.zon", .{test_exe.name})));
    test_step.dependOn(&test_runner_run.step);
}
