const builtin = @import("builtin");
const std = @import("std");
const Build = std.Build;

const internals = @import("microzig/build-internals");
const uf2 = @import("microzig/tools/uf2");

const MicroZig = @This();
const CpuMap = std.EnumMap(internals.CpuKind, Cpu);

b: *Build,
dep: *Build.Dependency,
cpu_map: CpuMap,

pub fn build(b: *Build) void {
    _ = b.dependency("microzig/build-internals", .{});

    const rp2xxx_enable = b.option(bool, "rp2xxx", "Use the RaspberryPi rp2xxx port") orelse false;

    if (rp2xxx_enable) {
        if (b.lazyDependency("microzig/raspberrypi/rp2xxx", .{})) |rp2xxx_dep| {
            _ = rp2xxx_dep;
        }
    }
}

pub fn init(b: *Build, dep: *Build.Dependency) *MicroZig {
    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = .{
        .b = b,
        .dep = dep,
        .cpu_map = CpuMap.init(.{}),
    };

    mz.init_cpu_map();

    return mz;
}

pub fn add_firmware(mz: *MicroZig, options: CreateFirmwareOptions) *Build.Step.Compile {
    const target = options.target;
    const cpu = mz.cpu_map.get(target.cpu) orelse @panic("unimplemented cpu: this shouldn't happen");
    const zig_target = mz.dep.builder.resolveTargetQuery(cpu.target);

    const config = mz.dep.builder.addOptions();
    config.addOption(bool, "has_hal", target.hal != null);
    config.addOption(bool, "has_board", target.board != null);

    config.addOption([]const u8, "cpu_name", @tagName(target.cpu));
    config.addOption([]const u8, "chip_name", target.chip.name);

    // NOTE: should you pass optimize? the same for all
    const core_mod = mz.dep.builder.createModule(.{
        .root_source_file = mz.dep.path("core/microzig.zig"),
        .imports = &.{
            .{
                .name = "config",
                .module = config.createModule(),
            },
        },
    });

    const cpu_mod = mz.dep.builder.createModule(.{
        .root_source_file = cpu.root_source_file,
    });
    cpu_mod.addImport("microzig", core_mod);
    core_mod.addImport("cpu", cpu_mod);

    const chip_mod = target.chip.module.create_module();
    chip_mod.addImport("microzig", core_mod);
    core_mod.addImport("chip", chip_mod);

    if (target.hal) |hal| {
        const hal_mod = hal.create_module();
        hal_mod.addImport("microzig", core_mod);
        core_mod.addImport("hal", hal_mod);
    }

    if (target.board) |board| {
        const board_mod = board.create_module();
        board_mod.addImport("microzig", core_mod);
        core_mod.addImport("board", board_mod);
    }

    const app_mod = mz.b.createModule(.{
        .root_source_file = options.root_source_file,
        .imports = options.imports,
    });
    app_mod.addImport("microzig", core_mod);

    const artifact = mz.b.addExecutable(.{
        .name = options.name,
        .target = zig_target,
        .optimize = options.optimize,
        .root_source_file = mz.dep.path("core/start.zig"),
    });

    artifact.root_module.addImport("microzig", core_mod);
    artifact.root_module.addImport("app", app_mod);

    // If not specified then generate the linker script
    artifact.setLinkerScript(target.linker_script);

    return artifact;
}

pub fn install_firmware(mz: *MicroZig, artifact: *Build.Step.Compile, options: InstallFirmwareOptions) void {
    const install_step = mz.add_install_firmware(artifact, options);
    mz.b.getInstallStep().dependOn(&install_step.step);
}

