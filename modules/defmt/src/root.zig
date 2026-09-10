const std = @import("std");
const assert = std.debug.assert;
const config = @import("config");

const section = struct {
    const name = config.section_name;

    const start = @extern(*anyopaque, .{
        .name = config.section_marker_start,
    });

    const end = @extern(*anyopaque, .{
        .name = config.section_marker_end,
    });
};

fn tokenize(comptime fmt: []const u8) []const Tokenizer.Token {
    var tokenizer: Tokenizer = .{
        .fmt = fmt,
        .pos = 0,
    };

    var tokens: []const Tokenizer.Token = &.{};
    while (tokenizer.next() catch unreachable) |token|
        tokens = tokens ++ [_]Tokenizer.Token{token};

    return tokens;
}

pub const PrintInfo = struct {
    instructions: []const Instruction,

    pub const Instruction = union(enum) {
        text: []const u8,
        placeholder: std.fmt.Placeholder,

        fn validate(comptime Args: type, insns: []const Instruction) !void {
            const args_count = @typeInfo(Args).@"struct".field_names.len;

            // If one of the arguments is not used we throw an error
            var mask: @Vector(bool, args_count) = @splat(false);

            var idx: usize = 0;
            for (insns) |insn| switch (insn) {
                .placeholder => |ph| switch (ph) {
                    .none => {
                        mask[idx] = true;
                        idx += 1;
                    },
                    .number => |n| mask[n] = true,
                    .named => |name| for (@typeInfo(Args).@"struct".field_names, 0..) |field_name, field_idx| {
                        if (std.mem.eql(u8, name, field_name)) {
                            mask[field_idx] = true;
                            break;
                        }
                    },
                },
                .text => {},
            };

            if (!@reduce(.And, mask)) {
                return error.UnusedArguments;
            }
        }
    };

    fn parse_placeholders(comptime tokens: []const Tokenizer.Token) []const Instruction {
        var insns: [tokens.len]Instruction = undefined;

        for (tokens, &insns) |token, *insn|
            insn.* = switch (token) {
                .text => |text| .{ .text = text },
                .placeholder => |str| .{ .placeholder = std.fmt.Placeholder.parse(str) catch unreachable },
            };

        const insns_copy = insns;
        return insns_copy;
    }

    fn generate(comptime fmt: [:0]const u8, comptime Args: type) PrintInfo {
        const tokens = tokenize(fmt);
        const insns = parse_placeholders(tokens);
        Instruction.validate(Args, insns) catch unreachable;
        return .{ .instructions = insns };
    }
};

const Tokenizer = struct {
    fmt: []const u8,
    pos: usize,

    pub const Token = union(enum) {
        text: []const u8,
        placeholder: []const u8,
    };

    pub fn next(t: *Tokenizer) !?Token {
        const State = enum {
            text,
            placeholder,
        };

        var cur = t.pos;

        state: switch (State.text) {
            .text => {
                if (cur >= t.fmt.len) {
                    defer t.pos = t.fmt.len;

                    if (cur - t.pos > 0)
                        return .{ .text = t.fmt[t.pos..] };

                    return null;
                }

                switch (t.fmt[cur]) {
                    '{' => {
                        if (cur + 1 >= t.fmt.len) {
                            return error.MismatchedOpen;
                        } else if (t.fmt[cur + 1] == '{') {
                            cur += 1;
                            defer t.pos = cur + 1;
                            return .{ .text = t.fmt[t.pos..cur] };
                        }

                        if (cur > t.pos) {
                            defer t.pos = cur;
                            return .{ .text = t.fmt[t.pos..cur] };
                        }

                        cur += 1;
                        t.pos = cur;
                        assert(t.fmt[t.pos] != '{');
                        continue :state .placeholder;
                    },
                    '}' => {
                        if (cur + 1 >= t.fmt.len) {
                            return error.MismatchedClose;
                        } else if (t.fmt[cur + 1] == '}') {
                            cur += 1;
                            defer t.pos = cur + 1;
                            return .{ .text = t.fmt[t.pos..cur] };
                        }

                        return error.MismatchedClose;
                    },
                    else => {
                        cur += 1;
                        continue :state .text;
                    },
                }
            },
            .placeholder => {
                if (cur >= t.fmt.len) {
                    return error.MismatchedOpen;
                }

                switch (t.fmt[cur]) {
                    '{' => {
                        assert(cur - t.pos > 1);
                        return error.MismatchedOpen;
                    },
                    '}' => {
                        defer t.pos = cur + 1;
                        return .{ .placeholder = t.fmt[t.pos..cur] };
                    },
                    else => {
                        cur += 1;
                        continue :state .placeholder;
                    },
                }
            },
        }
    }
};

/// Write binary protocol to writer. It's up to you to figure out how to receive
/// it and format it.
pub fn print(w: *std.Io.Writer, comptime fmt: []const u8, args: anytype) std.Io.Writer.Error!void {
    const print_info: PrintInfo = comptime .generate(fmt, @TypeOf(args));
    const id = register(print_info);
    try w.writeLeb128(id);

    inline for (print_info.instructions) |insn| switch (insn) {
        .text => unreachable, // The receiver will know to print.
    };
}

fn register(comptime print_info: PrintInfo) u32 {
    const Entry = struct {
        var byte: u8 = undefined;
    };

    const name = comptime blk: {
        var buf: [config.print_info_size_max]u8 = undefined;
        var writer: std.Io.Writer = .fixed(&buf);
        std.json.Stringify.value(print_info, .{}, &writer) catch unreachable;
        // Not sure if this will copy it right at comptime.
        break :blk writer.buffered();
    };

    @export(&Entry.byte, .{
        .name = name,
        .section = section.name,
    });

    // This has to be done at runtime because we can't make comptime
    // calculations based off where the linker places things.
    return @intCast(@intFromPtr(&Entry.byte) - @intFromPtr(section.start));
}

