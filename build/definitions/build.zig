const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;

pub fn build(b: *Build) void {
    _ = b.addModule("definitions", .{
        .root_source_file = b.path("build.zig"),
    });
}

/// A cpu descriptor.
pub const Cpu = struct {
    /// Display name of the CPU.
    name: []const u8,

    /// Source file providing startup code and memory initialization routines.
    root_source_file: LazyPath,

    /// The compiler target we use to compile all the code.
    target: std.Target.Query,
};

/// Defines a custom microcontroller.
pub const Chip = struct {
    /// The display name of the controller.
    name: []const u8,

    /// (optional) link to the documentation/vendor page of the controller.
    url: ?[]const u8 = null,

    /// The cpu model this controller uses.
    cpu: Cpu,

    /// The provider for register definitions.
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

    /// The memory regions that are present in this chip.
    memory_regions: []const MemoryRegion,
};

/// Defines a hardware abstraction layer.
pub const HardwareAbstractionLayer = struct {
    /// Root source file for this HAL.
    root_source_file: LazyPath,
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
    root_source_file: LazyPath,
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
