const std = @import("std");

pub fn build(b: *std.Build) void {
    const drivers_mod = b.addModule("drivers", .{
        .root_source_file = b.path("framework.zig"),
    });

    _ = drivers_mod;

    const test_suite = b.addTest(.{
        .root_source_file = b.path("framework.zig"),
        .target = b.host,
        .optimize = .Debug,
    });

    b.getInstallStep().dependOn(&b.addRunArtifact(test_suite).step);
}
