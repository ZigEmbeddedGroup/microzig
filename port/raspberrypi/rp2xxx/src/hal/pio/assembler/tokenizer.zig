const std = @import("std");
const assert = std.debug.assert;

const assembler = @import("../assembler.zig");
const Diagnostics = assembler.Diagnostics;

const Expression = @import("Expression.zig");
const CPU = @import("../../cpu.zig").CPU;

pub const Options = struct {
    capacity: u32 = 256,
};

pub fn tokenize(
    comptime cpu: CPU,
    source: []const u8,
    diags: *?assembler.Diagnostics,
    comptime options: Options,
) !std.BoundedArray(Token(cpu), options.capacity) {
    var tokens = std.BoundedArray(Token(cpu), options.capacity).init(0) catch unreachable;
    var tokenizer = Tokenizer(cpu).init(source);
    while (try tokenizer.next(diags)) |token|
        try tokens.append(token);

    return tokens;
}

pub const Value = union(enum) {
    // integer, hex, binary
    integer: u32,
    // either a symbol or label
    string: []const u8,
    expression: []const u8,

    pub fn format(
        value: Value,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;
        switch (value) {
            .string => |str| try writer.print("\"{s}\"", .{str}),
            .expression => |expr| try writer.print("{s}", .{expr}),
            .integer => |int| try writer.print("{}", .{int}),
        }
    }

    pub fn from_string(str: []const u8) !Value {
        return Value{
            .integer = std.fmt.parseInt(u32, str, 0) catch {
                return Value{
                    .string = str,
                };
            },
        };
    }
};

