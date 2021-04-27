//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using 

const std = @import("std");

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

fn addEmbeddedExecutable(builder: *std.build.Builder, name: []const u8, source: []const u8, backing: Backing) *std.build.LibExeObjStep {
    const Pkg = std.build.Pkg;

    const exe = builder.addExecutable(name, source);

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" package instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this

    exe.bundle_compiler_rt = false;

    switch (backing) {
        .chip => |chip| {
            exe.addBuildOption(bool, "microzig_has_board", false);
            exe.addBuildOption([]const u8, "microzig_chip_name", chip.name);
            exe.addBuildOption([]const u8, "microzig_cpu_name", chip.cpu.name);
            exe.setTarget(chip.cpu.target);
            exe.setLinkerScriptPath(chip.cpu.linker_script);
            exe.addPackage(Pkg{
                .name = "microzig",
                .path = "src/core/microzig.zig",
                .dependencies = &[_]Pkg{
                    Pkg{
                        .name = "chip",
                        .path = chip.path,
                        .dependencies = &[_]Pkg{
                            Pkg{
                                .name = "cpu",
                                .path = chip.cpu.path,
                            },
                        },
                    },
                },
            });
        },
        .board => |board| {
            exe.addBuildOption(bool, "microzig_has_board", true);
            exe.addBuildOption([]const u8, "microzig_board_name", board.name);
            exe.addBuildOption([]const u8, "microzig_chip_name", board.chip.name);
            exe.addBuildOption([]const u8, "microzig_cpu_name", board.chip.cpu.name);
            exe.setTarget(board.chip.cpu.target);
            exe.setLinkerScriptPath(board.chip.cpu.linker_script);
            exe.addPackage(Pkg{
                .name = "microzig",
                .path = "src/core/microzig.zig",
                .dependencies = &[_]Pkg{
                    Pkg{
                        .name = "board",
                        .path = board.path,
                        .dependencies = &[_]Pkg{
                            Pkg{
                                .name = "chip",
                                .path = board.chip.path,
                                .dependencies = &[_]Pkg{
                                    Pkg{
                                        .name = "cpu",
                                        .path = board.chip.cpu.path,
                                    },
                                },
                            },
                        },
                    },
                },
            });
        },
    }
    return exe;
}

const pkgs = struct {
    const cpus = struct {
        const avr5 = Cpu{
            .name = "avr",
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
            .name = "cortex-m3",
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
            .name = "AtMega328p",
            .path = "src/modules/chips/atmega328p/atmega328p.zig",
            .cpu = cpus.avr5,
        };
        const lpc1768 = Chip{
            .name = "mcu",
            .path = "src/modules/chips/lpc1768/lpc1768.zig",
            .cpu = cpus.cortex_m3,
        };
    };

    const boards = struct {
        const arduino_nano = Board{
            .name = "board",
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

    inline for (all_backings) |cfg| {
        const exe = addEmbeddedExecutable(
            b,
            "test-minimal-" ++ cfg.name,
            "tests/minimal.zig",
            cfg.backing,
        );
        exe.setBuildMode(mode);

        test_step.dependOn(&exe.step);
    }
}
