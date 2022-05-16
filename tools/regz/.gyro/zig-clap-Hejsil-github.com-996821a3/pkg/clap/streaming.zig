const builtin = @import("builtin");
const clap = @import("../clap.zig");
const std = @import("std");

const args = clap.args;
const debug = std.debug;
const heap = std.heap;
const io = std.io;
const mem = std.mem;
const os = std.os;
const testing = std.testing;

/// The result returned from Clap.next
pub fn Arg(comptime Id: type) type {
    return struct {
        const Self = @This();

        param: *const clap.Param(Id),
        value: ?[]const u8 = null,
    };
}

pub const Error = error{
    MissingValue,
    InvalidArgument,
    DoesntTakeValue,
};

/// A command line argument parser which, given an ArgIterator, will parse arguments according
/// to the params. Clap parses in an iterating manner, so you have to use a loop together with
/// Clap.next to parse all the arguments of your program.
///
/// This parser is the building block for all the more complicated parsers.
pub fn Clap(comptime Id: type, comptime ArgIterator: type) type {
    return struct {
        const State = union(enum) {
            normal,
            chaining: Chaining,
            rest_are_positional,

            const Chaining = struct {
                arg: []const u8,
                index: usize,
            };
        };

        params: []const clap.Param(Id),
        iter: *ArgIterator,
        state: State = .normal,
        positional: ?*const clap.Param(Id) = null,
        diagnostic: ?*clap.Diagnostic = null,

        /// Get the next Arg that matches a Param.
        pub fn next(parser: *@This()) !?Arg(Id) {
            switch (parser.state) {
                .normal => return try parser.normal(),
                .chaining => |state| return try parser.chaining(state),
                .rest_are_positional => {
                    const param = parser.positionalParam() orelse unreachable;
                    const value = parser.iter.next() orelse return null;
                    return Arg(Id){ .param = param, .value = value };
                },
            }
        }

        fn normal(parser: *@This()) !?Arg(Id) {
            const arg_info = (try parser.parseNextArg()) orelse return null;
            const arg = arg_info.arg;
            switch (arg_info.kind) {
                .long => {
                    const eql_index = mem.indexOfScalar(u8, arg, '=');
                    const name = if (eql_index) |i| arg[0..i] else arg;
                    const maybe_value = if (eql_index) |i| arg[i + 1 ..] else null;

                    for (parser.params) |*param| {
                        const match = param.names.long orelse continue;

                        if (!mem.eql(u8, name, match))
                            continue;
                        if (param.takes_value == .none) {
                            if (maybe_value != null)
                                return parser.err(arg, .{ .long = name }, Error.DoesntTakeValue);

                            return Arg(Id){ .param = param };
                        }

                        const value = blk: {
                            if (maybe_value) |v|
                                break :blk v;

                            break :blk parser.iter.next() orelse
                                return parser.err(arg, .{ .long = name }, Error.MissingValue);
                        };

                        return Arg(Id){ .param = param, .value = value };
                    }

                    return parser.err(arg, .{ .long = name }, Error.InvalidArgument);
                },
                .short => return try parser.chaining(.{
                    .arg = arg,
                    .index = 0,
                }),
                .positional => if (parser.positionalParam()) |param| {
                    // If we find a positional with the value `--` then we
                    // interpret the rest of the arguments as positional
                    // arguments.
                    if (mem.eql(u8, arg, "--")) {
                        parser.state = .rest_are_positional;
                        const value = parser.iter.next() orelse return null;
                        return Arg(Id){ .param = param, .value = value };
                    }

                    return Arg(Id){ .param = param, .value = arg };
                } else {
                    return parser.err(arg, .{}, Error.InvalidArgument);
                },
            }
        }

        fn chaining(parser: *@This(), state: State.Chaining) !?Arg(Id) {
            const arg = state.arg;
            const index = state.index;
            const next_index = index + 1;

            for (parser.params) |*param| {
                const short = param.names.short orelse continue;
                if (short != arg[index])
                    continue;

                // Before we return, we have to set the new state of the clap
                defer {
                    if (arg.len <= next_index or param.takes_value != .none) {
                        parser.state = .normal;
                    } else {
                        parser.state = .{
                            .chaining = .{
                                .arg = arg,
                                .index = next_index,
                            },
                        };
                    }
                }

                const next_is_eql = if (next_index < arg.len) arg[next_index] == '=' else false;
                if (param.takes_value == .none) {
                    if (next_is_eql)
                        return parser.err(arg, .{ .short = short }, Error.DoesntTakeValue);
                    return Arg(Id){ .param = param };
                }

                if (arg.len <= next_index) {
                    const value = parser.iter.next() orelse
                        return parser.err(arg, .{ .short = short }, Error.MissingValue);

                    return Arg(Id){ .param = param, .value = value };
                }

                if (next_is_eql)
                    return Arg(Id){ .param = param, .value = arg[next_index + 1 ..] };

                return Arg(Id){ .param = param, .value = arg[next_index..] };
            }

            return parser.err(arg, .{ .short = arg[index] }, Error.InvalidArgument);
        }

        fn positionalParam(parser: *@This()) ?*const clap.Param(Id) {
            if (parser.positional) |p|
                return p;

            for (parser.params) |*param| {
                if (param.names.long) |_|
                    continue;
                if (param.names.short) |_|
                    continue;

                parser.positional = param;
                return param;
            }

            return null;
        }

        const ArgInfo = struct {
            arg: []const u8,
            kind: enum {
                long,
                short,
                positional,
            },
        };

        fn parseNextArg(parser: *@This()) !?ArgInfo {
            const full_arg = parser.iter.next() orelse return null;
            if (mem.eql(u8, full_arg, "--") or mem.eql(u8, full_arg, "-"))
                return ArgInfo{ .arg = full_arg, .kind = .positional };
            if (mem.startsWith(u8, full_arg, "--"))
                return ArgInfo{ .arg = full_arg[2..], .kind = .long };
            if (mem.startsWith(u8, full_arg, "-"))
                return ArgInfo{ .arg = full_arg[1..], .kind = .short };

            return ArgInfo{ .arg = full_arg, .kind = .positional };
        }

        fn err(parser: @This(), arg: []const u8, names: clap.Names, _err: anytype) @TypeOf(_err) {
            if (parser.diagnostic) |d|
                d.* = .{ .arg = arg, .name = names };
            return _err;
        }
    };
}

