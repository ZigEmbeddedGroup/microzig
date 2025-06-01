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

// Starts with capital, but there are _some_ lowercase
fn is_type_case(str: []const u8) bool {
    if (str.len == 0)
        return false;

    if (!std.ascii.isUpper(str[0]))
        return false;

    for (str[1..]) |c| {
        if (std.ascii.isLower(c)) {
            return true;
        }
    }

    return false;
}

pub fn main() !void {
    const source = @embedFile(@src().file);

    var debug_allocator = std.heap.DebugAllocator(.{}){};
    defer _ = debug_allocator.deinit();

    const gpa = debug_allocator.allocator();
    var ast = try std.zig.Ast.parse(gpa, source, .zig);
    defer ast.deinit(gpa);

    for (ast.nodes.items(.tag), ast.nodes.items(.main_token), 0..) |node_tag, main_tok_idx, node_idx| {
        _ = node_idx;
        switch (node_tag) {
            .fn_proto_simple,
            .fn_proto_multi,
            .fn_proto_one,
            .fn_proto,
            => {
                const identifier_tok = find_first_token_tag(ast, .identifier, main_tok_idx);
                const identifier_str = ast.tokenSlice(identifier_tok);
                if (is_camel_case(identifier_str) and !is_snake_case(identifier_str)) {
                    const location = ast.tokenLocation(0, identifier_tok);
                    // TODO: break up camel case
                    std.log.info("FAILED SNAKE CASE: {s}, location: {}", .{ identifier_str, location });
                }
            },

            .global_var_decl,
            .local_var_decl,
            .aligned_var_decl,
            .simple_var_decl,
            => {
                //const str = ast.getNodeSource(@intCast(node_idx));
                //std.log.info("  node_str: {s}", .{str});

                // Find first identifier token
                const identifier_tok = find_first_token_tag(ast, .identifier, main_tok_idx);
                //std.log.info("  identifier_token_idx: {}", .{identifier_tok});

                const identifier_str = ast.tokenSlice(identifier_tok);
                std.log.info("  identifier_str: '{s}'", .{identifier_str});

                if (!is_type_case(identifier_str))
                    continue;
            },
            else => {},
        }
    }
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

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("linter_lib");
