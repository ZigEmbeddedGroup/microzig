dir: std.fs.Dir,

const vtable = Directory.VTable{
    .create_file = create_file,
};

pub fn create_file(ctx: *anyopaque, filename: []const u8, contents: []const u8) Directory.CreateFileError!void {
    const fs: *FS_Directory = @ptrCast(@alignCast(ctx));
    const file: std.fs.File = if (std.fs.path.dirname(filename)) |dirname| blk: {
        var dir = fs.dir.makeOpenPath(dirname, .{}) catch return error.System;
        defer dir.close();

        break :blk dir.createFile(std.fs.path.basename(filename), .{}) catch return error.System;
    } else fs.dir.createFile(filename, .{}) catch return error.System;
    defer file.close();

    file.writeAll(contents) catch return error.System;
}

pub fn init(dir: std.fs.Dir) FS_Directory {
    return FS_Directory{
        .dir = dir,
    };
}

pub fn directory(fs: *FS_Directory) Directory {
    return Directory{
        .ptr = fs,
        .vtable = &vtable,
    };
}

const FS_Directory = @This();
const std = @import("std");
const Directory = @import("Directory.zig");
