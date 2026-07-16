//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Dir = std.Io.Dir;
const File = std.Io.File;
const log = std.log.scoped(.vio);

pub const Node = union(enum) {
    pub const Dir = std.StringHashMapUnmanaged(ID);
    pub const File = std.ArrayList(u8);
    pub const Kind = std.meta.Tag(Node);
    pub const Map = std.AutoArrayHashMapUnmanaged(ID, Node);

    pub const ID = enum(u16) {
        const Backing = @Int(.unsigned, @bitSizeOf(ID));

        // Reserve first 256 file handles for os-specific values, such as sitdin/out/err
        // on posix, cwd on wasm and the reserved NULL value on windows.
        root = 0x100,
        _,

        pub fn from_handle(handle: std.posix.fd_t) !ID {
            return if (std.math.cast(Backing, switch (builtin.os.tag) {
                .windows => @intFromPtr(handle),
                else => handle,
            })) |int|
                @enumFromInt(int)
            else
                error.Unexpected;
        }

        pub fn to_handle(id: ID) std.posix.fd_t {
            return switch (builtin.os.tag) {
                .windows => @ptrFromInt(@intFromEnum(id)),
                else => @intFromEnum(id),
            };
        }

        fn next(prev: ID) !ID {
            return if (std.math.add(Backing, @intFromEnum(prev), 1)) |int|
                @enumFromInt(int)
            else |_|
                error.Unexpected;
        }
    };

    file: Node.File,
    dir: Node.Dir,

    pub fn destroy(node: *Node, gpa: Allocator) void {
        switch (node.*) {
            .file => |*w| w.deinit(gpa),
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
                .handle = (try vio.create_node(try .from_handle(dir.handle), sub_path, .dir)).to_handle(),
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
                .handle = (try vio.create_node(try .from_handle(dir.handle), sub_path, .file)).to_handle(),
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
            const node_id = try vio.get_node(try .from_handle(dir.handle), sub_path);
            const node = vio.nodes.get(node_id) orelse
                return error.FileNotFound;
            return switch (node) {
                .file => .{
                    .handle = node_id.to_handle(),
                    .flags = .{ .nonblocking = false },
                },
                .dir => error.IsDir,
            };
        }

        fn file_close(_: ?*anyopaque, _: []const File) void {}
    };

    var ret = std.Io.failing.vtable.*;
    ret.operate = VTable.operate;
    ret.dirCreateDirPathOpen = VTable.create_dir_path_open;
    ret.dirClose = VTable.dir_close;
    ret.dirCreateFile = VTable.dir_create_file;
    ret.dirOpenFile = VTable.dir_open_file;
    ret.fileClose = VTable.file_close;

    const ret_const = ret;
    break :blk &ret_const;
};

pub const root_dir: Dir = .{ .handle = Node.ID.root.to_handle() };

gpa: Allocator,
nodes: Node.Map,
last_id: Node.ID,

pub fn io(vio: *VirtualIo) std.Io {
    return .{ .userdata = vio, .vtable = vtable };
}

pub fn init(gpa: Allocator) !VirtualIo {
    var nodes: Node.Map = .empty;
    try nodes.put(gpa, .root, .{ .dir = .empty });
    return .{
        .gpa = gpa,
        .nodes = nodes,
        .last_id = .root,
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

pub fn get_node(vio: *const VirtualIo, dir: Node.ID, path: []const u8) !Node.ID {
    const idx_opt = std.mem.findScalar(u8, path, '/');
    const path_part = path[0 .. idx_opt orelse path.len];

    const dir_node = vio.nodes.getEntry(dir) orelse
        return error.Unexpected;

    const id = switch (dir_node.value_ptr.*) {
        .dir => |d| d.get(path_part) orelse return error.FileNotFound,
        else => return error.FileNotFound,
    };

    if (idx_opt) |idx| {
        return try vio.get_node(id, path[idx + 1 ..]);
    } else return id;
}

fn create_node(vio: *VirtualIo, dir: Node.ID, sub_path: []const u8, kind: Node.Kind) !Node.ID {
    if (std.mem.findScalar(u8, sub_path, '/') != null) {
        log.err("path includes '/': '{s}'", .{sub_path});
        return error.BadPathName;
    }

    const node: Node = switch (kind) {
        .file => .{ .file = .empty },
        .dir => .{ .dir = .empty },
    };

    const id: Node.ID = try vio.last_id.next();
    vio.last_id = id;

    vio.nodes.put(vio.gpa, id, node) catch
        return error.NoSpaceLeft;

    const dir_node = vio.nodes.getPtr(dir) orelse
        return error.Unexpected;

    const name = vio.gpa.dupe(u8, sub_path) catch
        return error.NoSpaceLeft;

    switch (dir_node.*) {
        .dir => |*d| d.put(vio.gpa, name, id) catch
            return error.NoSpaceLeft,
        else => return error.Unexpected,
    }

    return id;
}

fn file_write_streaming(vio: *VirtualIo, op: std.Io.Operation.FileWriteStreaming) std.Io.Operation.FileWriteStreaming.Result {
    const node = vio.nodes.getPtr(try .from_handle(op.file.handle)) orelse
        return error.Unexpected;
    const file = switch (node.*) {
        .file => |*data| data,
        .dir => return error.Unexpected,
    };
    var allocating: std.Io.Writer.Allocating = .fromArrayList(vio.gpa, file);
    defer file.* = allocating.toArrayList();
    return allocating.writer.writeSplatHeader(
        op.header,
        op.data,
        op.splat,
    ) catch error.NoSpaceLeft;
}
