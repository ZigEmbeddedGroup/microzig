const std = @import("std");
const assert = std.debug.assert;

const assembler = @import("../assembler.zig");
const Diagnostics = assembler.Diagnostics;

const tokenizer = @import("tokenizer.zig");
const Token = tokenizer.Token;
const Value = tokenizer.Value;

const Expression = @import("Expression.zig");

pub const Options = struct {
    max_defines: u32 = 16,
    max_programs: u32 = 16,
};

pub fn encode(
    comptime tokens: []const Token,
    diags: *?assembler.Diagnostics,
    comptime options: Options,
) !Encoder(options).Output {
    var encoder = Encoder(options).init(tokens);
    return try encoder.encode_output(diags);
}

pub const SideSet = struct {
    count: u3,
    optional: bool,
    pindir: bool,
};

pub const Define = struct {
    name: []const u8,
    value: i128,
};

pub const DefineWithIndex = struct {
    name: []const u8,
    value: i128,
    index: u32,
};

pub fn Encoder(comptime options: Options) type {
    return struct {
        output: Self.Output,
        tokens: []const Token,
        index: u32,

        const Self = @This();
        const Output = struct {
            global_defines: BoundedDefines,
            private_defines: BoundedDefines,
            programs: BoundedPrograms,
        };

        const BoundedDefines = std.BoundedArray(DefineWithIndex, options.max_defines);
        const BoundedPrograms = std.BoundedArray(BoundedProgram, options.max_programs);
        const BoundedInstructions = std.BoundedArray(Instruction, 32);
        const BoundedLabels = std.BoundedArray(Label, 32);
        const Label = struct {
            name: []const u8,
            index: u5,
            public: bool,
        };

        const BoundedProgram = struct {
            name: []const u8,
            defines: BoundedDefines,
            private_defines: BoundedDefines,
            instructions: BoundedInstructions,
            labels: BoundedLabels,
            origin: ?u5,
            side_set: ?SideSet,
            wrap_target: ?u5,
            wrap: ?u5,

            pub fn to_exported_program(comptime bounded: BoundedProgram) assembler.Program {
                comptime var program_name: [bounded.name.len]u8 = undefined;
                std.mem.copyForwards(u8, &program_name, bounded.name);
                return assembler.Program{
                    .name = &program_name,
                    .defines = blk: {
                        var tmp = std.BoundedArray(assembler.Define, options.max_defines).init(0) catch unreachable;
                        for (bounded.defines.slice()) |define| {
                            comptime var define_name: [define.name.len]u8 = undefined;
                            std.mem.copyForwards(u8, &define_name, define.name);
                            tmp.append(.{
                                .name = &define_name,
                                .value = @as(i64, @intCast(define.value)),
                            }) catch unreachable;
                        }

                        break :blk tmp.slice();
                    },
                    .instructions = @as([]const u16, @ptrCast(bounded.instructions.slice())),
                    .origin = bounded.origin,
                    .side_set = bounded.side_set,
                    .wrap_target = bounded.wrap_target,
                    .wrap = bounded.wrap,
                };
            }
        };

        fn init(tokens: []const Token) Self {
            return Self{
                .output = Self.Output{
                    .global_defines = BoundedDefines.init(0) catch unreachable,
                    .private_defines = BoundedDefines.init(0) catch unreachable,
                    .programs = BoundedPrograms.init(0) catch unreachable,
                },
                .tokens = tokens,
                .index = 0,
            };
        }

        fn peek_token(self: Self) ?Token {
            return if (self.index < self.tokens.len)
                self.tokens[self.index]
            else
                null;
        }

        fn get_token(self: *Self) ?Token {
            return if (self.peek_token()) |token| blk: {
                self.consume(1);
                break :blk token;
            } else null;
        }

        fn consume(self: *Self, count: u32) void {
            self.index += count;
        }

        fn evaluate_expr(
            define_lists: []const []const Define,
            expr: []const u8,
            index: u32,
            diags: *?Diagnostics,
        ) !i128 {
            _ = define_lists;
            _ = expr;
            _ = index;
            _ = diags;
        }

        fn evaluate_impl(
            comptime T: type,
            define_lists: []const []const DefineWithIndex,
            value: Value,
            index: u32,
            diags: *?Diagnostics,
        ) !T {
            return switch (value) {
                .integer => |int| @as(T, @intCast(int)),
                .string => |str| outer: for (define_lists) |defines| {
                    for (defines) |define| {
                        if (std.mem.eql(u8, str, define.name)) {
                            if (define.value > std.math.maxInt(T)) {
                                diags.* = Diagnostics.init(
                                    index,
                                    "{s}'s value ({}) is too large to fit in {} bits",
                                    .{ str, define.value, @bitSizeOf(T) },
                                );

                                break :outer error.TooBig;
                            }

                            break :outer @as(T, @intCast(define.value));
                        }
                    }
                } else {
                    diags.* = Diagnostics.init(index, "define '{s}' not found", .{
                        str,
                    });

                    break :outer error.DefineNotFound;
                },
                .expression => |expr_str| {
                    const expr = try Expression.tokenize(expr_str, index, diags);
                    const result = try expr.evaluate(define_lists, diags);
                    if (result < 0 or result > std.math.maxInt(T)) {
                        diags.* = Diagnostics.init(
                            index,
                            "value of {} does not fit in a u{}",
                            .{
                                result, @bitSizeOf(T),
                            },
                        );
                    }

                    return @as(T, @intCast(result));
                },
            };
        }

        fn evaluate(
            self: *Self,
            comptime T: type,
            program: BoundedProgram,
            value: Value,
            index: u32,
            diags: *?Diagnostics,
        ) !T {
            return evaluate_impl(T, &.{
                self.output.global_defines.slice(),
                self.output.private_defines.slice(),
                program.defines.slice(),
                program.private_defines.slice(),
            }, value, index, diags);
        }

        fn evaluate_target(
            self: *Self,
            program: BoundedProgram,
            target: []const u8,
            index: u32,
            diags: *?Diagnostics,
        ) !u5 {
            return for (program.labels.slice()) |label| {
                if (std.mem.eql(u8, target, label.name))
                    break label.index;
            } else try self.evaluate(u5, program, try Value.from_string(target), index, diags);
        }

        fn evaluate_global(
            self: *Self,
            comptime T: type,
            value: Value,
            index: u32,
            diags: *?Diagnostics,
        ) !T {
            return evaluate_impl(T, &.{
                self.output.global_defines.slice(),
                self.output.private_defines.slice(),
            }, value, index, diags);
        }

        fn encode_globals(self: *Self, diags: *?Diagnostics) !void {
            assert(self.index == 0);

            // read defines until program is had
            while (self.peek_token()) |token| switch (token.data) {
                .define => |define| {
                    const result = DefineWithIndex{
                        .name = define.name,
                        .value = try self.evaluate_global(i128, define.value, token.index, diags),
                        .index = define.index,
                    };

                    if (define.public)
                        try self.output.global_defines.append(result)
                    else
                        try self.output.private_defines.append(result);

                    self.consume(1);
                },
                .program => break,
                else => return error.InvalidTokenInGlobalSpace,
            };
        }

        fn encode_program_init(self: *Self, program: *BoundedProgram, diags: *?Diagnostics) !void {
            while (self.peek_token()) |token| {
                switch (token.data) {
                    .program, .label, .instruction, .word, .wrap_target => break,
                    .define => |define| {
                        const result = DefineWithIndex{
                            .name = define.name,
                            .value = try self.evaluate(i128, program.*, define.value, token.index, diags),
                            .index = define.index,
                        };

                        if (define.public)
                            try program.defines.append(result)
                        else
                            try program.private_defines.append(result);

                        self.consume(1);
                    },
                    .origin => |value| {
                        program.origin = try self.evaluate(u5, program.*, value, token.index, diags);
                        self.consume(1);
                    },
                    .side_set => |side_set| {
                        program.side_set = .{
                            .count = try self.evaluate(u3, program.*, side_set.count, token.index, diags),
                            .optional = side_set.opt,
                            .pindir = side_set.pindir,
                        };
                        self.consume(1);
                    },
                    // ignore
                    .lang_opt => self.consume(1),
                    .wrap => unreachable,
                }
            }
        }

        fn encode_instruction(
            self: *Self,
            program: *BoundedProgram,
            token: Token.Instruction,
            token_index: u32,
            diags: *?Diagnostics,
        ) !void {
            // guaranteed to be an instruction variant
            const payload: Instruction.Payload = switch (token.payload) {
                .nop => .{
                    .mov = .{
                        .destination = .y,
                        .operation = .none,
                        .source = .y,
                    },
                },
                .jmp => |jmp| .{
                    .jmp = .{
                        .condition = jmp.condition,
                        .address = try self.evaluate_target(program.*, jmp.target, token_index, diags),
                    },
                },
                .wait => |wait| .{
                    .wait = .{
                        .polarity = wait.polarity,
                        .source = wait.source,
                        .index = try self.evaluate(u5, program.*, wait.num, token_index, diags),
                    },
                },
                .in => |in| .{
                    .in = .{
                        .source = in.source,
                        .bit_count = in.bit_count,
                    },
                },
                .out => |out| .{
                    .out = .{
                        .destination = out.destination,
                        .bit_count = out.bit_count,
                    },
                },
                .push => |push| .{
                    .push = .{
                        .if_full = @intFromBool(push.iffull),
                        .block = @intFromBool(push.block),
                    },
                },
                .pull => |pull| .{
                    .pull = .{
                        .if_empty = @intFromBool(pull.ifempty),
                        .block = @intFromBool(pull.block),
                    },
                },
                .mov => |mov| .{
                    .mov = .{
                        .destination = mov.destination,
                        .operation = mov.operation,
                        .source = mov.source,
                    },
                },
                .irq => |irq| blk: {
                    const irq_num = try self.evaluate(u5, program.*, irq.num, token_index, diags);
                    break :blk .{
                        .irq = .{
                            .clear = @intFromBool(irq.clear),
                            .wait = @intFromBool(irq.wait),
                            .index = if (irq.rel)
                                @as(u5, 0x10) | irq_num
                            else
                                irq_num,
                        },
                    };
                },
                .set => |set| .{
                    .set = .{
                        .destination = set.destination,
                        .data = try self.evaluate(u5, program.*, set.value, token_index, diags),
                    },
                },
            };

            const tag: Instruction.Tag = switch (token.payload) {
                .nop => .mov,
                .jmp => .jmp,
                .wait => .wait,
                .in => .in,
                .out => .out,
                .push => .push_pull,
                .pull => .push_pull,
                .mov => .mov,
                .irq => .irq,
                .set => .set,
            };

            if (program.side_set) |side_set| {
                if (!side_set.optional and token.side_set == null) {
                    diags.* = Diagnostics.init(token_index, "'side' must be specified for this instruction because 'opt' was not specied in the .side_set directive", .{});
                    return error.InvalidSideSet;
                }
            } else {
                if (token.side_set != null) {
                    diags.* = Diagnostics.init(token_index, ".side_set directive must be specified for program to use side_set", .{});
                    return error.InvalidSideSet;
                }
            }

            const side_set: ?u5 = if (token.side_set) |s|
                try self.evaluate(u5, program.*, s, token_index, diags)
            else
                null;

            const delay: ?u5 = if (token.delay) |d|
                try self.evaluate(u5, program.*, d, token_index, diags)
            else
                null;

            const delay_side_set = try calc_delay_side_set(
                program.side_set,
                side_set,
                delay,
            );

            try program.instructions.append(Instruction{
                .tag = tag,
                .payload = payload,
                .delay_side_set = delay_side_set,
            });
        }

        fn calc_delay_side_set(
            program_settings: ?SideSet,
            side_set_opt: ?u5,
            delay_opt: ?u5,
        ) !u5 {
            // TODO: error for side_set/delay collision
            const delay: u5 = if (delay_opt) |delay| delay else 0;
            return if (program_settings) |settings|
                if (settings.optional)
                    if (side_set_opt) |side_set|
                        0x10 | (side_set << @as(u3, 4) - settings.count) | delay
                    else
                        delay
                else
                    (side_set_opt.? << @as(u3, 5) - settings.count) | delay
            else
                delay;
        }

        fn encode_instruction_body(self: *Self, program: *BoundedProgram, diags: *?Diagnostics) !void {
            // first scan through body for labels
            var instr_index: u5 = 0;
            for (self.tokens[self.index..]) |token| {
                switch (token.data) {
                    .label => |label| try program.labels.append(.{
                        .name = label.name,
                        .public = label.public,
                        .index = instr_index,
                    }),
                    .instruction, .word => instr_index += 1,
                    .wrap_target => {
                        if (program.wrap_target != null) {
                            diags.* = Diagnostics.init(token.index, "wrap_target already set for this program", .{});
                            return error.WrapTargetAlreadySet;
                        }

                        program.wrap_target = instr_index;
                    },
                    .wrap => {
                        if (program.wrap != null) {
                            diags.* = Diagnostics.init(token.index, "wrap already set for this program", .{});
                            return error.WrapAlreadySet;
                        }

                        program.wrap = instr_index - 1;
                    },
                    .program => break,
                    else => unreachable, // invalid
                }
            }

            // encode instructions, labels will be populated
            for (self.tokens[self.index..], self.index..) |token, i| {
                switch (token.data) {
                    .instruction => |instr| try self.encode_instruction(program, instr, token.index, diags),
                    .word => |word| try program.instructions.append(
                        @as(Instruction, @bitCast(try self.evaluate(u16, program.*, word, token.index, diags))),
                    ),
                    // already processed
                    .label, .wrap_target, .wrap => {},
                    .program => {
                        self.index = @as(u32, @intCast(i));
                        break;
                    },

                    else => unreachable, // invalid
                }
            } else if (self.tokens.len > 0)
                self.index = @as(u32, @intCast(self.tokens.len));
        }

        fn encode_program(self: *Self, diags: *?Diagnostics) !?BoundedProgram {
            const program_token = self.get_token() orelse return null;
            if (program_token.data != .program)
                return error.ExpectedProgramToken;

            var program = BoundedProgram{
                .name = program_token.data.program,
                .defines = BoundedDefines.init(0) catch unreachable,
                .private_defines = BoundedDefines.init(0) catch unreachable,
                .instructions = BoundedInstructions.init(0) catch unreachable,
                .labels = BoundedLabels.init(0) catch unreachable,
                .side_set = null,
                .origin = null,
                .wrap_target = null,
                .wrap = null,
            };

            try self.encode_program_init(&program, diags);
            try self.encode_instruction_body(&program, diags);

            return program;
        }

        fn encode_output(self: *Self, diags: *?Diagnostics) !Self.Output {
            try self.encode_globals(diags);

            while (try self.encode_program(diags)) |program|
                try self.output.programs.append(program);

            return self.output;
        }
    };
}