pub const Printer = struct {
    reader: *std.Io.Reader,
    writer: *std.Io.Writer,
    lookup: std.AutoArrayHashMap(u32, PrintInfo),

    /// Process a single record, flushes the writer.
    pub fn process_record(p: *Printer) !void {
        const id = try p.reader.takeLeb128(u32);
        const print_info = p.lookup.get(id) orelse return error.InvalidID;

        for (print_info.instructions) |insn| switch (insn) {
            .text => |str| try p.writer.writeAll(str),
        };

        try p.writer.flush();
    }
};

const testing = std.testing;

test "tokenize: empty string" {
    const tokens = comptime tokenize("");
    try testing.expectEqual(0, tokens.len);
}

test "tokenize: just text" {
    const tokens = comptime tokenize("asdf");
    try testing.expectEqual(1, tokens.len);

    try testing.expectEqualStrings("asdf", tokens[0].text);
}

test "tokenize: lone empty placeholder" {
    const tokens = comptime tokenize("{}");
    try testing.expectEqual(1, tokens.len);

    try testing.expectEqualStrings("", tokens[0].placeholder);
}

test "tokenize: placeholder with text" {
    const tokens = comptime tokenize("{abc:123}");
    try testing.expectEqual(1, tokens.len);

    try testing.expectEqualStrings("abc:123", tokens[0].placeholder);
}

test "tokenize: text then placeholder" {
    const tokens = comptime tokenize("asdf{abc:123}");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("asdf", tokens[0].text);
    try testing.expectEqualStrings("abc:123", tokens[1].placeholder);
}

test "tokenize: placeholder then text" {
    const tokens = comptime tokenize("{abc:123}asdf");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("abc:123", tokens[0].placeholder);
    try testing.expectEqualStrings("asdf", tokens[1].text);
}

test "tokenize: text, placeholder, text" {
    const tokens = comptime tokenize("arst{abc:123}asdf");
    try testing.expectEqual(3, tokens.len);

    try testing.expectEqualStrings("arst", tokens[0].text);
    try testing.expectEqualStrings("abc:123", tokens[1].placeholder);
    try testing.expectEqualStrings("asdf", tokens[2].text);
}

test "tokenize: text, empty placeholder, text" {
    const tokens = comptime tokenize("arst{}asdf");
    try testing.expectEqual(3, tokens.len);

    try testing.expectEqualStrings("arst", tokens[0].text);
    try testing.expectEqualStrings("", tokens[1].placeholder);
    try testing.expectEqualStrings("asdf", tokens[2].text);
}

test "tokenize: escaped open bracket" {
    const tokens = comptime tokenize("{{");
    try testing.expectEqual(1, tokens.len);

    try testing.expectEqualStrings("{", tokens[0].text);
}

test "tokenize: escaped close bracket" {
    const tokens = comptime tokenize("}}");
    try testing.expectEqual(1, tokens.len);

    try testing.expectEqualStrings("}", tokens[0].text);
}

test "tokenize: escaped open and close bracket next to eachother" {
    // The way this works, the tokenizer always uses the first bracket. There is
    // a potential optimization here to have fewer tokens, but given that text
    // is ignored on the MCU side, I don't think it's worth the extra
    // complexity.
    const tokens = comptime tokenize("{{}}");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("{", tokens[0].text);
    try testing.expectEqualStrings("}", tokens[1].text);
}

test "tokenize: escaped open bracket surrounded by text" {
    const tokens = comptime tokenize("arst{{asdf");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("arst{", tokens[0].text);
    try testing.expectEqualStrings("asdf", tokens[1].text);
}

test "tokenize: escaped close bracket surrounded by text" {
    const tokens = comptime tokenize("arst}}asdf");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("arst}", tokens[0].text);
    try testing.expectEqualStrings("asdf", tokens[1].text);
}

test "tokenize: escaped open bracket before placeholder" {
    const tokens = comptime tokenize("{{{asdf}");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("{", tokens[0].text);
    try testing.expectEqualStrings("asdf", tokens[1].placeholder);
}

test "tokenize: escaped close bracket after placeholder" {
    const tokens = comptime tokenize("}}{asdf}");
    try testing.expectEqual(2, tokens.len);

    try testing.expectEqualStrings("}", tokens[0].text);
    try testing.expectEqualStrings("asdf", tokens[1].placeholder);
}

fn check_tokens(fmt: []const u8) !void {
    var t: Tokenizer = .{
        .fmt = fmt,
        .pos = 0,
    };

    while (try t.next()) |_| {}
}

test "tokenize: invalid placeholders" {
    try testing.expectError(error.MismatchedOpen, check_tokens("asdf{abc"));
    try testing.expectError(error.MismatchedOpen, check_tokens("asdfabc{"));
    try testing.expectError(error.MismatchedClose, check_tokens("asdfabc}"));
    try testing.expectError(error.MismatchedClose, check_tokens("asdfabc}arst"));
}

//test "print_info: empty string" {
//    const print_info: PrintInfo = comptime .generate("", @TypeOf(.{}));
//    try testing.expectEqual(0, print_info.instructions.len);
//}
//
//test "print_info: zero args" {
//    const print_info: PrintInfo = comptime .generate("arst", @TypeOf(.{}));
//    try testing.expectEqual(1, print_info.instructions.len);
//}
//
//test "print_info: empty curly" {
//    const print_info: PrintInfo = comptime .generate("{}", @TypeOf(.{}));
//    try testing.expectEqual(1, print_info.instructions.len);
//}
