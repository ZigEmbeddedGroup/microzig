const std = @import("std");
const Dependency = std.Build.Dependency;

pub const FamilyId = @import("src/uf2.zig").FamilyId;

pub const Options = struct {
    family_id: ?FamilyId = null,
};

pub fn from_elf(dep: *Dependency, elf_file: std.Build.LazyPath, opts: Options) std.Build.LazyPath {
    const b = dep.builder;
    const elf2uf2 = dep.artifact("elf2uf2");
    const run = b.addRunArtifact(elf2uf2);

    // family id
    if (opts.family_id) |family_id| {
        run.addArgs(&.{ "--family-id", @tagName(family_id) });
    }

    // elf file
    run.addArg("--elf-path");
    run.addFileArg(elf_file);

    // output file
    run.addArg("--output-path");
    return run.addOutputFileArg("output.uf2");
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});
    const should_update_family_id = b.option(bool, "update_family_id", "Should update the FamilyId enum") orelse false;

    if (should_update_family_id) {
        if (b.lazyDependency("microsoft_uf2", .{})) |microsoft_uf2_dep| {
            const update_family_id_exe = b.addExecutable(.{
                .name = "update_family_id",
                .root_module = b.createModule(.{
                    .root_source_file = b.path("src/update_family_id.zig"),
                    .target = b.graph.host,
                }),
            });
            const update_family_id_run = b.addRunArtifact(update_family_id_exe);
            update_family_id_run.addFileArg(microsoft_uf2_dep.path("utils/uf2families.json"));
            update_family_id_run.addFileArg(b.path("src/family_id.zig"));
            b.default_step.dependOn(&update_family_id_run.step);
        }
    }

    const uf2_mod = b.addModule("uf2", .{
        .root_source_file = b.path("src/uf2.zig"),
    });

    const elf2uf2 = b.addExecutable(.{
        .name = "elf2uf2",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/elf2uf2.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "uf2", .module = uf2_mod },
            },
        }),
    });
    b.installArtifact(elf2uf2);

    const example = b.addExecutable(.{
        .name = "example",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/example.zig"),
            .target = b.graph.host,
            .imports = &.{
                .{ .name = "uf2", .module = uf2_mod },
            },
        }),
    });
    b.installArtifact(example);

    const main_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/uf2.zig"),
            .target = b.graph.host,
        }),
    });
    const run_main_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
