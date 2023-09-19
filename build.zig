//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const uf2 = @import("uf2");

const LibExeObjStep = std.Build.LibExeObjStep;
const Module = std.Build.Module;
const LazyPath = std.Build.LazyPath;
const OptionsStep = std.Build.OptionsStep;
const Build = std.Build;

// alias for packages
pub const LinkerScriptStep = @import("src/modules/LinkerScriptStep.zig");
pub const cpus = @import("src/modules/cpus.zig");
pub const Board = @import("src/modules/Board.zig");
pub const Chip = @import("src/modules/Chip.zig");
pub const Cpu = @import("src/modules/Cpu.zig");
pub const MemoryRegion = @import("src/modules/MemoryRegion.zig");

pub const Backing = union(enum) {
    board: Board,
    chip: Chip,

    pub fn get_target(self: @This()) std.zig.CrossTarget {
        return switch (self) {
            .board => |brd| brd.chip.cpu.target,
            .chip => |chip| chip.cpu.target,
        };
    }
};

pub const EmbeddedExecutable = struct {
    inner: *LibExeObjStep,

    pub const AppDependencyOptions = struct {
        depend_on_microzig: bool = false,
    };

    pub fn addAppDependency(exe: *EmbeddedExecutable, name: []const u8, module: *Module, options: AppDependencyOptions) void {
        if (options.depend_on_microzig) {
            const microzig_module = exe.inner.modules.get("microzig").?;
            module.dependencies.put("microzig", microzig_module) catch @panic("OOM");
        }

        const app_module = exe.inner.modules.get("app").?;
        app_module.dependencies.put(name, module) catch @panic("OOM");
    }

    pub fn installArtifact(exe: *EmbeddedExecutable, b: *Build) void {
        b.installArtifact(exe.inner);
    }

    pub fn addIncludePath(exe: *EmbeddedExecutable, path: LazyPath) void {
        exe.inner.addIncludePath(path);
    }

    pub fn addSystemIncludePath(exe: *EmbeddedExecutable, path: LazyPath) void {
        return exe.inner.addSystemIncludePath(path);
    }

    pub fn addCSourceFile(exe: *EmbeddedExecutable, source: Build.Step.Compile.CSourceFile) void {
        exe.inner.addCSourceFile(source);
    }

    pub fn addOptions(exe: *EmbeddedExecutable, module_name: []const u8, options: *OptionsStep) void {
        exe.inner.addOptions(module_name, options);
        const app_module = exe.inner.modules.get("app").?;
        const opt_module = exe.inner.modules.get(module_name).?;
        app_module.dependencies.put(module_name, opt_module) catch @panic("OOM");
    }

    pub fn addObjectFile(exe: *EmbeddedExecutable, source: LazyPath) void {
        exe.inner.addObjectFile(source);
    }
};

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const EmbeddedExecutableOptions = struct {
    name: []const u8,
    source_file: LazyPath,
    backing: Backing,
    optimize: std.builtin.OptimizeMode = .Debug,
    linkerscript_source_file: ?LazyPath = null,
};

