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
                    const identifier_tok = find_first_token_tag(ast, .identifier, main_tok_idx);
                    const identifier_str = ast.tokenSlice(identifier_tok);
                    const location = ast.tokenLocation(0, identifier_tok);
                    if (try should_transform_typename(allocator, identifier_str)) |typename| {
                        try issues.append(allocator, .{
                            .line = @intCast(location.line + 1),
                            .message = try std.fmt.allocPrint(allocator, "Suggestion: Rename `{s}` to `{s}`, " ++
                                "it _should_ be more in line with our [style guidelines](https://microzig.tech/docs/contributing/). " ++
                                "This automation is not perfect so take it with a grain of salt.", .{ identifier_str, typename }),
                            .file = path,
                        });
                    }
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

const TypenameComponentTag = enum {
    underscore,
    uppercase,
    capitalcase,
    lowercase,
};

const TypenameComponent = union(TypenameComponentTag) {
    underscore,
    uppercase: []const u8,
    capitalcase: []const u8,
    lowercase: []const u8,
};

const TypenameComponents = struct {
    list: std.ArrayList(TypenameComponent) = .{},

    pub fn format(components: *const TypenameComponents, writer: *std.Io.Writer) !void {
        try writer.print("Components:\n", .{});
        for (components.list.items) |entry| switch (entry) {
            .underscore => try writer.print("  _\n", .{}),
            .uppercase => |str| try writer.print("  uppercase: '{s}'\n", .{str}),
            .capitalcase => |str| try writer.print("  capitalcase: '{s}'\n", .{str}),
            .lowercase => |str| try writer.print("  lowercase: '{s}'\n", .{str}),
        };
    }
};

fn typename_components_to_string(gpa: Allocator, components: []const TypenameComponent) ![]const u8 {
    var allocating: std.Io.Writer.Allocating = .init(gpa);
    defer allocating.deinit();

    const writer = &allocating.writer;
    for (components) |component| switch (component) {
        .underscore => try writer.writeByte('_'),
        .uppercase => |uppercase| for (uppercase) |c| try writer.writeByte(std.ascii.toUpper(c)),
        .lowercase => |lowercase| for (lowercase) |c| try writer.writeByte(std.ascii.toLower(c)),
        .capitalcase => |capitalcase| for (capitalcase, 0..) |c, i| {
            if (i == 0) {
                try writer.writeByte(std.ascii.toUpper(c));
            } else {
                try writer.writeByte(std.ascii.toLower(c));
            }
        },
    };

    return allocating.toOwnedSlice();
}

test "to_string.single" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const gpa = arena.allocator();

    const underscore = try typename_components_to_string(gpa, &.{.underscore});
    const uppercase = try typename_components_to_string(gpa, &.{.{ .uppercase = "arst" }});
    const lowercase = try typename_components_to_string(gpa, &.{.{ .lowercase = "ARST" }});
    const capitalcase = try typename_components_to_string(gpa, &.{.{ .capitalcase = "ARST" }});

    try std.testing.expectEqualStrings("_", underscore);
    try std.testing.expectEqualStrings("ARST", uppercase);
    try std.testing.expectEqualStrings("arst", lowercase);
    try std.testing.expectEqualStrings("Arst", capitalcase);
}

test "to_string.mixed" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const gpa = arena.allocator();

    const a = try typename_components_to_string(gpa, &.{
        .{ .uppercase = "gpio" },
        .underscore,
        .{ .capitalcase = "mapper" },
    });

    const b = try typename_components_to_string(gpa, &.{
        .{ .capitalcase = "spi" },
        .{ .capitalcase = "bus" },
    });

    const c = try typename_components_to_string(gpa, &.{
        .{ .capitalcase = "spi" },
        .underscore,
        .{ .capitalcase = "bus" },
    });

    const d = try typename_components_to_string(gpa, &.{
        .{ .uppercase = "spi" },
        .{ .capitalcase = "bus" },
    });

    try std.testing.expectEqualStrings("GPIO_Mapper", a);
    try std.testing.expectEqualStrings("SpiBus", b);
    try std.testing.expectEqualStrings("Spi_Bus", c);
    try std.testing.expectEqualStrings("SPIBus", d);
}

const ParsingState = enum {
    start,
    end,
    capitalcase,
    lowercase,
    uppercase,
};

fn has_lower(str: []const u8) bool {
    for (str) |c| {
        if (std.ascii.isLower(c))
            return true;
    }

    return false;
}

