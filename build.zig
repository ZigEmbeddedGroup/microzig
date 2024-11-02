const std = @import("std");
const Build = std.Build;

const internals = @import("microzig/build-internals");

const MicroZig = @This();

const ports_list = [_]struct {
    name: [:0]const u8,
    dep_name: [:0]const u8,
}{
    .{ .name = "rp2xxx", .dep_name = "microzig/port/raspberrypi/rp2xxx" },
    .{ .name = "lpc", .dep_name = "microzig/port/nxp/lpc" },
};

pub const PortSelect = blk: {
    var fields: []const std.builtin.Type.StructField = &.{};
    for (ports_list) |port| {
        fields = fields ++ [_]std.builtin.Type.StructField{.{
            .name = port.name,
            .type = bool,
            .default_value = @as(*const anyopaque, @ptrCast(&false)),
            .is_comptime = false,
            .alignment = @alignOf(bool),
        }};
    }
    break :blk @Type(.{
        .Struct = .{
            .layout = .auto,
            .fields = fields,
            .decls = &.{},
            .is_tuple = false,
        },
    });
};

pub const Options = struct {
    enable_ports: PortSelect = .{},
};

const microzig_options: Options = blk: {
    const build_runner = @import("root");
    const root = build_runner.root;
    break :blk if (@hasDecl(root, "microzig_options")) root.microzig_options else .{};
};

const Ports = blk: {
    var fields: []const std.builtin.Type.StructField = &.{};

    for (ports_list) |port| {
        if (@field(microzig_options.enable_ports, port.name)) {
            const typ = customLazyImport(@This(), port.dep_name) orelse struct {};
            fields = fields ++ [_]std.builtin.Type.StructField{.{
                .name = port.name,
                .type = typ,
                .default_value = null,
                .is_comptime = false,
                .alignment = @alignOf(typ),
            }};
        }
    }

    break :blk @Type(.{
        .Struct = .{
            .layout = .auto,
            .fields = fields,
            .decls = &.{},
            .is_tuple = false,
        },
    });
};

b: *Build,
dep: *Build.Dependency,
ports: Ports,

pub fn build(b: *Build) void {
    const generate_linker_script_exe = b.addExecutable(.{
        .name = "generate_linker_script",
        .root_source_file = b.path("tools/generate_linker_script.zig"),
        .target = b.host,
    });
    b.installArtifact(generate_linker_script_exe);
}

/// Initializes an instance of MicroZig.
pub fn init(b: *Build, dep: *Build.Dependency) *MicroZig {
    var ports: Ports = undefined;
    var should_quit = false;
    inline for (ports_list) |port| {
        if (@field(microzig_options.enable_ports, port.name)) {
            if (dep.builder.lazyDependency(port.dep_name, .{})) |port_dep| {
                @field(ports, port.name) = dep.builder.lazyImport(@This(), port.dep_name).?.init(port_dep);
            } else {
                should_quit = true;
            }
        }
    }
    if (should_quit) {
        std.process.exit(0);
    }

    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = .{
        .b = b,
        .dep = dep,
        .ports = ports,
    };

    return mz;
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
                patch_elf(fw.target.dep, raw_elf)
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
                    convert.addArg(@tagName(family_id));

                    convert.addArg("--elf-path");
                    convert.addFileArg(elf_file);

                    convert.addArg("--output-path");
                    break :blk convert.addOutputFileArg(basename);
                },

                .dfu => @panic("DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!"),
                .esp => @panic("ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!"),

                .custom => |generator| generator.convert(firmware.target.dep, elf_file),
            };
        }

        return result.value_ptr.*;
    }
};

/// Creates a new firmware for a given target.
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
    const chip_source = switch (target.chip.register_definition) {
        .json, .atdf, .svd => |file| blk: {
            const regz_run = b.addRunArtifact(regz_exe);

            regz_run.addArg("--schema"); // Explicitly set schema type, one of: svd, atdf, json
            regz_run.addArg(@tagName(target.chip.register_definition));

            regz_run.addArg("--output_path"); // Write to a file
            const zig_file = regz_run.addOutputFileArg("chip.zig");

            regz_run.addFileArg(file);

            break :blk zig_file;
        },

        .zig => |src| src,
    };
    const chip_mod = b.createModule(.{
        .root_source_file = chip_source,
    });

    chip_mod.addImport("microzig", core_mod);
    core_mod.addImport("chip", chip_mod);

    if (target.hal) |hal| {
        const hal_mod = b.createModule(.{
            .root_source_file = hal.root_source_file,
            .imports = hal.imports,
        });
        hal_mod.addImport("microzig", core_mod);
        core_mod.addImport("hal", hal_mod);
    }

    if (target.board) |board| {
        const board_mod = b.createModule(.{
            .root_source_file = board.root_source_file,
            .imports = board.imports,
        });
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
            .root_source_file = mz.dep.path("core/start.zig"),
            .target = zig_target,
            .optimize = options.optimize,
            .linkage = .static,
        }),
        .target = target,
        .emitted_files = Firmware.EmittedFiles.init(mz.b.allocator),
    };

    fw.artifact.root_module.addImport("microzig", core_mod);
    fw.artifact.root_module.addImport("app", app_mod);

    // If not specified then generate the linker script
    const linker_script = target.linker_script orelse blk: {
        const GenerateLinkerScriptArgs = struct {
            cpu_name: []const u8,
            cpu_arch: std.Target.Cpu.Arch,
            chip_name: []const u8,
            memory_regions: []const internals.MemoryRegion,
        };

        const generate_linker_script_exe = mz.dep.artifact("generate_linker_script");

        const generate_linker_script_args: GenerateLinkerScriptArgs = .{
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

pub inline fn customLazyImport(
    comptime asking_build_zig: type,
    comptime dep_name: []const u8,
) ?type {
    const build_runner = @import("root");
    const deps = build_runner.dependencies;
    const pkg_hash = customFindImportPkgHashOrFatal(asking_build_zig, dep_name);

    inline for (@typeInfo(deps.packages).Struct.decls) |decl| {
        if (comptime std.mem.eql(u8, decl.name, pkg_hash)) {
            const pkg = @field(deps.packages, decl.name);
            const available = !@hasDecl(pkg, "available") or pkg.available;
            if (!available) {
                return null;
            }
            return if (@hasDecl(pkg, "build_zig"))
                pkg.build_zig
            else
                @compileError("dependency '" ++ dep_name ++ "' does not have a build.zig");
        }
    }

    comptime unreachable; // Bad @dependencies source
}

inline fn customFindImportPkgHashOrFatal(comptime asking_build_zig: type, comptime dep_name: []const u8) []const u8 {
    const build_runner = @import("root");
    const deps = build_runner.dependencies;

    const pkg_deps = comptime for (@typeInfo(deps.packages).Struct.decls) |decl| {
        const pkg_hash = decl.name;
        const pkg = @field(deps.packages, pkg_hash);
        if (@hasDecl(pkg, "build_zig") and pkg.build_zig == asking_build_zig) break pkg.deps;
    } else deps.root_deps;

    comptime for (pkg_deps) |dep| {
        if (std.mem.eql(u8, dep[0], dep_name)) return dep[1];
    };

    @panic("dependency not found");
}

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
