const std = @import("std");

pub fn build(b: *std.Build) void {
    const validation_step = b.step("validate", "Runs the test suite and validates everything. Automatically triggered in Debug builds.");

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const single_threaded = b.option(bool, "single_threaded", "Create a single-threaded libc implementation (default: false)") orelse false;

    // Run validation in debug builds for convenience:
    if (optimize == .Debug) {
        b.getInstallStep().dependOn(validation_step);
    }

    const libc = b.addStaticLibrary(.{
        .name = "foundation",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/libc.zig"),
        .single_threaded = single_threaded,
    });

    libc.addIncludePath(b.path("include"));
    for (header_files) |header_name|
        libc.installHeader(
            b.path(b.fmt("include/{s}", .{header_name})),
            header_name,
        );

    libc.installHeadersDirectory(b.path("include/foundation"), "foundation", .{});

    b.installArtifact(libc);
}

const header_files = [_][]const u8{
    "assert.h",
    "ctype.h",
    "errno.h",
    "inttypes.h",
    "math.h",
    "setjmp.h",
    "stdlib.h",
    "string.h",
    "tgmath.h",
    "uchar.h",
    "foundation/libc.h",
};
