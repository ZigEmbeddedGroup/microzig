const std = @import("std");
const microzig = @import("microzig");

const Self = @This();

chips: struct {
    atsamd51j19: *const microzig.Target,
},

boards: struct {},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const chip_atsamd51j19: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .chip = .{
            .name = "ATSAMD51J19A",
            .url = "https://www.microchip.com/en-us/product/ATSAMD51J19A",
            .cpu = .{
                .cpu_arch = .thumb,
                .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
                .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
                .os_tag = .freestanding,
                .abi = .eabihf,
            },
            .register_definition = .{
                .atdf = b.path("src/chips/ATSAMD51J19A.atdf"),
            },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x00000000, .length = 512 * 1024 }, // Embedded Flash
                .{ .kind = .ram, .offset = 0x20000000, .length = 192 * 1024 }, // Embedded SRAM
                .{ .kind = .ram, .offset = 0x47000000, .length = 8 * 1024 }, // Backup SRAM
                .{ .kind = .flash, .offset = 0x00804000, .length = 512 }, // NVM User Row
            },
        },
    };

    return .{
        .chips = .{
            .atsamd51j19 = chip_atsamd51j19.derive(.{}),
        },
        .boards = .{},
    };
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
