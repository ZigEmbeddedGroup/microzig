const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .ch32h = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .small });

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const fw = mb.ports.ch32h.addDualCoreFirmware(mb, .{
        .name = "dual_blinky",
        .v3f_root_source_file = b.path("src/v3f.zig"),
        .v5f_root_source_file = b.path("src/v5f.zig"),
        .optimize = optimize,
    });

    mb.ports.ch32h.installFirmware(mb, fw);
}
