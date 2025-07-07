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

    const test_exe = b.addExecutable(.{
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

    const generate_test_data_run = b.addRunArtifact(generate_test_data_exe);
    if (b.option(bool, "rebuild-test-elf", "rebuild the test program elf") == true) {
        const mz_dep = b.lazyDependency("microzig", .{}) orelse return;

        const mb = @import("microzig").MicroBuild(.{
            .rp2xxx = true,
        }).init(b, mz_dep) orelse return;

        generate_test_data_run.addFileArg(blk: {
            break :blk mb.add_firmware(.{
                .name = "test_program.dwarf32",
                .root_source_file = b.path("tests/test_program.zig"),
                .optimize = .Debug,
                .target = mb.ports.rp2xxx.boards.raspberrypi.pico2_arm,
                .dwarf_format = .@"32",
            }).get_emitted_elf();
        });

        generate_test_data_run.addFileArg(blk: {
            break :blk mb.add_firmware(.{
                .name = "test_program.dwarf64",
                .root_source_file = b.path("tests/test_program.zig"),
                .optimize = .Debug,
                .target = mb.ports.rp2xxx.boards.raspberrypi.pico2_arm,
                .dwarf_format = .@"64",
            }).get_emitted_elf();
        });
    }

    const generate_test_results_step = b.step("generate-test-data", "regenerate test data");
    generate_test_results_step.dependOn(&generate_test_data_run.step);

    const run_tests_run = b.addRunArtifact(test_exe);
    const run_tests_step = b.step("test", "test printer");
    run_tests_step.dependOn(&run_tests_run.step);
}
