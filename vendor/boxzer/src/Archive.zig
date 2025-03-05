files: std.StringArrayHashMapUnmanaged(File) = .{},

const Archive = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
pub const Hash = std.crypto.hash.sha2.Sha256;

const builtin = @import("builtin");
const tar = @import("tar.zig");

const log = std.log.scoped(.archive);

pub const File = struct {
    mode: std.fs.File.Mode,
    kind: union(enum) {
        regular: []const u8,
        symlink: []const u8,
    },
};

pub fn deinit(archive: *Archive, allocator: Allocator) void {
    for (archive.files.keys(), archive.files.values()) |path, file| {
        allocator.free(path);
        switch (file.kind) {
            .regular => |text| {
                allocator.free(text);
            },
            .symlink => |link_path| {
                allocator.free(link_path);
            },
        }
    }

    archive.files.deinit(allocator);
}

fn padding_from_size(size: usize) usize {
    const mod = (512 + size) % 512;
    return if (mod > 0) 512 - mod else 0;
}

fn strip_components(path: []const u8, count: u32) ![]const u8 {
    var i: usize = 0;
    var c = count;
    while (c > 0) : (c -= 1) {
        if (std.mem.indexOfScalarPos(u8, path, i, '/')) |pos| {
            i = pos + 1;
        } else {
            return error.TarComponentsOutsideStrippedPrefix;
        }
    }
    return path[i..];
}

const ReadFromTarOptions = struct {
    strip_components: u32,
};

fn path_to_components(allocator: Allocator, path: []const u8) ![]const []const u8 {
    var list = std.ArrayList([]const u8).init(allocator);
    defer list.deinit();

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try list.append(component);

    return list.toOwnedSlice();
}

const Dir = std.fs.Dir;

// TODO: thread pool it
pub fn read_from_fs(
    allocator: Allocator,
    root_dir: Dir,
    paths: std.StringArrayHashMap(void),
) !Archive {
    {
        var buf: [4096]u8 = undefined;
        const dir_path = try root_dir.realpath(".", &buf);
        std.log.err("reading archive from: {s}", .{dir_path});
    }

    var archive = Archive{};
    errdefer archive.deinit(allocator);

    for (paths.keys()) |path| {
        const components = try path_to_components(allocator, path);
        defer allocator.free(components);

        const basename = std.fs.path.basename(path);
        const dir = if (std.fs.path.dirname(path)) |dirname|
            try root_dir.openDir(dirname, .{})
        else
            root_dir;

        const is_dir = blk: {
            const stat = dir.statFile(basename) catch |err| {
                if (err == error.IsDir)
                    break :blk true;
                var buf: [4096]u8 = undefined;
                const dir_path = try dir.realpath(".", &buf);
                std.log.err("Failed to stat file: {s}/{s}, reason: {}", .{ dir_path, path, err });

                return err;
            };
            break :blk stat.kind == .directory;
        };
        if (is_dir) {
            var collected_dir = try dir.openDir(basename, .{
                .iterate = true,
            });
            defer collected_dir.close();
            {
                var buf: [4096]u8 = undefined;
                const dir_path = try collected_dir.realpath(".", &buf);
                std.log.debug("found directory, adding all contents: {s}", .{dir_path});
            }

            var walker = try collected_dir.walk(allocator);
            defer walker.deinit();

            while (try walker.next()) |entry| {
                switch (entry.kind) {
                    .directory => {},
                    .file => {
                        var path_components = std.ArrayList([]const u8).init(allocator);
                        defer path_components.deinit();

                        try path_components.appendSlice(components);
                        try path_components.append(entry.path);

                        const path_copy = try std.fs.path.join(allocator, path_components.items);
                        errdefer allocator.free(path_copy);

                        const normalized = try normalize_path_alloc(allocator, path_copy);

                        const file = try entry.dir.openFile(entry.basename, .{});
                        defer file.close();

                        const text = try file.readToEndAlloc(allocator, std.math.maxInt(usize));
                        errdefer allocator.free(text);

                        std.log.debug("adding file: {s}", .{entry.path});
                        const file_stat = try file.stat();
                        try archive.files.put(allocator, normalized, .{
                            .mode = file_stat.mode,
                            .kind = .{
                                .regular = text,
                            },
                        });
                    },
                    .sym_link => {
                        var path_components = std.ArrayList([]const u8).init(allocator);
                        defer path_components.deinit();

                        try path_components.appendSlice(components);
                        try path_components.append(entry.path);

                        const path_copy = try std.fs.path.join(allocator, path_components.items);
                        errdefer allocator.free(path_copy);

                        var buf: [8000]u8 = undefined;
                        const link_name = try entry.dir.readLink(entry.basename, &buf);
                        const link_copy = try allocator.dupe(u8, link_name);

                        if (std.fs.path.sep != canonical_sep) {
                            normalize_path(link_copy);
                        }

                        const file = try entry.dir.openFile(entry.basename, .{});
                        defer file.close();

                        const normalized = try normalize_path_alloc(allocator, path_copy);

                        const file_stat = try file.stat();
                        std.log.debug("adding symlink: {s} -> {s}", .{
                            normalized,
                            link_copy,
                        });

                        try archive.files.put(allocator, normalized, .{
                            .mode = file_stat.mode,
                            .kind = .{
                                .symlink = link_copy,
                            },
                        });
                    },
                    else => {
                        if (entry.kind != .file) {
                            log.warn("skipping {}: {s}", .{ entry.kind, entry.path });
                            continue;
                        }
                    },
                }
            }
        } else {
            const file = try dir.openFile(basename, .{});
            defer file.close();

            const text = try file.readToEndAlloc(allocator, std.math.maxInt(usize));
            errdefer allocator.free(text);

            const path_copy = try std.fs.path.join(allocator, components);
            errdefer allocator.free(path_copy);

            const file_stat = try file.stat();
            std.log.debug("adding file directly: {s}", .{path_copy});

            const normalized = try normalize_path_alloc(allocator, path_copy);
            try archive.files.put(allocator, normalized, .{
                .mode = file_stat.mode,
                .kind = .{
                    .regular = text,
                },
            });
        }
    }

    return archive;
}

