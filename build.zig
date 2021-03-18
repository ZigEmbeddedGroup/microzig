const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = std.zig.CrossTarget{
        .cpu_arch = .arm,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
        .abi = .gnueabihf,
        .os_tag = .freestanding,
    };

    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("firmware", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.setLinkerScriptPath("src/linker.ld");
    exe.install();

    const convert_to_hex = b.addSystemCommand(&[_][]const u8{
        "arm-none-eabi-objcopy",
        "-I",
        "elf32-littlearm",
        "-O",
        "ihex",
    });
    convert_to_hex.addArtifactArg(exe);
    convert_to_hex.addArg("zig-cache/bin/firmware.hex");

    b.getInstallStep().dependOn(&convert_to_hex.step);
}