pub const Instruction = packed struct(u16) {
    payload: Payload,
    delay_side_set: u5,
    tag: Tag,

    pub const Payload = packed union {
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

    pub const Tag = enum(u3) {
        jmp,
        wait,
        in,
        out,
        push_pull,
        mov,
        irq,
        set,
    };

    pub const Jmp = packed struct(u8) {
        address: u5,
        condition: Token.Instruction.Jmp.Condition,
    };

    pub const Wait = packed struct(u8) {
        index: u5,
        source: Token.Instruction.Wait.Source,
        polarity: u1,
    };

    pub const In = packed struct(u8) {
        bit_count: u5,
        source: Token.Instruction.In.Source,
    };

    pub const Out = packed struct(u8) {
        bit_count: u5,
        destination: Token.Instruction.Out.Destination,
    };

    pub const Push = packed struct(u8) {
        _reserved0: u5 = 0,
        block: u1,
        if_full: u1,
        _reserved1: u1 = 0,
    };

    pub const Pull = packed struct(u8) {
        _reserved0: u5 = 0,
        block: u1,
        if_empty: u1,
        _reserved1: u1 = 1,
    };

    pub const Mov = packed struct(u8) {
        source: Token.Instruction.Mov.Source,
        operation: Token.Instruction.Mov.Operation,
        destination: Token.Instruction.Mov.Destination,
    };

    pub const Irq = packed struct(u8) {
        index: u5,
        wait: u1,
        clear: u1,
        reserved: u1 = 0,
    };

    pub const Set = packed struct(u8) {
        data: u5,
        destination: Token.Instruction.Set.Destination,
    };
};

//==============================================================================
// Encoder Tests
//==============================================================================

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

fn encode_bounded_output_impl(source: []const u8, diags: *?assembler.Diagnostics) !Encoder(.{}).Output {
    const tokens = try tokenizer.tokenize(source, diags, .{});
    var encoder = Encoder(.{}).init(tokens.slice());
    return try encoder.encode_output(diags);
}

fn encode_bounded_output(source: []const u8) !Encoder(.{}).Output {
    var diags: ?assembler.Diagnostics = null;
    return encode_bounded_output_impl(source, &diags) catch |err| if (diags) |d| blk: {
        std.log.err("error at index {}: {s}", .{ d.index, d.message.slice() });
        break :blk err;
    } else err;
}

test "encode.define" {
    const output = try encode_bounded_output(".define foo 5");

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 1), output.private_defines.len);
    try expectEqual(@as(usize, 0), output.programs.len);

    try expectEqualStrings("foo", output.private_defines.get(0).name);
    try expectEqual(@as(i128, 5), output.private_defines.get(0).value);
}

