const std = @import("std");
const LazyPath = std.Build.LazyPath;
const microzig = @import("microzig");
const RegisterSchemaUsage = @import("src/RegisterSchemaUsage.zig");

const MicroBuild = microzig.MicroBuild(.all);

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});

    const mb = MicroBuild.init(b, mz_dep) orelse return;
    const register_schemas = get_register_schemas(b, mb) catch @panic("OOM");
    const write_files = b.addWriteFiles();

    // Generate Zig file with embedded schemas (used by both CLI and GUI)
    const register_schema_zig = write_files.add("register_schemas.zig", generate_zig_schema_literal(b.allocator, register_schemas) catch @panic("OOM"));

    const regz_dep = mz_dep.builder.dependency("tools/regz", .{
        .target = target,
        // Setting to release safe because on debug builds its what slows
        // things down. It _should_ be solid for the most part once you're
        // developing Sorcerer, if that's not the case then you can change this
        // manually.
        .optimize = .ReleaseSafe,
    });

    const regz_mod = regz_dep.module("regz");

    // Shared module for RegisterSchemaUsage (used by both schemas_mod and cli_mod)
    const register_schema_usage_mod = b.createModule(.{
        .root_source_file = b.path("src/RegisterSchemaUsage.zig"),
    });

    // Create schemas module from generated Zig file
    const schemas_mod = b.createModule(.{
        .root_source_file = register_schema_zig,
        .imports = &.{
            .{ .name = "RegisterSchemaUsage", .module = register_schema_usage_mod },
        },
    });

    // ─────────────────────────────────────────────────────────────────────────
    // CLI executable
    // ─────────────────────────────────────────────────────────────────────────
    const cli_mod = b.createModule(.{
        .root_source_file = b.path("src/cli.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "regz", .module = regz_mod },
            .{ .name = "schemas", .module = schemas_mod },
            .{ .name = "RegisterSchemaUsage", .module = register_schema_usage_mod },
        },
    });

    const cli_exe = b.addExecutable(.{
        .name = "sorcerer-cli",
        .root_module = cli_mod,
    });
    b.installArtifact(cli_exe);

    const run_cli_cmd = b.addRunArtifact(cli_exe);
    run_cli_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cli_cmd.addArgs(args);
    }
    const run_cli_step = b.step("run-cli", "Run the CLI tool");
    run_cli_step.dependOn(&run_cli_cmd.step);

    // ─────────────────────────────────────────────────────────────────────────
    // GUI executable
    // ─────────────────────────────────────────────────────────────────────────
    const dvui_dep = b.dependency("dvui", .{
        .target = target,
        .optimize = optimize,
    });

    const serial_dep = b.dependency("serial", .{
        .target = target,
        .optimize = optimize,
    });

    const dvui_mod = dvui_dep.module("dvui_sdl3");
    const serial_mod = serial_dep.module("serial");

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{
                .name = "dvui",
                .module = dvui_mod,
            },
            .{
                .name = "regz",
                .module = regz_mod,
            },
            .{
                .name = "serial",
                .module = serial_mod,
            },
            .{
                .name = "schemas",
                .module = schemas_mod,
            },
            .{
                .name = "RegisterSchemaUsage",
                .module = register_schema_usage_mod,
            },
        },
    });

    const tree_sitter_zig_dep = b.lazyDependency("tree_sitter_zig", .{
        .target = target,
        .optimize = optimize,
    });
    if (tree_sitter_zig_dep) |tsd| {
        exe_mod.addIncludePath(tsd.path("src"));
        exe_mod.addCSourceFiles(.{
            .root = tsd.path(""),
            .files = &.{"src/parser.c"},
            .flags = &.{"-std=c11"},
        });
    }

    const tree_sitter_diff_dep = b.lazyDependency("tree_sitter_diff", .{
        .target = target,
        .optimize = optimize,
    });
    if (tree_sitter_diff_dep) |tsd| {
        exe_mod.addIncludePath(tsd.path("src"));
        exe_mod.addCSourceFiles(.{
            .root = tsd.path(""),
            .files = &.{"src/parser.c"},
            .flags = &.{"-std=c11"},
        });
    }

    const diffz_dep = b.dependency("diffz", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("diffz", diffz_dep.module("diffz"));

    const exe = b.addExecutable(.{
        .name = "sorcerer",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    // I only want the path to the register schema file, not the lazy path,
    // because I want to be able to refresh it with `zig build` while sorcerer
    // is running. Sorcerer will watch the file for changes and update itself
    // automatically.
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the GUI app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);

    // Diff algorithm unit tests
    const diff_test_mod = b.createModule(.{
        .root_source_file = b.path("src/test_diff.zig"),
        .target = target,
        .optimize = optimize,
    });
    diff_test_mod.addImport("diffz", diffz_dep.module("diffz"));

    const diff_tests = b.addTest(.{
        .root_module = diff_test_mod,
    });

    const run_diff_tests = b.addRunArtifact(diff_tests);
    test_step.dependOn(&run_diff_tests.step);
}

const TargetWithPath = struct {
    target: *const microzig.Target,
    path: []const u8,
};

fn get_targets(mb: *MicroBuild) []const TargetWithPath {
    @setEvalBranchQuota(50000);
    var ret: std.array_list.Managed(TargetWithPath) = .init(mb.builder.allocator);
    inline for (@typeInfo(@FieldType(MicroBuild, "ports")).@"struct".fields) |field| {
        recursively_collect_targets(@field(mb.ports, field.name), field.name, &ret) catch @panic("OOM");
    }

    return ret.toOwnedSlice() catch unreachable;
}

fn recursively_collect_targets(field: anytype, path: []const u8, targets: *std.array_list.Managed(TargetWithPath)) !void {
    const Type = @TypeOf(field);

    switch (Type) {
        *const microzig.Target, *microzig.Target => {
            try targets.append(.{ .target = field, .path = path });
            return;
        },
        else => {},
    }

    const type_info = @typeInfo(Type);
    if (type_info != .@"struct") {
        std.log.info("missed type: {s}", .{@typeName(Type)});
        return;
    }

    inline for (type_info.@"struct".fields) |child_field| {
        const new_path = std.fmt.allocPrint(targets.allocator, "{s}.{s}", .{ path, child_field.name }) catch @panic("OOM");
        try recursively_collect_targets(@field(field, child_field.name), new_path, targets);
    }
}

fn find_target_location(b: *std.Build, lazy_path: LazyPath) RegisterSchemaUsage.Location {
    return switch (lazy_path) {
        .src_path => |src_path| blk: {
            const build_root = get_build_root(b, src_path.owner);
            break :blk .{
                .src_path = .{
                    .build_root = build_root,
                    //.owner = src_path.owner,
                    .sub_path = src_path.sub_path,
                    .port_name = get_port_name(build_root),
                },
            };
        },
        .dependency => |val| {
            const dependency = val.dependency;
            const sub_path = val.sub_path;
            const build_root = get_build_root(b, dependency.builder);
            const root = @import("root");
            const packages = root.dependencies.packages;
            const package_hash = inline for (@typeInfo(packages).@"struct".decls) |decl| {
                const package = @field(packages, decl.name);
                if (!@hasDecl(package, "build_root"))
                    continue;

                if (std.mem.eql(u8, package.build_root, build_root)) {
                    break decl.name;
                }
            } else unreachable;

            const Pair = struct { port: []const u8, dep: []const u8 };
            const result: Pair = outer: inline for (@typeInfo(packages).@"struct".decls) |decl| {
                const package = @field(packages, decl.name);
                if (!@hasDecl(package, "deps"))
                    continue;

                for (package.deps) |dep| {
                    const name = dep[0];
                    const dep_package_hash = dep[1];
                    if (std.mem.eql(u8, package_hash, dep_package_hash)) {
                        break :outer .{ .port = decl.name, .dep = name };
                    }
                }
            } else unreachable;

            return .{
                .dependency = .{
                    //.dependency = dependency,
                    .sub_path = sub_path,
                    .build_root = build_root,
                    .port_name = get_port_name(result.port),
                    .dep_name = result.dep,
                },
            };
        },
        else => unreachable,
    };
}

fn convert_patch_files(b: *std.Build, patch_files: []const LazyPath) ![]const RegisterSchemaUsage.PatchFile {
    var result: std.ArrayList(RegisterSchemaUsage.PatchFile) = .{};
    for (patch_files) |patch_file| {
        const converted: RegisterSchemaUsage.PatchFile = switch (patch_file) {
            .src_path => |src_path| .{
                .src_path = .{
                    .build_root = get_build_root(b, src_path.owner),
                    .sub_path = src_path.sub_path,
                },
            },
            .dependency => |dep| .{
                .dependency = .{
                    .build_root = get_build_root(b, dep.dependency.builder),
                    .sub_path = dep.sub_path,
                    .dep_name = find_dep_name(b, dep.dependency),
                },
            },
            else => continue,
        };
        try result.append(b.allocator, converted);
    }
    return result.toOwnedSlice(b.allocator);
}

fn find_dep_name(b: *std.Build, dependency: *std.Build.Dependency) []const u8 {
    const build_root = get_build_root(b, dependency.builder);
    const root = @import("root");
    const packages = root.dependencies.packages;
    const package_hash = inline for (@typeInfo(packages).@"struct".decls) |decl| {
        const package = @field(packages, decl.name);
        if (!@hasDecl(package, "build_root"))
            continue;

        if (std.mem.eql(u8, package.build_root, build_root)) {
            break decl.name;
        }
    } else unreachable;

    inline for (@typeInfo(packages).@"struct".decls) |decl| {
        const package = @field(packages, decl.name);
        if (!@hasDecl(package, "deps"))
            continue;

        for (package.deps) |dep| {
            const name = dep[0];
            const dep_package_hash = dep[1];
            if (std.mem.eql(u8, package_hash, dep_package_hash)) {
                return name;
            }
        }
    }

    unreachable;
}

fn get_build_root(b: *std.Build, owner: *std.Build) []const u8 {
    var it = b.graph.dependency_cache.iterator();
    return while (it.next()) |entry| {
        if (entry.value_ptr.*.builder == owner) {
            break entry.key_ptr.build_root_string;
        }
    } else unreachable;
}

const LazyPathContext = struct {
    pub const hash = std.array_hash_map.getAutoHashStratFn(LazyPath, @This(), .Shallow);
    pub fn eql(_: @This(), a: LazyPath, b: LazyPath, _: usize) bool {
        const a_tag: std.meta.Tag(LazyPath) = a;
        const b_tag: std.meta.Tag(LazyPath) = b;
        if (a_tag != b_tag)
            return false;

        return switch (a) {
            .src_path => |val| val.owner == b.src_path.owner and std.mem.eql(u8, val.sub_path, b.src_path.sub_path),
            .generated => @panic("Generated paths unsupported"),
            .cwd_relative => @panic("Cwd relative paths unsupported, you probably shouldn't be vendoring that in MicroZig anyways"),
            .dependency => |val| val.dependency == b.dependency.dependency and std.mem.eql(u8, val.sub_path, b.dependency.sub_path),
        };
    }
};

fn LazyPathHashMap(comptime Value: type) type {
    return std.ArrayHashMap(std.Build.LazyPath, Value, LazyPathContext, true);
}

fn get_register_schemas(b: *std.Build, mb: *MicroBuild) ![]const RegisterSchemaUsage {
    const targets = get_targets(mb);
    var deduped_targets: LazyPathHashMap(RegisterSchemaUsage.Format) = .init(b.allocator);
    var chips: LazyPathHashMap(std.ArrayList(RegisterSchemaUsage.Chip)) = .init(b.allocator);
    var boards: LazyPathHashMap(std.ArrayList(RegisterSchemaUsage.Board)) = .init(b.allocator);
    var locations: LazyPathHashMap(RegisterSchemaUsage.Location) = .init(b.allocator);

    for (targets) |twp| {
        const t = twp.target;
        const lazy_path = switch (t.chip.register_definition) {
            .targetdb => |targetdb| blk: {
                try deduped_targets.put(targetdb.path, .targetdb);
                break :blk targetdb.path;
            },
            .embassy => |embassy| blk: {
                try deduped_targets.put(embassy.path, .embassy);
                break :blk embassy.path;
            },
            inline else => |lazy_path| blk: {
                try deduped_targets.put(lazy_path, switch (t.chip.register_definition) {
                    .svd => .svd,
                    .atdf => .atdf,
                    .embassy, .targetdb => unreachable,
                    .zig => continue,
                });

                break :blk lazy_path;
            },
        };

        const patch_files = try convert_patch_files(b, t.chip.patch_files);

        if (chips.getEntry(lazy_path)) |entry| {
            try entry.value_ptr.append(b.allocator, .{
                .name = t.chip.name,
                .target_name = twp.path,
                .patch_files = patch_files,
            });
        } else {
            var chip_list: std.ArrayList(RegisterSchemaUsage.Chip) = .{};
            try chip_list.append(b.allocator, .{
                .name = t.chip.name,
                .target_name = twp.path,
                .patch_files = patch_files,
            });
            try chips.put(lazy_path, chip_list);
        }

        if (t.board) |board| if (boards.getEntry(lazy_path)) |entry| {
            // Check if this board name already exists (deduplicate by name)
            const board_exists = for (entry.value_ptr.items) |existing_board| {
                if (std.mem.eql(u8, existing_board.name, board.name)) break true;
            } else false;

            if (!board_exists) {
                try entry.value_ptr.append(b.allocator, .{
                    .name = board.name,
                });
            }
        } else {
            var board_list: std.ArrayList(RegisterSchemaUsage.Board) = .{};
            try board_list.append(b.allocator, .{
                .name = board.name,
            });
            try boards.put(lazy_path, board_list);
        };
    }

    for (deduped_targets.keys()) |lazy_path| {
        const location = find_target_location(b, lazy_path);
        try locations.put(lazy_path, location);
    }

    var ret: std.ArrayList(RegisterSchemaUsage) = .{};
    for (deduped_targets.keys(), deduped_targets.values()) |lazy_path, format| {
        var chip_list = chips.get(lazy_path).?;
        var board_list = boards.get(lazy_path);
        try ret.append(b.allocator, .{
            .format = format,
            .location = locations.get(lazy_path).?,
            .chips = try chip_list.toOwnedSlice(b.allocator),
            .boards = if (board_list) |*bl| try bl.toOwnedSlice(b.allocator) else &.{},
        });
    }

    return ret.toOwnedSlice(b.allocator);
}

fn get_port_name(path: []const u8) []const u8 {
    var i: u32 = 0;
    var slash_count: u32 = 0;
    while (i < path.len) : (i += 1) {
        if (path[path.len - i - 1] == '/') {
            switch (slash_count) {
                0 => slash_count += 1,
                1 => {
                    const start = path.len - i;
                    return path[start..];
                },
                else => unreachable,
            }
        }
    }

    unreachable;
}

/// Generate a Zig source file containing the register schemas as compile-time constants.
fn generate_zig_schema_literal(allocator: std.mem.Allocator, schemas: []const RegisterSchemaUsage) ![]const u8 {
    var buf: std.ArrayList(u8) = .{};
    const writer = buf.writer(allocator);

    // Helper to normalize paths (convert backslashes to forward slashes for Windows compatibility)
    const normalize_path = struct {
        fn call(alloc: std.mem.Allocator, path: []const u8) ![]const u8 {
            const result = try alloc.alloc(u8, path.len);
            for (path, 0..) |c, i| {
                result[i] = if (c == '\\') '/' else c;
            }
            return result;
        }
    }.call;

    try writer.writeAll(
        \\// Auto-generated file - do not edit manually.
        \\// Generated by tools/sorcerer/build.zig
        \\
        \\const RegisterSchemaUsage = @import("RegisterSchemaUsage");
        \\
        \\pub const schemas: []const RegisterSchemaUsage = &.{
        \\
    );

    for (schemas) |schema| {
        try writer.writeAll("    .{\n");

        // Format
        try writer.print("        .format = .{s},\n", .{@tagName(schema.format)});

        // Chips
        try writer.writeAll("        .chips = &.{\n");
        for (schema.chips) |chip| {
            try writer.writeAll("            .{\n");
            try writer.print("                .name = \"{s}\",\n", .{chip.name});
            try writer.print("                .target_name = \"{s}\",\n", .{chip.target_name});
            // Patch files
            if (chip.patch_files.len > 0) {
                try writer.writeAll("                .patch_files = &.{\n");
                for (chip.patch_files) |patch_file| {
                    switch (patch_file) {
                        .src_path => |src| {
                            const sub_path = try normalize_path(allocator, src.sub_path);
                            const build_root = try normalize_path(allocator, src.build_root);
                            try writer.writeAll("                    .{ .src_path = .{\n");
                            try writer.print("                        .sub_path = \"{s}\",\n", .{sub_path});
                            try writer.print("                        .build_root = \"{s}\",\n", .{build_root});
                            try writer.writeAll("                    } },\n");
                        },
                        .dependency => |dep| {
                            const sub_path = try normalize_path(allocator, dep.sub_path);
                            const build_root = try normalize_path(allocator, dep.build_root);
                            try writer.writeAll("                    .{ .dependency = .{\n");
                            try writer.print("                        .sub_path = \"{s}\",\n", .{sub_path});
                            try writer.print("                        .build_root = \"{s}\",\n", .{build_root});
                            try writer.print("                        .dep_name = \"{s}\",\n", .{dep.dep_name});
                            try writer.writeAll("                    } },\n");
                        },
                    }
                }
                try writer.writeAll("                },\n");
            }
            try writer.writeAll("            },\n");
        }
        try writer.writeAll("        },\n");

        // Boards
        try writer.writeAll("        .boards = &.{");
        for (schema.boards, 0..) |board, i| {
            if (i > 0) try writer.writeAll(", ");
            try writer.print(".{{ .name = \"{s}\" }}", .{board.name});
        }
        try writer.writeAll("},\n");

        // Location
        try writer.writeAll("        .location = ");
        switch (schema.location) {
            .src_path => |src| {
                try writer.writeAll(".{ .src_path = .{\n");
                try writer.print("            .port_name = \"{s}\",\n", .{src.port_name});
                try writer.print("            .sub_path = \"{s}\",\n", .{src.sub_path});
                try writer.print("            .build_root = \"{s}\",\n", .{src.build_root});
                try writer.writeAll("        } },\n");
            },
            .dependency => |dep| {
                try writer.writeAll(".{ .dependency = .{\n");
                try writer.print("            .sub_path = \"{s}\",\n", .{dep.sub_path});
                try writer.print("            .build_root = \"{s}\",\n", .{dep.build_root});
                try writer.print("            .dep_name = \"{s}\",\n", .{dep.dep_name});
                try writer.print("            .port_name = \"{s}\",\n", .{dep.port_name});
                try writer.writeAll("        } },\n");
            },
        }

        try writer.writeAll("    },\n");
    }

    try writer.writeAll(
        \\};
        \\
    );

    return buf.toOwnedSlice(allocator);
}
