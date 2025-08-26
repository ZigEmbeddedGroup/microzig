//! Expressions for PIO are weird. The documentation states that an expression,
//! when used as a "value", requires parenthesis. However the official PIO
//! assembler allows for defines with a value of `::1` which is an expression.
//!
//! Annoyingly, looking at the parser, it seems that it supports a number of
//! other operations not covered in the documentation.
ops: BoundedOperations,
values: BoundedValues,

const std = @import("std");
const assert = std.debug.assert;

const assembler = @import("../assembler.zig");
const Diagnostics = assembler.Diagnostics;

const encoder = @import("encoder.zig");
const DefineWithIndex = encoder.DefineWithIndex;

const BoundedArray = @import("bounded-array").BoundedArray;

const Expression = @This();
const BoundedOperations = BoundedArray(OperationWithIndex, 32);
const BoundedValues = BoundedArray(Value, 32);

const Value = struct {
    str: []const u8,
    index: u32,
};

const OperationWithIndex = struct {
    op: Operation,
    index: u32,
};

const call_depth_max = 64;

pub const Operation = enum {
    add,
    sub,
    mul,
    div,
    negative,
    bit_reverse,
    value,
    // operations shown in pioasm's parser:
    // - OR
    // - AND
    // - XOR

    pub fn format(
        op: Operation,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;
        try writer.print("{s}", .{switch (op) {
            .add => "add",
            .sub => "sub",
            .mul => "mul",
            .div => "div",
            .negative => "neg",
            .bit_reverse => "rev",
            .value => "val",
        }});
    }
};

pub fn tokenize(
    str: []const u8,
    /// starting index of the expression
    index: u32,
    diags: *?Diagnostics,
) !Expression {
    var ops = BoundedOperations.init(0) catch unreachable;
    var values = BoundedValues.init(0) catch unreachable;

    const call_depth: u32 = 0;
    try recursive_tokenize(call_depth, &ops, &values, str, index, diags);
    return Expression{
        .ops = ops,
        .values = values,
    };
}

const TrimResult = struct {
    str: []const u8,
    index: u32,

    fn default(str: []const u8) TrimResult {
        return TrimResult{
            .str = str,
            .index = 0,
        };
    }
};

fn trim_outer_parenthesis(str: []const u8) TrimResult {
    // if the outer characters (not including whitespace) are parenthesis, then include the inside string

    // scan the prefix
    const start: usize = for (str, 0..) |c, i| {
        switch (c) {
            ' ',
            '\t',
            => {},
            '(' => break i + 1,
            else => return TrimResult.default(str),
        }
    } else return TrimResult.default(str);

    const end: usize = blk: {
        var i = str.len - 1;
        break :blk while (i > 0) : (i -= 1) {
            switch (str[i]) {
                ' ',
                '\t',
                => {},
                ')' => break i,
                else => return TrimResult.default(str),
            }
        } else return TrimResult.default(str);
    };

    return TrimResult{
        .str = str[start..end],
        .index = @as(u32, @intCast(start)),
    };
}

