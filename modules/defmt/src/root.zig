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

pub const WireInfo = union(enum) {
    bool,
    int: std.lang.Type.Int,
    // optional: WireInfo,
    // enum: sent as a number, can be serialized as the field string. Maybe get
    // the typename too?
    // struct: how can we flatten it into a bunch of basic fields
    // arrays
    // pointers:
    //  - single

    pub fn from(comptime T: type) WireInfo {
        return switch (@typeInfo(T)) {
            // We should never see comptime int as it will get folded into the
            // static content of the format string.
            .comptime_int => unreachable,
            .int => |int| .{ .int = int },
            .bool => .bool,
            else => @compileError(std.fmt.comptimePrint("Type unhandled or unsupported: {s}", .{@typeName(T)})),
        };
    }
};

pub const PrintInfo = struct {
    instructions: []const Instruction,

    pub const Instruction = union(enum) {
        text: []const u8,
        value: struct {
            placeholder: std.fmt.Placeholder,
            wire_info: WireInfo,
        },
    };

    fn validate(pi: *const PrintInfo, comptime Args: type) !void {
        const args_count = @typeInfo(Args).@"struct".field_names.len;

        // If one of the arguments is not used we throw an error
        var mask: std.bit_set.Static(args_count) = .full;

        var idx: usize = 0;
        for (pi.instructions) |insn| switch (insn) {
            .value => |value| switch (value.placeholder.arg) {
                .none => {
                    mask.set(idx);
                    idx += 1;
                },
                .number => |n| mask.set(n),
                .named => |name| for (@typeInfo(Args).@"struct".field_names, 0..) |field_name, field_idx| {
                    if (std.mem.eql(u8, name, field_name)) {
                        mask.set(field_idx);
                        break;
                    }
                },
            },
            .text => {},
        };

        if (mask.count() != args_count) {
            return error.UnusedArguments;
        }
    }

    fn parse_placeholders(comptime tokens: []const Tokenizer.Token, comptime Args: type, cis: []const comptime_int) []const Instruction {
        var insns: [tokens.len]Instruction = undefined;

        var ci_idx: usize = 0;
        const idx: usize = 0;
        for (tokens, &insns) |token, *insn|
            insn.* = switch (token) {
                .text => |text| .{ .text = text },
                .placeholder => |str| blk: {
                    const placeholder: std.fmt.Placeholder = .parse(str);
                    const FieldType = @typeInfo(Args).@"struct".field_types[idx];
                    break :blk switch (@typeInfo(FieldType)) {
                        .comptime_int => inner: {
                            const text = std.fmt.comptimePrint("{}", .{cis[ci_idx]});
                            ci_idx += 1;
                            break :inner .{
                                .text = text,
                            };
                        },
                        else => .{
                            .value = .{
                                .placeholder = placeholder,
                                .wire_info = .from(FieldType),
                            },
                        },
                    };
                },
            };

        const insns_copy = insns;
        return &insns_copy;
    }

    fn generate(comptime fmt: [:0]const u8, comptime Args: type, cis: []const comptime_int) PrintInfo {
        const tokens = tokenize(fmt);
        const ret: PrintInfo = .{
            .instructions = parse_placeholders(tokens, Args, cis),
        };
        ret.validate(Args) catch unreachable;
        return ret;
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

fn comptime_ints(args: anytype) []const comptime_int {
    var count: usize = 0;
    for (@typeInfo(@TypeOf(args)).@"struct".field_types) |field_type| {
        if (field_type == .comptime_int)
            count += 1;
    }

    var ret: [count]comptime_int = undefined;

    count = 0;
    for (@typeInfo(@TypeOf(args)).@"struct".field_types, 0..) |field_type, i| {
        if (field_type == .comptime_int) {
            ret[count] = args[i];
            count += 1;
        }
    }

    const int_copy = ret;
    return &int_copy;
}

/// Write binary protocol to writer. It's up to you to figure out how to receive
/// it and format it.
pub fn print(w: *std.Io.Writer, comptime fmt: []const u8, args: anytype) std.Io.Writer.Error!void {
    const print_info: PrintInfo = comptime .generate(fmt, @TypeOf(args), comptime_ints(args));
    const id = register(print_info);
    try write_record(w, id, print_info, args);
}

fn write_record(w: *std.Io.Writer, id: usize, comptime print_info: PrintInfo, args: anytype) !void {
    try w.writeLeb128(id);

    comptime var idx: usize = 0;
    inline for (print_info.instructions) |insn| switch (insn) {
        .text => {}, // The receiver will know to print.
        .value => |value| switch (value.placeholder.arg) {
            .none => {
                try w.writeInt(@TypeOf(args[idx]), args[idx], .little);
                idx += 1;
            },
            .number => unreachable,
            .named => unreachable,
        },
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
    lookup: []const PrintInfo,

    /// Process a single record, flushes the writer.
    pub fn process_record(p: *Printer) !void {
        const id = try p.reader.takeLeb128(u32);
        if (id >= p.lookup.len)
            return error.InvalidID;

        const print_info = p.lookup[id];
        for (print_info.instructions) |insn| switch (insn) {
            .text => |str| try p.writer.writeAll(str),
            .value => |value| switch (value.wire_info) {
                .int => |int| {
                    const byte_count = @divCeil(int.bits, 8);
                    const options: std.fmt.Number = .{
                        .mode = .decimal,
                        .case = .lower,
                        .fill = value.placeholder.fill,
                        .alignment = value.placeholder.alignment,
                    };

                    const buf = try p.reader.peek(byte_count);
                    try print_int(p.writer, int, buf, options);
                    p.reader.toss(byte_count);
                },
                else => @panic("TODO"),
            },
        };

        try p.writer.flush();
    }

    pub fn print_int(
        w: *std.Io.Writer,
        type_info: std.lang.Type.Int,
        /// Always little endian
        buffer: []const u8,
        num_options: std.fmt.Number,
    ) !void {
        const options = std.fmt.Options{
            .precision = num_options.precision,
            .width = num_options.width,
            .alignment = num_options.alignment,
            .fill = num_options.fill,
        };

        const base = num_options.mode.base() orelse 10;
        var reader: std.Io.Reader = .fixed(buffer);
        inline for (&.{ .signed, .unsigned }) |signedness| {
            inline for (&.{ 8, 16, 32, 64 }) |bits| {
                if (type_info.signedness == signedness and type_info.bits == bits) {
                    const value = try reader.takeInt(@Int(signedness, bits), .little);
                    try w.printInt(value, base, num_options.case, options);
                    return;
                }
            }
        }

        @panic("TODO: arbitrary sized integers");
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

test "print_info: empty string" {
    const print_info: PrintInfo = comptime .generate("", @TypeOf(.{}), &.{});
    try testing.expectEqual(0, print_info.instructions.len);
}

test "print_info: zero args" {
    const print_info: PrintInfo = comptime .generate("arst", @TypeOf(.{}), &.{});
    try testing.expectEqual(1, print_info.instructions.len);
}

test "print_info: empty curly" {
    const print_info: PrintInfo = comptime .generate("{}", @TypeOf(.{2}), &.{2});
    try testing.expectEqual(1, print_info.instructions.len);
    try testing.expectEqualStrings("2", print_info.instructions[0].text);
}

test "Printer: static text ellision" {
    // The point of this test is to demonstrate that fixed text within a print
    // statement will not be communicated over the wire, yet is still printed by
    // the printer.

    const id: u32 = 5;
    const print_info: PrintInfo = comptime .generate("asdf{}b", @TypeOf(.{@as(u16, 10)}), &.{});

    var wire_buf: [80]u8 = undefined;
    var wire: std.Io.Writer = .fixed(&wire_buf);

    // We need to ensure that the argument is considered a u16 so that it
    // matches the args type above. A comptime_int is spec'd to get embedded in
    // the static text so that it doesn't need to get sent over the wire.
    try write_record(&wire, id, print_info, .{@as(u16, 4)});

    // When this serialized, I expect it to send two byts, the single Leb128 ID
    // followed by the two bytes that make up the u16.
    try testing.expectEqual(3, wire.buffered().len);
    try testing.expectEqual(5, wire.buffered()[0]);
    // little endian u16 4
    try testing.expectEqual(4, wire.buffered()[1]);
    try testing.expectEqual(0, wire.buffered()[2]);

    var output_buf: [80]u8 = undefined;
    var output: std.Io.Writer = .fixed(&output_buf);
    var reader: std.Io.Reader = .fixed(wire.buffered());

    var printer: Printer = .{
        .reader = &reader,
        .writer = &output,
        .lookup = &.{
            // Some padding so we can have a non zero ID
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            print_info,
        },
    };

    try printer.process_record();
    try testing.expectEqualStrings("asdf4b", output.buffered());
}

test "Printer: comptime_int ellision" {
    const id: u32 = 5;
    const print_info: PrintInfo = comptime .generate("asdf{}b", @TypeOf(.{4}), &.{4});

    var wire_buf: [80]u8 = undefined;
    var wire: std.Io.Writer = .fixed(&wire_buf);

    // We need to ensure that the argument is considered a u16 so that it
    // matches the args type above. A comptime_int is spec'd to get embedded in
    // the static text so that it doesn't need to get sent over the wire.
    try write_record(&wire, id, print_info, .{4});

    // When this serialized, I expect it to send two byts, the single Leb128 ID
    // followed by the two bytes that make up the u16.
    try testing.expectEqual(1, wire.buffered().len);
    try testing.expectEqual(5, wire.buffered()[0]);

    var output_buf: [80]u8 = undefined;
    var output: std.Io.Writer = .fixed(&output_buf);
    var reader: std.Io.Reader = .fixed(wire.buffered());

    var printer: Printer = .{
        .reader = &reader,
        .writer = &output,
        .lookup = &.{
            // Some padding so we can have a non zero ID
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            comptime .generate("", @TypeOf(.{}), &.{}),
            print_info,
        },
    };

    try printer.process_record();
    try testing.expectEqualStrings("asdf4b", output.buffered());
}

const Fixture = struct {
    reader: std.Io.Reader,
    writer: std.Io.Writer.Allocating,
    printer: Printer,

    fn init(
        print_info_entries: []const PrintInfo,
        serial_content: []const u8,
    ) !Fixture {
        var f: Fixture = .{
            .reader = .fixed(serial_content),
            .writer = .init(std.testing.allocator),
            .printer = undefined,
        };

        var lookup: std.array_list.Managed(PrintInfo) = .init(std.testing.allocator);
        try lookup.appendSlice(print_info_entries);
        f.printer = .{
            .reader = &f.reader,
            .writer = &f.writer.writer,
            .lookup = lookup,
        };

        return f;
    }

    fn deinit(f: *Fixture) void {
        f.printer.lookup.deinit();
    }
};

const TestPrintInfo_DB = struct {
    entries: []const PrintInfo,

    fn send_record(db: *const TestPrintInfo_DB, w: *std.Io.Writer, id: usize, args: anytype) !void {
        // The application codepath generates print info from the args type, but
        // we should throw another check here just to catch any test
        // issues/mismatches.

        const pi: *const PrintInfo = &db.entries[id];

        // Just a check to ensure print info can be serialized to json, does
        // nothing else
        var buf: [config.print_info_size_max]u8 = undefined;
        var writer: std.Io.Writer = .fixed(&buf);
        try std.json.Stringify.value(pi, .{}, &writer);

        try pi.validate(@TypeOf(args));
        try write_record(w, id, pi, args);
    }
};
