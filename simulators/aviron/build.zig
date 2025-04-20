const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const ResolvedTarget = Build.ResolvedTarget;

const TestSuiteConfig = @import("src/testconfig.zig").TestSuiteConfig;

const samples = [_][]const u8{
    "math",
};

const avr_target_query = std.zig.CrossTarget{
    .cpu_arch = .avr,
    .cpu_model = .{ .explicit = &std.Target.avr.cpu.atmega328p },
    .os_tag = .freestanding,
    .abi = .none,
};

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *Build) !void {
    // Targets
    const test_step = b.step("test", "Run test suite");
    const run_step = b.step("run", "Run the app");
    const debug_testsuite_step = b.step("debug-testsuite", "Installs all testsuite examples");
    const update_testsuite_step = b.step("update-testsuite", "Updates the folder testsuite with the data in testsuite.avr-gcc. Requires avr-gcc to be present!");

    // Deps
    const args_dep = b.dependency("args", .{});

    // Dep modules

    const args_module = args_dep.module("args");

    // Options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Modules

    const isa_module = b.createModule(.{
        .root_source_file = b.path("src/shared/isa.zig"),
    });
    const isa_tables_module = b.createModule(.{
        .root_source_file = generateIsaTables(b, isa_module),
        .imports = &.{
            .{ .name = "isa", .module = isa_module },
        },
    });
    const aviron_module = b.addModule("aviron", .{
        .root_source_file = b.path("src/lib/aviron.zig"),
        .imports = &.{
            .{ .name = "autogen-tables", .module = isa_tables_module },
            .{ .name = "isa", .module = isa_module },
        },
    });

    // Main emulator executable
    const aviron_exe = b.addExecutable(.{
        .name = "aviron",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    aviron_exe.root_module.addImport("args", args_module);
    aviron_exe.root_module.addImport("aviron", aviron_module);
    b.installArtifact(aviron_exe);

    const run_cmd = b.addRunArtifact(aviron_exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    run_step.dependOn(&run_cmd.step);

    const avr_target = b.resolveTargetQuery(avr_target_query);

    // Samples
    for (samples) |sample_name| {
        const sample = b.addExecutable(.{
            .name = sample_name,
            .root_source_file = b.path(b.fmt("samples/{s}.zig", .{sample_name})),
            .target = avr_target,
            .optimize = .ReleaseSmall,
            .strip = false,
        });
        sample.bundle_compiler_rt = false;
        sample.setLinkerScriptPath(b.path("linker.ld"));

        // install to the prefix:
        const install_elf_sample = b.addInstallFile(sample.getEmittedBin(), b.fmt("samples/{s}.elf", .{sample_name}));
        b.getInstallStep().dependOn(&install_elf_sample.step);
    }

    // Test suite:

    try addTestSuite(b, test_step, debug_testsuite_step, target, avr_target, optimize, args_module, aviron_module);

    try addTestSuiteUpdate(b, update_testsuite_step);
}

fn addTestSuite(
    b: *Build,
    test_step: *Build.Step,
    debug_step: *Build.Step,
    host_target: ResolvedTarget,
    avr_target: ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    args_module: *Build.Module,
    aviron_module: *Build.Module,
) !void {
    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = host_target,
        .optimize = optimize,
    });
    test_step.dependOn(&b.addRunArtifact(unit_tests).step);

    const testrunner_exe = b.addExecutable(.{
        .name = "aviron-test-runner",
        .root_source_file = b.path("src/testrunner.zig"),
        .target = host_target,
        .optimize = optimize,
    });
    testrunner_exe.root_module.addImport("args", args_module);
    testrunner_exe.root_module.addImport("aviron", aviron_module);

    debug_step.dependOn(&b.addInstallArtifact(testrunner_exe, .{}).step);

    {
        var walkdir = try b.build_root.handle.openDir("testsuite", .{
            .iterate = true,
        });
        defer walkdir.close();

        var walker = try walkdir.walk(b.allocator);
        defer walker.deinit();

        while (try walker.next()) |entry| {
            if (entry.kind != .file)
                continue;

            if (std.mem.eql(u8, entry.path, "dummy.zig")) {
                // This file is not interesting to test.
                continue;
            }

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
                .elf = .load,

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
                binary: LazyPath,
                config: TestSuiteConfig,
            };

            const cae: ConfigAndExe = switch (action) {
                .unknown => std.debug.panic("Unknown test action on file testsuite/{s}, please fix the build script.", .{entry.path}),
                .ignore => continue,

                .compile => blk: {
                    var file = try entry.dir.openFile(entry.basename, .{});
                    defer file.close();

                    const config = try parseTestSuiteConfig(b, file);

                    const custom_target = if (config.cpu) |cpu|
                        b.resolveTargetQuery(std.zig.CrossTarget.parse(.{
                            .arch_os_abi = "avr-freestanding-eabi",
                            .cpu_features = cpu,
                        }) catch @panic(cpu))
                    else
                        avr_target;

                    const is_zig_test = std.mem.eql(u8, std.fs.path.extension(entry.path), ".zig");

                    const source_file = b.path(b.fmt("testsuite/{s}", .{entry.path}));
                    const root_file = if (is_zig_test)
                        source_file
                    else
                        b.path("testsuite/dummy.zig");

                    const test_payload = b.addExecutable(.{
                        .name = std.fs.path.stem(entry.basename),
                        .target = custom_target,
                        .optimize = config.optimize,
                        .strip = false,
                        .root_source_file = root_file,
                        .link_libc = false,
                    });
                    test_payload.want_lto = false; // AVR has no LTO support!
                    test_payload.verbose_link = true;
                    test_payload.verbose_cc = true;
                    if (!is_zig_test) {
                        test_payload.addCSourceFile(.{
                            .file = source_file,
                            .flags = &.{},
                        });
                    }
                    test_payload.bundle_compiler_rt = false;
                    test_payload.addIncludePath(b.path("testsuite"));
                    test_payload.setLinkerScriptPath(b.path("linker.ld"));
                    test_payload.root_module.addAnonymousImport("testsuite", .{
                        .root_source_file = b.path("src/libtestsuite/lib.zig"),
                    });

                    debug_step.dependOn(&b.addInstallFile(
                        test_payload.getEmittedBin(),
                        b.fmt("testsuite/{s}/{s}.elf", .{
                            std.fs.path.dirname(entry.path).?,
                            std.fs.path.stem(entry.basename),
                        }),
                    ).step);

                    break :blk ConfigAndExe{
                        .binary = test_payload.getEmittedBin(),
                        .config = config,
                    };
                },
                .load => blk: {
                    const config_path = b.fmt("{s}.json", .{entry.basename});
                    const config = if (entry.dir.openFile(config_path, .{})) |file| cfg: {
                        defer file.close();
                        break :cfg try TestSuiteConfig.load(b.allocator, file);
                    } else |_| @panic(config_path);

                    break :blk ConfigAndExe{
                        .binary = b.path(b.fmt("testsuite/{s}", .{entry.path})),
                        .config = config,
                    };
                },
            };

            const write_file = b.addWriteFile("config.json", cae.config.toString(b));

            const test_run = b.addRunArtifact(testrunner_exe);
            test_run.addArg("--config");
            test_run.addFileArg(write_file.files.items[0].getPath());
            test_run.addArg("--name");
            test_run.addArg(entry.path);

            test_run.addFileArg(cae.binary);

            test_run.expectExitCode(0);

            test_step.dependOn(&test_run.step);
        }
    }
}