// the characters we're interested in are:
// ';' -> line comment
// '/' -> '/' -> line comment
// '/' -> '*' -> block comment
// '%' -> <whitespace> -> <identifier> -> <whitespace> -> '{' -> code block
// '.' -> directive
pub fn Tokenizer(cpu: CPU) type {
    return struct {
        const Self = @This();
        source: []const u8,
        index: u32,

        pub fn format(
            self: Self,
            comptime fmt: []const u8,
            options: std.fmt.FormatOptions,
            writer: anytype,
        ) !void {
            _ = fmt;
            _ = options;

            try writer.print(
                \\parser:
                \\  index: {}
                \\
                \\
            , .{self.index});

            var printed_cursor = false;
            var line_it = std.mem.tokenize(u8, self.source, "\n\r");
            while (line_it.next()) |line| {
                try writer.print("{s}\n", .{line});
                if (!printed_cursor and line_it.index > self.index) {
                    try writer.writeByteNTimes(' ', line.len - (line_it.index - self.index));
                    try writer.writeAll("\x1b[30;42;1m^\x1b[0m\n");
                    printed_cursor = true;
                }
            }
        }

        fn init(source: []const u8) Self {
            return Self{
                .source = source,
                .index = 0,
            };
        }

        fn consume(self: *Self, count: u32) void {
            assert(self.index < self.source.len);
            self.index += count;
        }

        fn peek(self: Self) ?u8 {
            return if (self.index < self.source.len)
                self.source[self.index]
            else
                null;
        }

        fn get(self: *Self) ?u8 {
            return if (self.index < self.source.len) blk: {
                defer self.index += 1;
                break :blk self.source[self.index];
            } else null;
        }

        fn skip_line(self: *Self) void {
            while (self.get()) |c|
                if (c == '\n')
                    return;
        }

        fn skip_until_end_of_comment_block(self: *Self) void {
            while (self.get()) |c| {
                if (c == '*') {
                    if (self.peek()) |p| {
                        self.consume(1);
                        if (p == '/') {
                            return;
                        }
                    }
                }
            }
        }

        fn skip_until_end_of_code_block(self: *Self) void {
            // TODO: assert we have the code identifier and open curly bracket
            while (self.get()) |c| {
                if (c == '%') {
                    if (self.peek()) |p| {
                        self.consume(1);
                        if (p == '}') {
                            return;
                        }
                    }
                }
            }
        }

        fn read_until_whitespace_or_end(self: *Self) ![]const u8 {
            const start = self.index;
            var end: ?u32 = null;
            while (self.peek()) |p| {
                switch (p) {
                    ' ', '\n', '\r', '\t', ',' => {
                        end = self.index;
                        break;
                    },
                    else => self.consume(1),
                }
            } else end = self.index;

            return self.source[start .. end orelse return error.EndOfStream];
        }

        fn skip_whitespace(self: *Self) void {
            while (self.peek()) |p| {
                switch (p) {
                    ' ', '\t', '\r', '\n', ',' => self.consume(1),
                    else => return,
                }
            }
        }

        /// returns array of args
        fn get_args(self: *Self, comptime num: u32, diags: *?Diagnostics) TokenizeError![num]?[]const u8 {
            var args: [num]?[]const u8 = undefined;
            for (&args) |*arg|
                arg.* = try self.get_arg(diags);

            return args;
        }

        const PeekResult = struct {
            str: []const u8,
            start: u32,
        };

        fn peek_arg(self: *Self, diags: *?Diagnostics) TokenizeError!?PeekResult {
            var tmp_index = self.index;
            return self.peek_arg_impl(&tmp_index, diags);
        }

        fn consume_peek(self: *Self, result: PeekResult) void {
            assert(self.index <= result.start);
            self.index = result.start + @as(u32, @intCast(result.str.len));
        }

        /// gets next arg without consuming the stream
        fn peek_arg_impl(
            self: *Self,
            index: *u32,
            diags: *?Diagnostics,
        ) TokenizeError!?PeekResult {

            // skip whitespace
            while (index.* < self.source.len) {
                switch (self.source[index.*]) {
                    ' ', '\t', ',' => index.* += 1,
                    else => break,
                }
            }

            if (index.* == self.source.len)
                return null;

            const start = index.*;
            const end = end: {
                break :end switch (self.source[start]) {
                    '(' => blk: {
                        var depth: u32 = 0;
                        break :blk while (index.* < self.source.len) : (index.* += 1) {
                            switch (self.source[index.*]) {
                                '(' => depth += 1,
                                ')' => {
                                    depth -= 1;

                                    if (depth == 0) {
                                        index.* += 1;
                                        break index.*;
                                    }
                                },
                                else => {},
                            }
                        } else {
                            diags.* = Diagnostics.init(start, "mismatched parenthesis", .{});
                            return error.InvalidExpression;
                        };
                    },
                    '[' => while (index.* < self.source.len) : (index.* += 1) {
                        if (self.source[index.*] == ']') {
                            index.* += 1;
                            break index.*;
                        }
                    } else {
                        diags.* = Diagnostics.init(start, "mismatched parenthesis", .{});
                        return error.InvalidExpression;
                    },
                    else => while (index.* < self.source.len) {
                        switch (self.source[index.*]) {
                            // ; and / are to stop at comments
                            ' ', '\t', '\r', '\n', ',', ';', '/' => break index.*,
                            else => index.* += 1,
                        }
                    } else index.*,
                };
            };

            return if (start != end)
                PeekResult{
                    .str = self.source[start..end],
                    .start = start,
                }
            else
                null;
        }

        fn get_arg(self: *Self, diags: *?Diagnostics) TokenizeError!?[]const u8 {
            return if (try self.peek_arg_impl(&self.index, diags)) |result|
                result.str
            else
                null;
        }

        const Identifier = struct {
            index: u32,
            str: []const u8,
        };

        fn get_identifier(self: *Self) TokenizeError!Identifier {
            self.skip_whitespace();
            return Identifier{
                .index = self.index,
                .str = try self.read_until_whitespace_or_end(),
            };
        }

        const TokenizeError = error{
            EndOfStream,
            NoValue,
            NotAnExpression,
            Overflow,
            InvalidCharacter,
            InvalidSource,
            InvalidCondition,
            MissingArg,
            InvalidDestination,
            InvalidOperation,
            InvalidExpression,
            TooBig,
        };

        fn get_program(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            const name = (try self.get_arg(diags)) orelse {
                diags.* = Diagnostics.init(index, "missing program name", .{});
                return error.MissingArg;
            };
            return Token(cpu){
                .index = index,
                .data = .{ .program = name },
            };
        }

        fn assert_is_lower(str: []const u8) void {
            for (str) |c|
                assert(std.ascii.isLower(c));
        }

        fn eql_lower(comptime lhs: []const u8, rhs: []const u8) bool {
            assert_is_lower(lhs);
            if (lhs.len != rhs.len)
                return false;

            var buf: [lhs.len]u8 = undefined;
            for (&buf, rhs) |*b, r|
                b.* = std.ascii.toLower(r);

            return std.mem.eql(u8, &buf, lhs);
        }

        fn get_define(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            const maybe_public = try self.get_identifier();
            const is_public = eql_lower("public", maybe_public.str);

            const name = if (is_public)
                try self.get_identifier()
            else
                maybe_public;

            return Token(cpu){
                .index = index,
                .data = .{
                    .define = .{
                        .name = name.str,
                        .value = Value{
                            .expression = (try self.get_arg(diags)) orelse {
                                diags.* = Diagnostics.init(index, "failed to get expression", .{});
                                return error.InvalidExpression;
                            },
                        },
                        .public = is_public,
                        .index = name.index,
                    },
                },
            };
        }

        fn get_expression(self: *Self) TokenizeError!Value {
            const start = self.index;
            var count: u32 = 1;

            if (self.get()) |c|
                if (c != '(')
                    return error.NotAnExpression;

            while (self.get()) |c| {
                switch (c) {
                    '(' => count += 1,
                    ')' => {
                        count -= 1;
                    },
                    else => {},
                }

                if (count == 0) {
                    return Value{
                        .expression = self.source[start..self.index],
                    };
                }
            } else {
                return error.NotAnExpression;
            }
        }

        fn get_value(self: *Self) TokenizeError!Value {
            self.skip_whitespace();

            if (self.peek()) |p|
                if (p == '(')
                    return try self.get_expression()
                else {
                    const identifier = try self.get_identifier();
                    return try Value.from_string(identifier.str);
                }
            else
                return error.NoValue;
        }

        fn get_origin(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            _ = diags;
            return Token(cpu){
                .index = index,
                .data = .{
                    .origin = try self.get_value(),
                },
            };
        }

        fn get_side_set(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            const args = try self.get_args(3, diags);
            const count = try Value.from_string(args[0] orelse {
                diags.* = Diagnostics.init(index, "missing count", .{});
                return error.MissingArg;
            });
            var opt = false;
            var pindirs = false;

            if (args[1]) |arg| {
                if (std.mem.eql(u8, "opt", arg))
                    opt = true
                else if (std.mem.eql(u8, "pindirs", arg))
                    pindirs = true;
            }

            if (args[2]) |arg| {
                if (std.mem.eql(u8, "pindirs", arg))
                    pindirs = true;
            }

            return Token(cpu){
                .index = index,
                .data = .{
                    .side_set = .{
                        .count = count,
                        .opt = opt,
                        .pindir = pindirs,
                    },
                },
            };
        }

        fn get_wrap_target(_: *Self, index: u32, _: *?Diagnostics) TokenizeError!Token(cpu) {
            return Token(cpu){
                .index = index,
                .data = .{ .wrap_target = {} },
            };
        }

        fn get_wrap(_: *Self, index: u32, _: *?Diagnostics) TokenizeError!Token(cpu) {
            return Token(cpu){
                .index = index,
                .data = .{ .wrap = {} },
            };
        }

        fn get_lang_opt(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            _ = diags;
            return Token(cpu){
                .index = index,
                .data = .{
                    .lang_opt = .{
                        .lang = (try self.get_identifier()).str,
                        .name = (try self.get_identifier()).str,
                        .option = (try self.get_identifier()).str,
                    },
                },
            };
        }

        fn get_word(self: *Self, index: u32, diags: *?Diagnostics) TokenizeError!Token(cpu) {
            _ = diags;
            return Token(cpu){
                .index = index,
                .data = .{ .word = try self.get_value() },
            };
        }

        const directives = std.StaticStringMap(*const fn (*Self, u32, *?Diagnostics) TokenizeError!Token(cpu)).initComptime(.{
            .{ "program", get_program },
            .{ "define", get_define },
            .{ "origin", get_origin },
            .{ "side_set", get_side_set },
            .{ "wrap_target", get_wrap_target },
            .{ "wrap", get_wrap },
            .{ "lang_opt", get_lang_opt },
            .{ "word", get_word },
        });

        fn get_directive(self: *Self, diags: *?Diagnostics) !Token(cpu) {
            const index = self.index;
            const identifier = try self.read_until_whitespace_or_end();
            return if (directives.get(identifier)) |handler| ret: {
                const ret = try handler(self, index, diags);
                self.skip_line();
                break :ret ret;
            } else error.InvalidDirective;
        }

        fn get_nop(_: *Self, _: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            return Token(cpu).Instruction.Payload{
                .nop = {},
            };
        }

        fn target_from_string(str: []const u8) TokenizeError!Token(cpu).Instruction.Jmp.Target {
            const value = Value.from_string(str);
            return Token(cpu).Instruction.Payload{
                .jmp = .{
                    .condition = .always,
                    .target = switch (value) {
                        .string => |label| Token(cpu).Instruction.Jmp.Target{
                            .label = label,
                        },
                        else => Token(cpu).Instruction.Jmp.Target{
                            .value = value,
                        },
                    },
                },
            };
        }

        fn get_jmp(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const Condition = Token(cpu).Instruction.Jmp.Condition;
            const conditions = std.StaticStringMap(Condition).initComptime(.{
                .{ "!x", .x_is_zero },
                .{ "x--", .x_dec },
                .{ "!y", .y_is_zero },
                .{ "y--", .y_dec },
                .{ "x!=y", .x_is_not_y },
                .{ "pin", .pin },
                .{ "!osre", .osre_not_empty },
            });

            const maybe_cond = (try self.get_arg(diags)) orelse return error.MissingArg;
            const maybe_cond_lower = try lowercase_bounded(256, maybe_cond);
            const cond: Condition = conditions.get(maybe_cond_lower.slice()) orelse .always;
            const target_str = if (cond == .always)
                maybe_cond
            else
                (try self.get_arg(diags)) orelse return error.MissingArg;

            return Token(cpu).Instruction.Payload{
                .jmp = .{ .condition = cond, .target = target_str },
            };
        }

        fn get_wait(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const polarity = try std.fmt.parseInt(u1, (try self.get_arg(diags)) orelse return error.MissingArg, 0);
            const source_str = (try self.get_arg(diags)) orelse return error.MissingArg;
            const pin = try Value.from_string((try self.get_arg(diags)) orelse return error.MissingArg);

            var buf: [8]u8 = undefined;
            for (source_str, 0..) |c, i|
                buf[i] = std.ascii.toLower(c);

            const source_lower = buf[0..source_str.len];
            const source: Token(cpu).Instruction.Wait.Source =
                if (std.mem.eql(u8, "gpio", source_lower))
                .gpio
            else if (std.mem.eql(u8, "pin", source_lower))
                .pin
            else if (std.mem.eql(u8, "irq", source_lower))
                .irq
            else
                return error.InvalidSource;

            const rel: bool = if (source == .irq)
                if (try self.peek_arg(diags)) |rel_result| blk: {
                    const is_rel = std.mem.eql(u8, "rel", rel_result.str);
                    if (is_rel)
                        self.consume_peek(rel_result);

                    break :blk is_rel;
                } else false
            else
                false;

            return Token(cpu).Instruction.Payload{
                .wait = .{
                    .polarity = polarity,
                    .source = source,
                    .num = pin,
                    .rel = rel,
                },
            };
        }

        /// get the lowercase of a string, returns an error if it's too big
        fn lowercase_bounded(comptime max_size: usize, str: []const u8) TokenizeError!std.BoundedArray(u8, max_size) {
            if (str.len > max_size)
                return error.TooBig;

            var ret = std.BoundedArray(u8, max_size).init(0) catch unreachable;
            for (str) |c|
                try ret.append(std.ascii.toLower(c));

            return ret;
        }

        // TODO: I need to take a break. There is no rush to finish this. The thing
        // I need to keep in mind with `get_args()` is that I must only consume the
        // args that are used. side set and delay may be on the same line

        fn get_in(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const source_str = (try self.get_arg(diags)) orelse return error.MissingArg;
            const bit_count_str = (try self.get_arg(diags)) orelse return error.MissingArg;

            const source_lower = try lowercase_bounded(256, source_str);
            const bit_count_tmp = try std.fmt.parseInt(u6, bit_count_str, 0);
            const bit_count = if (bit_count_tmp == 32)
                @as(u5, 0)
            else
                @as(u5, @intCast(bit_count_tmp));

            return Token(cpu).Instruction.Payload{
                .in = .{
                    .source = std.meta.stringToEnum(Token(cpu).Instruction.In.Source, source_lower.slice()) orelse return error.InvalidSource,
                    .bit_count = bit_count,
                },
            };
        }

        fn get_out(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const dest_src = (try self.get_arg(diags)) orelse return error.MissingArg;
            const bit_count_str = (try self.get_arg(diags)) orelse return error.MissingArg;

            const dest_lower = try lowercase_bounded(256, dest_src);
            const bit_count_tmp = try std.fmt.parseInt(u6, bit_count_str, 0);
            const bit_count = if (bit_count_tmp == 32)
                @as(u5, 0)
            else
                @as(u5, @intCast(bit_count_tmp));

            return Token(cpu).Instruction.Payload{
                .out = .{
                    .destination = std.meta.stringToEnum(Token(cpu).Instruction.Out.Destination, dest_lower.slice()) orelse return error.InvalidDestination,
                    .bit_count = bit_count,
                },
            };
        }

        fn block_from_peek(self: *Self, result: PeekResult) TokenizeError!bool {
            const block_lower = try lowercase_bounded(256, result.str);
            const is_block = std.mem.eql(u8, "block", block_lower.slice());
            const is_noblock = std.mem.eql(u8, "noblock", block_lower.slice());

            if (is_block or is_noblock)
                self.consume_peek(result);

            return if (is_block)
                true
            else if (is_noblock)
                false
            else
                true;
        }

        fn get_push(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            return if (try self.peek_arg(diags)) |first_result| ret: {
                const lower = try lowercase_bounded(256, first_result.str);
                const iffull = std.mem.eql(u8, "iffull", lower.slice());

                const block: bool = if (iffull) blk: {
                    self.consume_peek(first_result);
                    break :blk if (try self.peek_arg(diags)) |block_result|
                        try self.block_from_peek(block_result)
                    else
                        true;
                } else try self.block_from_peek(first_result);

                break :ret Token(cpu).Instruction.Payload{
                    .push = .{
                        .iffull = iffull,
                        .block = block,
                    },
                };
            } else Token(cpu).Instruction.Payload{
                .push = .{
                    .iffull = false,
                    .block = true,
                },
            };
        }

        fn get_pull(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            return if (try self.peek_arg(diags)) |first_result| ret: {
                const lower = try lowercase_bounded(256, first_result.str);
                const ifempty = std.mem.eql(u8, "ifempty", lower.slice());

                const block: bool = if (ifempty) blk: {
                    self.consume_peek(first_result);
                    break :blk if (try self.peek_arg(diags)) |block_result|
                        try self.block_from_peek(block_result)
                    else
                        true;
                } else try self.block_from_peek(first_result);

                break :ret Token(cpu).Instruction.Payload{
                    .pull = .{
                        .ifempty = ifempty,
                        .block = block,
                    },
                };
            } else Token(cpu).Instruction.Payload{
                .pull = .{
                    .ifempty = false,
                    .block = true,
                },
            };
        }

        fn get_mov(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const dest_str = (try self.get_arg(diags)) orelse return error.MissingArg;
            const dest_lower = try lowercase_bounded(256, dest_str);
            const destination = std.meta.stringToEnum(Token(cpu).Instruction.Mov.Destination, dest_lower.slice()) orelse return error.InvalidDestination;

            const second = try self.get_arg(diags) orelse return error.MissingArg;
            const op_prefixed: ?[]const u8 = if (std.mem.startsWith(u8, second, "!"))
                "!"
            else if (std.mem.startsWith(u8, second, "~"))
                "~"
            else if (std.mem.startsWith(u8, second, "::"))
                "::"
            else
                null;

            const source_str = if (op_prefixed) |op_str|
                if (second.len == op_str.len)
                    (try self.get_arg(diags)) orelse return error.MissingArg
                else
                    second[op_str.len..]
            else
                second;

            const source_lower = try lowercase_bounded(256, source_str);
            const source = std.meta.stringToEnum(Token(cpu).Instruction.Mov.Source, source_lower.slice()) orelse return error.InvalidSource;
            const operation: Token(cpu).Instruction.Mov.Operation = if (op_prefixed) |op_str|
                if (std.mem.eql(u8, "!", op_str))
                    .invert
                else if (std.mem.eql(u8, "~", op_str))
                    .invert
                else if (std.mem.eql(u8, "::", op_str))
                    .bit_reverse
                else
                    return error.InvalidOperation
            else
                .none;

            return Token(cpu).Instruction.Payload{
                .mov = .{
                    .destination = destination,
                    .source = source,
                    .operation = operation,
                },
            };
        }

        fn get_irq(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const first = (try self.get_arg(diags)) orelse return error.MissingArg;

            var clear = false;
            var wait = false;
            var has_mode = false;
            const first_lower = try lowercase_bounded(256, first);
            if (std.mem.eql(u8, "set", first_lower.slice())) {
                has_mode = true;
                // do nothing
            } else if (std.mem.eql(u8, "nowait", first_lower.slice())) {
                has_mode = true;
                // do nothing
            } else if (std.mem.eql(u8, "wait", first_lower.slice())) {
                has_mode = true;
                wait = true;
            } else if (std.mem.eql(u8, "clear", first_lower.slice())) {
                has_mode = true;
                clear = true;
            }

            const num = Value{
                .expression = if (has_mode)
                    (try self.get_arg(diags)) orelse {
                        diags.* = Diagnostics.init(self.index, "irq (mode) <num> (prev,rel,next): failed to get num argument", .{});
                        return error.MissingArg;
                    }
                else
                    first,
            };

            switch (comptime cpu) {
                .RP2040 => {
                    const rel: bool = if (try self.peek_arg(diags)) |result| blk: {
                        const rel_lower = try lowercase_bounded(256, result.str);
                        const is_rel = std.mem.eql(u8, "rel", rel_lower.slice());
                        if (is_rel)
                            self.consume_peek(result);

                        break :blk is_rel;
                    } else false;

                    return Token(cpu).Instruction.Payload{
                        .irq = .{
                            .clear = clear,
                            .wait = wait,
                            .num = num,
                            .rel = rel,
                        },
                    };
                },
                .RP2350 => {
                    // This doesn't work: idx_mode's type only exists at comptime,
                    // even though this is a comptime-only switch :/
                    // Hardcoding the type
                    const idx_mode: u2 = if (try self.peek_arg(diags)) |result| blk: {
                        const idxmode_lower = try lowercase_bounded(256, result.str);
                        if (std.mem.eql(u8, "rel", idxmode_lower.slice())) {
                            // @compileLog("got rel"); // DELETEME
                            self.consume_peek(result);
                            break :blk 0b10;
                            // break :blk .rel;
                        } else if (std.mem.eql(u8, "prev", idxmode_lower.slice())) {
                            // @compileLog("got prev"); // DELETEME
                            self.consume_peek(result);
                            break :blk 0b01;
                            // break :blk .prev;
                        } else if (std.mem.eql(u8, "next", idxmode_lower.slice())) {
                            // @compileLog("got next"); // DELETEME
                            self.consume_peek(result);
                            break :blk 0b11;
                            // break :blk .next;
                        } else {
                            // Not specified: direct
                            break :blk 0b00;
                            // break :blk .direct;
                        }
                    } else 0b00;
                    // } else .direct;

                    return Token(cpu).Instruction.Payload{
                        .irq = .{
                            .clear = clear,
                            .wait = wait,
                            .num = num,
                            .idxmode = @enumFromInt(idx_mode),
                        },
                    };
                },
            }
        }

        fn get_set(self: *Self, diags: *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload {
            const dest_str = (try self.get_arg(diags)) orelse {
                diags.* = Diagnostics.init(0, "missing destination", .{});
                return error.MissingArg;
            };
            const value = try self.get_value();

            const dest_lower = try lowercase_bounded(256, dest_str);

            return Token(cpu).Instruction.Payload{
                .set = .{
                    .destination = std.meta.stringToEnum(Token(cpu).Instruction.Set.Destination, dest_lower.slice()) orelse return error.InvalidDestination,
                    .value = value,
                },
            };
        }

        const instructions = std.StaticStringMap(*const fn (*Self, *?Diagnostics) TokenizeError!Token(cpu).Instruction.Payload).initComptime(.{
            .{ "nop", get_nop },
            .{ "jmp", get_jmp },
            .{ "wait", get_wait },
            .{ "in", get_in },
            .{ "out", get_out },
            .{ "push", get_push },
            .{ "pull", get_pull },
            .{ "mov", get_mov },
            .{ "irq", get_irq },
            .{ "set", get_set },
        });

        fn get_instruction(self: *Self, name: Identifier, diags: *?Diagnostics) !Token(cpu) {
            const name_lower = try lowercase_bounded(256, name.str);
            const payload = if (instructions.get(name_lower.slice())) |handler|
                try handler(self, diags)
            else {
                diags.* = Diagnostics.init(name.index, "invalid instruction", .{});
                return error.InvalidInstruction;
            };

            var side_set: ?Value = null;
            var delay: ?Value = null;

            if (try self.peek_arg(diags)) |result| {
                if (eql_lower("side", result.str)) {
                    self.consume_peek(result);

                    const side_set_str = (try self.get_arg(diags)) orelse return error.MissingArg;
                    side_set = Value{ .expression = side_set_str };
                } else if (std.mem.startsWith(u8, result.str, "[") and std.mem.endsWith(u8, result.str, "]")) {
                    self.consume_peek(result);
                    delay = Value{ .expression = result.str[1 .. result.str.len - 1] };
                }
            }

            if (try self.peek_arg(diags)) |result| {
                if (eql_lower("side", result.str)) {
                    self.consume_peek(result);

                    const side_set_str = (try self.get_arg(diags)) orelse return error.MissingArg;
                    assert(side_set == null);
                    side_set = Value{ .expression = side_set_str };
                } else if (std.mem.startsWith(u8, result.str, "[") and std.mem.endsWith(u8, result.str, "]")) {
                    self.consume_peek(result);
                    assert(delay == null);
                    delay = Value{
                        .expression = result.str[1 .. result.str.len - 1],
                    };
                }
            }

            self.skip_line();
            return Token(cpu){
                .index = name.index,
                .data = .{
                    .instruction = .{
                        .payload = payload,
                        .side_set = side_set,
                        .delay = delay,
                    },
                },
            };
        }

        fn next(self: *Self, diags: *?assembler.Diagnostics) !?Token(cpu) {
            while (self.peek()) |p| {
                switch (p) {
                    ' ', '\t', '\n', '\r', ',' => self.consume(1),
                    ';' => self.skip_line(),
                    '/' => {
                        self.consume(1);
                        if (self.peek()) |p2| {
                            self.consume(1);
                            switch (p2) {
                                '/' => self.skip_line(),
                                '*' => self.skip_until_end_of_comment_block(),
                                else => unreachable,
                            }
                        } else return null;
                    },
                    '%' => {
                        self.consume(1);
                        self.skip_until_end_of_code_block();
                    },
                    '.' => {
                        self.consume(1);
                        return try self.get_directive(diags);
                    },
                    'a'...'z', 'A'...'Z', '0'...'9', '_' => {
                        const first = try self.get_identifier();

                        // definitely a label
                        return if (eql_lower("public", first.str))
                            Token(cpu){
                                .index = first.index,
                                .data = .{
                                    .label = .{
                                        .public = true,
                                        .name = blk: {
                                            const tmp = (try self.get_identifier()).str;
                                            break :blk tmp[0 .. tmp.len - 1];
                                        },
                                    },
                                },
                            }
                        else if (std.mem.endsWith(u8, first.str, ":"))
                            Token(cpu){
                                .index = first.index,
                                .data = .{
                                    .label = .{
                                        .name = first.str[0 .. first.str.len - 1],
                                    },
                                },
                            }
                        else
                            try self.get_instruction(first, diags);
                    },
                    else => return error.Unhandled,
                }
            }

            return null;
        }
    };
}

pub fn Token(comptime cpu: CPU) type {
    return struct {
        const Self = @This();
        index: u32,
        data: union(enum) {
            program: []const u8,
            define: Self.Define,
            origin: Value,
            side_set: SideSet,
            wrap_target: void,
            wrap: void,
            lang_opt: LangOpt,
            word: Value,
            label: Label,
            instruction: Instruction,
        },

        pub const Tag = std.meta.Tag(std.meta.FieldType(Token(cpu), .data));

        pub const Label = struct {
            name: []const u8,
            public: bool = false,
        };

        // TODO: use Value instead of numbers
        pub const Instruction = struct {
            payload: Payload,
            side_set: ?Value = null,
            // TODO: delay can look like [T1-1], so we could consider the square
            // brackets to be an expression
            delay: ?Value = null,

            pub const Payload = union(enum) {
                nop: void,
                jmp: Jmp,
                wait: Wait,
                in: In,
                out: Out,
                push: Push,
                pull: Pull,
                mov: Mov,
                irq: Irq,
                set: Set,
            };

            pub const Jmp = struct {
                condition: Condition,
                target: []const u8,

                pub const Condition = enum(u3) {
                    always = 0b000,
                    x_is_zero = 0b001, // !X
                    x_dec = 0b010, // X--
                    y_is_zero = 0b011, // !Y
                    y_dec = 0b100, // Y--
                    x_is_not_y = 0b101, //X!=Y
                    pin = 0b110, // PIN
                    osre_not_empty = 0b111, // !OSRE
                };
            };

            pub const Wait = struct {
                polarity: u1,
                source: Source,
                num: Value,
                rel: bool,

                pub const Source = switch (cpu) {
                    .RP2040 => enum(u2) {
                        gpio = 0b00,
                        pin = 0b01,
                        irq = 0b10,
                    },
                    .RP2350 => enum(u2) {
                        gpio = 0b00,
                        pin = 0b01,
                        irq = 0b10,
                        jmppin = 0b11,
                    },
                };
            };

            pub const In = struct {
                source: Source,
                bit_count: u5,

                pub const Source = enum(u3) {
                    pins = 0b00,
                    x = 0b001,
                    y = 0b010,
                    null = 0b011,
                    isr = 0b110,
                    osr = 0b111,
                };
            };

            pub const Out = struct {
                destination: Destination,
                bit_count: u5,

                pub const Destination = enum(u3) {
                    pins = 0b000,
                    x = 0b001,
                    y = 0b010,
                    null = 0b011,
                    pindirs = 0b100,
                    pc = 0b101,
                    isr = 0b110,
                    exec = 0b111,
                };
            };

            pub const Push = struct {
                block: bool,
                iffull: bool,
            };

            pub const Pull = struct {
                block: bool,
                ifempty: bool,
            };

            // TODO: Add mov to RX for rp2350
            pub const Mov = struct {
                destination: Destination,
                operation: Operation,
                source: Source,

                pub const Destination = switch (cpu) {
                    .RP2040 => enum(u3) {
                        pins = 0b000,
                        x = 0b001,
                        y = 0b010,
                        exec = 0b100,
                        pc = 0b101,
                        isr = 0b110,
                        osr = 0b111,
                    },
                    .RP2350 => enum(u3) {
                        pins = 0b000,
                        x = 0b001,
                        y = 0b010,
                        pindirs = 0b011,
                        exec = 0b100,
                        pc = 0b101,
                        isr = 0b110,
                        osr = 0b111,
                    },
                };

                pub const Operation = enum(u2) {
                    none = 0b00,
                    invert = 0b01,
                    bit_reverse = 0b10,
                };

                pub const Source = enum(u3) {
                    pins = 0b00,
                    x = 0b001,
                    y = 0b010,
                    null = 0b011,
                    status = 0b101,
                    isr = 0b110,
                    osr = 0b111,
                };
            };

            pub const Irq = switch (cpu) {
                .RP2040 => struct {
                    clear: bool,
                    wait: bool,
                    num: Value,
                    rel: bool,
                },
                .RP2350 => struct {
                    clear: bool,
                    wait: bool,
                    num: Value,
                    idxmode: IdxMode,

                    pub const IdxMode = enum(u2) {
                        direct = 0b00,
                        prev = 0b01,
                        rel = 0b10,
                        next = 0b11,
                    };
                },
            };

            pub const Set = struct {
                destination: Destination,
                value: Value,

                pub const Destination = enum(u3) {
                    pins = 0b000,
                    x = 0b001,
                    y = 0b010,
                    pindirs = 0b100,
                };
            };
        };

        pub const Define = struct {
            name: []const u8,
            value: Value,
            public: bool = false,
            index: u32,
        };

        pub const SideSet = struct {
            count: Value,
            opt: bool = false,
            pindir: bool = false,
        };

        pub const LangOpt = struct {
            lang: []const u8,
            name: []const u8,
            option: []const u8,
        };
    };
}

//==============================================================================
// Tokenization Tests
//==============================================================================

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

fn DirectiveTag(comptime cpu: CPU) type {
    return @typeInfo(Token(cpu).Directive).Union.tag_type.?;
}
fn PayloadTag(comptime cpu: CPU) type {
    return @typeInfo(Token(cpu).Instruction.Payload).Union.tag_type.?;
}

fn expect_program(comptime cpu: CPU, expected: []const u8, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.program, @as(Token(cpu).Tag, actual.data));
    try expectEqualStrings(expected, actual.data.program);
}

