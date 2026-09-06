const std = @import("std");
const microzig = @import("microzig/build-internals");

const Self = @This();

const KiB = 1024;

pub fn build(b: *std.Build) void {
    _ = b;
}

pub const default_v5f_image_offset: u64 = 0x10000;
pub const total_flash_size: u64 = 960 * KiB;

chips: struct {
    ch32h417_v3f: *const microzig.Target,
    ch32h417_v5f: *const microzig.Target,
},

boards: struct {},

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
    const chip_v3f = create_core(dep, "qingkev3f", dep.path("src/cpus/qingkev3f.zig"), &.{
        .{ .name = "FLASH", .tag = .flash, .offset = 0x0000_0000, .length = default_v5f_image_offset, .access = .rx },
        .{ .name = "SRAM", .tag = .ram, .offset = 0x2010_0000, .length = 512 * KiB, .access = .rwx },
    });
    const chip_v5f = create_core(dep, "qingkev5f", dep.path("src/cpus/qingkev5f.zig"), &.{
        // V5F image lives right behind the V3F image in the merged binary.
        .{ .name = "FLASH", .tag = .flash, .offset = default_v5f_image_offset, .length = total_flash_size - default_v5f_image_offset, .access = .rx },
        // DTCM: 256 KB zero-wait data RAM, private to the V5F.
        // Listed first so the default stack lands at its end.
        .{ .name = "DTCM", .tag = .ram, .offset = 0x200C_0000, .length = 256 * KiB, .access = .rw },
        // ITCM: 128 KB zero-wait code RAM, private to the V5F.
        .{ .name = "ITCM", .tag = .ram, .offset = 0x200A_0000, .length = 128 * KiB, .access = .rwx },
    });

    return .{
        .chips = .{
            .ch32h417_v3f = chip_v3f,
            .ch32h417_v5f = chip_v5f,
        },
        .boards = .{},
    };
}

/// Options for building a dual-core (V3F + V5F) firmware image.
pub const DualCoreFirmwareOptions = struct {
    /// Base name of the firmware; the per-core executables are named
    /// `<name>_v3f` / `<name>_v5f`, the merged image `<name>.bin`.
    name: []const u8,

    /// Root source file of the V3F (boot core) application, e.g. `src/v3f.zig`.
    v3f_root_source_file: std.Build.LazyPath,

    /// Root source file of the V5F (application core) application, e.g. `src/v5f.zig`.
    v5f_root_source_file: std.Build.LazyPath,

    /// Optimization level for both cores.
    optimize: std.builtin.OptimizeMode,
};

/// A pair of firmware builds plus their merged flash image.
pub fn DualCoreFirmware(comptime mb_type: type) type {
    const Firmware = std.meta.Child(mb_type).Firmware;
    return struct {
        /// Firmware's name.
        name: []const u8,
        /// Firmware running on the V3F boot core (CORE0).
        v3f: *Firmware,
        /// Firmware running on the V5F application core (CORE1).
        v5f: *Firmware,
        /// Merged flash image.
        merged_bin: std.Build.LazyPath,
    };
}

/// Builds the V3F and V5F applications as two independent firmwares and merges
/// both ELF images into one flash image, gap padded with 0xFF.
pub fn addDualCoreFirmware(
    self: Self,
    mb: anytype,
    options: DualCoreFirmwareOptions,
) DualCoreFirmware(@TypeOf(mb)) {
    const b = mb.builder;

    const fw_v3f = mb.add_firmware(.{
        .name = b.fmt("{s}_v3f", .{options.name}),
        .root_source_file = options.v3f_root_source_file,
        .target = self.chips.ch32h417_v3f,
        .optimize = options.optimize,
    });

    const fw_v5f = mb.add_firmware(.{
        .name = b.fmt("{s}_v5f", .{options.name}),
        .root_source_file = options.v5f_root_source_file,
        .target = self.chips.ch32h417_v5f,
        .optimize = options.optimize,
    });

    // Host tool that merges the per-core ELF images into one flash image.
    const merge_exe = b.addExecutable(.{
        .name = "merge_dual_core_image",
        .root_module = b.createModule(.{
            .root_source_file = self.chips.ch32h417_v3f.dep.path("tools/merge_dual_core_image.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
        }),
    });

    const merge_run = b.addRunArtifact(merge_exe);
    merge_run.addFileArg(fw_v3f.get_emitted_elf());
    merge_run.addFileArg(fw_v5f.get_emitted_elf());
    merge_run.addArg(b.fmt("0x{x}", .{default_v5f_image_offset}));
    const merged_bin = merge_run.addOutputFileArg(b.fmt("{s}.bin", .{options.name}));

    return .{
        .name = options.name,
        .v3f = fw_v3f,
        .v5f = fw_v5f,
        .merged_bin = merged_bin,
    };
}

/// Install the merged image at `firmware/<name>.bin`.
pub fn installFirmware(
    self: Self,
    mb: anytype,
    firmware: DualCoreFirmware(@TypeOf(mb)),
) void {
    _ = self;

    const b = mb.builder;

    const install = b.addInstallFileWithDir(
        firmware.merged_bin,
        .{ .custom = "firmware" },
        b.fmt("{s}.bin", .{firmware.name}),
    );
    b.getInstallStep().dependOn(&install.step);
}
