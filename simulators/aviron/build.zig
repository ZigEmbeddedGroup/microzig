const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Main executable

    const exe = b.addExecutable(.{
        .name = "aviron",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const aviron_module = b.addModule("aviron", .{
        .source_file = .{ .path = "src/main.zig" },
    });

    // Table tool
    const generate_tables_exe = b.addExecutable(.{
        .name = "aviron-generate-tables",
        .root_source_file = .{ .path = "tools/generate-tables.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(generate_tables_exe);
    generate_tables_exe.addModule("aviron", aviron_module);

    const run_generate_tables_cmd = b.addRunArtifact(generate_tables_exe);
    run_generate_tables_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_generate_tables_cmd.addArgs(args);
    }

    const run_generate_tables_step = b.step("generate-tables", "Run the generate-tables tool");
    run_generate_tables_step.dependOn(&run_generate_tables_cmd.step);

    // Samples
    inline for (&.{"math"}) |sample_name| {
        const sample = b.addExecutable(.{
            .name = "aviron-sample-" ++ sample_name,
            .root_source_file = .{ .path = "samples/" ++ sample_name ++ ".zig" },
            .target = std.zig.CrossTarget{
                .cpu_arch = .avr,
                .cpu_model = .{ .explicit = &std.Target.avr.cpu.atmega328p },
                .os_tag = .freestanding,
                .abi = .none,
            },
            .optimize = .ReleaseSmall,
        });
        sample.bundle_compiler_rt = false;
        sample.setLinkerScriptPath(std.build.FileSource{ .path = "linker.ld" });
        b.installArtifact(sample);
    }

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
