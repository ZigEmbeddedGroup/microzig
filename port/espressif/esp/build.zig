const std = @import("std");
const Import = std.Build.Module.Import;
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    esp32_c3: *const microzig.Target,
    esp32_c3_direct_boot: *const microzig.Target,
    esp32_c3_flashless: *const microzig.Target,
},

boards: struct {},

const esp32_c3_zig_target: std.Target.Query = .{
    .cpu_arch = .riscv32,
    .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
    .cpu_features_add = std.Target.riscv.featureSet(&.{
        .c,
        .m,
    }),
    .os_tag = .freestanding,
    .abi = .eabi,
};

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const riscv32_common_dep = b.dependency("microzig/modules/riscv32-common", .{});
    const riscv32_common_mod = riscv32_common_dep.module("riscv32-common");

    const chip_esp32_c3: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .esp = .{
            .chip_id = .esp32_c3,
            .flash_mode = .dio,
            .flash_size = .@"4mb",
            .flash_freq = .@"40m",
        } },
        .zig_target = esp32_c3_zig_target,
        .cpu = .{
            .name = "esp_riscv",
            .root_source_file = b.path("src/cpus/esp_riscv.zig"),
            .imports = b.allocator.dupe(Import, &.{
                .{
                    .name = "cpu-config",
                    .module = get_cpu_config(b, .image),
                },
                .{
                    .name = "riscv32-common",
                    .module = riscv32_common_mod,
                },
            }) catch @panic("OOM"),
        },
        .chip = .{
            .name = "ESP32-C3",
            .url = "https://www.espressif.com/en/products/socs/esp32-c3",
            .register_definition = .{ .svd = b.path("src/chips/ESP32-C3.svd") },
            .memory_regions = &.{
                .{ .name = "IROM", .offset = 0x4200_0000, .length = 0x0080_0000, .access = .rx },
                .{ .name = "DROM", .offset = 0x3C00_0000, .length = 0x0080_0000, .access = .r },
                .{ .name = "IRAM", .offset = 0x4037C000 + 0x4000, .length = 313 * 1024, .access = .x },
                // tag for stack
                .{ .name = "DRAM", .tag = .ram, .offset = 0x3FC7C000 + 0x4000, .length = 313 * 1024, .access = .rw },
            },
        },
        .hal = .{
            .root_source_file = b.path("src/hal.zig"),
            .imports = b.allocator.dupe(Import, &.{
                .{
                    .name = "esp-wifi-driver",
                    .module = dep.module("esp-wifi-driver"),
                },
            }) catch @panic("OOM"),
        },
        .linker_script = .{
            .generate = .memory_regions,
            .file = generate_linker_script(
                dep,
                "final.ld",
                b.path("ld/esp32_c3/image_boot_sections.ld"),
                b.path("ld/esp32_c3/rom_functions.ld"),
            ),
        },
    };

    return .{
        .chips = .{
            .esp32_c3 = chip_esp32_c3.derive(.{}),
            .esp32_c3_direct_boot = chip_esp32_c3.derive(.{
                .preferred_binary_format = .bin,
                .cpu = .{
                    .name = "esp_riscv",
                    .root_source_file = b.path("src/cpus/esp_riscv.zig"),
                    .imports = b.allocator.dupe(Import, &.{
                        .{
                            .name = "cpu-config",
                            .module = get_cpu_config(b, .direct),
                        },
                        .{
                            .name = "riscv32-common",
                            .module = riscv32_common_mod,
                        },
                    }) catch @panic("OOM"),
                },
                .linker_script = .{
                    .generate = .memory_regions,
                    .file = generate_linker_script(
                        dep,
                        "final.ld",
                        b.path("ld/esp32_c3/direct_boot_sections.ld"),
                        b.path("ld/esp32_c3/rom_functions.ld"),
                    ),
                },
            }),
            .esp32_c3_flashless = chip_esp32_c3.derive(.{
                .ram_image = true,
                .linker_script = .{
                    .generate = .memory_regions,
                    .file = generate_linker_script(
                        dep,
                        "final.ld",
                        b.path("ld/esp32_c3/flashless_sections.ld"),
                        b.path("ld/esp32_c3/rom_functions.ld"),
                    ),
                },
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

    const cat_exe = b.addExecutable(.{
        .name = "cat",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/tools/cat.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
        }),
    });
    b.installArtifact(cat_exe);

    const esp32_c3_resolved_zig_target = b.resolveTargetQuery(esp32_c3_zig_target);

    const esp_wifi_sys_dep = b.dependency("esp-wifi-sys", .{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = esp_wifi_sys_dep.path("esp-wifi-sys/include/include.h"),
        .target = esp32_c3_resolved_zig_target,
        .optimize = .Debug,
        .link_libc = false,
    });

    translate_c.addIncludePath(b.path("src/hal/radio/libc_dummy_include"));
    translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/include"));
    translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/headers"));

    // esp32_c3 specific
    translate_c.addIncludePath(esp_wifi_sys_dep.path("esp-wifi-sys/headers/esp32c3"));

    const mod = translate_c.addModule("esp-wifi-driver");
    mod.addLibraryPath(esp_wifi_sys_dep.path("esp-wifi-sys/libs/esp32c3"));
    inline for (&.{
        "btbb",
        "btdm_app",
        "coexist",
        "core",
        "espnow",
        "mesh",
        "net80211",
        "phy",
        "pp",
        "smartconfig",
        "wapi",
        "wpa_supplicant",
    }) |library| {
        mod.linkSystemLibrary(library, .{});
    }

    mod.linkSystemLibrary("printf", .{
        .weak = true,
    });
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

fn generate_linker_script(
    dep: *std.Build.Dependency,
    output_name: []const u8,
    base_path: std.Build.LazyPath,
    rom_functions_path: std.Build.LazyPath,
) std.Build.LazyPath {
    const b = dep.builder;
    const cat_exe = dep.artifact("cat");

    const run = b.addRunArtifact(cat_exe);
    run.addFileArg(base_path);
    run.addFileArg(rom_functions_path);
    return run.addOutputFileArg(output_name);
}
