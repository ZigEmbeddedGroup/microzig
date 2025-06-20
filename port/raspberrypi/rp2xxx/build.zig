const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    rp2040: *const microzig.Target,
    rp2350_arm: *const microzig.Target,
    rp2350_riscv: *const microzig.Target,
},

boards: struct {
    adafruit: struct {
        metro_rp2350: *const microzig.Target,
    },
    raspberrypi: struct {
        pico: *const microzig.Target,
        pico_flashless: *const microzig.Target,
        pico2_arm: *const microzig.Target,
        pico2_riscv: *const microzig.Target,
    },
    waveshare: struct {
        rp2040_plus_4m: *const microzig.Target,
        rp2040_plus_16m: *const microzig.Target,
        rp2040_eth: *const microzig.Target,
        rp2040_matrix: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const riscv32_common_dep = b.dependency("microzig/modules/riscv32-common", .{});
    const pico_sdk = b.dependency("pico-sdk", .{});

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
    };

    const chip_rp2040: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2040 },
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "RP2040",
            .register_definition = .{ .svd = pico_sdk.path("src/rp2040/hardware_regs/RP2040.svd") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x10000000, .length = 2048 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 256 * 1024, .access = .rwx },
            },
            .patches = @import("patches/rp2040.zig").patches,
        },
        .hal = hal,
        .linker_script = .{
            .file = b.path("ld/rp2040/sections.ld"),
        },
    };

    const chip_rp2350_arm: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2350_ARM_S },
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "RP2350",
            .register_definition = .{ .svd = pico_sdk.path("src/rp2350/hardware_regs/RP2350.svd") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x10000000, .length = 2048 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 512 * 1024, .access = .rwx },
                // TODO: maybe these can be used for stacks
                .{ .tag = .ram, .offset = 0x20080000, .length = 4 * 1024, .access = .rwx },
                .{ .tag = .ram, .offset = 0x20081000, .length = 4 * 1024, .access = .rwx },
            },
            .patches = @import("patches/rp2350.zig").patches,
        },
        .hal = hal,
        .linker_script = .{
            .file = b.path("ld/rp2350/arm_sections.ld"),
        },
    };

    const chip_rp2350_riscv: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2350_RISC_V },
        .zig_target = .{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
            .cpu_features_add = std.Target.riscv.featureSet(&.{
                .a,
                .m,
                .c,
                .zba,
                .zbb,
                .zbs,
                .zcb,
                .zcmp,
                .zbkb,
                .zifencei,
            }),
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .cpu = .{
            .name = "hazard3",
            .root_source_file = b.path("src/cpus/hazard3.zig"),
            .imports = b.allocator.dupe(std.Build.Module.Import, &.{
                .{
                    .name = "riscv32-common",
                    .module = riscv32_common_dep.module("riscv32-common"),
                },
            }) catch @panic("OOM"),
        },
        .chip = .{
            .name = "RP2350",
            .register_definition = .{ .svd = pico_sdk.path("src/rp2350/hardware_regs/RP2350.svd") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x10000000, .length = 2048 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 512 * 1024, .access = .rwx },
                // TODO: maybe these can be used for stacks
                .{ .tag = .ram, .offset = 0x20080000, .length = 4 * 1024, .access = .rwx },
                .{ .tag = .ram, .offset = 0x20081000, .length = 4 * 1024, .access = .rwx },
            },
            .patches = @import("patches/rp2350.zig").patches ++ [_]microzig.Patch{
                .{
                    .override_arch = .{
                        .device_name = "RP2350",
                        .arch = .hazard3,
                    },
                },
            },
        },
        .hal = hal,
        .linker_script = .{
            .file = b.path("ld/rp2350/riscv_sections.ld"),
        },
    };

    const bootrom_rp2040 = get_bootrom(b, &chip_rp2040, .w25q080);
    const rp2040_bootrom_imports = b.allocator.dupe(std.Build.Module.Import, &.{
        .{ .name = "bootloader", .module = b.createModule(.{ .root_source_file = bootrom_rp2040 }) },
    }) catch @panic("out of memory");

    return .{
        .chips = .{
            .rp2040 = chip_rp2040.derive(.{}),
            .rp2350_arm = chip_rp2350_arm.derive(.{}),
            .rp2350_riscv = chip_rp2350_riscv.derive(.{}),
        },
        .boards = .{
            .adafruit = .{
                .metro_rp2350 = chip_rp2350_arm.derive(.{
                    .board = .{
                        .name = "Adafruit Metro RP2350",
                        .url = "https://www.adafruit.com/product/6267",
                        .root_source_file = b.path("src/boards/adafruit_metro_rp2350.zig"),
                    },
                }),
            },
            .raspberrypi = .{
                .pico = chip_rp2040.derive(.{
                    .board = .{
                        .name = "RaspberryPi Pico",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-pico/",
                        .root_source_file = b.path("src/boards/raspberry_pi_pico.zig"),
                        .imports = rp2040_bootrom_imports,
                    },
                }),
                .pico_flashless = chip_rp2040.derive(.{
                    .entry = .{ .symbol_name = "_entry_point" },
                    .linker_script = .{ .generate = .none, .file = b.path("ld/rp2040/ram_image_linker.ld") },
                    .ram_image = true,
                    .board = .{
                        .name = "RaspberryPi Pico (ram image)",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-pico/",
                        .root_source_file = b.path("src/boards/raspberry_pi_pico2.zig"),
                    },
                }),
                .pico2_arm = chip_rp2350_arm.derive(.{
                    .board = .{
                        .name = "RaspberryPi Pico 2",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-pico2/",
                        .root_source_file = b.path("src/boards/raspberry_pi_pico2.zig"),
                    },
                }),
                .pico2_riscv = chip_rp2350_riscv.derive(.{
                    .board = .{
                        .name = "RaspberryPi Pico 2",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-pico2/",
                        .root_source_file = b.path("src/boards/raspberry_pi_pico2.zig"),
                    },
                }),
            },
            .waveshare = .{
                .rp2040_plus_4m = chip_rp2040.derive(.{
                    .board = .{
                        .name = "Waveshare RP2040-Plus (4M Flash)",
                        .url = "https://www.waveshare.com/rp2040-plus.htm",
                        .root_source_file = b.path("src/boards/waveshare_rp2040_plus_4m.zig"),
                        .imports = rp2040_bootrom_imports,
                    },
                }),
                .rp2040_plus_16m = chip_rp2040.derive(.{
                    .board = .{
                        .name = "Waveshare RP2040-Plus (16M Flash)",
                        .url = "https://www.waveshare.com/rp2040-plus.htm",
                        .root_source_file = b.path("src/boards/waveshare_rp2040_plus_16m.zig"),
                        .imports = rp2040_bootrom_imports,
                    },
                }),
                .rp2040_eth = chip_rp2040.derive(.{
                    .board = .{
                        .name = "Waveshare RP2040-ETH Mini",
                        .url = "https://www.waveshare.com/rp2040-eth.htm",
                        .root_source_file = b.path("src/boards/waveshare_rp2040_eth.zig"),
                        .imports = rp2040_bootrom_imports,
                    },
                }),
                .rp2040_matrix = chip_rp2040.derive(.{
                    .board = .{
                        .name = "Waveshare RP2040-Matrix",
                        .url = "https://www.waveshare.com/rp2040-matrix.htm",
                        .root_source_file = b.path("src/boards/waveshare_rp2040_matrix.zig"),
                        .imports = rp2040_bootrom_imports,
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) !void {
    // TODO: construct all bootroms here and expose them via lazy paths: requires zig 0.14

    const optimize = b.standardOptimizeOption(.{});

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/hal.zig"),
        .optimize = optimize,
    });
    unit_tests.addIncludePath(b.path("src/hal/pio/assembler"));

    const unit_tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run platform agnostic unit tests");
    test_step.dependOn(&unit_tests_run.step);
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

fn get_bootrom(b: *std.Build, target: *const microzig.Target, rom: BootROM) std.Build.LazyPath {
    var zig_target = target.zig_target;
    zig_target.abi = .eabi;

    const rom_exe = b.addExecutable(.{
        .name = b.fmt("stage2-{s}", .{@tagName(rom)}),
        .optimize = .ReleaseSmall,
        .target = b.resolveTargetQuery(zig_target),
    });

    //rom_exe.linkage = .static;
    rom_exe.build_id = .none;
    rom_exe.setLinkerScript(b.path(b.fmt("src/bootroms/{s}/shared/stage2.ld", .{target.chip.name})));
    rom_exe.addAssemblyFile(b.path(b.fmt("src/bootroms/{s}/{s}.S", .{ target.chip.name, @tagName(rom) })));
    rom_exe.entry = .{ .symbol_name = "_stage2_boot" };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = b.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return rom_objcopy.getOutput();
}