fn testNoErr(
    params: []const clap.Param(u8),
    args_strings: []const []const u8,
    results: []const Arg(u8),
) !void {
    var iter = args.SliceIterator{ .args = args_strings };
    var c = Clap(u8, args.SliceIterator){
        .params = params,
        .iter = &iter,
    };

    for (results) |res| {
        const arg = (try c.next()) orelse return error.TestFailed;
        try testing.expectEqual(res.param, arg.param);
        const expected_value = res.value orelse {
            try testing.expectEqual(@as(@TypeOf(arg.value), null), arg.value);
            continue;
        };
        const actual_value = arg.value orelse return error.TestFailed;
        try testing.expectEqualSlices(u8, expected_value, actual_value);
    }

    if (try c.next()) |_|
        return error.TestFailed;
}

fn testErr(
    params: []const clap.Param(u8),
    args_strings: []const []const u8,
    expected: []const u8,
) !void {
    var diag: clap.Diagnostic = undefined;
    var iter = args.SliceIterator{ .args = args_strings };
    var c = Clap(u8, args.SliceIterator){
        .params = params,
        .iter = &iter,
        .diagnostic = &diag,
    };
    while (c.next() catch |err| {
        var buf: [1024]u8 = undefined;
        var fbs = io.fixedBufferStream(&buf);
        diag.report(fbs.writer(), err) catch return error.TestFailed;
        try testing.expectEqualStrings(expected, fbs.getWritten());
        return;
    }) |_| {}

    try testing.expect(false);
}

test "short params" {
    const params = [_]clap.Param(u8){
        .{ .id = 0, .names = .{ .short = 'a' } },
        .{ .id = 1, .names = .{ .short = 'b' } },
        .{
            .id = 2,
            .names = .{ .short = 'c' },
            .takes_value = .one,
        },
        .{
            .id = 3,
            .names = .{ .short = 'd' },
            .takes_value = .many,
        },
    };

    const a = &params[0];
    const b = &params[1];
    const c = &params[2];
    const d = &params[3];

    try testNoErr(
        &params,
        &.{
            "-a", "-b",    "-ab",  "-ba",
            "-c", "0",     "-c=0", "-ac",
            "0",  "-ac=0", "-d=0",
        },
        &.{
            .{ .param = a },
            .{ .param = b },
            .{ .param = a },
            .{ .param = b },
            .{ .param = b },
            .{ .param = a },
            .{ .param = c, .value = "0" },
            .{ .param = c, .value = "0" },
            .{ .param = a },
            .{ .param = c, .value = "0" },
            .{ .param = a },
            .{ .param = c, .value = "0" },
            .{ .param = d, .value = "0" },
        },
    );
}

