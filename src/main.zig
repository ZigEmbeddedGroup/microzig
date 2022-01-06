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
};

const root_path = root() ++ "/";
fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub fn addEmbeddedExecutable(
    builder: *std.build.Builder,
    name: []const u8,
    source: []const u8,
    backing: Backing,
) !*std.build.LibExeObjStep {
    const Pkg = std.build.Pkg;

    const microzig_base = Pkg{
        .name = "microzig",
        .path = .{ .path = root_path ++ "core/microzig.zig" },
    };

    const chip = switch (backing) {
        .chip => |c| c,
        .board => |b| b.chip,
    };

    const has_board = (backing == .board);

    const chip_package = Pkg{
        .name = "chip",
        .path = .{ .path = chip.path },
        .dependencies = &[_]Pkg{
            microzig_base,
            pkgs.mmio,
            Pkg{
                .name = "cpu",
                .path = .{ .path = chip.cpu.path },
                .dependencies = &[_]Pkg{ microzig_base, pkgs.mmio },
            },
        },
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
        std.fs.cwd().makeDir(std.fs.path.dirname(config_file_name).?) catch {};
        var config_file = try std.fs.cwd().createFile(config_file_name, .{});
        defer config_file.close();

        var writer = config_file.writer();
        try writer.print("pub const has_board = {};\n", .{has_board});
        if (has_board)
            try writer.print("pub const board_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(backing.board.name)});

        try writer.print("pub const chip_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.name)});
        try writer.print("pub const cpu_name = .@\"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.cpu.name)});
    }

    const config_pkg = Pkg{
        .name = "microzig-config",
        .path = .{ .path = config_file_name },
    };

    const linkerscript = try LinkerScriptStep.create(builder, chip);
    const exe = builder.addExecutable(name, source);

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.single_threaded = true;
    exe.setTarget(chip.cpu.target);

    exe.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" package instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this

    exe.bundle_compiler_rt = false;

    switch (backing) {
        .chip => {
            exe.addPackage(Pkg{
                .name = microzig_base.name,
                .path = microzig_base.path,
                .dependencies = &[_]Pkg{ config_pkg, chip_package },
            });
        },
        .board => |board| {
            exe.addPackage(Pkg{
                .name = microzig_base.name,
                .path = microzig_base.path,
                .dependencies = &[_]Pkg{
                    config_pkg,
                    chip_package,
                    Pkg{
                        .name = "board",
                        .path = .{ .path = board.path },
                        .dependencies = &[_]Pkg{ microzig_base, chip_package, pkgs.mmio },
                    },
                },
            });
        },
    }
    return exe;
}

const pkgs = struct {
    const mmio = std.build.Pkg{
        .name = "microzig-mmio",
        .path = .{ .path = root_path ++ "core/mmio.zig" },
    };
};
