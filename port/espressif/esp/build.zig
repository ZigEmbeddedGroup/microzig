const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

chips: struct {
    esp32_c3: *const microzig.Target,
},

boards: struct {},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;

    const hal: microzig.HardwareAbstractionLayer = .{
        .root_source_file = b.path("src/hals/ESP32_C3.zig"),
    };
    const chip_esp32c3: microzig.Target = .{
        .dep = dep,
        // TODO: Exchange FLAT format with .esp format
        .preferred_binary_format = .bin,
        .chip = .{
            .name = "ESP32-C3",
            .url = "https://www.espressif.com/en/products/socs/esp32-c3",
            .cpu = std.Target.Query{
                // .name = "Espressif RISC-V",
                // .root_source_file = b.path("/src/cpus/espressif-riscv.zig"),
                .cpu_arch = .riscv32,
                .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
                .cpu_features_add = std.Target.riscv.featureSet(&.{
                    std.Target.riscv.Feature.c,
                    std.Target.riscv.Feature.m,
                }),
                .os_tag = .freestanding,
                .abi = .eabi,
            },
            .cpu_module_file = b.path("src/cpus/espressif-riscv.zig"),
            .register_definition = .{ .svd = b.path("src/chips/ESP32-C3.svd") },
            .memory_regions = &.{
                // external memory, ibus
                .{ .kind = .flash, .offset = 0x4200_0000, .length = 0x0080_0000 },
                // sram 1, data bus
                .{ .kind = .ram, .offset = 0x3FC8_0000, .length = 0x0006_0000 },
            },
        },
        .hal = hal,
    };

    return .{
        .chips = .{
            .esp32_c3 = chip_esp32c3.derive(.{}),
        },
        .boards = .{},
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
