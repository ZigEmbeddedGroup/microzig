//! This program takes nested xml objects and turns them into newline delimited JSON
const std = @import("std");
const json = std.json;
const assert = std.debug.assert;

const xml = @import("xml");

const ContextMap = std.StringHashMap(std.StringHashMapUnmanaged([]const u8));

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .stack_trace_frames = 10 }){};
    defer _ = gpa.deinit();

    var args = std.process.args();
    _ = args.next();

    const query = args.next() orelse return error.NoQuery;
    const path = args.next() orelse return error.NoXmlPath;
    if (args.next() != null)
        return error.TooManyArgs;

    var components = std.ArrayList([]const u8).init(gpa.allocator());
    defer components.deinit();

    {
        var it = std.mem.split(u8, query, ".");
        while (it.next()) |component|
            try components.append(component);
    }

    if (components.items.len == 0)
        return error.NoComponents;

    const doc = xml.readFile(path.ptr, null, 0) orelse return error.ReadXmlFile;
    const root_element: *xml.Node = xml.docGetRootElement(doc) orelse return error.NoRoot;
    if (!std.mem.eql(u8, components.items[0], std.mem.span(root_element.name)))
        return;

    var context = std.StringHashMap(std.StringHashMapUnmanaged([]const u8)).init(gpa.allocator());
    defer context.deinit();

    const stdout = std.io.getStdOut().writer();
    try recursiveSearchAndPrint(
        gpa.allocator(),
        components.items,
        context,
        root_element,
        stdout,
    );

    var children: ?*xml.Node = root_element.children;
    while (children != null) : (children = children.?.next) {
        if (1 != children.?.type)
            continue;
    }
}

fn RecursiveSearchAndPrintError(comptime Writer: type) type {
    return Writer.Error || error{OutOfMemory};
}

fn recursiveSearchAndPrint(
    allocator: std.mem.Allocator,
    components: []const []const u8,
    context: ContextMap,
    node: *xml.Node,
    writer: anytype,
) RecursiveSearchAndPrintError(@TypeOf(writer))!void {
    assert(components.len != 0);

    var attr_map = std.StringHashMapUnmanaged([]const u8){};
    defer attr_map.deinit(allocator);

    {
        var attr_it: ?*xml.Attr = node.properties;
        while (attr_it != null) : (attr_it = attr_it.?.next)
            if (attr_it.?.name) |name|
                if (@ptrCast(*xml.Node, attr_it.?.children).content) |content|
                    try attr_map.put(allocator, std.mem.span(name), std.mem.span(content));
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
        // we're done, convert into json tree and write to writer.
        var tree = json.ValueTree{
            .arena = std.heap.ArenaAllocator.init(allocator),
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
        var child_it: ?*xml.Node = node.children;
        while (child_it != null) : (child_it = child_it.?.next) {
            if (1 != child_it.?.type)
                continue;

            if (std.mem.eql(u8, components[1], std.mem.span(child_it.?.name)))
                try recursiveSearchAndPrint(
                    allocator,
                    components[1..],
                    current_context,
                    child_it.?,
                    writer,
                );
        }
    }
}
