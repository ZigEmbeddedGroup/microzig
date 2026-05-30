const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const single_threaded = b.option(bool, "single_threaded", "Create a single-threaded libc implementation (default: false)") orelse false;

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("include/foundation/libc.h"),
        .target = target,
        .optimize = optimize,
        .link_libc = false,
    });
    translate_c.addIncludePath(b.path("include"));

    const libc = b.addLibrary(.{
        .name = "foundation",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/libc.zig"),
            .single_threaded = single_threaded,
            .imports = &.{
                .{ .name = "h", .module = translate_c.createModule() },
            },
        }),
    });

    libc.root_module.addIncludePath(b.path("include"));
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
    "stdio.h",
    "stdlib.h",
    "string.h",
    "tgmath.h",
    "uchar.h",
    "foundation/libc.h",
};
