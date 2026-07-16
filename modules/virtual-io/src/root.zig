//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Dir = std.Io.Dir;
const File = std.Io.File;
const log = std.log.scoped(.vio);

pub const Node = union(enum) {
    pub const ID = std.posix.fd_t;

    pub const CreateInfo = union(std.meta.Tag(Node)) {
        file: []const u8,
        dir,
    };

    const Map = std.AutoArrayHashMapUnmanaged(ID, Node);
    const Directory = std.StringHashMapUnmanaged(ID);

    file: std.Io.Writer.Allocating,
    dir: Directory,

    pub fn destroy(node: *Node, gpa: Allocator) void {
        switch (node.*) {
            .file => |*w| w.deinit(),
            .dir => |*entries| {
                var it = entries.keyIterator();
                while (it.next()) |name|
                    gpa.free(name.*);
                entries.deinit(gpa);
            },
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
            const node_id = try vio.get_node(dir, sub_path);
            const node = vio.nodes.get(node_id) orelse
                return error.FileNotFound;
            return switch (node) {
                .file => .{
                    .handle = node_id,
                    .flags = .{ .nonblocking = false },
                },
                .dir => error.IsDir,
            };
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
last_id: u16,

pub fn io(vio: *VirtualIo) std.Io {
    return .{ .userdata = vio, .vtable = vtable };
}

pub fn init(gpa: Allocator) !VirtualIo {
    var nodes: Node.Map = .empty;
    try nodes.put(gpa, root_dir.handle, .{ .dir = .empty });
    return .{
        .gpa = gpa,
        .nodes = nodes,
        .last_id = root_dir_handle,
    };
}

pub fn deinit(vio: *VirtualIo) void {
    for (vio.nodes.values()) |*node|
        node.destroy(vio.gpa);
    vio.nodes.deinit(vio.gpa);
}

pub fn total_file_count(vio: *const VirtualIo) usize {
    var ret: usize = 0;
    var it = vio.nodes.iterator();
    while (it.next()) |entry| {
        if (entry.value_ptr.* == .file)
            ret += 1;
    }
    return ret;
}

pub fn get_node(vio: *const VirtualIo, dir: Dir, path: []const u8) !Node.ID {
    const idx_opt = std.mem.findScalar(u8, path, '/');
    const path_part = path[0 .. idx_opt orelse path.len];

    const dir_node = vio.nodes.getEntry(dir.handle) orelse
        return error.Unexpected;

    const id = switch (dir_node.value_ptr.*) {
        .dir => |d| d.get(path_part) orelse return error.FileNotFound,
        else => return error.FileNotFound,
    };

    if (idx_opt) |idx| {
        return try vio.get_node(.{ .handle = id }, path[idx + 1 ..]);
    } else return id;
}

fn create_node(vio: *VirtualIo, dir: Dir, sub_path: []const u8, info: Node.CreateInfo) !Node.ID {
    if (std.mem.findScalar(u8, sub_path, '/') != null) {
        log.err("path includes '/': '{s}'", .{sub_path});
        return error.BadPathName;
    }

    const node: Node = switch (info) {
        .file => |content| blk: {
            var w: std.Io.Writer.Allocating = .init(vio.gpa);
            w.writer.writeAll(content) catch
                return error.NoSpaceLeft;
            break :blk .{ .file = w };
        },
        .dir => .{ .dir = .empty },
    };

    vio.last_id += 1;
    const handle = handle_from_int(vio.last_id);

    vio.nodes.put(vio.gpa, handle, node) catch
        return error.NoSpaceLeft;

    const dir_node = vio.nodes.getPtr(dir.handle) orelse
        return error.Unexpected;

    const name = vio.gpa.dupe(u8, sub_path) catch
        return error.NoSpaceLeft;

    switch (dir_node.*) {
        .dir => |*d| d.put(vio.gpa, name, handle) catch
            return error.NoSpaceLeft,
        else => return error.Unexpected,
    }

    return handle;
}

fn file_write_streaming(vio: *VirtualIo, op: std.Io.Operation.FileWriteStreaming) std.Io.Operation.FileWriteStreaming.Result {
    const node = vio.nodes.getPtr(op.file.handle) orelse
        return error.Unexpected;
    const w = switch (node.*) {
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
