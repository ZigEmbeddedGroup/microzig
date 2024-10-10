//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const MicroZig = @import("microzig/build/definitions");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *std.Build) !void {
    _ = b;
}

pub const cpus = struct {
    pub const avr5 = MicroZig.Cpu{
        .name = "AVR5",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/avr5.zig" },
        .target = std.Target.Query{
            .cpu_arch = .avr,
            .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0 = MicroZig.Cpu{
        .name = "ARM Cortex-M0",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0plus = MicroZig.Cpu{
        .name = "ARM Cortex-M0+",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m3 = MicroZig.Cpu{
        .name = "ARM Cortex-M3",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m33 = MicroZig.Cpu{
        .name = "ARM Cortex-M33",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m4 = MicroZig.Cpu{
        .name = "ARM Cortex-M4",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m4f = MicroZig.Cpu{
        .name = "ARM Cortex-M4F",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
    };

    pub const cortex_m7 = MicroZig.Cpu{
        .name = "ARM Cortex-M7",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/cortex_m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m7 },
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
    };

    pub const riscv32_imac = MicroZig.Cpu{
        .name = "RISC-V 32-bit",
        .root_source_file = .{ .cwd_relative = build_root ++ "/src/cpus/riscv32.zig" },
        .target = std.Target.Query{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
            .os_tag = .freestanding,
            .abi = .none,
        },
    };
};
