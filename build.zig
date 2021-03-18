const std = @import("std");
const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();

    const target = std.zig.CrossTarget{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
        .os_tag = .freestanding,
        .abi = .none,
    };

    const exe = b.addExecutable("firmware.elf", "src/main.zig");
    exe.setTarget(target);

    exe.setBuildMode(std.builtin.Mode.ReleaseFast);
    //exe.setBuildMode(std.builtin.Mode.Debug);

    exe.setLinkerScriptPath("rk2040.ld");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
