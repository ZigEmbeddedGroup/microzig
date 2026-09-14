allocator: Allocator,
name: []const u8,
version: std.SemanticVersion,
fingerprint: Fingerprint,
dependencies: std.array_hash_map.String(PackageInfo),
release_ignores: std.array_hash_map.String(void),
paths: std.array_hash_map.String(PathOrigin),
ast: std.zig.Ast,
/// Node indices into the AST for fields we may need to rewrite during serialize.
nodes: AstNodes,

const Manifest = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const Ast = std.zig.Ast;

const Fingerprint = packed struct(u64) {
    id: u32,
    checksum: u32,
};

/// AST node indices needed for serialization fixups.
const AstNodes = struct {
    dependencies: Ast.Node.OptionalIndex = .none,
    release_ignores: Ast.Node.OptionalIndex = .none,
    paths: Ast.Node.OptionalIndex = .none,
    minimum_zig_version: Ast.Node.OptionalIndex = .none,
    version: Ast.Node.OptionalIndex = .none,
    description: Ast.Node.OptionalIndex = .none,
};

pub const PathOrigin = union(enum) {
    in_filesystem,
    in_memory: []const u8,
};

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
        writer: *std.Io.Writer,
    ) !void {
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
    // The source needs to be kept alive for the lifetime of the manifest since
    // Ast tokens reference into it. We dupe it so the caller's buffer can be freed.
    const source = try allocator.allocSentinel(u8, text.len, 0);
    @memcpy(source, text);

    var ast = try Ast.parse(allocator, source, .{ .mode = .zon });
    errdefer ast.deinit(allocator);

    if (ast.errors.len > 0)
        return error.ZonParseError;

    const root_node = ast.nodeData(.root).node;
    var buf: [2]Ast.Node.Index = undefined;
    const struct_init = ast.fullStructInit(&buf, root_node) orelse
        return error.RootIsNotObject;

    var name: []const u8 = "";
    var version_text: []const u8 = "";
    var fingerprint_val: u64 = 0;
    var nodes: AstNodes = .{};

    var paths: std.array_hash_map.String(PathOrigin) = .empty;
    errdefer {
        for (paths.keys()) |path| allocator.free(path);
        paths.deinit(allocator);
    }

    var release_ignores: std.array_hash_map.String(void) = .empty;
    errdefer {
        for (release_ignores.keys()) |path| allocator.free(path);
        release_ignores.deinit(allocator);
    }

    var dependencies: std.array_hash_map.String(PackageInfo) = .empty;
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
        dependencies.deinit(allocator);
    }

    for (struct_init.ast.fields) |field_init| {
        const name_token = ast.firstToken(field_init) - 2;
        const field_name = ast.tokenSlice(name_token);
        if (std.mem.eql(u8, field_name, "name")) {
            name = try parse_enum_literal(allocator, ast, field_init);
        } else if (std.mem.eql(u8, field_name, "version")) {
            version_text = try parse_string_literal(allocator, ast, field_init);
            nodes.version = field_init.toOptional();
        } else if (std.mem.eql(u8, field_name, "fingerprint")) {
            fingerprint_val = try parse_fingerprint(ast, field_init);
        } else if (std.mem.eql(u8, field_name, "dependencies")) {
            nodes.dependencies = field_init.toOptional();
            try parse_dependencies(allocator, ast, field_init, &dependencies);
        } else if (std.mem.eql(u8, field_name, "paths")) {
            nodes.paths = field_init.toOptional();
            try parse_paths(allocator, ast, field_init, &paths);
        } else if (std.mem.eql(u8, field_name, "release_ignores")) {
            try parse_release_ignores(allocator, ast, field_init, &release_ignores);
        } else if (std.mem.eql(u8, field_name, "minimum_zig_version")) {
            nodes.minimum_zig_version = field_init.toOptional();
        } else if (std.mem.eql(u8, field_name, "description")) {
            nodes.description = field_init.toOptional();
        }
    }

    if (name.len == 0) return error.ProjectMissingName;
    if (version_text.len == 0) return error.ProjectMissingVersion;

    const semver = try std.SemanticVersion.parse(version_text);

    return Manifest{
        .allocator = allocator,
        .name = name,
        .version = semver,
        .fingerprint = @bitCast(fingerprint_val),
        .dependencies = dependencies,
        .release_ignores = release_ignores,
        .paths = paths,
        .ast = ast,
        .nodes = nodes,
    };
}