fn recursive_tokenize(
    call_depth: u32,
    ops: *BoundedOperations,
    values: *BoundedValues,
    str: []const u8,
    index: u32,
    diags: *?Diagnostics,
) !void {
    assert(call_depth < call_depth_max);
    const trim_result = trim_outer_parenthesis(str);
    const expr_str = trim_result.str;
    const expr_index = index + trim_result.index;

    var parenthesis_found = false;
    var depth: u32 = 0;
    var i = @as(i32, @intCast(expr_str.len - 1));
    outer: while (i >= 0) : (i -= 1) {
        const idx = @as(u32, @intCast(i));
        // TODO: how about if the expression is fully enveloped in parenthesis?
        switch (expr_str[idx]) {
            ')' => {
                depth += 1;
                parenthesis_found = true;
                continue :outer;
            },
            '(' => {
                if (depth == 0) {
                    diags.* = Diagnostics.init(expr_index + idx, "mismatched parenthesis", .{});
                    return error.MismatchedParenthesis;
                }

                depth -= 1;
                parenthesis_found = true;
                if (depth != 0)
                    continue :outer;
            },
            else => if (depth > 0)
                continue :outer,
        }

        const op: Operation = switch (expr_str[idx]) {
            '+' => .add,
            // needs context to determine if it's a negative or subtraction
            '-' => blk: {
                // it's negative if we have nothing to the left. If an operator
                // is found to the left we continue
                const is_negative = (i == 0) or is_negative: {
                    var j = i - 1;
                    while (j >= 0) : (j -= 1) {
                        const jdx = @as(u32, @intCast(j));
                        switch (expr_str[jdx]) {
                            ' ', '\t' => continue,
                            '+', '-', '*', '/' => continue :outer,
                            else => break :is_negative false,
                        }
                    }

                    break :is_negative true;
                };

                if (is_negative) {
                    try ops.append(.{
                        .op = .negative,
                        .index = expr_index + idx,
                    });
                    try recursive_tokenize(call_depth + 1, ops, values, expr_str[idx + 1 ..], expr_index + idx + 1, diags);
                    return;
                }

                break :blk .sub;
            },
            '*' => .mul,
            '/' => .div,
            ':' => {
                const is_bit_reverse = (i != 0) and expr_str[idx - 1] == ':';
                if (is_bit_reverse) {
                    try ops.append(.{
                        .op = .bit_reverse,
                        .index = expr_index + idx - 1,
                    });
                    try recursive_tokenize(call_depth + 1, ops, values, expr_str[idx + 1 ..], expr_index + idx + 1, diags);
                    i -= 1;
                    return;
                }

                return error.InvalidBitReverse;
            },
            else => continue,
        };

        try ops.append(.{
            .op = op,
            .index = expr_index + idx,
        });
        try recursive_tokenize(call_depth + 1, ops, values, expr_str[idx + 1 ..], expr_index + idx + 1, diags);
        try recursive_tokenize(call_depth + 1, ops, values, expr_str[0..idx], expr_index, diags);
        return;
    } else if (parenthesis_found) {
        try recursive_tokenize(call_depth + 1, ops, values, expr_str, expr_index, diags);
    } else {
        // if we hit this path, then the full string has been scanned, and no operators
        const trimmed = std.mem.trim(u8, expr_str, " \t");
        const value_index = expr_index + @as(u32, @intCast(std.mem.indexOf(u8, expr_str, trimmed).?));
        try ops.append(.{
            .op = .value,
            .index = value_index,
        });

        try values.append(.{
            .str = trimmed,
            .index = value_index,
        });
    }

    if (depth != 0) {
        diags.* = Diagnostics.init(expr_index + @as(u32, @intCast(i)), "mismatched parenthesis", .{});
        return error.MismatchedParenthesis;
    }
}

const EvaluatedValue = struct {
    num: i128,
    index: u32,

    pub fn format(
        eval_value: EvaluatedValue,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;
        try writer.print("{}", .{eval_value.num});
    }
};

pub fn evaluate(
    self: Expression,
    define_lists: []const []const DefineWithIndex,
    diags: *?Diagnostics,
) !i128 {
    var values = BoundedArray(EvaluatedValue, 32).init(0) catch unreachable;
    // parse/extract values into numbers
    for (self.values.slice()) |entry| {
        const value: EvaluatedValue = if (std.fmt.parseInt(i128, entry.str, 0)) |num| .{
            .num = num,
            .index = entry.index,
        } else |_| blk: {
            // if it fails, try looking up the strings in definitions
            for (define_lists) |define_list|
                for (define_list) |define|
                    if (std.mem.eql(u8, define.name, entry.str))
                        break :blk .{
                            .num = define.value,
                            .index = define.index,
                        };

            diags.* = Diagnostics.init(entry.index, "value doesn't parse as an integer, or define not found", .{});
            return error.UnresolvedValue;
        };

        try values.append(value);
    }

    return if (self.ops.len == 1) blk: {
        assert(self.values.len == 1);
        assert(self.ops.get(0).op == .value);

        break :blk values.get(0).num;
    } else blk: {
        const result = try recursive_evaluate(0, self.ops.slice(), values.slice(), diags);
        assert(result.consumed.ops == self.ops.len);
        assert(result.consumed.values == self.values.len);
        break :blk result.value;
    };
}

