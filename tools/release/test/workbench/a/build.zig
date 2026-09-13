const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const b_dep = b.dependency("b", .{});
    const exe = b.addExecutable(.{
        .name = "a",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
        }),
    });
    exe.root_module.addImport("b", b_dep.module("b"));
    b.installArtifact(exe);
}
