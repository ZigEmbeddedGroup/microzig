const std = @import("std");
const ptk = @import("parser-toolkit");

pub const Document = struct {
    arena: std.heap.ArenaAllocator,
    root: Node,

    pub fn deinit(doc: *Document) void {
        doc.arena.deinit();
        doc.* = undefined;
    }
};

pub const Node = union(enum) {
    null,
    bool: bool,

    int: i128,
    float: f128,
    string: []const u8,
    char: u21,
    @"enum": []const u8,

    array: []Node,
    object: std.StringArrayHashMapUnmanaged(Node),
    empty, // .{}
};

pub fn parseString(allocator: std.mem.Allocator, document: []const u8) error{ OutOfMemory, SyntaxError }!Document {
    var doc = Document{
        .arena = std.heap.ArenaAllocator.init(allocator),
        .root = .null,
    };
    errdefer doc.arena.deinit();

    doc.root = parseInternal(doc.arena.allocator(), null, document) catch |err| switch (err) {
        error.UnexpectedCharacter => return error.SyntaxError,
        error.InvalidCharacter => return error.SyntaxError,
        error.Overflow => return error.SyntaxError,
        error.EndOfStream => return error.SyntaxError,
        error.UnexpectedToken => return error.SyntaxError,
        error.DuplicateKey => return error.SyntaxError,

        else => |e| return e,
    };

    return doc;
}

fn parseInternal(arena: std.mem.Allocator, file_name: ?[]const u8, document: []const u8) !Node {
    var tokenizer = Tokenizer.init(document, file_name);
    var parser = Parser{
        .core = ParserCore.init(&tokenizer),
    };

    errdefer |e| std.debug.print("{}: {}\n", .{ tokenizer.current_location, e });

    const node = try parseNode(arena, &parser);

    const end = try parser.core.nextToken();
    if (end != null)
        return error.SyntaxError;

    return node;
}

fn parseNode(arena: std.mem.Allocator, parser: *Parser) error{ OutOfMemory, SyntaxError, UnexpectedCharacter, DuplicateKey, InvalidCharacter, Overflow, EndOfStream, UnexpectedToken }!Node {
    var string_buffer = std.ArrayList(u8).init(arena);
    defer string_buffer.deinit();

    if (parser.acceptNull()) {
        return .null;
    } else |_| {}

    if (parser.acceptInt()) |int_value| {
        return .{ .int = int_value };
    } else |_| {}

    if (parser.acceptBool()) |value| {
        return .{ .bool = value };
    } else |_| {}

    if (parser.acceptChar()) |value| {
        return .{ .char = value };
    } else |_| {}

    if (parser.acceptString(string_buffer.writer())) {
        return .{ .string = try string_buffer.toOwnedSlice() };
    } else |_| {}

    string_buffer.shrinkRetainingCapacity(0);

    if (parser.acceptEnumLiteral(string_buffer.writer())) {
        return .{ .@"enum" = try string_buffer.toOwnedSlice() };
    } else |_| {}

    string_buffer.shrinkRetainingCapacity(0);

    // we tried all primitive types, the only thing left available is a dot-brace:

    const s = parser.save();
    errdefer parser.restore(s);

    try parser.accept(.@".");
    try parser.accept(.@"{");

    // now we're in a dotbrace context, we can now accept three things:

    // 1: the empty object .{}
    if (parser.accept(.@"}")) {
        return .empty;
    } else |_| {}

    // 2: A structure .{ .key = value,  .key = value },
    if (parseObject(arena, parser)) |obj| {
        return .{ .object = obj };
    } else |_| {}

    // 3: An array .{ value, value, value },
    if (parseArray(arena, parser)) |arr| {
        return .{ .array = arr };
    } else |e| {
        std.log.err("{}", .{e});
    }

    return error.SyntaxError;
}

fn parseArray(arena: std.mem.Allocator, parser: *Parser) ![]Node {
    const s = parser.save();
    errdefer parser.restore(s);

    var list = std.ArrayList(Node).init(arena);
    defer list.deinit();

    while (true) {
        if (parser.accept(.@"}")) {
            break;
        } else |_| {}

        const value = try parseNode(arena, parser);

        try list.append(value);

        if (parser.accept(.@",")) {
            continue;
        } else |_| {}

        try parser.accept(.@"}");
        break;
    }

    return try list.toOwnedSlice();
}

