//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const LibExeObjStep = std.Build.LibExeObjStep;
const Module = std.Build.Module;
const LazyPath = std.Build.LazyPath;
const OptionsStep = std.Build.OptionsStep;
const Dependency = std.Build.Dependency;
const Build = std.Build;

// alias for packages
pub const LinkerScriptStep = @import("src/modules/LinkerScriptStep.zig");
pub const cpus = @import("src/modules/cpus.zig");
pub const Board = @import("src/modules/Board.zig");
pub const Chip = @import("src/modules/Chip.zig");
pub const Cpu = @import("src/modules/Cpu.zig");
pub const MemoryRegion = @import("src/modules/MemoryRegion.zig");

pub const Backing = union(enum) {
    board: Board,
    chip: Chip,

    pub fn get_target(self: @This()) std.zig.CrossTarget {
        return switch (self) {
            .board => |brd| brd.chip.cpu.target,
            .chip => |chip| chip.cpu.target,
        };
    }
};

pub const EmbeddedExecutable = struct {
    inner: *LibExeObjStep,

    pub const AppDependencyOptions = struct {
        depend_on_microzig: bool = false,
    };

    pub fn addAppDependency(exe: *EmbeddedExecutable, name: []const u8, module: *Module, options: AppDependencyOptions) void {
        if (options.depend_on_microzig) {
            const microzig_module = exe.inner.modules.get("microzig").?;
            module.dependencies.put("microzig", microzig_module) catch @panic("OOM");
        }

        const app_module = exe.inner.modules.get("app").?;
        app_module.dependencies.put(name, module) catch @panic("OOM");
    }

    pub fn installArtifact(exe: *EmbeddedExecutable, b: *Build) void {
        b.installArtifact(exe.inner);
    }

    pub fn addIncludePath(exe: *EmbeddedExecutable, path: []const u8) void {
        exe.inner.addIncludePath(path);
    }

    pub fn addSystemIncludePath(exe: *EmbeddedExecutable, path: []const u8) void {
        return exe.inner.addSystemIncludePath(path);
    }

    pub fn addCSourceFile(exe: *EmbeddedExecutable, file: []const u8, flags: []const []const u8) void {
        exe.inner.addCSourceFile(file, flags);
    }

    pub fn addOptions(exe: *EmbeddedExecutable, module_name: []const u8, options: *OptionsStep) void {
        exe.inner.addOptions(module_name, options);
        const app_module = exe.inner.modules.get("app").?;
        const opt_module = exe.inner.modules.get(module_name).?;
        app_module.dependencies.put(module_name, opt_module) catch @panic("OOM");
    }

    pub fn addObjectFile(exe: *EmbeddedExecutable, source_file: []const u8) void {
        exe.inner.addObjectFile(source_file);
    }
};

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const EmbeddedExecutableOptions = struct {
    name: []const u8,
    source_file: LazyPath,
    backing: Backing,
    optimize: std.builtin.OptimizeMode = .Debug,
    linkerscript_source_file: ?LazyPath = null,
};

pub fn addEmbeddedExecutable(
    b: *Build,
    microzig_dep: *Dependency,
    opts: EmbeddedExecutableOptions,
) *EmbeddedExecutable {
    return addEmbeddedExecutableImpl(b, microzig_dep, opts);
}