pub fn addEmbeddedExecutable(b: *Build, opts: EmbeddedExecutableOptions) *EmbeddedExecutable {
    const has_board = (opts.backing == .board);
    const chip = switch (opts.backing) {
        .chip => |chip| chip,
        .board => |board| board.chip,
    };

    const has_hal = chip.hal != null;

    // TODO: let the user override which ram section to use the stack on,
    // for now just using the first ram section in the memory region list
    const first_ram = blk: {
        for (chip.memory_regions) |region| {
            if (region.kind == .ram)
                break :blk region;
        } else @panic("no ram memory region found for setting the end-of-stack address");
    };

    const config = b.addOptions();
    config.addOption(bool, "has_hal", has_hal);
    config.addOption(bool, "has_board", has_board);
    if (has_board)
        config.addOption([]const u8, "board_name", opts.backing.board.name);

    config.addOption([]const u8, "chip_name", chip.name);
    config.addOption([]const u8, "cpu_name", chip.name);
    config.addOption(usize, "end_of_stack", first_ram.offset + first_ram.length);

    const microzig_module = b.createModule(.{
        .source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/microzig.zig", .{root_dir()}) },
    });

    microzig_module.dependencies.put("config", b.createModule(.{
        .source_file = config.getSource(),
    })) catch unreachable;

    microzig_module.dependencies.put("chip", b.createModule(.{
        .source_file = chip.source,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    microzig_module.dependencies.put("cpu", b.createModule(.{
        .source_file = chip.cpu.source,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    })) catch unreachable;

    if (chip.hal) |hal_module_source| {
        microzig_module.dependencies.put("hal", b.createModule(.{
            .source_file = hal_module_source,
            .dependencies = &.{
                .{ .name = "microzig", .module = microzig_module },
            },
        })) catch unreachable;
    }

    switch (opts.backing) {
        .board => |board| {
            microzig_module.dependencies.put("board", b.createModule(.{
                .source_file = board.source,
                .dependencies = &.{
                    .{ .name = "microzig", .module = microzig_module },
                },
            })) catch unreachable;
        },
        else => {},
    }

    const app_module = b.createModule(.{
        .source_file = opts.source_file,
        .dependencies = &.{
            .{ .name = "microzig", .module = microzig_module },
        },
    });

    const exe = b.allocator.create(EmbeddedExecutable) catch unreachable;
    exe.* = EmbeddedExecutable{
        .inner = b.addExecutable(.{
            .name = opts.name,
            .root_source_file = .{ .path = comptime std.fmt.comptimePrint("{s}/src/start.zig", .{root_dir()}) },
            .target = chip.cpu.target,
            .optimize = opts.optimize,
        }),
    };
    exe.inner.addModule("app", app_module);
    exe.inner.addModule("microzig", microzig_module);

    exe.inner.strip = false; // we always want debug symbols, stripping brings us no benefit on embedded

    // might not be true for all machines (Pi Pico), but
    // for the HAL it's true (it doesn't know the concept of threading)
    exe.inner.single_threaded = true;

    if (opts.linkerscript_source_file) |linkerscript_source_file| {
        exe.inner.setLinkerScriptPath(linkerscript_source_file);
    } else {
        const linkerscript = LinkerScriptStep.create(b, chip) catch unreachable;
        exe.inner.setLinkerScriptPath(.{ .generated = &linkerscript.generated_file });
    }

    // TODO:
    // - Generate the linker scripts from the "chip" or "board" module instead of using hardcoded ones.
    //   - This requires building another tool that runs on the host that compiles those files and emits the linker script.
    //    - src/tools/linkerscript-gen.zig is the source file for this
    exe.inner.bundle_compiler_rt = (exe.inner.target.getCpuArch() != .avr); // don't bundle compiler_rt for AVR as it doesn't compile right now

    return exe;
}

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *Build) !void {
    const backings = @import("test/backings.zig");
    const optimize = b.standardOptimizeOption(.{});

    const minimal = addEmbeddedExecutable(b, .{
        .name = "minimal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/minimal.zig",
        },
        .backing = backings.minimal,
        .optimize = optimize,
    });

    const has_hal = addEmbeddedExecutable(b, .{
        .name = "has_hal",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/has_hal.zig",
        },
        .backing = backings.has_hal,
        .optimize = optimize,
    });

    const has_board = addEmbeddedExecutable(b, .{
        .name = "has_board",
        .source_file = .{
            .path = comptime root_dir() ++ "/test/programs/has_board.zig",
        },
        .backing = backings.has_board,
        .optimize = optimize,
    });

    const core_tests = b.addTest(.{
        .root_source_file = .{
            .path = comptime root_dir() ++ "/src/core.zig",
        },
        .optimize = optimize,
    });

    const test_step = b.step("test", "build test programs");
    test_step.dependOn(&minimal.inner.step);
    test_step.dependOn(&has_hal.inner.step);
    test_step.dependOn(&has_board.inner.step);
    test_step.dependOn(&b.addRunArtifact(core_tests).step);
}

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

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
        extension: []const u8,
        convert: *const fn (*Custom, std.Build.LazyPath) std.Build.LazyPath,
    };

    const Enum = std.meta.Tag(BinaryFormat);
};

pub const Bootloader = union(enum) {
    //
};

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

pub const Target = struct {
    /// The display name of the target.
    name: []const u8,

    /// The preferred binary format of this MicroZig target. If `null`, the user must
    /// explicitly give the `.format` field during a call to `getEmittedBin()` or installation steps.
    preferred_format: ?BinaryFormat,

    /// The cpu model this target uses.
    cpu: CpuModel,

    /// (optional) Post processing step that will patch up and modify the elf file if necessary.
    binary_post_process: ?*const fn (*std.Build, std.Build.LazyPath) std.Build.LazyPath = null,
};

pub const HardwareAbstractionLayer = struct {
    //
};

pub const FirmwareOptions = struct {
    name: []const u8,
    target: Target,
    optimize: std.builtin.OptimizeMode,

    source_file: ?std.Build.LazyPath = null,

    // TODO: Future extensions
    hal: ?HardwareAbstractionLayer = null,
    bootloader: ?Bootloader = null,
};

pub fn addFirmware(b: *std.Build, options: FirmwareOptions) *Firmware {
    const cpu = options.target.cpu.getDescriptor();

    const fw: *Firmware = b.allocator.create(Firmware) catch @panic("out of memory");

    fw.* = Firmware{
        .b = b,
        .artifact = b.addExecutable(.{
            .name = options.name,
            .optimize = options.optimize,
            .target = cpu.target,
            .linkage = .static,
        }),
        .target = options.target,
        .output_files = Firmware.OutputFileMap.init(b.allocator),
    };
    errdefer fw.output_files.deinit();

    return fw;
}

