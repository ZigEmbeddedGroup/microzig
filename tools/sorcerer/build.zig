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
    const register_schema = write_files.add("register_schemas.json", std.json.Stringify.valueAlloc(b.allocator, register_schemas, .{}) catch @panic("OOM"));
    const register_schema_install = b.addInstallFile(register_schema, "data/register_schemas.json");
    b.getInstallStep().dependOn(&register_schema_install.step);

    const dvui_dep = b.dependency("dvui", .{
        .target = target,
        .optimize = optimize,
    });

    const regz_dep = mz_dep.builder.dependency("tools/regz", .{
        .target = target,
        .optimize = optimize,
    });

    const serial_dep = b.dependency("serial", .{
        .target = target,
        .optimize = optimize,
    });

    const dvui_mod = dvui_dep.module("dvui_sdl3");
    const regz_mod = regz_dep.module("regz");
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
        },
    });

    const exe = b.addExecutable(.{
        .name = "sorcerer",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    //run_cmd.addArg("--register-schemas");

    // I only want the path to the register schema file, not the lazy path,
    // because I want to be able to refresh it with `zig build` while sorcerer
    // is running. Sorcerer will watch the file for changes and update itself
    // automatically.
    //run_cmd.addArg(b.getInstallPath(.prefix, register_schema_install.dest_rel_path));
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}

fn get_targets(mb: *MicroBuild) []const *const microzig.Target {
    @setEvalBranchQuota(50000);
    var ret: std.array_list.Managed(*const microzig.Target) = .init(mb.builder.allocator);
    inline for (@typeInfo(@FieldType(MicroBuild, "ports")).@"struct".fields) |field| {
        recursively_collect_targets(@field(mb.ports, field.name), &ret) catch @panic("OOM");
    }

    return ret.toOwnedSlice() catch unreachable;
}

fn recursively_collect_targets(field: anytype, targets: *std.array_list.Managed(*const microzig.Target)) !void {
    const Type = @TypeOf(field);

    switch (Type) {
        *const microzig.Target, *microzig.Target => {
            try targets.append(field);
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
        try recursively_collect_targets(@field(field, child_field.name), targets);
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

    for (targets) |t| switch (t.chip.register_definition) {
        inline else => |lazy_path| {
            try deduped_targets.put(lazy_path, switch (t.chip.register_definition) {
                .svd => .svd,
                .embassy => .embassy,
                .atdf => .atdf,
                .zig => continue,
            });

            if (chips.getEntry(lazy_path)) |entry| {
                try entry.value_ptr.append(b.allocator, .{
                    .name = t.chip.name,
                });
            } else {
                var chip_list: std.ArrayList(RegisterSchemaUsage.Chip) = .{};
                try chip_list.append(b.allocator, .{
                    .name = t.chip.name,
                });
                try chips.put(lazy_path, chip_list);
            }

            if (t.board) |board| if (boards.getEntry(lazy_path)) |entry| {
                try entry.value_ptr.append(b.allocator, .{
                    .name = board.name,
                });
            } else {
                var board_list: std.ArrayList(RegisterSchemaUsage.Board) = .{};
                try board_list.append(b.allocator, .{
                    .name = board.name,
                });
                try boards.put(lazy_path, board_list);
            };
        },
    };

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
