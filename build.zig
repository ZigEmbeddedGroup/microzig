const builtin = @import("builtin");
const std = @import("std");
const Build = std.Build;

const internals = @import("microzig/build-internals");

const MicroZig = @This();

b: *Build,
dep: *Build.Dependency,

pub fn build(b: *Build) void {
    const build_internals_dep = b.dependency("microzig/build-internals", .{});
    const generate_linker_script = b.addExecutable(.{
        .name = "generate_linker_script",
        .root_source_file = b.path("tools/generate_linker_script.zig"),
        .target = b.host,
    });
    generate_linker_script.root_module.addImport("microzig/build-internals", build_internals_dep.module("shared"));
    b.installArtifact(generate_linker_script);
}

/// Initializes MicroZig.
pub fn init(b: *Build, dep: *Build.Dependency) *MicroZig {
    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = .{
        .b = b,
        .dep = dep,
    };
    return mz;
}

// TODO: make a comptime system for this so as to allow specifying a list of ports instead of manually coding all the logic when
// adding a new one
/// Loads the specified ports and return a struct including all the targets aliases exposed.
pub inline fn load_ports(mz: *MicroZig, comptime port_select: struct {
    rp2xxx: bool = false,
    lpc: bool = false,
}) type {
    // This should ensure that lazyImport never fails. Kind of a hacky way to do things, but it should work
    var should_quit = false;
    should_quit = should_quit or
        if (port_select.rp2xxx) mz.dep.builder.lazyDependency("microzig/port/raspberrypi/rp2xxx", .{}) == null else false;
    should_quit = should_quit or
        if (port_select.lpc) mz.dep.builder.lazyDependency("microzig/port/nxp/lpc", .{}) == null else false;
    if (should_quit) {
        std.process.exit(0);
    }

    const rp2xxx_port = if (port_select.rp2xxx)
        mz.dep.builder.lazyImport(@This(), "microzig/port/raspberrypi/rp2xxx").?
    else
        struct {};

    const lpc_port = if (port_select.lpc)
        mz.dep.builder.lazyImport(@This(), "microzig/port/nxp/lpc").?
    else
        struct {};

    return struct {
        pub const rp2xxx = if (port_select.rp2xxx)
            rp2xxx_port
        else
            @compileError("Please provide `.rp2xxx = true` to enable the port.");

        pub const lpc = if (port_select.lpc)
            lpc_port
        else
            @compileError("Please provide `.lpc = true` to enable the port.");
    };
}

/// Gets a MicroZig target based on its alias.
pub fn get_target(_: *MicroZig, alias: *const internals.TargetAlias) internals.Target {
    return internals.get_target(alias) orelse @panic("target not found");
}

/// Configuration options for firmware creation.
pub const CreateFirmwareOptions = struct {
    name: []const u8,
    target: internals.Target,
    optimize: std.builtin.OptimizeMode,
    root_source_file: Build.LazyPath,
    imports: []const Build.Module.Import = &.{},
};

