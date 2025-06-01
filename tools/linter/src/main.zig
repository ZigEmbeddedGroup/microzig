const Issue = struct {
    file: []const u8,
    line: u32,
    message: []const u8,
};

pub fn main() !void {
    var debug_allocator = std.heap.DebugAllocator(.{}){};
    defer _ = debug_allocator.deinit();

    var arena = std.heap.ArenaAllocator.init(debug_allocator.allocator());
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var issues: std.ArrayList(Issue) = .init(allocator);
    defer issues.deinit();

    for (args[1..]) |path| {
        const source = try std.fs.cwd().readFileAllocOptions(allocator, path, 1024 * 1024, null, 1, 0);
        defer allocator.free(source);

        var ast = try std.zig.Ast.parse(allocator, source, .zig);
        defer ast.deinit(allocator);
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
                        const message = try std.fmt.allocPrint(allocator, "For MicroZig we use snake case for function names. Please change to `{s}`. This is not required", .{
                            snake_case,
                        });

                        try issues.append(.{
                            .line = @intCast(location.line + 1),
                            .message = message,
                            .file = path,
                        });
                        // TODO: break up camel case
                        std.log.info("FAILED SNAKE CASE: {s}, location: {}", .{ identifier_str, location });
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

    const stdout = std.io.getStdOut().writer();
    try std.json.stringify(issues.items, .{}, stdout);
}

const Token = std.zig.Token;
const TokenIndex = std.zig.Ast.TokenIndex;

fn find_first_token_tag(ast: std.zig.Ast, tag: Token.Tag, start_idx: TokenIndex) TokenIndex {
    return for (ast.tokens.items(.tag)[start_idx..], start_idx..) |token_tag, token_idx| {
        if (token_tag == tag)
            break @intCast(token_idx);
    } else unreachable;
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "use other module" {
    try std.testing.expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}

const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("linter_lib");

const Type = struct {
    pub fn whatIsThis() void {}
};

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

// TODO: implement
fn camel_to_snake(arena: Allocator, str: []const u8) ![]const u8 {
    _ = arena;
    return str;
}