test "encode.define.public" {
    const output = try encode_bounded_output(".define PUBLIC foo 5");

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 0), output.programs.len);
}

test "encode.program.empty" {
    const output = try encode_bounded_output(".program arst");

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    try expectEqualStrings("arst", output.programs.get(0).name);
    try expectEqual(@as(usize, 0), output.programs.get(0).instructions.len);
}

test "encode.program.define" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.define bruh 7
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqualStrings("arst", program.name);
    try expectEqual(@as(usize, 0), program.instructions.len);

    const define = program.private_defines.get(0);
    try expectEqualStrings("bruh", define.name);
    try expectEqual(@as(i128, 7), define.value);
}

test "encode.program.define.public" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.define public bruh 7
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqualStrings("arst", program.name);
    try expectEqual(@as(usize, 0), program.instructions.len);

    const define = program.defines.get(0);
    try expectEqualStrings("bruh", define.name);
    try expectEqual(@as(i128, 7), define.value);
}

test "encode.program.define.namespaced" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.define public bruh 7
        \\.program what
        \\.define public hi 8
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 2), output.programs.len);

    const program_arst = output.programs.get(0);
    try expectEqualStrings("arst", program_arst.name);
    try expectEqual(@as(usize, 0), program_arst.instructions.len);

    const define_bruh = program_arst.defines.get(0);
    try expectEqualStrings("bruh", define_bruh.name);
    try expectEqual(@as(i128, 7), define_bruh.value);

    const program_what = output.programs.get(1);
    try expectEqualStrings("what", program_what.name);
    try expectEqual(@as(usize, 0), program_what.instructions.len);

    const define_hi = program_what.defines.get(0);
    try expectEqualStrings("hi", define_hi.name);
    try expectEqual(@as(i128, 8), define_hi.value);
}

