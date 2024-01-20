//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const microbuild = @import("microzig-build");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *std.Build) !void {
    _ = b;
    // const uf2_dep = b.dependency("uf2", .{});

    // const build_test = b.addTest(.{
    //     .root_source_file = .{ .path = "build.zig" },
    // });

    // build_test.addAnonymousModule("uf2", .{
    //     .source_file = .{ .cwd_relative = uf2_dep.builder.pathFromRoot("build.zig") },
    // });

    // const install_docs = b.addInstallDirectory(.{
    //     .source_dir = build_test.getEmittedDocs(),
    //     .install_dir = .prefix,
    //     .install_subdir = "docs",
    // });

    // b.getInstallStep().dependOn(&install_docs.step);

    // const backings = @import("test/backings.zig");
    // const optimize = b.standardOptimizeOption(.{});

    // const minimal = addEmbeddedExecutable(b, .{
    //     .name = "minimal",
    //     .source_file = .{
    //         .path = comptime root_dir() ++ "/test/programs/minimal.zig",
    //     },
    //     .backing = backings.minimal,
    //     .optimize = optimize,
    // });

    // const has_hal = addEmbeddedExecutable(b, .{
    //     .name = "has_hal",
    //     .source_file = .{
    //         .path = comptime root_dir() ++ "/test/programs/has_hal.zig",
    //     },
    //     .backing = backings.has_hal,
    //     .optimize = optimize,
    // });

    // const has_board = addEmbeddedExecutable(b, .{
    //     .name = "has_board",
    //     .source_file = .{
    //         .path = comptime root_dir() ++ "/test/programs/has_board.zig",
    //     },
    //     .backing = backings.has_board,
    //     .optimize = optimize,
    // });

    // const core_tests = b.addTest(.{
    //     .root_source_file = .{
    //         .path = comptime root_dir() ++ "/src/core.zig",
    //     },
    //     .optimize = optimize,
    // });

    // const test_step = b.step("test", "build test programs");
    // test_step.dependOn(&minimal.inner.step);
    // test_step.dependOn(&has_hal.inner.step);
    // test_step.dependOn(&has_board.inner.step);
    // test_step.dependOn(&b.addRunArtifact(core_tests).step);
}

pub const cpus = struct {
    pub const avr5 = microbuild.Cpu{
        .name = "AVR5",
        .source_file = .{ .path = build_root ++ "/src/cpus/avr5.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .avr,
            .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0 = microbuild.Cpu{
        .name = "ARM Cortex-M0",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0plus = microbuild.Cpu{
        .name = "ARM Cortex-M0+",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m3 = microbuild.Cpu{
        .name = "ARM Cortex-M3",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m4 = microbuild.Cpu{
        .name = "ARM Cortex-M4",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const riscv32_imac = microbuild.Cpu{
        .name = "RISC-V 32-bit",
        .source_file = .{ .path = build_root ++ "/src/cpus/riscv32.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
            .os_tag = .freestanding,
            .abi = .none,
        },
    };
};
