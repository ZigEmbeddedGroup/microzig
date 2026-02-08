const std = @import("std");
const Allocator = std.mem.Allocator;
const Database = @import("Database.zig");
const Arch = @import("arch.zig").Arch;

pub const Patch = union(enum) {
    pub const Type = union(enum) {
        pub const EnumField = struct {
            name: []const u8,
            description: ?[]const u8 = null,
            value: u32,
        };

        pub const Enum = struct {
            description: ?[]const u8 = null,
            bitsize: u8,
            fields: []const EnumField = &.{},
        };

        @"enum": Enum,
    };

    override_arch: struct {
        device_name: []const u8,
        arch: Arch,
    },
    set_device_property: struct {
        device_name: []const u8,
        key: []const u8,
        value: []const u8,
        description: ?[]const u8 = null,
    },
    add_interrupt: struct {
        device_name: []const u8,
        idx: i32,
        name: []const u8,
        description: ?[]const u8 = null,
    },
    add_type: struct {
        parent: []const u8,
        type_name: []const u8,
        type: Type,
    },
    /// The replaced type MUST be the same size. Bit or Byte size depends on the
    /// context
    set_enum_type: struct {
        of: []const u8,
        to: ?[]const u8,
    },
    /// Creates a new type in the specified parent struct and applies it
    /// to all the specified field references. This is a convenience patch that
    /// combines `add_type` with multiple `set_enum_type` operations.
    add_type_and_apply: struct {
        parent: []const u8,
        type_name: []const u8,
        type: Type,
        apply_to: []const []const u8,
    },
};
