const std = @import("std");
const Build = std.Build;
const internals = @import("microzig/build-internals");
const TargetAlias = internals.TargetAlias;
const ModuleDeclaration = internals.ModuleDeclaration;
const regz = @import("microzig/regz");

pub const chips = struct {
    pub const rp2040 = &TargetAlias.init("rp2040");
};

pub const boards = struct {
    pub const pico = &TargetAlias.init("pico");
};

pub fn build(b: *Build) !void {
    const rp2040_bootrom = get_bootrom(b);

    const rp2040_cpu = std.Target.Query{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const regz_dep = b.dependency("microzig/regz", .{});
    const rp2040_chip_source = regz.generate(regz_dep, b.path("src/chips/rp2040.svd"), .svd);

    const rp2040_chip = .{
        .name = "RP2040",
        .module = ModuleDeclaration.init(b, .{
            .root_source_file = rp2040_chip_source,
        }),
    };

    const rp2040_hal = ModuleDeclaration.init(b, .{
        .root_source_file = b.path("src/hal.zig"),
    });

    internals.submit_target(chips.rp2040, .{
        .cpu = rp2040_cpu,
        .linker_script = b.path("rp2040.ld"),
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .preferred_binary_format = .{ .uf2 = .RP2040 },
    });
    internals.submit_target(boards.pico, .{
        .cpu = rp2040_cpu,
        .linker_script = b.path("rp2040.ld"),
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .board = ModuleDeclaration.init(b, .{
            .root_source_file = b.path("src/boards/raspberry_pi_pico.zig"),
            .imports = &.{
                .{ .name = "bootloader", .module = b.createModule(.{ .root_source_file = rp2040_bootrom }) },
            },
        }),
        .preferred_binary_format = .{ .uf2 = .RP2040 },
    });
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
