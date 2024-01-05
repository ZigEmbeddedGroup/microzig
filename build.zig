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

    // check if the host has a gcc or clang available:
    const maybe_gcc = b.findProgram(&.{"gcc"}, &.{}) catch null;
    const maybe_clang = b.findProgram(&.{"clang"}, &.{}) catch null;

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
        const syntax_validator_source: std.Build.LazyPath = .{ .path = "tests/syntactic-validation.c" };

        // use the shipped C compiler to validate our code:
        {
            // Check if the syntax of all of our header files is valid:
            const syntax_validator = b.addStaticLibrary(.{
                .name = "syntax-validator",
                .target = .{}, // just build for the host
                .optimize = .Debug,
            });
            syntax_validator.addCSourceFile(.{
                .file = syntax_validator_source,
                .flags = &common_c_flags,
            });
            syntax_validator.addIncludePath(include_path);
            _ = syntax_validator.getEmittedBin();

            // Just compile, do not install:
            b.getInstallStep().dependOn(&syntax_validator.step);
        }

        // use the host C compilers to validate our code:
        for ([_]?[]const u8{ maybe_gcc, maybe_clang }) |maybe_cc| {
            const cc = maybe_cc orelse continue;

            const ext_compiler = b.addSystemCommand(&.{cc});

            // just compile every time, we don't have dir caching
            // so changes on the headers wouldn't re-trigger this
            ext_compiler.has_side_effects = true;

            ext_compiler.addPrefixedDirectoryArg("-I", include_path);

            ext_compiler.addArg("-c"); // compile only
            ext_compiler.addArg("-O0"); // no optimization for fast compiles
            ext_compiler.addArg("-ffreestanding"); // we require freestanding environment
            ext_compiler.addArg("-nostdlib"); // do not try to link anything useful

            // turn on warnings
            ext_compiler.addArg("-Werror");
            ext_compiler.addArg("-Wall");
            ext_compiler.addArg("-Wextra");

            ext_compiler.addFileArg(syntax_validator_source);

            ext_compiler.addArg("-o");
            ext_compiler.addArg(b.pathJoin(&.{ b.makeTempPath(), "dummy" })); // we don't really care where this ends up

            b.getInstallStep().dependOn(&ext_compiler.step);
        }
    }
}

const header_files = [_][]const u8{
    "ctype.h",
    "errno.h",
    "inttypes.h",
    "math.h",
    "setjmp.h",
    "stdlib.h",
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