/// Declaration of a firmware build.
pub const Firmware = struct {
    pub const EmittedFiles = std.AutoHashMap(internals.BinaryFormat, Build.LazyPath);

    mz: *MicroZig,

    /// The artifact that is built by Zig.
    artifact: *Build.Step.Compile,

    /// The target to which the firmware is built.
    target: internals.Target,

    emitted_elf: ?Build.LazyPath = null,
    emitted_files: EmittedFiles,

    /// Returns the emitted ELF file for this firmware. This is useful if you need debug information
    /// or want to use a debugger like Segger, ST-Link or similar.
    ///
    /// **NOTE:** This is similar, but not equivalent to `std.Build.Step.Compile.getEmittedBin`. The call on the compile step does
    ///           not include post processing of the ELF files necessary by certain targets.
    pub fn get_emitted_elf(fw: *Firmware) Build.LazyPath {
        if (fw.emitted_elf == null) {
            const raw_elf = fw.artifact.getEmittedBin();
            fw.emitted_elf = if (fw.target.patch_elf) |patch_elf|
                patch_elf.func(patch_elf.b, raw_elf)
            else
                raw_elf;
        }
        return fw.emitted_elf.?;
    }

    /// Returns the emitted binary for this firmware. The file is either in the preferred file format for
    /// the target or in `format` if not null.
    ///
    /// **NOTE:** The file returned here is the same file that will be installed.
    pub fn get_emitted_bin(firmware: *Firmware, format: ?internals.BinaryFormat) Build.LazyPath {
        const resolved_format = format orelse firmware.target.preferred_binary_format orelse .elf;

        const result = firmware.emitted_files.getOrPut(resolved_format) catch @panic("out of memory");
        if (!result.found_existing) {
            const elf_file = firmware.get_emitted_elf();

            const basename = firmware.mz.b.fmt("{s}{s}", .{
                firmware.artifact.name,
                resolved_format.get_extension(),
            });

            result.value_ptr.* = switch (resolved_format) {
                .elf => elf_file,

                .bin => blk: {
                    const objcopy = firmware.mz.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .bin,
                    });

                    break :blk objcopy.getOutput();
                },

                .hex => blk: {
                    const objcopy = firmware.mz.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .hex,
                    });

                    break :blk objcopy.getOutput();
                },

                .uf2 => |family_id| blk: {
                    const uf2_exe = firmware.mz.dep.builder.dependency("microzig/tools/uf2", .{ .optimize = .ReleaseSafe }).artifact("elf2uf2");

                    const convert = firmware.mz.b.addRunArtifact(uf2_exe);

                    convert.addArg("--family-id");
                    convert.addArg(firmware.mz.b.fmt("0x{X:0>4}", .{@intFromEnum(family_id)}));

                    convert.addArg("--elf-path");
                    convert.addFileArg(elf_file);

                    convert.addArg("--output-path");
                    break :blk convert.addOutputFileArg(basename);
                },

                .dfu => @panic("DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!"),
                .esp => @panic("ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!"),

                .custom => |generator| generator.convert(generator, elf_file),
            };
        }

        return result.value_ptr.*;
    }
};

/// Creates a new firmware.
pub fn add_firmware(mz: *MicroZig, options: CreateFirmwareOptions) *Firmware {
    const b = mz.dep.builder;
    const target = options.target;
    const zig_target = mz.dep.builder.resolveTargetQuery(target.chip.cpu);
    const cpu = Cpu.init(zig_target.result);

    // TODO: let the user override which ram section to use the stack on,
    // for now just using the first ram section in the memory region list
    const first_ram = blk: {
        for (target.chip.memory_regions) |region| {
            if (region.kind == .ram)
                break :blk region;
        } else @panic("no ram memory region found for setting the end-of-stack address");
    };

    const config = mz.dep.builder.addOptions();
    config.addOption(bool, "has_hal", target.hal != null);
    config.addOption(bool, "has_board", target.board != null);

    config.addOption([]const u8, "cpu_name", zig_target.result.cpu.model.name);
    config.addOption([]const u8, "chip_name", target.chip.name);
    config.addOption(usize, "end_of_stack", first_ram.offset + first_ram.length);

    // NOTE: should you pass optimize? the same for all
    const core_mod = b.createModule(.{
        .root_source_file = b.path("core/microzig.zig"),
        .imports = &.{
            .{
                .name = "config",
                .module = config.createModule(),
            },
        },
    });

    const cpu_mod = cpu.create_module(b);
    cpu_mod.addImport("microzig", core_mod);
    core_mod.addImport("cpu", cpu_mod);

    const regz_exe = b.dependency("microzig/tools/regz", .{}).artifact("regz");
    const chip_mod = target.chip.create_module(regz_exe);
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

    const fw = mz.b.allocator.create(Firmware) catch @panic("out of memory");

    fw.* = .{
        .mz = mz,
        .artifact = mz.b.addExecutable(.{
            .name = options.name,
            .target = zig_target,
            .optimize = options.optimize,
            .root_source_file = mz.dep.path("core/start.zig"),
        }),
        .target = target,
        .emitted_files = Firmware.EmittedFiles.init(mz.b.allocator),
    };

    fw.artifact.root_module.addImport("microzig", core_mod);
    fw.artifact.root_module.addImport("app", app_mod);

    // If not specified then generate the linker script
    const linker_script = target.linker_script orelse blk: {
        const GenerateLinkerScriptArgs = @import("tools/generate_linker_script.zig").Args;

        const generate_linker_script_exe = mz.dep.artifact("generate_linker_script");

        const generate_linker_script_args = GenerateLinkerScriptArgs{
            .cpu_name = zig_target.result.cpu.model.name,
            .cpu_arch = zig_target.result.cpu.arch,
            .chip_name = target.chip.name,
            .memory_regions = target.chip.memory_regions,
        };

        const args_str = std.json.stringifyAlloc(
            b.allocator,
            generate_linker_script_args,
            .{},
        ) catch @panic("out of memory");

        const generate_linker_script_run = b.addRunArtifact(generate_linker_script_exe);
        generate_linker_script_run.addArg(args_str);
        break :blk generate_linker_script_run.addOutputFileArg("linker.ld");
    };
    fw.artifact.setLinkerScript(linker_script);

    return fw;
}

