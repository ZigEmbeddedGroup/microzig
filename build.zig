const std = @import("std");
const Build = std.Build;

const internals = @import("build-internals");
pub const Target = internals.Target;
pub const Chip = internals.Chip;
pub const ModuleDeclaration = internals.ModuleDeclaration;
pub const BinaryFormat = internals.BinaryFormat;
pub const MemoryRegion = internals.MemoryRegion;

const port_list: []const struct {
    name: [:0]const u8,
    dep_name: [:0]const u8,
} = &.{
    .{ .name = "rp2xxx", .dep_name = "port/raspberrypi/rp2xxx" },
    .{ .name = "lpc", .dep_name = "port/nxp/lpc" },
    .{ .name = "stm32", .dep_name = "port/stmicro/stm32" },
};

pub fn build(b: *Build) void {
    const generate_linker_script_exe = b.addExecutable(.{
        .name = "generate_linker_script",
        .root_source_file = b.path("tools/generate_linker_script.zig"),
        .target = b.host,
    });
    b.installArtifact(generate_linker_script_exe);

    const boxzer_dep = b.dependency("boxzer", .{});
    const boxzer_exe = boxzer_dep.artifact("boxzer");
    const boxzer_run = b.addRunArtifact(boxzer_exe);
    if (b.args) |args|
        boxzer_run.addArgs(args);

    const package_step = b.step("package", "Package monorepo using boxzer");
    package_step.dependOn(&boxzer_run.step);
}

pub const PortSelect = blk: {
    var fields: []const std.builtin.Type.StructField = &.{};
    for (port_list) |port| {
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

    for (port_list) |port| {
        if (@field(microzig_options.enable_ports, port.name)) {
            const typ = custom_lazy_import(port.dep_name) orelse struct {};
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

const MicroZig = @This();

b: *Build,
dep: *Build.Dependency,
core_dep: *Build.Dependency,
ports: Ports,

const InitReturnType = blk: {
    var ok = true;
    for (port_list) |port| {
        if (@field(microzig_options.enable_ports, port.name)) {
            ok = ok and custom_lazy_import(port.dep_name) != null;
        }
    }
    if (ok) {
        break :blk *MicroZig;
    } else {
        break :blk noreturn;
    }
};

/// Initializes an instance of MicroZig.
pub fn init(b: *Build, dep: *Build.Dependency) InitReturnType {
    if (InitReturnType == noreturn) {
        inline for (port_list) |port| {
            if (@field(microzig_options.enable_ports, port.name)) {
                _ = dep.builder.lazyDependency(port.dep_name, .{});
            }
        }
        std.process.exit(0);
    }

    var ports: Ports = undefined;
    inline for (port_list) |port| {
        if (@field(microzig_options.enable_ports, port.name)) {
            const port_dep = dep.builder.lazyDependency(port.dep_name, .{}).?;
            @field(ports, port.name) = custom_lazy_import(port.dep_name).?.init(port_dep);
        }
    }

    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = .{
        .b = b,
        .dep = dep,
        .core_dep = dep.builder.dependency("core", .{}),
        .ports = ports,
    };
    return mz;
}

/// Configuration options for firmware creation.
pub const CreateFirmwareOptions = struct {
    name: []const u8,
    target: *Target,
    optimize: std.builtin.OptimizeMode,
    root_source_file: Build.LazyPath,
    imports: []const Build.Module.Import = &.{},
    linker_script: ?Build.LazyPath = null,
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
        .root_source_file = mz.core_dep.path("src/microzig.zig"),
        .imports = &.{
            .{
                .name = "config",
                .module = config.createModule(),
            },
        },
    });

    const cpu_mod = cpu.create_module(b, mz.core_dep);
    cpu_mod.addImport("microzig", core_mod);
    core_mod.addImport("cpu", cpu_mod);

    const regz_exe = b.dependency("tools/regz", .{}).artifact("regz");
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
            .root_source_file = mz.core_dep.path("src/start.zig"),
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
    const linker_script = options.linker_script orelse target.linker_script orelse blk: {
        const GenerateLinkerScriptArgs = struct {
            cpu_name: []const u8,
            cpu_arch: std.Target.Cpu.Arch,
            chip_name: []const u8,
            memory_regions: []const MemoryRegion,
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
    format: ?BinaryFormat = null,
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

/// Declaration of a firmware build.
pub const Firmware = struct {
    pub const EmittedFiles = std.AutoHashMap(BinaryFormat, Build.LazyPath);

    mz: *MicroZig,

    /// The artifact that is built by Zig.
    artifact: *Build.Step.Compile,

    /// The target to which the firmware is built.
    target: *Target,

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
    pub fn get_emitted_bin(fw: *Firmware, format: ?BinaryFormat) Build.LazyPath {
        const resolved_format = format orelse fw.target.preferred_binary_format orelse .elf;

        const result = fw.emitted_files.getOrPut(resolved_format) catch @panic("out of memory");
        if (!result.found_existing) {
            const elf_file = fw.get_emitted_elf();

            const basename = fw.mz.b.fmt("{s}{s}", .{
                fw.artifact.name,
                resolved_format.get_extension(),
            });

            result.value_ptr.* = switch (resolved_format) {
                .elf => elf_file,

                .bin => blk: {
                    const objcopy = fw.mz.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .bin,
                    });

                    break :blk objcopy.getOutput();
                },

                .hex => blk: {
                    const objcopy = fw.mz.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .hex,
                    });

                    break :blk objcopy.getOutput();
                },

                .uf2 => |family_id| blk: {
                    const uf2_exe = fw.mz.dep.builder.dependency("tools/uf2", .{ .optimize = .ReleaseSafe }).artifact("elf2uf2");

                    const convert = fw.mz.b.addRunArtifact(uf2_exe);

                    convert.addArg("--family-id");
                    convert.addArg(@tagName(family_id));

                    convert.addArg("--elf-path");
                    convert.addFileArg(elf_file);

                    convert.addArg("--output-path");
                    break :blk convert.addOutputFileArg(basename);
                },

                .dfu => @panic("DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!"),
                .esp => @panic("ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!"),

                .custom => |generator| generator.convert(fw.target.dep, elf_file),
            };
        }

        return result.value_ptr.*;
    }
};

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

    pub fn create_module(cpu: Cpu, b: *Build, core_dep: *Build.Dependency) *Build.Module {
        return b.createModule(.{
            .root_source_file = switch (cpu) {
                .avr5 => core_dep.path("src/cpus/avr5.zig"),
                .cortex_m => core_dep.path("src/cpus/cortex_m.zig"),
                .riscv32 => core_dep.path("src/cpus/riscv32.zig"),
            },
        });
    }
};

pub inline fn custom_lazy_import(
    comptime dep_name: []const u8,
) ?type {
    const build_runner = @import("root");
    const deps = build_runner.dependencies;
    const pkg_hash = custom_find_import_pkg_hash_or_fatal(dep_name);

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

inline fn custom_find_import_pkg_hash_or_fatal(comptime dep_name: []const u8) []const u8 {
    const build_runner = @import("root");
    const deps = build_runner.dependencies;

    const pkg_deps = comptime for (@typeInfo(deps.packages).Struct.decls) |decl| {
        const pkg_hash = decl.name;
        const pkg = @field(deps.packages, pkg_hash);
        if (@hasDecl(pkg, "build_zig") and pkg.build_zig == @This()) break pkg.deps;
    } else deps.root_deps;

    comptime for (pkg_deps) |dep| {
        if (std.mem.eql(u8, dep[0], dep_name)) return dep[1];
    };

    @panic("dependency not found");
}
