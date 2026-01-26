const std = @import("std");
const Allocator = std.mem.Allocator;
const Database = @import("Database.zig");
const Arch = @import("arch.zig").Arch;

pub const Type = struct {
    pub const EnumField = struct {
        name: []const u8,
        description: ?[]const u8 = null,
        value: u32,
    };

    pub const Enum = struct {
        name: []const u8,
        description: ?[]const u8 = null,
        bitsize: u8,
        fields: []const EnumField = &.{},
    };
};

pub const Patch = union(enum) {
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
    add_enum: struct {
        parent: []const u8,
        @"enum": Type.Enum,
    },
    /// The replaced type MUST be the same size. Bit or Byte size depends on the
    /// context
    set_enum_type: struct {
        of: []const u8,
        to: ?[]const u8,
    },
    add_interrupt: struct {
        device_name: []const u8,
        idx: i32,
        name: []const u8,
        description: ?[]const u8 = null,
    },
    /// Creates a new enum type in the specified parent struct and applies it
    /// to all the specified field references. This is a convenience patch that
    /// combines `add_enum` with multiple `set_enum_type` operations.
    create_enum_and_apply: struct {
        parent: []const u8,
        @"enum": Type.Enum,
        apply_to: []const []const u8,
    },

    pub fn from_json_str(allocator: Allocator, json_str: []const u8) !std.json.Parsed(Patch) {
        return std.json.parseFromSlice(Patch, allocator, json_str, .{});
    }
};

/// List for assembling patches in build scripts
pub const PatchList = struct {
    entries: std.array_list.Managed(Patch),

    pub fn append(list: *PatchList, patch: Patch) void {
        list.append(patch) catch @panic("OOM");
    }
};
