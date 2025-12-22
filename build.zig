const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const assert = std.debug.assert;

const internals = @import("build-internals");
pub const Target = internals.Target;
pub const Cpu = internals.Cpu;
pub const Chip = internals.Chip;
pub const HardwareAbstractionLayer = internals.HardwareAbstractionLayer;
pub const Board = internals.Board;
pub const BinaryFormat = internals.BinaryFormat;
pub const LinkerScript = internals.LinkerScript;
pub const Stack = internals.Stack;
pub const MemoryRegion = internals.MemoryRegion;

const regz = @import("tools/regz");

// If more ports are available, the error "error: evaluation exceeded 1000 backwards branches" may occur.
// In such cases, consider increasing the argument value for @setEvalBranchQuota().
const port_list: []const struct {
    name: [:0]const u8,
    dep_name: [:0]const u8,
} = &.{
    .{ .name = "esp", .dep_name = "port/espressif/esp" },
    .{ .name = "gd32", .dep_name = "port/gigadevice/gd32" },
    .{ .name = "atsam", .dep_name = "port/microchip/atsam" },
    .{ .name = "avr", .dep_name = "port/microchip/avr" },
    .{ .name = "nrf5x", .dep_name = "port/nordic/nrf5x" },
    .{ .name = "lpc", .dep_name = "port/nxp/lpc" },
    .{ .name = "mcx", .dep_name = "port/nxp/mcx" },
    .{ .name = "rp2xxx", .dep_name = "port/raspberrypi/rp2xxx" },
    .{ .name = "stm32", .dep_name = "port/stmicro/stm32" },
    .{ .name = "ch32v", .dep_name = "port/wch/ch32v" },
};

const exe_targets: []const std.Target.Query = &.{
    .{ .cpu_arch = .aarch64, .os_tag = .macos },
    .{ .cpu_arch = .aarch64, .os_tag = .linux },
    .{ .cpu_arch = .aarch64, .os_tag = .windows },
    .{ .cpu_arch = .x86_64, .os_tag = .macos },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
    .{ .cpu_arch = .x86_64, .os_tag = .windows },
};

pub fn build(b: *Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const generate_linker_script_mod = b.createModule(.{
        .root_source_file = b.path("tools/generate_linker_script.zig"),
        .target = b.graph.host,
        .optimize = optimize,
    });

    const generate_linker_script_exe = b.addExecutable(.{
        .name = "generate_linker_script",
        .root_module = generate_linker_script_mod,
    });

    generate_linker_script_exe.root_module.addImport(
        "build-internals",
        b.dependency("build-internals", .{}).module("build-internals"),
    );

    b.installArtifact(generate_linker_script_exe);

    const boxzer_dep = b.dependency("boxzer", .{});
    const boxzer_exe = boxzer_dep.artifact("boxzer");
    const boxzer_run = b.addRunArtifact(boxzer_exe);
    if (b.args) |args|
        boxzer_run.addArgs(args);

    const package_step = b.step("package", "Package monorepo using boxzer");
    package_step.dependOn(&boxzer_run.step);

    generate_release_steps(b);
}

fn generate_release_steps(b: *Build) void {
    const release_regz_step = b.step("release-regz", "Generate the release binaries for regz");
    const release_uf2_step = b.step("release-uf2", "Generate the release binaries for uf2");
    const release_esp_image_step = b.step("release-esp-image", "Generate the release binaries for esp image");

    for (exe_targets) |t| {
        const release_target = b.resolveTargetQuery(t);

        const regz_dep = b.dependency("tools/regz", .{
            .optimize = .ReleaseSafe,
            .target = release_target,
        });

        const regz_artifact = regz_dep.artifact("regz");
        const regz_target_output = b.addInstallArtifact(regz_artifact, .{
            .dest_dir = .{
                .override = .{
                    .custom = t.zigTriple(b.allocator) catch unreachable,
                },
            },
        });
        release_regz_step.dependOn(&regz_target_output.step);
    }

    for (exe_targets) |t| {
        const release_target = b.resolveTargetQuery(t);

        const uf2_dep = b.dependency("tools/uf2", .{
            .optimize = .ReleaseSafe,
            .target = release_target,
        });

        const uf2_artifact = uf2_dep.artifact("elf2uf2");
        const uf2_target_output = b.addInstallArtifact(uf2_artifact, .{
            .dest_dir = .{
                .override = .{
                    .custom = t.zigTriple(b.allocator) catch unreachable,
                },
            },
        });
        release_uf2_step.dependOn(&uf2_target_output.step);
    }

    for (exe_targets) |t| {
        const release_target = b.resolveTargetQuery(t);

        const esp_image_dep = b.dependency("tools/esp-image", .{
            .optimize = .ReleaseSafe,
            .target = release_target,
        });

        const elf2image_artifact = esp_image_dep.artifact("elf2image");
        const elf2image_target_output = b.addInstallArtifact(elf2image_artifact, .{
            .dest_dir = .{
                .override = .{
                    .custom = t.zigTriple(b.allocator) catch unreachable,
                },
            },
        });
        release_esp_image_step.dependOn(&elf2image_target_output.step);
    }
}

