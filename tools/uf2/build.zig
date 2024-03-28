const std = @import("std");
const Dependency = std.Build.Dependency;
const CompileStep = std.Build.CompileStep;
const FileSource = std.Build.FileSource;

const uf2 = @import("src/uf2.zig");

pub const FamilyId = uf2.FamilyId;

pub fn from_elf(dep: *Dependency, exe: *CompileStep, opts: uf2.Options) FileSource {
    std.debug.assert(!opts.bundle_source); // TODO: bundle source in UF2 File
    const b = dep.builder;
    const elf2uf2 = dep.artifact("elf2uf2");
    const run = b.addRunArtifact(elf2uf2);

    // family id
    if (opts.family_id) |family_id| {
        inline for (@typeInfo(uf2.FamilyId).Enum.fields) |field| {
            if (@field(uf2.FamilyId, field.name) == family_id) {
                run.addArgs(&.{ "--family-id", field.name });
            }
        }
    }

    // elf file
    run.addArg("--elf-path");
    run.addArtifactArg(exe);

    // output file
    return run.addPrefixedOutputFileArg("--output-path", "test.uf2");
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const elf2uf2 = b.addExecutable(.{
        .name = "elf2uf2",
        .root_source_file = .{ .path = "src/elf2uf2.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(elf2uf2);

    _ = b.addModule("uf2", .{
        .root_source_file = .{ .path = "src/uf2.zig" },
    });

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/uf2.zig" },
    });
    const run_main_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);

    const gen = b.addExecutable(.{
        .name = "gen",
        .root_source_file = .{ .path = "src/gen.zig" },
        .target = b.host,
    });
    const gen_run_step = b.addRunArtifact(gen);
    const gen_step = b.step("gen", "Generate family id enum");
    gen_step.dependOn(&gen_run_step.step);

    const example = b.addExecutable(.{
        .name = "example",
        .root_source_file = .{ .path = "src/example.zig" },
        .target = b.host,
    });
    b.installArtifact(example);
}
