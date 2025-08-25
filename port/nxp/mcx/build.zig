const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    mcxa153: *const microzig.Target,
},

boards: struct {
    frdm_mcxa153: *const microzig.Target,
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const mcux_soc_svd = b.dependency("mcux-soc-svd", .{});

    const chip_mcxa153: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "MCXA153",
            .register_definition = .{ .svd = mcux_soc_svd.path("MCXA153/MCXA153.xml") },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x00000000, .length = 128 * 1024, .access = .rx },
                .{ .tag = .ram, .offset = 0x20000000, .length = 24 * 1024, .access = .rw },
            },
        },
        .hal = .{ .root_source_file = b.path("src/hal.zig") },
    };

    return .{
        .chips = .{
            .mcxa153 = chip_mcxa153.derive(.{}),
        },
        .boards = .{
            .frdm_mcxa153 = chip_mcxa153.derive(.{
                .board = .{
                    .name = "FRDM Development Board for MCX A153",
                    .url = "https://www.nxp.com/part/FRDM-MCXA153",
                    .root_source_file = b.path("src/boards/frdm_mcxa153.zig"),
                },
            }),
        },
    };
}

pub fn build(b: *std.Build) void {
    _ = b;
}