test "encode.origin" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.origin 0
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqualStrings("arst", program.name);
    try expectEqual(@as(usize, 0), program.instructions.len);

    try expectEqual(@as(?u5, 0), program.origin);
}

test "encode.wrap_target" {
    const output = try encode_bounded_output(
        \\.program arst
        \\nop
        \\.wrap_target
        \\nop
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqualStrings("arst", program.name);
    try expectEqual(@as(usize, 2), program.instructions.len);

    try expectEqual(@as(?u5, 1), program.wrap_target);
}

test "encode.wrap" {
    const output = try encode_bounded_output(
        \\.program arst
        \\nop
        \\.wrap
        \\nop
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqualStrings("arst", program.name);
    try expectEqual(@as(usize, 2), program.instructions.len);

    try expectEqual(@as(?u5, 0), program.wrap);
}

test "encode.side_set" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.side_set 1
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(?u5, 1), program.side_set.?.count);
}

test "encode.side_set.opt" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.side_set 1 opt
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(?u5, 1), program.side_set.?.count);
    try expect(program.side_set.?.optional);
}

test "encode.side_set.pindirs" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.side_set 1 pindirs
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(?u5, 1), program.side_set.?.count);
    try expect(program.side_set.?.pindir);
}

test "encode.label" {
    const output = try encode_bounded_output(
        \\.program arst
        \\nop
        \\my_label:
        \\nop
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(usize, 1), program.labels.len);

    const label = program.labels.get(0);
    try expectEqualStrings("my_label", label.name);
    try expectEqual(@as(u32, 1), label.index);
    try expectEqual(false, label.public);
}