fn expect_value(expected: Value, actual: Value) !void {
    switch (expected) {
        .integer => |int| try expectEqual(int, actual.integer),
        .string => |str| try expectEqualStrings(str, actual.string),
        .expression => |expr| try expectEqualStrings(expr, actual.expression),
    }
}

fn expect_opt_value(expected: ?Value, actual: ?Value) !void {
    if (expected != null)
        switch (expected.?) {
            .integer => |int| try expectEqual(int, actual.?.integer),
            .string => |str| try expectEqualStrings(str, actual.?.string),
            .expression => |expr| try expectEqualStrings(expr, actual.?.expression),
        };
}

fn expect_define(comptime cpu: CPU, expected: Token(cpu).Define, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.define, @as(Token(cpu).Tag, actual.data));

    const define = actual.data.define;
    try expectEqualStrings(expected.name, define.name);
    try expect_value(expected.value, define.value);
}

fn expect_origin(comptime cpu: CPU, expected: Value, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.origin, @as(Token(cpu).Tag, actual.data));
    try expect_value(expected, actual.data.origin);
}

fn expect_side_set(comptime cpu: CPU, expected: Token(cpu).SideSet, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.side_set, @as(Token(cpu).Tag, actual.data));

    const side_set = actual.data.side_set;
    try expect_value(expected.count, side_set.count);
    try expectEqual(expected.opt, side_set.opt);
    try expectEqual(expected.pindir, side_set.pindir);
}

