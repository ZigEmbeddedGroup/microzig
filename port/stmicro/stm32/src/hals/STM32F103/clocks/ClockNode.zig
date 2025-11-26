const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;

pub const Limit = struct {
    min: ?f32 = null,
    max: ?f32 = null,
    min_expr: ?[]const u8 = null,
    max_expr: ?[]const u8 = null,
};

pub const ClockNodesTypes = enum {
    source,
    multi,
    mul,
    mulfrac,
    div,
    output,
    frac,
    off,
};

pub const ClockError = struct {
    recive: f32 = 0,
    limit: f32 = 0,
    node: *const ClockNode,
};

pub const ClockState = union(enum) {
    Ok: f32,
    Overflow: ClockError,
    Underflow: ClockError,
    NoParent: ClockError,
    ClockOff: ClockError,
};

pub const ClockNode = struct {
    const Self = *const @This();
    name: []const u8,
    nodetype: ClockNodesTypes,
    parents: []const *const ClockNode,
    value: f32 = 0,
    limit: Limit = .{},

    pub fn get(self: Self) ClockState {
        switch (self.nodetype) {
            .source => {
                return self.source();
            },
            .multi => {
                return self.multi();
            },
            .mul => {
                return self.mul();
            },
            .mulfrac => {
                return self.mulfrac();
            },
            .div => {
                return self.div();
            },
            .frac => {
                return self.output();
            },
            .output => {
                return self.output();
            },
            .off => {
                return .{ .ClockOff = .{ .node = self } };
            },
        }
    }

    pub fn get_output(self: Self) !f32 {
        if (self.nodetype == .off) return 0;
        if (@inComptime()) @setEvalBranchQuota(10000);
        return self.get_value();
    }

    pub fn get_value(self: Self) !f32 {
        switch (self.get()) {
            .Ok => |val| {
                return val;
            },
            else => |err| {
                if (@inComptime()) {
                    print_comptime_error(err);
                }

                return switch (err) {
                    .Overflow => error.Overflow,
                    .Underflow => error.Underflow,
                    .NoParent => error.NoNodeParent,
                    .ClockOff => error.ClockOff,
                    else => unreachable,
                };
            },
        }
    }

    pub fn get_comptime(comptime self: Self) f32 {
        const ret = comptime self.get();
        switch (ret) {
            .Ok => |val| return val,
            else => |err| print_comptime_error(err),
        }
    }

    pub fn get_parent(node: *const ClockNode) ?*const ClockNode {
        switch (node.nodetype) {
            .mul, .div, .mulfrac, .output, .multi => {
                return node.parents[0];
            },
            else => {},
        }
        return null;
    }

    fn print_comptime_error(comptime err: ClockState) noreturn {
        comptime {
            const name = get_name_from_error(err);
            const error_msg = blk: {
                switch (err) {
                    .ClockOff => break :blk "Clock is not active in the current configuration",
                    .NoParent => break :blk "No Parent list!",
                    .Overflow => |data| {
                        const max_str = if (data.node.limit.max_expr) |expr| expr else "";
                        break :blk comptimePrint("Overflow | Recive: {d} max: {s}({d})", .{ data.recive, max_str, data.limit });
                    },
                    .Underflow => |data| {
                        const min_str = if (data.node.limit.min_expr) |expr| expr else "";
                        break :blk comptimePrint("Underflow | Recive: {d} min: {s}({d})", .{ data.recive, min_str, data.limit });
                    },
                    else => unreachable,
                }
            };
            const main_msg = comptimePrint("Error on node {s} => {s}\n", .{ name, error_msg });
            switch (err) {
                .NoParent => @compileError(main_msg),
                .Overflow, .Underflow, .ClockOff => |node| {
                    const parent = get_parent(node.node) orelse @compileError(main_msg);
                    const tree = comptimePrint("TREE TRACE: {s} -> {s}: {d} <- ERROR\n\n", .{ print_tree(parent), node.node.name, node.recive });
                    @compileError(comptimePrint("{s}{s}", .{ main_msg, tree }));
                },
                else => unreachable,
            }
        }
    }

    fn get_name_from_error(err: ClockState) []const u8 {
        switch (err) {
            .Ok => unreachable,
            .Overflow,
            .Underflow,
            .NoParent,
            .ClockOff,
            => |clk| {
                return clk.node.name;
            },
        }
    }

    fn print_tree(comptime node: *const ClockNode) []const u8 {
        if (get_parent(node)) |parent| {
            return comptimePrint("{s} -> {s}", .{ print_tree(parent), print_node_info(node) });
        }
        return comptimePrint("ROOT -> {s}", .{print_node_info(node)});
    }

    fn print_node_info(comptime node: *const ClockNode) []const u8 {
        const parent = get_parent(node) orelse node;
        const value = parent.get_output() catch unreachable;

        const type_data = switch (node.nodetype) {
            .div => comptimePrint("{d}/{d}", .{ value, node.value }),
            .mul => comptimePrint("{d} * {d}", .{ value, node.value }),
            .output, .source => comptimePrint("{d}", .{value}),
            .multi => comptimePrint("{s}", .{parent.name}),
            .mulfrac => comptimePrint("{d} * ({s})", .{ value, print_multi_frac(node) }),
            else => unreachable,
        };

        return comptimePrint("|{s}: {s}|", .{ node.name, type_data });
    }

    fn print_multi_frac(node: *const ClockNode) []const u8 {
        const mul_val = node.value;
        const frac_val = node.parents[1].value;
        const frac_max = node.parents[0].value;
        return comptimePrint("{d} + ({d}/{d})", .{ mul_val, frac_val, frac_max });
    }

    fn limit_check(self: Self, value: f32, node_limit: Limit) ClockState {
        if (node_limit.max) |max| {
            if (value > max) {
                return .{
                    .Overflow = .{
                        .node = self,
                        .limit = max,
                        .recive = value,
                    },
                };
            }
        }

        if (node_limit.min) |min| {
            if (value < min) {
                return .{
                    .Underflow = .{
                        .node = self,
                        .limit = min,
                        .recive = value,
                    },
                };
            }
        }

        return .{ .Ok = value };
    }

    fn source(self: Self) ClockState {
        return self.limit_check(self.value, self.limit);
    }

    fn multi(self: Self) ClockState {
        if (self.parents.len != 0) {
            return self.parents[0].get();
        }
        return .{ .NoParent = .{ .node = self } };
    }

    fn mul(self: Self) ClockState {
        if (self.parents.len != 0) {
            const value = self.value;
            const limit = self.limit_check(value, self.limit);
            switch (limit) {
                .Ok => {
                    const input = self.parents[0].get();
                    switch (input) {
                        .Ok => |from_input| {
                            return .{ .Ok = from_input * value };
                        },
                        else => {
                            return input;
                        },
                    }
                },
                else => {
                    return limit;
                },
            }
        }

        return .{ .NoParent = .{ .node = self } };
    }

    fn mulfrac(self: Self) ClockState {
        if (self.parents.len >= 2) {
            const value = self.value;
            const limit = self.limit_check(value, self.limit);
            switch (limit) {
                .Ok => {
                    const input = self.parents[0].get();
                    const frac = self.parents[1].get();

                    switch (frac) {
                        .Ok => |from_frac| {
                            const frac_max = self.parents[1].limit.max.?;
                            switch (input) {
                                .Ok => |from_input| {
                                    const ref = from_input * (self.value + (from_frac / frac_max));
                                    return .{ .Ok = ref };
                                },
                                else => return input,
                            }
                        },
                        else => return frac,
                    }
                },
                else => return limit,
            }
        }

        return .{ .NoParent = .{ .node = self } };
    }

    fn div(self: Self) ClockState {
        if (self.parents.len != 0) {
            const value = self.value;
            const limit = self.limit_check(value, self.limit);
            switch (limit) {
                .Ok => {
                    const input = self.parents[0].get();
                    switch (input) {
                        .Ok => |from_input| {
                            return .{ .Ok = from_input / value };
                        },
                        else => {
                            return input;
                        },
                    }
                },
                else => {
                    return limit;
                },
            }
        }

        return .{ .NoParent = .{ .node = self } };
    }

    fn output(self: Self) ClockState {
        if (self.parents.len != 0) {
            const value = self.parents[0].get();
            switch (value) {
                .Ok => |ret| {
                    return self.limit_check(ret, self.limit);
                },
                else => return value,
            }
        }
        return .{ .NoParent = .{ .node = self } };
    }
};

