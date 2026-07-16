//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Io = std.Io;
const log = std.log.scoped(.vio);

pub const Dir = struct {
    inner: std.StringHashMapUnmanaged(Node.ID) = .empty,

    pub fn from_std(vio: *const VirtualIo, dir: Io.Dir) !*Dir {
        return from_id(vio, try .from_handle(dir.handle));
    }

    pub fn from_id(vio: *const VirtualIo, id: Node.ID) !*Dir {
        const node = vio.nodes.getPtr(id) orelse
            return error.Unexpected;
        return switch (node.*) {
            .dir => |*ret| ret,
            else => error.NotDir,
        };
    }

    pub fn sub_path(parent: *Dir, vio: *const VirtualIo, path: []const u8) !Node.ID {
        var dir = parent;
        var path_tail = path;
        while (std.mem.findScalar(u8, path_tail, '/')) |idx| {
            dir = try .from_id(vio, dir.inner.get(path_tail[0..idx]) orelse
                return error.FileNotFound);
            path_tail = path_tail[idx + 1 ..];
        }
        return dir.inner.get(path_tail) orelse error.FileNotFound;
    }

    pub fn create_node(dir: *Dir, vio: *VirtualIo, name: []const u8, comptime kind: Node.Kind) !Node.ID {
        if (std.mem.findScalar(u8, name, '/') != null) {
            log.err("name includes '/': '{s}'", .{name});
            return error.BadPathName;
        }

        const id: Node.ID = try vio.last_id.next();
        vio.last_id = id;

        const name_owned = vio.gpa.dupe(u8, name) catch return error.NoSpaceLeft;
        errdefer vio.gpa.free(name_owned);

        if (dir.inner.getOrPut(vio.gpa, name_owned)) |result| {
            if (result.found_existing)
                return error.PathAlreadyExists;

            result.value_ptr.* = id;
        } else |_| return error.NoSpaceLeft;

        if (vio.nodes.getOrPut(vio.gpa, id)) |result| {
            if (result.found_existing)
                return error.PathAlreadyExists;

            result.value_ptr.* = switch (kind) {
                .file => .{ .file = .{} },
                .dir => .{ .dir = .{} },
            };
        } else |_| return error.NoSpaceLeft;

        return id;
    }
};

pub const File = struct {
    inner: std.ArrayList(u8) = .empty,

    pub fn from_std(vio: *const VirtualIo, file: Io.File) !*File {
        return from_id(vio, try .from_handle(file.handle));
    }

    pub fn from_id(vio: *const VirtualIo, id: Node.ID) !*File {
        const node = vio.nodes.getPtr(id) orelse
            return error.Unexpected;
        return switch (node.*) {
            .file => |*ret| ret,
            .dir => error.IsDir,
        };
    }

    pub fn write_streaming(
        vio: *const VirtualIo,
        op: Io.Operation.FileWriteStreaming,
    ) Io.Operation.FileWriteStreaming.Result {
        const file = File.from_std(vio, op.file) catch
            return error.Unexpected;
        var allocating: Io.Writer.Allocating = .fromArrayList(vio.gpa, &file.inner);
        defer file.inner = allocating.toArrayList();
        return allocating.writer.writeSplatHeader(op.header, op.data, op.splat) catch
            error.NoSpaceLeft;
    }
};

pub const Node = union(enum) {
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

    file: File,
    dir: Dir,

    pub fn destroy(node: *Node, gpa: Allocator) void {
        switch (node.*) {
            .file => |*file| file.inner.deinit(gpa),
            .dir => |*dir| {
                var it = dir.inner.keyIterator();
                while (it.next()) |name|
                    gpa.free(name.*);
                dir.inner.deinit(gpa);
            },
        }
    }
};

pub const VirtualIo = @This();

pub const vtable: *const Io.VTable = blk: {
    const VTable = struct {
        fn operate(userdata: ?*anyopaque, op: Io.Operation) Io.Cancelable!Io.Operation.Result {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            return switch (op) {
                .file_write_streaming => |write_op| .{
                    .file_write_streaming = File.write_streaming(vio, write_op),
                },
                .file_read_streaming => .{ .file_read_streaming = error.InputOutput },
                .device_io_control => unreachable,
                .net_receive => .{ .net_receive = .{ error.NetworkDown, 0 } },
                .net_read => .{ .net_read = error.NetworkDown },
            };
        }

        fn create_dir_path_open(
            userdata: ?*anyopaque,
            dir: Io.Dir,
            sub_path: []const u8,
            _: Io.Dir.Permissions,
            _: Io.Dir.OpenOptions,
        ) Io.Dir.CreateDirPathOpenError!Io.Dir {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            const parent = try Dir.from_std(vio, dir);
            const ret = try parent.create_node(vio, sub_path, .dir);
            return .{ .handle = ret.to_handle() };
        }

        fn dir_close(_: ?*anyopaque, _: []const Io.Dir) void {}

        fn dir_create_file(
            userdata: ?*anyopaque,
            dir: Io.Dir,
            sub_path: []const u8,
            _: Io.Dir.CreateFileOptions,
        ) Io.File.OpenError!Io.File {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            const parent = try Dir.from_std(vio, dir);
            const ret = try parent.create_node(vio, sub_path, .file);
            return .{
                .handle = ret.to_handle(),
                .flags = .{ .nonblocking = false },
            };
        }

        fn dir_open_file(
            userdata: ?*anyopaque,
            dir: Io.Dir,
            sub_path: []const u8,
            _: Io.Dir.OpenFileOptions,
        ) Io.File.OpenError!Io.File {
            const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
            const parent = try Dir.from_std(vio, dir);
            const node = try parent.sub_path(vio, sub_path);
            return .{
                .handle = node.to_handle(),
                .flags = .{ .nonblocking = false },
            };
        }

        fn file_close(_: ?*anyopaque, _: []const Io.File) void {}
    };

    var ret = Io.failing.vtable.*;
    ret.operate = VTable.operate;
    ret.dirCreateDirPathOpen = VTable.create_dir_path_open;
    ret.dirClose = VTable.dir_close;
    ret.dirCreateFile = VTable.dir_create_file;
    ret.dirOpenFile = VTable.dir_open_file;
    ret.fileClose = VTable.file_close;

    const ret_const = ret;
    break :blk &ret_const;
};

pub const root_dir: Io.Dir = .{ .handle = Node.ID.root.to_handle() };

gpa: Allocator,
nodes: Node.Map,
last_id: Node.ID,

pub fn io(vio: *VirtualIo) Io {
    return .{ .userdata = vio, .vtable = vtable };
}

pub fn init(gpa: Allocator) !VirtualIo {
    var nodes: Node.Map = .empty;
    try nodes.put(gpa, .root, .{ .dir = .{} });
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

pub fn file_contents(vio: *const VirtualIo, file: Io.File) !*std.ArrayList(u8) {
    return &(try File.from_std(vio, file)).inner;
}
