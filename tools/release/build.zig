const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const flags_dep = b.dependency("flags", .{
        .target = target,
        .optimize = optimize,
    });

    const flags = flags_dep.module("flags");
    const exe = b.addExecutable(.{
        .name = "release",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "flags", .module = flags },
            },
        }),
    });
    b.installArtifact(exe);
}
