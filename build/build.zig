//! MicroZig Build Interface
host_build: *Build,
self: *Build.Dependency,
microzig_core: *Build.Dependency,
generate_linkerscript: *Build.Step.Compile,

const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;

const uf2 = @import("microzig/tools/uf2");
const core = @import("microzig/core");
const defs = @import("microzig/build/definitions");
pub const Chip = defs.Chip;
pub const Cpu = defs.Cpu;
pub const HardwareAbstractionLayer = defs.HardwareAbstractionLayer;
pub const BoardDefinition = defs.BoardDefinition;

const MicroZig = @This();

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *Build) !void {
    const uf2_dep = b.dependency("microzig/tools/uf2", .{});

    const build_test = b.addTest(.{
        .root_source_file = b.path("build.zig"),
    });

    build_test.root_module.addAnonymousImport("uf2", .{
        .root_source_file = .{ .cwd_relative = uf2_dep.builder.pathFromRoot("build.zig") },
    });

    const install_docs = b.addInstallDirectory(.{
        .source_dir = build_test.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });

    b.getInstallStep().dependOn(&install_docs.step);
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
/// Creates a new MicroZig build environment that can be used to create new firmware.
pub fn init(b: *Build, opts: struct {
    dependency_name: []const u8 = "microzig/build",
}) *MicroZig {
    const mz_dep = b.dependency(opts.dependency_name, .{});
    const core_dep = mz_dep.builder.dependency("microzig/core", .{});
    const ret = b.allocator.create(MicroZig) catch @panic("OOM");
    ret.* =
        MicroZig{
        .host_build = b,
        .self = mz_dep,
        .microzig_core = core_dep,
        .generate_linkerscript = mz_dep.builder.addExecutable(.{
            .name = "generate-linkerscript",
            .root_source_file = .{ .cwd_relative = comptime root() ++ "/src/generate_linkerscript.zig" },
            .target = mz_dep.builder.host,
        }),
    };

    const defs_dep = mz_dep.builder.dependency("microzig/build/definitions", .{});
    ret.generate_linkerscript.root_module.addImport("microzig/build/definitions", defs_dep.module("definitions"));

    return ret;
}

pub fn add_firmware(
    /// The MicroZig instance that should be used to create the firmware.
    mz: *MicroZig,
    /// The instance of the `build.zig` that is calling this function.
    host_build: *Build,
    /// Options that define how the firmware is built.
    options: FirmwareOptions,
) *Firmware {
    const micro_build = mz.self.builder;

    const chip = &options.target.chip;
    const maybe_hal = options.hal orelse options.target.hal;
    const maybe_board = options.board orelse options.target.board;

    const linker_script = options.linker_script orelse options.target.linker_script;

    // TODO: let the user override which ram section to use the stack on,
    // for now just using the first ram section in the memory region list
    const first_ram = blk: {
        for (chip.memory_regions) |region| {
            if (region.kind == .ram)
                break :blk region;
        } else @panic("no ram memory region found for setting the end-of-stack address");
    };

    // On demand, generate chip definitions via regz:
    const chip_source = switch (chip.register_definition) {
        .json, .atdf, .svd => |file| blk: {
            const regz_exe = mz.dependency("microzig/tools/regz", .{ .optimize = .ReleaseSafe }).artifact("regz");

            const regz_gen = host_build.addRunArtifact(regz_exe);

            regz_gen.addArg("--schema"); // Explicitly set schema type, one of: svd, atdf, json
            regz_gen.addArg(@tagName(chip.register_definition));

            regz_gen.addArg("--output_path"); // Write to a file
            const zig_file = regz_gen.addOutputFileArg("chip.zig");

            regz_gen.addFileArg(file);

            break :blk zig_file;
        },

        .zig => |src| src,
    };

    const config = host_build.addOptions();
    config.addOption(bool, "has_hal", (maybe_hal != null));
    config.addOption(bool, "has_board", (maybe_board != null));

    config.addOption(?[]const u8, "board_name", if (maybe_board) |brd| brd.name else null);

    config.addOption([]const u8, "chip_name", chip.name);
    config.addOption([]const u8, "cpu_name", chip.cpu.name);
    config.addOption(usize, "end_of_stack", first_ram.offset + first_ram.length);

    const fw: *Firmware = host_build.allocator.create(Firmware) catch @panic("out of memory");
    fw.* = Firmware{
        .mz = mz,
        .host_build = host_build,
        .artifact = host_build.addExecutable(.{
            .name = options.name,
            .optimize = options.optimize,
            .target = mz.host_build.resolveTargetQuery(chip.cpu.target),
            .linkage = .static,
            .root_source_file = .{ .cwd_relative = mz.microzig_core.builder.pathFromRoot("src/start.zig") },
            .strip = options.strip,
        }),
        .target = options.target,
        .output_files = Firmware.OutputFileMap.init(host_build.allocator),
        .config = config,
        .modules = .{
            .microzig = micro_build.createModule(.{
                .root_source_file = .{ .cwd_relative = mz.microzig_core.builder.pathFromRoot("src/microzig.zig") },
                .imports = &.{
                    .{
                        .name = "config",
                        .module = micro_build.createModule(.{ .root_source_file = config.getSource() }),
                    },
                },
            }),
            .cpu = undefined,
            .chip = undefined,
            .board = null,
            .hal = null,
            .app = undefined,
        },
    };
    errdefer fw.output_files.deinit();

    fw.artifact.link_gc_sections = options.strip_unused_symbols;
    fw.artifact.link_function_sections = options.strip_unused_symbols;
    fw.artifact.link_data_sections = options.strip_unused_symbols;

    fw.modules.chip = micro_build.createModule(.{
        .root_source_file = chip_source,
        .imports = &.{
            .{ .name = "microzig", .module = fw.modules.microzig },
        },
    });
    fw.modules.microzig.addImport("chip", fw.modules.chip);

    fw.modules.cpu = micro_build.createModule(.{
        .root_source_file = chip.cpu.root_source_file,
        .imports = &.{
            .{ .name = "microzig", .module = fw.modules.microzig },
        },
    });
    fw.modules.microzig.addImport("cpu", fw.modules.cpu);

    if (maybe_hal) |hal| {
        fw.modules.hal = micro_build.createModule(.{
            .root_source_file = hal.root_source_file,
            .imports = &.{
                .{ .name = "microzig", .module = fw.modules.microzig },
            },
        });
        fw.modules.microzig.addImport("hal", fw.modules.hal.?);
    }

    if (maybe_board) |brd| {
        fw.modules.board = micro_build.createModule(.{
            .root_source_file = brd.root_source_file,
            .imports = &.{
                .{ .name = "microzig", .module = fw.modules.microzig },
            },
        });
        fw.modules.microzig.addImport("board", fw.modules.board.?);
    }

    fw.modules.app = host_build.createModule(.{
        .root_source_file = options.root_source_file,
        .imports = &.{
            .{ .name = "microzig", .module = fw.modules.microzig },
        },
    });

    //const umm = mz.microzig_core.builder.dependency("umm-zig", .{}).module("umm");
    //fw.modules.microzig.addImport("umm", umm);

    fw.artifact.root_module.addImport("app", fw.modules.app);
    fw.artifact.root_module.addImport("microzig", fw.modules.microzig);

    fw.artifact.bundle_compiler_rt = options.bundle_compiler_rt orelse fw.target.bundle_compiler_rt;

    if (linker_script) |ls| {
        fw.artifact.setLinkerScriptPath(ls);
    } else {
        const target = mz.host_build.resolveTargetQuery(chip.cpu.target);
        const generate_linkerscript_args = GenerateLinkerscriptArgs{
            .cpu_name = target.result.cpu.model.name,
            .cpu_arch = target.result.cpu.arch,
            .chip_name = chip.name,
            .memory_regions = chip.memory_regions,
        };

        const args_str = std.json.stringifyAlloc(
            mz.microzig_core.builder.allocator,
            generate_linkerscript_args,
            .{},
        ) catch @panic("OOM");

        const generate_linkerscript_run = mz.microzig_core.builder.addRunArtifact(mz.generate_linkerscript);
        generate_linkerscript_run.addArg(args_str);
        const linkerscript = generate_linkerscript_run.addOutputFileArg("linker.ld");

        // If not specified then generate the linker script
        fw.artifact.setLinkerScript(linkerscript);
    }

    if (options.target.configure) |configure| {
        configure(fw.mz, fw);
    }

    return fw;
}

const GenerateLinkerscriptArgs = @import("src/generate_linkerscript.zig").Args;

/// Adds a new dependency to the `install` step that will install the `firmware` into the folder `$prefix/firmware`.
pub fn install_firmware(
    /// The MicroZig instance that was used to create the firmware.
    mz: *MicroZig,
    /// The instance of the `build.zig` that should perform installation.
    b: *Build,
    /// The firmware that should be installed. Please make sure that this was created with the same `MicroZig` instance as `mz`.
    firmware: *Firmware,
    /// Optional configuration of the installation process. Pass `.{}` if you're not sure what to do here.
    options: InstallFirmwareOptions,
) void {
    std.debug.assert(mz == firmware.mz);
    const install_step = add_install_firmware(mz, b, firmware, options);
    b.getInstallStep().dependOn(&install_step.step);
}

/// Creates a new `std.Build.Step.InstallFile` instance that will install the given firmware to `$prefix/firmware`.
///
/// **NOTE:** This does not actually install the firmware yet. You have to add the returned step as a dependency to another step.
///           If you want to just install the firmware, use `installFirmware` instead!
pub fn add_install_firmware(
    /// The MicroZig instance that was used to create the firmware.
    mz: *MicroZig,
    /// The instance of the `build.zig` that should perform installation.
    b: *Build,
    /// The firmware that should be installed. Please make sure that this was created with the same `MicroZig` instance as `mz`.
    firmware: *Firmware,
    /// Optional configuration of the installation process. Pass `.{}` if you're not sure what to do here.
    options: InstallFirmwareOptions,
) *Build.Step.InstallFile {
    _ = mz;
    const format = firmware.resolve_format(options.format);

    const basename = b.fmt("{s}{s}", .{
        firmware.artifact.name,
        format.get_extension(),
    });

    return b.addInstallFileWithDir(firmware.get_emitted_bin(format), .{ .custom = "firmware" }, basename);
}

fn dependency(env: *MicroZig, name: []const u8, args: anytype) *Build.Dependency {
    return env.self.builder.dependency(name, args);
}

pub const cpus = core.cpus;

/// A compilation target for MicroZig. Provides information about the chip,
/// hal, board and so on.
///
/// This is used instead of `std.zig.CrossTarget` to define a MicroZig Firmware.
pub const Target = struct {
    /// The preferred binary format of this MicroZig target. If `null`, the user must
    /// explicitly give the `.format` field during a call to `getEmittedBin()` or installation steps.
    preferred_format: ?BinaryFormat,

    /// The chip this target uses,
    chip: Chip,

    /// Usually, embedded projects are single-threaded and single-core applications. Platforms that
    /// support multiple CPUs should set this to `false`.
    single_threaded: bool = true,

    /// Determines whether the compiler_rt package is bundled with the application or not.
    /// This should always be true except for platforms where compiler_rt cannot be built right now.
    bundle_compiler_rt: bool = true,

    /// (optional) Provides a default hardware abstraction layer that is used.
    /// If `null`, no `microzig.hal` will be available.
    hal: ?HardwareAbstractionLayer = null,

    /// (optional) Provides description of external hardware and connected devices
    /// like oscillators and such.
    ///
    /// This structure isn't used by MicroZig itself, but can be utilized from the HAL
    /// if present.
    board: ?BoardDefinition = null,

    /// (optional) Provide a custom linker script for the hardware or define a custom generation.
    linker_script: ?LazyPath = null,

    /// (optional) Further configures the created firmware depending on the chip and/or board settings.
    /// This can be used to set/change additional properties on the created `*Firmware` object.
    configure: ?*const fn (env: *MicroZig, *Firmware) void = null,

    /// (optional) Post processing step that will patch up and modify the elf file if necessary.
    binary_post_process: ?*const fn (host_build: *std.Build, LazyPath) std.Build.LazyPath = null,
};

/// Options to the `add_firmware` function.
pub const FirmwareOptions = struct {
    /// The name of the firmware file.
    name: []const u8,

    /// The MicroZig target that the firmware is built for. Either a board or a chip.
    target: Target,

    /// The optimization level that should be used. Usually `ReleaseSmall` or `Debug` is a good choice.
    /// Also using `std.Build.standardOptimizeOption` is a good idea.
    optimize: std.builtin.OptimizeMode,

    /// The root source file for the application. This is your `src/main.zig` file.
    root_source_file: LazyPath,

    // Overrides:

    /// If set, overrides the `single_threaded` property of the target.
    single_threaded: ?bool = null,

    /// If set, overrides the `bundle_compiler_rt` property of the target.
    bundle_compiler_rt: ?bool = null,

    /// If set, overrides the `hal` property of the target.
    hal: ?HardwareAbstractionLayer = null,

    /// If set, overrides the `board` property of the target.
    board: ?BoardDefinition = null,

    /// If set, overrides the `linker_script` property of the target.
    linker_script: ?LazyPath = null,

    /// Strips stack trace info from final executable.
    strip: bool = false,

    /// Enables the following build options for the firmware executable
    /// to support stripping unused symbols in all modes (not just Release):
    ///     exe.link_gc_sections = true;
    ///     exe.link_data_sections = true;
    ///     exe.link_function_sections = true;
    strip_unused_symbols: bool = true,
};

/// Configuration options for firmware installation.
pub const InstallFirmwareOptions = struct {
    /// Overrides the output format for the binary. If not set, the standard preferred file format for the firmware target is used.
    format: ?BinaryFormat = null,
};

/// Declaration of a firmware build.
pub const Firmware = struct {
    const OutputFileMap = std.ArrayHashMap(BinaryFormat, LazyPath, BinaryFormat.Context, false);

    const Modules = struct {
        app: *std.Build.Module,
        cpu: *std.Build.Module,
        chip: *std.Build.Module,
        board: ?*std.Build.Module,
        hal: ?*std.Build.Module,
        microzig: *std.Build.Module,
    };

    // privates:
    mz: *MicroZig,
    host_build: *std.Build,
    target: Target,
    output_files: OutputFileMap,

    // publics:

    /// The artifact that is built by Zig.
    artifact: *std.Build.Step.Compile,

    /// The options step that provides `microzig.config`. If you need custom configuration, you can add this here.
    config: *std.Build.Step.Options,

    /// Declaration of the MicroZig modules used by this firmware.
    modules: Modules,

    /// Path to the emitted elf file, if any.
    emitted_elf: ?LazyPath = null,

    /// Returns the emitted ELF file for this firmware. This is useful if you need debug information
    /// or want to use a debugger like Segger, ST-Link or similar.
    ///
    /// **NOTE:** This is similar, but not equivalent to `std.Build.Step.Compile.getEmittedBin`. The call on the compile step does
    ///           not include post processing of the ELF files necessary by certain targets.
    pub fn get_emitted_elf(firmware: *Firmware) LazyPath {
        if (firmware.emitted_elf == null) {
            const raw_elf = firmware.artifact.getEmittedBin();
            firmware.emitted_elf = if (firmware.target.binary_post_process) |binary_post_process|
                binary_post_process(firmware.host_build, raw_elf)
            else
                raw_elf;
        }
        return firmware.emitted_elf.?;
    }

    /// Returns the emitted binary for this firmware. The file is either in the preferred file format for
    /// the target or in `format` if not null.
    ///
    /// **NOTE:** The file returned here is the same file that will be installed.
    pub fn get_emitted_bin(firmware: *Firmware, format: ?BinaryFormat) LazyPath {
        const actual_format = firmware.resolve_format(format);

        const gop = firmware.output_files.getOrPut(actual_format) catch @panic("out of memory");
        if (!gop.found_existing) {
            const elf_file = firmware.get_emitted_elf();

            const basename = firmware.host_build.fmt("{s}{s}", .{
                firmware.artifact.name,
                actual_format.get_extension(),
            });

            gop.value_ptr.* = switch (actual_format) {
                .elf => elf_file,

                .bin => blk: {
                    const objcopy = firmware.host_build.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .bin,
                    });

                    break :blk objcopy.getOutput();
                },

                .hex => blk: {
                    const objcopy = firmware.host_build.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .hex,
                    });

                    break :blk objcopy.getOutput();
                },

                .uf2 => |family_id| blk: {
                    const uf2_exe = firmware.mz.dependency("microzig/tools/uf2", .{ .optimize = .ReleaseSafe }).artifact("elf2uf2");

                    const convert = firmware.host_build.addRunArtifact(uf2_exe);

                    convert.addArg("--family-id");
                    convert.addArg(firmware.host_build.fmt("0x{X:0>4}", .{@intFromEnum(family_id)}));

                    convert.addArg("--elf-path");
                    convert.addFileArg(elf_file);

                    convert.addArg("--output-path");
                    break :blk convert.addOutputFileArg(basename);
                },

                .dfu => build_config_error(firmware.host_build, "DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!", .{}),
                .esp => build_config_error(firmware.host_build, "ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!", .{}),

                .custom => |generator| generator.convert(generator, elf_file),
            };
        }
        return gop.value_ptr.*;
    }

    pub const AppDependencyOptions = struct {
        depend_on_microzig: bool = false,
    };

    /// Adds a regular dependency to your application.
    pub fn add_app_import(fw: *Firmware, name: []const u8, module: *std.Build.Module, options: AppDependencyOptions) void {
        if (options.depend_on_microzig) {
            module.addImport("microzig", fw.modules.microzig);
        }
        fw.modules.app.addImport(name, module);
    }

    pub fn add_include_path(fw: *Firmware, path: LazyPath) void {
        fw.artifact.addIncludePath(path);
    }

    pub fn add_system_include_path(fw: *Firmware, path: LazyPath) void {
        fw.artifact.addSystemIncludePath(path);
    }

    pub fn add_c_source_file(fw: *Firmware, source: std.Build.Step.Compile.CSourceFile) void {
        fw.artifact.addCSourceFile(source);
    }

    pub fn add_options(fw: *Firmware, module_name: []const u8, options: *std.Build.Step.Options) void {
        fw.modules.app.addOptions(module_name, options);
    }

    pub fn add_object_file(fw: *Firmware, source: LazyPath) void {
        fw.artifact.addObjectFile(source);
    }

    fn resolve_format(firmware: *Firmware, format: ?BinaryFormat) BinaryFormat {
        if (format) |fmt| return fmt;

        if (firmware.target.preferred_format) |fmt| return fmt;

        build_config_error(firmware.host_build, "{s} has no preferred output format, please provide one in the `format` option.", .{
            firmware.target.chip.name,
        });
    }
};

