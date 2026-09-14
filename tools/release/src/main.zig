const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const json = std.json;
const Io = std.Io;

const Manifest = @import("Manifest.zig");
const Archive = @import("Archive.zig");

const StringArrayHashMap = std.array_hash_map.String;
const StringArrayHashMapUnmanaged = std.array_hash_map.String;

pub fn main(init: std.process.Init) !void {
    const allocator = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(allocator);

    {
        const zon_text = try std.Io.Dir.cwd().readFileAlloc(io, "build.zig.zon", allocator, .limited(0x4000));
        const zon_text_copy = try allocator.allocSentinel(u8, zon_text.len, 0);
        @memcpy(zon_text_copy, zon_text);

        if (std.mem.eql(u8, args[1], "get-version")) {
            const manifest = try Manifest.from_text(allocator, zon_text_copy);
            var stdout_buf: [4096]u8 = undefined;
            var stdout = std.Io.File.stdout().writerStreaming(io, &stdout_buf);
            try stdout.interface.print("{f}\n", .{manifest.version});
            try stdout.interface.flush();
            return;
        }
    }

    const base_url = args[1];

    var todo: StringArrayHashMap(void) = .empty;

    var iterable = try std.Io.Dir.cwd().openDir(io, ".", .{ .iterate = true });
    defer iterable.close(io);

    var walker = try iterable.walkSelectively(allocator);
    while (try walker.next(io)) |entry| switch (entry.kind) {
        .directory => if (!std.mem.startsWith(u8, entry.basename, ".") and
            !std.mem.eql(u8, entry.basename, "zig-out") and
            !std.mem.eql(u8, entry.basename, "zig-pkg"))
        {
            try walker.enter(io, entry);
        },

        .file => if (std.mem.eql(u8, entry.basename, "build.zig.zon")) {
            const path = try entry.dir.realPathFileAlloc(io, "build.zig.zon", allocator);
            std.log.info("found build.zig.zon: {s}", .{path});
            try todo.put(allocator, std.fs.path.dirname(path).?, {});
        },
        else => {},
    };

    var manifests: StringArrayHashMap(*Manifest) = .empty;
    var dependencies: StringArrayHashMap(StringArrayHashMapUnmanaged([]const u8)) = .empty;
    var release_ignores: StringArrayHashMap(void) = .empty;

    {
        var buf: [std.Io.Dir.max_path_bytes]u8 = undefined;
        const n = try std.Io.Dir.cwd().realPathFile(io, ".", &buf);
        try todo.put(allocator, try allocator.dupe(u8, buf[0..n]), {});
    }
    while (todo.count() > 0) {
        // pop entries from todo until it's ones we haven't visited
        const root_path = while (todo.pop()) |entry| {
            if (!manifests.contains(entry.key))
                break entry.key;
        } else continue;

        var root_dir = try std.Io.Dir.openDirAbsolute(io, root_path, .{});
        defer root_dir.close(io);

        const zon_text = try root_dir.readFileAlloc(io, "build.zig.zon", allocator, .limited(0x4000));
        const manifest = try Manifest.create_from_text(allocator, zon_text);

        const result = try dependencies.getOrPut(allocator, root_path);
        std.debug.assert(!result.found_existing);

        result.value_ptr.* = .{};

        for (manifest.dependencies.keys(), manifest.dependencies.values()) |dep_name, dep|
            switch (dep) {
                .local => |local| {
                    var buf: [std.Io.Dir.max_path_bytes]u8 = undefined;
                    const n = root_dir.realPathFile(io, local.path, &buf) catch |err| {
                        if (err == error.FileNotFound)
                            std.log.err("failed to find file: {s}", .{local.path});
                        return err;
                    };
                    const realpath = try allocator.dupe(u8, buf[0..n]);
                    try todo.put(allocator, realpath, {});
                    try result.value_ptr.put(allocator, dep_name, realpath);
                },
                .remote => {},
            };

        for (manifest.release_ignores.keys()) |rel_path| {
            std.log.info("RELEASE IGNORE: {s}", .{rel_path});
            const path = try root_dir.realPathFileAlloc(io, rel_path, allocator);
            try release_ignores.put(allocator, path, {});
        }

        try manifests.put(allocator, root_path, manifest);
        std.log.debug("created manifest: {s}", .{root_path});
    }

    var root_buf: [std.Io.Dir.max_path_bytes]u8 = undefined;
    const root_n = try std.Io.Dir.cwd().realPathFile(io, ".", &root_buf);
    const root_path = try allocator.dupe(u8, root_buf[0..root_n]);

    var stack = try circular_dependency_found(allocator, root_path, dependencies);
    defer stack.deinit(allocator);

    if (stack.items.len > 0) {
        std.log.err("Circular dependency found!", .{});
        std.log.err("  {s}", .{stack.items[0]});
        for (stack.items[1..]) |elem|
            std.log.err("  -> {s}", .{elem});

        return error.CircularDependency;
    }

    const depths = try calculate_depths(allocator, manifests.keys(), dependencies);
    for (depths.keys(), depths.values()) |path, depth| {
        std.log.debug("{}: {s}", .{ depth, path });
    }

    var archives: StringArrayHashMap(Archive) = .empty;
    var hashes: StringArrayHashMap([]const u8) = .empty;
    var urls: StringArrayHashMap([]const u8) = .empty;

    const root_manifest = manifests.get(root_path).?;
    // calculate urls
    for (manifests.keys(), manifests.values()) |path, manifest| {
        try urls.put(allocator, path, try std.fmt.allocPrint(allocator, "{s}/{f}/{s}.tar.gz", .{
            base_url,
            root_manifest.version,
            manifest.name,
        }));
        if (!manifest.paths.contains("LICENSE")) {
            // Copy the license file from the root
            std.log.info("{s} does not have a LICENSE file, using root LICENSE", .{path});
            try manifest.paths.put(allocator, "LICENSE", .{
                .in_memory = try root_manifest.get_file_contents(allocator, std.Io.Dir.cwd(), io, "LICENSE"),
            });
        }
    }

    const minimum_zig_version: []const u8 = try get_minimum_zig_version(allocator, io);
    var d: isize = @intCast(std.mem.max(u32, depths.values()));
    while (d > -1) : (d -= 1) {
        for (depths.keys(), depths.values()) |path, depth| {
            if (d == depth) {
                const local_deps = dependencies.get(path).?;
                var manifest = manifests.get(path).?;
                for (local_deps.keys(), local_deps.values()) |dep_name, dep_path| {
                    const old = manifest.dependencies.get(dep_name).?;
                    try manifest.dependencies.put(allocator, dep_name, .{
                        .remote = .{
                            .url = urls.get(dep_path).?,
                            .hash = try std.fmt.allocPrint(allocator, "{s}", .{hashes.get(dep_path).?}),
                            .lazy = old.local.lazy,
                        },
                    });
                }

                var dir = try std.Io.Dir.openDirAbsolute(io, path, .{ .iterate = true });
                defer dir.close(io);

                var archive = try Archive.read_from_fs(allocator, io, dir, manifest.paths);
                if (archive.files.getPtr("build.zig.zon")) |file| {
                    file.kind = .{ .regular = try manifest.serialize(allocator, .{
                        .minimum_zig_version = minimum_zig_version,
                    }) };
                }

                const hash = try archive.hash(allocator, manifest.name, manifest.version, manifest.fingerprint.id);
                std.log.debug("hash for {s}: {s}", .{ manifest.name, hash });
                try hashes.put(allocator, path, hash);
                try archives.put(allocator, path, archive);
            }
        }
    }

    try std.Io.Dir.cwd().deleteTree(io, "release-out");
    var out_dir = try std.Io.Dir.cwd().createDirPathOpen(io, "release-out", .{});
    defer out_dir.close(io);

    var packages: json.ObjectMap = .empty;
    for (manifests.keys(), manifests.values()) |path, manifest| {
        if (release_ignores.contains(path)) {
            // TODO: assert no other manifest depends on this.
            std.log.info("IGNORED {s}", .{path});
            continue;
        }

        const out_path = try std.fmt.allocPrint(allocator, "{f}/{s}.tar.gz", .{
            root_manifest.version,
            manifest.name,
        });

        var dir = try out_dir.createDirPathOpen(io, std.fs.path.dirname(out_path).?, .{});
        defer dir.close(io);

        const file = try dir.createFile(io, std.fs.path.basename(out_path), .{});
        defer file.close(io);

        const tar_gz = try archives.get(path).?.to_tar_gz(allocator);

        var buf: [4096]u8 = undefined;
        var writer = file.writer(io, &buf);
        try writer.interface.writeAll(tar_gz);
        try writer.interface.flush();

        var deps: json.ObjectMap = .empty;
        for (manifest.dependencies.keys(), manifest.dependencies.values()) |dep_name, info| {
            switch (info) {
                .remote => |remote| {
                    var dep: json.ObjectMap = .empty;
                    try dep.put(allocator, "url", .{ .string = remote.url });
                    try dep.put(allocator, "hash", .{ .string = remote.hash });
                    try dep.put(allocator, "lazy", .{ .bool = remote.lazy });

                    try deps.put(allocator, dep_name, .{ .object = dep });
                },
                .local => |local| {
                    assert(false);
                    _ = local;
                },
            }
        }

        var package: json.ObjectMap = .empty;
        try package.put(allocator, "dependencies", .{ .object = deps });
        try package.put(allocator, "version", .{ .string = try std.fmt.allocPrint(allocator, "{f}", .{manifest.version}) });
        try package.put(allocator, "url", .{ .string = urls.get(path).? });
        try package.put(allocator, "hash", .{ .string = hashes.get(path).? });

        if (manifest.nodes.description.unwrap()) |_| {
            const desc_token = manifest.ast.nodeMainToken(manifest.nodes.description.unwrap().?);
            const desc_bytes = manifest.ast.tokenSlice(desc_token);
            var desc_aw: std.Io.Writer.Allocating = .init(allocator);
            defer desc_aw.deinit();
            _ = std.zig.string_literal.parseWrite(&desc_aw.writer, desc_bytes) catch {};
            if (desc_aw.written().len > 0)
                try package.put(allocator, "description", .{ .string = desc_aw.written() });
        }

        try packages.put(allocator, manifest.name, .{ .object = package });
    }

    if (manifests.get(root_path)) |manifest| {
        var metadata: json.ObjectMap = .empty;
        try metadata.put(allocator, "version", .{ .string = try std.fmt.allocPrint(allocator, "{f}", .{manifest.version}) });
        try metadata.put(allocator, "minimum_zig_version", .{ .string = minimum_zig_version });
        try metadata.put(allocator, "packages", .{ .object = packages });

        const version_path = try std.fmt.allocPrint(allocator, "{f}", .{manifest.version});
        var dir = try out_dir.openDir(io, version_path, .{});
        defer dir.close(io);

        const file = try dir.createFile(io, "package-metadata.json", .{});
        defer file.close(io);

        var buf: [4096]u8 = undefined;
        var writer = file.writer(io, &buf);

        const value = json.Value{ .object = metadata };
        try json.Stringify.value(value, .{ .whitespace = .indent_4 }, &writer.interface);
        try writer.interface.flush();
    }
}

