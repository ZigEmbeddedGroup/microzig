const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("link", .{
        .root_source_file = b.path("link.zig"),
        .target = target,
        .optimize = optimize,
    });
}