fn parseObject(arena: std.mem.Allocator, parser: *Parser) !std.StringArrayHashMapUnmanaged(Node) {
    const s = parser.save();
    errdefer parser.restore(s);

    var object = std.StringArrayHashMapUnmanaged(Node){};
    errdefer object.deinit(arena);

    var identifier_buffer = std.ArrayList(u8).init(arena);
    defer identifier_buffer.deinit();

    while (true) {
        if (parser.accept(.@"}")) {
            break;
        } else |_| {}

        try parser.accept(.@".");
        try parser.acceptIdentifier(identifier_buffer.writer());

        const key = try identifier_buffer.toOwnedSlice();

        const gop = try object.getOrPut(arena, key);
        if (gop.found_existing)
            return error.DuplicateKey;

        try parser.accept(.@"=");

        gop.value_ptr.* = try parseNode(arena, parser);

        if (parser.accept(.@",")) {
            continue;
        } else |_| {}

        try parser.accept(.@"}");
        break;
    }

    return object;
}

const Parser = struct {
    const State = ParserCore.State;
    const rules = ptk.RuleSet(TokenType);

    core: ParserCore,

    fn save(p: *Parser) State {
        return p.core.saveState();
    }
    fn restore(p: *Parser, state: State) void {
        p.core.restoreState(state);
    }

    pub fn accept(p: *Parser, comptime t: TokenType) !void {
        const s = p.save();
        errdefer p.restore(s);

        _ = try p.core.accept(rules.is(t));
    }

    pub fn acceptNull(p: *Parser) !void {
        const s = p.save();
        errdefer p.restore(s);

        _ = try p.core.accept(rules.is(.null));
    }

    pub fn acceptInt(p: *Parser) !i128 {
        const s = p.save();
        errdefer p.restore(s);

        const negative = if (p.core.accept(rules.is(.@"-"))) |_|
            true
        else |_|
            false;

        const tok = try p.core.accept(rules.is(.integer));
        const number = try std.fmt.parseInt(i128, tok.text, 0);

        return if (negative) -number else number;
    }

    pub fn acceptBool(p: *Parser) !bool {
        const s = p.save();
        errdefer p.restore(s);

        const tok = try p.core.accept(rules.oneOf(.{ .false, .true }));
        return (tok.type == .true);
    }

    pub fn acceptChar(p: *Parser) !u21 {
        const s = p.save();
        errdefer p.restore(s);

        const tok = try p.core.accept(rules.is(.character_literal));
        std.debug.assert(tok.text.len >= 2);
        std.debug.assert(tok.text[0] == '\'');
        std.debug.assert(tok.text[tok.text.len - 1] == '\'');

        const Decoder = struct {
            storage: ?u21 = null,
            fn put(self: *@This(), char: u21, source: EscapeSource) !void {
                _ = source;
                // std.debug.print("'{}'\n", .{char});
                if (self.storage != null)
                    return error.StringLength;
                self.storage = char;
            }
        };

        var deco = Decoder{};
        // std.debug.print("=> \"{s}\"\n", .{tok.text});
        try parseEscapes(tok.text[1 .. tok.text.len - 1], &deco);

        return deco.storage orelse error.StringLength;
    }

    pub fn acceptString(p: *Parser, writer: anytype) !void {
        const s = p.save();
        errdefer p.restore(s);

        const tok = try p.core.accept(rules.is(.string_literal));
        std.debug.assert(tok.text.len >= 2);
        std.debug.assert(tok.text[0] == '\"');
        std.debug.assert(tok.text[tok.text.len - 1] == '\"');

        var deco = StringDecoder(@TypeOf(writer)){ .writer = writer };
        try parseEscapes(tok.text[1 .. tok.text.len - 1], &deco);
    }

    pub fn acceptEnumLiteral(p: *Parser, writer: anytype) !void {
        const s = p.save();
        errdefer p.restore(s);

        _ = try p.core.accept(rules.is(.@"."));
        _ = try p.acceptIdentifierInner(writer);
    }

    pub fn acceptIdentifier(p: *Parser, writer: anytype) !void {
        const s = p.save();
        errdefer p.restore(s);

        _ = try p.acceptIdentifierInner(writer);
    }

    fn acceptIdentifierInner(p: *Parser, writer: anytype) !void {
        const tok = try p.core.accept(rules.is(.identifier));

        std.debug.assert(tok.text.len > 0);

        if (tok.text[0] == '@') {
            std.debug.assert(tok.text.len >= 3);
            std.debug.assert(tok.text[1] == '\"');
            std.debug.assert(tok.text[tok.text.len - 1] == '\"');

            var deco = StringDecoder(@TypeOf(writer)){ .writer = writer };
            try parseEscapes(tok.text[2 .. tok.text.len - 1], &deco);
        } else {
            // regular id
            try writer.writeAll(tok.text);
        }
    }

    fn StringDecoder(comptime Writer: type) type {
        return struct {
            writer: Writer,

            fn put(self: *@This(), char: u21, source: EscapeSource) !void {
                if (source == .hex_escape) {
                    try self.writer.writeByte(@intCast(char));
                } else {
                    var buffer: [4]u8 = undefined;
                    const len = try std.unicode.utf8Encode(char, &buffer);
                    try self.writer.writeAll(buffer[0..len]);
                }
            }
        };
    }
};

