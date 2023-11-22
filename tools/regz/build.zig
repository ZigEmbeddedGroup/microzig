const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const Step = std.build.Step;
const GeneratedFile = std.build.GeneratedFile;

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libxml2_dep = b.dependency("libxml2", .{
        .target = target,
        .optimize = optimize,
        .iconv = false,
    });

    const clap_dep = b.dependency("clap", .{
        .target = target,
        .optimize = optimize,
    });

    const xml = b.addStaticLibrary(.{
        .name = "xml2",
        .target = target,
        .optimize = optimize,
    });
    xml.linkLibrary(libxml2_dep.artifact("xml2"));
    b.installArtifact(xml);

    const regz = b.addExecutable(.{
        .name = "regz",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    regz.addModule("clap", clap_dep.module("clap"));
    regz.linkLibrary(libxml2_dep.artifact("xml2"));
    b.installArtifact(regz);

    _ = b.addModule("regz", .{
        .source_file = .{ .path = "src/module.zig" },
    });

    const run_cmd = b.addRunArtifact(regz);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const contextualize_fields = b.addExecutable(.{
        .name = "contextualize-fields",
        .root_source_file = .{
            .path = "src/contextualize-fields.zig",
        },
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
        .root_source_file = .{
            .path = "src/characterize.zig",
        },
    });
    characterize.linkLibrary(libxml2_dep.artifact("xml2"));
    const characterize_run = b.addRunArtifact(characterize);
    const characterize_step = b.step("characterize", "Characterize a number of xml files whose paths are piped into stdin, results are ndjson");
    characterize_step.dependOn(&characterize_run.step);

    const tests = b.addTest(.{
        .root_source_file = .{
            .path = "src/Database.zig",
        },
        .target = target,
        .optimize = optimize,
    });
    tests.linkLibrary(libxml2_dep.artifact("xml2"));
    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
