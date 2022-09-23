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

const Pkg = std.build.Pkg;
const root_path = root() ++ "/";
fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const BuildOptions = struct {
    // a hal package is a package with ergonomic wrappers for registers for a
    // given mcu, it's only dependency can be microzig
    hal_package_path: ?std.build.FileSource = null,
};

pub const EmbeddedExecutable = struct {
    inner: *LibExeObjStep,
    app_packages: std.ArrayList(Pkg),

    pub fn addPackage(exe: *EmbeddedExecutable, pkg: Pkg) void {
        exe.app_packages.append(pkg) catch @panic("failed to append");

        for (exe.inner.packages.items) |*entry| {
            if (std.mem.eql(u8, "app", entry.name)) {
                entry.dependencies = exe.app_packages.items;
                break;
            }
        } else @panic("app package not found");
    }

    pub fn addPackagePath(exe: *EmbeddedExecutable, name: []const u8, pkg_index_path: []const u8) void {
        exe.addPackage(Pkg{
            .name = exe.inner.builder.allocator.dupe(u8, name) catch unreachable,
            .source = .{ .path = exe.inner.builder.allocator.dupe(u8, pkg_index_path) catch unreachable },
        });
    }

    pub fn setBuildMode(exe: *EmbeddedExecutable, mode: std.builtin.Mode) void {
        exe.inner.setBuildMode(mode);
    }

    pub fn install(exe: *EmbeddedExecutable) void {
        exe.inner.install();
    }

    pub fn installRaw(exe: *EmbeddedExecutable, dest_filename: []const u8, options: std.build.InstallRawStep.CreateOptions) *std.build.InstallRawStep {
        return exe.inner.installRaw(dest_filename, options);
    }

    pub fn addIncludePath(exe: *EmbeddedExecutable, path: []const u8) void {
        exe.addIncludePath(path);
    }

    pub fn addSystemIncludePath(exe: *EmbeddedExecutable, path: []const u8) void {
        return exe.inner.addSystemIncludePath(path);
    }

    pub fn addCSourceFile(exe: *EmbeddedExecutable, file: []const u8, flags: []const []const u8) void {
        exe.inner.addCSourceFile(file, flags);
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
            writer.print("pub const board_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(backing.board.name)}) catch unreachable;

        writer.print("pub const chip_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.name)}) catch unreachable;
        writer.print("pub const cpu_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.cpu.name)}) catch unreachable;
        writer.print("pub const end_of_stack = 0x{X:0>8};\n\n", .{first_ram.offset + first_ram.length}) catch unreachable;
    }

    const config_pkg = Pkg{
        .name = "microzig-config",
        .source = .{ .path = config_file_name },
    };

    const chip_pkg = Pkg{
        .name = "chip",
        .source = .{ .path = chip.path },
        .dependencies = &.{pkgs.microzig},
    };

    const cpu_pkg = Pkg{
        .name = "cpu",
        .source = .{ .path = chip.cpu.path },
        .dependencies = &.{pkgs.microzig},
    };

    var exe = EmbeddedExecutable{
        .inner = builder.addExecutable(name, root_path ++ "core/microzig.zig"),
        .app_packages = std.ArrayList(Pkg).init(builder.allocator),
    };

    exe.inner.use_stage1 = true;

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.inner.single_threaded = true;
    exe.inner.setTarget(chip.cpu.target);

    const linkerscript = LinkerScriptStep.create(builder, chip) catch unreachable;
    exe.inner.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" package instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this
    exe.inner.bundle_compiler_rt = (exe.inner.target.cpu_arch.? != .avr); // don't bundle compiler_rt for AVR as it doesn't compile right now

    // these packages will be re-exported from core/microzig.zig
    exe.inner.addPackage(config_pkg);
    exe.inner.addPackage(chip_pkg);
    exe.inner.addPackage(cpu_pkg);

    exe.inner.addPackage(.{
        .name = "hal",
        .source = if (options.hal_package_path) |hal_package_path|
            hal_package_path
        else .{ .path = root_path ++ "core/empty.zig" },
        .dependencies = &.{pkgs.microzig},
    });

    switch (backing) {
        .board => |board| {
            exe.inner.addPackage(std.build.Pkg{
                .name = "board",
                .source = .{ .path = board.path },
                .dependencies = &.{pkgs.microzig},
            });
        },
        else => {},
    }

    exe.inner.addPackage(.{
        .name = "app",
        .source = .{ .path = source },
    });
    exe.addPackage(pkgs.microzig);

    return exe;
}

pub const pkgs = struct {
    const mmio = std.build.Pkg{
        .name = "microzig-mmio",
        .source = .{ .path = root_path ++ "core/mmio.zig" },
    };

    pub const microzig = std.build.Pkg{
        .name = "microzig",
        .source = .{ .path = root_path ++ "core/import-package.zig" },
    };
};

/// Generic purpose drivers shipped with microzig
pub const drivers = struct {
    pub const quadrature = std.build.Pkg{
        .name = "microzig.quadrature",
        .source = .{ .path = root_path ++ "drivers/quadrature.zig" },
        .dependencies = &.{pkgs.microzig},
    };

    pub const button = std.build.Pkg{
        .name = "microzig.button",
        .source = .{ .path = root_path ++ "drivers/button.zig" },
        .dependencies = &.{pkgs.microzig},
    };
};