fn get_minimum_zig_version(allocator: Allocator, io: Io) ![]u8 {
    const result = try std.process.run(allocator, io, .{
        .argv = &.{ "zig", "env" },
    });
    defer {
        allocator.free(result.stdout);
        allocator.free(result.stderr);
    }

    switch (result.term) {
        .exited => |code| if (code != 0) return error.FailedToGetZigVersion,
        else => return error.FailedToGetZigVersion,
    }

    // `zig env` outputs ZON, not JSON.
    const source = try allocator.allocSentinel(u8, result.stdout.len, 0);
    defer allocator.free(source);
    @memcpy(source, result.stdout);

    var ast = try std.zig.Ast.parse(allocator, source, .{ .mode = .zon });
    defer ast.deinit(allocator);

    const root_node = ast.nodeData(.root).node;
    var buf: [2]std.zig.Ast.Node.Index = undefined;
    const struct_init = ast.fullStructInit(&buf, root_node) orelse
        return error.FailedToGetZigVersion;

    for (struct_init.ast.fields) |field_init| {
        const name_token = ast.firstToken(field_init) - 2;
        const field_name = ast.tokenSlice(name_token);
        if (std.mem.eql(u8, field_name, "version")) {
            if (ast.nodeTag(field_init) != .string_literal)
                return error.FailedToGetZigVersion;
            const token_bytes = ast.tokenSlice(ast.nodeMainToken(field_init));
            var aw: std.Io.Writer.Allocating = .init(allocator);
            defer aw.deinit();
            _ = std.zig.string_literal.parseWrite(&aw.writer, token_bytes) catch return error.FailedToGetZigVersion;
            return allocator.dupe(u8, aw.written());
        }
    }

    return error.FailedToGetZigVersion;
}