pub const PortSelect = struct {
    esp: bool = false,
    gd32: bool = false,
    atsam: bool = false,
    avr: bool = false,
    nrf5x: bool = false,
    lpc: bool = false,
    mcx: bool = false,
    rp2xxx: bool = false,
    stm32: bool = false,
    ch32v: bool = false,

    pub const all: PortSelect = blk: {
        var ret: PortSelect = undefined;
        for (@typeInfo(PortSelect).@"struct".fields) |field| {
            @field(ret, field.name) = true;
        }

        break :blk ret;
    };

    comptime {
        // assumes fields are in the same order as the port list
        for (port_list, @typeInfo(PortSelect).@"struct".fields) |port_entry, field| {
            assert(std.mem.eql(u8, port_entry.name, field.name));
            const default_value_ptr: *const bool = @ptrCast(field.default_value_ptr);
            assert(false == default_value_ptr.*);
        }
    }
};

// Don't know if this is required but it doesn't hurt either.
// Helps in case there are multiple microzig instances including the same ports (eg: examples).
pub const PortCache = blk: {
    var fields: []const std.builtin.Type.StructField = &.{};
    for (port_list) |port| {
        const typ = ?(custom_lazy_import(port.dep_name) orelse struct {});
        fields = fields ++ [_]std.builtin.Type.StructField{.{
            .name = port.name,
            .type = typ,
            .default_value_ptr = @as(*const anyopaque, @ptrCast(&@as(typ, null))),
            .is_comptime = false,
            .alignment = @alignOf(typ),
        }};
    }
    break :blk @Type(.{
        .@"struct" = .{
            .layout = .auto,
            .fields = fields,
            .decls = &.{},
            .is_tuple = false,
        },
    });
};

var port_cache: PortCache = .{};

