//! In-memory filesystem implementation
const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Io = std.Io;
const log = std.log.scoped(.vio);

pub fn ResultID(T: type) type {
    return switch (T) {
        Dir, File => T.ID,
        else => @compileError("Expected File or Dir, got " ++ @typeName(T)),
    };
}

pub const Dir = struct {
    pub const empty: Node = .{ .dir = .{ .inner = .empty } };
    pub const kind: Node.Kind = empty;

    pub const ID = enum(Node.ID) {
        // Reserve first 256 file handles for os-specific values, such as sitdin/out/err
        // on posix, cwd on wasm and the reserved NULL value on windows.
        root = 0x100,
        _,

        pub fn from_std(dir: Io.Dir) !ID {
            return from_handle(ID, dir.handle);
        }

        pub fn to_std(id: ID) Io.Dir {
            return .{ .handle = to_handle(id) };
        }

        pub fn get(id: ID, vio: *const VirtualIo) !*Dir {
            const node = vio.nodes.getPtr(@intFromEnum(id)) orelse
                return error.Unexpected;
            return switch (node.*) {
                .dir => |*ret| ret,
                else => error.NotDir,
            };
        }
    };

    inner: std.StringHashMapUnmanaged(Node.ID) = .empty,

    pub fn open(parent: *Dir, vio: *const VirtualIo, sub_path: []const u8, T: type) !ResultID(T) {
        var dir = parent;
        var path_tail = sub_path;
        while (std.mem.findScalar(u8, path_tail, '/')) |idx| {
            const next = dir.inner.get(path_tail[0..idx]) orelse
                return error.FileNotFound;
            const node = vio.nodes.getPtr(next) orelse
                return error.Unexpected;
            switch (node.*) {
                .dir => |*d| dir = d,
                .file => return error.FileNotFound,
            }
            path_tail = path_tail[idx + 1 ..];
        }
        const id = dir.inner.get(path_tail) orelse
            return error.FileNotFound;

        // Check that node exists and is the right type
        const node = vio.nodes.get(id);
        if (node == null or node.? != T.kind)
            return error.Unexpected;

        return @enumFromInt(id);
    }

    pub fn create(dir: *Dir, vio: *VirtualIo, name: []const u8, T: type) !ResultID(T) {
        if (std.mem.findScalar(u8, name, '/') != null) {
            log.err("name includes '/': '{s}'", .{name});
            return error.BadPathName;
        }

        const id = vio.last_id + 1;
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

            result.value_ptr.* = T.empty;
        } else |_| return error.NoSpaceLeft;

        return @enumFromInt(id);
    }
};

pub const File = struct {
    pub const empty: Node = .{ .file = .{ .inner = .empty } };
    pub const kind: Node.Kind = empty;

    pub const ID = enum(Node.ID) {
        _,

        pub fn from_std(file: Io.File) !ID {
            return from_handle(ID, file.handle);
        }

        pub fn to_std(id: ID) Io.File {
            return .{
                .handle = to_handle(id),
                .flags = .{ .nonblocking = false },
            };
        }

        pub fn get(id: ID, vio: *const VirtualIo) !*File {
            const node = vio.nodes.getPtr(@intFromEnum(id)) orelse
                return error.Unexpected;
            return switch (node.*) {
                .file => |*ret| ret,
                .dir => error.IsDir,
            };
        }
    };

    inner: std.ArrayList(u8) = .empty,

    pub fn write_streaming(
        vio: *const VirtualIo,
        op: Io.Operation.FileWriteStreaming,
    ) Io.Operation.FileWriteStreaming.Result {
        const file = (try File.ID.from_std(op.file)).get(vio) catch
            return error.Unexpected;
        var allocating: Io.Writer.Allocating = .fromArrayList(vio.gpa, &file.inner);
        defer file.inner = allocating.toArrayList();
        return allocating.writer.writeSplatHeader(op.header, op.data, op.splat) catch
            error.NoSpaceLeft;
    }
};

pub const Node = union(enum) {
    pub const ID = u16;
    pub const Kind = std.meta.Tag(Node);
    pub const Map = std.AutoArrayHashMapUnmanaged(ID, Node);

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
        const parent = try (try Dir.ID.from_std(dir)).get(vio);
        return (try parent.create(vio, sub_path, Dir)).to_std();
    }

    fn dir_close(_: ?*anyopaque, _: []const Io.Dir) void {}

    fn dir_create_file(
        userdata: ?*anyopaque,
        dir: Io.Dir,
        sub_path: []const u8,
        _: Io.Dir.CreateFileOptions,
    ) Io.File.OpenError!Io.File {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
        const parent = try (try Dir.ID.from_std(dir)).get(vio);
        return (try parent.create(vio, sub_path, File)).to_std();
    }

    fn dir_open_file(
        userdata: ?*anyopaque,
        dir: Io.Dir,
        sub_path: []const u8,
        _: Io.Dir.OpenFileOptions,
    ) Io.File.OpenError!Io.File {
        const vio: *VirtualIo = @ptrCast(@alignCast(userdata.?));
        const parent = try (try Dir.ID.from_std(dir)).get(vio);
        return (try parent.open(vio, sub_path, File)).to_std();
    }

    fn file_close(_: ?*anyopaque, _: []const Io.File) void {}
};

pub const VirtualIo = struct {
    pub const root_dir = Dir.ID.root.to_std();

    pub const vtable: *const Io.VTable = blk: {
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

    gpa: Allocator,
    nodes: Node.Map,
    last_id: Node.ID,

    pub fn io(vio: *VirtualIo) Io {
        return .{ .userdata = vio, .vtable = vtable };
    }

    pub fn init(gpa: Allocator) !VirtualIo {
        var ret: VirtualIo = .{
            .gpa = gpa,
            .nodes = .empty,
            .last_id = @intFromEnum(Dir.ID.root),
        };
        try ret.nodes.put(gpa, ret.last_id, Dir.empty);
        return ret;
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
        return &(try (try File.ID.from_std(file)).get(vio)).inner;
    }
};

pub fn from_handle(T: type, handle: std.posix.fd_t) !T {
    const Backing = @Int(.unsigned, @bitSizeOf(T));
    return if (std.math.cast(Backing, switch (builtin.os.tag) {
        .windows => @intFromPtr(handle),
        else => handle,
    })) |int|
        @enumFromInt(int)
    else
        error.Unexpected;
}

pub fn to_handle(id: anytype) std.posix.fd_t {
    // const ID = @TypeOf(id);
    return switch (builtin.os.tag) {
        .windows => @ptrFromInt(@intFromEnum(id)),
        else => @intFromEnum(id),
    };
}
