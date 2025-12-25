const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

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
        try check_todos(allocator, ast, path, &issues);

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

const Token = std.zig.Token;
const TokenIndex = std.zig.Ast.TokenIndex;

/// Checks for TODO and FIXME comments without issue links.
/// Appends issues to the provided ArrayList.
pub fn check_todos(
    allocator: Allocator,
    ast: std.zig.Ast,
    path: []const u8,
    issues: *std.ArrayListUnmanaged(Issue),
) !void {
    // Parse source line by line to find TODO/FIXME comments
    var line_num: u32 = 1;
    var lines = std.mem.splitScalar(u8, ast.source, '\n');

    while (lines.next()) |line| : (line_num += 1) {
        // Check if line contains a comment
        const comment_start = std.mem.indexOf(u8, line, "//");
        if (comment_start == null) continue;

        const comment = line[comment_start.?..];

        // Check if comment contains TODO or FIXME
        const has_todo = std.mem.indexOf(u8, comment, "TODO") != null;
        const has_fixme = std.mem.indexOf(u8, comment, "FIXME") != null;

        if (has_todo or has_fixme) {
            // Check if there's a link on the same line
            const has_link = containsLink(comment);

            if (!has_link) {
                const keyword = if (has_todo) "TODO" else "FIXME";
                const message = try std.fmt.allocPrint(
                    allocator,
                    "{s} comment must include a link to an issue on the same line",
                    .{keyword},
                );

                try issues.append(allocator, .{
                    .line = line_num,
                    .message = message,
                    .file = path,
                });
            }
        }
    }
}

/// Checks if a string contains a link (URL).
fn containsLink(text: []const u8) bool {
    return std.mem.indexOf(u8, text, "http://") != null or
        std.mem.indexOf(u8, text, "https://") != null;
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

// Unit tests
test "check_todos - TODO without link" {
    const allocator = std.testing.allocator;

    const source =
        \\// TODO: implement this
        \\fn foo() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer {
        for (issues.items) |issue| {
            allocator.free(issue.message);
        }
        issues.deinit(allocator);
    }

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 1), issues.items.len);
    try std.testing.expectEqualStrings("TODO comment must include a link to an issue on the same line", issues.items[0].message);
}

test "check_todos - TODO with link" {
    const allocator = std.testing.allocator;

    const source =
        \\// TODO: implement this https://github.com/user/repo/issues/123
        \\fn foo() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer issues.deinit(allocator);

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 0), issues.items.len);
}

test "check_todos - FIXME without link" {
    const allocator = std.testing.allocator;

    const source =
        \\// FIXME: broken behavior
        \\fn bar() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer {
        for (issues.items) |issue| {
            allocator.free(issue.message);
        }
        issues.deinit(allocator);
    }

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 1), issues.items.len);
    try std.testing.expectEqualStrings("FIXME comment must include a link to an issue on the same line", issues.items[0].message);
}

test "check_todos - FIXME with http link" {
    const allocator = std.testing.allocator;

    const source =
        \\// FIXME: broken behavior http://example.com/issue/1
        \\fn bar() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer issues.deinit(allocator);

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 0), issues.items.len);
}

test "check_todos - multiple TODOs" {
    const allocator = std.testing.allocator;

    const source =
        \\// TODO: first issue https://github.com/user/repo/issues/1
        \\fn foo() void {}
        \\
        \\// TODO: second issue without link
        \\fn bar() void {}
        \\
        \\// FIXME: third issue https://example.com/issues/3
        \\fn baz() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer {
        for (issues.items) |issue| {
            allocator.free(issue.message);
        }
        issues.deinit(allocator);
    }

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 1), issues.items.len);
    try std.testing.expectEqualStrings("TODO comment must include a link to an issue on the same line", issues.items[0].message);
}

test "check_todos - no TODO or FIXME" {
    const allocator = std.testing.allocator;

    const source =
        \\// Regular comment
        \\fn foo() void {}
        \\
        \\/// Doc comment
        \\fn bar() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer issues.deinit(allocator);

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 0), issues.items.len);
}

test "check_todos - doc comment TODO without link" {
    const allocator = std.testing.allocator;

    const source =
        \\/// TODO: add documentation
        \\fn foo() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer {
        for (issues.items) |issue| {
            allocator.free(issue.message);
        }
        issues.deinit(allocator);
    }

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 1), issues.items.len);
}

test "check_todos - doc comment TODO with link" {
    const allocator = std.testing.allocator;

    const source =
        \\/// TODO: add documentation https://github.com/user/repo/issues/1
        \\fn foo() void {}
    ;

    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    var issues: std.ArrayListUnmanaged(Issue) = .{};
    defer issues.deinit(allocator);

    try check_todos(allocator, ast, "test.zig", &issues);

    try std.testing.expectEqual(@as(usize, 0), issues.items.len);
}

test "containsLink - various URL formats" {
    try std.testing.expect(containsLink("http://example.com"));
    try std.testing.expect(containsLink("https://example.com"));
    try std.testing.expect(containsLink("See https://github.com/user/repo/issues/1"));
    try std.testing.expect(containsLink("http://localhost:8080/issue"));
    try std.testing.expect(!containsLink("github.com/user/repo"));
    try std.testing.expect(!containsLink("no link here"));
    try std.testing.expect(!containsLink(""));
}