/// The MicroZig build system.
///
/// # Example usage:
/// ```zig
/// const std = @import("std");
/// const microzig = @import("microzig");
///
/// const MicroBuild = microzig.MicroBuild(.{
///     .rp2xxx = true,
/// });
///
/// pub fn build(b: *std.Build) void {
///     const optimize = b.standardOptimizeOption(.{});
///
///     const mz_dep = b.dependency("microzig", .{});
///     const mb = MicroBuild.init(b, mz_dep) orelse return;
///
///     const fw = mb.add_firmware(.{
///         .name = "test",
///         .root_source_file = b.path("src/main.zig"),
///         .target = mb.ports.rp2xxx.boards.raspberrypi.pico,
///         .optimize = optimize,
///     });
///     mb.install_firmware(fw, .{});
/// }
/// ```
pub fn MicroBuild(port_select: PortSelect) type {
    return struct {
        builder: *Build,
        dep: *Build.Dependency,
        core_dep: *Build.Dependency,
        drivers_dep: *Build.Dependency,

        /// Contains all the ports you selected.
        ports: SelectedPorts,

        const Self = @This();

        const SelectedPorts = blk: {
            var fields: []const std.builtin.Type.StructField = &.{};

            for (port_list) |port| {
                if (@field(port_select, port.name)) {
                    const typ = custom_lazy_import(port.dep_name) orelse struct {};
                    fields = fields ++ [_]std.builtin.Type.StructField{.{
                        .name = port.name,
                        .type = typ,
                        .default_value_ptr = null,
                        .is_comptime = false,
                        .alignment = @alignOf(typ),
                    }};
                }
            }

            break :blk @Type(.{
                .@"struct" = .{
                    .layout = .auto,
                    .fields = fields,
                    .decls = &.{},
                    .is_tuple = false,
                },
            });
        };

        const InitReturnType = blk: {
            @setEvalBranchQuota(5000);

            var ok = true;
            for (port_list) |port| {
                if (@field(port_select, port.name)) {
                    ok = ok and custom_lazy_import(port.dep_name) != null;
                }
            }
            if (ok) {
                break :blk *Self;
            } else {
                break :blk noreturn;
            }
        };

        /// Initializes the microzig build system. Returns null when there are ports
        /// that haven't been fetched yet (it uses lazy dependencies internally).
        pub fn init(b: *Build, dep: *Build.Dependency) ?InitReturnType {
            if (InitReturnType == noreturn) {
                inline for (port_list) |port| {
                    if (@field(port_select, port.name)) {
                        _ = dep.builder.lazyDependency(port.dep_name, .{});
                    }
                }
                return null;
            }

            var ports: SelectedPorts = undefined;
            inline for (port_list) |port| {
                if (@field(port_select, port.name)) {
                    @field(ports, port.name) = if (@field(port_cache, port.name)) |cached_port| cached_port else blk: {
                        const port_dep = dep.builder.lazyDependency(port.dep_name, .{}).?;
                        const instance = custom_lazy_import(port.dep_name).?.init(port_dep);
                        @field(port_cache, port.name) = instance;
                        break :blk instance;
                    };
                }
            }

            const mb = b.allocator.create(Self) catch @panic("out of memory");
            mb.* = .{
                .builder = b,
                .dep = dep,
                .core_dep = dep.builder.dependency("core", .{}),
                .drivers_dep = dep.builder.dependency("drivers", .{}),
                .ports = ports,
            };
            return mb;
        }

        /// Configuration options for the `add_firmware` function.
        pub const CreateFirmwareOptions = struct {
            /// The name of the firmware file.
            name: []const u8,

            /// The MicroZig target that the firmware is built for. Either a board or a chip.
            target: *const Target,

            /// The optimization level that should be used. Usually `ReleaseSmall` or `Debug` is a good choice.
            /// Also using `std.Build.standardOptimizeOption` is a good idea.
            optimize: std.builtin.OptimizeMode,

            /// The root source file for the application. This is your `src/main.zig` file.
            root_source_file: LazyPath,

            /// Imports for the application.
            imports: []const Build.Module.Import = &.{},

            /// If set, overrides the `single_threaded` property of the target.
            single_threaded: ?bool = null,

            /// If set, overrides the `bundle_compiler_rt` property of the target.
            bundle_compiler_rt: ?bool = null,

            /// If set, overrides the `zig_target` property of the target.
            zig_target: ?std.Target.Query = null,

            /// If set, overrides the `cpu` property of the target.
            cpu: ?Cpu = null,

            /// If set, overrides the `hal` property of the target.
            hal: ?HardwareAbstractionLayer = null,

            /// If set, overrides the `board` property of the target.
            board: ?Board = null,

            /// If set, overrides the `linker_script` property of the target.
            linker_script: ?LinkerScript = null,

            /// If set, overrides the `stack` property of the target.
            stack: ?Stack = null,

            /// If set, overrides the default `entry` property of the arget.
            entry: ?Build.Step.Compile.Entry = null,

            /// Strips stack trace info from final executable.
            strip: bool = false,

            /// Enables the following build options for the firmware executable
            /// to support stripping unused symbols in all modes (not just Release):
            ///     exe.link_gc_sections = true;
            ///     exe.link_data_sections = true;
            ///     exe.link_function_sections = true;
            strip_unused_symbols: bool = true,

            /// Unwind tables option for the firmware executable.
            unwind_tables: ?std.builtin.UnwindTables = null,

            /// Error tracing option for the firmware executable.
            error_tracing: ?bool = null,

            /// Dwarf format option for the firmware executable.
            dwarf_format: ?std.dwarf.Format = null,

            /// Additional patches the user may apply to the generated register
            /// code. This does not override the chip's existing patches.
            patches: []const regz.patch.Patch = &.{},
        };

        fn serialize_patches(b: *Build, patches: []const regz.patch.Patch) []const u8 {
            var buf: std.Io.Writer.Allocating = .init(b.allocator);

            for (patches) |patch| {
                buf.writer.print("{f}", .{std.json.fmt(patch, .{})}) catch @panic("OOM");
                buf.writer.writeByte('\n') catch @panic("OOM");
            }

            return buf.toOwnedSlice() catch @panic("OOM");
        }

        /// Creates a new firmware for a given target.
        pub fn add_firmware(mb: *Self, options: CreateFirmwareOptions) *Firmware {
            const b = mb.dep.builder;

            const target = options.target;

            // validate that tagged memory regions meet the requirements
            for (target.chip.memory_regions) |region| {
                region.validate_tag();
            }

            // TODO: use unions when they are supported in the build system
            const EndOfStack = struct {
                address: ?usize = null,
                symbol_name: ?[]const u8 = null,
            };

            const end_of_stack: EndOfStack = switch (options.stack orelse options.target.stack) {
                .address => |address| .{ .address = address },
                .ram_region_index => |index| blk: {
                    var i: usize = 0;
                    for (target.chip.memory_regions) |region| {
                        if (region.tag == .ram) {
                            if (i == index)
                                break :blk .{ .address = region.offset + region.length };
                            i += 1;
                        }
                    } else @panic("no ram memory region found for setting the end-of-stack address");
                },
                .symbol_name => |name| .{ .symbol_name = name },
            };

            const zig_resolved_target = b.resolveTargetQuery(options.zig_target orelse target.zig_target);

            const cpu = options.cpu orelse target.cpu orelse mb.get_default_cpu(zig_resolved_target.result);
            const maybe_hal = options.hal orelse target.hal;
            const maybe_board = options.board orelse target.board;

            const config = b.addOptions();
            config.addOption(bool, "has_hal", maybe_hal != null);
            config.addOption(bool, "has_board", maybe_board != null);

            config.addOption([]const u8, "cpu_name", cpu.name);
            config.addOption([]const u8, "chip_name", target.chip.name);
            config.addOption(?[]const u8, "board_name", if (maybe_board) |board| board.name else null);
            config.addOption(EndOfStack, "end_of_stack", end_of_stack);
            config.addOption(bool, "ram_image", target.ram_image);

            const core_mod = b.createModule(.{
                .root_source_file = mb.core_dep.path("src/microzig.zig"),
                .imports = &.{
                    .{
                        .name = "config",
                        .module = config.createModule(),
                    },
                    .{
                        .name = "drivers",
                        .module = mb.drivers_dep.module("drivers"),
                    },
                },
            });

            const cpu_mod = b.createModule(.{
                .root_source_file = cpu.root_source_file,
                .imports = cpu.imports,
            });
            cpu_mod.addImport("microzig", core_mod);
            core_mod.addImport("cpu", cpu_mod);

            const regz_exe = b.dependency("tools/regz", .{ .optimize = .ReleaseSafe }).artifact("regz");
            const chip_source = switch (target.chip.register_definition) {
                .atdf, .svd => |file| blk: {
                    const regz_run = b.addRunArtifact(regz_exe);

                    regz_run.addArg("--format");
                    regz_run.addArg(@tagName(target.chip.register_definition));

                    regz_run.addArg("--output_path"); // Write to a file

                    const chips_dir = regz_run.addOutputDirectoryArg("chips");
                    var patches: std.array_list.Managed(regz.patch.Patch) = .init(b.allocator);

                    // From chip definition
                    patches.appendSlice(target.chip.patches) catch @panic("OOM");

                    // From user invoking `add_firmware`
                    patches.appendSlice(options.patches) catch @panic("OOM");

                    if (patches.items.len > 0) {
                        // write patches to file
                        const patch_ndjson = serialize_patches(b, patches.items);
                        const write_file_step = b.addWriteFiles();
                        const patch_file = write_file_step.add("patch.ndjson", patch_ndjson);

                        regz_run.addArg("--patch_path");
                        regz_run.addFileArg(patch_file);
                    }

                    regz_run.addFileArg(file);
                    break :blk chips_dir.path(b, b.fmt("{s}.zig", .{target.chip.name}));
                },
                .embassy => |path| blk: {
                    const regz_run = b.addRunArtifact(regz_exe);

                    regz_run.addArg("--format");
                    regz_run.addArg(@tagName(target.chip.register_definition));

                    regz_run.addArg("--output_path"); // Write to a file

                    const chips_dir = regz_run.addOutputDirectoryArg("chips");
                    var patches: std.array_list.Managed(regz.patch.Patch) = .init(b.allocator);

                    // From chip definition
                    patches.appendSlice(target.chip.patches) catch @panic("OOM");

                    // From user invoking `add_firmware`
                    patches.appendSlice(options.patches) catch @panic("OOM");

                    if (patches.items.len > 0) {
                        // write patches to file
                        const patch_ndjson = serialize_patches(b, patches.items);
                        const write_file_step = b.addWriteFiles();
                        const patch_file = write_file_step.add("patch.ndjson", patch_ndjson);

                        regz_run.addArg("--patch_path");
                        regz_run.addFileArg(patch_file);
                    }

                    regz_run.addDirectoryArg(path);
                    break :blk chips_dir.path(b, b.fmt("{s}.zig", .{target.chip.name}));
                },

                .zig => |src| src,
            };
            const chip_mod = b.createModule(.{
                .root_source_file = chip_source,
            });

            chip_mod.addImport("microzig", core_mod);
            core_mod.addImport("chip", chip_mod);

            if (maybe_hal) |hal| {
                const hal_mod = b.createModule(.{
                    .root_source_file = hal.root_source_file,
                    .imports = hal.imports,
                });
                hal_mod.addImport("microzig", core_mod);
                core_mod.addImport("hal", hal_mod);
            }

            if (maybe_board) |board| {
                const board_mod = b.createModule(.{
                    .root_source_file = board.root_source_file,
                    .imports = board.imports,
                });
                board_mod.addImport("microzig", core_mod);
                core_mod.addImport("board", board_mod);
            }

            const app_mod = mb.builder.createModule(.{
                .root_source_file = options.root_source_file,
                .imports = options.imports,
                .target = zig_resolved_target,
            });
            app_mod.addImport("microzig", core_mod);
            core_mod.addImport("app", app_mod);

            const fw = mb.builder.allocator.create(Firmware) catch @panic("out of memory");
            fw.* = .{
                .mb = mb,
                .core_mod = core_mod,
                .artifact = mb.builder.addExecutable(.{
                    .name = options.name,
                    .root_module = b.createModule(.{
                        .optimize = options.optimize,
                        .target = zig_resolved_target,
                        .root_source_file = mb.core_dep.path("src/start.zig"),
                        .single_threaded = options.single_threaded orelse target.single_threaded,
                        .strip = options.strip,
                        .unwind_tables = options.unwind_tables,
                        .error_tracing = options.error_tracing,
                        .dwarf_format = options.dwarf_format,
                    }),
                    .linkage = .static,
                }),
                .app_mod = app_mod,
                .target = target,
                .emitted_files = Firmware.EmittedFiles.init(mb.builder.allocator),
            };

            fw.artifact.bundle_compiler_rt = options.bundle_compiler_rt orelse target.bundle_compiler_rt;

            fw.artifact.link_gc_sections = options.strip_unused_symbols;
            fw.artifact.link_function_sections = options.strip_unused_symbols;
            fw.artifact.link_data_sections = options.strip_unused_symbols;
            fw.artifact.entry = options.entry orelse target.entry orelse .default;

            fw.artifact.root_module.addImport("microzig", core_mod);
            fw.artifact.root_module.addImport("app", app_mod);

            const linker_script_options = options.linker_script orelse target.linker_script;
            const linker_script = blk: {
                const GenerateLinkerScriptArgs = @import("tools/generate_linker_script.zig").Args;

                if (linker_script_options.file == null and linker_script_options.generate != .memory_regions_and_sections) {
                    @panic("linker script: no file provided and no sections are auto-generated");
                }

                const generate_linker_script_exe = mb.dep.artifact("generate_linker_script");

                const generate_linker_script_args: GenerateLinkerScriptArgs = .{
                    .cpu_name = cpu.name,
                    .cpu_arch = zig_resolved_target.result.cpu.arch,
                    .chip_name = target.chip.name,
                    .memory_regions = target.chip.memory_regions,
                    .generate = linker_script_options.generate,
                    .ram_image = target.ram_image,
                };

                const args_str = std.json.Stringify.valueAlloc(
                    b.allocator,
                    generate_linker_script_args,
                    .{},
                ) catch @panic("out of memory");

                const generate_linker_script_run = b.addRunArtifact(generate_linker_script_exe);
                generate_linker_script_run.addArg(args_str);
                const output = generate_linker_script_run.addOutputFileArg("linker.ld");
                if (linker_script_options.file) |file| {
                    generate_linker_script_run.addFileArg(file);
                }
                break :blk output;
            };
            fw.artifact.setLinkerScript(linker_script);

            return fw;
        }

        /// Configuration options for firmware installation.
        pub const InstallFirmwareOptions = struct {
            format: ?BinaryFormat = null,
        };

        /// Adds a new dependency to the `install` step that will install the `firmware` into the folder `$prefix/firmware`.
        pub fn install_firmware(mb: *Self, fw: *Firmware, options: InstallFirmwareOptions) void {
            std.debug.assert(mb == fw.mb);

            const install_step = add_install_firmware(mb, fw, options);
            mb.builder.getInstallStep().dependOn(&install_step.step);
        }

        /// Creates a new `std.Build.Step.InstallFile` instance that will install the given firmware to `$prefix/firmware`.
        ///
        /// **NOTE:** This does not actually install the firmware yet. You have to add the returned step as a dependency to another step.
        ///           If you want to just install the firmware, use `installFirmware` instead!
        pub fn add_install_firmware(mb: *Self, fw: *Firmware, options: InstallFirmwareOptions) *Build.Step.InstallFile {
            std.debug.assert(mb == fw.mb);

            const format = options.format orelse fw.target.preferred_binary_format orelse .elf;

            const basename = mb.builder.fmt("{s}{s}", .{
                fw.artifact.name,
                format.get_extension(),
            });

            return mb.builder.addInstallFileWithDir(fw.get_emitted_bin(format), .{ .custom = "firmware" }, basename);
        }

        /// Declaration of a firmware build.
        pub const Firmware = struct {
            pub const EmittedFiles = std.AutoHashMap(BinaryFormat, LazyPath);

            mb: *Self,

            /// The artifact that is built by MicroZig.
            artifact: *Build.Step.Compile,

            /// The app module that is built by Zig.
            app_mod: *Build.Module,

            // The @import("microzig") module
            core_mod: *Build.Module,

            /// The target to which the firmware is built.
            target: *const Target,

            emitted_elf: ?LazyPath = null,
            emitted_files: EmittedFiles,
            emitted_docs: ?LazyPath = null,

            /// Returns the emitted ELF file for this firmware. This is useful if you need debug information
            /// or want to use a debugger like Segger, ST-Link or similar.
            ///
            /// **NOTE:** This is similar, but not equivalent to `std.Build.Step.Compile.getEmittedBin`. The call on the compile step does
            ///           not include post processing of the ELF files necessary by certain targets.
            pub fn get_emitted_elf(fw: *Firmware) LazyPath {
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
            pub fn get_emitted_bin(fw: *Firmware, format: ?BinaryFormat) LazyPath {
                const resolved_format = format orelse fw.target.preferred_binary_format orelse .elf;

                const result = fw.emitted_files.getOrPut(resolved_format) catch @panic("out of memory");
                if (!result.found_existing) {
                    const elf_file = fw.get_emitted_elf();

                    const basename = fw.mb.builder.fmt("{s}{s}", .{
                        fw.artifact.name,
                        resolved_format.get_extension(),
                    });

                    result.value_ptr.* = switch (resolved_format) {
                        .elf => elf_file,

                        .bin => blk: {
                            const objcopy = fw.mb.builder.addObjCopy(elf_file, .{
                                .basename = basename,
                                .format = .bin,
                            });

                            break :blk objcopy.getOutput();
                        },

                        .hex => blk: {
                            const objcopy = fw.mb.builder.addObjCopy(elf_file, .{
                                .basename = basename,
                                .format = .hex,
                            });

                            break :blk objcopy.getOutput();
                        },

                        .uf2 => |options| @import("tools/uf2").from_elf(
                            fw.mb.dep.builder.dependency("tools/uf2", .{
                                .optimize = .ReleaseSafe,
                            }),
                            elf_file,
                            options,
                        ),

                        .dfu => @panic("DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!"),

                        .esp => |options| @import("tools/esp-image").from_elf(
                            fw.mb.dep.builder.dependency("tools/esp-image", .{
                                .optimize = .ReleaseSafe,
                            }),
                            elf_file,
                            options,
                        ),

                        .custom => |generator| generator.convert(fw.target.dep, elf_file),
                    };
                }

                return result.value_ptr.*;
            }

            /// Returns the emitted docs folder for this firmware.
            ///
            /// Example usage:
            /// ```zig
            /// const install_docs = b.addInstallDirectory(.{
            ///     .source_dir = fw.get_emitted_docs(),
            ///     .install_dir = .prefix,
            ///     .install_subdir = "docs",
            /// });
            ///
            /// const install_docs_step = b.step("docs", "Install documentation.");
            /// install_docs_step.dependOn(&install_docs.step);
            /// ```
            pub fn get_emitted_docs(fw: *Firmware) LazyPath {
                if (fw.emitted_docs == null) {
                    const docs_test = fw.mb.builder.addTest(.{
                        .name = fw.artifact.name,
                        .root_module = fw.app_mod,
                    });

                    fw.emitted_docs = docs_test.getEmittedDocs();
                }
                return fw.emitted_docs.?;
            }

            /// Configuration options for the `add_app_import` function.
            pub const AppDependencyOptions = struct {
                depend_on_microzig: bool = false,
            };

            /// Adds an import to your application.
            pub fn add_app_import(fw: *Firmware, name: []const u8, module: *Build.Module, options: AppDependencyOptions) void {
                if (options.depend_on_microzig) {
                    module.addImport("microzig", fw.core_mod);
                }
                fw.app_mod.addImport(name, module);
            }

            /// Adds an include path to the firmware.
            pub fn add_include_path(fw: *Firmware, path: LazyPath) void {
                fw.artifact.addIncludePath(path);
            }

            /// Adds a system include path to the firmware.
            pub fn add_system_include_path(fw: *Firmware, path: LazyPath) void {
                fw.artifact.addSystemIncludePath(path);
            }

            /// Adds a c source file to the firmware.
            pub fn add_c_source_file(fw: *Firmware, source: Build.Module.CSourceFile) void {
                fw.artifact.addCSourceFile(source);
            }

            /// Adds options to your application.
            pub fn add_options(fw: *Firmware, module_name: []const u8, options: *Build.Step.Options) void {
                fw.app_mod.addOptions(module_name, options);
            }

            /// Adds an object file to the firmware.
            pub fn add_object_file(fw: *Firmware, source: LazyPath) void {
                fw.artifact.addObjectFile(source);
            }
        };

        fn get_default_cpu(mb: *Self, target: std.Target) Cpu {
            if (std.mem.eql(u8, target.cpu.model.name, "avr5")) {
                return .{
                    .name = "avr5",
                    .root_source_file = mb.core_dep.namedLazyPath("cpu_avr5"),
                };
            } else if (std.mem.startsWith(u8, target.cpu.model.name, "cortex_m")) {
                return .{
                    .name = target.cpu.model.name,
                    .root_source_file = mb.core_dep.namedLazyPath("cpu_cortex_m"),
                    .imports = mb.builder.allocator.dupe(Build.Module.Import, &.{
                        .{
                            .name = "rtt",
                            .module = mb.dep.builder.dependency("modules/rtt", .{}).module("rtt"),
                        },
                    }) catch @panic("OOM"),
                };
            } else if (target.cpu.arch.isRISCV() and target.ptrBitWidth() == 32) {
                return .{
                    .name = "riscv32",
                    .root_source_file = mb.core_dep.namedLazyPath("cpu_riscv32"),
                    .imports = mb.builder.allocator.dupe(Build.Module.Import, &.{
                        .{
                            .name = "riscv32-common",
                            .module = mb.dep.builder.dependency("modules/riscv32-common", .{}).module("riscv32-common"),
                        },
                    }) catch @panic("OOM"),
                };
            }

            std.debug.panic(
                "No default cpu configuration for `{s}`. Please specify a cpu either in the target or in the options for creating the firmware.",
                .{target.cpu.model.name},
            );
        }
    };
}

pub inline fn custom_lazy_import(
    comptime dep_name: []const u8,
) ?type {
    const build_runner = @import("root");
    const deps = build_runner.dependencies;
    const pkg_hash = custom_find_import_pkg_hash_or_fatal(dep_name);

    inline for (@typeInfo(deps.packages).@"struct".decls) |decl| {
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
    @setEvalBranchQuota(5000);
    const build_runner = @import("root");
    const deps = build_runner.dependencies;

    const pkg_deps = comptime for (@typeInfo(deps.packages).@"struct".decls) |decl| {
        const pkg_hash = decl.name;
        const pkg = @field(deps.packages, pkg_hash);
        if (@hasDecl(pkg, "build_zig") and pkg.build_zig == @This()) break pkg.deps;
    } else deps.root_deps;

    comptime for (pkg_deps) |dep| {
        if (std.mem.eql(u8, dep[0], dep_name)) return dep[1];
    };

    @panic("dependency not found");
}
