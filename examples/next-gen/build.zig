const std = @import("std");
const MicroZig = @import("microzig");

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.createBuildEnvironment(b, .{
        .self = "microzig", // package name of the build package (optional)
        .core = "microzig-core", // package name of the core package (optional)
    });

    const optimize = b.standardOptimizeOption(.{});
    const target_name = b.option([]const u8, "target", "Select the target to build for.") orelse "board:mbed/lpc1768";

    for (microzig.targets.keys()) |listed_target_name| {
        std.debug.print("- '{s}'\n", .{listed_target_name});
    }

    const target = microzig.findTarget(target_name).?;

    const firmware = microzig.addFirmware(b, .{
        .name = "blinky",
        .target = target,
        .optimize = optimize,
        .source_file = .{ .path = "src/empty.zig" },
    });

    microzig.installFirmware(b, firmware, .{});
}