fn from_string(gpa: Allocator, typename: []const u8) !TypenameComponents {
    var components: std.ArrayList(TypenameComponent) = .{};
    errdefer components.deinit(gpa);

    var buf: []const u8 = &.{};
    var i: usize = 0;
    state: switch (ParsingState.start) {
        .start => {
            if (i >= typename.len)
                continue :state .end;

            const c = typename[i];
            buf = typename[i .. i + 1];
            i += 1;

            continue :state switch (c) {
                '_' => blk: {
                    try components.append(gpa, .underscore);
                    break :blk .start;
                },
                'A'...'Z' => .capitalcase,
                else => .lowercase,
            };
        },
        .uppercase => {
            if (i >= typename.len) {
                try components.append(gpa, .{ .uppercase = buf });
                continue :state .end;
            }

            const c = typename[i];
            continue :state switch (c) {
                'a'...'z' => blk: {
                    buf.len -= 1;
                    i -= 1;
                    try components.append(gpa, .{ .uppercase = buf });
                    break :blk .start;
                },
                '_' => blk: {
                    try components.append(gpa, .{ .uppercase = buf });
                    break :blk .start;
                },
                else => blk: {
                    buf.len += 1;
                    i += 1;

                    break :blk .uppercase;
                },
            };
        },
        .capitalcase => {
            if (i >= typename.len) {
                try components.append(gpa, if (has_lower(buf))
                    .{ .capitalcase = buf }
                else
                    .{ .uppercase = buf });
                continue :state .end;
            }

            const c = typename[i];
            continue :state switch (c) {
                'A'...'Z' => if (!has_lower(buf))
                    .uppercase
                else blk: {
                    try components.append(gpa, if (has_lower(buf))
                        .{ .capitalcase = buf }
                    else
                        .{ .uppercase = buf });
                    break :blk .start;
                },

                '_' => blk: {
                    try components.append(gpa, if (has_lower(buf))
                        .{ .capitalcase = buf }
                    else
                        .{ .uppercase = buf });
                    break :blk .start;
                },
                else => blk: {
                    buf.len += 1;
                    i += 1;

                    break :blk .capitalcase;
                },
            };
        },
        .lowercase => {
            if (i >= typename.len) {
                try components.append(gpa, .{ .lowercase = buf });
                continue :state .end;
            }

            const c = typename[i];
            continue :state switch (c) {
                '_', 'A'...'Z' => blk: {
                    try components.append(gpa, .{ .lowercase = buf });
                    break :blk .start;
                },
                else => blk: {
                    buf.len += 1;
                    i += 1;

                    break :blk .lowercase;
                },
            };
        },
        .end => {},
    }

    return .{ .list = components };
}

fn should_transform_typename(gpa: Allocator, typename: []const u8) !?[]const u8 {
    if (!is_capital_case(typename))
        return null;

    if (std.mem.eql(u8, typename, "VTable"))
        return null;

    var components = try from_string(gpa, typename);
    defer components.list.deinit(gpa);

    // special cases
    if (components.list.items.len > 1) {
        switch (components.list.items[components.list.items.len - 1]) {
            // ID is fine
            .uppercase => |str| if (std.mem.eql(u8, str, "ID")) return null,
            .lowercase => |str| if (std.mem.eql(u8, str, "t") and components.list.items[components.list.items.len - 2] == .underscore) {
                components.list.orderedRemoveMany(&.{
                    components.list.items.len - 2,
                    components.list.items.len - 1,
                });
            },
            else => {},
        }
    }

    var new_components: std.ArrayList(TypenameComponent) = .{};
    defer new_components.deinit(gpa);

    for (components.list.items) |component| switch (component) {
        .underscore, .uppercase => try new_components.append(gpa, component),
        .lowercase => |str| try new_components.append(gpa, .{
            .capitalcase = str,
        }),
        .capitalcase => |str| if (is_known_abbrev(str)) {
            try new_components.append(gpa, .{ .uppercase = str });
        } else {
            try new_components.append(gpa, component);
        },
    };

    var i: usize = 1;
    while (i < new_components.items.len) : (i += 1) {
        // Upper case components should have underscores between them and others
        if ((new_components.items[i] == .uppercase and new_components.items[i - 1] != .underscore) or
            (new_components.items[i] != .underscore and new_components.items[i - 1] == .uppercase))
        {
            try new_components.insert(gpa, i, .underscore);
            i += 1;
        }

        if (i > 1 and new_components.items[i] != .uppercase and
            new_components.items[i - 1] == .underscore and new_components.items[i - 2] != .uppercase)
        {
            _ = new_components.orderedRemove(i - 1);
            i -= 1;
        }
    }

    const new_typename = try typename_components_to_string(gpa, new_components.items);
    return if (std.mem.eql(u8, typename, new_typename)) blk: {
        gpa.free(new_typename);
        break :blk null;
    } else new_typename;
}

