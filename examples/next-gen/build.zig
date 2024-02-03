const std = @import("std");
const MicroZig = @import("microzig-build");

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.createBuildEnvironment(b, .{});

    const show_targets_step = b.step("show-targets", "Shows all available MicroZig targets");
    show_targets_step.dependOn(microzig.getShowTargetsStep());

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
