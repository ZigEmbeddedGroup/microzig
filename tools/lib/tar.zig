//!
//! Extracted from https://github.com/mattnite/ezpkg.
//!

const std = @import("std");
const builtin = @import("builtin");

const testing = std.testing;
const Allocator = std.mem.Allocator;

// ustar tar implementation
pub const Header = extern struct {
    name: [100]u8,
    mode: [7:0]u8,
    uid: [7:0]u8,
    gid: [7:0]u8,
    size: [11:0]u8,
    mtime: [11:0]u8,
    checksum: [7:0]u8,
    typeflag: FileType,
    linkname: [100]u8,
    magic: [5:0]u8,
    version: [2]u8,
    uname: [31:0]u8,
    gname: [31:0]u8,
    devmajor: [7:0]u8,
    devminor: [7:0]u8,
    prefix: [155]u8,
    pad: [12]u8,

    comptime {
        std.debug.assert(@sizeOf(Header) == 512);
    }

    const Self = @This();

    const FileType = enum(u8) {
        regular = '0',
        hard_link = '1',
        symbolic_link = '2',
        character = '3',
        block = '4',
        directory = '5',
        fifo = '6',
        reserved = '7',
        pax_global = 'g',
        extended = 'x',
        _,
    };

    const Options = struct {
        typeflag: FileType,
        path: []const u8,
        size: u64,
        mode: std.fs.File.Mode,
    };

    pub fn to_bytes(header: *const Header) *const [512]u8 {
        return @ptrCast(header);
    }

    pub fn init(opts: Options) !Self {
        var ret = std.mem.zeroes(Self);
        ret.magic = [_:0]u8{ 'u', 's', 't', 'a', 'r' };
        ret.version = [_:0]u8{ '0', '0' };
        ret.typeflag = opts.typeflag;

        try ret.setPath(opts.path);
        try ret.setSize(opts.size);
        try ret.setMtime(0);
        try ret.setMode(opts.typeflag, opts.mode);
        try ret.setUid(0);
        try ret.setGid(0);

        std.mem.copy(u8, &ret.uname, "root");
        std.mem.copy(u8, &ret.gname, "root");

        try ret.updateChecksum();
        return ret;
    }

    pub fn setPath(self: *Self, path: []const u8) !void {
        if (path.len > 100) {
            var i: usize = 100;
            while (i > 0) : (i -= 1) {
                if (path[i] == '/' and i < 100)
                    break;
            }

            _ = try std.fmt.bufPrint(&self.prefix, "{s}", .{path[0..i]});
            _ = try std.fmt.bufPrint(&self.name, "{s}", .{path[i + 1 ..]});
        } else {
            _ = try std.fmt.bufPrint(&self.name, "{s}", .{path});
        }
    }

    pub fn setSize(self: *Self, size: u64) !void {
        _ = try std.fmt.bufPrint(&self.size, "{o:0>11}", .{size});
    }

    pub fn get_size(header: Header) !u64 {
        return std.fmt.parseUnsigned(u64, &header.size, 8);
    }

    pub fn setMtime(self: *Self, mtime: u32) !void {
        _ = try std.fmt.bufPrint(&self.mtime, "{o:0>11}", .{mtime});
    }

    pub fn setMode(self: *Self, filetype: FileType, perm: std.fs.File.Mode) !void {
        switch (filetype) {
            .regular => _ = try std.fmt.bufPrint(&self.mode, "0{o:0>6}", .{perm}),
            .directory => _ = try std.fmt.bufPrint(&self.mode, "0{o:0>6}", .{perm}),
            else => return error.Unsupported,
        }
    }

    pub fn get_mode(header: Header) !std.fs.File.Mode {
        std.log.info("mode str: {s}", .{&header.mode});
        return std.fmt.parseUnsigned(std.fs.File.Mode, &header.mode, 8);
    }

    fn setUid(self: *Self, uid: u32) !void {
        _ = try std.fmt.bufPrint(&self.uid, "{o:0>7}", .{uid});
    }

    fn setGid(self: *Self, gid: u32) !void {
        _ = try std.fmt.bufPrint(&self.gid, "{o:0>7}", .{gid});
    }

    pub fn updateChecksum(self: *Self) !void {
        const offset = @offsetOf(Self, "checksum");
        var checksum: usize = 0;
        for (std.mem.asBytes(self), 0..) |val, i| {
            checksum += if (i >= offset and i < offset + @sizeOf(@TypeOf(self.checksum)))
                ' '
            else
                val;
        }

        _ = try std.fmt.bufPrint(&self.checksum, "{o:0>7}", .{checksum});
    }

    pub fn fromStat(stat: std.fs.File.Stat, path: []const u8) !Header {
        if (std.mem.indexOf(u8, path, "\\") != null) return error.NeedPosixPath;
        if (std.fs.path.isAbsolute(path)) return error.NeedRelPath;

        var ret = Self.init();
        ret.typeflag = switch (stat.kind) {
            .File => .regular,
            .Directory => .directory,
            else => return error.UnsupportedType,
        };

        try ret.setPath(path);
        try ret.setSize(stat.size);
        try ret.setMtime(@as(u32, @truncate(@as(u128, @bitCast(@divTrunc(stat.mtime, std.time.ns_per_s))))));
        try ret.setMode(ret.typeflag, @as(u9, @truncate(stat.mode)));

        try ret.setUid(0);
        try ret.setGid(0);

        std.mem.copy(u8, &ret.uname, "root");
        std.mem.copy(u8, &ret.gname, "root");

        try ret.updateChecksum();
        return ret;
    }

    pub fn isBlank(self: *const Header) bool {
        const block = std.mem.asBytes(self);
        return for (block) |elem| {
            if (elem != 0) break false;
        } else true;
    }
};

