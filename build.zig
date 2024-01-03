const std = @import("std");

/// Creates a new instance of the libc target.
pub fn createLibrary(b: *std.Build, target: std.zig.CrossTarget, optimize: std.builtin.OptimizeMode) *std.Build.Step.Compile {
    const libc = b.addStaticLibrary(.{
        .name = "foundation-libc",
        .target = target,
        .optimize = optimize,
        .root_source_file = .{ .path = "src/libc.zig" },
    });

    libc.addIncludePath(.{ .path = "include" });

    return libc;
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libc = createLibrary(b, target, optimize);
    b.installArtifact(libc);

    // Add all headers here:
    b.getInstallStep().dependOn(&b.addInstallHeaderFile("include/stdlib.h", "stdlib.h").step);
    b.getInstallStep().dependOn(&b.addInstallHeaderFile("include/string.h", "string.h").step);
}
