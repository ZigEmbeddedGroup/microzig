const std = @import("std");

pub const LinkerScriptStep = @import("modules/LinkerScriptStep.zig");
pub const boards = @import("modules/boards.zig");
pub const chips = @import("modules/chips.zig");
pub const cpus = @import("modules/cpus.zig");
pub const Board = @import("modules/Board.zig");
pub const Chip = @import("modules/Chip.zig");
pub const Cpu = @import("modules/Cpu.zig");

const LibExeObjStep = std.build.LibExeObjStep;

pub const Backing = union(enum) {
    board: Board,
    chip: Chip,

    pub fn getTarget(self: @This()) std.zig.CrossTarget {
        return switch (self) {
            .board => |brd| brd.chip.cpu.target,
            .chip => |chip| chip.cpu.target,
        };
    }
};

const Module = std.build.Module;
const root_path = root() ++ "/";
fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const BuildOptions = struct {
    // a hal module is a module with ergonomic wrappers for registers for a
    // given mcu, it's only dependency can be microzig
    hal_module_path: ?std.build.FileSource = null,
    optimize: std.builtin.OptimizeMode = .Debug,
};

pub const EmbeddedExecutable = struct {
    inner: *LibExeObjStep,

    pub fn addModule(exe: *EmbeddedExecutable, name: []const u8, module: *Module) void {
        exe.inner.addModule(name, module);
    }

    pub fn addDriver(exe: *EmbeddedExecutable, driver: Driver) void {
        var dependencies = std.ArrayList(std.Build.ModuleDependency).init(exe.inner.builder.allocator);

        for (driver.dependencies) |dep| {
            dependencies.append(.{
                .name = dep,
                .module = exe.inner.builder.modules.get(dep).?,
            }) catch @panic("OOM");
        }

        // TODO: this is not perfect but should work for now
        exe.inner.addAnonymousModule(driver.name, .{
            .source_file = driver.source_file,
            .dependencies = dependencies.toOwnedSlice() catch @panic("OOM"),
        });

        const app_module = exe.inner.modules.get("app").?;
        const driver_module = exe.inner.modules.get(driver.name).?;

        app_module.dependencies.put(driver.name, driver_module) catch @panic("OOM");
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

pub fn addEmbeddedExecutable(
    builder: *std.build.Builder,
    name: []const u8,
    source: []const u8,
    backing: Backing,
    options: BuildOptions,
) EmbeddedExecutable {
    const has_board = (backing == .board);
    const chip = switch (backing) {
        .chip => |c| c,
        .board => |b| b.chip,
    };

    const config_file_name = blk: {
        const hash = hash_blk: {
            var hasher = std.hash.SipHash128(1, 2).init("abcdefhijklmnopq");

            hasher.update(chip.name);
            hasher.update(chip.path);
            hasher.update(chip.cpu.name);
            hasher.update(chip.cpu.path);

            if (backing == .board) {
                hasher.update(backing.board.name);
                hasher.update(backing.board.path);
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

    builder.addModule(.{
        .name = "microzig",
        .source_file = .{ .path = root_path ++ "core/import-module.zig" },
    });
    const microzig = builder.modules.get("microzig").?;

    const config_module = builder.createModule(.{
        .source_file = .{ .path = config_file_name },
    });

    const chip_module = builder.createModule(.{
        .source_file = .{ .path = chip.path },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig },
        },
    });

    const cpu_module = builder.createModule(.{
        .source_file = .{ .path = chip.cpu.path },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig },
        },
    });

    var exe = EmbeddedExecutable{
        .inner = builder.addExecutable(.{
            .name = name,
            .root_source_file = .{ .path = root_path ++ "core/microzig.zig" },
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

    // these modules will be re-exported from core/microzig.zig
    exe.inner.addModule("microzig-config", config_module);
    exe.inner.addModule("chip", chip_module);
    exe.inner.addModule("cpu", cpu_module);

    exe.inner.addModule("hal", builder.createModule(.{
        .source_file = if (options.hal_module_path) |hal_module_path|
            hal_module_path
        else
            .{ .path = root_path ++ "core/empty.zig" },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig },
        },
    }));

    switch (backing) {
        .board => |board| {
            exe.inner.addModule("board", builder.createModule(.{
                .source_file = .{ .path = board.path },
                .dependencies = &.{
                    .{ .name = "microzig", .module = microzig },
                },
            }));
        },
        else => {},
    }

    exe.inner.addModule("app", builder.createModule(.{
        .source_file = .{ .path = source },
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig },
        },
    }));

    return exe;
}

pub const Driver = struct {
    name: []const u8,
    source_file: std.build.FileSource,
    dependencies: []const []const u8,
};

// Generic purpose drivers shipped with microzig
pub const drivers = struct {
    pub const quadrature = Driver{
        .name = "microzig.quadrature",
        .source_file = .{ .path = root_path ++ "drivers/quadrature.zig" },
        .dependencies = &.{"microzig"},
    };

    pub const button = Driver{
        .name = "microzig.button",
        .source_file = .{ .path = root_path ++ "drivers/button.zig" },
        .dependencies = &.{"microzig"},
    };
};
