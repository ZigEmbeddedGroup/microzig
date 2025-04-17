const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    gd32vf103xb: *const microzig.Target,
    gd32vf103x8: *const microzig.Target,
},

boards: struct {
    sipeed: struct {
        longan_nano: *const microzig.Target,
    },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const hal_f103: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/GD32VF103/hal.zig"),
    };

    const sifive_e21_target: std.Target.Query = .{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
        .os_tag = .freestanding,
        .abi = .none,
    };

    const chip_gd32vf103xb: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = sifive_e21_target,
        .chip = .{
            .name = "GD32VF103",
            .register_definition = .{
                .svd = b.path("src/chips/GD32VF103.svd"),
            },
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 128 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 32 * 1024, .kind = .ram },
            },
        },
        .hal = hal_f103,
    };

    const chip_gd32vf103x8: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = sifive_e21_target,
        .chip = .{
            .name = "GD32VF103",
            .register_definition = .{
                .svd = b.path("src/chips/GD32VF103.svd"),
            },
            .memory_regions = &.{
                .{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
                .{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
            },
        },
        .hal = hal_f103,
    };

    return .{
        .chips = .{
            .gd32vf103xb = chip_gd32vf103xb.derive(.{}),
            .gd32vf103x8 = chip_gd32vf103x8.derive(.{}),
        },
        .boards = .{
            .sipeed = .{
                .longan_nano = chip_gd32vf103xb.derive(.{
                    .board = .{
                        .name = "Longan Nano",
                        .url = "https://longan.sipeed.com/en/",
                        .root_source_file = b.path("src/boards/longan_nano.zig"),
                    },
                }),
            },
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
