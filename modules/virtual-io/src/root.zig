//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const log = std.log.scoped(.vio);
const Map = std.AutoArrayHashMapUnmanaged;

pub const Kind = enum(u1) {
    file,
    directory,
};

pub const VirtualIo = @This();

pub const vtable: std.Io.VTable = blk: {
    var ret = std.Io.failing.vtable.*;

    ret.operate = operate;
    ret.dirCreateDirPathOpen = Dir.create_dir_path_open;
    ret.dirClose = Dir.close;
    ret.dirCreateFile = Dir.create_file;
    ret.fileClose = File.close;

    break :blk ret;
};

// Don't use file descriptor 0, because on windows, fd_t is actually a *anyopaque,
// and setting that null under the hood is ILLEGAL, and I don't want to go to jail.
pub const root_dir: std.Io.Dir = .{ .handle = handle_from_int(1) };

gpa: Allocator,
directories: Map(std.Io.Dir, Dir) = .empty,
files: Map(std.posix.fd_t, File) = .empty,
// child -> parent
hierarchy: Map(std.posix.fd_t, std.Io.Dir) = .empty,
last_id: u16 = switch (builtin.os.tag) {
    .windows => @intFromPtr(root_dir.handle),
    else => root_dir.handle,
},

fn handle_from_int(int: u16) std.posix.fd_t {
    return switch (builtin.os.tag) {
        .windows => @ptrFromInt(int),
        else => int,
    };
}

pub const Dir = struct {
    name: []const u8,

    pub fn deinit(d: *Dir, gpa: Allocator) void {
        gpa.free(d.name);
    }

    fn create_file(
        userdata: ?*anyopaque,
        dir: std.Io.Dir,
        sub_path: []const u8,
        _: std.Io.Dir.CreateFileOptions,
    ) std.Io.File.OpenError!std.Io.File {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));

        if (std.mem.findScalar(u8, sub_path, '/') != null) {
            log.err("path includes '/': '{s}'", .{sub_path});
            return error.BadPathName;
        }

        return .{
            .handle = vio.create_file(dir, sub_path) catch |err| switch (err) {
                error.OutOfMemory => return error.NoSpaceLeft,
            },
            .flags = .{ .nonblocking = false },
        };
    }

    fn create_dir_path_open(
        userdata: ?*anyopaque,
        dir: std.Io.Dir,
        sub_path: []const u8,
        _: std.Io.Dir.Permissions,
        _: std.Io.Dir.OpenOptions,
    ) std.Io.Dir.CreateDirPathOpenError!std.Io.Dir {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
        return vio.create_dir(dir, sub_path) catch return error.NoSpaceLeft;
    }

    fn close(_: ?*anyopaque, _: []const std.Io.Dir) void {}
};

pub const File = struct {
    name: []const u8,
    content: std.Io.Writer.Allocating,

    pub fn deinit(f: *File, gpa: Allocator) void {
        gpa.free(f.name);
        f.content.deinit();
    }

    pub fn close(_: ?*anyopaque, _: []const std.Io.File) void {}
};

fn operate(userdata: ?*anyopaque, op: std.Io.Operation) std.Io.Cancelable!std.Io.Operation.Result {
    const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
    switch (op) {
        .file_write_streaming => |write_op| {
            const file = vio.files.getPtr(write_op.file.handle).?;
            return .{
                .file_write_streaming = file.content.writer.writeSplatHeader(
                    write_op.header,
                    write_op.data,
                    write_op.splat,
                ) catch error.NoSpaceLeft,
            };
        },
        .file_read_streaming => unreachable,
        .device_io_control => unreachable,
        .net_receive => unreachable,
        .net_read => unreachable,
    }
}

pub fn init(gpa: Allocator) VirtualIo {
    return VirtualIo{
        .gpa = gpa,
    };
}

