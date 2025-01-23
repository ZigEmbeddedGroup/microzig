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
        .optimize = optimize,
        .iconv = false,
    });

    const sqlite_dep = b.dependency("sqlite", .{
        .target = target,
        .optimize = optimize,
    });
    const sqlite = sqlite_dep.module("sqlite");

    const regz = b.addExecutable(.{
        .name = "regz",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    regz.linkLibrary(libxml2_dep.artifact("xml2"));
    regz.root_module.addImport("sqlite", sqlite);
    b.installArtifact(regz);

    const exported_module = b.addModule("regz", .{
        .root_source_file = b.path("src/module.zig"),
    });
    exported_module.linkLibrary(libxml2_dep.artifact("xml2"));
    exported_module.addImport("sqlite", sqlite);

    const run_cmd = b.addRunArtifact(regz);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const contextualize_fields = b.addExecutable(.{
        .name = "contextualize-fields",
        .root_source_file = b.path("src/contextualize-fields.zig"),
        .target = b.graph.host,
    });
    contextualize_fields.linkLibrary(libxml2_dep.artifact("xml2"));
    const contextualize_fields_run = b.addRunArtifact(contextualize_fields);
    if (b.args) |args| {
        contextualize_fields_run.addArgs(args);
    }
    const contextualize_fields_step = b.step("contextualize-fields", "Create ndjson of all the fields with the context of parent fields");
    contextualize_fields_step.dependOn(&contextualize_fields_run.step);

    const characterize = b.addExecutable(.{
        .name = "characterize",
        .root_source_file = b.path("src/characterize.zig"),
        .target = b.graph.host,
    });
    characterize.linkLibrary(libxml2_dep.artifact("xml2"));
    const characterize_run = b.addRunArtifact(characterize);
    const characterize_step = b.step("characterize", "Characterize a number of xml files whose paths are piped into stdin, results are ndjson");
    characterize_step.dependOn(&characterize_run.step);

    const tests = b.addTest(.{
        .root_source_file = b.path("src/Database.zig"),
        .target = target,
        .optimize = optimize,
    });
    tests.linkLibrary(libxml2_dep.artifact("xml2"));
    tests.root_module.addImport("sqlite", sqlite);

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
