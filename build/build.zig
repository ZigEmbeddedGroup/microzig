//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const uf2 = @import("uf2");

////////////////////////////////////////
//      MicroZig Gen 3 Interface      //
////////////////////////////////////////

pub const BoardSupportPackageDefinition = struct {
    pub const TargetDefinition = struct {
        id: []const u8, // full "uri"
        target: Target,
    };

    bsp_root: type,
    targets: []const TargetDefinition,

    fn init(comptime bsp_root: type) BoardSupportPackageDefinition {
        var targets: []const TargetDefinition = &.{};

        if (@hasDecl(bsp_root, "chips")) {
            targets = targets ++ construct_target_database("chip:", bsp_root.chips);
        }

        if (@hasDecl(bsp_root, "boards")) {
            targets = targets ++ construct_target_database("board:", bsp_root.boards);
        }

        if (targets.len == 0) {
            @compileError("Board support package contains not a single target. Please add at least one target!");
        }

        return BoardSupportPackageDefinition{
            .bsp_root = bsp_root,
            .targets = targets,
        };
    }

    fn construct_target_database(comptime prefix: []const u8, comptime namespace: type) []const TargetDefinition {
        var list: []const TargetDefinition = &.{};

        inline for (@typeInfo(namespace).Struct.decls) |decl_info| {
            const decl = @field(namespace, decl_info.name);
            const T = @TypeOf(decl);

            const name = comptime prefix ++ decl_info.name; // board:vendor/name

            if (T == Target) {
                const target: Target = decl;

                list = list ++ &[_]TargetDefinition{.{
                    .id = name,
                    .target = target,
                }};
                // be.targets.put(be.host_build.allocator, name, target) catch @panic("out of memory");
            } else {
                if (T != type) {
                    @compileError(std.fmt.comptimePrint("Declaration {s} is neither a MicroZig.Target nor a namespace. Expected declaration to be a 'type', found {s}.", .{
                        name,
                        @typeName(T),
                    }));
                }

                const ti = @typeInfo(decl);
                if (ti != .Struct) {
                    @compileError(std.fmt.comptimePrint("Declaration {s} is neither a MicroZig.Target nor a namespace. Expected declaration to be a 'struct', found {s}.", .{
                        name,
                        @tagName(ti),
                    }));
                }

                if (ti.Struct.fields.len > 0) {
                    @compileError(std.fmt.comptimePrint("Declaration {s} is neither a MicroZig.Target nor a namespace. Expected declaration to have no fields, but found {} fields.", .{
                        name,
                        ti.Struct.fields.len,
                    }));
                }

                const sublist = construct_target_database(
                    comptime name ++ "/",
                    decl,
                );

                list = list ++ sublist;
            }
        }

        return list;
    }
};

/// Validates a board support package and returns a registration type that can be used
/// with MicroZig automatic BSP discovery.
///
/// Store the return value into a public constant named "" at the root of your build script:
///
///     pub const microzig_board_support = microzig.registerBoardSupport(@This());
///
pub fn registerBoardSupport(comptime bsp_root: type) BoardSupportPackageDefinition {
    return BoardSupportPackageDefinition.init(bsp_root);
}

const ImportedBSP = struct {
    import_name: []const u8,
    bsp: BoardSupportPackageDefinition,
};

fn get_declared_bsps() []const ImportedBSP {

    // Keep in sync with the logic from Build.zig:dependency
    const build_runner = @import("root");
    const deps = build_runner.dependencies;

    var bsps: []const ImportedBSP = &.{};
    inline for (@typeInfo(deps.imports).Struct.decls) |decl| {
        if (comptime std.mem.indexOfScalar(u8, decl.name, '.') == null) {
            const maybe_bsp = @field(deps.imports, decl.name);

            if (@hasDecl(maybe_bsp, "microzig_board_support")) {
                const bsp = @field(maybe_bsp, "microzig_board_support");
                if (@TypeOf(bsp) == BoardSupportPackageDefinition) {
                    bsps = bsps ++ [_]ImportedBSP{.{
                        .import_name = decl.name,
                        .bsp = bsp,
                    }};
                }
            }
        }
    }
    return bsps;
}

