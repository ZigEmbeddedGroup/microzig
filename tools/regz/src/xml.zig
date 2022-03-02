const std = @import("std");
const c = @cImport({
    @cDefine("LIBXML_TREE_ENABLED", {});
    @cDefine("LIBXML_SCHEMAS_ENABLED", {});
    @cDefine("LIBXML_READER_ENABLED", {});
    @cInclude("libxml/xmlreader.h");
});

const Allocator = std.mem.Allocator;

pub const Node = c.xmlNode;
pub const Doc = c.xmlDoc;
pub const readFile = c.xmlReadFile;
pub const readIo = c.xmlReadIO;
pub const cleanupParser = c.xmlCleanupParser;
pub const freeDoc = c.xmlFreeDoc;
pub const docGetRootElement = c.xmlDocGetRootElement;

pub fn getAttribute(node: ?*Node, key: [:0]const u8) ?[]const u8 {
    if (c.xmlHasProp(node, key.ptr)) |prop| {
        if (@ptrCast(*c.xmlAttr, prop).children) |value_node| {
            if (@ptrCast(*Node, value_node).content) |content| {
                return std.mem.span(content);
            }
        }
    }

    return null;
}

pub fn findNode(node: ?*Node, key: []const u8) ?*Node {
    return if (node) |n| blk: {
        var it: ?*Node = n;
        break :blk while (it != null) : (it = it.?.next) {
            if (it.?.type != 1)
                continue;

            const name = std.mem.span(it.?.name orelse continue);
            if (std.mem.eql(u8, key, name))
                break it;
        } else null;
    } else null;
}

pub fn findValueForKey(node: ?*Node, key: []const u8) ?[]const u8 {
    return if (findNode(node, key)) |n|
        if (@ptrCast(?*Node, n.children)) |child|
            if (@ptrCast(?[*:0]const u8, child.content)) |content|
                std.mem.span(content)
            else
                null
        else
            null
    else
        null;
}

pub fn parseDescription(allocator: Allocator, node: ?*Node, key: []const u8) !?[]const u8 {
    return if (findValueForKey(node, key)) |value| blk: {
        var str = std.ArrayList(u8).init(allocator);
        errdefer str.deinit();

        var it = std.mem.tokenize(u8, value, " \n\t\r");
        try str.appendSlice(it.next() orelse return null);
        while (it.next()) |token| {
            try str.append(' ');
            try str.appendSlice(token);
        }

        break :blk str.toOwnedSlice();
    } else null;
}

pub fn parseIntForKey(comptime T: type, allocator: std.mem.Allocator, node: ?*Node, key: []const u8) !?T {
    return if (findValueForKey(node, key)) |str| blk: {
        const lower = try std.ascii.allocLowerString(allocator, str);
        defer allocator.free(lower);

        break :blk if (std.mem.startsWith(u8, lower, "#")) weird_base2: {
            for (lower[1..]) |*character| {
                if (character.* == 'x') {
                    character.* = '0';
                }
            }

            break :weird_base2 try std.fmt.parseInt(T, lower[1..], 2);
        } else try std.fmt.parseInt(T, lower, 0);
    } else null;
}

pub fn parseBoolean(allocator: Allocator, node: ?*Node, key: []const u8) !?bool {
    return if (findValueForKey(node, key)) |str| blk: {
        const lower = try std.ascii.allocLowerString(allocator, str);
        defer allocator.free(lower);

        break :blk if (std.mem.eql(u8, "0", lower))
            false
        else if (std.mem.eql(u8, "1", lower))
            true
        else if (std.mem.eql(u8, "false", lower))
            false
        else if (std.mem.eql(u8, "true", lower))
            true
        else
            return error.InvalidBoolean;
    } else null;
}
