const std = @import("std");
const Build = std.Build;
const Compile = Build.Compile;
const Step = Build.Step;
const GeneratedFile = Build.GeneratedFile;

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

    const regz = b.addExecutable(.{
        .name = "regz",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
        .use_llvm = true,
    });
    regz.linkLibrary(libxml2_dep.artifact("xml2"));
    regz.root_module.addImport("zqlite", zqlite);
    b.installArtifact(regz);

    const exported_module = b.addModule("regz", .{
        .root_source_file = b.path("src/module.zig"),
    });
    exported_module.linkLibrary(libxml2_dep.artifact("xml2"));
    exported_module.addImport("zqlite", zqlite);

    const run_cmd = b.addRunArtifact(regz);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/Database.zig"),
            .target = target,
            .optimize = optimize,
        }),
        .use_llvm = true,
    });
    tests.linkLibrary(libxml2_dep.artifact("xml2"));
    tests.root_module.addImport("zqlite", zqlite);
    tests.step.dependOn(&regz.step);

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