fn expect_wrap_target(comptime cpu: CPU, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.wrap_target, @as(Token(cpu).Tag, actual.data));
}

fn expect_wrap(comptime cpu: CPU, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.wrap, @as(Token(cpu).Tag, actual.data));
}

fn expect_lang_opt(comptime cpu: CPU, expected: Token(cpu).LangOpt, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.lang_opt, @as(Token(cpu).Tag, actual.data));

    const lang_opt = actual.data.lang_opt;
    try expectEqualStrings(expected.lang, lang_opt.lang);
    try expectEqualStrings(expected.name, lang_opt.name);
    try expectEqualStrings(expected.option, lang_opt.option);
}

fn expect_word(comptime cpu: CPU, expected: Value, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.word, @as(Token(cpu).Tag, actual.data));
    try expect_value(expected, actual.data.word);
}

fn expect_label(comptime cpu: CPU, expected: Token(cpu).Label, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.label, @as(Token(cpu).Tag, actual.data));

    const label = actual.data.label;
    try expectEqual(expected.public, label.public);
    try expectEqualStrings(expected.name, label.name);
}

const ExpectedNopInstr = struct {
    delay: ?Value = null,
    side_set: ?Value = null,
};

fn expect_instr_nop(comptime cpu: CPU, expected: ExpectedNopInstr, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).nop, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);
}