test "long params" {
    const params = [_]clap.Param(u8){
        .{ .id = 0, .names = .{ .long = "aa" } },
        .{ .id = 1, .names = .{ .long = "bb" } },
        .{
            .id = 2,
            .names = .{ .long = "cc" },
            .takes_value = .one,
        },
        .{
            .id = 3,
            .names = .{ .long = "dd" },
            .takes_value = .many,
        },
    };

    const aa = &params[0];
    const bb = &params[1];
    const cc = &params[2];
    const dd = &params[3];

    try testNoErr(
        &params,
        &.{
            "--aa",   "--bb",
            "--cc",   "0",
            "--cc=0", "--dd=0",
        },
        &.{
            .{ .param = aa },
            .{ .param = bb },
            .{ .param = cc, .value = "0" },
            .{ .param = cc, .value = "0" },
            .{ .param = dd, .value = "0" },
        },
    );
}

test "positional params" {
    const params = [_]clap.Param(u8){.{
        .id = 0,
        .takes_value = .one,
    }};

    try testNoErr(
        &params,
        &.{ "aa", "bb" },
        &.{
            .{ .param = &params[0], .value = "aa" },
            .{ .param = &params[0], .value = "bb" },
        },
    );
}

test "all params" {
    const params = [_]clap.Param(u8){
        .{
            .id = 0,
            .names = .{ .short = 'a', .long = "aa" },
        },
        .{
            .id = 1,
            .names = .{ .short = 'b', .long = "bb" },
        },
        .{
            .id = 2,
            .names = .{ .short = 'c', .long = "cc" },
            .takes_value = .one,
        },
        .{ .id = 3, .takes_value = .one },
    };

    const aa = &params[0];
    const bb = &params[1];
    const cc = &params[2];
    const positional = &params[3];

    try testNoErr(
        &params,
        &.{
            "-a",   "-b",    "-ab",    "-ba",
            "-c",   "0",     "-c=0",   "-ac",
            "0",    "-ac=0", "--aa",   "--bb",
            "--cc", "0",     "--cc=0", "something",
            "-",    "--",    "--cc=0", "-a",
        },
        &.{
            .{ .param = aa },
            .{ .param = bb },
            .{ .param = aa },
            .{ .param = bb },
            .{ .param = bb },
            .{ .param = aa },
            .{ .param = cc, .value = "0" },
            .{ .param = cc, .value = "0" },
            .{ .param = aa },
            .{ .param = cc, .value = "0" },
            .{ .param = aa },
            .{ .param = cc, .value = "0" },
            .{ .param = aa },
            .{ .param = bb },
            .{ .param = cc, .value = "0" },
            .{ .param = cc, .value = "0" },
            .{ .param = positional, .value = "something" },
            .{ .param = positional, .value = "-" },
            .{ .param = positional, .value = "--cc=0" },
            .{ .param = positional, .value = "-a" },
        },
    );
}

test "errors" {
    const params = [_]clap.Param(u8){
        .{
            .id = 0,
            .names = .{ .short = 'a', .long = "aa" },
        },
        .{
            .id = 1,
            .names = .{ .short = 'c', .long = "cc" },
            .takes_value = .one,
        },
    };
    try testErr(&params, &.{"q"}, "Invalid argument 'q'\n");
    try testErr(&params, &.{"-q"}, "Invalid argument '-q'\n");
    try testErr(&params, &.{"--q"}, "Invalid argument '--q'\n");
    try testErr(&params, &.{"--q=1"}, "Invalid argument '--q'\n");
    try testErr(&params, &.{"-a=1"}, "The argument '-a' does not take a value\n");
    try testErr(&params, &.{"--aa=1"}, "The argument '--aa' does not take a value\n");
    try testErr(&params, &.{"-c"}, "The argument '-c' requires a value but none was supplied\n");
    try testErr(
        &params,
        &.{"--cc"},
        "The argument '--cc' requires a value but none was supplied\n",
    );
}