/// Configuration options for firmware installation.
pub const InstallFirmwareOptions = struct {
    format: ?internals.BinaryFormat = null,
};

/// Adds a new dependency to the `install` step that will install the `firmware` into the folder `$prefix/firmware`.
pub fn install_firmware(mz: *MicroZig, firmware: *Firmware, options: InstallFirmwareOptions) void {
    std.debug.assert(mz == firmware.mz);

    const install_step = add_install_firmware(mz, firmware, options);
    mz.b.getInstallStep().dependOn(&install_step.step);
}

/// Creates a new `std.Build.Step.InstallFile` instance that will install the given firmware to `$prefix/firmware`.
///
/// **NOTE:** This does not actually install the firmware yet. You have to add the returned step as a dependency to another step.
///           If you want to just install the firmware, use `installFirmware` instead!
pub fn add_install_firmware(mz: *MicroZig, firmware: *Firmware, options: InstallFirmwareOptions) *Build.Step.InstallFile {
    std.debug.assert(mz == firmware.mz);

    const format = options.format orelse firmware.target.preferred_binary_format orelse .elf;

    const basename = mz.b.fmt("{s}{s}", .{
        firmware.artifact.name,
        format.get_extension(),
    });

    return mz.b.addInstallFileWithDir(firmware.get_emitted_bin(format), .{ .custom = "firmware" }, basename);
}

const Cpu = enum {
    avr5,
    cortex_m,
    riscv32,

    // TODO: add here the remaining cpus
    pub fn init(target: std.Target) Cpu {
        // TODO: not sure this is right tho
        if (target.cpu.arch.isThumb()) {
            return .cortex_m;
        }

        @panic("unrecognized cpu configuration");
    }

    pub fn create_module(cpu: Cpu, b: *Build) *Build.Module {
        return b.createModule(.{
            .root_source_file = switch (cpu) {
                .avr5 => b.path("cpus/avr5.zig"),
                .cortex_m => b.path("cpus/cortex_m.zig"),
                .riscv32 => b.path("cpus/riscv32.zig"),
            },
        });
    }
};

// fn init_cpu_map(mz: *MicroZig) void {
//     mz.cpu_map.put(.avr5, .{
//         .name = "avr5",
//         .root_source_file = mz.dep.path("cpus/avr5.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .avr,
//             .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m0, .{
//         .name = "cortex_m0",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m0plus, .{
//         .name = "cortex_m0plus",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m3, .{
//         .name = "cortex_m3",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m33, .{
//         .name = "cortex_m33",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m4, .{
//         .name = "cortex_m4",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
//             .os_tag = .freestanding,
//             .abi = .eabi,
//         },
//     });
//     mz.cpu_map.put(.cortex_m4f, .{
//         .name = "cortex_m4f",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.zig.CrossTarget{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
//             .cpu_features_add = std.Target.arm.featureSet(&.{.vfp4d16sp}),
//             .os_tag = .freestanding,
//             .abi = .eabihf,
//         },
//     });
//     mz.cpu_map.put(.cortex_m7, .{
//         .name = "cortex_m7",
//         .root_source_file = mz.dep.path("cpus/cortex_m.zig"),
//         .target = std.zig.CrossTarget{
//             .cpu_arch = .thumb,
//             .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m7 },
//             .os_tag = .freestanding,
//             .abi = .eabihf,
//         },
//     });
//     mz.cpu_map.put(.riscv32_imac, .{
//         .name = "riscv32_imac",
//         .root_source_file = mz.dep.path("cpus/riscv32.zig"),
//         .target = std.Target.Query{
//             .cpu_arch = .riscv32,
//             .cpu_model = .{ .explicit = &std.Target.riscv.cpu.sifive_e21 },
//             .os_tag = .freestanding,
//             .abi = .none,
//         },
//     });
// }
