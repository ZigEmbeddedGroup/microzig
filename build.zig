const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
        .abi = .gnueabi,
        .os_tag = .freestanding,
    };

    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("firmware", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.setLinkerScriptPath("src/linker.ld");
    exe.install();

    const convert_to_bin = b.addSystemCommand(&[_][]const u8{
        "arm-none-eabi-objcopy",
        "-I",
        "elf32-littlearm",
        "-O",
        "binary",
    });
    convert_to_bin.addArtifactArg(exe);
    convert_to_bin.addArg("zig-cache/bin/firmware.bin");
    b.getInstallStep().dependOn(&convert_to_bin.step);

    const copy_flash = b.addSystemCommand(&[_][]const u8{
        "doas",
        "mcopy",
        "-D",
        "o", // override the file without asking
        "zig-cache/bin/firmware.bin", // from firmware.bin
        "::firmware.bin", // to D:\firmware.bin
        "-i", // MUST BE LAST
        "/dev/sdb",
    });
    copy_flash.step.dependOn(&convert_to_bin.step);

    const flash_step = b.step("flash", "Copies the generated binary over to the lpc board");
    flash_step.dependOn(&copy_flash.step);
}
