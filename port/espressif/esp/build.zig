const std = @import("std");
const Import = std.Build.Module.Import;
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    esp32_c3: *const microzig.Target,
    esp32_c3_direct_boot: *const microzig.Target,
},

boards: struct {},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const riscv32_common_dep = b.dependency("microzig/modules/riscv32-common", .{});
    const riscv32_common_mod = riscv32_common_dep.module("riscv32-common");

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
    };

    const chip_esp32_c3: microzig.Target = .{
        .dep = dep,
        .entry = .{ .symbol_name = "_start" },
        .preferred_binary_format = .{ .esp = .{
            .chip_id = .esp32_c3,
            .flash_mode = .dio,
            .flash_size = .@"4mb",
            .flash_freq = .@"40m",
        } },
        .zig_target = .{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
            .cpu_features_add = std.Target.riscv.featureSet(&.{
                .c,
                .m,
            }),
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .cpu = .{
            .name = "esp_riscv",
            .root_source_file = b.path("src/cpus/esp_riscv.zig"),
            .imports = microzig.utils.dupe_imports(b, &.{
                .{
                    .name = "cpu-config",
                    .module = get_cpu_config(b, .image),
                },
                .{
                    .name = "riscv32-common",
                    .module = riscv32_common_mod,
                },
            }),
        },
        .chip = .{
            .name = "ESP32-C3",
            .url = "https://www.espressif.com/en/products/socs/esp32-c3",
            .register_definition = .{ .svd = b.path("src/chips/ESP32-C3.svd") },
            .memory_regions = &.{
                .{ .name = "IROM", .offset = 0x4200_0000 + 0x20, .length = 0x0080_0000 - 0x20, .access = .rx },
                .{ .name = "DROM", .offset = 0x3C00_0000 + 0x20, .length = 0x0080_0000 - 0x20, .access = .r },
                .{ .name = "IRAM", .offset = 0x4037C000 + 0x4000, .length = 313 * 1024, .access = .rx },
                 // tag for stack
                .{ .name = "DRAM", .tag = .ram, .offset = 0x3FC7C000 + 0x4000, .length = 313 * 1024, .access = .rw },
            },
        },
        .hal = hal,
        .linker_script = .{ .generate = .{
            .mode = .only_memory_regions,
            .files = microzig.utils.dupe_paths(b, &.{
                b.path("ld/esp32_c3/image_boot_sections.ld"),
                b.path("ld/esp32_c3/rom_functions.ld"),
            }),
        } },
    };

    return .{
        .chips = .{
            .esp32_c3 = chip_esp32_c3.derive(.{}),
            .esp32_c3_direct_boot = chip_esp32_c3.derive(.{
                .preferred_binary_format = .bin,
                .cpu = .{
                    .name = "esp_riscv",
                    .root_source_file = b.path("src/cpus/esp_riscv.zig"),
                    .imports = microzig.utils.dupe_imports(b, &.{
                        .{
                            .name = "cpu-config",
                            .module = get_cpu_config(b, .direct),
                        },
                        .{
                            .name = "riscv32-common",
                            .module = riscv32_common_mod,
                        },
                    }),
                },
                .chip = .{
                    .name = "ESP32-C3",
                    .url = "https://www.espressif.com/en/products/socs/esp32-c3",
                    .register_definition = .{ .svd = b.path("src/chips/ESP32-C3.svd") },
                    .memory_regions = &.{
                        // TODO: place rodata in DROM and `microzig_time_critical` in ram.
                        .{ .name = "IROM", .tag = .flash, .offset = 0x4200_0000, .length = 0x0080_0000, .access = .rx },
                        // .{ .name = "DROM", .offset = 0x3C00_0000, .length = 0x0080_0000, .flags = .r },
                        // .{ .name = "IRAM", .offset = 0x4037C000 + 0x4000, .length = 313 * 1024, .flags = .x },
                        .{ .name = "DRAM", .tag = .ram, .offset = 0x3FC7C000 + 0x4000, .length = 313 * 1024, .access = .rw },
                    },
                },
                .linker_script = .{ .generate = .{
                    .mode = .{ .memory_regions_and_sections = .{
                        .rodata_location = .ram,
                    } },
                    .files = microzig.utils.dupe_paths(b, &.{
                        b.path("ld/esp32_c3/rom_functions.ld"),
                    }),
                } },
            }),
        },
        .boards = .{},
    };
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/hal.zig"),
        .optimize = optimize,
    });

    const unit_tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run platform agnostic unit tests");
    test_step.dependOn(&unit_tests_run.step);
}

const BootMode = enum {
    direct,
    image,
};

fn get_cpu_config(b: *std.Build, boot_mode: BootMode) *std.Build.Module {
    const options = b.addOptions();
    options.addOption(BootMode, "boot_mode", boot_mode);
    return b.createModule(.{
        .root_source_file = options.getOutput(),
    });
}
