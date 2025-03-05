allocator: Allocator,
name: []const u8,
version: std.SemanticVersion,
dependencies: std.StringArrayHashMap(PackageInfo),
paths: std.StringArrayHashMap(void),
doc: zon.Document,

const Manifest = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const zon = @import("eggzon");

const log = std.log.scoped(.manifest);

pub const PackageInfo = union(enum) {
    local: struct {
        path: []const u8,
        lazy: bool,
    },
    remote: struct {
        url: []const u8,
        hash: []const u8,
        lazy: bool,
    },

    pub fn format(
        info: PackageInfo,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;

        switch (info) {
            .local => |local| try writer.print("local: path={s}", .{local.path}),
            .remote => |remote| try writer.print("remote: url={s} hash={s}", .{ remote.url, remote.hash }),
        }
    }
};

pub fn create_from_text(allocator: Allocator, text: []const u8) !*Manifest {
    const manifest = try allocator.create(Manifest);
    errdefer allocator.destroy(manifest);

    manifest.* = try from_text(allocator, text);
    return manifest;
}

pub fn from_text(allocator: Allocator, text: []const u8) !Manifest {
    var doc = try zon.parseString(allocator, text);
    errdefer doc.deinit();

    if (doc.root != .object)
        return error.RootIsNotObject;

    const root = doc.root.object;
    const name = root.get("name") orelse return error.ProjectMissingName;
    if (name != .@"enum")
        return error.ProjectNameNotEnum;

    const version = root.get("version") orelse return error.ProjectMissingVersion;
    if (version != .string)
        return error.VersionIsNotString;

    const name_copy = try allocator.dupe(u8, name.@"enum");
    const semver = try std.SemanticVersion.parse(version.string);

    var paths = std.StringArrayHashMap(void).init(allocator);
    errdefer {
        for (paths.keys()) |path| allocator.free(path);
        paths.deinit();
    }
    var ignore_paths = std.StringArrayHashMap(void).init(allocator);
    errdefer {
        for (ignore_paths.keys()) |path| allocator.free(path);
        ignore_paths.deinit();
    }

    if (root.get("boxzer_ignore_paths")) |zon_ignore_paths| {
        if (zon_ignore_paths != .array)
            return error.ProjectIgnorePathsIsNotArray;

        for (zon_ignore_paths.array) |ignore_path| {
            if (ignore_path != .string)
                return error.ProjectIgnorePathIsNotString;

            const ignore_path_copy = try allocator.dupe(u8, ignore_path.string);
            errdefer allocator.free(ignore_path_copy);

            try ignore_paths.put(ignore_path_copy, {});
        }
    }

    const zon_paths = root.get("paths") orelse return error.ProjectMissingPaths;
    if (zon_paths != .array)
        return error.ProjectPathsIsNotArray;

    for (zon_paths.array) |path| {
        if (path != .string)
            return error.ProjectPathIsNotString;

        if (ignore_paths.contains(path.string))
            continue;

        const path_copy = try allocator.dupe(u8, path.string);
        errdefer allocator.free(path_copy);

        try paths.put(path_copy, {});
    }

    var dependencies = std.StringArrayHashMap(PackageInfo).init(allocator);
    errdefer {
        for (dependencies.keys(), dependencies.values()) |dep_key, info| {
            allocator.free(dep_key);
            switch (info) {
                .local => |local| allocator.free(local.path),
                .remote => |remote| {
                    allocator.free(remote.url);
                    allocator.free(remote.hash);
                },
            }
        }
        dependencies.deinit();
    }

    if (root.get("dependencies")) |dependencies_node| blk: {
        if (dependencies_node == .empty)
            break :blk;
        if (dependencies_node != .object)
            return error.DependenciesIsNotObject;

        for (dependencies_node.object.keys(), dependencies_node.object.values()) |dep_key, dep_value| {
            if (dep_value != .object)
                return error.DependencyIsNotObject;

            const dep = dep_value.object;
            const dep_key_copy = try allocator.dupe(u8, dep_key);
            errdefer allocator.free(dep_key_copy);

            if (dep.get("path")) |path| {
                if (path != .string)
                    return error.DependencyPathIsNotString;

                const path_copy = try allocator.dupe(u8, path.string);
                errdefer allocator.free(path_copy);

                const lazy: bool = if (dep.get("lazy")) |lazy_node|
                    if (lazy_node != .bool)
                        return error.DependencyLazinessIsNotBool
                    else
                        lazy_node.bool
                else
                    false;

                try dependencies.put(dep_key_copy, .{
                    .local = .{ .path = path_copy, .lazy = lazy },
                });
            } else {
                const url = dep.get("url") orelse return error.DependencyMissingUrl;
                const hash = dep.get("hash") orelse return error.DependencyMissingHash;

                if (url != .string)
                    return error.UrlIsNotString;

                if (hash != .string)
                    return error.HashIsNotString;

                const lazy: bool = if (dep.get("lazy")) |lazy_node|
                    if (lazy_node != .bool)
                        return error.DependencyLazinessIsNotBool
                    else
                        lazy_node.bool
                else
                    false;

                const url_copy = try allocator.dupe(u8, url.string);
                errdefer allocator.free(url_copy);

                const hash_copy = try allocator.dupe(u8, hash.string);
                errdefer allocator.free(url_copy);

                try dependencies.put(dep_key_copy, .{
                    .remote = .{
                        .url = url_copy,
                        .hash = hash_copy,
                        .lazy = lazy,
                    },
                });
            }
        }
    }

    return Manifest{
        .allocator = allocator,
        .name = name_copy,
        .version = semver,
        .dependencies = dependencies,
        .paths = paths,
        .doc = doc,
    };
}