fn parse_enum_literal(allocator: Allocator, ast: Ast, node: Ast.Node.Index) ![]const u8 {
    if (ast.nodeTag(node) != .enum_literal)
        return error.ProjectNameNotEnum;
    const token_bytes = ast.tokenSlice(ast.nodeMainToken(node));
    return allocator.dupe(u8, token_bytes);
}

fn parse_string_literal(allocator: Allocator, ast: Ast, node: Ast.Node.Index) ![]const u8 {
    if (ast.nodeTag(node) != .string_literal)
        return error.ExpectedStringLiteral;
    const token_bytes = ast.tokenSlice(ast.nodeMainToken(node));
    var aw: std.Io.Writer.Allocating = .init(allocator);
    errdefer aw.deinit();
    const result = std.zig.string_literal.parseWrite(&aw.writer, token_bytes) catch return error.InvalidStringLiteral;
    switch (result) {
        .success => return try aw.toOwnedSlice(),
        .failure => return error.InvalidStringLiteral,
    }
}

fn parse_fingerprint(ast: Ast, node: Ast.Node.Index) !u64 {
    if (ast.nodeTag(node) != .number_literal)
        return error.FingerprintIsNotInt;
    const token_bytes = ast.tokenSlice(ast.nodeMainToken(node));
    const parsed = std.zig.parseNumberLiteral(token_bytes);
    return switch (parsed) {
        .int => |n| @bitCast(n),
        else => error.FingerprintIsNotInt,
    };
}

fn parse_bool(ast: Ast, node: Ast.Node.Index) !bool {
    if (ast.nodeTag(node) != .identifier)
        return error.ExpectedBool;
    const token_bytes = ast.tokenSlice(ast.nodeMainToken(node));
    if (std.mem.eql(u8, token_bytes, "true")) return true;
    if (std.mem.eql(u8, token_bytes, "false")) return false;
    return error.ExpectedBool;
}

fn parse_dependencies(
    allocator: Allocator,
    ast: Ast,
    node: Ast.Node.Index,
    dependencies: *std.array_hash_map.String(PackageInfo),
) !void {
    var buf: [2]Ast.Node.Index = undefined;
    const struct_init = ast.fullStructInit(&buf, node) orelse return;

    for (struct_init.ast.fields) |field_init| {
        const name_token = ast.firstToken(field_init) - 2;
        const dep_name = try allocator.dupe(u8, ast.tokenSlice(name_token));
        errdefer allocator.free(dep_name);

        var dep_buf: [2]Ast.Node.Index = undefined;
        const dep_struct = ast.fullStructInit(&dep_buf, field_init) orelse continue;

        var has_path = false;
        var path: []const u8 = "";
        var url: []const u8 = "";
        var hash: []const u8 = "";
        var lazy: bool = false;

        for (dep_struct.ast.fields) |dep_field| {
            const dep_field_name_token = ast.firstToken(dep_field) - 2;
            const dep_field_name = ast.tokenSlice(dep_field_name_token);
            if (std.mem.eql(u8, dep_field_name, "path")) {
                has_path = true;
                path = try parse_string_literal(allocator, ast, dep_field);
            } else if (std.mem.eql(u8, dep_field_name, "url")) {
                url = try parse_string_literal(allocator, ast, dep_field);
            } else if (std.mem.eql(u8, dep_field_name, "hash")) {
                hash = try parse_string_literal(allocator, ast, dep_field);
            } else if (std.mem.eql(u8, dep_field_name, "lazy")) {
                lazy = try parse_bool(ast, dep_field);
            }
        }

        if (has_path) {
            try dependencies.put(allocator, dep_name, .{
                .local = .{ .path = path, .lazy = lazy },
            });
        } else {
            try dependencies.put(allocator, dep_name, .{
                .remote = .{
                    .url = url,
                    .hash = hash,
                    .lazy = lazy,
                },
            });
        }
    }
}

fn parse_release_ignores(
    allocator: Allocator,
    ast: Ast,
    node: Ast.Node.Index,
    ignore_paths: *std.array_hash_map.String(void),
) !void {
    var buf: [2]Ast.Node.Index = undefined;
    const array_init = ast.fullArrayInit(&buf, node) orelse return;

    for (array_init.ast.elements) |elem_node| {
        const path_string = try parse_string_literal(allocator, ast, elem_node);
        errdefer allocator.free(path_string);
        try ignore_paths.put(allocator, path_string, {});
    }
}