pub fn to_tar_gz(archive: Archive, allocator: Allocator) ![]u8 {
    var in_buf = std.fifo.LinearFifo(u8, .{ .Dynamic = {} }).init(allocator);
    defer in_buf.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    for (archive.files.keys(), archive.files.values()) |path, file| {
        const size = switch (file.kind) {
            .regular => |text| text.len,
            .symlink => 0,
        };
        const padding = padding_from_size(size);
        const header = try tar.Header.init(.{
            .path = path,
            .size = size,
            .typeflag = switch (file.kind) {
                .regular => .regular,
                .symlink => .symbolic_link,
            },
            .mode = @intCast(file.mode),
            .linkname = switch (file.kind) {
                .regular => null,
                .symlink => |link| link,
            },
        });

        try in_buf.writer().writeAll(header.to_bytes());
        switch (file.kind) {
            .regular => |text| {
                try in_buf.writer().writeAll(text);
                try in_buf.writer().writeByteNTimes(0, @as(usize, @intCast(padding)));
            },
            .symlink => {},
        }
    }

    try in_buf.writer().writeByteNTimes(0, 1024);

    var out_buf = std.ArrayList(u8).init(allocator);
    defer out_buf.deinit();

    try std.compress.gzip.compress(in_buf.reader(), out_buf.writer(), .{});

    return out_buf.toOwnedSlice();
}

fn path_less_than(_: void, lhs: []const u8, rhs: []const u8) bool {
    return std.mem.lessThan(u8, lhs, rhs);
}

pub const WhatToDoWithExecutableBit = enum {
    ignore_executable_bit,
    include_executable_bit,
};

pub const multihash_function: MultihashFunction = switch (Hash) {
    std.crypto.hash.sha2.Sha256 => .@"sha2-256",
    else => @compileError("unreachable"),
};

pub const Digest = [Hash.digest_length]u8;
pub const multihash_len = 1 + 1 + Hash.digest_length;
pub const multihash_hex_digest_len = 2 * multihash_len;
pub const MultiHashHexDigest = [multihash_hex_digest_len]u8;
const hex_charset = "0123456789abcdef";