pub fn comptime_fail_or_error(err: anyerror, fmt: []const u8, args: anytype) anyerror {
    if (@inComptime()) {
        @compileError(comptimePrint(fmt, args));
    }
    return err;
}

pub const Opration = enum {
    @"=",
    @"!=",
    @">",
    @"<",
    @">=",
    @"<=",
};

pub const MathOpration = enum {
    @"+",
    @"-",
    @"/",
    @"*",
};

fn check_type(comptime T: type) ?bool {
    const info = @typeInfo(T);
    switch (info) {
        .optional => |ch| {
            if (ch.child == f32) return false;
            if (ch.child == u32) return true;
            return null;
        },
        else => {
            @compileError("check_ref must only be used on optional types");
        },
    }
}

pub fn check_ref(comptime T: type, val: T, to_check: T, op: Opration) bool {
    _ = check_type(T);

    // If both side is null, we consider the comparison true.
    if (val == null and to_check == null) return true;

    const inner = val orelse return false;
    const item = to_check orelse unreachable;

    return switch (op) {
        .@"=" => inner == item,
        .@"!=" => inner != item,
        .@">" => inner > item,
        .@"<" => inner < item,
        .@">=" => inner >= item,
        .@"<=" => inner <= item,
    };
}

pub fn math_op(comptime T: type, val: T, val2: T, op: MathOpration, owner: []const u8, op1_s: []const u8, op2_s: []const u8) !f32 {
    const t = check_type(T) orelse @compileError("math_op used on invalid type:" ++ @typeName(T));
    const op1 = val orelse try comptime_fail_or_error(error.NullValue,
        \\Error trying to evaluate the expression {s}{s}{s} on reference: {s}
        \\the value of {0s} is null.
        \\
        \\
    , .{ op1_s, @tagName(op), op2_s, owner });
    const op2 = val2 orelse try comptime_fail_or_error(error.NullValue,
        \\Error trying to evaluate the expression {s}({d}){s}{s}() on reference: {s}
        \\the value of val2 is null.
        \\
        \\
    , .{ op1_s, op1, @tagName(op), op2_s, owner });

    const n1: f32 = if (t) @floatFromInt(op1) else op1;
    const n2: f32 = if (t) @floatFromInt(op2) else op2;

    return switch (op) {
        .@"+" => {
            const ret = @addWithOverflow(n1, n2);
            if (ret.@"1" == 1) {
                try comptime_fail_or_error(error.Overflow,
                    \\Error trying to evaluate the expression {s}({d}){s}{s}({d}) on reference: {s}
                    \\Overflow.
                    \\
                    \\
                , .{ op1_s, n1, @tagName(op), op2_s, n2, owner });
            }
            return ret.@"0";
        },
        .@"-" => {
            const ret = @subWithOverflow(n1, n2);
            if (ret.@"1" == 1) {
                try comptime_fail_or_error(error.Overflow,
                    \\Error trying to evaluate the expression {s}({d}){s}{s}({d}) on reference: {s}
                    \\Underflow.
                    \\
                    \\
                , .{ op1_s, n1, @tagName(op), op2_s, n2, owner });
            }
            return ret.@"0";
        },
        .@"*" => {
            const ret = @mulWithOverflow(n1, n2);
            if (ret.@"1" == 1) {
                try comptime_fail_or_error(error.Overflow,
                    \\Error trying to evaluate the expression {s}({d}){s}{s}({d}) on reference: {s}
                    \\Overflow.
                    \\
                    \\
                , .{ op1_s, n1, @tagName(op), op2_s, n2, owner });
            }
            return ret.@"0";
        },
        .@"/" => {
            if (op2 == 0) {
                try comptime_fail_or_error(error.Divzero,
                    \\Error trying to evaluate the expression {s}({d}){s}{s}({d}) on reference: {s}
                    \\Div by zero.
                    \\
                    \\
                , .{ op1_s, n1, @tagName(op), op2_s, n2, owner });
            }
            const ret = @divExact(n1, n2);
            return ret;
        },
    };
}
