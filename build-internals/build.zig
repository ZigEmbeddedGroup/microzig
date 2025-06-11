const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

const regz = @import("regz");
pub const Patch = regz.patch.Patch;
const uf2 = @import("uf2");
pub const FamilyId = uf2.FamilyId;
const esp_image = @import("esp-image");

pub fn build(b: *Build) void {
    _ = b.addModule("build-internals", .{
        .root_source_file = b.path("build.zig"),
    });
}

/// A compilation target for MicroZig. Provides information about the chip,
/// hal, board and so on.
///
/// This is used instead of `std.Target.Query` to define a MicroZig Firmware.
pub const Target = struct {
    /// The `*std.Build.Dependency` belonging of the port that created this target.
    dep: *Build.Dependency,

    /// The preferred binary format of this MicroZig target, if it has one.
    preferred_binary_format: ?BinaryFormat = null,

    /// The cpu target for the firmware.
    zig_target: std.Target.Query,

    /// (optional) If set, overrides the default cpu module that microzig provides.
    cpu: ?Cpu = null,

    /// The chip this target uses.
    chip: Chip,

    /// Usually, embedded projects are single-threaded and single-core applications. Platforms that
    /// support multiple CPUs should set this to `false`.
    single_threaded: bool = true,

    /// Determines whether the compiler_rt package is bundled with the application or not.
    /// This should always be true except for platforms where compiler_rt cannot be built right now.
    bundle_compiler_rt: bool = true,

    /// Determines whether the artifact produced for this target will exist solely in RAM. This will
    /// inform whether we need to do any special handling e.g. of vector tables and whether we need
    /// to explicitly copy .data and clear out .bss
    ram_image: bool = false,

    /// (optional) Provides a default hardware abstraction layer that is used.
    /// If `null`, no `microzig.hal` will be available.
    hal: ?HardwareAbstractionLayer = null,

    /// (optional) Provides description of external hardware and connected devices
    /// like oscillators and such.
    ///
    /// This structure isn't used by MicroZig itself, but can be utilized from the HAL
    /// if present.
    board: ?Board = null,

    /// Provide a custom linker script for the hardware or define a custom generation.
    linker_script: LinkerScript = .{},

    /// Provides the stack end for the target.
    stack_end: union(enum) {
        /// Place the stack end at a fixed address.
        address: usize,
        /// Place the stack at the end of the n-th ram memory region.
        ram_region_index: usize,
        /// Place the stack end at a symbol address.
        symbol_name: []const u8,
    } = .{ .ram_region_index = 0 },

    /// (optional) Explicitly set the entry point.
    entry: ?Build.Step.Compile.Entry = null,

    /// (optional) Post processing step that will patch up and modify the elf file if necessary.
    patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,

    /// Things you can change by deriving from an already existing target.
    pub const DeriveOptions = struct {
        preferred_binary_format: ?BinaryFormat = null,
        zig_target: ?std.Target.Query = null,
        cpu: ?Cpu = null,
        chip: ?Chip = null,
        single_threaded: ?bool = null,
        bundle_compiler_rt: ?bool = null,
        ram_image: ?bool = null,
        hal: ?HardwareAbstractionLayer = null,
        board: ?Board = null,
        linker_script: ?LinkerScript = null,
        entry: ?Build.Step.Compile.Entry = null,
        patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,
    };

    /// Creates a new target from an existing one.
    pub fn derive(from: *const Target, options: DeriveOptions) *Target {
        const ret = from.dep.builder.allocator.create(Target) catch @panic("out of memory");
        ret.* = .{
            .dep = from.dep,
            .preferred_binary_format = options.preferred_binary_format orelse from.preferred_binary_format,
            .zig_target = options.zig_target orelse from.zig_target,
            .cpu = options.cpu orelse from.cpu,
            .chip = options.chip orelse from.chip,
            .single_threaded = options.single_threaded orelse from.single_threaded,
            .bundle_compiler_rt = options.bundle_compiler_rt orelse from.bundle_compiler_rt,
            .ram_image = options.ram_image orelse from.ram_image,
            .hal = options.hal orelse from.hal,
            .board = options.board orelse from.board,
            .linker_script = options.linker_script orelse from.linker_script,
            .entry = options.entry orelse from.entry,
            .patch_elf = options.patch_elf orelse from.patch_elf,
        };
        return ret;
    }
};

