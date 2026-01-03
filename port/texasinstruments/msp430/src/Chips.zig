const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

MSP430F5529: *microzig.Target,
MSP430G2553: *microzig.Target,

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;
    const ti_data = b.dependency("ti_data", .{});
    const targetdb = ti_data.path("targetdb");

    var ret: Self = undefined;

    ret.MSP430F5529 = b.allocator.create(microzig.Target) catch @panic("OOM");
    ret.MSP430F5529.* = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .msp430,
            .cpu_model = .{ .explicit = &std.Target.msp430.cpu.msp430x },
            .os_tag = .freestanding,
            .abi = .none,
        },
        .chip = .{
            .name = "MSP430F5229",
            .register_definition = .{
                .targetdb = .{
                    .path = targetdb,
                    .device = "MSP430F5229",
                },
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x4400, .length = 0xBB80, .access = .rx },
                .{ .tag = .flash, .offset = 0x10000, .length = 0x143F8, .access = .rx },
                .{ .tag = .ram, .offset = 0x2400, .length = 0x2000, .access = .rwx },
            },
        },
    };

    ret.MSP430G2553 = b.allocator.create(microzig.Target) catch @panic("OOM");
    ret.MSP430G2553.* = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .msp430,
            .cpu_model = .{ .explicit = &std.Target.msp430.cpu.msp430 },
            .os_tag = .freestanding,
            .abi = .none,
        },
        .chip = .{
            .name = "MSP430G2553",
            .register_definition = .{
                .targetdb = .{
                    .path = targetdb,
                    .device = "MSP430G2553",
                },
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0xC000, .length = 0x3FDE, .access = .rx },
                .{ .tag = .ram, .offset = 0x200, .length = 0x200, .access = .rwx },
            },
        },
    };

    return ret;
}
