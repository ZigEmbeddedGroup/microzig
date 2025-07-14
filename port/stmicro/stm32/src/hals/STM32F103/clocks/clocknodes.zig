const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;

pub const Limit = struct {
    min: f32 = 0,
    max: f32,
};

pub const MUL = struct {
    value: f32,
    limit: ?Limit = null,
    pub fn get(self: *const MUL, value: f32) f32 {
        return value * self.value;
    }
};

pub const Source = struct {
    value: f32,
    limit: ?Limit = null,
};

pub const MulFrac = struct {
    value: f32,
    limit: ?Limit = null,
    pub fn get(self: *const MulFrac, value: f32, frac: f32, max: f32) f32 {
        return value * (self.value + (frac / max));
    }
};

pub const DIV = struct {
    value: f32,
    limit: ?Limit = null,
    pub fn get(self: *const DIV, value: f32) f32 {
        return value / self.value;
    }
};

pub const ClockNodesTypes = union(enum) {
    source: Source,
    multi: usize,
    mul: MUL,
    mulfrac: MulFrac,
    div: DIV,
    output: ?Limit,
    frac: Limit,

    pub fn num_val(self: *const ClockNodesTypes) f32 {
        return switch (self.*) {
            ClockNodesTypes.source => |val| val.value,
            ClockNodesTypes.multi => |val| @floatFromInt(val),
            ClockNodesTypes.mulfrac => |val| val.value,
            ClockNodesTypes.div => |val| val.value,
            else => 0,
        };
    }
};

pub const ClockError = struct {
    receive: f32 = 0,
    limit: f32 = 0,
    node: *const ClockNode,
};

pub const ClockState = union(enum) {
    Ok: f32,
    Overflow: ClockError,
    Underflow: ClockError,
    NoParent: ClockError,
};

