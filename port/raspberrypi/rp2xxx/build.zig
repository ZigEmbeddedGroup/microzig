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

    const rp2040_bootrom = get_bootrom(b, rp2040_chip, .w25q080);

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
    // TODO: construct all bootroms here and expose them via lazy paths: requires zig 0.14
}

const BootROM = union(enum) {
    at25sf128a,
    generic_03h,
    is25lp080,
    w25q080,
    w25x10cl,

    // Use the old stage2 bootloader vendored with MicroZig till 2023-09-13
    legacy,
};

fn get_bootrom(b: *Build, chip: Chip, rom: BootROM) Build.LazyPath {
    var target = chip.cpu;
    target.abi = .eabi;

    const rom_exe = b.addExecutable(.{
        .name = b.fmt("stage2-{s}", .{@tagName(rom)}),
        .optimize = .ReleaseSmall,
        .target = b.resolveTargetQuery(target),
        .root_source_file = null,
    });

    //rom_exe.linkage = .static;
    rom_exe.setLinkerScript(b.path(b.fmt("src/bootroms/{s}/shared/stage2.ld", .{chip.name})));
    rom_exe.addAssemblyFile(b.path(b.fmt("src/bootroms/{s}/{s}.S", .{ chip.name, @tagName(rom) })));
    rom_exe.entry = .{ .symbol_name = "_stage2_boot" };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = b.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return rom_objcopy.getOutput();
}
