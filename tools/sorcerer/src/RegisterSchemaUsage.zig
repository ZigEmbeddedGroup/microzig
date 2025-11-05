format: Format,
chips: []const Chip,
boards: []const Board,
location: Location,

const std = @import("std");
pub const Format = enum {
    svd,
    atdf,
    embassy,
};

pub const Chip = struct {
    name: []const u8,
};

pub const Board = struct {
    name: []const u8,
};

pub const Location = union(enum) {
    src_path: struct {
        //owner: *std.Build,
        port_name: []const u8,
        sub_path: []const u8,
        build_root: []const u8,
    },
    dependency: struct {
        //dependency: *std.Build.Dependency,
        sub_path: []const u8,
        build_root: []const u8,
        dep_name: []const u8,
        port_name: []const u8,
    },
};
