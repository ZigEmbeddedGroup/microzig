const std = @import("std");
const microzig = @import("microzig-build");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

pub fn build(b: *std.Build) !void {
    //  Dummy func to make package manager happy
    _ = b;
}

pub const chips = struct {
    // Note: This chip has no flash support defined and requires additional configuration!
    pub const rp2040 = microzig.Target{
        .preferred_format = .{ .uf2 = .RP2040 },
        .chip = chip,
        .hal = hal,
        .board = null,
        .linker_script = linker_script,
    };
};

pub const boards = struct {
    pub const raspberry_pi = struct {
        pub const pico = microzig.Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "RaspberryPi Pico",
                .source_file = .{ .cwd_relative = build_root ++ "/src/boards/raspberry_pi_pico.zig" },
                .url = "https://www.raspberrypi.com/products/raspberry-pi-pico/",
            },
            .configure = rp2040_configure(.w25q080),
        };
    };

    pub const waveshare = struct {
        pub const rp2040_plus_4m = microzig.Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Plus (4M Flash)",
                .source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_plus_4m.zig" },
                .url = "https://www.waveshare.com/rp2040-plus.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_plus_16m = microzig.Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Plus (16M Flash)",
                .source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_plus_16m.zig" },
                .url = "https://www.waveshare.com/rp2040-plus.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_eth = microzig.Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-ETH Mini",
                .source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_eth.zig" },
                .url = "https://www.waveshare.com/rp2040-eth.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };

        pub const rp2040_matrix = microzig.Target{
            .preferred_format = .{ .uf2 = .RP2040 },
            .chip = chip,
            .hal = hal,
            .linker_script = linker_script,
            .board = .{
                .name = "Waveshare RP2040-Matrix",
                .source_file = .{ .cwd_relative = build_root ++ "/src/boards/waveshare_rp2040_matrix.zig" },
                .url = "https://www.waveshare.com/rp2040-matrix.htm",
            },
            .configure = rp2040_configure(.w25q080),
        };
    };
};

pub const BootROM = union(enum) {
    artifact: *std.build.CompileStep, // provide a custom startup code
    blob: std.build.LazyPath, // just include a binary blob

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
    .source_file = .{ .cwd_relative = build_root ++ "/rp2040.ld" },
};

const hal = .{
    .source_file = .{ .cwd_relative = build_root ++ "/src/hal.zig" },
};

const chip = .{
    .name = "RP2040",
    .url = "https://www.raspberrypi.com/products/rp2040/",
    .cpu = .cortex_m0plus,
    .register_definition = .{
        .json = .{ .cwd_relative = build_root ++ "/src/chips/RP2040.json" },
    },
    .memory_regions = &.{
        .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
        .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
        .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
    },
};

/// Returns a configuration function that will add the provided `BootROM` to the firmware.
pub fn rp2040_configure(comptime bootrom: BootROM) *const fn (host_build: *std.Build, *microzig.Firmware) void {
    const T = struct {
        fn configure(host_build: *std.Build, fw: *microzig.Firmware) void {
            const bootrom_file = getBootrom(host_build, bootrom);

            // HACK: Inject the file as a dependency to MicroZig.board
            fw.modules.board.?.dependencies.put(
                "bootloader",
                host_build.createModule(.{
                    .source_file = bootrom_file.bin,
                }),
            ) catch @panic("oom");
            bootrom_file.bin.addStepDependencies(&fw.artifact.step);
        }
    };

    return T.configure;
}

pub const Stage2Bootloader = struct {
    bin: std.Build.LazyPath,
    elf: ?std.Build.LazyPath,
};

pub fn getBootrom(b: *std.Build, rom: BootROM) Stage2Bootloader {
    const rom_exe = switch (rom) {
        .artifact => |artifact| artifact,
        .blob => |blob| return Stage2Bootloader{
            .bin = blob,
            .elf = null,
        },

        else => blk: {
            var target = @as(microzig.CpuModel, chip.cpu).getDescriptor().target;
            target.abi = .eabi;

            const rom_path = b.pathFromRoot(b.fmt("{s}/src/bootroms/{s}.S", .{ build_root, @tagName(rom) }));

            const rom_exe = b.addExecutable(.{
                .name = b.fmt("stage2-{s}", .{@tagName(rom)}),
                .optimize = .ReleaseSmall,
                .target = target,
                .root_source_file = null,
            });
            rom_exe.linkage = .static;
            // rom_exe.pie = false;
            // rom_exe.force_pic = false;
            rom_exe.setLinkerScript(.{ .path = build_root ++ "/src/bootroms/shared/stage2.ld" });
            rom_exe.addAssemblyFile(.{ .path = rom_path });

            break :blk rom_exe;
        },
    };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = b.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return Stage2Bootloader{
        .bin = rom_objcopy.getOutput(),
        .elf = rom_exe.getEmittedBin(),
    };
}

/////////////////////////////////////////
//      MicroZig Legacy Interface      //
/////////////////////////////////////////

// // this build script is mostly for testing and verification of this
// // package. In an attempt to modularize -- designing for a case where a
// // project requires multiple HALs, it accepts microzig as a param
// pub fn build(b: *Build) !void {
//     const optimize = b.standardOptimizeOption(.{});

//     const args_dep = b.dependency("args", .{});
//     const args_mod = args_dep.module("args");

//     var examples = Examples.init(b, optimize);
//     examples.install(b);

//     const pio_tests = b.addTest(.{
//         .root_source_file = .{
//             .path = "src/hal.zig",
//         },
//         .optimize = optimize,
//     });
//     pio_tests.addIncludePath(.{ .path = "src/hal/pio/assembler" });

//     const test_step = b.step("test", "run unit tests");
//     test_step.dependOn(&b.addRunArtifact(pio_tests).step);

//     {
//         const flash_tool = b.addExecutable(.{
//             .name = "rp2040-flash",
//             .optimize = .Debug,
//             .target = .{},
//             .root_source_file = .{ .path = "tools/rp2040-flash.zig" },
//         });
//         flash_tool.addModule("args", args_mod);

//         b.installArtifact(flash_tool);
//     }

//     // Install all bootroms for debugging and CI
//     inline for (comptime std.enums.values(std.meta.Tag(BootROM))) |rom| {
//         if (rom == .artifact or rom == .blob) {
//             continue;
//         }

//         if (rom == .is25lp080) {
//             // TODO: https://github.com/ZigEmbeddedGroup/raspberrypi-rp2040/issues/79
//             //  is25lp080.o:(text+0x16): has non-ABS relocation R_ARM_THM_CALL against symbol 'read_flash_sreg'
//             continue;
//         }

//         const files = getBootrom(b, rom);
//         if (files.elf) |elf| {
//             b.getInstallStep().dependOn(
//                 &b.addInstallFileWithDir(elf, .{ .custom = "stage2" }, b.fmt("{s}.elf", .{@tagName(rom)})).step,
//             );
//         }
//         b.getInstallStep().dependOn(
//             &b.addInstallFileWithDir(files.bin, .{ .custom = "stage2" }, b.fmt("{s}.bin", .{@tagName(rom)})).step,
//         );
//     }
// }
