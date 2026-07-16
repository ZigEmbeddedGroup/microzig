//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Dir = std.Io.Dir;
const File = std.Io.File;
const log = std.log.scoped(.vio);
const Map = std.AutoArrayHashMapUnmanaged;

pub const Node = struct {
    pub const ID = std.posix.fd_t;

    pub const Kind = union(enum) {
        file: std.Io.Writer.Allocating,
        dir,
    };

    pub const CreateInfo = union(std.meta.Tag(Kind)) {
        file: []const u8,
        dir,
    };

    name: []const u8,
    kind: Kind,

    pub fn destroy(node: *Node, gpa: Allocator) void {
        gpa.free(node.name);
        switch (node.kind) {
            .file => |*w| w.deinit(),
            .dir => {},
        }
    }
};

pub const VirtualIo = @This();

pub const vtable: *const std.Io.VTable = blk: {
    var ret = std.Io.failing.vtable.*;

    const VTable = struct {
        fn operate(userdata: ?*anyopaque, op: std.Io.Operation) std.Io.Cancelable!std.Io.Operation.Result {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            switch (op) {
                .file_write_streaming => |write_op| {
                    const node = vio.nodes.getPtr(write_op.file.handle).?;
                    const w = switch (node.kind) {
                        .file => |*allocating| &allocating.writer,
                        .dir => unreachable,
                    };
                    return .{
                        .file_write_streaming = w.writeSplatHeader(
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

        fn create_dir_path_open(
            userdata: ?*anyopaque,
            dir: Dir,
            sub_path: []const u8,
            _: Dir.Permissions,
            _: Dir.OpenOptions,
        ) Dir.CreateDirPathOpenError!Dir {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            return .{
                .handle = try vio.create_node(dir, sub_path, .dir),
            };
        }

        fn dir_close(_: ?*anyopaque, _: []const Dir) void {}

        fn dir_create_file(
            userdata: ?*anyopaque,
            dir: Dir,
            sub_path: []const u8,
            _: Dir.CreateFileOptions,
        ) File.OpenError!File {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            return .{
                .handle = try vio.create_node(dir, sub_path, .{ .file = "" }),
                .flags = .{ .nonblocking = false },
            };
        }

        fn file_close(_: ?*anyopaque, _: []const File) void {}
    };

    ret.operate = VTable.operate;
    ret.dirCreateDirPathOpen = VTable.create_dir_path_open;
    ret.dirClose = VTable.dir_close;
    ret.dirCreateFile = VTable.dir_create_file;
    ret.fileClose = VTable.file_close;

    const ret_const = ret;
    break :blk &ret_const;
};

// Don't use file descriptor 0, because on windows, fd_t is actually a *anyopaque,
// and setting that null under the hood is ILLEGAL, and I don't want to go to jail.
pub const root_dir: Dir = .{ .handle = handle_from_int(1) };

gpa: Allocator,
nodes: Map(Node.ID, Node) = .empty,
// child -> parent
hierarchy: Map(Node.ID, Dir) = .empty,
last_id: u16 = switch (builtin.os.tag) {
    .windows => @intFromPtr(root_dir.handle),
    else => root_dir.handle,
},

pub fn io(vio: *VirtualIo) std.Io {
    return .{ .userdata = vio, .vtable = vtable };
}

pub fn init(gpa: Allocator) VirtualIo {
    return VirtualIo{
        .gpa = gpa,
    };
}

pub fn deinit(vio: *VirtualIo) void {
    for (vio.nodes.values()) |*node|
        node.destroy(vio.gpa);
    vio.nodes.deinit(vio.gpa);
    vio.hierarchy.deinit(vio.gpa);
}

pub fn total_file_count(vio: *VirtualIo) usize {
    var ret: usize = 0;
    var it = vio.nodes.iterator();
    while (it.next()) |entry| {
        if (entry.value_ptr.kind == .file)
            ret += 1;
    }
    return ret;
}

pub fn file_content(vio: *VirtualIo, file: File) []const u8 {
    const node = vio.nodes.getPtr(file.handle).?;
    return switch (node.kind) {
        .file => |*w| w.written(),
        .dir => unreachable,
    };
}

pub fn get_file(vio: *VirtualIo, path: []const u8) !?File {
    var components: std.ArrayList([]const u8) = .empty;
    defer components.deinit(vio.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        components.append(vio.gpa, component) catch
            return error.NoSpaceLeft;

    return vio.recursive_get_file(0, root_dir, components.items);
}

fn recursive_get_file(vio: *VirtualIo, depth: usize, dir: Dir, components: []const []const u8) !?File {
    const children = try vio.get_children(vio.gpa, dir);
    defer vio.gpa.free(children);

    switch (components.len) {
        0 => {},
        1 => for (children) |id| {
            const child = vio.nodes.getPtr(id).?;

            if (child.kind != .file)
                continue;

            if (std.mem.eql(u8, child.name, components[0]))
                return .{
                    .handle = id,
                    .flags = .{ .nonblocking = false },
                };
        },
        else => for (children) |id| {
            const child = vio.nodes.getPtr(id).?;

            if (child.kind != .dir)
                continue;

            return try vio.recursive_get_file(
                depth + 1,
                .{ .handle = id },
                components[1..],
            ) orelse continue;
        },
    }
    return null;
}

fn get_children(vio: *VirtualIo, allocator: Allocator, dir: Dir) ![]Node.ID {
    var ret: std.ArrayList(Node.ID) = .empty;
    var it = vio.hierarchy.iterator();
    while (it.next()) |entry| {
        if (entry.value_ptr.handle == dir.handle)
            ret.append(allocator, entry.key_ptr.*) catch
                return error.NoSpaceLeft;
    }
    return ret.toOwnedSlice(allocator) catch
        return error.NoSpaceLeft;
}

fn create_node(vio: *VirtualIo, dir: Dir, sub_path: []const u8, info: Node.CreateInfo) !Node.ID {
    if (std.mem.findScalar(u8, sub_path, '/') != null) {
        log.err("path includes '/': '{s}'", .{sub_path});
        return error.BadPathName;
    }

    const node: Node = .{
        .name = vio.gpa.dupe(u8, sub_path) catch
            return error.NoSpaceLeft,
        .kind = switch (info) {
            .file => |content| blk: {
                var w: std.Io.Writer.Allocating = .init(vio.gpa);
                w.writer.writeAll(content) catch
                    return error.NoSpaceLeft;
                break :blk .{ .file = w };
            },
            .dir => .dir,
        },
    };

    vio.last_id += 1;
    const handle = handle_from_int(vio.last_id);

    vio.nodes.put(vio.gpa, handle, node) catch
        return error.NoSpaceLeft;
    vio.hierarchy.put(vio.gpa, handle, dir) catch
        return error.NoSpaceLeft;

    return handle;
}

fn handle_from_int(int: u16) Node.ID {
    return switch (builtin.os.tag) {
        .windows => @ptrFromInt(int),
        else => int,
    };
}