fn parse_paths(
    allocator: Allocator,
    ast: Ast,
    node: Ast.Node.Index,
    paths: *std.array_hash_map.String(PathOrigin),
) !void {
    var buf: [2]Ast.Node.Index = undefined;
    const array_init = ast.fullArrayInit(&buf, node) orelse return error.ProjectPathsIsNotArray;

    for (array_init.ast.elements) |elem_node| {
        const path_string = try parse_string_literal(allocator, ast, elem_node);
        errdefer allocator.free(path_string);
        try paths.put(allocator, path_string, .in_filesystem);
    }
}

pub fn deinit(manifest: *Manifest) void {
    manifest.allocator.free(manifest.name);
    manifest.ast.deinit(manifest.allocator);

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
    manifest.dependencies.deinit(manifest.allocator);

    for (manifest.paths.keys()) |path| manifest.allocator.free(path);
    manifest.paths.deinit(manifest.allocator);
}

pub const SerializeOptions = struct {
    minimum_zig_version: ?[]const u8,
};

pub fn serialize(manifest: *Manifest, allocator: Allocator, opts: SerializeOptions) ![]const u8 {
    // Use an arena for all fixup string allocations so they stay alive until
    // after rendering completes.
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const a = arena.allocator();

    var fixups: Ast.Render.Fixups = .{};
    defer fixups.deinit(allocator);

    // Add or replace minimum_zig_version.
    if (opts.minimum_zig_version != null) {
        if (manifest.nodes.minimum_zig_version.unwrap()) |mzv_node| {
            const mzv_text = try std.fmt.allocPrint(a, "\"{s}\"", .{opts.minimum_zig_version.?});
            try fixups.replace_nodes_with_string.put(allocator, mzv_node, mzv_text);
        } else if (manifest.nodes.version.unwrap()) |version_node| {
            const mzv_field = try std.fmt.allocPrint(a, "\n    .minimum_zig_version = \"{s}\",", .{opts.minimum_zig_version.?});
            try fixups.append_string_after_node.put(allocator, version_node, mzv_field);
        }
    }

    // Rewrite dependencies from local to remote.
    if (manifest.nodes.dependencies.unwrap()) |deps_node| {
        if (manifest.dependencies.count() > 0) {
            var deps_buf: std.Io.Writer.Allocating = .init(a);
            try deps_buf.writer.writeAll(".{\n");
            for (manifest.dependencies.keys(), manifest.dependencies.values()) |dep_name, info| {
                switch (info) {
                    .remote => |remote| {
                        try deps_buf.writer.print(
                            "        .{f} = .{{\n            .url = \"{f}\",\n            .hash = \"{f}\",\n            .lazy = {},\n        }},\n",
                            .{
                                std.zig.fmtId(dep_name),
                                std.zig.fmtString(remote.url),
                                std.zig.fmtString(remote.hash),
                                remote.lazy,
                            },
                        );
                    },
                    .local => {},
                }
            }
            try deps_buf.writer.writeAll("    }");
            const deps_text = try deps_buf.toOwnedSlice();
            try fixups.replace_nodes_with_string.put(allocator, deps_node, deps_text);
        }
    }

    // Rewrite paths.
    if (manifest.nodes.paths.unwrap()) |paths_node| {
        var paths_buf: std.Io.Writer.Allocating = .init(a);
        try paths_buf.writer.writeAll(".{\n");
        for (manifest.paths.keys()) |path| {
            try paths_buf.writer.print("        \"{f}\",\n", .{std.zig.fmtString(path)});
        }
        try paths_buf.writer.writeAll("    }");
        const paths_text = try paths_buf.toOwnedSlice();
        try fixups.replace_nodes_with_string.put(allocator, paths_node, paths_text);
    }

    var aw: std.Io.Writer.Allocating = .init(allocator);
    defer aw.deinit();
    try manifest.ast.render(allocator, &aw.writer, fixups);
    return try aw.toOwnedSlice();
}

pub fn get_file_contents(manifest: *Manifest, arena: Allocator, root_dir: std.Io.Dir, io: std.Io, path: []const u8) ![]const u8 {
    const origin = manifest.paths.get(path) orelse return error.FileNotFound;
    return switch (origin) {
        .in_memory => |content| content,
        .in_filesystem => try root_dir.readFileAlloc(io, path, arena, .limited(100 * 1024 * 1024)),
    };
}