test "Header size" {
    try testing.expectEqual(512, @sizeOf(Header));
}

pub fn instantiate(
    allocator: Allocator,
    dir: std.fs.Dir,
    reader: anytype,
    skip_depth: usize,
) !void {
    var count: usize = 0;
    while (true) {
        const header = reader.readStruct(Header) catch |err| {
            return if (err == error.EndOfStream)
                if (count < 2) error.AbrubtEnd else break
            else
                err;
        };

        if (header.isBlank()) {
            count += 1;
            continue;
        } else if (count > 0) {
            return error.Format;
        }

        var size = try std.fmt.parseUnsigned(usize, &header.size, 8);
        const block_size = ((size + 511) / 512) * 512;
        var components = std.ArrayList([]const u8).init(allocator);
        defer components.deinit();

        var path_it = std.mem.tokenize(u8, &header.prefix, "/\x00");
        if (header.prefix[0] != 0) {
            while (path_it.next()) |component| {
                try components.append(component);
            }
        }

        path_it = std.mem.tokenize(u8, &header.name, "/\x00");
        while (path_it.next()) |component| {
            try components.append(component);
        }

        const tmp_path = try std.fs.path.join(allocator, components.items);
        defer allocator.free(tmp_path);

        if (skip_depth >= components.items.len) {
            try reader.skipBytes(block_size, .{});
            continue;
        }

        var i: usize = 0;
        while (i < skip_depth) : (i += 1) {
            _ = components.orderedRemove(0);
        }

        const file_path = try std.fs.path.join(allocator, components.items);
        defer allocator.free(file_path);

        switch (header.typeflag) {
            .directory => try dir.makePath(file_path),
            .pax_global => try reader.skipBytes(512, .{}),
            .regular => {
                const file = try dir.createFile(file_path, .{ .read = true, .truncate = true });
                defer file.close();
                const skip_size = block_size - size;

                var buf: [std.mem.page_size]u8 = undefined;
                while (size > 0) {
                    const buffered = try reader.read(buf[0..std.math.min(size, 512)]);
                    try file.writeAll(buf[0..buffered]);
                    size -= buffered;
                }

                try reader.skipBytes(skip_size, .{});
            },
            else => {},
        }
    }
}