/// Defines a cpu.
pub const Cpu = struct {
    /// Name of the cpu.
    name: []const u8,

    /// Provides the root source file for the cpu.
    root_source_file: LazyPath,

    /// (optional) Provides imports for the cpu. **Needs to be heap allocated.**
    imports: []const Module.Import = &.{},
};

/// Defines a chip.
pub const Chip = struct {
    /// The display name of the controller.
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the controller.
    url: ?[]const u8 = null,

    /// The provider for register definitions.
    register_definition: union(enum) {
        /// Use `regz` to create a json file from a SVD schema.
        svd: LazyPath,

        /// Use `regz` to create a zig file from an ATDF schema.
        atdf: LazyPath,

        /// Use the provided file directly as the chip file.
        zig: LazyPath,

        /// Path to embassy stm32-data directory
        embassy: LazyPath,
    },

    /// The memory regions that are present in this chip.
    memory_regions: []const MemoryRegion,

    /// Register patches for this chip.
    patches: []const Patch = &.{},
};

/// Defines a hardware abstraction layer.
pub const HardwareAbstractionLayer = struct {
    /// Provides the root source file for the HAL.
    root_source_file: LazyPath,

    /// Provides imports for the HAL. **Needs to be heap allocated.**
    imports: []const Module.Import = &.{},
};

/// Provides a description of a board.
///
/// Boards provide additional information to a chip and HAL package.
/// For example, they can list attached peripherials, external crystal frequencies,
/// flash sizes, ...
pub const Board = struct {
    /// Display name of the board.
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the board.
    url: ?[]const u8 = null,

    /// Provides the root source file for the board definition.
    root_source_file: LazyPath,

    /// (optional) Provides imports for the board definition. **Needs to be heap allocated.**
    imports: []const Module.Import = &.{},
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
    esp: esp_image.Options,

    /// Custom option for non-standard formats.
    custom: *Custom,

    /// Returns the standard extension for the resulting binary file.
    pub fn get_extension(format: BinaryFormat) []const u8 {
        return switch (format) {
            .elf => ".elf",
            .bin, .esp => ".bin",
            .hex => ".hex",
            .dfu => ".dfu",
            .uf2 => ".uf2",

            .custom => |c| c.extension,
        };
    }

    pub const Custom = struct {
        /// The standard extension of the format.
        extension: []const u8,

        /// A function that will convert a given `elf` file into the custom output format.
        convert: *const fn (*Build.Dependency, elf: Build.LazyPath) Build.LazyPath,
    };
};

pub const LinkerScript = struct {
    /// Will anything be auto-generated for this linker script?
    generate: GenerateOptions = .{ .memory_regions_and_sections = .{} },
    /// Linker script path. Will be appended after what is auto-generated if it's not null.
    file: ?LazyPath = null,

    pub const GenerateOptions = union(enum) {
        /// Only generates a comment with target info.
        none,
        /// Only generates memory regions.
        memory_regions,
        /// Generates memory regions and default sections based on the provided options.
        memory_regions_and_sections: struct {
            /// Where should rodata go?
            rodata_location: enum {
                /// Place rodata in the first region tagged as flash.
                flash,
                /// Place rodata in the first region tagged as ram.
                ram,
            } = .flash,
        },
    };
};

/// A descriptor for memory regions in a microcontroller.
pub const MemoryRegion = struct {
    name: ?[]const u8 = null,
    tag: Tag = .none,
    offset: u64,
    length: u64,
    access: Access,

    pub fn validate_tag(region: MemoryRegion) void {
        switch (region.tag) {
            .flash => if (!region.access.read or !region.access.execute)
                @panic("memory regions tagged as `flash` must be executable"),
            .ram => if (!region.access.read or !region.access.write)
                @panic("memory regions tagged as `ram` must be both readable and writable"),
            else => {},
        }
    }

    pub const Tag = enum {
        /// This is a (normally) immutable memory region where the code is stored.
        flash,

        /// This is a mutable memory region for data storage.
        ram,

        /// No tag.
        none,
    };

    pub const Access = struct {
        pub const r: Access = .{ .read = true };
        pub const w: Access = .{ .write = true };
        pub const x: Access = .{ .execute = true };
        pub const rw: Access = .{ .read = true, .write = true };
        pub const rx: Access = .{ .read = true, .execute = true };
        pub const rwx: Access = .{ .read = true, .write = true, .execute = true };

        /// Is the memory region readable?
        read: bool = false,

        /// Is the memory region writable?
        write: bool = false,

        /// Is the memory region executable?
        execute: bool = false,
    };
};
