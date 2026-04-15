const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

TM4C123GH6PM: *microzig.Target,

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;
    const ti_data = b.dependency("ti_data", .{});
    const targetdb = ti_data.path("targetdb");

    var ret: Self = undefined;

    ret.TM4C123GH6PM = b.allocator.create(microzig.Target) catch @panic("OOM");
    ret.TM4C123GH6PM.* = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
            .abi = .eabihf,
        },
        .chip = .{
            .name = "TM4C123GH6PM",
            .register_definition = .{
                .targetdb = .{
                    .path = targetdb,
                    .device = "tm4c123gh6pm",
                },
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x0000, .length = 0x4_0000, .access = .rx },
                .{ .tag = .ram, .offset = 0x2000_0000, .length = 0x2000_8000, .access = .rwx },
            },
        },
    };

    return ret;
}
