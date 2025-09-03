//! This program takes nested xml objects and turns them into newline delimited JSON
const std = @import("std");
const json = std.json;
const assert = std.debug.assert;

const xml = @import("xml.zig");

const ContextMap = std.StringHashMap(std.StringHashMapUnmanaged([]const u8));

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .stack_trace_frames = 10 }){};
    defer _ = gpa.deinit();

    var args = std.process.args();
    _ = args.next();

    const query = args.next() orelse return error.NoQuery;
    const path = try gpa.allocator().dupeZ(u8, args.next() orelse return error.NoXmlPath);
    defer gpa.allocator().free(path);
    if (args.next() != null)
        return error.TooManyArgs;

    var components = std.array_list.Managed([]const u8).init(gpa.allocator());
    defer components.deinit();

    {
        var it = std.mem.split(u8, query, ".");
        while (it.next()) |component|
            try components.append(component);
    }

    if (components.items.len == 0)
        return error.NoComponents;

    var doc = try xml.Doc.from_file(path);
    defer doc.deinit();

    const root = try doc.get_root_element();
    if (!std.mem.eql(u8, components.items[0], std.mem.span(root.impl.name)))
        return;

    var base = std.StringHashMapUnmanaged([]const u8){};
    defer base.deinit(gpa.allocator());

    try base.put(gpa.allocator(), "path", path);
    var context = std.StringHashMap(std.StringHashMapUnmanaged([]const u8)).init(gpa.allocator());
    defer context.deinit();

    try context.put("file", base);
    const stdout = std.io.getStdOut().writer();
    try recursive_search_and_print(
        gpa.allocator(),
        components.items,
        context,
        root,
        stdout,
    );
}

fn recursive_search_and_print_error(comptime Writer: type) type {
    return Writer.Error || error{OutOfMemory};
}

fn recursive_search_and_print(
    allocator: std.mem.Allocator,
    components: []const []const u8,
    context: ContextMap,
    node: xml.Node,
    writer: anytype,
) !void {
    assert(components.len != 0);

    var attr_map = std.StringHashMapUnmanaged([]const u8){};
    defer attr_map.deinit(allocator);

    {
        var it = node.iterate_attrs();
        while (it.next()) |attr|
            try attr_map.put(allocator, attr.key, attr.value);
    }

    var current_context = ContextMap.init(allocator);
    defer current_context.deinit();

    {
        var it = context.iterator();
        while (it.next()) |entry|
            try current_context.put(entry.key_ptr.*, entry.value_ptr.*);
    }

    if (attr_map.count() > 0)
        try current_context.put(components[0], attr_map);

    if (components.len == 1) {
        const arena = try allocator.create(std.heap.ArenaAllocator);
        arena.* = std.heap.ArenaAllocator.init(allocator);
        // we're done, convert into json tree and write to writer.
        var tree = json.ValueTree{
            .arena = arena,
            .root = json.Value{ .Object = json.ObjectMap.init(allocator) },
        };
        defer {
            var it = tree.root.Object.iterator();
            while (it.next()) |entry|
                entry.value_ptr.Object.deinit();

            tree.root.Object.deinit();
            tree.deinit();
        }

        var it = current_context.iterator();
        while (it.next()) |entry| {
            var obj = json.Value{ .Object = json.ObjectMap.init(allocator) };

            var attr_it = entry.value_ptr.iterator();
            while (attr_it.next()) |attr_entry| {
                try obj.Object.put(attr_entry.key_ptr.*, json.Value{
                    .String = attr_entry.value_ptr.*,
                });
            }

            try tree.root.Object.put(entry.key_ptr.*, obj);
        }

        try tree.root.jsonStringify(.{}, writer);
        try writer.writeByte('\n');
    } else {
        // pass it down to the children
        var child_it = node.iterate(&.{}, components[1]);
        while (child_it.next()) |child| {
            try recursive_search_and_print(
                allocator,
                components[1..],
                current_context,
                child,
                writer,
            );
        }
    }
}
