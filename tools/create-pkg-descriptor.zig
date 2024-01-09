const std = @import("std");
const eggzon = @import("eggzon");

const fmtEscapes = std.zig.fmtEscapes;
const fmtId = std.zig.fmtId;

const Archive = struct {
    sha256sum: []const u8,
    size: []const u8,
};

const Package = struct {
    hash: []const u8,
    files: []const []const u8,
};

const Timestamp = struct {
    iso: []const u8,
    unix: []const u8,
};

const MetaData = struct {
    const Type = enum {
        @"board-support",
        core,
        build,
    };

    package_name: []const u8,
    package_type: Type,
    version: []const u8,

    inner_dependencies: []const []const u8 = &.{},
    external_dependencies: std.json.Value = .null,

    archive: ?Archive = null,
    package: ?Package = null,
    created: ?Timestamp = null,

    download_url: ?[]const u8 = null,

    microzig: std.json.Value = .null,
};

fn findPackage(packages: []const MetaData, name: []const u8) ?*const MetaData {
    return for (packages) |*pkg| {
        if (std.mem.eql(u8, pkg.package_name, name))
            return pkg;
    } else null;
}

fn renderDep(writer: anytype, name: []const u8, url: []const u8, hash: []const u8) !void {
    try writer.print("            .{} = .{{\n", .{fmtId(name)});
    try writer.print("                .url = \"{}\",\n", .{fmtEscapes(url)});
    try writer.print("                .hash = \"{}\",\n", .{fmtEscapes(hash)});
    try writer.writeAll("        },\n");
}

// create-pkg-descriptor <package_name>
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var arena_impl = std.heap.ArenaAllocator.init(allocator);
    defer arena_impl.deinit();

    const arena = arena_impl.allocator();

    const argv = try std.process.argsAlloc(arena);

    if (argv.len != 2) {
        @panic("version and/or relpath missing!");
    }

    // build inputs:
    const pkg_name = argv[1];

    const json_input = try std.io.getStdIn().readToEndAlloc(arena, 1 << 20);

    errdefer std.log.err("failed to parse json from {s}", .{json_input});

    const all_packages = try std.json.parseFromSliceLeaky([]MetaData, arena, json_input, .{});

    const package = findPackage(all_packages, pkg_name).?;

    const version = try std.SemanticVersion.parse(package.version);

    var buffered_stdout = std.io.bufferedWriter(std.io.getStdOut().writer());

    const stdout = buffered_stdout.writer();
    {
        try stdout.writeAll(".{\n");
        try stdout.print("    .name = \"{}\",\n", .{fmtEscapes(package.package_name)});
        try stdout.print("    .version = \"{}\",\n", .{version});
        try stdout.writeAll("    .dependencies = .{\n");
        if (package.external_dependencies != .null) {
            const deps = &package.external_dependencies.object;
            for (deps.keys(), deps.values()) |key, value| {
                const dep: *const std.json.ObjectMap = &value.object;
                try renderDep(
                    stdout,
                    key,
                    dep.get("url").?.string,
                    dep.get("hash").?.string,
                );
            }
        }

        // Add all other dependencies:
        for (package.inner_dependencies) |dep_name| {
            const dep = findPackage(all_packages, dep_name).?;

            try renderDep(
                stdout,
                "microzig",
                dep.download_url.?,
                dep.package.?.hash,
            );
        }

        try stdout.writeAll("    },\n");
        try stdout.writeAll("}\n");
    }

    try buffered_stdout.flush();
}