fn ExpectedSetInstr(comptime cpu: CPU) type {
    return struct {
        dest: Token(cpu).Instruction.Set.Destination,
        value: Value,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_set(comptime cpu: CPU, expected: ExpectedSetInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).set, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const set = instr.payload.set;
    try expectEqual(expected.dest, set.destination);
    try expect_value(expected.value, set.value);
}

fn ExpectedJmpInstr(comptime cpu: CPU) type {
    return struct {
        cond: Token(cpu).Instruction.Jmp.Condition = .always,
        target: []const u8,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_jmp(comptime cpu: CPU, expected: ExpectedJmpInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).jmp, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const jmp = instr.payload.jmp;
    try expectEqual(expected.cond, jmp.condition);
    try expectEqualStrings(expected.target, jmp.target);
}

fn ExpectedWaitInstr(comptime cpu: CPU) type {
    return struct {
        polarity: u1,
        source: Token(cpu).Instruction.Wait.Source,
        num: Value,
        // only valid for irq source
        rel: bool = false,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_wait(comptime cpu: CPU, expected: ExpectedWaitInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).wait, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const wait = instr.payload.wait;
    try expectEqual(expected.polarity, wait.polarity);
    try expectEqual(expected.source, wait.source);
    try expect_value(expected.num, wait.num);
}

fn ExpectedInInstr(comptime cpu: CPU) type {
    return struct {
        source: Token(cpu).Instruction.In.Source,
        bit_count: u5,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_in(comptime cpu: CPU, expected: ExpectedInInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).in, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const in = instr.payload.in;
    try expectEqual(expected.source, in.source);
    try expectEqual(expected.bit_count, in.bit_count);
}

fn ExpectedOutInstr(comptime cpu: CPU) type {
    return struct {
        destination: Token(cpu).Instruction.Out.Destination,
        bit_count: u5,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_out(comptime cpu: CPU, expected: ExpectedOutInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).out, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const out = instr.payload.out;
    try expectEqual(expected.destination, out.destination);
    try expectEqual(expected.bit_count, out.bit_count);
}

const ExpectedPushInstr = struct {
    block: bool = true,
    iffull: bool = false,
    delay: ?Value = null,
    side_set: ?Value = null,
};

fn expect_instr_push(comptime cpu: CPU, expected: ExpectedPushInstr, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).push, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const push = instr.payload.push;
    try expectEqual(expected.block, push.block);
    try expectEqual(expected.iffull, push.iffull);
}

const ExpectedPullInstr = struct {
    block: bool = true,
    ifempty: bool = false,
    delay: ?Value = null,
    side_set: ?Value = null,
};

fn expect_instr_pull(comptime cpu: CPU, expected: ExpectedPullInstr, actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).pull, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const pull = instr.payload.pull;
    try expectEqual(expected.block, pull.block);
    try expectEqual(expected.ifempty, pull.ifempty);
}

fn ExpectedMovInstr(comptime cpu: CPU) type {
    return struct {
        source: Token(cpu).Instruction.Mov.Source,
        destination: Token(cpu).Instruction.Mov.Destination,
        operation: Token(cpu).Instruction.Mov.Operation = .none,
        delay: ?Value = null,
        side_set: ?Value = null,
    };
}

fn expect_instr_mov(comptime cpu: CPU, expected: ExpectedMovInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).mov, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const mov = instr.payload.mov;
    try expectEqual(expected.source, mov.source);
    try expectEqual(expected.operation, mov.operation);
    try expectEqual(expected.destination, mov.destination);
}

fn ExpectedIrqInstr(comptime cpu: CPU) type {
    return switch (cpu) {
        .RP2040 => struct {
            clear: bool,
            wait: bool,
            num: u5,
            rel: bool = false,
            delay: ?Value = null,
            side_set: ?Value = null,
        },
        .RP2350 => struct {
            clear: bool,
            wait: bool,
            num: u5,
            idxmode: u2 = 0,
            delay: ?Value = null,
            side_set: ?Value = null,
        },
    };
}

fn expect_instr_irq(comptime cpu: CPU, expected: ExpectedIrqInstr(cpu), actual: Token(cpu)) !void {
    try expectEqual(Token(cpu).Tag.instruction, @as(Token(cpu).Tag, actual.data));
    try expectEqual(PayloadTag(cpu).irq, @as(PayloadTag(cpu), actual.data.instruction.payload));

    const instr = actual.data.instruction;
    try expect_opt_value(expected.delay, instr.delay);
    try expect_opt_value(expected.side_set, instr.side_set);

    const irq = instr.payload.irq;
    try expectEqual(expected.clear, irq.clear);
    try expectEqual(expected.wait, irq.wait);
    switch (cpu) {
        .RP2040 => {
            try expectEqual(expected.rel, irq.rel);
        },
        .RP2350 => {
            // try expectEqual(expected.idxmode, irq.idxmode);
        },
    }
}

fn bounded_tokenize(comptime cpu: CPU, source: []const u8) !std.BoundedArray(Token(cpu), 256) {
    var diags: ?assembler.Diagnostics = null;
    return tokenize(cpu, source, &diags, .{}) catch |err| if (diags) |d| blk: {
        std.log.err("error at index {}: {s}", .{ d.index, d.message.slice() });
        break :blk err;
    } else err;
}

test "tokenize.empty string" {
    const tokens = try bounded_tokenize(.RP2040, "");
    try expectEqual(@as(usize, 0), tokens.len);
}

test "tokenize.whitespace" {
    const tokens = try bounded_tokenize(.RP2040, " \t\r\n");
    try expectEqual(@as(usize, 0), tokens.len);
}

test "tokenize.comma line comment" {
    const tokens = try bounded_tokenize(.RP2040, "; this is a line comment");

    try expectEqual(@as(usize, 0), tokens.len);
}

test "tokenize.slash line comment" {
    const tokens = try bounded_tokenize(.RP2040, "// this is a line comment");

    try expectEqual(@as(usize, 0), tokens.len);
}

test "tokenize.block comment" {
    const tokens = try bounded_tokenize(.RP2040,
        \\/* this is
        \\   a block comment */
    );

    try expectEqual(@as(usize, 0), tokens.len);
}

test "tokenize.code block" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format,
            \\% c-sdk {
            \\   int foo;
            \\%}
        );

        try expectEqual(@as(usize, 0), tokens.len);
    }
}