pub fn deinit(manifest: *Manifest) void {
    manifest.allocator.free(manifest.name);

    for (manifest.dependencies.keys(), manifest.dependencies.values()) |name, info| {
        manifest.allocator.free(name);
        switch (info) {
            .local => |local| manifest.allocator.free(local.path),
            .remote => |remote| {
                manifest.allocator.free(remote.url);
                manifest.allocator.free(remote.hash);
            },
        }
    }
    manifest.dependencies.deinit();

    for (manifest.paths.keys()) |path| manifest.allocator.free(path);
    manifest.paths.deinit();
    manifest.doc.deinit();
}

pub const SerializeOptions = struct {
    minimum_zig_version: ?[]const u8,
};

pub fn serialize(manifest: *Manifest, allocator: Allocator, opts: SerializeOptions) ![]const u8 {
    var buffer = std.ArrayList(u8).init(allocator);
    const writer = buffer.writer();

    if (!manifest.doc.root.object.contains("minimum_zig_version") and opts.minimum_zig_version != null) {
        try manifest.doc.root.object.put(manifest.allocator, "minimum_zig_version", .{
            .string = opts.minimum_zig_version.?,
        });
    }

    if (manifest.dependencies.count() > 0) {
        const dependencies = manifest.doc.root.object.getPtr("dependencies").?;
        for (manifest.dependencies.keys(), manifest.dependencies.values()) |dep_name, info| {
            // TODO: clean up old
            var new_value = std.StringArrayHashMapUnmanaged(zon.Node){};
            try new_value.put(manifest.allocator, "url", .{ .string = info.remote.url });
            try new_value.put(manifest.allocator, "hash", .{ .string = info.remote.hash });
            try new_value.put(manifest.allocator, "lazy", .{ .bool = info.remote.lazy });
            try dependencies.object.put(manifest.allocator, dep_name, .{ .object = new_value });
        }
    }

    var paths = std.ArrayList(zon.Node).init(manifest.allocator);
    defer paths.deinit();

    for (manifest.paths.keys()) |path|
        try paths.append(.{ .string = path });

    try manifest.doc.root.object.put(manifest.allocator, "paths", .{ .array = try paths.toOwnedSlice() });

    try write_zon_node(manifest.doc.root, 0, writer);
    return try buffer.toOwnedSlice();
}

const WriteZonError = error{OutOfMemory};
fn write_zon_node(node: zon.Node, depth: u32, writer: anytype) WriteZonError!void {
    switch (node) {
        .null => try writer.writeAll("null"),
        .empty => {},
        .@"enum" => |e| try writer.print("\"{s}\"", .{e}),
        .string => |str| try writer.print("\"{s}\"", .{str}),
        .array => |arr| {
            try writer.writeAll(".{\n");
            for (arr) |elem| {
                try writer.writeByteNTimes(' ', 4 * (depth + 1));
                try write_zon_node(elem, depth + 1, writer);
                try writer.writeAll(",\n");
            }
            try writer.writeByteNTimes(' ', 4 * depth);
            try writer.writeAll("}");
        },
        .object => |obj| {
            try writer.writeAll(".{\n");
            for (obj.keys(), obj.values()) |key, value| {
                try writer.writeByteNTimes(' ', 4 * (depth + 1));
                try writer.print(".{} = ", .{std.zig.fmtId(key)});
                try write_zon_node(value, depth + 1, writer);
                try writer.writeAll(",\n");
            }
            try writer.writeByteNTimes(' ', 4 * depth);
            try writer.writeAll("}");
        },
        inline else => |value| try writer.print("{}", .{value}),
    }
}