pub fn deinit(vio: *VirtualIo) void {
    for (vio.directories.values()) |*directory| directory.deinit(vio.gpa);
    for (vio.files.values()) |*file| file.deinit(vio.gpa);

    vio.directories.deinit(vio.gpa);
    vio.files.deinit(vio.gpa);
    vio.hierarchy.deinit(vio.gpa);
}

pub fn get_file(vio: *VirtualIo, path: []const u8) !?std.posix.fd_t {
    var components: std.ArrayList([]const u8) = .empty;
    defer components.deinit(vio.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try components.append(vio.gpa, component);

    return vio.recursive_get_file(0, root_dir, components.items);
}

fn recursive_get_file(vio: *VirtualIo, depth: usize, dir: std.Io.Dir, components: []const []const u8) !?std.posix.fd_t {
    return switch (components.len) {
        0 => null,
        1 => blk: {
            const children = try vio.get_children(vio.gpa, dir);
            defer vio.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .file)
                    continue;

                const name = vio.get_name(child.id);
                if (std.mem.eql(u8, name, components[0]))
                    break child.id;
            } else null;
        },
        else => blk: {
            const children = try vio.get_children(vio.gpa, dir);
            defer vio.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .directory)
                    continue;

                break try vio.recursive_get_file(depth + 1, .{ .handle = child.id }, components[1..]) orelse continue;
            } else null;
        },
    };
}

pub const Entry = struct {
    id: std.posix.fd_t,
    kind: Kind,
};

pub fn get_children(vio: *VirtualIo, allocator: Allocator, dir: std.Io.Dir) ![]const Entry {
    var ret: std.ArrayList(Entry) = .empty;
    for (vio.hierarchy.keys(), vio.hierarchy.values()) |child_id, parent| {
        if (parent.handle == dir.handle)
            try ret.append(allocator, .{
                .id = child_id,
                .kind = vio.get_kind(child_id),
            });
    }
    return ret.toOwnedSlice(allocator);
}

fn create_dir(vio: *VirtualIo, parent: std.Io.Dir, name: []const u8) !std.Io.Dir {
    vio.last_id += 1;
    const dir: std.Io.Dir = .{ .handle = handle_from_int(vio.last_id) };

    const name_copy = try vio.gpa.dupe(u8, name);
    try vio.directories.put(vio.gpa, dir, .{
        .name = name_copy,
    });

    try vio.hierarchy.put(vio.gpa, dir.handle, parent);

    return dir;
}

fn create_file(vio: *VirtualIo, parent: std.Io.Dir, name: []const u8) !std.posix.fd_t {
    vio.last_id += 1;
    const id = handle_from_int(vio.last_id);

    const name_copy = try vio.gpa.dupe(u8, name);
    try vio.files.put(vio.gpa, id, .{
        .name = name_copy,
        .content = .init(vio.gpa),
    });

    try vio.hierarchy.put(vio.gpa, id, parent);

    return id;
}

pub fn get_kind(vio: *VirtualIo, id: std.posix.fd_t) Kind {
    return if (vio.files.contains(id))
        .file
    else if (vio.directories.contains(.{ .handle = id }))
        .directory
    else
        unreachable;
}

pub fn get_name(vio: *VirtualIo, id: std.posix.fd_t) []const u8 {
    return if (vio.files.get(id)) |f|
        f.name
    else if (vio.directories.get(.{ .handle = id })) |d|
        d.name
    else
        unreachable;
}

pub fn get_content(vio: *VirtualIo, id: std.posix.fd_t) []const u8 {
    assert(vio.get_kind(id) == .file);
    return vio.files.get(id).?.content.writer.buffered();
}

fn get_child(vio: *VirtualIo, parent: std.Io.Dir, component: []const u8) ?std.posix.fd_t {
    return for (vio.hierarchy.keys(), vio.hierarchy.values()) |child_id, entry_parent_id| {
        if (entry_parent_id == parent and std.mem.eql(u8, component, vio.get_name(child_id)))
            break child_id;
    } else null;
}

pub fn io(vio: *VirtualIo) std.Io {
    return .{
        .userdata = vio,
        .vtable = &vtable,
    };
}