pub fn builder(allocator: Allocator, writer: anytype) Builder(@TypeOf(writer)) {
    return Builder(@TypeOf(writer)).init(allocator, writer);
}

pub fn Builder(comptime Writer: type) type {
    return struct {
        writer: Writer,
        arena: std.heap.ArenaAllocator,
        directories: std.StringHashMap(void),

        const Self = @This();

        pub fn init(allocator: Allocator, writer: Writer) Self {
            return Self{
                .arena = std.heap.ArenaAllocator.init(allocator),
                .writer = writer,
                .directories = std.StringHashMap(void).init(allocator),
            };
        }

        pub fn deinit(self: *Self) void {
            self.directories.deinit();
            self.arena.deinit();
        }

        pub fn finish(self: *Self) !void {
            try self.writer.writeByteNTimes(0, 1024);
        }

        fn maybeAddDirectories(
            self: *Self,
            path: []const u8,
        ) !void {
            var i: usize = 0;
            while (i < path.len) : (i += 1) {
                while (path[i] != '/' and i < path.len) i += 1;
                if (i >= path.len) break;
                const dirpath = try self.arena.allocator().dupe(u8, path[0..i]);
                if (self.directories.contains(dirpath)) continue else try self.directories.put(dirpath, {});

                const stat = std.fs.File.Stat{
                    .inode = undefined,
                    .size = 0,
                    .mode = switch (builtin.os.tag) {
                        .windows => 0,
                        else => 0o755,
                    },
                    .kind = .Directory,
                    .atime = undefined,
                    .mtime = std.time.nanoTimestamp(),
                    .ctime = undefined,
                };
                const allocator = self.arena.child_allocator;
                const posix_dirpath = try std.mem.replaceOwned(u8, allocator, dirpath, std.fs.path.sep_str_windows, std.fs.path.sep_str_posix);
                defer allocator.free(posix_dirpath);

                const header = try Header.fromStat(stat, posix_dirpath);
                try self.writer.writeAll(std.mem.asBytes(&header));
            }
        }

        /// prefix is a path to prepend subpath with
        pub fn addFile(
            self: *Self,
            root: std.fs.Dir,
            prefix: ?[]const u8,
            subpath: []const u8,
        ) !void {
            const allocator = self.arena.child_allocator;
            const path = if (prefix) |prefix_path|
                try std.fs.path.join(allocator, &[_][]const u8{ prefix_path, subpath })
            else
                subpath;
            defer if (prefix != null) allocator.free(path);

            const posix_path = try std.mem.replaceOwned(u8, allocator, path, std.fs.path.sep_str_windows, std.fs.path.sep_str_posix);
            defer allocator.free(posix_path);

            if (std.fs.path.dirname(posix_path)) |dirname|
                try self.maybeAddDirectories(posix_path[0 .. dirname.len + 1]);
            const subfile = try root.openFile(subpath, .{ .mode = .read_write });
            defer subfile.close();

            const stat = try subfile.stat();
            const header = try Header.fromStat(stat, posix_path);
            var buf: [std.mem.page_size]u8 = undefined;

            try self.writer.writeAll(std.mem.asBytes(&header));
            var counter = std.io.countingWriter(self.writer);

            while (true) {
                const n = try subfile.reader().read(&buf);
                if (n == 0) break;

                try counter.writer().writeAll(buf[0..n]);
            }

            const padding = blk: {
                const mod = counter.bytes_written % 512;
                break :blk if (mod > 0) 512 - mod else 0;
            };
            try self.writer.writeByteNTimes(0, @as(usize, @intCast(padding)));
        }

        /// add slice of bytes as file `path`
        pub fn addSlice(self: *Self, slice: []const u8, path: []const u8) !void {
            const allocator = self.arena.child_allocator;
            const posix_path = try std.mem.replaceOwned(u8, allocator, path, std.fs.path.sep_str_windows, std.fs.path.sep_str_posix);
            defer allocator.free(posix_path);

            const stat = std.fs.File.Stat{
                .inode = undefined,
                .size = slice.len,
                .mode = switch (builtin.os.tag) {
                    .windows => 0,
                    else => 0o644,
                },
                .kind = .File,
                .atime = undefined,
                .mtime = std.time.nanoTimestamp(),
                .ctime = undefined,
            };

            var header = try Header.fromStat(stat, posix_path);
            const padding = blk: {
                const mod = slice.len % 512;
                break :blk if (mod > 0) 512 - mod else 0;
            };
            try self.writer.writeAll(std.mem.asBytes(&header));
            try self.writer.writeAll(slice);
            try self.writer.writeByteNTimes(0, padding);
        }
    };
}