test "tokenize.directive.program" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".program arst");
        try expect_program(format, "arst", tokens.get(0));
    }
}

test "tokenize.directive.define" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".define symbol_name 1");
        try expect_define(format, .{
            .name = "symbol_name",
            .value = .{ .expression = "1" },
            .index = 8,
        }, tokens.get(0));
    }
}

test "tokenize.directive.define.public" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".define public symbol_name 0x1");
        try expect_define(format, .{
            .name = "symbol_name",
            .value = .{ .expression = "0x1" },
            .index = 15,
        }, tokens.get(0));
    }
}

test "tokenize.directive.define.with expression" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format,
            \\.define symbol_name 0x1
            \\.define something (symbol_name * 2)
        );

        try expect_define(format, .{
            .name = "symbol_name",
            .value = .{ .expression = "0x1" },
            .index = 8,
        }, tokens.get(0));

        try expect_define(format, .{
            .name = "something",
            .value = .{ .expression = "(symbol_name * 2)" },
            .index = 32,
        }, tokens.get(1));
    }
}

test "tokenize.directive.origin" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".origin 0x10");
        try expect_origin(format, .{ .integer = 0x10 }, tokens.get(0));
    }
}

test "tokenize.directive.side_set" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".side_set 1");
        try expect_side_set(format, .{ .count = .{ .integer = 1 } }, tokens.get(0));
    }
}

