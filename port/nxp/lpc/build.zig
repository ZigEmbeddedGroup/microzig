const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    lpc176x5x: *const microzig.Target,
},

boards: struct {
    mbed: struct {
        lpc1768: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const chip_lpc176x5x: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "LPC176x5x",
            // Downloaded from http://ds.arm.com/media/resources/db/chip/nxp/lpc1768/LPC176x5x.svd
            .register_definition = .{ .svd = b.path("src/chips/LPC176x5x.svd") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 512 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x10000000, .length = 32 * 1024, .access = .rw },
                .{ .tag = .ram, .offset = 0x2007C000, .length = 32 * 1024, .access = .rw },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hals/LPC176x5x.zig"),
        },
        .patch_elf = lpc176x5x_patch_elf,
    };

    return .{
        .chips = .{
            .lpc176x5x = chip_lpc176x5x.derive(.{}),
        },
        .boards = .{
            .mbed = .{
                .lpc1768 = chip_lpc176x5x.derive(.{
                    .board = .{
                        .name = "mbed LPC1768",
                        .url = "https://os.mbed.com/platforms/mbed-LPC1768/",
                        .root_source_file = b.path("src/boards/mbed_LPC1768.zig"),
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const lpc176x5x_patch_elf_exe = b.addExecutable(.{
        .name = "lpc176x5x-patchelf",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/tools/patchelf.zig"),
            .optimize = optimize,
            .target = target,
        }),
    });
    b.installArtifact(lpc176x5x_patch_elf_exe);
}

/// Patch an ELF file to add a checksum over the first 8 words so the
/// cpu will properly boot.
fn lpc176x5x_patch_elf(dep: *std.Build.Dependency, input: std.Build.LazyPath) std.Build.LazyPath {
    const patch_elf_exe = dep.artifact("lpc176x5x-patchelf");
    const run = dep.builder.addRunArtifact(patch_elf_exe);
    run.addFileArg(input);
    return run.addOutputFileArg("output.elf");
}
