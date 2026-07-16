//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Dir = std.Io.Dir;
const File = std.Io.File;
const log = std.log.scoped(.vio);

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

    const Map = std.AutoArrayHashMapUnmanaged(ID, Node);

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
            return switch (op) {
                .file_write_streaming => |write_op| .{
                    .file_write_streaming = vio.file_write_streaming(write_op),
                },
                .file_read_streaming => .{ .file_read_streaming = error.InputOutput },
                .device_io_control => unreachable,
                .net_receive => .{ .net_receive = .{ error.NetworkDown, 0 } },
                .net_read => .{ .net_read = error.NetworkDown },
            };
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

        fn dir_open_file(
            userdata: ?*anyopaque,
            dir: Dir,
            sub_path: []const u8,
            _: Dir.OpenFileOptions,
        ) File.OpenError!File {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            return try vio.dir_open_file(dir, sub_path) orelse error.FileNotFound;
        }

        fn file_close(_: ?*anyopaque, _: []const File) void {}
    };

    ret.operate = VTable.operate;
    ret.dirCreateDirPathOpen = VTable.create_dir_path_open;
    ret.dirClose = VTable.dir_close;
    ret.dirCreateFile = VTable.dir_create_file;
    ret.dirOpenFile = VTable.dir_open_file;
    ret.fileClose = VTable.file_close;

    const ret_const = ret;
    break :blk &ret_const;
};

// Don't use file descriptor 0, because on windows, fd_t is actually a *anyopaque,
// and setting that null under the hood is ILLEGAL, and I don't want to go to jail.
const root_dir_handle = 1;
pub const root_dir: Dir = .{
    .handle = handle_from_int(root_dir_handle),
};

gpa: Allocator,
nodes: Node.Map,
// child -> parent
hierarchy: std.AutoArrayHashMapUnmanaged(Node.ID, Dir),
last_id: u16,

pub fn io(vio: *VirtualIo) std.Io {
    return .{ .userdata = vio, .vtable = vtable };
}

pub fn init(gpa: Allocator) !VirtualIo {
    var nodes: Node.Map = .empty;
    try nodes.put(gpa, root_dir.handle, .{ .name = "", .kind = .dir });
    return .{
        .gpa = gpa,
        .nodes = nodes,
        .hierarchy = .empty,
        .last_id = root_dir_handle,
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

pub fn file_content(vio: *VirtualIo, file: File) ![]const u8 {
    const node = vio.nodes.getPtr(file.handle) orelse
        return error.Unexpected;
    return switch (node.kind) {
        .file => |*w| w.written(),
        .dir => error.Unexpected,
    };
}

fn dir_open_file(vio: *VirtualIo, dir: Dir, path: []const u8) !?File {
    var it = vio.hierarchy.iterator();
    const idx_opt = std.mem.findScalar(u8, path, '/');
    while (it.next()) |entry| {
        if (entry.value_ptr.handle != dir.handle)
            continue;
        const id = entry.key_ptr.*;
        const child = vio.nodes.getPtr(id).?;

        if (idx_opt) |idx| {
            if (child.kind != .dir) continue;

            return try vio.dir_open_file(
                .{ .handle = id },
                path[idx + 1 ..],
            ) orelse continue;
        } else {
            if (child.kind != .file) continue;

            if (std.mem.eql(u8, child.name, path))
                return .{
                    .handle = id,
                    .flags = .{ .nonblocking = false },
                };
        }
    }
    return null;
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

fn file_write_streaming(vio: *VirtualIo, op: std.Io.Operation.FileWriteStreaming) std.Io.Operation.FileWriteStreaming.Result {
    const node = vio.nodes.getPtr(op.file.handle) orelse
        return error.Unexpected;
    const w = switch (node.kind) {
        .file => |*allocating| &allocating.writer,
        .dir => return error.Unexpected,
    };
    return w.writeSplatHeader(
        op.header,
        op.data,
        op.splat,
    ) catch error.NoSpaceLeft;
}

fn handle_from_int(int: u16) Node.ID {
    return switch (builtin.os.tag) {
        .windows => @ptrFromInt(int),
        else => int,
    };
}
