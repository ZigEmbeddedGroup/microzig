const std = @import("std");

const header_files = [_][]const u8{
    "ctype.h",
    "errno.h",
    "inttypes.h",
    "math.h",
    "setjmp.h",
    "stdlib.h",
    "stdnoreturn.h",
    "string.h",
    "tgmath.h",
    "uchar.h",
};

/// Creates a new instance of the libc target.
pub fn createLibrary(b: *std.Build, target: std.zig.CrossTarget, optimize: std.builtin.OptimizeMode) *std.Build.Step.Compile {
    const libc = b.addStaticLibrary(.{
        .name = "foundation",
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

    for (header_files) |header_name| {
        b.getInstallStep().dependOn(&b.addInstallHeaderFile(
            b.fmt("include/{s}", .{header_name}),
            header_name,
        ).step);
    }
}
