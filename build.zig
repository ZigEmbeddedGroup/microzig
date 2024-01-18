const std = @import("std");
// const examples = @import("examples/build.zig");

pub fn build(b: *std.Build) void {
    buildTools(b);

    // examples.build(b);
}

fn buildTools(b: *std.Build) void {
    const tools_step = b.step("tools", "Only build the development tools");
    b.getInstallStep().dependOn(tools_step);

    const eggzon_dep = b.dependency("eggzon", .{});
    const eggzon_mod = eggzon_dep.module("eggzon");

    const create_build_meta = b.addExecutable(.{
        .name = "create-pkg-descriptor",
        .root_source_file = .{ .path = "tools/create-pkg-descriptor.zig" },
        .optimize = .ReleaseSafe,
    });
    create_build_meta.addModule("eggzon", eggzon_mod);
    installTool(tools_step, create_build_meta);

    const archive_info = b.addExecutable(.{
        .name = "archive-info",
        .optimize = .ReleaseSafe,
        .root_source_file = .{ .path = "tools/archive-info.zig" },
    });
    installTool(tools_step, archive_info);
}

fn installTool(tools_step: *std.Build.Step, exe: *std.Build.Step.Compile) void {
    tools_step.dependOn(&tools_step.owner.addInstallArtifact(exe, .{
        .dest_dir = .{ .override = .{ .custom = "tools" } },
    }).step);
}
