const std = @import("std");
const Archive = @import("Archive.zig");
const Manifest = @import("Manifest.zig");

const Io = std.Io;
const Allocator = std.mem.Allocator;

/// A test fixture defining a package to hash.
const TestPackage = struct {
    name: []const u8,
    version: []const u8,
    fingerprint: u64,
    files: []const TestFile,
};

const TestFile = struct {
    path: []const u8,
    content: []const u8,
};

/// Compute the CRC32 checksum of a package name to build a valid fingerprint.
fn fingerprintFor(name: []const u8, id: u32) u64 {
    const crc = std.hash.Crc32.hash(name);
    // packed struct(u64) { id: u32, checksum: u32 } => checksum in high bits
    return (@as(u64, crc) << 32) | @as(u64, id);
}

/// Creates a temporary directory with the given files, returning the path.
/// Caller must clean up the directory.
fn createTempPackage(
    allocator: Allocator,
    io: Io,
    test_dir_name: []const u8,
    files: []const TestFile,
) ![]const u8 {
    const tmp_path = try std.fmt.allocPrint(allocator, "/tmp/release-test-{s}", .{test_dir_name});
    // Clean up any leftover
    std.Io.Dir.cwd().deleteTree(io, tmp_path) catch {};
    _ = try std.Io.Dir.cwd().createDirPathOpen(io, tmp_path, .{});

    var pkg_dir = try std.Io.Dir.cwd().openDir(io, tmp_path, .{});
    defer pkg_dir.close(io);

    for (files) |f| {
        // Create parent directories if needed
        if (std.fs.path.dirname(f.path)) |dirname| {
            pkg_dir.createDirPath(io, dirname) catch |err| switch (err) {
                error.PathAlreadyExists => {},
                else => return err,
            };
        }
        const file = try pkg_dir.createFile(io, f.path, .{});
        defer file.close(io);
        var write_buf: [4096]u8 = undefined;
        var writer = file.writer(io, &write_buf);
        try writer.interface.writeAll(f.content);
        try writer.interface.flush();
    }

    return tmp_path;
}

/// Builds an Archive from the given package files and computes the hash,
/// then compares with `zig fetch` on the equivalent tarball.
fn verifyHashMatches(
    allocator: Allocator,
    io: Io,
    pkg: TestPackage,
) !void {
    const tmp_path = try createTempPackage(allocator, io, pkg.name, pkg.files);
    defer {
        std.Io.Dir.cwd().deleteTree(io, tmp_path) catch {};
        allocator.free(tmp_path);
    }

    // Build the paths map for Archive.read_from_fs
    var paths: std.array_hash_map.String(Manifest.PathOrigin) = .empty;
    defer paths.deinit(allocator);
    for (pkg.files) |f| {
        try paths.put(allocator, try allocator.dupe(u8, f.path), .in_filesystem);
    }
    defer {
        for (paths.keys()) |k| allocator.free(k);
    }

    // Read the archive from the filesystem
    var pkg_dir = try std.Io.Dir.cwd().openDir(io, tmp_path, .{});
    defer pkg_dir.close(io);

    var archive = try Archive.read_from_fs(allocator, io, pkg_dir, paths);
    defer archive.deinit(allocator);

    // Compute the hash using release's algorithm
    const name = pkg.name;
    const semver = try std.SemanticVersion.parse(pkg.version);
    // Fingerprint is packed struct(u64) { id: u32, checksum: u32 }
    // id is the low 32 bits
    const id: u32 = @truncate(pkg.fingerprint);

    const release_hash = try archive.hash(allocator, name, semver, id);
    defer allocator.free(release_hash);

    // Create the tar.gz for zig fetch
    const tar_gz = try archive.to_tar_gz(allocator);
    defer allocator.free(tar_gz);

    // Write tar.gz to a temp file
    const tar_gz_path = try std.fmt.allocPrint(allocator, "/tmp/release-test-{s}.tar.gz", .{pkg.name});
    defer {
        std.Io.Dir.cwd().deleteFile(io, tar_gz_path) catch {};
        allocator.free(tar_gz_path);
    }
    {
        const file = try std.Io.Dir.cwd().createFile(io, tar_gz_path, .{});
        defer file.close(io);
        var write_buf: [4096]u8 = undefined;
        var writer = file.writer(io, &write_buf);
        try writer.interface.writeAll(tar_gz);
        try writer.interface.flush();
    }

    // Build an environment map from the current process environment so that
    // the child `zig fetch` can resolve its cache directory.
    var env_map: std.process.Environ.Map = blk: {
        if (@hasDecl(std.process.Environ.Block, "use_global")) {
            break :blk try std.process.Environ.createMap(.{ .block = .global }, allocator);
        }
        // PosixBlock: build from std.c.environ
        var m = std.process.Environ.Map.init(allocator);
        errdefer m.deinit();
        const env_ptr: [*:null]const ?[*:0]const u8 = @ptrCast(std.c.environ);
        var i: usize = 0;
        while (env_ptr[i]) |entry| : (i += 1) {
            const entry_str = std.mem.span(entry);
            const eq_pos = std.mem.indexOfScalar(u8, entry_str, '=') orelse continue;
            try m.put(entry_str[0..eq_pos], entry_str[eq_pos + 1 ..]);
        }
        break :blk m;
    };
    defer env_map.deinit();

    // Run `zig fetch` to get the reference hash
    const result = std.process.run(allocator, io, .{
        .argv = &.{ "zig", "fetch", tar_gz_path },
        .environ_map = &env_map,
    }) catch |err| {
        std.debug.print("Failed to run zig fetch: {}\n", .{err});
        return err;
    };
    defer {
        allocator.free(result.stdout);
        allocator.free(result.stderr);
    }

    switch (result.term) {
        .exited => |code| if (code != 0) {
            std.debug.print("zig fetch failed (exit {d}):\n{s}\n", .{ code, result.stderr });
            return error.ZigFetchFailed;
        },
        else => {
            std.debug.print("zig fetch terminated abnormally\n", .{});
            return error.ZigFetchFailed;
        },
    }

    // zig fetch outputs the hash followed by a newline
    const zig_hash = std.mem.trim(u8, result.stdout, &std.ascii.whitespace);

    // When a tarball has no build.zig.zon, zig fetch uses default name="N",
    // version="V", id=0xffff. Since release uses the real name/version/id from
    // the manifest, we compare the underlying digest instead of the full hash
    // string. The hashplus is the base64url-encoded part after "name-version-".
    // It encodes: id(u32 LE) + size(u32 LE) + digest[0..25] = 33 bytes.
    // base64url-no-pad of 33 bytes = 44 chars. We compare bytes [8..] which
    // is the digest of file contents.
    const hashplus_b64_len = 44;
    if (release_hash.len < hashplus_b64_len or zig_hash.len < hashplus_b64_len) {
        std.debug.print("hash string too short - release: {s}, zig: {s}\n", .{ release_hash, zig_hash });
        return error.UnexpectedHashFormat;
    }
    const release_b64 = release_hash[release_hash.len - hashplus_b64_len ..];
    const zig_b64 = zig_hash[zig_hash.len - hashplus_b64_len ..];

    var release_decoded: [33]u8 = undefined;
    var zig_decoded: [33]u8 = undefined;
    std.base64.url_safe_no_pad.Decoder.decode(&release_decoded, release_b64) catch {
        std.debug.print("failed to decode release hashplus: {s}\n", .{release_b64});
        return error.DecodeError;
    };
    std.base64.url_safe_no_pad.Decoder.decode(&zig_decoded, zig_b64) catch {
        std.debug.print("failed to decode zig hashplus: {s}\n", .{zig_b64});
        return error.DecodeError;
    };

    // Compare size (bytes 4..8) and digest (bytes 8..)
    const release_size = std.mem.readInt(u32, release_decoded[4..8], .little);
    const zig_size = std.mem.readInt(u32, zig_decoded[4..8], .little);
    const release_digest = release_decoded[8..];
    const zig_digest = zig_decoded[8..];

    if (release_size != zig_size) {
        std.debug.print("Size mismatch for package '{s}':\n  release: {d}\n  zig:    {d}\n", .{
            pkg.name, release_size, zig_size,
        });
        return error.SizeMismatch;
    }

    std.testing.expectEqualSlices(u8, zig_digest, release_digest) catch |err| {
        std.debug.print("Digest mismatch for package '{s}':\n  release: {X}\n  zig:    {X}\n", .{
            pkg.name, release_digest, zig_digest,
        });
        return err;
    };
}

