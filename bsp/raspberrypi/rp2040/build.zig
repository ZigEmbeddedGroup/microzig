const std = @import("std");
const Build = std.Build;

const MicroZig = @import("microzig/build");
const Target = MicroZig.Target;
const Firmware = MicroZig.Firmware;

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

pub fn build(b: *Build) !void {
    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/hal.zig"),
    });
    unit_tests.addIncludePath(b.path("src/hal/pio/assembler"));

    const unit_tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run platform agnostic unit tests");
    test_step.dependOn(&unit_tests_run.step);
}

pub const chips = struct {
    // Note: This chip has no flash support defined and requires additional configuration!
    pub const rp2040 = Target{
        .preferred_format = .{ .uf2 = .RP2040 },
        .chip = chip,
        .hal = hal,
        .board = null,
        .linker_script = linker_script,
    };
};

pub const boards = struct {
    pub const raspberrypi = struct {
        pub const pico = Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "RaspberryPi Pico",
                .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/raspberry_pi_pico.zig" },
                .url = "https://www.raspberrypi.com/products/raspberry-pi-pico/",
            },
            .configure = rp2040_configure(.w25q080),
        };
    };

    pub const waveshare = struct {
        pub const rp2040_plus_4m = Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Plus (4M Flash)",
                .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_plus_4m.zig" },
                .url = "https://www.waveshare.com/rp2040-plus.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_plus_16m = Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Plus (16M Flash)",
                .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_plus_16m.zig" },
                .url = "https://www.waveshare.com/rp2040-plus.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_eth = Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-ETH Mini",
                .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_eth.zig" },
                .url = "https://www.waveshare.com/rp2040-eth.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_matrix = Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Matrix",
                .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_matrix.zig" },
                .url = "https://www.waveshare.com/rp2040-matrix.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };
    };
};

pub const BootROM = union(enum) {
    artifact: *Build.Step.Compile, // provide a custom startup code
    blob: Build.LazyPath, // just include a binary blob

    // Pre-shipped ones:
    at25sf128a,
    generic_03h,
    is25lp080,
    w25q080,
    w25x10cl,

    // Use the old stage2 bootloader vendored with MicroZig till 2023-09-13
    legacy,
};

const linker_script = .{
    .cwd_relative = build_root ++ "/rp2040.ld",
};

const hal = .{
    .root_source_file = .{ .cwd_relative = build_root ++ "/src/hal.zig" },
};

const chip = .{
    .name = "RP2040",
    .url = "https://www.raspberrypi.com/products/rp2040/",
    .cpu = MicroZig.cpus.cortex_m0plus,
    .register_definition = .{
        .svd = .{ .cwd_relative = build_root ++ "/src/chips/rp2040.svd" },
    },
    .memory_regions = &.{
        .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
        .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
        .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
    },
};

/// Returns a configuration function that will add the provided `BootROM` to the firmware.
pub fn rp2040_configure(comptime bootrom: BootROM) *const fn (mz: *MicroZig, *Firmware) void {
    const T = struct {
        fn configure(mz: *MicroZig, fw: *Firmware) void {
            const bootrom_file = get_bootrom(mz, bootrom);

            // HACK: Inject the file as a dependency to MicroZig.board
            fw.modules.board.?.addImport(
                "bootloader",
                mz.host_build.createModule(.{
                    .root_source_file = bootrom_file.bin,
                }),
            );

            // TODO: is this required?
            bootrom_file.bin.addStepDependencies(&fw.artifact.step);
        }
    };

    return T.configure;
}

pub const Stage2Bootloader = struct {
    bin: Build.LazyPath,
    elf: ?Build.LazyPath,
};

pub fn get_bootrom(mz: *MicroZig, rom: BootROM) Stage2Bootloader {
    const rom_exe = switch (rom) {
        .artifact => |artifact| artifact,
        .blob => |blob| return Stage2Bootloader{
            .bin = blob,
            .elf = null,
        },

        else => blk: {
            var target = chip.cpu.target;
            target.abi = .eabi;

            const rom_path = mz.host_build.pathFromRoot(mz.host_build.fmt("{s}/src/bootroms/{s}.S", .{ build_root, @tagName(rom) }));

            const rom_exe = mz.host_build.addExecutable(.{
                .name = mz.host_build.fmt("stage2-{s}", .{@tagName(rom)}),
                .optimize = .ReleaseSmall,
                .target = mz.host_build.resolveTargetQuery(target),
                .root_source_file = null,
            });
            //rom_exe.linkage = .static;
            rom_exe.setLinkerScript(.{ .cwd_relative = build_root ++ "/src/bootroms/shared/stage2.ld" });
            rom_exe.addAssemblyFile(.{ .cwd_relative = rom_path });
            rom_exe.entry = .{ .symbol_name = "_stage2_boot" };

            break :blk rom_exe;
        },
    };

    const rom_objcopy = mz.host_build.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = mz.host_build.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return Stage2Bootloader{
        .bin = rom_objcopy.getOutput(),
        .elf = rom_exe.getEmittedBin(),
    };
}
