const std = @import("std");
const MicroZig = @import("../build/build.zig"); // "microzig-build"

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.createBuildEnvironment(b, .{
        .self = "microzig", // package name of the build package (optional)
        .core = "microzig-core", // package name of the core package (optional)
        .board_support = &.{
            // package names for BSP packages:
            "microzig-bsp-nxp",
            "microzig-bsp-rp2040",
        },
    });

    const optimize = b.standardOptimizeOption(.{});
    const target_name = b.option([]const u8, "target", "Select the target to build for.") orelse "board:mbed/lpc1768";

    const target = microzig.findTarget(target_name).?;

    const firmware = microzig.addFirmware(b, .{
        .name = "blinky",
        .target = target,
        .optimize = optimize,
        .source_file = .{ .path = "src/empty.zig" },
    });

    microzig.installFirmware(b, firmware, .{});
}