test "encode.label.public" {
    const output = try encode_bounded_output(
        \\.program arst
        \\nop
        \\nop
        \\public my_label:
        \\nop
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(usize, 1), program.labels.len);

    const label = program.labels.get(0);
    try expectEqualStrings("my_label", label.name);
    try expectEqual(@as(u32, 2), label.index);
    try expectEqual(true, label.public);
}

test "encode.side_set.bits" {
    const output = try encode_bounded_output(
        \\.program arst
        \\.side_set 1 opt
        \\nop side 1
        \\nop [1]
        \\nop side 0 [1]
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);

    const instr0 = program.instructions.get(0);
    try expectEqual(@as(u5, 0x18), instr0.delay_side_set);

    const instr1 = program.instructions.get(1);
    try expectEqual(@as(u5, 0x1), instr1.delay_side_set);

    const instr2 = program.instructions.get(2);
    try expectEqual(@as(u5, 0x11), instr2.delay_side_set);
}

test "encode.evaluate.global" {
    const output = try encode_bounded_output(
        \\.define NUM 5
        \\.define public FOO NUM
    );

    try expectEqual(@as(usize, 1), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 5), output.global_defines.get(0).value);
}

test "encode.evaluate.addition" {
    const output = try encode_bounded_output(
        \\.define public FOO (1+5)
    );

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 6), output.global_defines.get(0).value);
}