fn calculate_depths(
    allocator: Allocator,
    paths: []const []const u8,
    dependencies: StringArrayHashMap(StringArrayHashMapUnmanaged([]const u8)),
) !StringArrayHashMap(u32) {
    var dependents: StringArrayHashMap(StringArrayHashMapUnmanaged(void)) = .empty;
    defer {
        //for (dependents.values()) |*d| d.deinit();
        dependents.deinit(allocator);
    }

    for (paths) |path| if (dependencies.get(path)) |deps| {
        for (deps.values()) |dep_path| {
            const result = try dependents.getOrPut(allocator, dep_path);
            if (result.found_existing == false)
                result.value_ptr.* = .{};

            try result.value_ptr.put(allocator, path, {});
        }
    };

    for (dependents.keys(), dependents.values()) |path, parents| {
        std.log.debug("{s} is depended on by {}", .{ path, parents.count() });
    }

    var depths: StringArrayHashMap(u32) = .empty;
    errdefer depths.deinit(allocator);

    for (paths) |path|
        try calculate_depths_recursive(path, &depths, dependents, allocator);

    return depths;
}

// walk up the dependency tree and calculate depths of each node
fn calculate_depths_recursive(
    path: []const u8,
    depths: *StringArrayHashMap(u32),
    dependents: StringArrayHashMap(StringArrayHashMapUnmanaged(void)),
    allocator: Allocator,
) !void {
    // if the depth for a path is found, then we've already calculated it
    if (depths.contains(path))
        return;

    const parents = dependents.get(path) orelse {
        // we've found the root path
        try depths.put(allocator, path, 0);
        return;
    };

    var max_depth: u32 = 0;
    for (parents.keys()) |parent_path| {
        try calculate_depths_recursive(parent_path, depths, dependents, allocator);
        max_depth = @max(max_depth, depths.get(parent_path).?);
    }

    try depths.put(allocator, path, max_depth + 1);
}

fn circular_dependency_found(
    allocator: Allocator,
    root_path: []const u8,
    dependencies: StringArrayHashMap(StringArrayHashMapUnmanaged([]const u8)),
) !std.ArrayList([]const u8) {
    var stack: std.ArrayList([]const u8) = .empty;
    errdefer stack.deinit(allocator);

    _ = try circular_dependency_found_recursive(root_path, &stack, dependencies, allocator);

    return stack;
}

fn circular_dependency_found_recursive(
    path: []const u8,
    stack: *std.ArrayList([]const u8),
    dependencies: StringArrayHashMap(StringArrayHashMapUnmanaged([]const u8)),
    allocator: Allocator,
) !bool {
    for (stack.items) |elem| {
        if (std.mem.eql(u8, path, elem)) {
            try stack.append(allocator, path);
            return true;
        }
    }

    try stack.append(allocator, path);

    if (dependencies.get(path)) |deps|
        for (deps.values()) |dep_path| {
            if (try circular_dependency_found_recursive(dep_path, stack, dependencies, allocator))
                return true;
        };

    _ = stack.pop();
    return false;
}

test "all" {
    _ = Archive;
}
