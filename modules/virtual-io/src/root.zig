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

pub const root_dir: std.Io.Dir = .{ .handle = handle_from_id(ID.root) };

gpa: Allocator,
directories: Map(ID, Dir) = .empty,
files: Map(ID, File) = .empty,
// child -> parent
hierarchy: Map(ID, ID) = .empty,
last_id: u16 = switch (builtin.os.tag) {
    .windows => @intFromPtr(root_dir.handle),
    else => root_dir.handle,
},

fn id_from_handle(handle: std.posix.fd_t) ID {
    return @enumFromInt(switch (builtin.os.tag) {
        .windows => @intFromPtr(handle),
        else => handle,
    });
}

fn handle_from_id(id: ID) std.posix.fd_t {
    return switch (builtin.os.tag) {
        .windows => @ptrFromInt(@intFromEnum(id)),
        else => @intFromEnum(id),
    };
}

pub const Dir = struct {
    name: []const u8,

    pub fn deinit(d: *Dir, gpa: Allocator) void {
        gpa.free(d.name);
    }

    fn create_file(userdata: ?*anyopaque, dir: std.Io.Dir, sub_path: []const u8, _: std.Io.Dir.CreateFileOptions) std.Io.File.OpenError!std.Io.File {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
        const dir_id = id_from_handle(dir.handle);

        if (std.mem.findScalar(u8, sub_path, '/') != null) {
            log.err("path includes '/': '{s}'", .{sub_path});
            return error.BadPathName;
        }

        const id = vio.create_file(dir_id, sub_path) catch |err| switch (err) {
            error.OutOfMemory => return error.NoSpaceLeft,
        };
        return .{
            .handle = handle_from_id(id),
            .flags = .{
                .nonblocking = false,
            },
        };
    }

    fn create_dir_path_open(
        userdata: ?*anyopaque,
        parent_dir: std.Io.Dir,
        sub_path: []const u8,
        _: std.Io.Dir.Permissions,
        _: std.Io.Dir.OpenOptions,
    ) std.Io.Dir.CreateDirPathOpenError!std.Io.Dir {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
        const parent = id_from_handle(parent_dir.handle);
        const id = vio.create_dir(parent, sub_path) catch return error.NoSpaceLeft;

        return .{
            .handle = handle_from_id(id),
        };
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
    return switch (op) {
        .file_write_streaming => |write_op| blk: {
            const file = vio.files.getPtr(id_from_handle(write_op.file.handle)).?;
            const header = write_op.header;
            const data = write_op.data;
            const splat = write_op.splat;
            break :blk .{
                .file_write_streaming = file.content.writer.writeSplatHeader(header, data, splat) catch error.NoSpaceLeft,
            };
        },
        .file_read_streaming => unreachable,
        .device_io_control => unreachable,
        .net_receive => unreachable,
        .net_read => unreachable,
    };
}

pub const ID = enum(u16) {
    // Don't use this one, because on windows, fd_t is actually a *anyopaque,
    // and setting that null under the hood is ILLEGAL, and I don't want to go
    // to jail.
    invalid = 0,
    root = 1,
    _,
};

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

pub fn get_file(vio: *VirtualIo, path: []const u8) !?ID {
    var components: std.ArrayList([]const u8) = .empty;
    defer components.deinit(vio.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try components.append(vio.gpa, component);

    return vio.recursive_get_file(0, .root, components.items);
}

fn recursive_get_file(vio: *VirtualIo, depth: usize, dir_id: ID, components: []const []const u8) !?ID {
    return switch (components.len) {
        0 => null,
        1 => blk: {
            const children = try vio.get_children(vio.gpa, dir_id);
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
            const children = try vio.get_children(vio.gpa, dir_id);
            defer vio.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .directory)
                    continue;

                break try vio.recursive_get_file(depth + 1, child.id, components[1..]) orelse continue;
            } else null;
        },
    };
}

pub const Entry = struct {
    id: ID,
    kind: Kind,
};

pub fn get_children(vio: *VirtualIo, allocator: Allocator, id: ID) ![]const Entry {
    var ret: std.ArrayList(Entry) = .empty;
    for (vio.hierarchy.keys(), vio.hierarchy.values()) |child_id, parent_id| {
        if (parent_id == id)
            try ret.append(allocator, .{
                .id = child_id,
                .kind = vio.get_kind(child_id),
            });
    }
    return ret.toOwnedSlice(allocator);
}

fn create_dir(vio: *VirtualIo, parent: ID, name: []const u8) !ID {
    vio.last_id += 1;
    const id: ID = @enumFromInt(vio.last_id);

    const name_copy = try vio.gpa.dupe(u8, name);
    try vio.directories.put(vio.gpa, id, .{
        .name = name_copy,
    });

    try vio.hierarchy.put(vio.gpa, id, parent);

    return id;
}

fn create_file(vio: *VirtualIo, parent: ID, name: []const u8) !ID {
    vio.last_id += 1;
    const id: ID = @enumFromInt(vio.last_id);

    const name_copy = try vio.gpa.dupe(u8, name);
    try vio.files.put(vio.gpa, id, .{
        .name = name_copy,
        .content = .init(vio.gpa),
    });

    try vio.hierarchy.put(vio.gpa, id, parent);

    return id;
}

pub fn get_kind(vio: *VirtualIo, id: ID) Kind {
    return if (vio.files.contains(id))
        .file
    else if (vio.directories.contains(id))
        .directory
    else
        unreachable;
}

pub fn get_name(vio: *VirtualIo, id: ID) []const u8 {
    return if (vio.files.get(id)) |f|
        f.name
    else if (vio.directories.get(id)) |d|
        d.name
    else
        unreachable;
}

pub fn get_content(vio: *VirtualIo, id: ID) []const u8 {
    assert(vio.get_kind(id) == .file);
    return vio.files.get(id).?.content.writer.buffered();
}

fn get_child(vio: *VirtualIo, parent: ID, component: []const u8) ?ID {
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