pub const MultihashFunction = enum(u16) {
    identity = 0x00,
    sha1 = 0x11,
    @"sha2-256" = 0x12,
    @"sha2-512" = 0x13,
    @"sha3-512" = 0x14,
    @"sha3-384" = 0x15,
    @"sha3-256" = 0x16,
    @"sha3-224" = 0x17,
    @"sha2-384" = 0x20,
    @"sha2-256-trunc254-padded" = 0x1012,
    @"sha2-224" = 0x1013,
    @"sha2-512-224" = 0x1014,
    @"sha2-512-256" = 0x1015,
    @"blake2b-256" = 0xb220,
    _,
};

pub fn hex_digest(digest: Digest) MultiHashHexDigest {
    var result: MultiHashHexDigest = undefined;

    result[0] = hex_charset[@intFromEnum(multihash_function) >> 4];
    result[1] = hex_charset[@intFromEnum(multihash_function) & 15];

    result[2] = hex_charset[Hash.digest_length >> 4];
    result[3] = hex_charset[Hash.digest_length & 15];

    for (digest, 0..) |byte, i| {
        result[4 + i * 2] = hex_charset[byte >> 4];
        result[5 + i * 2] = hex_charset[byte & 15];
    }
    return result;
}

// TODO: threadpool this
pub fn hash(
    archive: Archive,
    allocator: Allocator,
) !MultiHashHexDigest {
    var timer = try std.time.Timer.start();
    defer {
        const timer_result = timer.read();
        log.info("hash took {} nanoseconds", .{timer_result});
    }

    var paths = std.ArrayList([]const u8).init(allocator);
    defer paths.deinit();

    var hashes = std.ArrayList([Hash.digest_length]u8).init(allocator);
    defer hashes.deinit();

    try paths.appendSlice(archive.files.keys());
    try hashes.appendNTimes(undefined, paths.items.len);
    std.mem.sort([]const u8, paths.items, {}, path_less_than);

    for (paths.items, hashes.items) |path, *result| {
        std.log.debug("getting path: {s}", .{path});
        const file = archive.files.get(path).?;
        var hasher = Hash.init(.{});
        std.log.debug("hashing file", .{});
        std.log.debug("  <- {}", .{std.fmt.fmtSliceEscapeUpper(path)});
        hasher.update(path);

        switch (file.kind) {
            .regular => |text| {
                // hardcode executable bit to false
                std.log.debug("  <- {}", .{std.fmt.fmtSliceEscapeUpper(&.{ 0, 0 })});
                hasher.update(&.{ 0, 0 });
                std.log.debug("  <- <content>", .{});
                hasher.update(text);
            },
            .symlink => |symlink| {
                const link_name = try normalize_path_alloc(allocator, symlink);
                hasher.update(link_name);
                std.log.err("  <- {}", .{std.fmt.fmtSliceEscapeUpper(link_name)});
            },
        }
        hasher.final(result);
        std.log.debug("  -> {}", .{std.fmt.fmtSliceEscapeUpper(result)});
    }

    std.log.debug("hashing package:", .{});
    var hasher = Hash.init(.{});
    for (paths.items, hashes.items) |file_path, file_hash| {
        std.log.debug("  {s}: {}", .{ file_path, std.fmt.fmtSliceHexUpper(&file_hash) });
        hasher.update(&file_hash);
    }

    const result = hex_digest(hasher.finalResult());
    std.log.debug("  RESULT: {s}", .{result});
    return result;
}

const canonical_sep = std.fs.path.sep_posix;

fn normalize_path_alloc(arena: Allocator, pkg_path: []const u8) ![]const u8 {
    const normalized = try arena.dupe(u8, pkg_path);
    if (std.fs.path.sep == canonical_sep) return normalized;
    normalize_path(normalized);
    return normalized;
}

fn normalize_path(bytes: []u8) void {
    assert(std.fs.path.sep != canonical_sep);
    std.mem.replaceScalar(u8, bytes, std.fs.path.sep, canonical_sep);
}

const testing = std.testing;

test "normalize_path_alloc" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try testing.expectEqualStrings("./file", try normalize_path_alloc(allocator, "." ++ std.fs.path.sep_str ++ "file"));
    try testing.expectEqualStrings("src/file", try normalize_path_alloc(allocator, "src/file"));
    try testing.expectEqualStrings("./src/file", try normalize_path_alloc(allocator, "./src/file"));
}
