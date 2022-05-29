const std = @import("std");

pub const LinkerScriptStep = @import("modules/LinkerScriptStep.zig");
pub const boards = @import("modules/boards.zig");
pub const chips = @import("modules/chips.zig");
pub const cpus = @import("modules/cpus.zig");
pub const Board = @import("modules/Board.zig");
pub const Chip = @import("modules/Chip.zig");
pub const Cpu = @import("modules/Cpu.zig");

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
    packages: ?[]const Pkg = null,

    // a hal package is a package with ergonomic wrappers for registers for a
    // given mcu, it's only dependency can be microzig
    hal_package_path: ?std.build.FileSource = null,
};

pub fn addEmbeddedExecutable(
    builder: *std.build.Builder,
    name: []const u8,
    source: []const u8,
    backing: Backing,
    options: BuildOptions,
) !*std.build.LibExeObjStep {
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
        const filename = try std.fmt.bufPrint(&ld_file_name, "{s}{}{s}", .{
            file_prefix,
            std.fmt.fmtSliceHexLower(&hash),
            file_suffix,
        });

        break :blk builder.dupe(filename);
    };

    {
        // TODO: let the user override which ram section to use the stack on,
        // for now just using the first ram section in the memory region list
        const first_ram = blk: {
            for (chip.memory_regions) |region| {
                if (region.kind == .ram)
                    break :blk region;
            } else {
                std.log.err("no ram memory region found for setting the end-of-stack address", .{});
                return error.NoRam;
            }
        };

        std.fs.cwd().makeDir(std.fs.path.dirname(config_file_name).?) catch {};
        var config_file = try std.fs.cwd().createFile(config_file_name, .{});
        defer config_file.close();

        var writer = config_file.writer();
        try writer.print("pub const has_board = {};\n", .{has_board});
        if (has_board)
            try writer.print("pub const board_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(backing.board.name)});

        try writer.print("pub const chip_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.name)});
        try writer.print("pub const cpu_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.cpu.name)});
        try writer.print("pub const end_of_stack = 0x{X:0>8};\n\n", .{first_ram.offset + first_ram.length});
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

    const exe = builder.addExecutable(name, root_path ++ "core/microzig.zig");

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.single_threaded = true;
    exe.setTarget(chip.cpu.target);

    const linkerscript = try LinkerScriptStep.create(builder, chip);
    exe.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" package instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this
    exe.bundle_compiler_rt = (exe.target.cpu_arch.? != .avr); // don't bundle compiler_rt for AVR as it doesn't compile right now

    const app_pkg = blk: {
        var app_pkgs = std.ArrayList(Pkg).init(builder.allocator);

        try app_pkgs.append(pkgs.microzig); // proxy package
        if (options.packages) |packages|
            try app_pkgs.appendSlice(packages);

        break :blk std.build.Pkg{
            .name = "app",
            .source = .{ .path = source },
            .dependencies = app_pkgs.items,
        };
    };

    // these packages will be re-exported from core/microzig.zig

    exe.addPackage(app_pkg);
    exe.addPackage(config_pkg);
    exe.addPackage(chip_pkg);
    exe.addPackage(cpu_pkg);

    if (options.hal_package_path) |hal_package_path|
        exe.addPackage(.{
            .name = "hal",
            .source = hal_package_path,
            .dependencies = &.{pkgs.microzig},
        });

    switch (backing) {
        .board => |board| {
            exe.addPackage(std.build.Pkg{
                .name = "board",
                .source = .{ .path = board.path },
                .dependencies = &.{pkgs.microzig},
            });
        },
        else => {},
    }

    return exe;
}

const pkgs = struct {
    const mmio = std.build.Pkg{
        .name = "microzig-mmio",
        .source = .{ .path = root_path ++ "core/mmio.zig" },
    };

    const microzig = std.build.Pkg{
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
