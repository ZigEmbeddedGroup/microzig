const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const Token = std.zig.Token;
const TokenIndex = std.zig.Ast.TokenIndex;

const Issue = struct {
    file: []const u8,
    line: u32,
    message: []const u8,
};

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();

    var arena = std.heap.ArenaAllocator.init(debug_allocator.allocator());
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer issues.deinit(allocator);

    for (args[1..]) |path| {
        const source = std.fs.cwd().readFileAllocOptions(allocator, path, 100 * 1024 * 1024, null, .@"1", 0) catch |err| {
            std.log.err("Failed to read file '{s}': {}", .{ path, err });
            return err;
        };
        defer allocator.free(source);

        var ast = try std.zig.Ast.parse(allocator, source, .zig);
        defer ast.deinit(allocator);

        // Check for TODO/FIXME comments without issue links
        try check_todos(allocator, path, source, &issues);

        for (ast.nodes.items(.tag), ast.nodes.items(.main_token)) |node_tag, main_tok_idx| {
            switch (node_tag) {
                .fn_proto_simple,
                .fn_proto_multi,
                .fn_proto_one,
                .fn_proto,
                => {
                    const identifier_tok = find_first_token_tag(ast, .identifier, main_tok_idx);
                    const identifier_str = ast.tokenSlice(identifier_tok);
                    if (is_camel_case(identifier_str) and !is_snake_case(identifier_str)) {
                        const snake_case = try camel_to_snake(allocator, identifier_str);
                        const location = ast.tokenLocation(0, identifier_tok);
                        const message = try std.fmt.allocPrint(allocator, "Please change to `{s}`, in MicroZig we use snake case for function names.", .{
                            snake_case,
                        });

                        try issues.append(allocator, .{
                            .line = @intCast(location.line + 1),
                            .message = message,
                            .file = path,
                        });
                    }
                },

                .global_var_decl,
                .local_var_decl,
                .aligned_var_decl,
                .simple_var_decl,
                => {
                    // TODO: check types for common abbreviations and ensure they follow coding style.

                },
                else => {},
            }
        }
    }

    const stdout = std.fs.File.stdout();
    var buf: [4096]u8 = undefined;
    var file_writer = stdout.writer(&buf);
    const writer = &file_writer.interface;

    try std.json.Stringify.value(issues.items, .{}, writer);
    try writer.flush();
}

fn find_first_token_tag(ast: std.zig.Ast, tag: Token.Tag, start_idx: TokenIndex) TokenIndex {
    return for (ast.tokens.items(.tag)[start_idx..], start_idx..) |token_tag, token_idx| {
        if (token_tag == tag)
            break @intCast(token_idx);
    } else unreachable;
}

fn is_snake_case(str: []const u8) bool {
    for (str) |c| {
        switch (c) {
            'A'...'Z' => return false,
            else => {},
        }
    }

    return true;
}

fn is_camel_case(str: []const u8) bool {
    if (str.len == 0)
        return false;

    if (!std.ascii.isLower(str[0]))
        return false;

    for (str[1..]) |c| {
        if (c == '_')
            return false;
    }

    return true;
}

fn camel_to_snake(arena: Allocator, str: []const u8) ![]const u8 {
    if (str.len == 0)
        return str;

    var ret = std.ArrayListUnmanaged(u8){};
    errdefer ret.deinit(arena);

    if (std.ascii.isUpper(str[0])) {
        try ret.append(arena, std.ascii.toLower(str[0]));
    } else {
        try ret.append(arena, str[0]);
    }

    for (str[1..]) |c| {
        if (std.ascii.isUpper(c)) {
            // Add underscore before uppercase letters
            try ret.append(arena, '_');
            try ret.append(arena, std.ascii.toLower(c));
        } else {
            try ret.append(arena, c);
        }
    }

    return ret.toOwnedSlice(arena);
}

const uppercase_todo_keywords: []const []const u8 = &.{
    "TODO",
    "HACK",
    "FIXME",
    "XXX",
    "BUG",
    "NOTE",
};

/// Checks for TODO and FIXME comments without issue links.
/// Appends issues to the provided ArrayList.
pub fn check_todos(
    allocator: Allocator,
    path: []const u8,
    source: []const u8,
    issues: *std.ArrayListUnmanaged(Issue),
) !void {
    var line_num: u32 = 1;
    var it = std.mem.tokenizeScalar(u8, source, '\n');
    while (it.next()) |line| : (line_num += 1) {
        const comment_start = std.mem.indexOf(u8, line, "//") orelse continue;
        const comment = line[comment_start..];
        if (contains_todo_keyword(comment) and !contains_link(comment)) {
            try issues.append(allocator, .{
                .file = path,
                .line = line_num,
                .message = "TODO style comments need to have a linked microzig issue on the same line.",
            });
        }
    }
}

/// Checks if a string contains a link (URL).
fn contains_link(text: []const u8) bool {
    return std.mem.indexOf(u8, text, "https://github.com/ZigEmbeddedGroup/microzig/issues") != null;
}

fn contains_todo_keyword(text: []const u8) bool {
    return for (uppercase_todo_keywords) |keyword| {
        if (std.mem.indexOf(u8, text, keyword) != null)
            break true;
    } else false;
}
