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

    const hal = microzig.HardwareAbstractionLayer{
        .root_source_file = dep.builder.path("src/hal.zig"),
    };

    ret.MSP430F5529 = b.allocator.create(microzig.Target) catch @panic("OOM");
    ret.MSP430F5529.* = .{
        .dep = dep,
        .preferred_binary_format = .elf,
        .zig_target = .{
            .cpu_arch = .msp430,
            .cpu_model = .{ .explicit = &std.Target.msp430.cpu.msp430x },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "MSP430F5529",
            .register_definition = .{
                .targetdb = .{
                    .path = targetdb,
                    .device = "MSP430F5529",
                },
            },
            .memory_regions = &.{
                .{ .tag = .flash, .offset = 0x4400, .length = 0xBB80, .access = .rx },
                .{ .tag = .flash, .offset = 0x10000, .length = 0x143F8, .access = .rx },
                .{ .tag = .ram, .offset = 0x2400, .length = 0x2000, .access = .rwx },
                .{ .name = "isr_vector", .tag = .none, .offset = 0xFF80, .length = 0x80, .access = .rx },
            },
            // Adding patches here breaks building sorcerer 🤡
            // .patch_files = &.{
            //     b.path("patches/msp430f5529.zon"),
            // },
        },
        .bundle_compiler_rt = false,
        .bundle_ubsan_rt = false,
        .hal = hal,
        .linker_script = .{
            .file = b.path("ld/MSP430.ld"),
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
            .abi = .eabi,
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
                .{ .name = "isr_vector", .tag = .none, .offset = 0xFFE0, .length = 0x20, .access = .rx },
            },
            // Adding patches here breaks building sorcerer 🤡
            // .patch_files = &.{
            //     b.path("patches/msp430g2553.zon"),
            // },
        },
        .bundle_compiler_rt = false,
        .bundle_ubsan_rt = false,
        .hal = hal,
        .linker_script = .{
            .file = b.path("ld/MSP430.ld"),
        },
    };

    return ret;
}