test "tokenize.directive.side_set.opt" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".side_set 1 opt");
        try expect_side_set(format, .{ .count = .{ .integer = 1 }, .opt = true }, tokens.get(0));
    }
}

test "tokenize.directive.side_set.pindirs" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".side_set 1 pindirs");
        try expect_side_set(format, .{ .count = .{ .integer = 1 }, .pindir = true }, tokens.get(0));
    }
}

test "tokenize.directive.wrap_target" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".wrap_target");
        try expect_wrap_target(format, tokens.get(0));
    }
}

test "tokenize.directive.wrap" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".wrap");
        try expect_wrap(format, tokens.get(0));
    }
}

test "tokenize.directive.lang_opt" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".lang_opt c flag foo");
        try expect_lang_opt(format, .{ .lang = "c", .name = "flag", .option = "foo" }, tokens.get(0));
    }
}

test "tokenize.directive.word" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, ".word 0xaaaa");
        try expect_word(format, .{ .integer = 0xaaaa }, tokens.get(0));
    }
}

test "tokenize.label" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, "my_label:");
        try expect_label(format, .{ .name = "my_label" }, tokens.get(0));
    }
}

test "tokenize.label.public" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, "public my_label:");
        try expect_label(format, .{ .name = "my_label", .public = true }, tokens.get(0));
    }
}

test "tokenize.instr.nop" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, "nop");
        try expect_instr_nop(format, .{}, tokens.get(0));
    }
}

test "tokenize.instr.jmp.label" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, "jmp my_label");
        try expect_instr_jmp(format, .{ .target = "my_label" }, tokens.get(0));
    }
}

test "tokenize.instr.jmp.value" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const tokens = try bounded_tokenize(format, "jmp 0x2");
        try expect_instr_jmp(format, .{ .target = "0x2" }, tokens.get(0));
    }
}

test "tokenize.instr.jmp.conditions" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        const Condition = Token(format).Instruction.Jmp.Condition;
        const cases = std.StaticStringMap(Condition).initComptime(.{
            .{ "!x", .x_is_zero },
            .{ "x--", .x_dec },
            .{ "!y", .y_is_zero },
            .{ "y--", .y_dec },
            .{ "x!=y", .x_is_not_y },
            .{ "pin", .pin },
            .{ "!osre", .osre_not_empty },
        });

        inline for (comptime cases.keys(), comptime cases.values()) |op, cond| {
            const tokens = try bounded_tokenize(format, comptime std.fmt.comptimePrint("jmp {s} my_label", .{op}));

            try expect_instr_jmp(format, .{ .cond = cond, .target = "my_label" }, tokens.get(0));
        }
    }
}

test "tokenize.instr.wait" {
    inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
        inline for (.{ "gpio", "pin", "irq" }) |source| {
            const tokens = try bounded_tokenize(format, comptime std.fmt.comptimePrint("wait 0 {s} 1", .{source}));
            try expect_instr_wait(format, .{
                .polarity = 0,
                .source = @field(Token(format).Instruction.Wait.Source, source),
                .num = .{ .integer = 1 },
            }, tokens.get(0));
        }
    }
}

test "tokenize.instr.wait.irq.rel" {
    const tokens = try bounded_tokenize(.RP2040, "wait 1 irq 1 rel");
    try expect_instr_wait(.RP2040, .{
        .polarity = 1,
        .source = .irq,
        .num = .{ .integer = 1 },
        .rel = true,
    }, tokens.get(0));
}

test "tokenize.instr.in" {
    inline for (.{
        "pins",
        "x",
        "y",
        "null",
        "isr",
        "osr",
    }, 1..) |source, bit_count| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("in {s}, {}", .{
            source,
            bit_count,
        }));

        try expect_instr_in(.RP2040, .{
            .source = @field(Token(.RP2040).Instruction.In.Source, source),
            .bit_count = @as(u5, @intCast(bit_count)),
        }, tokens.get(0));
    }
}

test "tokenize.instr.out" {
    inline for (.{
        "pins",
        "x",
        "y",
        "null",
        "pindirs",
        "pc",
        "isr",
        "exec",
    }, 1..) |destination, bit_count| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("out {s}, {}", .{
            destination,
            bit_count,
        }));

        try expect_instr_out(.RP2040, .{
            .destination = @field(Token(.RP2040).Instruction.Out.Destination, destination),
            .bit_count = @as(u5, @intCast(bit_count)),
        }, tokens.get(0));
    }
}

test "tokenize.instr.push" {
    const tokens = try bounded_tokenize(.RP2040, "push");
    try expect_instr_push(.RP2040, .{}, tokens.get(0));
}

test "tokenize.instr.push.block" {
    const tokens = try bounded_tokenize(.RP2040, "push block");
    try expect_instr_push(.RP2040, .{
        .block = true,
    }, tokens.get(0));
}

test "tokenize.instr.push.noblock" {
    const tokens = try bounded_tokenize(.RP2040, "push noblock");
    try expect_instr_push(.RP2040, .{
        .block = false,
    }, tokens.get(0));
}

test "tokenize.instr.push.iffull" {
    const tokens = try bounded_tokenize(.RP2040, "push iffull noblock");
    try expect_instr_push(.RP2040, .{
        .block = false,
        .iffull = true,
    }, tokens.get(0));
}

