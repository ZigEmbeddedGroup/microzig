const std = @import("std");

pub const include_path = std.Build.LazyPath{
    .cwd_relative = sdk_root ++ "/include",
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

    // test suite:
    {
        // Check if the syntax of all of our header files is valid:
        const syntax_validator = b.addStaticLibrary(.{
            .name = "syntax-validator",
            .target = .{}, // just build for the host
            .optimize = .Debug,
        });
        syntax_validator.addCSourceFile(.{
            .file = .{ .path = "tests/syntactic-validation.c" },
            .flags = &common_c_flags,
        });
        syntax_validator.addIncludePath(include_path);
        _ = syntax_validator.getEmittedBin();

        // Just compile, do not install:
        b.getInstallStep().dependOn(&syntax_validator.step);
    }
}

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

const common_c_flags = [_][]const u8{
    "-std=c11", // target C standard
    //
    "-Werror", // we do not allow warnings
    "-Wall",
    "-Wextra",
    "-Wmost",
    "-Weverything", // this might be dropped later as we just want to find all potential warnings and enable/disable them as required.
    //
    "-Wno-reserved-macro-identifier", // we actually want to implement those!
    "-Wno-reserved-identifier", // we actually want to implement those!
};

const sdk_root = computeSdkRoot();

fn computeSdkRoot() []const u8 {
    return std.fs.path.dirname(@src().file).?;
}