const RecursiveEvalResult = struct {
    value: i128,
    consumed: struct {
        ops: u32,
        values: u32,
    },
    index: u32,
};

fn recursive_evaluate(
    call_depth: u32,
    owis: []const OperationWithIndex,
    values: []const EvaluatedValue,
    diags: *?Diagnostics,
) !RecursiveEvalResult {
    assert(call_depth < call_depth_max);
    assert(owis.len != 0);
    assert(values.len != 0);

    return switch (owis[0].op) {
        .value => .{
            .value = values[0].num,
            .index = values[0].index,
            .consumed = .{
                .ops = 1,
                .values = 1,
            },
        },
        .negative => .{
            .value = -values[0].num,
            .index = values[0].index,
            .consumed = .{
                .ops = 2,
                .values = 1,
            },
        },
        .bit_reverse => blk: {
            if (values[0].num >= std.math.maxInt(u32) or
                values[0].num < std.math.minInt(i32))
            {
                diags.* = Diagnostics.init(owis[0].index, "Evaluated value does not fit in 32-bits: 0x{x}", .{values[0].num});
                return error.EvaluatedValueDoesntFit;
            }

            break :blk .{
                .value = @as(i128, @bitCast(@bitReverse(@as(u128, @bitCast(values[0].num))) >> (128 - 32))),
                .index = values[0].index,
                .consumed = .{
                    .ops = 2,
                    .values = 1,
                },
            };
        },
        .add, .sub, .mul, .div => blk: {
            const rhs = try recursive_evaluate(call_depth + 1, owis[1..], values, diags);
            const lhs = try recursive_evaluate(call_depth + 1, owis[1 + rhs.consumed.ops ..], values[rhs.consumed.values..], diags);
            break :blk .{
                .consumed = .{
                    .ops = 1 + lhs.consumed.ops + rhs.consumed.ops,
                    .values = lhs.consumed.values + rhs.consumed.values,
                },
                .index = lhs.index,
                .value = switch (owis[0].op) {
                    .add => lhs.value + rhs.value,
                    .sub => lhs.value - rhs.value,
                    .mul => lhs.value * rhs.value,
                    .div => div: {
                        if (rhs.value == 0) {
                            diags.* = Diagnostics.init(owis[0].index, "divide by zero (denominator evaluates to zero)", .{});
                            return error.DivideByZero;
                        }

                        // TODO: other requirement for @divExact
                        break :div @divExact(lhs.value, rhs.value);
                    },
                    else => unreachable,
                },
            };
        },
    };
}

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

fn expect_equal_slices_of_values(
    expected: []const Value,
    actual: []const Value,
) !void {
    for (expected, actual) |e, a| {
        try expectEqualStrings(e.str, a.str);
        try expectEqual(e.index, a.index);
    }
}

fn expect_equal_slices_of_ops(
    expected: []const OperationWithIndex,
    actual: []const OperationWithIndex,
) !void {
    for (expected, actual) |e, a| {
        try expectEqual(e.op, a.op);
        try expectEqual(e.index, a.index);
    }
}

test "expr.tokenize.integer" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.integer.parenthesis" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("(1)", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 1, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 1, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.integer.double parenthesis" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("((1))", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 2, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.symbol" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("BAR", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 0, .str = "BAR" },
    }, expr.values.slice());
}

