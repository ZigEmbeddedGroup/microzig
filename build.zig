const std = @import("std");

pub fn build(b: *std.Build) void {
    buildTools(b);
}

fn buildTools(b: *std.Build) void {
    const tools_step = b.step("tools", "Only build the development tools");
    b.getInstallStep().dependOn(tools_step);

    const archive_info = b.addExecutable(.{
        .name = "archive-info",
        .optimize = .ReleaseSafe,
        .root_source_file = .{ .path = "tools/archive-info.zig" },
    });

    tools_step.dependOn(&b.addInstallArtifact(archive_info, .{
        .dest_dir = .{ .override = .{ .custom = "tools" } },
    }).step);
}
