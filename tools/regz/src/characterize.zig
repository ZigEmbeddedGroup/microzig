const std = @import("std");
const json = std.json;
const xml = @import("xml.zig");

const Results = std.StringHashMap(struct {
    repeated: bool,
    total_count: usize,
    attr_counts: std.StringHashMapUnmanaged(usize),
});

const AttrUsage = enum {
    // this doesn't necessarily mean an attr is required, just that it's used
    // every time
    required,
    optional,
};

const PrintedResult = struct {
    key: []const u8,
    repeated: bool,
    attrs: std.StringHashMapUnmanaged(AttrUsage),

    fn less_than(_: void, lhs: PrintedResult, rhs: PrintedResult) bool {
        return std.ascii.lessThanIgnoreCase(lhs.key, rhs.key);
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var results = Results.init(gpa.allocator());
    defer {
        var it = results.iterator();
        while (it.next()) |entry|
            entry.value_ptr.attr_counts.deinit(gpa.allocator());

        results.deinit();
    }

    var path_buf: [4096]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    while (try stdin.readUntilDelimiterOrEof(&path_buf, '\n')) |path| {
        // path is not needed outside of the loop
        std.log.info("path: {s}", .{path});
        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();

        const text = try file.readToEndAlloc(gpa.allocator(), std.math.maxInt(usize));
        defer gpa.allocator().free(text);

        var doc = try xml.Doc.from_memory(text);
        defer doc.deinit();

        var found = std.StringHashMap(void).init(gpa.allocator());
        defer found.deinit();

        const root_element: *xml.Node = try doc.get_root_element();
        try recursive_characterize(&arena, root_element, &.{}, &found, &results);
    }

    var ordered = std.ArrayList(PrintedResult).init(gpa.allocator());
    defer {
        for (ordered.items) |*item|
            item.attrs.deinit(gpa.allocator());

        ordered.deinit();
    }

    const stdout = std.io.getStdOut().writer();
    var it = results.iterator();
    while (it.next()) |entry| {
        var tree = json.ValueTree{
            .arena = std.heap.ArenaAllocator.init(gpa.allocator()),
            .root = json.Value{ .Object = json.ObjectMap.init(gpa.allocator()) },
        };
        defer {
            var tree_it = tree.root.Object.iterator();
            while (tree_it.next()) |tree_entry|
                if (tree_entry.value_ptr.* == .Object)
                    tree_entry.value_ptr.Object.deinit();

            tree.root.Object.deinit();
            tree.deinit();
        }

        try tree.root.Object.put("name", .{
            .String = entry.key_ptr.*,
        });

        try tree.root.Object.put("repeated", .{
            .Bool = entry.value_ptr.repeated,
        });

        if (entry.value_ptr.attr_counts.count() > 0) {
            var obj = json.Value{ .Object = json.ObjectMap.init(gpa.allocator()) };

            var attr_it = entry.value_ptr.attr_counts.iterator();
            while (attr_it.next()) |attr_entry| {
                try obj.Object.put(attr_entry.key_ptr.*, json.Value{
                    .String = if (entry.value_ptr.total_count == attr_entry.value_ptr.*)
                        "required"
                    else
                        "optional",
                });
            }

            try tree.root.Object.put("attrs", obj);
        }

        try tree.root.jsonStringify(.{}, stdout);
        try stdout.writeByte('\n');
    }
}

const CharacterizeError = error{OutOfMemory};
fn recursive_characterize(
    arena: *std.heap.ArenaAllocator,
    node: *xml.Node,
    parent_location: []const []const u8,
    parent_found: *std.StringHashMap(void),
    results: *Results,
) CharacterizeError!void {
    const allocator = arena.child_allocator;
    var location = std.ArrayList([]const u8).init(allocator);
    defer location.deinit();

    if (node.name) |name| {
        try location.appendSlice(parent_location);
        try location.append(std.mem.span(name));
    } else return;

    const key = try std.mem.join(arena.allocator(), ".", location.items);
    const result = try results.getOrPut(key);
    if (!result.found_existing) {
        result.value_ptr.* = .{
            .repeated = false,
            .attr_counts = .{},
            .total_count = 0,
        };
    }

    result.value_ptr.total_count += 1;
    var attr_it: ?*xml.Attr = node.properties;
    while (attr_it != null) : (attr_it = attr_it.?.next) {
        if (attr_it.?.name) |name| {
            const name_slice = std.mem.span(name);
            if (result.value_ptr.attr_counts.getEntry(name_slice)) |entry| {
                entry.value_ptr.* += 1;
            } else {
                try result.value_ptr.attr_counts.put(
                    allocator,
                    try arena.allocator().dupe(u8, name_slice),
                    1,
                );
            }
        }
    }

    if (parent_found.contains(key))
        result.value_ptr.repeated = true
    else
        try parent_found.put(key, {});

    var found = std.StringHashMap(void).init(allocator);
    defer found.deinit();

    var child_it: ?*xml.Node = node.children;
    while (child_it != null) : (child_it = child_it.?.next) {
        if (child_it.?.type != 1)
            continue;

        try recursive_characterize(arena, child_it.?, location.items, &found, results);
    }
}
