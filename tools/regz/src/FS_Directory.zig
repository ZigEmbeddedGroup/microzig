io: std.Io,
dir: std.Io.Dir,

const vtable = Directory.VTable{
    .create_file = create_file,
};

pub fn create_file(ctx: *anyopaque, filename: []const u8, contents: []const u8) Directory.CreateFileError!void {
    const fs: *FS_Directory = @ptrCast(@alignCast(ctx));
    const file: std.Io.File = if (std.fs.path.dirname(filename)) |dirname| blk: {
        var dir = fs.dir.createDirPathOpen(fs.io, dirname, .{}) catch return error.System;
        defer dir.close(fs.io);

        break :blk dir.createFile(fs.io, std.fs.path.basename(filename), .{}) catch return error.System;
    } else fs.dir.createFile(fs.io, filename, .{}) catch return error.System;
    defer file.close(fs.io);

    file.writeStreamingAll(fs.io, contents) catch return error.System;
}

pub fn init(io: std.Io, dir: std.Io.Dir) FS_Directory {
    return FS_Directory{
        .io = io,
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
