//! Filesystem to store generated files
gpa: Allocator,
map: std.StringArrayHashMapUnmanaged([]const u8) = .{},

const std = @import("std");
const Allocator = std.mem.Allocator;

const regz = @import("regz");
const Directory = regz.Database.Directory;

const VirtualFilesystem = @This();

pub fn init(gpa: Allocator) VirtualFilesystem {
    return VirtualFilesystem{
        .gpa = gpa,
    };
}

pub fn deinit(fs: *VirtualFilesystem) void {
    for (fs.map.keys(), fs.map.values()) |path, content| {
        fs.gpa.free(path);
        fs.gpa.free(content);
    }

    fs.map.deinit(fs.gpa);
}

pub fn dir(fs: *VirtualFilesystem) Directory {
    return Directory{
        .ptr = @ptrCast(fs),
        .vtable = &.{
            .create_file = create_file,
        },
    };
}

fn create_file(ctx: *anyopaque, path: []const u8, content: []const u8) Directory.CreateFileError!void {
    const fs: *VirtualFilesystem = @ptrCast(@alignCast(ctx));
    const path_copy = try fs.gpa.dupe(u8, path);
    const content_copy = try fs.gpa.dupe(u8, content);
    // TODO: clean up collisions
    try fs.map.put(fs.gpa, path_copy, content_copy);
}
