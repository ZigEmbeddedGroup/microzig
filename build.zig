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
    for (header_files) |header_name|
        libc.installHeader(
            b.fmt("include/{s}", .{header_name}),
            header_name,
        );

    return libc;
}

pub fn build(b: *std.Build) void {
    const validation_step = b.step("validate", "Runs the test suite and validates everything. Automatically triggered in Debug builds.");

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const single_threaded = b.option(bool, "single-threaded", "Create a single-threaded libc implementation (default: false)") orelse false;

    // Run validation in debug builds for convenience:
    if (optimize == .Debug) {
        b.getInstallStep().dependOn(validation_step);
    }

    // check if the host has a gcc or clang available:
    const maybe_gcc = b.findProgram(&.{"gcc"}, &.{}) catch null;
    const maybe_clang = b.findProgram(&.{"clang"}, &.{}) catch null;

    const libc = createLibrary(b, target, optimize);
    libc.single_threaded = single_threaded;
    b.installArtifact(libc);

    // test suite:
    {
        // Compile for huge amount of targets to detect breakage early on:
        for ([_]bool{ false, true }) |validation_single_threaded| {
            for (std.enums.values(std.builtin.OptimizeMode)) |validation_optimize| {
                for (validation_target_list) |validation_target| {

                    // skip everything that cannot support multithreading on freestanding:
                    if (!validation_single_threaded and !target_can_multithread(validation_target))
                        continue;

                    const vlc = createLibrary(b, validation_target, validation_optimize);
                    vlc.single_threaded = validation_single_threaded;
                    validation_step.dependOn(&vlc.step);
                }
            }
        }

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
            validation_step.dependOn(&syntax_validator.step);
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

            validation_step.dependOn(&ext_compiler.step);
        }

        // Validate all modes of assertion:
        for ([_][]const u8{
            "FOUNDATION_LIBC_ASSERT_DEFAULT",
            "FOUNDATION_LIBC_ASSERT_NOFILE",
            "FOUNDATION_LIBC_ASSERT_NOMSG",
            "FOUNDATION_LIBC_ASSERT_EXPECTED",
        }) |assert_mode| {
            // Check if the syntax of all of our header files is valid:
            const assert_validator = b.addStaticLibrary(.{
                .name = "assert-validator",
                .target = .{}, // just build for the host
                .optimize = .Debug,
            });
            assert_validator.addCSourceFile(.{
                .file = .{ .path = "tests/assert-validator.c" },
                .flags = &common_c_flags,
            });
            assert_validator.addIncludePath(include_path);
            _ = assert_validator.getEmittedBin();

            assert_validator.defineCMacro("FOUNDATION_LIBC_ASSERT", assert_mode);

            // Just compile, do not install:
            validation_step.dependOn(&assert_validator.step);
        }
    }
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

fn target_can_multithread(target: std.zig.CrossTarget) bool {
    return switch (target.getCpuArch()) {
        .wasm32,
        .wasm64,
        .msp430,
        => false,

        else => true,
    };
}

const validation_target_list = [_]std.zig.CrossTarget{
    .{}, // regular host platform
    .{ .os_tag = .freestanding }, // host platform, but no OS

    // Check several common cpu targets:

    // arm:
    .{ .cpu_arch = .arm, .os_tag = .freestanding },
    .{ .cpu_arch = .armeb, .os_tag = .freestanding },
    .{ .cpu_arch = .thumb, .os_tag = .freestanding },
    .{ .cpu_arch = .thumbeb, .os_tag = .freestanding },
    .{ .cpu_arch = .aarch64, .os_tag = .freestanding },
    // .{ .cpu_arch = .aarch64_32, .os_tag = .freestanding }, // error: unknown target triple 'aarch64_32-unknown-unknown-eabi', please use -triple or -arch
    .{ .cpu_arch = .aarch64_be, .os_tag = .freestanding },

    // risc-v:
    .{ .cpu_arch = .riscv32, .os_tag = .freestanding },
    .{ .cpu_arch = .riscv64, .os_tag = .freestanding },

    // intel:
    .{ .cpu_arch = .x86_64, .os_tag = .freestanding },
    .{ .cpu_arch = .x86, .os_tag = .freestanding },

    // mips:
    .{ .cpu_arch = .mips, .os_tag = .freestanding },
    .{ .cpu_arch = .mips64, .os_tag = .freestanding },
    .{ .cpu_arch = .mips64el, .os_tag = .freestanding },
    .{ .cpu_arch = .mipsel, .os_tag = .freestanding },

    // sparc:
    .{ .cpu_arch = .sparc, .os_tag = .freestanding },
    .{ .cpu_arch = .sparc64, .os_tag = .freestanding },
    .{ .cpu_arch = .sparcel, .os_tag = .freestanding },

    // power:
    .{ .cpu_arch = .powerpc, .os_tag = .freestanding },
    .{ .cpu_arch = .powerpc64, .os_tag = .freestanding },
    .{ .cpu_arch = .powerpc64le, .os_tag = .freestanding },
    .{ .cpu_arch = .powerpcle, .os_tag = .freestanding },

    // web assembly:
    .{ .cpu_arch = .wasm32, .os_tag = .freestanding },
    .{ .cpu_arch = .wasm64, .os_tag = .freestanding },

    // nice to have, but broken:
    .{ .cpu_arch = .avr, .os_tag = .freestanding },
    // .{ .cpu_arch = .msp430, .os_tag = .freestanding }, // error: unknown target CPU 'generic'
    // .{ .cpu_arch = .m68k, .os_tag = .freestanding },
    // .{ .cpu_arch = .xtensa, .os_tag = .freestanding },

    // Not evaluated if reasonable to check:
    //   arc
    //   csky
    //   hexagon
    //   hsail
    //   hsail64
    //   kalimba
    //   lanai
    //   le32
    //   le64
    //   loongarch32
    //   loongarch64
    //   r600
    //   s390x
    //   shave
    //   spu_2
    //   tce
    //   tcele
    //   ve
    //   xcore

    // will never be supported due to their properties:
    //   spir
    //   spir64
    //   spirv32
    //   spirv64

    //   bpfeb
    //   bpfel

    //   renderscript32
    //   renderscript64

    //   amdgcn
    //   amdil
    //   amdil64

    //   nvptx
    //   nvptx64

    //   dxil
};

const sdk_root = computeSdkRoot();

fn computeSdkRoot() []const u8 {
    return std.fs.path.dirname(@src().file).?;
}