test "expr.tokenize.add" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 + 2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .add },
        .{ .index = 4, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 4, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.add.chain" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 + 2 + 3", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 6, .op = .add },
        .{ .index = 8, .op = .value },
        .{ .index = 2, .op = .add },
        .{ .index = 4, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 8, .str = "3" },
        .{ .index = 4, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.sub" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 - 2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .sub },
        .{ .index = 4, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 4, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.sub.nospace" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1-2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 1, .op = .sub },
        .{ .index = 2, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 2, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.sub.negative" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 - -2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .sub },
        .{ .index = 4, .op = .negative },
        .{ .index = 5, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 5, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.mul" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 * 2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .mul },
        .{ .index = 4, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 4, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.div" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 / 2", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 2, .op = .div },
        .{ .index = 4, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 4, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.negative" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("-1", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 0, .op = .negative },
        .{ .index = 1, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 1, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenize.bit reverse" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("::1", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 0, .op = .bit_reverse },
        .{ .index = 2, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 2, .str = "1" },
    }, expr.values.slice());
}

test "expr.tokenzie.parenthesis" {
    var diags: ?Diagnostics = null;
    const expr = try tokenize("1 * (::2 + (12 / 3)) - 5", 0, &diags);

    try expect_equal_slices_of_ops(&.{
        .{ .index = 21, .op = .sub },
        .{ .index = 23, .op = .value },
        .{ .index = 2, .op = .mul },
        .{ .index = 9, .op = .add },
        .{ .index = 15, .op = .div },
        .{ .index = 17, .op = .value },
        .{ .index = 12, .op = .value },
        .{ .index = 5, .op = .bit_reverse },
        .{ .index = 7, .op = .value },
        .{ .index = 0, .op = .value },
    }, expr.ops.slice());

    try expect_equal_slices_of_values(&.{
        .{ .index = 23, .str = "5" },
        .{ .index = 17, .str = "3" },
        .{ .index = 12, .str = "12" },
        .{ .index = 7, .str = "2" },
        .{ .index = 0, .str = "1" },
    }, expr.values.slice());
}

fn evaluate_test(expected: i128, str: []const u8, define_list: []const DefineWithIndex) !void {
    var diags: ?Diagnostics = null;
    const expr = tokenize(str, 0, &diags) catch |err| {
        if (diags) |d|
            std.log.err("{}: {s}", .{ err, d.message.slice() });

        return err;
    };

    const actual = expr.evaluate(&.{define_list}, &diags) catch |err| {
        if (diags) |d|
            std.log.err("{}: {s}", .{ err, d.message.slice() })
        else
            std.log.err("{}", .{err});

        return err;
    };

    try expectEqual(expected, actual);
}

test "expr.evaluate.integer" {
    try evaluate_test(1, "1", &.{});
}

test "expr.evaluate.symbol" {
    try evaluate_test(5, "BAR", &.{
        .{
            .name = "BAR",
            .value = 5,
            .index = 0,
        },
    });
}

test "expr.evaluate.add" {
    try evaluate_test(3, "1 + 2", &.{});
    try evaluate_test(6, "1 + 2 + 3", &.{});
}

test "expr.evaluate.sub" {
    try evaluate_test(1, "2 - 1", &.{});
    try evaluate_test(1, "(NUM_CYCLES - 1)", &.{
        .{
            .name = "NUM_CYCLES",
            .value = 2,
            .index = 1,
        },
    });
}

test "expr.evaluate.mul" {
    try evaluate_test(9, "3 * 3", &.{});
}

test "expr.evaluate.div" {
    try evaluate_test(3, "9 / 3", &.{});
    try evaluate_test(3, "9 / 3", &.{});
}

test "expr.evaluate.negative" {
    try evaluate_test(-3, "-3", &.{});
}

test "expr.evaluate.bit reverse" {
    try evaluate_test(0x80000000, "::1", &.{});
}

test "expr.evaluate.parenthesis" {
    try evaluate_test(15, "5 * (1 + 2)", &.{});
    try evaluate_test(1 * (@bitReverse(@as(u32, 2)) + (12 / 3)) - 5, "1 * (::2 + (12 / 3)) - 5", &.{});
}
