const std = @import("std");
const Build = std.Build;
const internals = @import("microzig/build-internals");
const TargetAlias = internals.TargetAlias;
const Chip = internals.Chip;
const ModuleDeclaration = internals.ModuleDeclaration;

pub const chips = struct {
    pub const rp2040 = &TargetAlias.init("rp2040");
};

pub const boards = struct {
    pub const pico = &TargetAlias.init("pico");
};

pub fn build(b: *Build) !void {
    const rp2040_bootrom = get_bootrom(b);

    const rp2040_chip: Chip = .{
        .b = b,
        .name = "RP2040",
        .cpu = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .register_definition = .{ .svd = b.path("src/chips/rp2040.svd") },
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
            .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
            .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
        },
    };

    const rp2040_hal = ModuleDeclaration.init(b, .{
        .root_source_file = b.path("src/hal.zig"),
    });

    internals.submit_target(chips.rp2040, .{
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .linker_script = b.path("rp2040.ld"),
        .preferred_binary_format = .{ .uf2 = .RP2040 },
    });
    internals.submit_target(boards.pico, .{
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .board = ModuleDeclaration.init(b, .{
            .root_source_file = b.path("src/boards/raspberry_pi_pico.zig"),
            .imports = &.{
                .{ .name = "bootloader", .module = b.createModule(.{ .root_source_file = rp2040_bootrom }) },
            },
        }),
        .linker_script = b.path("rp2040.ld"),
        .preferred_binary_format = .{ .uf2 = .RP2040 },
    });
}

// TODO: better bootrom system. maybe make bootrom a separate package so as to allow the user
// to use it in case he creates a custom board
fn get_bootrom(b: *Build) Build.LazyPath {
    const rom_exe = b.addExecutable(.{
        .name = "stage2-w25q080",
        .optimize = .ReleaseSmall,
        .target = b.resolveTargetQuery(std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        }),
        .root_source_file = null,
    });
    //rom_exe.linkage = .static;
    rom_exe.setLinkerScript(b.path("src/bootroms/RP2040/shared/stage2.ld"));
    rom_exe.addAssemblyFile(b.path("src/bootroms/RP2040/w25q080.S"));
    rom_exe.entry = .{ .symbol_name = "_stage2_boot" };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = "w25q080.bin",
        .format = .bin,
    });

    return rom_objcopy.getOutput();
}
