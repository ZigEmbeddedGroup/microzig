const builtin = @import("builtin");
const std = @import("std");

const zigVersionNotSupported =
    @compileError("Zig version " ++
        builtin.zig_version_string ++
        " is not supported by anyverz");

pub const ZigVersion = enum { @"0.16", @"0.17" };

pub const zig_version: ZigVersion = switch (builtin.zig_version.minor) {
    16 => .@"0.16",
    17 => .@"0.17",
    else => zigVersionNotSupported,
};

comptime {
    std.testing.expectEqual(0, builtin.zig_version.major) catch zigVersionNotSupported;
    _ = zig_version;
}

// fields

pub const StructFieldAttributes = switch (zig_version) {
    .@"0.16" => std.builtin.Type.StructField.Attributes,
    .@"0.17" => std.builtin.Type.Struct.FieldAttributes,
};

pub fn fieldsLen(T: type) comptime_int {
    @setEvalBranchQuota(10000);
    return std.meta.fieldNames(T).len;
}

pub const fieldNames = std.meta.fieldNames;

pub fn fieldTypes(T: type) [fieldsLen(T)]type {
    @setEvalBranchQuota(10000);
    comptime switch (zig_version) {
        .@"0.16" => {
            const fieldInfos = std.meta.fields(T);
            var types: [fieldInfos.len]type = undefined;
            for (fieldInfos, 0..) |field, i| types[i] = field.type;
            return types;
        },
        .@"0.17" => return std.meta.fieldTypes(T)[0..fieldsLen(T)].*,
    };
}

pub fn fieldAttrs(T: type) [fieldsLen(T)]StructFieldAttributes {
    @setEvalBranchQuota(10000);
    comptime switch (zig_version) {
        .@"0.16" => {
            const fieldInfos = std.meta.fields(T);
            var attrs: [fieldInfos.len]StructFieldAttributes = undefined;
            for (fieldInfos, 0..) |field, i| attrs[i] = .{
                .@"comptime" = field.is_comptime,
                .@"align" = field.alignment,
                .default_value_ptr = field.default_value_ptr,
            };
            return attrs;
        },
        .@"0.17" => switch (@typeInfo(T)) {
            inline .@"struct", .@"union" => |info| return info.field_attrs[0..fieldsLen(T)].*,
            else => @compileError("Expected struct or union type, found '" ++ @typeName(T) ++ "'"),
        },
    };
}

// declarations

pub fn declsLen(T: type) usize {
    @setEvalBranchQuota(10000);
    return comptime std.meta.declarations(T).len;
}

pub fn declNames(comptime T: type) [declsLen(T)][:0]const u8 {
    @setEvalBranchQuota(10000);
    comptime switch (zig_version) {
        .@"0.16" => {
            const declInfos = std.meta.declarations(T);
            var names: [declInfos.len][:0]const u8 = undefined;
            for (declInfos, 0..) |decl, i| names[i] = decl.name;
            return names;
        },
        .@"0.17" => return std.meta.declarations(T)[0..declsLen(T)].*,
    };
}

// build utilities

pub fn addPassthruArgs(b: *std.Build, run_step: *std.Build.Step.Run) void {
    switch (zig_version) {
        .@"0.16" => if (b.args) |args| run_step.addArgs(args),
        .@"0.17" => run_step.addPassthruArgs(),
    }
}

pub fn buildRoot(b: *std.Build) std.Io.Dir {
    return switch (zig_version) {
        .@"0.16" => b.build_root.handle,
        .@"0.17" => b.root.root_dir.handle,
    };
}

pub fn findProgramLazy(b: *std.Build, names: []const [:0]const u8) std.Build.LazyPath {
    return switch (zig_version) {
        .@"0.16" => .{ .cwd_relative = b.findProgram(names, &.{}) catch
            std.debug.panic("Could not find program {s}", .{names[0]}) },
        .@"0.17" => b.findProgramLazy(.{ .names = names }),
    };
}

pub fn build(b: *std.Build) void {
    _ = b.addModule("anyverz", .{
        .root_source_file = b.path("build.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
}
