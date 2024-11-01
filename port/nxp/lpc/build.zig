const std = @import("std");
const Build = std.Build;
const internals = @import("microzig/build-internals");
const Chip = internals.Chip;
const Target = internals.Target;
const ModuleDeclaration = internals.ModuleDeclaration;

const Self = @This();

chips: struct {
    lpc176x5x: Target,
},

boards: struct {
    mbed: Target,
},

pub fn init(dep: *Build.Dependency) Self {
    const b = dep.builder;

    const lpc176x5x_chip: Chip = .{
        .name = "LPC176x5x",
        .cpu = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .register_definition = .{ .json = b.path("src/chips/LPC176x5x.json") },
        .memory_regions = &.{
            .{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
            .{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
            .{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
        },
    };

    const lpc176x5x_hal = ModuleDeclaration.init(b, .{
        .root_source_file = b.path("src/hals/LPC176x5x.zig"),
    });

    const lpc176x5x_target: Target = .{
        .dep = dep,
        .chip = lpc176x5x_chip,
        .hal = lpc176x5x_hal,
        .preferred_binary_format = .elf,
        .patch_elf = lpc176x5x_patch_elf,
    };

    const mbed_target: Target = .{
        .dep = dep,
        .chip = lpc176x5x_chip,
        .hal = lpc176x5x_hal,
        .board = ModuleDeclaration.init(b, .{
            .root_source_file = b.path("src/boards/mbed_LPC1768.zig"),
        }),
        .patch_elf = lpc176x5x_patch_elf,
    };

    return .{
        .chips = .{
            .lpc176x5x = lpc176x5x_target,
        },
        .boards = .{
            .mbed = mbed_target,
        },
    };
}

pub fn build(b: *Build) void {
    const lpc176x5x_patch_elf_exe = b.addExecutable(.{
        .name = "lpc176x5x-patchelf",
        .root_source_file = b.path("src/tools/patchelf.zig"),
        .target = b.host,
    });
    b.installArtifact(lpc176x5x_patch_elf_exe);
}

/// Patch an ELF file to add a checksum over the first 8 words so the
/// cpu will properly boot.
fn lpc176x5x_patch_elf(dep: *Build.Dependency, input: std.Build.LazyPath) std.Build.LazyPath {
    const patch_elf_exe = dep.artifact("lpc176x5x-patchelf");
    const run = dep.builder.addRunArtifact(patch_elf_exe);
    run.addFileArg(input);
    return run.addOutputFileArg("output.elf");
}
