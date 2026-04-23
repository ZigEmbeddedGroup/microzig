const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

const SoftDeviceProfile = struct {
    name: []const u8,
    flash_start: u64,
    ram_start: u64,
    hex_path: std.Build.LazyPath,
    /// Variant root file (e.g. "src/softdevice/s132.zig") — single source of
    /// truth for which SoftDevice variant a target uses.
    variant_root: std.Build.LazyPath,
};

dep: *std.Build.Dependency,

chips: struct {
    nrf51822: *const microzig.Target,
    nrf52832: *const microzig.Target,
    nrf52833: *const microzig.Target,
    nrf52840: *const microzig.Target,
},

boards: struct {
    nordic: struct {
        nrf52840_dongle: *const microzig.Target,
        nrf52840_mdk: *const microzig.Target,
        pca10040: *const microzig.Target,
    },
    bbc: struct {
        microbit_v1: *const microzig.Target,
        microbit_v2: *const microzig.Target,
    },
},

softdevice: struct {
    files: struct {
        s112: std.Build.LazyPath,
        s113: std.Build.LazyPath,
        s122: std.Build.LazyPath,
        s132: std.Build.LazyPath,
        s140: std.Build.LazyPath,
    },

    chips: struct {
        nrf52832_s132: *const microzig.Target,
        nrf52833_s140: *const microzig.Target,
        nrf52840_s140: *const microzig.Target,
    },

    boards: struct {
        nordic: struct {
            pca10040_s132: *const microzig.Target,
            nrf52840_dongle_s140: *const microzig.Target,
            nrf52840_mdk_s140: *const microzig.Target,
        },
        bbc: struct {
            microbit_v2_s140: *const microzig.Target,
        },
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const nrfx = b.dependency("nrfx", .{});
    const softdevice_dep = b.dependency("nrf5-sdk", .{});

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
    };

    const chip_nrf51822: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "nrf51",
            .url = "https://www.nordicsemi.com/products/nrf51822",
            .register_definition = .{
                .svd = nrfx.path("mdk/nrf51.svd"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 128 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 16 * 1024, .access = .rwx },
            },
            .patch_files = &.{
                b.path("patches/nrf51.zon"),
            },
        },
        .hal = hal,
    };

    const chip_nrf52832: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "nrf52",
            .url = "https://www.nordicsemi.com/products/nrf52832",
            .register_definition = .{
                .svd = nrfx.path("mdk/nrf52.svd"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 0x80000, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 0x10000, .access = .rwx },
            },
            .patch_files = &.{
                b.path("patches/nrf528xx.zon"),
            },
        },
        .hal = hal,
    };

    const chip_nrf52833: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "nrf52833",
            .url = "https://www.nordicsemi.com/products/nrf52833",
            .register_definition = .{
                .svd = nrfx.path("mdk/nrf52833.svd"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 512 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 128 * 1024, .access = .rwx },
            },
            .patch_files = &.{
                b.path("patches/nrf528xx.zon"),
            },
        },
        .hal = hal,
    };

    const chip_nrf52840: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "nrf52840",
            .url = "https://www.nordicsemi.com/products/nrf52840",
            .register_definition = .{
                .svd = nrfx.path("mdk/nrf52840.svd"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 0x100000, .access = .rx },
                // TODO: use code ram for `.ram_text`
                .{ .tag = .ram, .offset = 0x20000000, .length = 0x40000, .access = .rwx },

                // EXTFLASH
                .{ .tag = .flash, .offset = 0x12000000, .length = 0x8000000, .access = .rx },

                // CODE_RAM
                .{ .name = "code_ram", .offset = 0x800000, .length = 0x40000, .access = .x },
            },
            .patch_files = &.{
                b.path("patches/nrf528xx.zon"),
            },
        },
        .hal = hal,
    };

    const profile_s132: SoftDeviceProfile = .{
        .name = "s132-7.2.0",
        .flash_start = 0x00026000,
        .ram_start = 0x20002800,
        .hex_path = softdevice_dep.path("components/softdevice/s132/hex/s132_nrf52_7.2.0_softdevice.hex"),
        .variant_root = b.path("src/softdevice/s132.zig"),
    };

    const profile_s140: SoftDeviceProfile = .{
        .name = "s140-7.2.0",
        .flash_start = 0x00027000,
        .ram_start = 0x20002800,
        .hex_path = softdevice_dep.path("components/softdevice/s140/hex/s140_nrf52_7.2.0_softdevice.hex"),
        .variant_root = b.path("src/softdevice/s140.zig"),
    };

    const resolved_chip_nrf51822 = chip_nrf51822.derive(.{});
    const resolved_chip_nrf52832 = chip_nrf52832.derive(.{});
    const resolved_chip_nrf52833 = chip_nrf52833.derive(.{});
    const resolved_chip_nrf52840 = chip_nrf52840.derive(.{});

    const resolved_chip_nrf52832_s132 = derive_with_softdevice_memory(
        resolved_chip_nrf52832,
        dep,
        profile_s132,
    );

    const resolved_chip_nrf52833_s140 = derive_with_softdevice_memory(
        resolved_chip_nrf52833,
        dep,
        profile_s140,
    );

    const resolved_chip_nrf52840_s140 = derive_with_softdevice_memory(
        resolved_chip_nrf52840,
        dep,
        profile_s140,
    );

    return .{
        .dep = dep,
        .chips = .{
            .nrf51822 = resolved_chip_nrf51822,
            .nrf52832 = resolved_chip_nrf52832,
            .nrf52833 = resolved_chip_nrf52833,
            .nrf52840 = resolved_chip_nrf52840,
        },
        .boards = .{
            .nordic = .{
                .nrf52840_dongle = resolved_chip_nrf52840.derive(.{
                    .board = .{
                        .name = "nRF52840 Dongle",
                        .url = "https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle",
                        .root_source_file = b.path("src/boards/nrf52840-dongle.zig"),
                    },
                }),
                .nrf52840_mdk = resolved_chip_nrf52840.derive(.{
                    .board = .{
                        .name = "nRF52840 MDK USB Dongle",
                        .url = "https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle",
                        .root_source_file = b.path("src/boards/nrf52840-mdk.zig"),
                    },
                }),
                .pca10040 = resolved_chip_nrf52832.derive(.{
                    .board = .{
                        .name = "PCA10040",
                        .url = "https://www.nordicsemi.com/Products/Development-hardware/nRF52-DK",
                        .root_source_file = b.path("src/boards/pca10040.zig"),
                    },
                }),
            },
            .bbc = .{
                .microbit_v1 = resolved_chip_nrf51822.derive(.{
                    .preferred_binary_format = .hex,
                    .board = .{
                        .name = "micro:bit v1",
                        .url = "https://tech.microbit.org/hardware/1-5-revision",
                        .root_source_file = b.path("src/boards/microbit.zig"),
                    },
                }),
                .microbit_v2 = resolved_chip_nrf52833.derive(.{
                    .preferred_binary_format = .hex,
                    .board = .{
                        .name = "micro:bit v2",
                        .url = "https://tech.microbit.org/hardware/2-2-revision",
                        .root_source_file = b.path("src/boards/microbit.zig"),
                    },
                }),
            },
        },
        .softdevice = .{
            .files = .{
                .s112 = softdevice_dep.path("components/softdevice/s112/hex/s112_nrf52_7.2.0_softdevice.hex"),
                .s113 = softdevice_dep.path("components/softdevice/s113/hex/s113_nrf52_7.2.0_softdevice.hex"),
                .s122 = softdevice_dep.path("components/softdevice/s122/hex/s122_nrf52_8.0.0_softdevice.hex"),
                .s132 = softdevice_dep.path("components/softdevice/s132/hex/s132_nrf52_7.2.0_softdevice.hex"),
                .s140 = softdevice_dep.path("components/softdevice/s140/hex/s140_nrf52_7.2.0_softdevice.hex"),
            },
            .chips = .{
                .nrf52832_s132 = resolved_chip_nrf52832_s132,
                .nrf52833_s140 = resolved_chip_nrf52833_s140,
                .nrf52840_s140 = resolved_chip_nrf52840_s140,
            },
            .boards = .{
                .nordic = .{
                    .pca10040_s132 = resolved_chip_nrf52832_s132.derive(.{
                        .board = .{
                            .name = "PCA10040 (SoftDevice s132 7.2.0)",
                            .url = "https://www.nordicsemi.com/Products/Development-hardware/nRF52-DK",
                            .root_source_file = b.path("src/boards/pca10040.zig"),
                        },
                    }),
                    .nrf52840_dongle_s140 = resolved_chip_nrf52840_s140.derive(.{
                        .board = .{
                            .name = "nRF52840 Dongle (SoftDevice s140 7.2.0)",
                            .url = "https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle",
                            .root_source_file = b.path("src/boards/nrf52840-dongle.zig"),
                        },
                    }),
                    .nrf52840_mdk_s140 = resolved_chip_nrf52840_s140.derive(.{
                        .board = .{
                            .name = "nRF52840 MDK USB Dongle (SoftDevice s140 7.2.0)",
                            .url = "https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle",
                            .root_source_file = b.path("src/boards/nrf52840-mdk.zig"),
                        },
                    }),
                },
                .bbc = .{
                    .microbit_v2_s140 = resolved_chip_nrf52833_s140.derive(.{
                        .preferred_binary_format = .hex,
                        .board = .{
                            .name = "micro:bit v2 (SoftDevice s140 7.2.0)",
                            .url = "https://tech.microbit.org/hardware/2-2-revision",
                            .root_source_file = b.path("src/boards/microbit.zig"),
                        },
                    }),
                },
            },
        },
    };
}

