const std = @import("std");
const internals = @import("microzig/build-internals");
const TargetAlias = internals.TargetAlias;
const Chip = internals.Chip;
const ModuleDeclaration = internals.ModuleDeclaration;
const regz = @import("microzig/tools/regz");

pub const chips = struct {
    pub const lpc176x5x = &TargetAlias.init("lpc176x5x");
};

pub const boards = struct {
    pub const mbed = &TargetAlias.init("mbed");
};

pub fn build(b: *std.Build) void {
    const lpc176x5x_chip = .{
        .b = b,
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

    internals.submit_target(chips.lpc176x5x, .{
        .chip = lpc176x5x_chip,
        .hal = lpc176x5x_hal,
        .preferred_binary_format = .elf,
        .patch_elf = .{
            .b = b,
            .func = patch_elf,
        },
    });
    internals.submit_target(boards.mbed, .{
        .chip = lpc176x5x_chip,
        .hal = lpc176x5x_hal,
        .board = ModuleDeclaration.init(b, .{
            .root_source_file = b.path("src/boards/mbed_LPC1768.zig"),
        }),
        .patch_elf = .{
            .b = b,
            .func = patch_elf,
        },
    });
}

/// Patch an ELF file to add a checksum over the first 8 words so the
/// cpu will properly boot.
fn patch_elf(b: *std.Build, input: std.Build.LazyPath) std.Build.LazyPath {
    const patchelf = b.addExecutable(.{
        .name = "lpc176x5x-patchelf",
        .root_source_file = b.path("src/tools/patchelf.zig"),
        .target = b.host,
    });

    const patch = b.addRunArtifact(patchelf);
    patch.addFileArg(input);
    return patch.addOutputFileArg("output.elf");
}
