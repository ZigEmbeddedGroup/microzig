const std = @import("std");
const Allocator = std.mem.Allocator;

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
    add_enum: struct {
        parent: []const u8,
        @"enum": Type.Enum,
    },
    /// The replaced type MUST be the same size. Bit or Byte size depends on the
    /// context
    set_enum_type: struct {
        of: []const u8,
        to: []const u8,
    },
    add_interrupt: struct {
        device_name: []const u8,
        idx: i32,
        name: []const u8,
        description: ?[]const u8,
    },

    pub fn from_json_str(allocator: Allocator, json_str: []const u8) !std.json.Parsed(Patch) {
        return std.json.parseFromSlice(Patch, allocator, json_str, .{});
    }
};

/// List for assembling patches in build scripts
pub const PatchList = struct {
    entries: std.ArrayList(Patch),

    pub fn append(list: *PatchList, patch: Patch) void {
        list.append(patch) catch @panic("OOM");
    }
};
