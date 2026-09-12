const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .ch32h = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .small });

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const v3f = mb.add_firmware(.{
        .name = "v3f",
        .root_source_file = b.path("src/v3f.zig"),
        .optimize = optimize,
        .target = mb.ports.ch32h.chips.ch32h417_v3f,
    });

    const v5f = mb.add_firmware(.{
        .name = "v5f",
        .root_source_file = b.path("src/v5f.zig"),
        .optimize = optimize,
        .target = mb.ports.ch32h.chips.ch32h417_v5f,
    });

    const merged_bin = mb.ports.ch32h.merge(mz_dep, v3f.get_emitted_elf(), v5f.get_emitted_elf(), "merged.bin");

    const install = b.addInstallFileWithDir(merged_bin, .{ .custom = "firmware" }, "merged.bin");
    b.getInstallStep().dependOn(&install.step);
}