fn addEmbeddedExecutableImpl(
    b: *Build,
    microzig_dep: ?*Dependency,
    opts: EmbeddedExecutableOptions,
) *EmbeddedExecutable {
    const has_board = (opts.backing == .board);
    const chip = switch (opts.backing) {
        .chip => |chip| chip,
        .board => |board| board.chip,
    };

    const has_hal = chip.hal != null;

    // TODO: let the user override which ram section to use the stack on,
    // for now just using the first ram section in the memory region list
    const first_ram = blk: {
        for (chip.memory_regions) |region| {
            if (region.kind == .ram)
                break :blk region;
        } else @panic("no ram memory region found for setting the end-of-stack address");
    };

    const config = b.addOptions();
    config.addOption(bool, "has_hal", has_hal);
    config.addOption(bool, "has_board", has_board);
    if (has_board)
        config.addOption([]const u8, "board_name", opts.backing.board.name);

    config.addOption([]const u8, "chip_name", chip.name);
    config.addOption([]const u8, "cpu_name", chip.name);
    config.addOption(usize, "end_of_stack", first_ram.offset + first_ram.length);

    const microzig_module = b.createModule(.{
        .source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/microzig.zig", .{root_dir()}) },
    });

    microzig_module.dependencies.put("config", b.createModule(.{
        .source_file = config.getSource(),
    })) catch unreachable;

    microzig_module.dependencies.put("chip", b.createModule(.{
        .source_file = if (chip.source != .path)
            chip.source
        else source: {
            const path = chip.source.path;
            // Chip files may be generated at run time from regz.
            const extension = std.fs.path.extension(path);
            if (std.mem.eql(u8, ".zig", extension))
                break :source chip.source;

            // This only ever intends to run on the host machine, so no target or
            // optimize set
            const microzig_b = microzig_dep.?.builder;
            const regz_dep = microzig_b.dependency("regz", .{ .optimize = .ReleaseSafe });
            const regz_exe = regz_dep.artifact("regz");
            const regz_run = b.addRunArtifact(regz_exe);

            const basename = std.mem.trim(u8, std.fs.path.basename(path), extension);
            const source = regz_run.addPrefixedOutputFileArg("-o", b.fmt("{s}.zig", .{basename}));
            regz_run.addArg(path);
            break :source source;
        },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    microzig_module.dependencies.put("cpu", b.createModule(.{
        .source_file = chip.cpu.source,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    if (chip.hal) |hal_module_source| {
        microzig_module.dependencies.put("hal", b.createModule(.{
            .source_file = hal_module_source,
            .dependencies = &.{
                .{ .name = "microzig", .module = microzig_module },
            },
        })) catch unreachable;
    }

    switch (opts.backing) {
        .board => |board| {
            microzig_module.dependencies.put("board", b.createModule(.{
                .source_file = board.source,
                .dependencies = &.{
                    .{ .name = "microzig", .module = microzig_module },
                },
            })) catch unreachable;
        },
        else => {},
    }

    const app_module = b.createModule(.{
        .source_file = opts.source_file,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    });

    const exe = b.allocator.create(EmbeddedExecutable) catch unreachable;
    exe.* = EmbeddedExecutable{
        .inner = b.addExecutable(.{
            .name = opts.name,
            .root_source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/start.zig", .{root_dir()}) },
            .target = chip.cpu.target,
            .optimize = opts.optimize,
        }),
    };
    exe.inner.addModule("app", app_module);
    exe.inner.addModule("microzig", microzig_module);

    exe.inner.strip = false; // we always want debug symbols, stripping brings us no benefit on embedded

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.inner.single_threaded = true;

    if (opts.linkerscript_source_file) |linkerscript_source_file| {
        exe.inner.setLinkerScriptPath(linkerscript_source_file);
    } else {
        const linkerscript = LinkerScriptStep.create(b, chip) catch unreachable;
        exe.inner.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });
    }

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" module instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this
    exe.inner.bundle_compiler_rt = (exe.inner.target.getCpuArch() != .avr); // don't bundle compiler_rt for AVR as it doesn't compile right now

    return exe;
}

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *Build) !void {
    const backings = @import("test/backings.zig");
    const optimize = b.standardOptimizeOption(.{});

    const minimal = addEmbeddedExecutableImpl(b, null, .{
        .name = "minimal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/minimal.zig",
        },
        .backing = backings.minimal,
        .optimize = optimize,
    });

    const has_hal = addEmbeddedExecutableImpl(b, null, .{
        .name = "has_hal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/has_hal.zig",
        },
        .backing = backings.has_hal,
        .optimize = optimize,
    });

    const has_board = addEmbeddedExecutableImpl(b, null, .{
        .name = "has_board",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/has_board.zig",
        },
        .backing = backings.has_board,
        .optimize = optimize,
    });

    const core_tests = b.addTest(.{
        .root_source_file = .{
            .path = comptime root_dir() ++ "/src/core.zig",
        },
        .optimize = optimize,
    });

    const test_step = b.step("test", "build test programs");
    test_step.dependOn(&minimal.inner.step);
    test_step.dependOn(&has_hal.inner.step);
    test_step.dependOn(&has_board.inner.step);
    test_step.dependOn(&b.addRunArtifact(core_tests).step);
}
