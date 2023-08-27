const std = @import("std");

const samples = [_][]const u8{
    "math",
};

const avr_target = std.zig.CrossTarget{
    .cpu_arch = .avr,
    .cpu_model = .{ .explicit = &std.Target.avr.cpu.atmega328p },
    .os_tag = .freestanding,
    .abi = .none,
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
            .target = avr_target,
            .optimize = .ReleaseSmall,
        });
        sample.bundle_compiler_rt = false;
        sample.setLinkerScriptPath(std.build.FileSource{ .path = "linker.ld" });

        // install to the prefix:
        const install_elf_sample = b.addInstallFile(sample.getEmittedBin(), b.fmt("samples/{s}.elf", .{sample_name}));
        b.getInstallStep().dependOn(&install_elf_sample.step);
    }

    // Test suite:

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_unit_tests.step);

    {
        var walkdir = try b.build_root.handle.openIterableDir("testsuite", .{});
        defer walkdir.close();

        var walker = try walkdir.walk(b.allocator);
        defer walker.deinit();

        while (try walker.next()) |entry| {
            if (entry.kind != .file)
                continue;

            var file = try entry.dir.openFile(entry.basename, .{});
            defer file.close();

            const config = try loadTestSuiteConfig(b, file);

            const test_payload = b.addExecutable(.{
                .name = entry.basename,
                .root_source_file = .{ .path = b.fmt("testsuite/{s}", .{entry.path}) },
                .target = avr_target,
                .optimize = config.optimize,
            });
            test_payload.bundle_compiler_rt = false;
            test_payload.setLinkerScriptPath(std.build.FileSource{ .path = "linker.ld" });

            const test_run = b.addRunArtifact(exe);
            test_run.addFileArg(test_payload.getEmittedBin());

            test_run.expectExitCode(config.exit_code);
            test_run.expectStdOutEqual(config.stdout);
            test_run.expectStdErrEqual(config.stderr);

            test_step.dependOn(&test_run.step);
        }
    }
}

const TestSuiteConfig = struct {
    exit_code: u8 = 0,
    stdout: []const u8 = "",
    stderr: []const u8 = "",

    optimize: std.builtin.OptimizeMode = .ReleaseSmall,
};

fn loadTestSuiteConfig(b: *std.Build, file: std.fs.File) !TestSuiteConfig {
    var code = std.ArrayList(u8).init(b.allocator);
    defer code.deinit();

    var line_buffer: [4096]u8 = undefined;

    while (true) {
        var fbs = std.io.fixedBufferStream(&line_buffer);
        file.reader().streamUntilDelimiter(fbs.writer(), '\n', null) catch |err| switch (err) {
            error.EndOfStream => break,
            else => |e| return e,
        };
        const line = fbs.getWritten();

        if (std.mem.startsWith(u8, line, "//!")) {
            try code.appendSlice(line[3..]);
            try code.appendSlice("\n");
        }
    }

    const json_text = std.mem.trim(u8, code.items, "\r\n\t ");
    if (json_text.len == 0)
        return TestSuiteConfig{};

    return try std.json.parseFromSliceLeaky(
        TestSuiteConfig,
        b.allocator,
        json_text,
        .{
            .allocate = .alloc_always,
        },
    );
}
