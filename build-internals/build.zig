const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;
const uf2 = @import("microzig/tools/uf2");

const TargetRegistry = std.AutoHashMap(*const TargetAlias, Target);

var target_registry: TargetRegistry = TargetRegistry.init(std.heap.page_allocator);

pub fn build(_: *Build) void {}

/// Get a MicroZig target based on its alias.
pub fn get_target(alias: *const TargetAlias) ?Target {
    return target_registry.get(alias);
}

/// Register a MicroZig target based on its alias.
pub fn submit_target(alias: *const TargetAlias, target: Target) void {
    const entry = target_registry.getOrPut(alias) catch @panic("out of memory");
    if (entry.found_existing) @panic("target submitted twice");
    entry.value_ptr.* = target;
}

/// MicroZig target definition.
pub const Target = struct {
    cpu: std.Target.Query,

    linker_script: LazyPath,

    chip: struct {
        name: []const u8,
        module: ModuleDeclaration,
    },

    hal: ?ModuleDeclaration = null,

    board: ?ModuleDeclaration = null,

    patch_elf: ?*const fn (LazyPath) LazyPath = null,

    preferred_binary_format: ?BinaryFormat = null,
};

/// MicroZig target alias. Used to get the actual target definition.
pub const TargetAlias = struct {
    name: []const u8,

    pub fn init(name: []const u8) TargetAlias {
        return .{ .name = name };
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
