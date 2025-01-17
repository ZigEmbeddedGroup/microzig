const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    rp2040: *const microzig.Target,
    rp2350_arm: *const microzig.Target,
    rp2350_riscv: *const microzig.Target,
},

boards: struct {
    raspberrypi: struct {
        pico: *const microzig.Target,
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

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
    };

    const chip_rp2040: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2040 },
        .chip = .{
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
            .patches = @import("patches/rp2040.zig").patches,
        },
        .hal = hal,
        .linker_script = b.path("rp2040.ld"),
    };

    const chip_rp2350_arm: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2350_ARM_S },
        .chip = .{
            .name = "RP2350",
            .cpu = std.Target.Query{
                .cpu_arch = .thumb,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .register_definition = .{ .svd = b.path("src/chips/rp2350.svd") },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x10000000, .length = 2048 * 1024 },
                .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
            },
        },
        .hal = hal,
        .linker_script = b.path("rp2350_arm.ld"),
    };

    const chip_rp2350_riscv: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .uf2 = .RP2350_RISC_V },
        .chip = .{
            .name = "RP2350",
            .cpu = std.Target.Query{
                .cpu_arch = .riscv32,
                .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
                // the commented ones are in the datasheet but for some reason they break the code
                .cpu_features_add = std.Target.riscv.featureSet(&.{
                    // std.Target.riscv.Feature.c,
                    std.Target.riscv.Feature.a,
                    std.Target.riscv.Feature.m,
                    std.Target.riscv.Feature.zba,
                    std.Target.riscv.Feature.zbb,
                    std.Target.riscv.Feature.zbs,
                    // std.Target.riscv.Feature.zcb,
                    // std.Target.riscv.Feature.zcmp,
                    std.Target.riscv.Feature.zbkb,
                    std.Target.riscv.Feature.zifencei,
                }),
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .cpu_module_file = b.path("src/cpus/hazard3.zig"),
            .register_definition = .{ .svd = b.path("src/chips/rp2350.svd") },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
                .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
                .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
            },
            .patches = &.{
                .{
                    .override_arch = .{
                        .device_name = "RP2350",
                        .arch = .hazard3,
                    },
                },
            },
        },
        .hal = hal,
        .linker_script = b.path("rp2350_riscv.ld"),
    };

    const bootrom_rp2040 = get_bootrom(b, chip_rp2040.chip, .w25q080);
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
            .raspberrypi = .{
                .pico = chip_rp2040.derive(.{
                    .board = .{
                        .name = "RaspberryPi Pico",
                        .url = "https://www.raspberrypi.com/products/raspberry-pi-pico/",
                        .root_source_file = b.path("src/boards/raspberry_pi_pico.zig"),
                        .imports = rp2040_bootrom_imports,
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

fn get_bootrom(b: *std.Build, chip: microzig.Chip, rom: BootROM) std.Build.LazyPath {
    var target = chip.cpu;
    target.abi = .eabi;

    const rom_exe = b.addExecutable(.{
        .name = b.fmt("stage2-{s}", .{@tagName(rom)}),
        .optimize = .ReleaseSmall,
        .target = b.resolveTargetQuery(target),
        .root_source_file = null,
    });

    //rom_exe.linkage = .static;
    rom_exe.build_id = .none;
    rom_exe.setLinkerScript(b.path(b.fmt("src/bootroms/{s}/shared/stage2.ld", .{chip.name})));
    rom_exe.addAssemblyFile(b.path(b.fmt("src/bootroms/{s}/{s}.S", .{ chip.name, @tagName(rom) })));
    rom_exe.entry = .{ .symbol_name = "_stage2_boot" };

    const rom_objcopy = b.addObjCopy(rom_exe.getEmittedBin(), .{
        .basename = b.fmt("{s}.bin", .{@tagName(rom)}),
        .format = .bin,
    });

    return rom_objcopy.getOutput();
}
