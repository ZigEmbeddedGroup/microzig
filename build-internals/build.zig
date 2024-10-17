const std = @import("std");
const Build = std.Build;
const LazyPath = Build.LazyPath;
const Module = Build.Module;

const TargetRegistry = std.AutoHashMap(*const TargetAlias, Target);

var target_registry: TargetRegistry = TargetRegistry.init(std.heap.page_allocator);

pub fn build(_: *Build) void {}

pub fn get_target(alias: *const TargetAlias) ?Target {
    return target_registry.get(alias);
}

pub fn submit_target(alias: *const TargetAlias, target: Target) void {
    const entry = target_registry.getOrPut(alias) catch @panic("out of memory");
    if (entry.found_existing) @panic("target submitted twice");
    entry.value_ptr.* = target;
}

/// MicroZig target definition.
pub const Target = struct {
    cpu: std.Target.Query,

    linker_script: LazyPath,

    chip: struct {
        name: []const u8,
        module: ModuleDeclaration,
    },

    hal: ?ModuleDeclaration = null,

    board: ?ModuleDeclaration = null,
};

pub const TargetAlias = struct {
    name: []const u8,

    pub fn init(name: []const u8) TargetAlias {
        return .{ .name = name };
    }
};

pub const ModuleDeclaration = struct {
    b: *Build,
    root_source_file: LazyPath,
    imports: []const Module.Import,

    pub fn init(b: *Build, options: struct {
        root_source_file: LazyPath,
        imports: []const Module.Import = &.{},
    }) ModuleDeclaration {
        const allocated_imports = b.allocator.dupe(Module.Import, options.imports) catch @panic("out of memory");
        return .{
            .b = b,
            .root_source_file = options.root_source_file,
            .imports = allocated_imports,
        };
    }

    pub fn create_module(decl: ModuleDeclaration) *Module {
        return decl.b.createModule(.{
            .root_source_file = decl.root_source_file,
            .imports = decl.imports,
        });
    }
};