pub const InstallFirmwareOptions = struct {
    format: ?BinaryFormat = null,
};

pub fn installFirmware(b: *std.Build, firmware: *Firmware, options: InstallFirmwareOptions) void {
    const install_step = addInstallFirmware(b, firmware, options);
    b.getInstallStep().dependOn(&install_step.step);
}

pub fn addInstallFirmware(b: *std.Build, firmware: *Firmware, options: InstallFirmwareOptions) *std.Build.Step.InstallFile {
    const format = firmware.resolveFormat(options.format);

    const basename = b.fmt("{s}{s}", .{
        firmware.artifact.name,
        format.getExtension(),
    });

    return b.addInstallFileWithDir(firmware.getEmittedBin(format), .{ .custom = "firmware" }, basename);
}

pub const Firmware = struct {
    const OutputFileMap = std.ArrayHashMap(BinaryFormat, std.Build.LazyPath, OutputFileMapContext, false);

    b: *std.Build,
    target: Target,
    artifact: *std.Build.Step.Compile,
    output_files: OutputFileMap,

    emitted_elf: ?std.Build.LazyPath = null,

    pub fn getEmittedElf(firmware: *Firmware) std.Build.LazyPath {
        if (firmware.emitted_elf == null) {
            const raw_elf = firmware.artifact.getEmittedBin();
            firmware.emitted_elf = if (firmware.target.binary_post_process) |binary_post_process|
                binary_post_process(firmware.b, raw_elf)
            else
                raw_elf;
        }
        return firmware.emitted_elf.?;
    }

    pub fn getEmittedBin(firmware: *Firmware, format: ?BinaryFormat) std.Build.LazyPath {
        const actual_format = firmware.resolveFormat(format);

        const gop = firmware.output_files.getOrPut(actual_format) catch @panic("out of memory");
        if (!gop.found_existing) {
            const elf_file = firmware.getEmittedElf();

            const basename = firmware.b.fmt("{s}{s}", .{
                firmware.artifact.name,
                actual_format.getExtension(),
            });

            gop.value_ptr.* = switch (actual_format) {
                .elf => elf_file,

                .bin => blk: {
                    const objcopy = firmware.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .bin,
                    });

                    break :blk objcopy.getOutput();
                },

                .hex => blk: {
                    const objcopy = firmware.b.addObjCopy(elf_file, .{
                        .basename = basename,
                        .format = .hex,
                    });

                    break :blk objcopy.getOutput();
                },

                .dfu => buildConfigError(firmware.b, "DFU is not implemented yet. See <LINK HERE> for more details!", .{}),
                .esp => buildConfigError(firmware.b, "ESP firmware image is not implemented yet. See <LINK HERE> for more details!", .{}),
                .uf2 => buildConfigError(firmware.b, "UF2 is not implemented yet. See <LINK HERE> for more details!", .{}),

                .custom => |generator| generator.convert(generator, elf_file),

                // TODO: Create output file here
            };
        }
        return gop.value_ptr.*;
    }

    fn resolveFormat(firmware: *Firmware, format: ?BinaryFormat) BinaryFormat {
        if (format) |fmt| return fmt;

        if (firmware.target.preferred_format) |fmt| return fmt;

        buildConfigError(firmware.b, "{s} has no preferred output format, please provide one in the `format` option.", .{
            firmware.target.name,
        });
    }
};

const OutputFileMapContext = struct {
    pub fn hash(self: @This(), fmt: BinaryFormat) u32 {
        _ = self;

        return switch (@as(BinaryFormat.Enum, fmt)) {
            inline .elf,
            .bin,
            .hex,
            .dfu,
            .uf2,
            .esp,
            => |tag| comptime std.hash.CityHash32.hash(@tagName(tag)),

            .custom => std.hash.CityHash32.hash(std.mem.asBytes(fmt.custom)),
        };
    }

    pub fn eql(self: @This(), fmt_a: BinaryFormat, fmt_b: BinaryFormat, index: usize) bool {
        _ = self;
        _ = index;
        if (@as(BinaryFormat.Enum, fmt_a) != @as(BinaryFormat.Enum, fmt_b))
            return false;

        return switch (fmt_a) {
            .elf,
            .bin,
            .hex,
            .dfu,
            .uf2,
            .esp,
            => true,

            .custom => |a| (a == fmt_b.custom),
        };
    }
};

fn buildConfigError(b: *std.Build, comptime fmt: []const u8, args: anytype) noreturn {
    const msg = b.fmt(fmt, args);
    @panic(msg);
}
