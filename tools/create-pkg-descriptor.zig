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
};

// create-pkg-descriptor <version>
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var arena_impl = std.heap.ArenaAllocator.init(allocator);
    defer arena_impl.deinit();

    const arena = arena_impl.allocator();

    const argv = try std.process.argsAlloc(arena);

    if (argv.len != 3) {
        @panic("version and/or relpath missing!");
    }

    // System configuration:
    const deployment_base_url = "https://download.microzig.tech/packages"; // TODO: Make those configurable

    // build inputs:
    const version_string = argv[1];
    const rel_pkg_path = argv[2];

    const version = try std.SemanticVersion.parse(version_string);

    const json_input = try std.io.getStdIn().readToEndAlloc(arena, 1 << 20);

    errdefer std.log.err("failed to parse json from {s}", .{json_input});

    const metadata = try std.json.parseFromSliceLeaky(MetaData, arena, json_input, .{});

    var buffered_stdout = std.io.bufferedWriter(std.io.getStdOut().writer());

    const stdout = buffered_stdout.writer();
    {
        try stdout.writeAll(".{\n");
        try stdout.print("    .name = \"{}\",\n", .{fmtEscapes(metadata.package_name)});
        try stdout.print("    .version = \"{}\",\n", .{version});
        try stdout.writeAll("    .dependencies = .{\n");
        if (metadata.external_dependencies != .null) {
            const deps = &metadata.external_dependencies.object;
            for (deps.keys(), deps.values()) |key, value| {
                const dep: *const std.json.ObjectMap = &value.object;

                //

                try stdout.print("            .{} = .{{\n", .{fmtId(key)});

                try stdout.print("                .url = \"{}\",\n", .{fmtEscapes(dep.get("url").?.string)});
                try stdout.print("                .hash = \"{}\",\n", .{fmtEscapes(dep.get("hash").?.string)});
                try stdout.writeAll("        },\n");
            }
        }

        switch (metadata.package_type) {
            .core => {
                // core packages are always "standalone" in the microzig environment and provide the root
                // of the build
            },

            .build => {
                //
            },

            .@"board-support" => {
                // bsp packages implicitly depend on the "microzig" package:

                try stdout.writeAll("            .microzig = .{\n");
                try stdout.print("                .url = \"{}/{}\",\n", .{ fmtEscapes(deployment_base_url), fmtEscapes(rel_pkg_path) });
                try stdout.print("                .hash = \"{}\",\n", .{fmtEscapes("???")});
                try stdout.writeAll("        },\n");
            },
        }

        try stdout.writeAll("    },\n");
        try stdout.writeAll("}\n");
    }

    try buffered_stdout.flush();
}