fn addTestSuiteUpdate(
    b: *Build,
    invoke_step: *Build.Step,
) !void {
    const avr_gcc = if (b.findProgram(&.{"avr-gcc"}, &.{})) |path| LazyPath{
        .cwd_relative = path,
    } else |_| b.addExecutable(.{
        .name = "no-avr-gcc",
        .target = b.host,
        .root_source_file = b.path("tools/no-avr-gcc.zig"),
    }).getEmittedBin();

    {
        var walkdir = try b.build_root.handle.openDir("testsuite.avr-gcc", .{ .iterate = true });
        defer walkdir.close();

        var walker = try walkdir.walk(b.allocator);
        defer walker.deinit();

        while (try walker.next()) |entry| {
            if (entry.kind != .file)
                continue;

            const FileAction = union(enum) {
                compile,
                ignore,
                unknown,
            };

            const extension_to_action = .{
                .c = .compile,
                .cpp = .compile,
                .S = .compile,

                .inc = .ignore,
                .h = .ignore,
                .json = .ignore,
                .md = .ignore,
            };

            const ext = std.fs.path.extension(entry.basename);
            const action: FileAction = inline for (std.meta.fields(@TypeOf(extension_to_action))) |fld| {
                const action: FileAction = @field(extension_to_action, fld.name);
                if (std.mem.eql(u8, ext, "." ++ fld.name))
                    break action;
            } else .unknown;

            switch (action) {
                .unknown => std.debug.panic("Unknown test action on file testsuite/{s}, please fix the build script.", .{entry.path}),
                .ignore => continue,

                .compile => {
                    var file = try entry.dir.openFile(entry.basename, .{});
                    defer file.close();

                    const config = try parseTestSuiteConfig(b, file);

                    const gcc_invocation = Build.Step.Run.create(b, "run avr-gcc");
                    gcc_invocation.addFileArg(avr_gcc);
                    gcc_invocation.addArg("-o");
                    gcc_invocation.addArg(b.fmt("testsuite/{s}/{s}.elf", .{ std.fs.path.dirname(entry.path).?, std.fs.path.stem(entry.basename) }));
                    gcc_invocation.addArg(b.fmt("-mmcu={s}", .{config.cpu orelse @panic("Uknown MCU!")}));
                    //avr_target.cpu_model.explicit.llvm_name orelse @panic("Unknown MCU!")}));
                    for (config.gcc_flags) |opt| {
                        gcc_invocation.addArg(opt);
                    }
                    gcc_invocation.addArg("-I");
                    gcc_invocation.addArg("testsuite");
                    gcc_invocation.addArg(b.fmt("testsuite.avr-gcc/{s}", .{entry.path}));

                    const write_file = b.addWriteFile("config.json", config.toString(b));

                    const copy_file = b.addSystemCommand(&.{"cp"}); // todo make this cross-platform!
                    copy_file.addFileArg(write_file.files.items[0].getPath());
                    copy_file.addArg(b.fmt("testsuite/{s}/{s}.elf.json", .{ std.fs.path.dirname(entry.path).?, std.fs.path.stem(entry.basename) }));

                    invoke_step.dependOn(&gcc_invocation.step);
                    invoke_step.dependOn(&copy_file.step);
                },
            }
        }
    }
}

fn parseTestSuiteConfig(b: *Build, file: std.fs.File) !TestSuiteConfig {
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

fn generateIsaTables(b: *Build, isa_mod: *Build.Module) LazyPath {
    const generate_tables_exe = b.addExecutable(.{
        .name = "aviron-generate-tables",
        .root_source_file = b.path("tools/generate-tables.zig"),
        .target = b.host,
        .optimize = .Debug,
    });
    generate_tables_exe.root_module.addImport("isa", isa_mod);

    const run = b.addRunArtifact(generate_tables_exe);

    const tables_zig_file = run.addOutputFileArg("tables.zig");

    return tables_zig_file;
}
