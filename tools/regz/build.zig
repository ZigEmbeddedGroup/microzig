const std = @import("std");
const Build = std.Build;

pub const patch = @import("src/patch.zig");

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Dependencies

    const libxml2 = b.dependency("libxml2", .{
        .target = target,
        .optimize = .ReleaseSafe,
        .iconv = false,
    })
        .artifact("xml2");

    const zqlite = b.dependency("zqlite", .{
        .target = target,
        .optimize = .ReleaseSafe,
    })
        .module("zqlite");

    // Main executable

    const regz = b.addExecutable(.{
        .name = "regz",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zqlite", .module = zqlite },
            },
        }),
    });
    regz.linkLibrary(libxml2);

    b.installArtifact(regz);

    const run_cmd = b.addRunArtifact(regz);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args|
        run_cmd.addArgs(args);
    b.step("run", "Run the app").dependOn(&run_cmd.step);

    // Library

    const exported_module = b.addModule("regz", .{
        .root_source_file = b.path("src/root.zig"),
        .imports = &.{
            .{ .name = "zqlite", .module = zqlite },
        },
    });
    exported_module.linkLibrary(libxml2);

    // Tests

    const tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zqlite", .module = zqlite },
            },
        }),
    });
    tests.linkLibrary(libxml2);
    tests.step.dependOn(&regz.step);

    const run_tests = b.addRunArtifact(tests);
    b.step("test", "Run unit tests").dependOn(&run_tests.step);
}
