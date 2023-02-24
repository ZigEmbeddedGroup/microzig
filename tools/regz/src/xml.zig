const std = @import("std");
pub const c = @cImport({
    @cDefine("LIBXML_TREE_ENABLED", {});
    @cDefine("LIBXML_SCHEMAS_ENABLED", {});
    @cDefine("LIBXML_READER_ENABLED", {});
    @cInclude("libxml/xmlreader.h");
});

const Allocator = std.mem.Allocator;

pub const Attr = c.xmlAttr;
pub const readIo = c.xmlReadIO;
pub const cleanupParser = c.xmlCleanupParser;

pub const Node = struct {
    impl: *c.xmlNode,

    pub const Iterator = struct {
        node: ?Node,
        filter: []const u8,

        pub fn next(it: *Iterator) ?Node {
            // TODO: what if current node doesn't fit the bill?
            return while (it.node != null) : (it.node = if (it.node.?.impl.next) |impl| Node{ .impl = impl } else null) {
                if (it.node.?.impl.type != 1)
                    continue;

                if (it.node.?.impl.name) |name|
                    if (std.mem.eql(u8, it.filter, std.mem.span(name))) {
                        const ret = it.node;
                        it.node = if (it.node.?.impl.next) |impl| Node{ .impl = impl } else null;
                        break ret;
                    };
            } else return null;
        }
    };

    pub const AttrIterator = struct {
        attr: ?*Attr,

        pub const Entry = struct {
            key: []const u8,
            value: []const u8,
        };

        pub fn next(it: *AttrIterator) ?Entry {
            return if (it.attr) |attr| ret: {
                if (attr.name) |name|
                    if (@ptrCast(*c.xmlNode, attr.children).content) |content| {
                        defer it.attr = attr.next;
                        break :ret Entry{
                            .key = std.mem.span(name),
                            .value = std.mem.span(content),
                        };
                    };
            } else null;
        }
    };

    pub fn get_attribute(node: Node, key: [:0]const u8) ?[]const u8 {
        if (c.xmlHasProp(node.impl, key.ptr)) |prop| {
            if (@ptrCast(*c.xmlAttr, prop).children) |value_node| {
                if (@ptrCast(*c.xmlNode, value_node).content) |content| {
                    return std.mem.span(content);
                }
            }
        }

        return null;
    }

    pub fn find_child(node: Node, key: []const u8) ?Node {
        var it = @ptrCast(?*c.xmlNode, node.impl.children);
        return while (it != null) : (it = it.?.next) {
            if (it.?.type != 1)
                continue;

            const name = std.mem.span(it.?.name orelse continue);
            if (std.mem.eql(u8, key, name))
                break Node{ .impl = it.? };
        } else null;
    }

    // `skip` will only delve into a specific path of elements
    // `name` will iterate the child elements with that name
    pub fn iterate(node: Node, skip: []const []const u8, filter: []const u8) Iterator {
        var current: Node = node;
        for (skip) |elem|
            current = current.find_child(elem) orelse return Iterator{
                .node = null,
                .filter = filter,
            };

        return Iterator{
            .node = current.find_child(filter),
            .filter = filter,
        };
    }

    pub fn iterate_attrs(node: Node) AttrIterator {
        return AttrIterator{
            .attr = node.impl.properties,
        };
    }

    /// up to you to copy
    pub fn get_value(node: Node, key: []const u8) ?[:0]const u8 {
        return if (node.find_child(key)) |child|
            if (child.impl.children) |value_node|
                if (@ptrCast(*c.xmlNode, value_node).content) |content|
                    std.mem.span(content)
                else
                    null
            else
                null
        else
            null;
    }
};

pub const Doc = struct {
    impl: *c.xmlDoc,

    pub fn from_file(path: [:0]const u8) !Doc {
        return Doc{
            .impl = c.xmlReadFile(
                path.ptr,
                null,
                0,
            ) orelse return error.ReadXmlFile,
        };
    }

    pub fn from_memory(text: []const u8) !Doc {
        return Doc{
            .impl = c.xmlReadMemory(
                text.ptr,
                @intCast(c_int, text.len),
                null,
                null,
                0,
            ) orelse return error.XmlReadMemory,
        };
    }

    pub fn from_io(read_fn: c.xmlInputReadCallback, ctx: ?*anyopaque) !Doc {
        return Doc{
            .impl = c.xmlReadIO(
                read_fn,
                null,
                ctx,
                null,
                null,
                0,
            ) orelse return error.ReadXmlFd,
        };
    }

    pub fn deinit(doc: *Doc) void {
        c.xmlFreeDoc(doc.impl);
    }

    pub fn get_root_element(doc: Doc) !Node {
        return Node{
            .impl = c.xmlDocGetRootElement(doc.impl) orelse return error.NoRoot,
        };
    }
};