test "tokenize.instr.pull" {
    const tokens = try bounded_tokenize(.RP2040, "pull");
    try expect_instr_pull(.RP2040, .{}, tokens.get(0));
}

test "tokenize.instr.pull.block" {
    const tokens = try bounded_tokenize(.RP2040, "pull block");
    try expect_instr_pull(.RP2040, .{
        .block = true,
    }, tokens.get(0));
}

test "tokenize.instr.pull.noblock" {
    const tokens = try bounded_tokenize(.RP2040, "pull noblock");
    try expect_instr_pull(.RP2040, .{
        .block = false,
    }, tokens.get(0));
}

test "tokenize.instr.pull.ifempty" {
    const tokens = try bounded_tokenize(.RP2040, "pull ifempty noblock");
    try expect_instr_pull(.RP2040, .{
        .block = false,
        .ifempty = true,
    }, tokens.get(0));
}

test "tokenize.instr.mov" {
    inline for (.{
        "pins",
        "x",
        "y",
        "null",
        "status",
        "isr",
        "osr",
    }) |source| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("mov x {s}", .{source}));

        try expect_instr_mov(.RP2040, .{
            .source = @field(Token(.RP2040).Instruction.Mov.Source, source),
            .destination = .x,
        }, tokens.get(0));
    }

    inline for (.{
        "pins",
        "x",
        "y",
        "exec",
        "pc",
        "isr",
        "osr",
    }) |dest| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("mov {s} x", .{dest}));

        try expect_instr_mov(.RP2040, .{
            .source = .x,
            .destination = @field(Token(.RP2040).Instruction.Mov.Destination, dest),
        }, tokens.get(0));
    }

    const Operation = Token(.RP2040).Instruction.Mov.Operation;
    const operations = std.StaticStringMap(Operation).initComptime(.{
        .{ "!", .invert },
        .{ "~", .invert },
        .{ "::", .bit_reverse },
    });

    inline for (.{ "", " " }) |space| {
        inline for (comptime operations.keys(), comptime operations.values()) |str, operation| {
            const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("mov x {s}{s}y", .{
                str,
                space,
            }));

            try expect_instr_mov(.RP2040, .{
                .destination = .x,
                .operation = operation,
                .source = .y,
            }, tokens.get(0));
        }
    }
}

test "tokenize.instr.irq" {
    const ClearWait = struct {
        clear: bool,
        wait: bool,
    };

    const modes = std.StaticStringMap(ClearWait).initComptime(.{
        .{ "", .{ .clear = false, .wait = false } },
        .{ "set", .{ .clear = false, .wait = false } },
        .{ "nowait", .{ .clear = false, .wait = false } },
        .{ "wait", .{ .clear = false, .wait = true } },
        .{ "clear", .{ .clear = true, .wait = false } },
    });

    inline for (comptime modes.keys(), comptime modes.values(), 0..) |key, value, num| {
        inline for (comptime .{ CPU.RP2040, CPU.RP2350 }) |format| {
            const tokens = try bounded_tokenize(format, comptime std.fmt.comptimePrint("irq {s} {}", .{
                key,
                num,
            }));

            try expect_instr_irq(format, .{
                .clear = value.clear,
                .wait = value.wait,
                .num = num,
            }, tokens.get(0));
        }
    }
}

test "tokenize.instr.irq.rel" {
    const tokens = try bounded_tokenize(.RP2040, "irq set 2 rel");
    // TODO: rp2350 support
    try expect_instr_irq(.RP2040, .{
        .clear = false,
        .wait = false,
        .num = 2,
        .rel = true,
    }, tokens.get(0));
}

test "tokenize.instr.set" {
    inline for (.{
        "pins",
        "x",
        "y",
        "pindirs",
    }) |dest| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("set {s}, 2", .{dest}));
        try expect_instr_set(.RP2040, .{
            .dest = @field(Token(.RP2040).Instruction.Set.Destination, dest),
            .value = .{ .integer = 2 },
        }, tokens.get(0));
    }
}

test "tokenize.instr.set.with expression including define" {
    const tokens = try bounded_tokenize(.RP2040, "set X, (NUM_CYCLES - 1)         ; initialise the loop counter");
    try expect_instr_set(.RP2040, .{
        .dest = .x,
        .value = .{ .expression = "(NUM_CYCLES - 1)" },
    }, tokens.get(0));
}

const instruction_examples = .{
    "nop",
    "jmp arst",
    "wait 0 gpio 1",
    "in pins, 2",
    "out pc, 1",
    "push",
    "pull",
    "mov x y",
    "irq 1",
    "set pins 2",
};

test "tokenize.instr.label prefixed" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("my_label: {s}", .{instr}));
        try expectEqual(@as(usize, 2), tokens.len);
        try expect_label(.RP2040, .{ .name = "my_label" }, tokens.get(0));
    }
}

test "tokenize.instr.side_set" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} side 0", .{instr}));
        const token = tokens.get(0);
        try expect_value(.{
            .expression = "0",
        }, token.data.instruction.side_set.?);
        try expectEqual(@as(?Value, null), token.data.instruction.delay);
    }
}

test "tokenize.instr.delay" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} [1]", .{instr}));
        const token = tokens.get(0);
        try expectEqual(@as(?Value, null), token.data.instruction.side_set);
        try expect_value(.{
            .expression = "1",
        }, token.data.instruction.delay.?);
    }
}

test "tokenize.instr.delay.expression" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} [T-1]", .{instr}));
        const token = tokens.get(0);
        try expectEqual(@as(?Value, null), token.data.instruction.side_set);
        try expect_value(.{
            .expression = "T-1",
        }, token.data.instruction.delay.?);
    }
}

test "tokenize.instr.side_set.expression" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} side (N-1)", .{instr}));
        const token = tokens.get(0);
        try expect_value(.{
            .expression = "(N-1)",
        }, token.data.instruction.side_set.?);
        try expectEqual(@as(?Value, null), token.data.instruction.delay);
    }
}

test "tokenize.instr.side_set and delay" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} side 1 [2]", .{instr}));
        const token = tokens.get(0);
        try expect_value(.{
            .expression = "1",
        }, token.data.instruction.side_set.?);
        try expect_value(.{
            .expression = "2",
        }, token.data.instruction.delay.?);
    }
}

test "tokenize.instr.side_set and delay reversed" {
    inline for (instruction_examples) |instr| {
        const tokens = try bounded_tokenize(.RP2040, comptime std.fmt.comptimePrint("{s} [2] side 1", .{instr}));
        const token = tokens.get(0);
        try expect_value(.{
            .expression = "1",
        }, token.data.instruction.side_set.?);
        try expect_value(.{
            .expression = "2",
        }, token.data.instruction.delay.?);
    }
}

test "tokenize.instr.comment with no whitespace" {
    const tokens = try bounded_tokenize(.RP2040, "nop side 0x0 [1]; CSn front porch");
    try expect_instr_nop(.RP2040, .{
        .side_set = .{ .expression = "0x0" },
        .delay = .{ .expression = "1" },
    }, tokens.get(0));
}
