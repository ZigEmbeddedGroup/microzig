const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    atsamd51j19: *const microzig.Target,
},

boards: struct {},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const atpack_dep = b.dependency("atpack", .{});

    const chip_atsamd51j19: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
        .chip = .{
            .name = "ATSAMD51J19A",
            .url = "https://www.microchip.com/en-us/product/ATSAMD51J19A",
            .register_definition = .{
                .atdf = atpack_dep.path("samd51a/atdf/ATSAMD51J19A.atdf"),
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 512 * 1024, .access = .rx }, // Embedded Flash
                .{ .tag = .ram, .offset = 0x20000000, .length = 192 * 1024, .access = .rwx }, // Embedded SRAM
                .{ .tag = .ram, .offset = 0x47000000, .length = 8 * 1024, .access = .rwx }, // Backup SRAM
                .{ .name = "NVM_USER_ROW", .offset = 0x00804000, .length = 512, .access = .r }, // NVM User Row
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
