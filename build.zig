const std = @import("std");
const microzig = @import("microzig");

pub const chips = @import("src/chips.zig");
pub const cpus = @import("src/cpus.zig");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    var exe = microzig.addEmbeddedExecutable(b, .{
        .name = "esp-bringup",
        .source_file = .{
            .path = "src/example/blinky.zig",
        },
        .backing = .{ .chip = chips.esp32_c3 },
        .optimize = optimize,
    });

    const fw_objcopy = b.addObjCopy(exe.inner.getEmittedBin(), .{
        .format = .bin,
    });

    const fw_bin = fw_objcopy.getOutput();

    const install_fw_bin = b.addInstallFile(fw_bin, "firmware/blinky.bin");

    b.getInstallStep().dependOn(&install_fw_bin.step);

    b.installArtifact(exe.inner);
}
