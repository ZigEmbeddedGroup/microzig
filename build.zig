//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const LibExeObjStep = std.Build.LibExeObjStep;
const Module = std.Build.Module;
const LazyPath = std.Build.LazyPath;
const OptionsStep = std.Build.OptionsStep;
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

    pub fn addIncludePath(exe: *EmbeddedExecutable, path: LazyPath) void {
        exe.inner.addIncludePath(path);
    }

    pub fn addSystemIncludePath(exe: *EmbeddedExecutable, path: LazyPath) void {
        return exe.inner.addSystemIncludePath(path);
    }

    pub fn addCSourceFile(exe: *EmbeddedExecutable, source: Build.Step.Compile.CSourceFile) void {
        exe.inner.addCSourceFile(source);
    }

    pub fn addOptions(exe: *EmbeddedExecutable, module_name: []const u8, options: *OptionsStep) void {
        exe.inner.addOptions(module_name, options);
        const app_module = exe.inner.modules.get("app").?;
        const opt_module = exe.inner.modules.get(module_name).?;
        app_module.dependencies.put(module_name, opt_module) catch @panic("OOM");
    }

    pub fn addObjectFile(exe: *EmbeddedExecutable, source: LazyPath) void {
        exe.inner.addObjectFile(source);
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

pub fn addEmbeddedExecutable(b: *Build, opts: EmbeddedExecutableOptions) *EmbeddedExecutable {
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
        .source_file = chip.source,
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

    const minimal = addEmbeddedExecutable(b, .{
        .name = "minimal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/minimal.zig",
        },
        .backing = backings.minimal,
        .optimize = optimize,
    });

    const has_hal = addEmbeddedExecutable(b, .{
        .name = "has_hal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/has_hal.zig",
        },
        .backing = backings.has_hal,
        .optimize = optimize,
    });

    const has_board = addEmbeddedExecutable(b, .{
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
