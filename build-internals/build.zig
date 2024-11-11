const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

pub fn build(b: *Build) void {
    _ = b.addModule("build-internals", .{
        .root_source_file = b.path("build.zig"),
    });
}

/// MicroZig target definition.
pub const Target = struct {
    dep: *Build.Dependency,

    chip: Chip,

    hal: ?ModuleDeclaration = null,

    board: ?ModuleDeclaration = null,

    linker_script: ?LazyPath = null,

    patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,

    preferred_binary_format: ?BinaryFormat = null,

    pub const DeriveOptions = struct {
        chip: ?Chip = null,
        hal: ?ModuleDeclaration = null,
        board: ?ModuleDeclaration = null,
        linker_script: ?LazyPath = null,
        patch_elf: ?*const fn (*Build.Dependency, LazyPath) LazyPath = null,
        preferred_binary_format: ?BinaryFormat = null,
    };

    pub fn derive(from: Target, options: DeriveOptions) *Target {
        const ret = from.dep.builder.allocator.create(Target) catch @panic("out of memory");
        ret.* = .{
            .dep = from.dep,
            .chip = options.chip orelse from.chip,
            .hal = options.hal orelse from.hal,
            .board = options.board orelse from.board,
            .linker_script = options.linker_script orelse from.linker_script,
            .patch_elf = options.patch_elf orelse from.patch_elf,
            .preferred_binary_format = options.preferred_binary_format orelse from.preferred_binary_format,
        };
        return ret;
    }
};

/// MicroZig chip definition.
pub const Chip = struct {
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
};

/// Helper struct that provides info for module creation by MicroZig.
pub const ModuleDeclaration = struct {
    root_source_file: LazyPath,
    imports: []const Module.Import,

    pub fn init(b: *Build, options: struct {
        root_source_file: LazyPath,
        imports: []const Module.Import = &.{},
    }) ModuleDeclaration {
        const allocated_imports = b.allocator.dupe(Module.Import, options.imports) catch @panic("out of memory");
        return .{
            .root_source_file = options.root_source_file,
            .imports = allocated_imports,
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
    uf2: enum {
        ATMEGA32,
        SAML21,
        NRF52,
        ESP32,
        STM32L1,
        STM32L0,
        STM32WL,
        LPC55,
        STM32G0,
        GD32F350,
        STM32L5,
        STM32G4,
        MIMXRT10XX,
        STM32F7,
        SAMD51,
        STM32F4,
        FX2,
        STM32F2,
        STM32F1,
        NRF52833,
        STM32F0,
        SAMD21,
        STM32F3,
        STM32F407,
        STM32H7,
        STM32WB,
        ESP8266,
        KL32L2,
        STM32F407VG,
        NRF52840,
        ESP32S2,
        ESP32S3,
        ESP32C3,
        ESP32C2,
        ESP32H2,
        RP2040,
        RP2XXX_ABSOLUTE,
        RP2XXX_DATA,
        RP2350_ARM_S,
        RP2350_RISC_V,
        RP2350_ARM_NS,
        STM32L4,
        GD32VF103,
        CSK4,
        CSK6,
        M0SENSE,
    },

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
