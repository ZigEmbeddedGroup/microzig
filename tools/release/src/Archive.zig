files: std.array_hash_map.String(File) = .{},

const Archive = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const Io = std.Io;
const assert = std.debug.assert;
pub const Algo = std.crypto.hash.sha2.Sha256;
pub const max_len = 32 + 1 + 32 + 1 + (32 + 32 + 200) / 6;

const tar = @import("tar.zig");
const Manifest = @import("Manifest.zig");

const log = std.log.scoped(.archive);

pub const File = struct {
    mode: std.Io.File.Permissions,
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


fn path_to_components(allocator: Allocator, path: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .empty;
    defer list.deinit(allocator);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try list.append(allocator, component);

    return list.toOwnedSlice(allocator);
}

const Dir = std.Io.Dir;

// TODO: thread pool it
pub fn read_from_fs(
    allocator: Allocator,
    io: Io,
    root_dir: Dir,
    paths: std.array_hash_map.String(Manifest.PathOrigin),
) !Archive {
    var archive = Archive{};
    errdefer archive.deinit(allocator);

    for (paths.keys(), paths.values()) |path, origin| {
        switch (origin) {
            .in_filesystem => {
                const components = try path_to_components(allocator, path);
                defer allocator.free(components);

                const basename = std.fs.path.basename(path);
                const dir = if (std.fs.path.dirname(path)) |dirname|
                    try root_dir.openDir(io, dirname, .{})
                else
                    root_dir;

                const is_dir = blk: {
                    const stat = dir.statFile(io, basename, .{}) catch |err| {
                        if (err == error.IsDir)
                            break :blk true;

                        log.err("failed to detect if is a directory: '{s}'", .{path});
                        return err;
                    };
                    break :blk stat.kind == .directory;
                };
                if (is_dir) {
                    var collected_dir = try dir.openDir(io, basename, .{
                        .iterate = true,
                    });
                    defer collected_dir.close(io);

                    var walker = try collected_dir.walk(allocator);
                    defer walker.deinit();

                    while (try walker.next(io)) |entry| {
                        switch (entry.kind) {
                            .directory => {},
                            .file => {
                                var path_components: std.ArrayList([]const u8) = .empty;
                                defer path_components.deinit(allocator);

                                try path_components.appendSlice(allocator, components);
                                try path_components.append(allocator, entry.path);

                                const path_copy = try std.fs.path.join(allocator, path_components.items);
                                defer allocator.free(path_copy);

                                const normalized = try normalize_path_alloc(allocator, path_copy);

                                const file = try entry.dir.openFile(io, entry.basename, .{});
                                defer file.close(io);

                                var read_buf: [4096]u8 = undefined;
                                var file_reader = file.reader(io, &read_buf);
                                const text = try file_reader.interface.allocRemaining(allocator, .limited(std.math.maxInt(usize)));
                                errdefer allocator.free(text);

                                const file_stat = try file.stat(io);
                                try archive.files.put(allocator, normalized, .{
                                    .mode = file_stat.permissions,
                                    .kind = .{
                                        .regular = text,
                                    },
                                });
                            },
                            .sym_link => {
                                var path_components: std.ArrayList([]const u8) = .empty;
                                defer path_components.deinit(allocator);

                                try path_components.appendSlice(allocator, components);
                                try path_components.append(allocator, entry.path);

                                const path_copy = try std.fs.path.join(allocator, path_components.items);
                                defer allocator.free(path_copy);

                                var buf: [8000]u8 = undefined;
                                const link_len = try entry.dir.readLink(io, entry.basename, &buf);
                                const link_copy = try allocator.dupe(u8, buf[0..link_len]);

                                if (std.fs.path.sep != canonical_sep) {
                                    normalize_path(link_copy);
                                }

                                const file = try entry.dir.openFile(io, entry.basename, .{});
                                defer file.close(io);

                                const normalized = try normalize_path_alloc(allocator, path_copy);

                                const file_stat = try file.stat(io);

                                try archive.files.put(allocator, normalized, .{
                                    .mode = file_stat.permissions,
                                    .kind = .{
                                        .symlink = link_copy,
                                    },
                                });
                            },
                            else => {
                                // Skip file types we don't handle (e.g. block devices,
                                // character devices, etc.)
                            },
                        }
                    }
                } else {
                    const file = try dir.openFile(io, basename, .{});
                    defer file.close(io);

                    var read_buf: [4096]u8 = undefined;
                    var file_reader = file.reader(io, &read_buf);
                    const text = try file_reader.interface.allocRemaining(allocator, .limited(std.math.maxInt(usize)));
                    errdefer allocator.free(text);

                    const path_copy = try std.fs.path.join(allocator, components);
                    defer allocator.free(path_copy);

                    const file_stat = try file.stat(io);

                    const normalized = try normalize_path_alloc(allocator, path_copy);
                    try archive.files.put(allocator, normalized, .{
                        .mode = file_stat.permissions,
                        .kind = .{
                            .regular = text,
                        },
                    });
                }
            },
            .in_memory => |content| {
                const components = try path_to_components(allocator, path);
                defer allocator.free(components);

                const path_copy = try std.fs.path.join(allocator, components);
                defer allocator.free(path_copy);

                const normalized = try normalize_path_alloc(allocator, path_copy);
                try archive.files.put(allocator, normalized, .{
                    .mode = @fromBackingInt(@intCast(0o777)),
                    .kind = .{
                        .regular = content,
                    },
                });
            },
        }
    }

    return archive;
}

pub fn to_tar_gz(archive: Archive, allocator: Allocator) ![]u8 {
    var buf: std.Io.Writer.Allocating = .init(allocator);
    defer buf.deinit();

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
            .mode = @intCast(@backingInt(file.mode)),
            .linkname = switch (file.kind) {
                .regular => null,
                .symlink => |link| link,
            },
        });

        try buf.writer.writeAll(header.to_bytes());
        switch (file.kind) {
            .regular => |text| {
                try buf.writer.writeAll(text);
                try buf.writer.splatBytesAll(&.{0}, @as(usize, @intCast(padding)));
            },
            .symlink => {},
        }
    }

    try buf.writer.splatBytesAll(&.{0}, 1024);

    var out: std.Io.Writer.Allocating = try .initCapacity(allocator, 16);
    defer out.deinit();

    var gzip_buf: [std.compress.flate.max_window_len * 2]u8 = undefined;
    var gzipper: std.compress.flate.Compress = try .init(&out.writer, &gzip_buf, .gzip, .default);

    try gzipper.writer.writeAll(buf.written());

    try gzipper.finish();
    return out.toOwnedSlice();
}

