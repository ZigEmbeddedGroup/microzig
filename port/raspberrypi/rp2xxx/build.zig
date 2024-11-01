const std = @import("std");
const Build = std.Build;
const internals = @import("microzig/build-internals");
const Chip = internals.Chip;
const Target = internals.Target;
const ModuleDeclaration = internals.ModuleDeclaration;

const Self = @This();

chips: struct {
    rp2040: Target,
},

boards: struct {
    pico: Target,
},

pub fn init(dep: *Build.Dependency) Self {
    const b = dep.builder;

    const rp2040_bootrom = get_bootrom(b);

    const rp2040_chip: Chip = .{
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

    const rp2040_target = .{
        .dep = dep,
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .linker_script = b.path("rp2040.ld"),
        .preferred_binary_format = .{ .uf2 = .RP2040 },
    };

    const pico_target = .{
        .dep = dep,
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
    };

    return .{
        .chips = .{
            .rp2040 = rp2040_target,
        },
        .boards = .{
            .pico = pico_target,
        },
    };
}

pub fn build(_: *Build) !void {

}

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