pub const PaxHeaderMap = struct {
    text: []const u8,
    map: std.StringHashMap([]const u8),

    const Self = @This();

    pub fn init(allocator: Allocator, reader: anytype) !Self {
        // TODO: header verification
        const header = try reader.readStruct(Header);
        if (header.typeflag != .pax_global) return error.NotPaxGlobalHeader;

        const size = try std.fmt.parseInt(usize, &header.size, 8);
        const text = try allocator.alloc(u8, size);
        errdefer allocator.free(text);

        var i: usize = 0;
        while (i < size) : (i = try reader.read(text[i..])) {}

        var map = std.StringHashMap([]const u8).init(allocator);
        errdefer map.deinit();

        var it = std.mem.tokenize(u8, text, "\n");
        while (it.next()) |line| {
            const begin = (std.mem.indexOf(u8, line, " ") orelse return error.BadMapEntry) + 1;
            const eql = std.mem.indexOf(u8, line[begin..], "=") orelse return error.BadMapEntry;
            try map.put(line[begin .. begin + eql], line[begin + eql + 1 ..]);
        }

        return Self{
            .text = text,
            .map = map,
        };
    }

    pub fn get(self: Self, key: []const u8) ?[]const u8 {
        return self.map.get(key);
    }

    pub fn deinit(self: *Self) void {
        self.map.allocator.free(self.text);
        self.map.deinit();
    }
};

pub fn fileExtractor(path: []const u8, reader: anytype) FileExtractor(@TypeOf(reader)) {
    return FileExtractor(@TypeOf(reader)).init(path, reader);
}

pub fn FileExtractor(comptime ReaderType: type) type {
    return struct {
        path: []const u8,
        internal: ReaderType,
        len: ?usize,

        const Self = @This();

        pub fn init(path: []const u8, internal: ReaderType) Self {
            return Self{
                .path = path,
                .internal = internal,
                .len = null,
            };
        }

        pub const Error = ReaderType.Error || error{ FileNotFound, EndOfStream } || std.fmt.ParseIntError;
        pub const Reader = std.io.Reader(*Self, Error, read);

        pub fn read(self: *Self, buf: []u8) Error!usize {
            if (self.len == null) {
                while (true) {
                    const header = try self.internal.readStruct(Header);
                    for (std.mem.asBytes(&header)) |c| {
                        if (c != 0) break;
                    } else return error.FileNotFound;
                    const size = try std.fmt.parseInt(usize, &header.size, 8);
                    const name = header.name[0 .. std.mem.indexOf(u8, &header.name, "\x00") orelse header.name.len];
                    if (std.mem.eql(u8, name, self.path)) {
                        self.len = size;
                        break;
                    } else if (size > 0) {
                        try self.internal.skipBytes(size + (512 - (size % 512)), .{});
                    }
                }
            }

            const n = try self.internal.read(buf[0..std.math.min(self.len.?, buf.len)]);
            self.len.? -= n;
            return n;
        }

        pub fn reader(self: *Self) Reader {
            return .{ .context = self };
        }
    };
}
