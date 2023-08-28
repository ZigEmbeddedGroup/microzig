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
    const tables_step = b.step("tables", "Installs the table generator");

    // Options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Static modules

    const aviron_module = b.addModule("aviron", .{
        .source_file = .{ .path = "src/main.zig" },
    });

    const isa_module = b.createModule(.{
        .source_file = .{ .path = "src/shared/isa.zig" },
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
    generate_tables_exe.addModule("isa", isa_module);

    tables_step.dependOn(&b.addInstallArtifact(generate_tables_exe, .{}).step);

    const run_generate_tables_cmd = b.addRunArtifact(generate_tables_exe);

    const tables_zig_file = run_generate_tables_cmd.addOutputFileArg("tables.zig");

    exe.addAnonymousModule("autogen-tables", .{
        .source_file = tables_zig_file,
        .dependencies = &.{
            .{ .name = "isa", .module = isa_module },
        },
    });
    exe.addModule("isa", isa_module);

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

            const FileAction = union(enum) {
                compile,
                load,
                ignore,
                unknown,
            };

            const extension_to_action = .{
                .c = .compile,
                .cpp = .compile,
                .S = .compile,
                .zig = .compile,

                .bin = .load,

                .inc = .ignore,
                .h = .ignore,
                .json = .ignore,
            };

            const ext = std.fs.path.extension(entry.basename);
            const action: FileAction = inline for (std.meta.fields(@TypeOf(extension_to_action))) |fld| {
                const action: FileAction = @field(extension_to_action, fld.name);

                if (std.mem.eql(u8, ext, "." ++ fld.name))
                    break action;
            } else .unknown;

            const ConfigAndExe = struct {
                binary: std.Build.LazyPath,
                config: TestSuiteConfig,
            };

            const cae: ConfigAndExe = switch (action) {
                .unknown => std.debug.panic("Unknown test action on file testsuite/{s}, please fix the build script.", .{entry.path}),
                .ignore => continue,

                .compile => blk: {
                    var file = try entry.dir.openFile(entry.basename, .{});
                    defer file.close();

                    const config = try parseTestSuiteConfig(b, file);

                    const test_payload = b.addExecutable(.{
                        .name = entry.basename,
                        .root_source_file = .{ .path = b.fmt("testsuite/{s}", .{entry.path}) },
                        .target = avr_target,
                        .optimize = config.optimize,
                    });
                    test_payload.bundle_compiler_rt = false;
                    test_payload.setLinkerScriptPath(std.build.FileSource{ .path = "linker.ld" });
                    test_payload.addAnonymousModule("testsuite", .{
                        .source_file = .{ .path = "src/libtestsuite/lib.zig" },
                    });

                    break :blk ConfigAndExe{
                        .binary = test_payload.getEmittedBin(),
                        .config = config,
                    };
                },
                .load => blk: {
                    const config = if (entry.dir.openFile(b.fmt("{s}.json", .{entry.basename}), .{})) |file| cfg: {
                        defer file.close();
                        break :cfg try loadTestSuiteConfig(b, file);
                    } else |_| TestSuiteConfig{};

                    break :blk ConfigAndExe{
                        .binary = .{ .path = b.dupe(entry.path) },
                        .config = config,
                    };
                },
            };

            const test_run = b.addRunArtifact(exe);
            test_run.addFileArg(cae.binary);

            test_run.setStdIn(.{ .bytes = cae.config.stdin });
            test_run.expectExitCode(cae.config.exit_code);
            test_run.expectStdOutEqual(cae.config.stdout);
            test_run.expectStdErrEqual(cae.config.stderr);

            test_step.dependOn(&test_run.step);
        }
    }
}

const TestSuiteConfig = struct {
    exit_code: u8 = 0,
    stdout: []const u8 = "",
    stderr: []const u8 = "",
    stdin: []const u8 = "",
    mileage: ?u32 = 0,

    optimize: std.builtin.OptimizeMode = .ReleaseSmall,
};

fn loadTestSuiteConfig(b: *std.Build, file: std.fs.File) !TestSuiteConfig {
    var reader = std.json.reader(b.allocator, file.reader());
    defer reader.deinit();

    return try std.json.parseFromTokenSourceLeaky(
        TestSuiteConfig,
        b.allocator,
        &reader,
        .{
            .allocate = .alloc_always,
        },
    );
}

fn parseTestSuiteConfig(b: *std.Build, file: std.fs.File) !TestSuiteConfig {
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