const EscapeSource = enum { char, escape, hex_escape, unicode_escape };
fn parseEscapes(str: []const u8, receiver: anytype) !void {
    var i: usize = 0;
    while (i < str.len) {
        const c = str[i];
        if (c == '\\') {
            i += 1;
            if (i >= str.len) {
                return error.MissingEscapeSpec;
            }
            const e = str[i];
            i += 1;
            switch (e) {
                'n' => try receiver.put('\n', .escape),
                'r' => try receiver.put('\r', .escape),
                '\\' => try receiver.put('\\', .escape),
                't' => try receiver.put('\t', .escape),
                '\'' => try receiver.put('\'', .escape),
                '\"' => try receiver.put('\"', .escape),

                'x' => {
                    if (i + 2 > str.len)
                        return error.BadHexLiteral;

                    const value = try std.fmt.parseInt(u8, str[i .. i + 2], 16);
                    try receiver.put(value, .hex_escape);

                    i += 2;
                },

                'u' => {
                    if (i >= str.len)
                        return error.BadUnicodeLiteral;
                    if (str[i] != '{')
                        return error.BadUnicodeLiteral;
                    i += 1;

                    const start = i;
                    while (i < str.len) {
                        if (std.mem.indexOfScalar(u8, "0123456789ABCDEFabcdef", str[i]) != null) {
                            i += 1;
                        } else if (str[i] == '}') {
                            const hex = str[start..i];
                            i += 1;

                            try receiver.put(
                                try std.fmt.parseInt(u21, hex, 16),
                                .unicode_escape,
                            );
                            break;
                        }
                    } else return error.BadUnicodeLiteral;
                },
                else => return error.InvalidEscape,
            }
        } else {
            // must be utf-8

            const len = try std.unicode.utf8ByteSequenceLength(c);
            if (i + len > str.len)
                return error.InvalidUtf8;

            const value = try std.unicode.utf8Decode(str[i .. i + len]);

            try receiver.put(value, .char);

            i += len;
        }
    }
}

const TokenType = enum {
    whitespace,
    comment,

    null,
    true,
    false,

    identifier,

    integer,
    float,

    character_literal,

    string_literal,
    multiline_string_literal,

    enum_literal,

    @"{",
    @"}",
    @".",
    @",",
    @"=",
    @"-",
};

fn matchStringLiteral(comptime delimiter: u8) ptk.Matcher {
    return struct {
        fn match(str: []const u8) ?usize {
            if (str.len < 2)
                return null;
            if (str[0] != delimiter)
                return null;

            var i: usize = 1;
            while (i < str.len) {
                if (str[i] == delimiter)
                    return i + 1;

                if (str[i] == '\\')
                    i += 1;

                i += 1;
            }
            return null;
        }
    }.match;
}

