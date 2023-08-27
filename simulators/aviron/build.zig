const std = @import("std");

const samples = [_][]const u8{
    "math",
};

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    // Targets
    const test_step = b.step("test", "Run test suite");
    const run_step = b.step("run", "Run the app");

    // Options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Static modules

    const aviron_module = b.addModule("aviron", .{
        .source_file = .{ .path = "src/main.zig" },
    });

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

    run_step.dependOn(&run_cmd.step);

    // Table tool
    const generate_tables_exe = b.addExecutable(.{
        .name = "aviron-generate-tables",
        .root_source_file = .{ .path = "tools/generate-tables.zig" },
        .target = target,
        .optimize = optimize,
    });
    generate_tables_exe.addModule("aviron", aviron_module);

    const run_generate_tables_cmd = b.addRunArtifact(generate_tables_exe);

    const tables_zig_file = run_generate_tables_cmd.addOutputFileArg("tables.zig");

    exe.addAnonymousModule("autogen-tables", .{ .source_file = tables_zig_file });

    // Samples
    for (samples) |sample_name| {
        const sample = b.addExecutable(.{
            .name = sample_name,
            .root_source_file = .{ .path = b.fmt("samples/{s}.zig", .{sample_name}) },
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

        // install to the prefix:
        const install_elf_sample = b.addInstallFile(sample.getEmittedBin(), b.fmt("samples/{s}.elf", .{sample_name}));
        b.getInstallStep().dependOn(&install_elf_sample.step);

        // add to the test suite:
        const run_sample = b.addRunArtifact(exe);
        run_sample.addFileArg(sample.getEmittedBin());
        run_sample.expectExitCode(0);
        test_step.dependOn(&run_sample.step);
    }

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_unit_tests.step);
}