fn path_less_than(_: void, lhs: []const u8, rhs: []const u8) bool {
    return std.mem.lessThan(u8, lhs, rhs);
}

pub const WhatToDoWithExecutableBit = enum {
    ignore_executable_bit,
    include_executable_bit,
};

pub const multihash_function: MultihashFunction = switch (Algo) {
    std.crypto.hash.sha2.Sha256 => .@"sha2-256",
    else => @compileError("unreachable"),
};

pub const Digest = [Algo.digest_length]u8;
pub const multihash_len = 1 + 1 + Algo.digest_length;
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

    result[0] = hex_charset[@backingInt(multihash_function) >> 4];
    result[1] = hex_charset[@backingInt(multihash_function) & 15];

    result[2] = hex_charset[Algo.digest_length >> 4];
    result[3] = hex_charset[Algo.digest_length & 15];

    for (digest, 0..) |byte, i| {
        result[4 + i * 2] = hex_charset[byte >> 4];
        result[5 + i * 2] = hex_charset[byte & 15];
    }
    return result;
}

pub fn hash(
    archive: Archive,
    gpa: Allocator,
    name: []const u8,
    semver: std.SemanticVersion,
    id: u32,
) ![]const u8 {
    if (name.len > 32)
        return error.NameTooLong;

    var ver_buf: [32]u8 = undefined;
    const ver = try std.fmt.bufPrint(&ver_buf, "{f}", .{semver});

    const archive_hash = try archive.hash_files(gpa);

    var hashplus: [33]u8 = undefined;
    std.mem.writeInt(u32, hashplus[0..4], id, .little);
    std.mem.writeInt(u32, hashplus[4..8], archive_hash.size, .little);
    hashplus[8..].* = archive_hash.digest[0..25].*;

    var buf: [80]u8 = undefined;
    const hashplus_str = std.base64.url_safe_no_pad.Encoder.encode(&buf, &hashplus);

    return try std.fmt.allocPrint(gpa, "{s}-{s}-{s}", .{ name, ver, hashplus_str });
}

const ArchiveHash = struct {
    digest: Digest,
    size: u32,
};

// TODO: threadpool this
fn hash_files(
    archive: Archive,
    allocator: Allocator,
) !ArchiveHash {
    var paths: std.ArrayList([]const u8) = .empty;
    defer paths.deinit(allocator);

    var hashes: std.ArrayList([Algo.digest_length]u8) = .empty;
    defer hashes.deinit(allocator);

    try paths.appendSlice(allocator, archive.files.keys());
    try hashes.appendNTimes(allocator, undefined, paths.items.len);
    std.mem.sortUnstable([]const u8, paths.items, {}, path_less_than);

    var size: u32 = 0;
    for (paths.items, hashes.items) |path, *result| {
        const file = archive.files.get(path).?;
        var hasher = Algo.init(.{});
        hasher.update(path);

        switch (file.kind) {
            .regular => |text| {
                // hardcode executable bit to false
                hasher.update(&.{ 0, 0 });
                hasher.update(text);

                size +%= @intCast(text.len);
            },
            .symlink => |symlink| {
                const link_name = try normalize_path_alloc(allocator, symlink);
                hasher.update(link_name);
            },
        }
        hasher.final(result);
    }

    var hasher = Algo.init(.{});
    for (hashes.items) |file_hash| {
        hasher.update(&file_hash);
    }

    const digest = hasher.finalResult();
    return ArchiveHash{
        .digest = digest,
        .size = size,
    };
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