pub const ClockNode = struct {
    const Self = *const @This();
    name: []const u8,
    Nodetype: ClockNodesTypes,
    parents: ?[]const *const ClockNode = null,

    pub fn get(self: Self) ClockState {
        switch (self.Nodetype) {
            .source => |node| {
                return self.source(&node);
            },
            .multi => |node| {
                return self.multi(node);
            },
            .mul => |node| {
                return self.mul(&node);
            },
            .mulfrac => |node| {
                return self.mulfrac(&node);
            },
            .div => |node| {
                return self.div(&node);
            },
            .frac => |frac| {
                return self.output(frac);
            },
            .output => |out_val| {
                return self.output(out_val);
            },
        }
    }

    pub fn get_value(self: Self) !f32 {
        switch (self.get()) {
            .Ok => |val| {
                return val;
            },
            else => return error.InvalidOutput,
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
        if (node.parents) |parents| {
            switch (node.Nodetype) {
                .mul, .div, .mulfrac, .output => {
                    return parents[0];
                },
                .multi => |val| {
                    const index = val;
                    if (parents.len > index) {
                        return parents[index];
                    }
                },
                else => {},
            }
        }
        return null;
    }

    fn print_comptime_error(comptime err: ClockState) noreturn {
        comptime {
            const name = get_name_from_error(err);
            const error_msg = switch (err) {
                .NoParent => "No Parent list!",
                .Overflow => |data| comptimePrint("Overflow | Received: {d} max: {d}", .{ data.receive, data.limit }),
                .Underflow => |data| comptimePrint("Underflow | Received: {d} min: {d}", .{ data.receive, data.limit }),
                else => unreachable,
            };
            const main_msg = comptimePrint("Error on node {s} => {s}\n", .{ name, error_msg });
            switch (err) {
                .NoParent => @compileError(main_msg),
                .Overflow, .Underflow => |node| {
                    const parent = get_parent(node.node) orelse unreachable;
                    const tree = comptimePrint("TREE TRACE: {s} -> {s}: {d} <- ERROR\n\n", .{ print_tree(parent), node.node.name, node.receive });
                    @compileError(comptimePrint("{s}{s}", .{ main_msg, tree }));
                },
                else => unreachable,
            }
        }
    }

    fn get_name_from_error(err: ClockState) []const u8 {
        switch (err) {
            .NoParent, .Overflow, .Underflow => |clk| {
                return clk.node.name;
            },
            else => unreachable,
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
        const value = parent.get_value() catch unreachable;

        const type_data = switch (node.Nodetype) {
            .div => |data| comptimePrint("{d}/{d}", .{ value, data.value }),
            .mul => |data| comptimePrint("{d} * {d}", .{ value, data.value }),
            .output, .source => comptimePrint("{d}", .{value}),
            .multi => comptimePrint("{s}", .{parent.name}),
            .mulfrac => comptimePrint("{d} * ({s})", .{ value, print_multi_frac(node) }),
            else => unreachable,
        };

        return comptimePrint("|{s}: {s}|", .{ node.name, type_data });
    }

    fn print_multi_frac(node: *const ClockNode) []const u8 {
        const mul_val = node.Nodetype.mulfrac.value;
        const frac_val = node.parents.?[1].get_value() catch unreachable;
        const frac_max = node.parents.?[1].Nodetype.frac.max;
        return comptimePrint("{d} + ({d}/{d})", .{ mul_val, frac_val, frac_max });
    }

    fn limit_check(self: Self, value: f32, node_limit: ?Limit) ClockState {
        if (node_limit) |limit| {
            if (value > limit.max) {
                return .{
                    .Overflow = .{
                        .node = self,
                        .limit = limit.max,
                        .receive = value,
                    },
                };
            } else if (value < limit.min) {
                return .{
                    .Underflow = .{
                        .node = self,
                        .limit = limit.min,
                        .receive = value,
                    },
                };
            }
        }

        return .{ .Ok = value };
    }

    fn source(self: Self, node: *const Source) ClockState {
        const value = node.value;
        return self.limit_check(value, node.limit);
    }

    fn multi(self: Self, node: usize) ClockState {
        if (self.parents) |nodes| {
            if (nodes.len > node) {
                return nodes[node].get();
            }
        }
        return .{ .NoParent = .{ .node = self } };
    }

    fn mul(self: Self, node: *const MUL) ClockState {
        if (self.parents) |parents| {
            const value = node.value;
            const limit = self.limit_check(value, node.limit);
            switch (limit) {
                .Ok => {
                    const input = parents[0].get();
                    switch (input) {
                        .Ok => |from_input| {
                            return .{ .Ok = node.get(from_input) };
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

    fn mulfrac(self: Self, node: *const MulFrac) ClockState {
        if (self.parents) |parents| {
            if (parents.len > 2) {
                const value = node.value;
                const limit = self.limit_check(value, node.limit);
                switch (limit) {
                    .Ok => {
                        const input = parents[0].get();
                        const frac = parents[1].get();

                        switch (frac) {
                            .Ok => |from_frac| {
                                const frac_max = parents[1].Nodetype.frac.max;
                                switch (input) {
                                    .Ok => |from_input| {
                                        return .{ .Ok = node.get(
                                            from_input,
                                            from_frac,
                                            frac_max,
                                        ) };
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
        }
        return .{ .NoParent = .{ .node = self } };
    }

    fn div(self: Self, node: *const DIV) ClockState {
        if (self.parents) |parents| {
            const value = node.value;
            const limit = self.limit_check(value, node.limit);
            switch (limit) {
                .Ok => {
                    const input = parents[0].get();
                    switch (input) {
                        .Ok => |from_input| {
                            return .{ .Ok = node.get(from_input) };
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

    fn output(self: Self, limit: ?Limit) ClockState {
        if (self.parents) |parents| {
            const value = parents[0].get();
            switch (value) {
                .Ok => |ret| {
                    return self.limit_check(ret, limit);
                },
                else => return value,
            }
        }
        return .{ .NoParent = .{ .node = self } };
    }
};