pub fn add_install_firmware(mz: *MicroZig, artifact: *Build.Step.Compile, options: InstallFirmwareOptions) *Build.Step.InstallFile {
    const extension = options.format.get_extension();

    const basename = mz.b.fmt("{s}{s}", .{
        artifact.name,
        extension,
    });

    const elf_file = artifact.getEmittedBin();

    const output_file = switch (options.format) {
        .elf => elf_file,
        .bin => blk: {
            const objcopy = mz.b.addObjCopy(elf_file, .{
                .basename = basename,
                .format = .bin,
            });
            break :blk objcopy.getOutput();
        },
        .hex => blk: {
            const objcopy = mz.b.addObjCopy(elf_file, .{
                .basename = basename,
                .format = .hex,
            });

            break :blk objcopy.getOutput();
        },
        .dfu => @panic("DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!"),
        .uf2 => |family_id| blk: {
            const uf2_exe = mz.dep.builder.dependency("microzig/tools/uf2", .{ .optimize = .ReleaseSafe }).artifact("elf2uf2");

            const convert = mz.b.addRunArtifact(uf2_exe);

            convert.addArg("--family-id");
            convert.addArg(mz.b.fmt("0x{X:0>4}", .{@intFromEnum(family_id)}));

            convert.addArg("--elf-path");
            convert.addFileArg(elf_file);

            convert.addArg("--output-path");
            break :blk convert.addOutputFileArg(basename);
        },
        .esp => @panic("ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!"),
    };

    return mz.b.addInstallFileWithDir(output_file, .{ .custom = "firmware" }, basename);
}

pub fn get_target(tag: @TypeOf(.enum_literal)) internals.Target {
    return internals.get_target(@tagName(tag)) orelse @panic("target not found");
}

pub const CreateFirmwareOptions = struct {
    name: []const u8,
    target: internals.Target,
    optimize: std.builtin.OptimizeMode,
    root_source_file: Build.LazyPath,
    imports: []const Build.Module.Import = &.{},
};

pub const InstallFirmwareOptions = struct {
    format: BinaryFormat,
};

// TODO: should be revisited.. maybe we can leave installing on the user and just provide tools (uf2).
pub const BinaryFormat = union(enum) {
    /// [Executable and Linkable Format](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format), the standard output from the compiler.
    elf,

    /// A flat binary, contains only the loaded portions of the firmware with an unspecified base offset.
    bin,

    /// The [Intel HEX](https://en.wikipedia.org/wiki/Intel_HEX) format, contains
    /// an ASCII description of what memory to load where.
    hex,

    /// A [Device Firmware Upgrade](https://www.usb.org/sites/default/files/DFU_1.1.pdf) file.
    dfu,

    /// The [USB Flashing Format (UF2)](https://github.com/microsoft/uf2) designed by Microsoft.
    uf2: uf2.FamilyId,

    /// The [firmware format](https://docs.espressif.com/projects/esptool/en/latest/esp32/advanced-topics/firmware-image-format.html) used by the [esptool](https://github.com/espressif/esptool) bootloader.
    esp,

    /// Returns the standard extension for the resulting binary file.
    pub fn get_extension(format: BinaryFormat) []const u8 {
        return switch (format) {
            .elf => ".elf",
            .bin => ".bin",
            .hex => ".hex",
            .dfu => ".dfu",
            .uf2 => ".uf2",
            .esp => ".bin",
        };
    }
};

const Cpu = struct {
    name: []const u8,
    root_source_file: Build.LazyPath,
    target: std.Target.Query,
};

fn init_cpu_map(mz: *MicroZig) void {
    mz.cpu_map.put(.avr5, .{
        .name = "avr5",
        .root_source_file = mz.dep.path("cpus/avr5.zig"),
        .target = std.Target.Query{
            .cpu_arch = .avr,
            .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m0, .{
        .name = "cortex_m0",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m0plus, .{
        .name = "cortex_m0plus",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m3, .{
        .name = "cortex_m3",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m33, .{
        .name = "cortex_m33",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m4, .{
        .name = "cortex_m4",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    });
    mz.cpu_map.put(.cortex_m4f, .{
        .name = "cortex_m4f",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
    });
    mz.cpu_map.put(.cortex_m7, .{
        .name = "cortex_m7",
        .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m7 },
            .os_tag = .freestanding,
            .abi = .eabihf,
        },
    });
    mz.cpu_map.put(.riscv32_imac, .{
        .name = "riscv32_imac",
        .root_source_file = mz.dep.path("cpus/riscv32.zig"),
        .target = std.Target.Query{
            .cpu_arch = .riscv32,
            .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
            .os_tag = .freestanding,
            .abi = .none,
        },
    });
}
