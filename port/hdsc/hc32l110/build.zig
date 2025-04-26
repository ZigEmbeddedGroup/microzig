const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    hc32l110x4: *const microzig.Target,
    hc32l110x6: *const microzig.Target,
},

boards: struct {
    // lilygo: struct {
    //     t_hc32: *const microzig.Target,
    // },
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hal.zig"),
    };

    const chip_hc32l110x4: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .bin = {} },
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "HDSC_HC32L110",
            .register_definition = .{ .svd = b.path("src/chips/HC32L110.svd") },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x00000000, .length = 16 * 1024 },
                .{ .kind = .ram, .offset = 0x20000000, .length = 2 * 1024 },
            },
            .patches = @import("patches/hc32l110.zig").patches,
        },
        .hal = hal,
    };

    const chip_hc32l110x6: microzig.Target = .{
        .dep = dep,
        .preferred_binary_format = .{ .bin = {} },
        .zig_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .chip = .{
            .name = "HDSC_HC32L110",
            .register_definition = .{ .svd = b.path("src/chips/HC32L110.svd") },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x00000000, .length = 32 * 1024 },
                .{ .kind = .ram, .offset = 0x20000000, .length = 4 * 1024 },
            },
            .patches = @import("patches/hc32l110.zig").patches,
        },
        .hal = hal,
    };

    return .{
        .chips = .{
            .hc32l110x4 = chip_hc32l110x4.derive(.{}),
            .hc32l110x6 = chip_hc32l110x6.derive(.{}),
        },
        .boards = .{},
    };
}

pub fn build(b: *std.Build) !void {
    const optimize = b.standardOptimizeOption(.{});

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/hal.zig"),
        .optimize = optimize,
    });

    const unit_tests_run = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run platform agnostic unit tests");
    test_step.dependOn(&unit_tests_run.step);
}
