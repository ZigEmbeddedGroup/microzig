//! Filesystem to store generated files
gpa: Allocator,
directories: Map(ID, Dir) = .{},
files: Map(ID, File) = .{},
// child -> parent
hierarchy: Map(ID, ID) = .{},
next_id: u16 = 1,

const VirtualFilesystem = @This();

const std = @import("std");
const Allocator = std.mem.Allocator;
const Map = std.AutoArrayHashMapUnmanaged;
const assert = std.debug.assert;

const Directory = @import("Directory.zig");

pub const Kind = enum {
    file,
    directory,
};

pub const Dir = struct {
    name: []const u8,

    pub fn deinit(d: *Dir, gpa: Allocator) void {
        gpa.free(d.name);
    }
};

pub const File = struct {
    name: []const u8,
    content: []const u8,

    pub fn deinit(f: *File, gpa: Allocator) void {
        gpa.free(f.name);
        gpa.free(f.content);
    }
};

pub const ID = enum(u16) {
    root = 0,
    _,
};

pub fn init(gpa: Allocator) VirtualFilesystem {
    return VirtualFilesystem{
        .gpa = gpa,
    };
}

pub fn deinit(fs: *VirtualFilesystem) void {
    for (fs.directories.values()) |*directory| directory.deinit(fs.gpa);
    for (fs.files.values()) |*file| file.deinit(fs.gpa);

    fs.directories.deinit(fs.gpa);
    fs.files.deinit(fs.gpa);
    fs.hierarchy.deinit(fs.gpa);
}

pub fn dir(fs: *VirtualFilesystem) Directory {
    return Directory{
        .ptr = @ptrCast(fs),
        .vtable = &.{
            .create_file = create_file_fn,
        },
    };
}

pub fn get_file(fs: *VirtualFilesystem, path: []const u8) !?ID {
    var components: std.ArrayList([]const u8) = .{};
    defer components.deinit(fs.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try components.append(fs.gpa, component);

    return fs.recursive_get_file(.root, components.items);
}

fn recursive_get_file(fs: *VirtualFilesystem, dir_id: ID, components: []const []const u8) !?ID {
    return switch (components.len) {
        0 => null,
        1 => blk: {
            const children = try fs.get_children(fs.gpa, dir_id);
            defer fs.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .file)
                    continue;

                const name = fs.get_name(child.id);
                if (std.mem.eql(u8, name, components[0]))
                    break child.id;
            } else null;
        },
        else => blk: {
            const children = try fs.get_children(fs.gpa, dir_id);
            defer fs.gpa.free(children);

            break :blk for (children) |child| {
                if (child.kind != .directory)
                    continue;

                break try fs.recursive_get_file(child.id, components[1..]) orelse continue;
            } else null;
        },
    };
}

pub const Entry = struct {
    id: ID,
    kind: Kind,
};

pub fn get_children(fs: *VirtualFilesystem, allocator: Allocator, id: ID) ![]const Entry {
    var ret: std.ArrayList(Entry) = .{};
    for (fs.hierarchy.keys(), fs.hierarchy.values()) |child_id, parent_id| {
        if (parent_id == id)
            try ret.append(allocator, .{
                .id = child_id,
                .kind = fs.get_kind(child_id),
            });
    }
    return ret.toOwnedSlice(allocator);
}

fn new_id(fs: *VirtualFilesystem) ID {
    defer fs.next_id += 1;
    return @enumFromInt(fs.next_id);
}

fn create_dir(fs: *VirtualFilesystem, parent: ID, name: []const u8) !ID {
    const id = fs.new_id();

    const name_copy = try fs.gpa.dupe(u8, name);
    try fs.directories.put(fs.gpa, id, .{
        .name = name_copy,
    });

    try fs.hierarchy.put(fs.gpa, id, parent);

    return id;
}

fn create_file(fs: *VirtualFilesystem, parent: ID, name: []const u8, content: []const u8) !ID {
    const id = fs.new_id();

    const name_copy = try fs.gpa.dupe(u8, name);
    const content_copy = try fs.gpa.dupe(u8, content);
    try fs.files.put(fs.gpa, id, .{
        .name = name_copy,
        .content = content_copy,
    });

    try fs.hierarchy.put(fs.gpa, id, parent);

    return id;
}

pub fn get_kind(fs: *VirtualFilesystem, id: ID) Kind {
    return if (fs.files.contains(id))
        .file
    else if (fs.directories.contains(id))
        .directory
    else
        unreachable;
}

pub fn get_name(fs: *VirtualFilesystem, id: ID) []const u8 {
    return if (fs.files.get(id)) |f|
        f.name
    else if (fs.directories.get(id)) |d|
        d.name
    else
        unreachable;
}

pub fn get_content(fs: *VirtualFilesystem, id: ID) []const u8 {
    assert(fs.get_kind(id) == .file);
    return fs.files.get(id).?.content;
}

fn get_child(fs: *VirtualFilesystem, parent: ID, component: []const u8) ?ID {
    return for (fs.hierarchy.keys(), fs.hierarchy.values()) |child_id, entry_parent_id| {
        if (entry_parent_id == parent and std.mem.eql(u8, component, fs.get_name(child_id)))
            break child_id;
    } else null;
}

fn create_file_fn(ctx: *anyopaque, path: []const u8, content: []const u8) Directory.CreateFileError!void {
    const fs: *VirtualFilesystem = @ptrCast(@alignCast(ctx));

    var components: std.ArrayList([]const u8) = .{};
    defer components.deinit(fs.gpa);

    var it = std.mem.tokenizeScalar(u8, path, '/');
    while (it.next()) |component|
        try components.append(fs.gpa, component);

    var parent: ID = .root;
    if (components.items.len > 1) for (components.items[0 .. components.items.len - 2]) |component| {
        const dir_id: ID = fs.get_child(parent, component) orelse blk: {
            const id = try fs.create_dir(parent, component);
            break :blk id;
        };

        parent = dir_id;
    };

    const file_name = components.items[components.items.len - 1];
    _ = try fs.create_file(parent, file_name, content);
}
