const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;
const uf2 = @import("microzig/tools/uf2");

pub const MemoryRegion = @import("src/shared.zig").MemoryRegion;

const TargetRegistry = std.AutoHashMap(*const TargetAlias, Target);

var target_registry: TargetRegistry = TargetRegistry.init(std.heap.page_allocator);

pub fn build(b: *Build) void {
    _ = b.addModule("shared", .{
        .root_source_file = b.path("src/shared.zig"),
    });
}

/// Gets a MicroZig target based on its alias.
pub fn get_target(alias: *const TargetAlias) ?Target {
    return target_registry.get(alias);
}

/// Registers a MicroZig target based on its alias.
pub fn submit_target(alias: *const TargetAlias, target: Target) void {
    const entry = target_registry.getOrPut(alias) catch @panic("out of memory");
    if (entry.found_existing) @panic("target submitted twice");
    entry.value_ptr.* = target;
}

/// MicroZig target definition.
pub const Target = struct {
    chip: Chip,

    hal: ?ModuleDeclaration = null,

    board: ?ModuleDeclaration = null,

    linker_script: ?LazyPath = null,

    patch_elf: ?struct {
        b: *Build,
        func: *const fn (*Build, LazyPath) LazyPath,
    } = null,

    preferred_binary_format: ?BinaryFormat = null,
};

/// MicroZig target alias. Used to get the actual target definition.
pub const TargetAlias = struct {
    name: []const u8,

    pub fn init(name: []const u8) TargetAlias {
        return .{ .name = name };
    }
};

pub const Chip = struct {
    b: *Build,

    name: []const u8,

    cpu: std.Target.Query,

    register_definition: union(enum) {
        /// Use `regz` to create a zig file from a JSON schema.
        json: LazyPath,

        /// Use `regz` to create a json file from a SVD schema.
        svd: LazyPath,

        /// Use `regz` to create a zig file from an ATDF schema.
        atdf: LazyPath,

        /// Use the provided file directly as the chip file.
        zig: LazyPath,
    },

    memory_regions: []const MemoryRegion,

    pub fn create_module(chip: Chip, regz_exe: *Build.Step.Compile) *Module {
        const chip_source = switch (chip.register_definition) {
            .json, .atdf, .svd => |file| blk: {
                const regz_run = chip.b.addRunArtifact(regz_exe);

                regz_run.addArg("--schema"); // Explicitly set schema type, one of: svd, atdf, json
                regz_run.addArg(@tagName(chip.register_definition));

                regz_run.addArg("--output_path"); // Write to a file
                const zig_file = regz_run.addOutputFileArg("chip.zig");

                regz_run.addFileArg(file);

                break :blk zig_file;
            },

            .zig => |src| src,
        };

        return chip.b.createModule(.{
            .root_source_file = chip_source,
        });
    }
};

/// Helper struct that provides info for module creation by MicroZig.
pub const ModuleDeclaration = struct {
    b: *Build,
    root_source_file: LazyPath,
    imports: []const Module.Import,

    pub fn init(b: *Build, options: struct {
        root_source_file: LazyPath,
        imports: []const Module.Import = &.{},
    }) ModuleDeclaration {
        const allocated_imports = b.allocator.dupe(Module.Import, options.imports) catch @panic("out of memory");
        return .{
            .b = b,
            .root_source_file = options.root_source_file,
            .imports = allocated_imports,
        };
    }

    pub fn create_module(decl: ModuleDeclaration) *Module {
        return decl.b.createModule(.{
            .root_source_file = decl.root_source_file,
            .imports = decl.imports,
        });
    }
};

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
};
