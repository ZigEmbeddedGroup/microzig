const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    nrf52832: *const microzig.Target,
    nrf52840: *const microzig.Target,
},

boards: struct {
    nordic: struct {
        nrf52840_dongle: *const microzig.Target,
        nrf52840_mdk: *const microzig.Target,
        pca10040: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const nrfx = b.dependency("nrfx", .{});

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
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
                // TODO: does this determine the name of the chips/x.zig?
                .svd = nrfx.path("mdk/nrf52.svd"),
            },
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 0x80000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            },
            .patches = @import("patches/nrf52832.zig").patches,
        },
        .hal = .{ .root_source_file = b.path("src/hal.zig") },
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
                .{ .offset = 0x00000000, .length = 0x100000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },

                // EXTFLASH
                .{ .offset = 0x12000000, .length = 0x8000000, .kind = .flash },

                // CODE_RAM
                .{ .offset = 0x800000, .length = 0x40000, .kind = .ram },
            },
            .patches = @import("patches/nrf52840.zig").patches,
        },
        .hal = hal,
    };

    return .{
        .chips = .{
            .nrf52832 = chip_nrf52832.derive(.{}),
            .nrf52840 = chip_nrf52840.derive(.{}),
        },
        .boards = .{
            .nordic = .{
                .nrf52840_dongle = chip_nrf52840.derive(.{
                    .board = .{
                        .name = "nRF52840 Dongle",
                        .url = "https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle",
                        .root_source_file = b.path("src/boards/nrf52840-dongle.zig"),
                    },
                }),
                .nrf52840_mdk = chip_nrf52840.derive(.{
                    .board = .{
                        .name = "nRF52840 MDK USB Dongle",
                        .url = "https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle",
                        .root_source_file = b.path("src/boards/nrf52840-mdk.zig"),
                    },
                }),
                .pca10040 = chip_nrf52832.derive(.{
                    .board = .{
                        .name = "PCA10040",
                        .url = "https://www.nordicsemi.com/Products/Development-hardware/nRF52-DK",
                        .root_source_file = b.path("src/boards/pca10040.zig"),
                    },
                }),
            },
        },
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
