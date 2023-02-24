//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const LibExeObjStep = std.build.LibExeObjStep;
const Module = std.build.Module;

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

pub const BuildOptions = struct {
    optimize: std.builtin.OptimizeMode = .Debug,
};

pub const EmbeddedExecutable = struct {
    inner: *LibExeObjStep,

    pub fn addModule(exe: *EmbeddedExecutable, name: []const u8, module: *Module) void {
        exe.inner.addModule(name, module);
    }

    pub fn install(exe: *EmbeddedExecutable) void {
        exe.inner.install();
    }

    pub fn installRaw(exe: *EmbeddedExecutable, dest_filename: []const u8, options: std.build.InstallRawStep.CreateOptions) *std.build.InstallRawStep {
        return exe.inner.installRaw(dest_filename, options);
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

    pub fn addOptions(exe: *EmbeddedExecutable, module_name: []const u8, options: *std.build.OptionsStep) void {
        exe.inner.addOptions(module_name, options);
    }

    pub fn addObjectFile(exe: *EmbeddedExecutable, source_file: []const u8) void {
        exe.inner.addObjectFile(source_file);
    }
};

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub fn addEmbeddedExecutable(
    builder: *std.build.Builder,
    name: []const u8,
    source: []const u8,
    backing: Backing,
    options: BuildOptions,
) *EmbeddedExecutable {
    const has_board = (backing == .board);
    const chip = switch (backing) {
        .chip => |c| c,
        .board => |b| b.chip,
    };

    const config_file_name = blk: {
        const hash = hash_blk: {
            var hasher = std.hash.SipHash128(1, 2).init("abcdefhijklmnopq");

            hasher.update(chip.name);
            // TODO: this will likely crash for generated sources, need to
            // properly hook this up to the build cache api
            hasher.update(chip.source.getPath(builder));
            hasher.update(chip.cpu.name);
            hasher.update(chip.cpu.source.getPath(builder));

            if (backing == .board) {
                hasher.update(backing.board.name);
                // TODO: see above
                hasher.update(backing.board.source.getPath(builder));
            }

            var mac: [16]u8 = undefined;
            hasher.final(&mac);
            break :hash_blk mac;
        };

        const file_prefix = "zig-cache/microzig/config-";
        const file_suffix = ".zig";

        var ld_file_name: [file_prefix.len + 2 * hash.len + file_suffix.len]u8 = undefined;
        const filename = std.fmt.bufPrint(&ld_file_name, "{s}{}{s}", .{
            file_prefix,
            std.fmt.fmtSliceHexLower(&hash),
            file_suffix,
        }) catch unreachable;

        break :blk builder.dupe(filename);
    };

    {
        // TODO: let the user override which ram section to use the stack on,
        // for now just using the first ram section in the memory region list
        const first_ram = blk: {
            for (chip.memory_regions) |region| {
                if (region.kind == .ram)
                    break :blk region;
            } else @panic("no ram memory region found for setting the end-of-stack address");
        };

        std.fs.cwd().makeDir(std.fs.path.dirname(config_file_name).?) catch {};
        var config_file = std.fs.cwd().createFile(config_file_name, .{}) catch unreachable;
        defer config_file.close();

        var writer = config_file.writer();
        writer.print("pub const has_board = {};\n", .{has_board}) catch unreachable;
        if (has_board)
            writer.print("pub const board_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(backing.board.name)}) catch unreachable;

        writer.print("pub const chip_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.name)}) catch unreachable;
        writer.print("pub const cpu_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.cpu.name)}) catch unreachable;
        writer.print("pub const end_of_stack = 0x{X:0>8};\n\n", .{first_ram.offset + first_ram.length}) catch unreachable;
    }

    const microzig_module = builder.createModule(.{
        .source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/microzig.zig", .{root_dir()}) },
    });

    microzig_module.dependencies.put("config", builder.createModule(.{
        .source_file = .{ .path = config_file_name },
    })) catch unreachable;

    microzig_module.dependencies.put("chip", builder.createModule(.{
        .source_file = chip.source,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    microzig_module.dependencies.put("cpu", builder.createModule(.{
        .source_file = chip.cpu.source,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    microzig_module.dependencies.put("hal", builder.createModule(.{
        .source_file = if (chip.hal) |hal_module_path|
            hal_module_path
        else
            .{ .path = comptime std.fmt.comptimePrint("{s}/src/core/empty.zig", .{root_dir()}) },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    switch (backing) {
        .board => |board| {
            microzig_module.dependencies.put("board", builder.createModule(.{
                .source_file = board.source,
                .dependencies = &.{
                    .{ .name = "microzig", .module = microzig_module },
                },
            })) catch unreachable;
        },
        else => {},
    }

    microzig_module.dependencies.put("app", builder.createModule(.{
        .source_file = .{ .path = source },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    const exe = builder.allocator.create(EmbeddedExecutable) catch unreachable;
    exe.* = EmbeddedExecutable{
        .inner = builder.addExecutable(.{
            .name = name,
            .root_source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/start.zig", .{root_dir()}) },
            .target = chip.cpu.target,
            .optimize = options.optimize,
        }),
    };

    exe.inner.strip = false; // we always want debug symbols, stripping brings us no benefit on embedded

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.inner.single_threaded = true;

    const linkerscript = LinkerScriptStep.create(builder, chip) catch unreachable;
    exe.inner.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" module instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this
    exe.inner.bundle_compiler_rt = (exe.inner.target.cpu_arch.? != .avr); // don't bundle compiler_rt for AVR as it doesn't compile right now
    exe.addModule("microzig", microzig_module);

    return exe;
}

pub fn build(b: *std.build.Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    const test_step = b.step("test", "Builds and runs the library test suite");

    _ = optimize;
    _ = test_step;
}