// FLOAT
//     <- "0x" hex_int "." hex_int ([pP] [-+]? dec_int)? skip
//      /      dec_int "." dec_int ([eE] [-+]? dec_int)? skip
//      / "0x" hex_int [pP] [-+]? dec_int skip
//      /      dec_int [eE] [-+]? dec_int skip
fn matchFloat(str: []const u8) ?usize {
    _ = str;
    return null;
}

pub fn matchNumberOfBase(comptime base: comptime_int) ptk.Matcher {
    return ptk.matchers.takeAnyOfIgnoreCase("_" ++ "0123456789ABCDEF"[0..base]);
}

const Tokenizer = ptk.Tokenizer(TokenType, &.{
    .{ .type = .null, .match = ptk.matchers.word("null") },
    .{ .type = .true, .match = ptk.matchers.word("true") },
    .{ .type = .false, .match = ptk.matchers.word("false") },

    .{ .type = .integer, .match = ptk.matchers.withPrefix("0b", matchNumberOfBase(2)) },
    .{ .type = .integer, .match = ptk.matchers.withPrefix("0x", matchNumberOfBase(16)) },
    .{ .type = .integer, .match = ptk.matchers.withPrefix("0o", matchNumberOfBase(8)) },
    .{ .type = .integer, .match = matchNumberOfBase(10) },

    .{ .type = .float, .match = matchFloat },

    .{ .type = .character_literal, .match = matchStringLiteral('\'') },
    .{ .type = .string_literal, .match = matchStringLiteral('"') },

    .{ .type = .identifier, .match = ptk.matchers.withPrefix("@", matchStringLiteral('"')) },
    .{ .type = .identifier, .match = ptk.matchers.identifier },

    .{ .type = .@"{", .match = ptk.matchers.literal("{") },
    .{ .type = .@"}", .match = ptk.matchers.literal("}") },
    .{ .type = .@".", .match = ptk.matchers.literal(".") },
    .{ .type = .@",", .match = ptk.matchers.literal(",") },
    .{ .type = .@"=", .match = ptk.matchers.literal("=") },
    .{ .type = .@"-", .match = ptk.matchers.literal("-") },

    .{ .type = .comment, .match = ptk.matchers.withPrefix("//", ptk.matchers.takeNoneOf("\n")) },
    .{ .type = .whitespace, .match = ptk.matchers.whitespace },
});

const ParserCore = ptk.ParserCore(Tokenizer, .{
    .whitespace,
    .comment,
});

test parseString {
    var doc = try parseString(std.testing.allocator,
        \\.{
        \\    .name = "egg-zon",
        \\    .version = "0.1.0",
        \\
        \\    .dependencies = .{
        \\        .@"parser-toolkit" = .{
        \\            .url = "https://github.com/MasterQ32/parser-toolkit/archive/6238b7c6893582fb56f39676a090b1af1226fe1a.tar.gz",
        \\            .hash = "1220cf55c10add71a9cd2591dbe118ffa9a9198e21069e440fae1f6e3eef6f274733",
        \\        },
        \\    },
        \\}
    );
    defer doc.deinit();

    try std.testing.expectEqualStrings("egg-zon", doc.root.object.get("name").?.string);
}

test "parse root null" {
    var doc = try parseString(std.testing.allocator, "null");
    defer doc.deinit();

    try std.testing.expectEqual(@as(Node, .null), doc.root);
}

test "parse root bool true" {
    var doc = try parseString(std.testing.allocator, "true");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .bool = true }, doc.root);
}

test "parse root bool false" {
    var doc = try parseString(std.testing.allocator, "false");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .bool = false }, doc.root);
}

test "parse root positive int single char" {
    var doc = try parseString(std.testing.allocator, " 1 ");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = 1 }, doc.root);
}

test "parse root positive int" {
    var doc = try parseString(std.testing.allocator, "1337");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = 1337 }, doc.root);
}

test "parse root negative int" {
    var doc = try parseString(std.testing.allocator, "-42");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = -42 }, doc.root);
}

test "parse root hex int" {
    var doc = try parseString(std.testing.allocator, "0x40_30_20_10");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = 0x40_30_20_10 }, doc.root);
}

test "parse root negative hex int" {
    var doc = try parseString(std.testing.allocator, "-0x40_30_20_10");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = -0x40_30_20_10 }, doc.root);
}

