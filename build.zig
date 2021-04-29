//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using 

const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const test_step = b.step("test", "Builds and runs the library test suite");

    const BuildConfig = struct { name: []const u8, backing: Backing };
    const all_backings = [_]BuildConfig{
        BuildConfig{ .name = "boards.arduino_nano", .backing = Backing{ .board = pkgs.boards.arduino_nano } },
        BuildConfig{ .name = "boards.mbed_lpc1768", .backing = Backing{ .board = pkgs.boards.mbed_lpc1768 } },
        BuildConfig{ .name = "chips.atmega328p", .backing = Backing{ .chip = pkgs.chips.atmega328p } },
        BuildConfig{ .name = "chips.lpc1768", .backing = Backing{ .chip = pkgs.chips.lpc1768 } },
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
            const exe = addEmbeddedExecutable(
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

fn addEmbeddedExecutable(builder: *std.build.Builder, name: []const u8, source: []const u8, backing: Backing) *std.build.LibExeObjStep {
    const Pkg = std.build.Pkg;

    const chip = switch (backing) {
        .chip => |c| c,
        .board => |b| b.chip,
    };

    const has_board = (backing == .board);

    const chip_package = Pkg{
        .name = "chip",
        .path = chip.path,
        .dependencies = &[_]Pkg{
            pkgs.mmio,
            Pkg{
                .name = "cpu",
                .path = chip.cpu.path,
                .dependencies = &[_]Pkg{pkgs.mmio},
            },
            Pkg{
                .name = "microzig-linker",
                .path = "src/modules/linker/linker.zig",
            },
        },
    };

    const linker_script_name = blk: {
        const hash = hash_blk: {
            var hasher = std.hash.SipHash128(1, 2).init("abcdefhijklmnopq");

            hasher.update(chip.name);
            hasher.update(chip.path);
            hasher.update(chip.cpu.name);
            hasher.update(chip.cpu.path);

            var mac: [16]u8 = undefined;
            hasher.final(&mac);
            break :hash_blk mac;
        };

        const file_prefix = "zig-cache/microzig/";
        const file_suffix = ".ld";

        var ld_file_name: [file_prefix.len + 2 * hash.len + file_suffix.len]u8 = undefined;
        const filename = std.fmt.bufPrint(&ld_file_name, "{s}{}{s}", .{
            file_prefix,
            std.fmt.fmtSliceHexLower(&hash),
            file_suffix,
        }) catch unreachable;

        break :blk builder.dupe(filename);
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
        var config_file = std.fs.cwd().createFile(config_file_name, .{}) catch unreachable;
        defer config_file.close();

        var writer = config_file.writer();

        writer.print("pub const has_board = {};\n", .{has_board}) catch unreachable;
        if (has_board) {
            writer.print("pub const board_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(backing.board.name)}) catch unreachable;
        }

        writer.print("pub const chip_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.name)}) catch unreachable;
        writer.print("pub const cpu_name = \"{}\";\n", .{std.fmt.fmtSliceEscapeUpper(chip.cpu.name)}) catch unreachable;
    }

    const config_pkg = Pkg{
        .name = "microzig-config",
        .path = config_file_name,
    };

    const linkerscript_gen = builder.addExecutable("linkerscript-gen", "src/tools/linkerscript-gen.zig");
    linkerscript_gen.addPackage(chip_package);
    linkerscript_gen.addPackage(Pkg{
        .name = "microzig-linker",
        .path = "src/modules/linker/linker.zig",
    });
    linkerscript_gen.addBuildOption([]const u8, "microzig_chip_name", chip.name);
    linkerscript_gen.addBuildOption([]const u8, "microzig_cpu_name", chip.cpu.name);
    linkerscript_gen.addBuildOption([]const u8, "microzig_target_triple", chip.cpu.target.zigTriple(builder.allocator) catch unreachable);

    const linkerscript_invocation = linkerscript_gen.run();
    linkerscript_invocation.addArg(linker_script_name);

    const exe = builder.addExecutable(name, source);

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.single_threaded = true;
    exe.setTarget(chip.cpu.target);

    exe.setLinkerScriptPath(linker_script_name);
    exe.step.dependOn(&linkerscript_invocation.step);

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" package instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this

    exe.bundle_compiler_rt = false;

    switch (backing) {
        .chip => {
            exe.addPackage(Pkg{
                .name = "microzig",
                .path = "src/core/microzig.zig",
                .dependencies = &[_]Pkg{ config_pkg, chip_package },
            });
        },
        .board => |board| {
            exe.addPackage(Pkg{
                .name = "microzig",
                .path = "src/core/microzig.zig",
                .dependencies = &[_]Pkg{
                    config_pkg,
                    chip_package,
                    Pkg{
                        .name = "board",
                        .path = board.path,
                        .dependencies = &[_]Pkg{ chip_package, pkgs.mmio },
                    },
                },
            });
        },
    }
    return exe;
}

const Board = struct {
    name: []const u8,
    path: []const u8,
    chip: Chip,
};

const Chip = struct {
    name: []const u8,
    path: []const u8,
    cpu: Cpu,
};

const Cpu = struct {
    name: []const u8,
    path: []const u8,
    target: std.zig.CrossTarget,
    linker_script: []const u8,
};

pub const Backing = union(enum) {
    board: Board,
    chip: Chip,
};

const pkgs = struct {
    const mmio = std.build.Pkg{
        .name = "microzig-mmio",
        .path = "src/core/mmio.zig",
    };

    const cpus = struct {
        const avr5 = Cpu{
            .name = "AVR5",
            .path = "src/modules/cpus/avr/avr5.zig",
            .linker_script = "src/modules/cpus/avr/linker.ld",
            .target = std.zig.CrossTarget{
                .cpu_arch = .avr,
                .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
        };
        const cortex_m3 = Cpu{
            .name = "ARM Cortex-M3",
            .path = "src/modules/cpus/cortex-m3/cortex-m3.zig",
            .linker_script = "src/modules/cpus/cortex-m3/linker.ld",
            .target = std.zig.CrossTarget{
                .cpu_arch = .arm,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
        };
    };

    const chips = struct {
        const atmega328p = Chip{
            .name = "ATmega328p",
            .path = "src/modules/chips/atmega328p/atmega328p.zig",
            .cpu = cpus.avr5,
        };
        const lpc1768 = Chip{
            .name = "NXP LPC1768",
            .path = "src/modules/chips/lpc1768/lpc1768.zig",
            .cpu = cpus.cortex_m3,
        };
    };

    const boards = struct {
        const arduino_nano = Board{
            .name = "Arduino Nano",
            .path = "src/modules/boards/arduino-nano/arduino-nano.zig",
            .chip = chips.atmega328p,
        };
        const mbed_lpc1768 = Board{
            .name = "mbed LPC1768",
            .path = "src/modules/boards/mbed-lpc1768/mbed-lpc1768.zig",
            .chip = chips.lpc1768,
        };
    };
};