pub fn merge_hex(self: *const Self, lower_hex: std.Build.LazyPath, upper_hex: std.Build.LazyPath, output_name: []const u8) std.Build.LazyPath {
    const run = self.dep.builder.addRunArtifact(self.dep.artifact("nrf5x-mergehex"));
    run.addFileArg(lower_hex);
    run.addFileArg(upper_hex);
    return run.addOutputFileArg(output_name);
}

fn derive_with_softdevice_memory(
    base: *const microzig.Target,
    dep: *std.Build.Dependency,
    profile: SoftDeviceProfile,
) *const microzig.Target {
    const b = dep.builder;
    const allocator = b.allocator;
    var filtered_regions = std.array_list.Managed(microzig.MemoryRegion).init(allocator);

    var found_flash = false;
    var found_ram = false;

    for (base.chip.memory_regions) |region| {
        if (region.tag == .flash) {
            if (found_flash) continue;
            var updated_region = region;
            const end = region.offset + region.length;
            if (profile.flash_start >= end) @panic("softdevice flash start is outside of flash memory");
            updated_region.length = end - profile.flash_start;
            updated_region.offset = profile.flash_start;
            filtered_regions.append(updated_region) catch @panic("OOM");
            found_flash = true;
            continue;
        }

        if (region.tag == .ram) {
            if (found_ram) continue;
            var updated_region = region;
            const end = region.offset + region.length;
            if (profile.ram_start >= end) @panic("softdevice ram start is outside of ram memory");
            updated_region.length = end - profile.ram_start;
            updated_region.offset = profile.ram_start;
            filtered_regions.append(updated_region) catch @panic("OOM");
            found_ram = true;
            continue;
        }

        filtered_regions.append(region) catch @panic("OOM");
    }

    if (!found_flash) @panic("target has no flash memory region");
    if (!found_ram) @panic("target has no ram memory region");

    const regions = filtered_regions.toOwnedSlice() catch @panic("OOM");

    const chip: microzig.Chip = .{
        .name = base.chip.name,
        .url = base.chip.url,
        .register_definition = base.chip.register_definition,
        .memory_regions = regions,
        .patch_files = base.chip.patch_files,
    };

    // Create a softdevice-aware HAL that re-exports the standard HAL plus
    // the variant-specific SoftDevice module (single source of truth).
    const sd_mod = b.createModule(.{
        .root_source_file = profile.variant_root,
    });

    const hal_sd: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal_softdevice.zig"),
        .imports = allocator.dupe(std.Build.Module.Import, &.{
            .{ .name = "softdevice", .module = sd_mod },
        }) catch @panic("OOM"),
    };

    return base.derive(.{ .chip = chip, .hal = hal_sd });
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/hal.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const unit_tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run platform agnostic unit tests");
    test_step.dependOn(&unit_tests_run.step);

    const mergehex_exe = b.addExecutable(.{
        .name = "nrf5x-mergehex",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/tools/mergehex.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
        }),
    });
    b.installArtifact(mergehex_exe);
}
