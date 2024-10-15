const std = @import("std");
const Build = std.Build;
const internals = @import("microzig/build-internals");
const ModuleDeclaration = internals.ModuleDeclaration;
const regz = @import("microzig/regz");

pub fn build(b: *Build) !void {
    const rp2040_bootrom = get_bootrom(b);

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

    const rp2040_target = .{
        .cpu = .cortex_m0plus,
        .linker_script = b.path("rp2040.ld"),
        .chip = rp2040_chip,
        .hal = rp2040_hal,
    };

    const pico_target = .{
        .cpu = .cortex_m0plus,
        .linker_script = b.path("rp2040.ld"),
        .chip = rp2040_chip,
        .hal = rp2040_hal,
        .board = ModuleDeclaration.init(b, .{
            .root_source_file = b.path("src/boards/raspberry_pi_pico.zig"),
            .imports = &.{
                .{ .name = "bootloader", .module = b.createModule(.{ .root_source_file = rp2040_bootrom }) },
            },
        }),
    };

    internals.submit_target("rp2040", rp2040_target);
    internals.submit_target("pico", pico_target);
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