fn is_known_abbrev(str: []const u8) bool {
    outer: for (known_abbrevs) |known_abbrev| {
        if (str.len != known_abbrev.len)
            continue;

        for (str, known_abbrev) |c, a| {
            if (std.ascii.toUpper(c) != std.ascii.toUpper(a))
                continue :outer;
        }

        return true;
    }

    return false;
}

const known_abbrevs: []const []const u8 = &.{
    "GPIO",
    "SPI",
    "I2C",
    "UART",
    "USART",
    "USARTE",
    "RAM",
    "PSRAM",
    "DRAM",
    "CYW43",
    "DB",
    "ELF",
    "IO",
    "SQL",
    "RCC",
    "DMA",
    "WP",
    "SWD",
    "CDC",
    "HID",
    "SSID",
    "SAE",
    "BSS",
    "SDP",
    "CLM",
    "IRQ",
    "LCD",
    "ADC",
    "EP",
    "USB",
    "IR",
    "PIO",
    "FS",
    "ISR",
    "CLI",
    "I2S",
    "CPU",
    "HAL",
};

test "from_string" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const gpa = arena.allocator();

    const a = try from_string(gpa, "GpioMapper");
    try std.testing.expectEqual(2, a.list.items.len);

    try std.testing.expect(a.list.items[0] == .capitalcase);
    try std.testing.expectEqualStrings("Gpio", a.list.items[0].capitalcase);
    try std.testing.expect(a.list.items[1] == .capitalcase);
    try std.testing.expectEqualStrings("Mapper", a.list.items[1].capitalcase);

    const b = try from_string(gpa, "GPIOMapper");
    try std.testing.expectEqual(2, b.list.items.len);

    try std.testing.expect(b.list.items[0] == .uppercase);
    try std.testing.expectEqualStrings("GPIO", b.list.items[0].uppercase);
    try std.testing.expect(b.list.items[1] == .capitalcase);
    try std.testing.expectEqualStrings("Mapper", b.list.items[1].capitalcase);

    const c = try from_string(gpa, "Device_Index");
    try std.testing.expectEqual(3, c.list.items.len);

    try std.testing.expect(c.list.items[0] == .capitalcase);
    try std.testing.expectEqualStrings("Device", c.list.items[0].capitalcase);
    try std.testing.expect(c.list.items[1] == .underscore);
    try std.testing.expect(c.list.items[2] == .capitalcase);
    try std.testing.expectEqualStrings("Index", c.list.items[2].capitalcase);
}

fn expect_transform(expected: ?[]const u8, input: []const u8) !void {
    const typename = try should_transform_typename(std.testing.allocator, input);
    defer if (typename) |str| std.testing.allocator.free(str);

    if (expected) |expect| {
        try std.testing.expect(typename != null);
        try std.testing.expectEqualStrings(expect, typename.?);
    } else {
        try std.testing.expectEqual(null, typename);
    }
}

test "should_transform" {
    try expect_transform(null, "arst");
    try expect_transform(null, "Arst");
    try expect_transform("GPIO_Mapper", "GpioMapper");
    try expect_transform("GPIO_Mapper", "GPIOMapper");
    try expect_transform("DeviceIndex", "Device_Index");
    try expect_transform("I2C_Bus", "I2cBus");
    try expect_transform(null, "I2C_Device");
    try expect_transform(null, "VTable");
    try expect_transform(null, "DeviceID");
    try expect_transform("Channel", "Channel_t");
    try expect_transform(null, "DMA_V1_Type");
}

// I'm defining capital case as something that starts with an upper case letter, and has lower case somewhere in it.
fn is_capital_case(str: []const u8) bool {
    if (str.len == 0)
        return false;

    if (!std.ascii.isAlphabetic(str[0]))
        return false;

    if (std.ascii.isLower(str[0]))
        return false;

    for (str[1..]) |c| {
        if (std.ascii.isLower(c))
            return true;
    }

    return false;
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
};

pub fn check_todos(
    allocator: Allocator,
    path: []const u8,
    source: []const u8,
    issues: *std.ArrayListUnmanaged(Issue),
) !void {
    var line_num: u32 = 1;
    var it = std.mem.splitScalar(u8, source, '\n');
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