/// Sets up a real Io.Threaded instance for tests that need process spawning.
fn runHashTest(pkg: TestPackage) !void {
    const gpa = std.testing.allocator;
    var threaded = Io.Threaded.init(gpa, .{});
    defer threaded.deinit();
    const io = threaded.io();
    try verifyHashMatches(gpa, io, pkg);
}

test "hash matches zig fetch: simple package" {
    try runHashTest(.{
        .name = "simple_pkg",
        .version = "0.1.0",
        .fingerprint = fingerprintFor("simple_pkg", 0x12345678),
        .files = &.{
            .{ .path = "build.zig", .content = "pub fn build(b: *std.Build) void {}\n" },
            .{ .path = "src/main.zig", .content = "pub fn main() void {}\n" },
        },
    });
}

test "hash matches zig fetch: single file" {
    try runHashTest(.{
        .name = "single_file",
        .version = "1.0.0",
        .fingerprint = fingerprintFor("single_file", 0xdeadbeef),
        .files = &.{
            .{ .path = "README.md", .content = "# Single File Package\n\nHello!\n" },
        },
    });
}

test "hash matches zig fetch: nested directories" {
    try runHashTest(.{
        .name = "nested_pkg",
        .version = "2.3.1",
        .fingerprint = fingerprintFor("nested_pkg", 0xcafebabe),
        .files = &.{
            .{ .path = "build.zig", .content = "const std = @import(\"std\");\npub fn build(b: *std.Build) void {}\n" },
            .{ .path = "src/root.zig", .content = "pub const root = 1;\n" },
            .{ .path = "src/deep/nested/file.zig", .content = "pub const deep = true;\n" },
            .{ .path = "LICENSE", .content = "MIT License\n\nCopyright (c) 2024\n" },
        },
    });
}

test "hash matches zig fetch: binary content" {
    // Include some binary-like content with null bytes and high bytes
    const binary_content = [_]u8{ 0x00, 0x01, 0x02, 0xFF, 0xFE, 0x00, 0x42, 0x7F };
    try runHashTest(.{
        .name = "binary_pkg",
        .version = "0.0.1",
        .fingerprint = fingerprintFor("binary_pkg", 0x00000001),
        .files = &.{
            .{ .path = "build.zig", .content = "pub fn build(b: *std.Build) void {}\n" },
            .{ .path = "data.bin", .content = &binary_content },
        },
    });
}

test "hash matches zig fetch: empty files" {
    try runHashTest(.{
        .name = "empty_pkg",
        .version = "0.1.0",
        .fingerprint = fingerprintFor("empty_pkg", 0xaaaaaaaa),
        .files = &.{
            .{ .path = "build.zig", .content = "" },
            .{ .path = "empty.txt", .content = "" },
        },
    });
}
