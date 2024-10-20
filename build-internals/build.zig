const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

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
        convert: *const fn (*Custom, elf: Build.LazyPath) Build.LazyPath,
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
