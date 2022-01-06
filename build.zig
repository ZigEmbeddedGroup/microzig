//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using 

const std = @import("std");
const boards = @import("src/modules/boards.zig");
const chips = @import("src/modules/chips.zig");
const LinkerscriptStep = @import("src/modules/LinkerScriptStep.zig");

const Board = boards.Board;
const Chip = chips.Chip;
const Cpu = chips.Cpu;

pub fn build(b: *std.build.Builder) !void {
    const mode = b.standardReleaseOptions();

    const test_step = b.step("test", "Builds and runs the library test suite");

    const BuildConfig = struct { name: []const u8, backing: Backing };
    const all_backings = [_]BuildConfig{
        //BuildConfig{ .name = "boards.arduino_nano", .backing = Backing{ .board = pkgs.boards.arduino_nano } },
        BuildConfig{ .name = "boards.mbed_lpc1768", .backing = Backing{ .board = boards.mbed_lpc1768 } },
        //BuildConfig{ .name = "chips.atmega328p", .backing = Backing{ .chip = pkgs.chips.atmega328p } },
        BuildConfig{ .name = "chips.lpc1768", .backing = Backing{ .chip = chips.lpc1768 } },
    };

    const Test = struct { name: []const u8, source: []const u8 };
    const all_tests = [_]Test{
        Test{ .name = "minimal", .source = "tests/minimal.zig" },
        Test{ .name = "blinky", .source = "tests/blinky.zig" },
        Test{ .name = "uart-sync", .source = "tests/uart-sync.zig" },
    };

    const filter = b.option(std.Target.Cpu.Arch, "filter-target", "Filters for a certain cpu target");

    inline for (all_backings) |cfg| {
        inline for (all_tests) |tst| {
            const exe = try addEmbeddedExecutable(
                b,
                "test-" ++ tst.name ++ "-" ++ cfg.name,
                tst.source,
                cfg.backing,
            );

            if (filter == null or exe.target.cpu_arch.? == filter.?) {
                exe.setBuildMode(mode);
                exe.install();

                test_step.dependOn(&exe.step);
            }
        }
    }
}

fn addEmbeddedExecutable(
    builder: *std.build.Builder,
    name: []const u8,
    source: []const u8,
    backing: Backing,
) !*std.build.LibExeObjStep {
    const Pkg = std.build.Pkg;

    const microzig_base = Pkg{
        .name = "microzig",
        .path = .{ .path = "src/core/microzig.zig" },
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

    const linkerscript = try LinkerscriptStep.create(builder, chip);
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

pub const Backing = union(enum) {
    board: Board,
    chip: Chip,
};

const pkgs = struct {
    const mmio = std.build.Pkg{
        .name = "microzig-mmio",
        .path = .{ .path = "src/core/mmio.zig" },
    };
};
