const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

const KiB = 1024;

pub fn build(b: *std.Build) void {
    _ = b;
}

pub const v5f_image_offset: u64 = 0x10000;
pub const flash_size: u64 = 960 * KiB;

chips: struct {
    ch32h417_v3f: *const microzig.Target,
    ch32h417_v5f: *const microzig.Target,
},

boards: struct {},

merge_exe: *std.Build.Step.Compile,

fn create_core(
    dep: *std.Build.Dependency,
    cpu_name: []const u8,
    cpu_impl_file: std.Build.LazyPath,
    memory_regions: []const microzig.MemoryRegion,
) *microzig.Target {
    const b = dep.builder;

    const cpu_imports = b.allocator.dupe(std.Build.Module.Import, &.{
        .{
            .name = "riscv32-common",
            .module = b.dependency("microzig/modules/riscv32-common", .{}).module("riscv32-common"),
        },
        .{
            .name = "cpu_impl",
            .module = std.Build.Module.create(b, .{ .root_source_file = cpu_impl_file }),
        },
    }) catch @panic("out of memory");

    const core = b.allocator.create(microzig.Target) catch @panic("out of memory");
    core.* = .{
        .dep = dep,
        .preferred_binary_format = .binary,
        .zig_target = .{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
            .cpu_features_add = cpu_common_features,
            .os_tag = .freestanding,
            .abi = .eabi,
        },
        .cpu = .{
            .name = cpu_name,
            .root_source_file = dep.path("src/cpus/main.zig"),
            .imports = cpu_imports,
        },
        .chip = .{
            .name = "CH32H417",
            .url = "https://www.wch-ic.com/products/CH32H417.html",
            .register_definition = .{ .svd = b.path("src/chips/ch32h417.svd") },
            .memory_regions = memory_regions,
        },
        .hal = .{
            .root_source_file = dep.path("src/hals/ch32h417.zig"),
        },
    };

    return core;
}

const cpu_common_features = std.Target.riscv.featureSet(&.{
    .i, .m, .a, .f, .c, .b, .xwchc, .zicsr, .zifencei,
});

pub fn init(dep: *std.Build.Dependency) ?Self {
    const b = dep.builder;

    const chip_v3f = create_core(dep, "qingkev3f", dep.path("src/cpus/qingkev3f.zig"), &.{
        .{ .name = "FLASH", .tag = .flash, .offset = 0x0000_0000, .length = v5f_image_offset, .access = .rx },
        .{ .name = "SRAM", .tag = .ram, .offset = 0x2010_0000, .length = 512 * KiB, .access = .rwx },
    });
    const chip_v5f = create_core(dep, "qingkev5f", dep.path("src/cpus/qingkev5f.zig"), &.{
        .{ .name = "FLASH", .tag = .flash, .offset = v5f_image_offset, .length = flash_size - v5f_image_offset, .access = .rx },
        .{ .name = "DTCM", .tag = .ram, .offset = 0x200C_0000, .length = 256 * KiB, .access = .rw },
        .{ .name = "ITCM", .tag = .ram, .offset = 0x200A_0000, .length = 128 * KiB, .access = .rwx },
    });

    const merge_exe = b.addExecutable(.{
        .name = "ch32h417-merge",
        .root_module = b.addModule("ch32h417-merge", .{
            .root_source_file = dep.path("tools/merge.zig"),
            .target = b.graph.host,
        }),
    });

    return .{
        .chips = .{
            .ch32h417_v3f = chip_v3f,
            .ch32h417_v5f = chip_v5f,
        },
        .boards = .{},
        .merge_exe = merge_exe,
    };
}

pub fn merge(
    self: @This(),
    dep: *std.Build.Dependency,
    v3f_elf: std.Build.LazyPath,
    v5f_elf: std.Build.LazyPath,
    merged_bin_path: []const u8,
) std.Build.LazyPath {
    const b = dep.builder;

    const merge_step = b.addRunArtifact(self.merge_exe);

    merge_step.addFileArg(v3f_elf);
    merge_step.addFileArg(v5f_elf);
    const merged_bin = merge_step.addOutputFileArg2(merged_bin_path, .{});

    b.getInstallStep().dependOn(&merge_step.step);

    return merged_bin;
}
