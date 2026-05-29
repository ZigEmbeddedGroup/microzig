const std = @import("std");
const Build = std.Build;

pub const patch = @import("src/patch.zig");

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libxml2_dep = b.dependency("libxml2", .{
        .target = target,
        .optimize = .ReleaseSafe,
        .iconv = false,
    });

    const zqlite_dep = b.dependency("zqlite", .{
        .target = target,
        .optimize = optimize,
    });

    const zqlite = zqlite_dep.module("zqlite");

    const xml_module = b.createModule(.{
        .root_source_file = b.path("src/xml.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "xml", .module = libxml2_dep.module("xml") },
        },
    });

    const regz_module = b.addModule("regz", .{
        .root_source_file = b.path("src/module.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{
                .name = "zqlite",
                .module = zqlite,
            },
            .{
                .name = "xml",
                .module = xml_module,
            },
        },
    });
    regz_module.linkLibrary(libxml2_dep.artifact("xml"));

    const regz = b.addExecutable(.{
        .name = "regz",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{
                    .name = "regz",
                    .module = regz_module,
                },
                .{
                    .name = "xml",
                    .module = xml_module,
                },
            },
        }),
        .use_llvm = true,
    });
    b.installArtifact(regz);

    const run_cmd = b.addRunArtifact(regz);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const tests = b.addTest(.{
        .root_module = regz_module,
        .use_llvm = true,
    });
    tests.step.dependOn(&regz.step);

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
