const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

const regz = @import("regz");
pub const Patch = regz.patch.Patch;
const uf2 = @import("uf2");
const FamilyId = uf2.FamilyId;

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

    /// The chip this target uses.
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
    board: ?Board = null,

    /// (optional) Provide a custom linker script for the hardware or define a custom generation.
    linker_script: ?LazyPath = null,

    /// (optional) Post processing step that will patch up and modify the elf file if necessary.
    patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,

    /// Things you can change by deriving from an already existing target.
    pub const DeriveOptions = struct {
        preferred_binary_format: ?BinaryFormat = null,
        chip: ?Chip = null,
        single_threaded: ?bool = null,
        bundle_compiler_rt: ?bool = null,
        hal: ?HardwareAbstractionLayer = null,
        board: ?Board = null,
        linker_script: ?LazyPath = null,
        patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,
    };

    /// Creates a new target from an existing one.
    pub fn derive(from: *const Target, options: DeriveOptions) *Target {
        const ret = from.dep.builder.allocator.create(Target) catch @panic("out of memory");
        ret.* = .{
            .dep = from.dep,
            .preferred_binary_format = options.preferred_binary_format orelse from.preferred_binary_format,
            .chip = options.chip orelse from.chip,
            .single_threaded = options.single_threaded orelse from.single_threaded,
            .bundle_compiler_rt = options.bundle_compiler_rt orelse from.bundle_compiler_rt,
            .hal = options.hal orelse from.hal,
            .board = options.board orelse from.board,
            .linker_script = options.linker_script orelse from.linker_script,
            .patch_elf = options.patch_elf orelse from.patch_elf,
        };
        return ret;
    }
};

/// Defines a chip.
pub const Chip = struct {
    /// The display name of the controller.
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the controller.
    url: ?[]const u8 = null,

    /// The cpu target this controller uses.
    cpu: std.Target.Query,

    /// The cpu specific module file, which contains its startup_logic.
    cpu_module_file: ?LazyPath = null,

    /// The provider for register definitions.
    register_definition: union(enum) {
        /// Use `regz` to create a json file from a SVD schema.
        svd: LazyPath,

        /// Use `regz` to create a zig file from an ATDF schema.
        atdf: LazyPath,

        /// Use the provided file directly as the chip file.
        zig: LazyPath,
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

    /// Provides imports for the HAL. **Need to be heap allocated.**
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

    /// (optional) Provides imports for the board definition. **Need to be heap allocated.**
    imports: []const Module.Import = &.{},
};

/// Convenience struct for heap allocated imports.
pub const ModuleImports = struct {
    /// List of imports.
    list: []const Module.Import = &.{},

    /// Initializes module imports on the heap.
    pub fn init(allocator: std.mem.Allocator, imports: []const Module.Import) ModuleImports {
        return .{
            .list = allocator.dupe(imports) catch @panic("out of memory"),
        };
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
        convert: *const fn (*Build.Dependency, elf: Build.LazyPath) Build.LazyPath,
    };
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
