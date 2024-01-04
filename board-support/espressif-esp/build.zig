const std = @import("std");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const esp_riscv = .{
    .name = "Espressif RISC-V",
    .source_file = path("/src/cpus/espressif-riscv.zig"),
    .target = std.zig.CrossTarget{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            std.Target.riscv.Feature.c,
            std.Target.riscv.Feature.m,
        }),
        .os_tag = .freestanding,
        .abi = .eabi,
    },
};

const hal = .{
    .source_file = path("/src/hals/ESP32_C3.zig"),
};

pub const chips = struct {
    pub const esp32_c3 = .{
        .preferred_format = .bin, // TODO: Exchange FLAT format with .esp format
        .chip = .{
            .name = "ESP32-C3",
            .url = "https://www.espressif.com/en/products/socs/esp32-c3",

            .cpu = .{ .custom = &esp_riscv },

            .register_definition = .{
                .svd = path("/src/chips/ESP32-C3.svd"),
            },

            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x4200_0000, .length = 0x0080_0000 }, // external memory, ibus
                .{ .kind = .ram, .offset = 0x3FC8_0000, .length = 0x0006_0000 }, // sram 1, data bus
            },
        },
        .hal = hal,
    };
};

pub fn build(b: *std.Build) void {
    _ = b;
    // const optimize = b.standardOptimizeOption(.{});

    // var exe = microzig.addEmbeddedExecutable(b, .{
    //     .name = "esp-bringup",
    //     .source_file = .{
    //         .path = "src/example/blinky.zig",
    //     },
    //     .backing = .{ .chip = chips.esp32_c3 },
    //     .optimize = optimize,
    // });

    // const fw_objcopy = b.addObjCopy(exe.inner.getEmittedBin(), .{
    //     .format = .bin,
    // });

    // const fw_bin = fw_objcopy.getOutput();

    // const install_fw_bin = b.addInstallFile(fw_bin, "firmware/blinky.bin");

    // b.getInstallStep().dependOn(&install_fw_bin.step);

    // b.installArtifact(exe.inner);
}
