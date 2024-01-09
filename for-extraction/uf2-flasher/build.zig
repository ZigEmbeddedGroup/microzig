const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const args_dep = b.dependency("args", .{});
    const args_mod = args_dep.module("args");

    const flash_tool = b.addExecutable(.{
        .name = "uf2-flash",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = optimize,
        .target = target,
    });
    flash_tool.addModule("args", args_mod);

    b.installArtifact(flash_tool);
}