test "encode.evaluate.subtraction" {
    const output = try encode_bounded_output(
        \\.define public FOO (5-1)
    );

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 4), output.global_defines.get(0).value);
}

test "encode.evaluate.multiplication" {
    const output = try encode_bounded_output(
        \\.define public FOO (5*2)
    );

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 10), output.global_defines.get(0).value);
}

test "encode.evaluate.division" {
    const output = try encode_bounded_output(
        \\.define public FOO (6/2)
    );

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 3), output.global_defines.get(0).value);
}

test "encode.evaluate.bit reversal" {
    const output = try encode_bounded_output(
        \\.define public FOO ::1
    );

    try expectEqual(@as(usize, 1), output.global_defines.len);
    try expectEqualStrings("FOO", output.global_defines.get(0).name);
    try expectEqual(@as(i128, 0x80000000), output.global_defines.get(0).value);
}

test "encode.jmp.label" {
    const output = try encode_bounded_output(
        \\.program arst
        \\nop
        \\my_label:
        \\nop
        \\nop
        \\jmp my_label
    );

    try expectEqual(@as(usize, 0), output.global_defines.len);
    try expectEqual(@as(usize, 0), output.private_defines.len);
    try expectEqual(@as(usize, 1), output.programs.len);

    const program = output.programs.get(0);
    try expectEqual(@as(usize, 1), program.labels.len);

    const label = program.labels.get(0);
    try expectEqualStrings("my_label", label.name);
    try expectEqual(@as(u32, 1), label.index);
    try expectEqual(false, label.public);

    const instr = program.instructions.get(3);
    try expectEqual(Instruction.Tag.jmp, instr.tag);
    try expectEqual(@as(u5, 0), instr.delay_side_set);
    try expectEqual(Token.Instruction.Jmp.Condition.always, instr.payload.jmp.condition);
    try expectEqual(@as(u5, 1), instr.payload.jmp.address);
}

//test "encode.error.duplicated program name" {}
//test "encode.error.duplicated define" {}
//test "encode.error.multiple side_set" {}
//test "encode.error.label with no instruction" {}
//test "encode.error.label with no instruction" {}

// Test Plan
// =========
//
// - .program name validation
// - .origin in program init and in program body
// - .side_set must be in the program init
// - .wrap_target must come before an instruction, defaults to start of a program
// - .wrap_target must only be used once in a program
// - .wrap must be placed after an instruction, defaults to end of a program
// - .wrap must only be used once in a program
// -
//