pub const EnvironmentInfo = struct {
    /// package name of the build package (optional)
    self: []const u8 = "microzig",

    /// package name of the core package (optional)
    core: []const u8 = "microzig-core",
};

pub fn createBuildEnvironment(b: *std.Build, comptime info: EnvironmentInfo) *BuildEnvironment {
    const available_bsps = comptime get_declared_bsps();

    const be = b.allocator.create(BuildEnvironment) catch @panic("out of memory");
    be.* = BuildEnvironment{
        .host_build = b,
        .self = undefined,
        .microzig_core = undefined,
        .board_support_packages = b.allocator.alloc(BoardSupportPackage, available_bsps.len) catch @panic("out of memory"),
        .targets = .{},
    };

    be.self = b.dependency(info.self, .{});
    be.microzig_core = b.dependency(info.core, .{});

    inline for (be.board_support_packages, available_bsps) |*bsp, def| {
        bsp.* = BoardSupportPackage{
            .name = def.import_name,
            .dep = b.dependency(def.import_name, .{}),
        };

        for (def.bsp.targets) |tgt| {
            const full_name = b.fmt("{s}#{s}", .{ tgt.id, def.import_name });

            be.targets.put(be.host_build.allocator, tgt.id, tgt.target) catch @panic("out of memory");
            be.targets.put(be.host_build.allocator, full_name, tgt.target) catch @panic("out of memory");
        }
    }

    return be;
}

pub const BoardSupportPackage = struct {
    dep: *std.Build.Dependency,
    name: []const u8,
};