test "parse root bin int" {
    var doc = try parseString(std.testing.allocator, "0b1100101");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = 0b1100101 }, doc.root);
}

test "parse root negative bin int" {
    var doc = try parseString(std.testing.allocator, "-0b1100101");
    defer doc.deinit();

    try std.testing.expectEqual(Node{ .int = -0b1100101 }, doc.root);
}

// TODO: Implement float support
// // FLOAT
// //     <- "0x" hex_int "." hex_int ([pP] [-+]? dec_int)? skip
// //      /      dec_int "." dec_int ([eE] [-+]? dec_int)? skip
// //      / "0x" hex_int [pP] [-+]? dec_int skip
// //      /      dec_int [eE] [-+]? dec_int skip
// test "parse root float" {
//     var doc = try parseString(std.testing.allocator, "13.37"); // dec_int "." dec_int
//     defer doc.deinit();

//     try std.testing.expectEqual(Node{ .int = -0b1100101 }, doc.root);
// }

const CharTest = struct { u21, []const u8 };

fn runCharTest(seq: []const CharTest) !void {
    for (seq) |pat| {
        var doc = try parseString(std.testing.allocator, pat[1]);
        defer doc.deinit();

        try std.testing.expectEqual(Node{ .char = pat[0] }, doc.root);
    }
}

test "parse root basic char literal" {
    try runCharTest(&.{
        .{ 'x', "'x'" },
        .{ 'ö', "'ö'" },
        .{ '🍏', "'🍏'" },
        .{ '💩', "'💩'" },
    });
}

test "parse root escaped char literal" {
    // "\\" [nr\\t'"]
    try runCharTest(&.{
        .{ '\r', "'\\r'" },
        .{ '\n', "'\\n'" },
        .{ '\t', "'\\t'" },
        .{ '\\', "'\\\\'" },
        .{ '\'', "'\\\''" },
        .{ '\"', "'\\\"'" },
    });
}

test "parse root hex char literal" {
    // "\\x" hex hex
    try runCharTest(&.{
        .{ 0x00, "'\\x00'" },
        .{ 0x10, "'\\x10'" },
        .{ 0x20, "'\\x20'" },
        .{ 0x23, "'\\x23'" },
        .{ 0x42, "'\\x42'" },
        .{ 0xFF, "'\\xFF'" },
    });
}

test "parse root unicode char literal" {
    // "\\u{" hex+ "}"
    try runCharTest(&.{
        .{ 'x', "'\\u{78}'" },
        .{ 'ö', "'\\u{f6}'" },
        .{ '🍏', "'\\u{1f34f}'" },
        .{ '💩', "'\\u{1f4a9}'" },
    });
}

const StringTest = struct { []const u8, []const u8 };

fn runStringTest(seq: []const StringTest) !void {
    for (seq) |pat| {
        var doc = parseString(std.testing.allocator, pat[1]) catch |err| {
            std.debug.print("failed pattern({}) => \"{}\"\n", .{
                err,
                std.zig.fmtEscapes(pat[1]),
            });
            return err;
        };
        defer doc.deinit();

        try std.testing.expectEqual(NodeTag.string, @as(NodeTag, doc.root));
        try std.testing.expectEqualStrings(pat[0], doc.root.string);
    }
}

test "parse root string literal" {
    try runStringTest(&.{
        .{ "", "\"\"" },
        .{ "hello", "\"hello\"" },
        .{ "hello, world", "\"hello, world\"" },
    });
}

test "parse root escaped string literal" {
    try runStringTest(&.{
        .{ "noot \r noot", "\"noot \\r noot\"" },
        .{ "noot \n noot", "\"noot \\n noot\"" },
        .{ "noot \t noot", "\"noot \\t noot\"" },
        .{ "noot \\ noot", "\"noot \\\\ noot\"" },
        .{ "noot \' noot", "\"noot \\\' noot\"" },
        .{ "noot \" noot", "\"noot \\\" noot\"" },
    });
}