fn build_config_error(b: *std.Build, comptime fmt: []const u8, args: anytype) noreturn {
    const msg = b.fmt(fmt, args);
    @panic(msg);
}

/// The resulting binary format for the firmware file.
/// A lot of embedded systems don't use plain ELF files, thus we provide means
/// to convert the resulting ELF into other common formats.
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

    /// Custom option for non-standard formats.
    custom: *Custom,

    /// Returns the standard extension for the resulting binary file.
    pub fn get_extension(format: BinaryFormat) []const u8 {
        return switch (format) {
            .elf => ".elf",
            .bin => ".bin",
            .hex => ".hex",
            .dfu => ".dfu",
            .uf2 => ".uf2",
            .esp => ".bin",

            .custom => |c| c.extension,
        };
    }

    pub const Custom = struct {
        /// The standard extension of the format.
        extension: []const u8,

        /// A function that will convert a given `elf` file into the custom output format.
        ///
        /// The `*Custom` format is passed so contextual information can be obtained by using
        /// `@fieldParentPtr` to provide access to tooling.
        convert: *const fn (*Custom, elf: Build.LazyPath) Build.LazyPath,
    };

    const Enum = std.meta.Tag(BinaryFormat);

    pub const Context = struct {
        pub fn hash(self: @This(), fmt: BinaryFormat) u32 {
            _ = self;

            var hasher = std.hash.XxHash32.init(0x1337_42_21);

            hasher.update(@tagName(fmt));

            switch (fmt) {
                .elf, .bin, .hex, .dfu, .esp => |val| {
                    if (@TypeOf(val) != void) @compileError("Missing update: Context.hash now requires special care!");
                },

                .uf2 => |family_id| hasher.update(@tagName(family_id)),
                .custom => |custom| hasher.update(std.mem.asBytes(custom)),
            }

            return hasher.final();
        }

        pub fn eql(self: @This(), fmt_a: BinaryFormat, fmt_b: BinaryFormat, index: usize) bool {
            _ = self;
            _ = index;
            if (@as(BinaryFormat.Enum, fmt_a) != @as(BinaryFormat.Enum, fmt_b))
                return false;

            return switch (fmt_a) {
                .elf, .bin, .hex, .dfu, .esp => |val| {
                    if (@TypeOf(val) != void) @compileError("Missing update: Context.eql now requires special care!");
                    return true;
                },

                .uf2 => |a| (a == fmt_b.uf2),
                .custom => |a| (a == fmt_b.custom),
            };
        }
    };
};