pub const BuildEnvironment = struct {
    host_build: *std.Build,
    self: *std.Build.Dependency,

    microzig_core: *std.Build.Dependency,

    board_support_packages: []BoardSupportPackage,

    targets: std.StringArrayHashMapUnmanaged(Target),

    pub fn findTarget(env: *const BuildEnvironment, name: []const u8) ?*const Target {
        return env.targets.getPtr(name);
    }

    /// Declares a new MicroZig firmware file.
    pub fn addFirmware(
        /// The MicroZig instance that should be used to create the firmware.
        env: *BuildEnvironment,
        /// The instance of the `build.zig` that is calling this function.
        host_build: *std.Build,
        /// Options that define how the firmware is built.
        options: FirmwareOptions,
    ) *Firmware {
        const micro_build = env.self.builder;

        const chip = &options.target.chip;
        const cpu = chip.cpu.getDescriptor();
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
                const regz_exe = env.dependency("regz", .{ .optimize = .ReleaseSafe }).artifact("regz");

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
        config.addOption([]const u8, "cpu_name", chip.name);
        config.addOption(usize, "end_of_stack", first_ram.offset + first_ram.length);

        const fw: *Firmware = host_build.allocator.create(Firmware) catch @panic("out of memory");
        fw.* = Firmware{
            .env = env,
            .host_build = host_build,
            .artifact = host_build.addExecutable(.{
                .name = options.name,
                .optimize = options.optimize,
                .target = cpu.target,
                .linkage = .static,
                .root_source_file = .{ .cwd_relative = env.self.builder.pathFromRoot("src/start.zig") },
            }),
            .target = options.target,
            .output_files = Firmware.OutputFileMap.init(host_build.allocator),

            .config = config,

            .modules = .{
                .microzig = micro_build.createModule(.{
                    .source_file = .{ .cwd_relative = micro_build.pathFromRoot("src/microzig.zig") },
                    .dependencies = &.{
                        .{
                            .name = "config",
                            .module = micro_build.createModule(.{ .source_file = config.getSource() }),
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

        fw.modules.chip = micro_build.createModule(.{
            .source_file = chip_source,
            .dependencies = &.{
                .{ .name = "microzig", .module = fw.modules.microzig },
            },
        });
        fw.modules.microzig.dependencies.put("chip", fw.modules.chip) catch @panic("out of memory");

        fw.modules.cpu = micro_build.createModule(.{
            .source_file = cpu.source_file,
            .dependencies = &.{
                .{ .name = "microzig", .module = fw.modules.microzig },
            },
        });
        fw.modules.microzig.dependencies.put("cpu", fw.modules.cpu) catch @panic("out of memory");

        if (maybe_hal) |hal| {
            fw.modules.hal = micro_build.createModule(.{
                .source_file = hal.source_file,
                .dependencies = &.{
                    .{ .name = "microzig", .module = fw.modules.microzig },
                },
            });
            fw.modules.microzig.dependencies.put("hal", fw.modules.hal.?) catch @panic("out of memory");
        }

        if (maybe_board) |brd| {
            fw.modules.board = micro_build.createModule(.{
                .source_file = brd.source_file,
                .dependencies = &.{
                    .{ .name = "microzig", .module = fw.modules.microzig },
                },
            });
            fw.modules.microzig.dependencies.put("board", fw.modules.board.?) catch @panic("out of memory");
        }

        fw.modules.app = host_build.createModule(.{
            .source_file = options.source_file,
            .dependencies = &.{
                .{ .name = "microzig", .module = fw.modules.microzig },
            },
        });

        const umm = env.dependency("umm-zig", .{}).module("umm");
        fw.modules.microzig.dependencies.put("umm", umm) catch @panic("out of memory");

        fw.artifact.addModule("app", fw.modules.app);
        fw.artifact.addModule("microzig", fw.modules.microzig);

        fw.artifact.strip = false; // we always want debug symbols, stripping brings us no benefit on embedded
        fw.artifact.single_threaded = options.single_threaded orelse fw.target.single_threaded;
        fw.artifact.bundle_compiler_rt = options.bundle_compiler_rt orelse fw.target.bundle_compiler_rt;

        switch (linker_script) {
            .generated => {
                fw.artifact.setLinkerScript(
                    generateLinkerScript(host_build, chip.*) catch @panic("out of memory"),
                );
            },

            .source_file => |source| {
                fw.artifact.setLinkerScriptPath(source);
            },
        }

        if (options.target.configure) |configure| {
            configure(host_build, fw);
        }

        return fw;
    }

    /// Adds a new dependency to the `install` step that will install the `firmware` into the folder `$prefix/firmware`.
    pub fn installFirmware(
        /// The MicroZig instance that was used to create the firmware.
        env: *BuildEnvironment,
        /// The instance of the `build.zig` that should perform installation.
        b: *std.Build,
        /// The firmware that should be installed. Please make sure that this was created with the same `MicroZig` instance as `mz`.
        firmware: *Firmware,
        /// Optional configuration of the installation process. Pass `.{}` if you're not sure what to do here.
        options: InstallFirmwareOptions,
    ) void {
        std.debug.assert(env == firmware.env);
        const install_step = addInstallFirmware(env, b, firmware, options);
        b.getInstallStep().dependOn(&install_step.step);
    }

    /// Creates a new `std.Build.Step.InstallFile` instance that will install the given firmware to `$prefix/firmware`.
    ///
    /// **NOTE:** This does not actually install the firmware yet. You have to add the returned step as a dependency to another step.
    ///           If you want to just install the firmware, use `installFirmware` instead!
    pub fn addInstallFirmware(
        /// The MicroZig instance that was used to create the firmware.
        env: *BuildEnvironment,
        /// The instance of the `build.zig` that should perform installation.
        b: *std.Build,
        /// The firmware that should be installed. Please make sure that this was created with the same `MicroZig` instance as `mz`.
        firmware: *Firmware,
        /// Optional configuration of the installation process. Pass `.{}` if you're not sure what to do here.
        options: InstallFirmwareOptions,
    ) *std.Build.Step.InstallFile {
        _ = env;
        const format = firmware.resolveFormat(options.format);

        const basename = b.fmt("{s}{s}", .{
            firmware.artifact.name,
            format.getExtension(),
        });

        return b.addInstallFileWithDir(firmware.getEmittedBin(format), .{ .custom = "firmware" }, basename);
    }

    fn dependency(env: *BuildEnvironment, name: []const u8, args: anytype) *std.Build.Dependency {
        return env.self.builder.dependency(name, args);
    }
};

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

const MicroZig = @This();

b: *std.Build,
self: *std.Build.Dependency,

/// Creates a new instance of the MicroZig build support.
///
/// This is necessary as we need to keep track of some internal state to prevent
/// duplicated work per firmware built.
pub fn init(b: *std.Build, dependency_name: []const u8) *MicroZig {
    const mz = b.allocator.create(MicroZig) catch @panic("out of memory");
    mz.* = MicroZig{
        .b = b,
        .self = b.dependency(dependency_name, .{}),
    };
    return mz;
}

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *std.Build) !void {
    const uf2_dep = b.dependency("uf2", .{});

    const build_test = b.addTest(.{
        .root_source_file = .{ .path = "build.zig" },
    });

    build_test.addAnonymousModule("uf2", .{
        .source_file = .{ .cwd_relative = uf2_dep.builder.pathFromRoot("build.zig") },
    });

    const install_docs = b.addInstallDirectory(.{
        .source_dir = build_test.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });

    b.getInstallStep().dependOn(&install_docs.step);

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
    pub fn getExtension(format: BinaryFormat) []const u8 {
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
        convert: *const fn (*Custom, elf: std.Build.LazyPath) std.Build.LazyPath,
    };

    const Enum = std.meta.Tag(BinaryFormat);

    const Context = struct {
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

/// The CPU model a target uses.
///
/// The CPUs usually require special care on how to do interrupts, and getting an entry point.
///
/// MicroZig officially only supports the CPUs listed here, but other CPUs might be provided
/// via the `custom` field.
pub const CpuModel = union(enum) {
    avr5,
    cortex_m0,
    cortex_m0plus,
    cortex_m3,
    cortex_m4,
    riscv32_imac,

    custom: *const Cpu,

    pub fn getDescriptor(model: CpuModel) *const Cpu {
        return switch (@as(std.meta.Tag(CpuModel), model)) {
            inline else => |tag| &@field(cpus, @tagName(tag)),
            .custom => model.custom,
        };
    }
};

/// A cpu descriptor.
pub const Cpu = struct {
    /// Display name of the CPU.
    name: []const u8,

    /// Source file providing startup code and memory initialization routines.
    source_file: std.build.LazyPath,

    /// The compiler target we use to compile all the code.
    target: std.zig.CrossTarget,
};

/// A descriptor for memory regions in a microcontroller.
pub const MemoryRegion = struct {
    /// The type of the memory region for generating a proper linker script.
    kind: Kind,
    offset: u64,
    length: u64,

    pub const Kind = union(enum) {
        /// This is a (normally) immutable memory region where the code is stored.
        flash,

        /// This is a mutable memory region for data storage.
        ram,

        /// This is a memory region that maps MMIO devices.
        io,

        /// This is a memory region that exists, but is reserved and must not be used.
        reserved,

        /// This is a memory region used for internal linking tasks required by the board support package.
        private: PrivateRegion,
    };

    pub const PrivateRegion = struct {
        /// The name of the memory region. Will not have an automatic numeric counter and must be unique.
        name: []const u8,

        /// Is the memory region executable?
        executable: bool,

        /// Is the memory region readable?
        readable: bool,

        /// Is the memory region writable?
        writeable: bool,
    };
};

/// Defines a custom microcontroller.
pub const Chip = struct {
    /// The display name of the controller.
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the controller.
    url: ?[]const u8 = null,

    /// The cpu model this controller uses.
    cpu: CpuModel,

    /// The provider for register definitions.
    register_definition: union(enum) {
        /// Use `regz` to create a zig file from a JSON schema.
        json: std.Build.LazyPath,

        /// Use `regz` to create a json file from a SVD schema.
        svd: std.Build.LazyPath,

        /// Use `regz` to create a zig file from an ATDF schema.
        atdf: std.Build.LazyPath,

        /// Use the provided file directly as the chip file.
        zig: std.Build.LazyPath,
    },

    /// The memory regions that are present in this chip.
    memory_regions: []const MemoryRegion,
};

/// Defines a hardware abstraction layer.
pub const HardwareAbstractionLayer = struct {
    /// Root source file for this HAL.
    source_file: std.Build.LazyPath,
};

/// Provides a description of a board.
///
/// Boards provide additional information to a chip and HAL package.
/// For example, they can list attached peripherials, external crystal frequencies,
/// flash sizes, ...
pub const BoardDefinition = struct {
    /// Display name of the board
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the board.
    url: ?[]const u8 = null,

    /// Provides the root file for the board definition.
    source_file: std.Build.LazyPath,
};

/// The linker script used to link the firmware.
pub const LinkerScript = union(enum) {
    /// Auto-generated linker script derived from the memory regions of the chip.
    generated,

    /// Externally defined linker script.
    source_file: std.build.LazyPath,
};

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
    linker_script: LinkerScript = .generated,

    /// (optional) Further configures the created firmware depending on the chip and/or board settings.
    /// This can be used to set/change additional properties on the created `*Firmware` object.
    configure: ?*const fn (host_build: *std.Build, *Firmware) void = null,

    /// (optional) Post processing step that will patch up and modify the elf file if necessary.
    binary_post_process: ?*const fn (host_build: *std.Build, std.Build.LazyPath) std.Build.LazyPath = null,
};

/// Options to the `addFirmware` function.
pub const FirmwareOptions = struct {
    /// The name of the firmware file.
    name: []const u8,

    /// The MicroZig target that the firmware is built for. Either a board or a chip.
    target: *const Target,

    /// The optimization level that should be used. Usually `ReleaseSmall` or `Debug` is a good choice.
    /// Also using `std.Build.standardOptimizeOption` is a good idea.
    optimize: std.builtin.OptimizeMode,

    /// The root source file for the application. This is your `src/main.zig` file.
    source_file: std.Build.LazyPath,

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
    linker_script: ?LinkerScript = null,
};

/// Configuration options for firmware installation.
pub const InstallFirmwareOptions = struct {
    /// Overrides the output format for the binary. If not set, the standard preferred file format for the firmware target is used.
    format: ?BinaryFormat = null,
};

/// Declaration of a firmware build.
pub const Firmware = struct {
    const OutputFileMap = std.ArrayHashMap(BinaryFormat, std.Build.LazyPath, BinaryFormat.Context, false);

    const Modules = struct {
        app: *std.Build.Module,
        cpu: *std.Build.Module,
        chip: *std.Build.Module,
        board: ?*std.Build.Module,
        hal: ?*std.Build.Module,
        microzig: *std.Build.Module,
    };

    // privates:
    env: *BuildEnvironment,
    host_build: *std.Build,
    target: *const Target,
    output_files: OutputFileMap,

    // publics:

    /// The artifact that is built by Zig.
    artifact: *std.Build.Step.Compile,

    /// The options step that provides `microzig.config`. If you need custom configuration, you can add this here.
    config: *std.Build.Step.Options,

    /// Declaration of the MicroZig modules used by this firmware.
    modules: Modules,

    /// Path to the emitted elf file, if any.
    emitted_elf: ?std.Build.LazyPath = null,

    /// Returns the emitted ELF file for this firmware. This is useful if you need debug information
    /// or want to use a debugger like Segger, ST-Link or similar.
    ///
    /// **NOTE:** This is similar, but not equivalent to `std.Build.Step.Compile.getEmittedBin`. The call on the compile step does
    ///           not include post processing of the ELF files necessary by certain targets.
    pub fn getEmittedElf(firmware: *Firmware) std.Build.LazyPath {
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
    pub fn getEmittedBin(firmware: *Firmware, format: ?BinaryFormat) std.Build.LazyPath {
        const actual_format = firmware.resolveFormat(format);

        const gop = firmware.output_files.getOrPut(actual_format) catch @panic("out of memory");
        if (!gop.found_existing) {
            const elf_file = firmware.getEmittedElf();

            const basename = firmware.host_build.fmt("{s}{s}", .{
                firmware.artifact.name,
                actual_format.getExtension(),
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
                    const uf2_exe = firmware.env.dependency("uf2", .{ .optimize = .ReleaseSafe }).artifact("elf2uf2");

                    const convert = firmware.host_build.addRunArtifact(uf2_exe);

                    convert.addArg("--family-id");
                    convert.addArg(firmware.host_build.fmt("0x{X:0>4}", .{@intFromEnum(family_id)}));

                    convert.addArg("--elf-path");
                    convert.addFileArg(elf_file);

                    convert.addArg("--output-path");
                    break :blk convert.addOutputFileArg(basename);
                },

                .dfu => buildConfigError(firmware.host_build, "DFU is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/145 for more details!", .{}),
                .esp => buildConfigError(firmware.host_build, "ESP firmware image is not implemented yet. See https://github.com/ZigEmbeddedGroup/microzig/issues/146 for more details!", .{}),

                .custom => |generator| generator.convert(generator, elf_file),
            };
        }
        return gop.value_ptr.*;
    }

    pub const AppDependencyOptions = struct {
        depend_on_microzig: bool = false,
    };

    /// Adds a regular dependency to your application.
    pub fn addAppDependency(fw: *Firmware, name: []const u8, module: *std.Build.Module, options: AppDependencyOptions) void {
        if (options.depend_on_microzig) {
            module.dependencies.put("microzig", fw.modules.microzig) catch @panic("OOM");
        }
        fw.modules.app.dependencies.put(name, module) catch @panic("OOM");
    }

    pub fn addIncludePath(fw: *Firmware, path: std.Build.LazyPath) void {
        fw.artifact.addIncludePath(path);
    }

    pub fn addSystemIncludePath(fw: *Firmware, path: std.Build.LazyPath) void {
        fw.artifact.addSystemIncludePath(path);
    }

    pub fn addCSourceFile(fw: *Firmware, source: std.Build.Step.Compile.CSourceFile) void {
        fw.artifact.addCSourceFile(source);
    }

    pub fn addOptions(fw: *Firmware, module_name: []const u8, options: *std.Build.OptionsStep) void {
        fw.artifact.addOptions(module_name, options);
        fw.modules.app.dependencies.put(
            module_name,
            fw.host_build.createModule(.{
                .source_file = options.getOutput(),
            }),
        ) catch @panic("OOM");
    }

    pub fn addObjectFile(fw: *Firmware, source: std.Build.LazyPath) void {
        fw.artifact.addObjectFile(source);
    }

    fn resolveFormat(firmware: *Firmware, format: ?BinaryFormat) BinaryFormat {
        if (format) |fmt| return fmt;

        if (firmware.target.preferred_format) |fmt| return fmt;

        buildConfigError(firmware.host_build, "{s} has no preferred output format, please provide one in the `format` option.", .{
            firmware.target.chip.name,
        });
    }
};

pub const cpus = struct {
    pub const avr5 = Cpu{
        .name = "AVR5",
        .source_file = .{ .path = build_root ++ "/src/cpus/avr5.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .avr,
            .cpu_model = .{ .explicit = &std.Target.avr.cpu.avr5 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0 = Cpu{
        .name = "ARM Cortex-M0",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m0plus = Cpu{
        .name = "ARM Cortex-M0+",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m3 = Cpu{
        .name = "ARM Cortex-M3",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m3 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const cortex_m4 = Cpu{
        .name = "ARM Cortex-M4",
        .source_file = .{ .path = build_root ++ "/src/cpus/cortex-m.zig" },
        .target = std.zig.CrossTarget{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
            .os_tag = .freestanding,
            .abi = .eabi,
        },
    };

    pub const riscv32_imac = Cpu{
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

fn buildConfigError(b: *std.Build, comptime fmt: []const u8, args: anytype) noreturn {
    const msg = b.fmt(fmt, args);
    @panic(msg);
}

fn generateLinkerScript(b: *std.Build, chip: Chip) !std.Build.LazyPath {
    const cpu = chip.cpu.getDescriptor();

    var contents = std.ArrayList(u8).init(b.allocator);
    const writer = contents.writer();
    try writer.print(
        \\/*
        \\ * This file was auto-generated by microzig
        \\ *
        \\ * Target CPU:  {[cpu]s}
        \\ * Target Chip: {[chip]s}
        \\ */
        \\
        // This is not the "true" entry point, but there's no such thing on embedded platforms
        // anyways. This is the logical entrypoint that should be invoked when
        // stack, .data and .bss are set up and the CPU is ready to be used.
        \\ENTRY(microzig_main);
        \\
        \\
    , .{
        .cpu = cpu.name,
        .chip = chip.name,
    });

    try writer.writeAll("MEMORY\n{\n");
    {
        var counters = [4]usize{ 0, 0, 0, 0 };
        for (chip.memory_regions) |region| {
            // flash (rx!w) : ORIGIN = 0x00000000, LENGTH = 512k

            switch (region.kind) {
                .flash => {
                    try writer.print("  flash{d}    (rx!w)", .{counters[0]});
                    counters[0] += 1;
                },

                .ram => {
                    try writer.print("  ram{d}      (rw!x)", .{counters[1]});
                    counters[1] += 1;
                },

                .io => {
                    try writer.print("  io{d}       (rw!x)", .{counters[2]});
                    counters[2] += 1;
                },

                .reserved => {
                    try writer.print("  reserved{d} (rw!x)", .{counters[3]});
                    counters[3] += 1;
                },

                .private => |custom| {
                    try writer.print("  {s} (", .{custom.name});
                    if (custom.readable) try writer.writeAll("r");
                    if (custom.writeable) try writer.writeAll("w");
                    if (custom.executable) try writer.writeAll("x");

                    if (!custom.readable or !custom.writeable or !custom.executable) {
                        try writer.writeAll("!");
                        if (!custom.readable) try writer.writeAll("r");
                        if (!custom.writeable) try writer.writeAll("w");
                        if (!custom.executable) try writer.writeAll("x");
                    }
                    try writer.writeAll(")");
                },
            }
            try writer.print(" : ORIGIN = 0x{X:0>8}, LENGTH = 0x{X:0>8}\n", .{ region.offset, region.length });
        }
    }

    try writer.writeAll("}\n\nSECTIONS\n{\n");
    {
        try writer.writeAll(
            \\  .text :
            \\  {
            \\     KEEP(*(microzig_flash_start))
            \\     *(.text*)
            \\  } > flash0
            \\
            \\
        );

        switch (cpu.target.getCpuArch()) {
            .arm, .thumb => try writer.writeAll(
                \\  .ARM.exidx : {
                \\      *(.ARM.exidx* .gnu.linkonce.armexidx.*)
                \\  } >flash0
                \\
                \\
            ),
            else => {},
        }

        try writer.writeAll(
            \\  .data :
            \\  {
            \\     microzig_data_start = .;
            \\     *(.rodata*)
            \\     *(.data*)
            \\     microzig_data_end = .;
            \\  } > ram0 AT> flash0
            \\
            \\  .bss (NOLOAD) :
            \\  {
            \\      microzig_bss_start = .;
            \\      *(.bss*)
            \\      microzig_bss_end = .;
            \\  } > ram0
            \\
            \\  microzig_data_load_start = LOADADDR(.data);
            \\
        );
    }
    try writer.writeAll("}\n");

    // TODO: Assert that the flash can actually hold all data!
    // try writer.writeAll(
    //     \\
    //     \\  ASSERT( (SIZEOF(.text) + SIZEOF(.data) > LENGTH(flash0)), "Error: .text + .data is too large for flash!" );
    //     \\
    // );

    const write = b.addWriteFiles();

    return write.add("linker.ld", contents.items);
}