test "parse root hex string literal" {
    try runStringTest(&.{
        .{ "booze \x00 jam", "\"booze \\x00 jam\"" },
        .{ "booze \x10 jam", "\"booze \\x10 jam\"" },
        .{ "booze \x20 jam", "\"booze \\x20 jam\"" },
        .{ "booze \x23 jam", "\"booze \\x23 jam\"" },
        .{ "booze \x42 jam", "\"booze \\x42 jam\"" },
        .{ "booze \xFF jam", "\"booze \\xFF jam\"" },
    });
}

test "parse root string unicode literal" {
    try runStringTest(&.{
        .{ "hello x jello", "\"hello \\u{78} jello\"" },
        .{ "hello ö jello", "\"hello \\u{f6} jello\"" },
        .{ "hello 🍏 jello", "\"hello \\u{1f34f} jello\"" },
        .{ "hello 💩 jello", "\"hello \\u{1f4a9} jello\"" },
    });
}

const NodeTag = std.meta.Tag(Node);

test "parse root enum literal" {
    var doc = try parseString(std.testing.allocator, ".foo");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.@"enum", @as(NodeTag, doc.root));
    try std.testing.expectEqualStrings("foo", doc.root.@"enum");
}

test "parse root @ enum literal" {
    var doc = try parseString(std.testing.allocator, ".@\"match-maker\"");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.@"enum", @as(NodeTag, doc.root));
    try std.testing.expectEqualStrings("match-maker", doc.root.@"enum");
}

test "parse root dotbrace" {
    var doc = try parseString(std.testing.allocator, ".{}");
    defer doc.deinit();

    try std.testing.expectEqual(@as(Node, .empty), doc.root);
}

test "parse root int array[4]" {
    var doc = try parseString(std.testing.allocator, ".{ 1, 2, 3, 4 }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.array, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 4), doc.root.array.len);

    for (0..4, 1..5) |index, val| {
        try std.testing.expectEqual(Node{ .int = val }, doc.root.array[index]);
    }
}

test "parse root int array[4] trailing comma" {
    var doc = try parseString(std.testing.allocator, ".{ 1, 2, 3, 4, }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.array, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 4), doc.root.array.len);

    for (0..4, 1..5) |index, val| {
        try std.testing.expectEqual(Node{ .int = val }, doc.root.array[index]);
    }
}

test "parse root int array[1]" {
    var doc = try parseString(std.testing.allocator, ".{ 1 }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.array, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 1), doc.root.array.len);

    for (0..1, 1..2) |index, val| {
        try std.testing.expectEqual(Node{ .int = val }, doc.root.array[index]);
    }
}

test "parse root int array[1] trailing comma" {
    var doc = try parseString(std.testing.allocator, ".{ 1, }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.array, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 1), doc.root.array.len);

    for (0..1, 1..2) |index, val| {
        try std.testing.expectEqual(Node{ .int = val }, doc.root.array[index]);
    }
}

test "parse root object[1]" {
    var doc = try parseString(std.testing.allocator, ".{ .x = 10 }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.object, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 1), doc.root.object.count());
}

test "parse root object[1] trailing comma" {
    var doc = try parseString(std.testing.allocator, ".{ .x = 10, }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.object, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 1), doc.root.object.count());
}

test "parse root object[2]" {
    var doc = try parseString(std.testing.allocator, ".{ .x = 10, .y = 20 }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.object, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 2), doc.root.object.count());
}

test "parse root object[2] trailing comma" {
    var doc = try parseString(std.testing.allocator, ".{ .x = 10, .y = 20, }");
    defer doc.deinit();

    try std.testing.expectEqual(NodeTag.object, @as(NodeTag, doc.root));
    try std.testing.expectEqual(@as(usize, 2), doc.root.object.count());
}

test "all test-data files" {
    var dir = try std.fs.cwd().openDir("test-data", .{ .iterate = true });
    defer dir.close();

    var iter = dir.iterate();

    while (try iter.next()) |item| {
        const text = try dir.readFileAlloc(std.testing.allocator, item.name, 1 << 20);
        defer std.testing.allocator.free(text);

        var doc = parseString(std.testing.allocator, text) catch |err| {
            std.log.err("failed to parse {s}: {s}", .{ item.name, @errorName(err) });
            return err;
        };
        defer doc.deinit();
    }
}
