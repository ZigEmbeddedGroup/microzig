const std = @import("std");
const microzig = @import("zpm.zig").sdks.microzig;

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const esp32_c3_cpu = microzig.Cpu{
        .name = "Espressif RISC-V",
        .path = "src/package/espressif-riscv.zig",
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

    const esp32_c3 = microzig.Chip{
        .name = "ESP32 C3",
        .path = "src/package/esp32-c3.zig",
        .cpu = esp32_c3_cpu,
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x4200_0000, .length = 0x0080_0000 }, // external memory, ibus
            .{ .kind = .ram, .offset = 0x3FC8_0000, .length = 0x0006_0000 }, // sram 1, data bus
        },
    };

    var exe = microzig.addEmbeddedExecutable(
        b,
        "esp-bringup",
        "src/example/blinky.zig",
        .{ .chip = esp32_c3 },
        .{ .hal_package_path = .{ .path = "src/hal/root.zig" } },
    );
    exe.setBuildMode(mode);
    exe.install();

    const raw_step = exe.installRaw("firmware.bin", .{});

    b.getInstallStep().dependOn(&raw_step.step);
}
