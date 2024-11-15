const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    nrf52840: *const microzig.Target,
    nrf52832: *const microzig.Target,
},

boards: struct {
    nordic: struct {
        nrf52840_dongle: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const chip_nrf52840: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .chip = .{
            .name = "nrf52840",
            .url = "https://www.nordicsemi.com/products/nrf52840",
            .cpu = .{
                .cpu_arch = .thumb,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .register_definition = .{
                .json = b.path("src/chips/nrf52840.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 0x100000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },

                // EXTFLASH
                .{ .offset = 0x12000000, .length = 0x8000000, .kind = .flash },

                // CODE_RAM
                .{ .offset = 0x800000, .length = 0x40000, .kind = .ram },
            },
        },
    };

    const chip_nrf52832: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .chip = .{
            .name = "nrf52",
            .url = "https://www.nordicsemi.com/products/nrf52832",
            .cpu = .{
                .cpu_arch = .thumb,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .register_definition = .{
                .json = b.path("src/chips/nrf52.json"),
            },
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 0x80000, .kind = .flash },
                .{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
            },
        },
    };

    return .{
        .chips = .{
            .nrf52840 = chip_nrf52840.derive(.{}),
            .nrf52832 = chip_nrf52832.derive(.{}),
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
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
