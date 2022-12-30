const std = @import("std");

const builtin = std.builtin;
const debug = std.debug;
const heap = std.heap;
const io = std.io;
const math = std.math;
const mem = std.mem;
const meta = std.meta;
const process = std.process;
const testing = std.testing;

pub const args = @import("clap/args.zig");
pub const parsers = @import("clap/parsers.zig");
pub const streaming = @import("clap/streaming.zig");

test "clap" {
    testing.refAllDecls(@This());
}

/// The names a `Param` can have.
pub const Names = struct {
    /// '-' prefix
    short: ?u8 = null,

    /// '--' prefix
    long: ?[]const u8 = null,

    /// The longest of the possible names this `Names` struct can represent.
    pub fn longest(names: *const Names) Longest {
        if (names.long) |long|
            return .{ .kind = .long, .name = long };
        if (names.short) |*short| {
            // TODO: Zig cannot figure out @as(*const [1]u8, short) in the ano literal
            const casted: *const [1]u8 = short;
            return .{ .kind = .short, .name = casted };
        }

        return .{ .kind = .positional, .name = "" };
    }

    pub const Longest = struct {
        kind: Kind,
        name: []const u8,
    };

    pub const Kind = enum {
        long,
        short,
        positional,

        pub fn prefix(kind: Kind) []const u8 {
            return switch (kind) {
                .long => "--",
                .short => "-",
                .positional => "",
            };
        }
    };
};

/// Whether a param takes no value (a flag), one value, or can be specified multiple times.
pub const Values = enum {
    none,
    one,
    many,
};

/// Represents a parameter for the command line.
/// Parameters come in three kinds:
///   * Short ("-a"): Should be used for the most commonly used parameters in your program.
///     * They can take a value three different ways.
///       * "-a value"
///       * "-a=value"
///       * "-avalue"
///     * They chain if they don't take values: "-abc".
///       * The last given parameter can take a value in the same way that a single parameter can:
///         * "-abc value"
///         * "-abc=value"
///         * "-abcvalue"
///   * Long ("--long-param"): Should be used for less common parameters, or when no single
///                            character can describe the paramter.
///     * They can take a value two different ways.
///       * "--long-param value"
///       * "--long-param=value"
///   * Positional: Should be used as the primary parameter of the program, like a filename or
///                 an expression to parse.
///     * Positional parameters have both names.long and names.short == null.
///     * Positional parameters must take a value.
pub fn Param(comptime Id: type) type {
    return struct {
        id: Id,
        names: Names = Names{},
        takes_value: Values = .none,
    };
}

/// Takes a string and parses it into many Param(Help). Returned is a newly allocated slice
/// containing all the parsed params. The caller is responsible for freeing the slice.
pub fn parseParams(allocator: mem.Allocator, str: []const u8) ![]Param(Help) {
    var end: usize = undefined;
    return parseParamsEx(allocator, str, &end);
}

/// Takes a string and parses it into many Param(Help). Returned is a newly allocated slice
/// containing all the parsed params. The caller is responsible for freeing the slice.
pub fn parseParamsEx(allocator: mem.Allocator, str: []const u8, end: *usize) ![]Param(Help) {
    var list = std.ArrayList(Param(Help)).init(allocator);
    errdefer list.deinit();

    try parseParamsIntoArrayListEx(&list, str, end);
    return try list.toOwnedSlice();
}

/// Takes a string and parses it into many Param(Help) at comptime. Returned is an array of
/// exactly the number of params that was parsed from `str`. A parse error becomes a compiler
/// error.
pub fn parseParamsComptime(comptime str: []const u8) [countParams(str)]Param(Help) {
    var end: usize = undefined;
    var res: [countParams(str)]Param(Help) = undefined;
    _ = parseParamsIntoSliceEx(&res, str, &end) catch {
        const loc = std.zig.findLineColumn(str, end);
        @compileError(std.fmt.comptimePrint("error:{}:{}: Failed to parse parameter:\n{s}", .{
            loc.line + 1,
            loc.column + 1,
            loc.source_line,
        }));
    };
    return res;
}

fn countParams(str: []const u8) usize {
    // See parseParam for reasoning. I would like to remove it from parseParam, but people depend
    // on that function to still work conveniently at comptime, so leaving it for now.
    @setEvalBranchQuota(std.math.maxInt(u32));

    var res: usize = 0;
    var it = mem.split(u8, str, "\n");
    while (it.next()) |line| {
        const trimmed = mem.trimLeft(u8, line, " \t");
        if (mem.startsWith(u8, trimmed, "-") or
            mem.startsWith(u8, trimmed, "<"))
        {
            res += 1;
        }
    }

    return res;
}

/// Takes a string and parses it into many Param(Help), which are written to `slice`. A subslice
/// is returned, containing all the parameters parsed. This function will fail if the input slice
/// is to small.
pub fn parseParamsIntoSlice(slice: []Param(Help), str: []const u8) ![]Param(Help) {
    var null_alloc = heap.FixedBufferAllocator.init("");
    var list = std.ArrayList(Param(Help)){
        .allocator = null_alloc.allocator(),
        .items = slice[0..0],
        .capacity = slice.len,
    };

    try parseParamsIntoArrayList(&list, str);
    return list.items;
}

/// Takes a string and parses it into many Param(Help), which are written to `slice`. A subslice
/// is returned, containing all the parameters parsed. This function will fail if the input slice
/// is to small.
pub fn parseParamsIntoSliceEx(slice: []Param(Help), str: []const u8, end: *usize) ![]Param(Help) {
    var null_alloc = heap.FixedBufferAllocator.init("");
    var list = std.ArrayList(Param(Help)){
        .allocator = null_alloc.allocator(),
        .items = slice[0..0],
        .capacity = slice.len,
    };

    try parseParamsIntoArrayListEx(&list, str, end);
    return list.items;
}

/// Takes a string and parses it into many Param(Help), which are appended onto `list`.
pub fn parseParamsIntoArrayList(list: *std.ArrayList(Param(Help)), str: []const u8) !void {
    var end: usize = undefined;
    return parseParamsIntoArrayListEx(list, str, &end);
}

/// Takes a string and parses it into many Param(Help), which are appended onto `list`.
pub fn parseParamsIntoArrayListEx(list: *std.ArrayList(Param(Help)), str: []const u8, end: *usize) !void {
    var i: usize = 0;
    while (i != str.len) {
        var end_of_this: usize = undefined;
        errdefer end.* = i + end_of_this;

        try list.append(try parseParamEx(str[i..], &end_of_this));
        i += end_of_this;
    }

    end.* = str.len;
}

pub fn parseParam(str: []const u8) !Param(Help) {
    var end: usize = undefined;
    return parseParamEx(str, &end);
}

/// Takes a string and parses it to a Param(Help).
pub fn parseParamEx(str: []const u8, end: *usize) !Param(Help) {
    // This function become a lot less ergonomic to use once you hit the eval branch quota. To
    // avoid this we pick a sane default. Sadly, the only sane default is the biggest possible
    // value. If we pick something a lot smaller and a user hits the quota after that, they have
    // no way of overriding it, since we set it here.
    // We can recosider this again if:
    // * We get parseParams: https://github.com/Hejsil/zig-clap/issues/39
    // * We get a larger default branch quota in the zig compiler (stage 2).
    // * Someone points out how this is a really bad idea.
    @setEvalBranchQuota(std.math.maxInt(u32));

    var res = Param(Help){ .id = .{} };
    var start: usize = 0;
    var state: enum {
        start,

        start_of_short_name,
        end_of_short_name,

        before_long_name_or_value_or_description,

        before_long_name,
        start_of_long_name,
        first_char_of_long_name,
        rest_of_long_name,

        before_value_or_description,

        first_char_of_value,
        rest_of_value,
        end_of_one_value,
        second_dot_of_multi_value,
        third_dot_of_multi_value,

        before_description,
        rest_of_description,
        rest_of_description_new_line,
    } = .start;
    for (str) |c, i| {
        errdefer end.* = i;

        switch (state) {
            .start => switch (c) {
                ' ', '\t', '\n' => {},
                '-' => state = .start_of_short_name,
                '<' => state = .first_char_of_value,
                else => return error.InvalidParameter,
            },

            .start_of_short_name => switch (c) {
                '-' => state = .first_char_of_long_name,
                'a'...'z', 'A'...'Z', '0'...'9' => {
                    res.names.short = c;
                    state = .end_of_short_name;
                },
                else => return error.InvalidParameter,
            },
            .end_of_short_name => switch (c) {
                ' ', '\t' => state = .before_long_name_or_value_or_description,
                '\n' => {
                    start = i + 1;
                    end.* = i + 1;
                    state = .rest_of_description_new_line;
                },
                ',' => state = .before_long_name,
                else => return error.InvalidParameter,
            },

            .before_long_name => switch (c) {
                ' ', '\t' => {},
                '-' => state = .start_of_long_name,
                else => return error.InvalidParameter,
            },
            .start_of_long_name => switch (c) {
                '-' => state = .first_char_of_long_name,
                else => return error.InvalidParameter,
            },
            .first_char_of_long_name => switch (c) {
                'a'...'z', 'A'...'Z', '0'...'9', '-', '_' => {
                    start = i;
                    state = .rest_of_long_name;
                },
                else => return error.InvalidParameter,
            },
            .rest_of_long_name => switch (c) {
                'a'...'z', 'A'...'Z', '0'...'9', '-', '_' => {},
                ' ', '\t' => {
                    res.names.long = str[start..i];
                    state = .before_value_or_description;
                },
                '\n' => {
                    res.names.long = str[start..i];
                    start = i + 1;
                    end.* = i + 1;
                    state = .rest_of_description_new_line;
                },
                else => return error.InvalidParameter,
            },

            .before_long_name_or_value_or_description => switch (c) {
                ' ', '\t' => {},
                ',' => state = .before_long_name,
                '<' => state = .first_char_of_value,
                else => {
                    start = i;
                    state = .rest_of_description;
                },
            },

            .before_value_or_description => switch (c) {
                ' ', '\t' => {},
                '<' => state = .first_char_of_value,
                else => {
                    start = i;
                    state = .rest_of_description;
                },
            },
            .first_char_of_value => switch (c) {
                '>' => return error.InvalidParameter,
                else => {
                    start = i;
                    state = .rest_of_value;
                },
            },
            .rest_of_value => switch (c) {
                '>' => {
                    res.takes_value = .one;
                    res.id.val = str[start..i];
                    state = .end_of_one_value;
                },
                else => {},
            },
            .end_of_one_value => switch (c) {
                '.' => state = .second_dot_of_multi_value,
                ' ', '\t' => state = .before_description,
                '\n' => {
                    start = i + 1;
                    end.* = i + 1;
                    state = .rest_of_description_new_line;
                },
                else => {
                    start = i;
                    state = .rest_of_description;
                },
            },
            .second_dot_of_multi_value => switch (c) {
                '.' => state = .third_dot_of_multi_value,
                else => return error.InvalidParameter,
            },
            .third_dot_of_multi_value => switch (c) {
                '.' => {
                    res.takes_value = .many;
                    state = .before_description;
                },
                else => return error.InvalidParameter,
            },

            .before_description => switch (c) {
                ' ', '\t' => {},
                '\n' => {
                    start = i + 1;
                    end.* = i + 1;
                    state = .rest_of_description_new_line;
                },
                else => {
                    start = i;
                    state = .rest_of_description;
                },
            },
            .rest_of_description => switch (c) {
                '\n' => {
                    end.* = i;
                    state = .rest_of_description_new_line;
                },
                else => {},
            },
            .rest_of_description_new_line => switch (c) {
                ' ', '\t', '\n' => {},
                '-', '<' => {
                    res.id.desc = str[start..end.*];
                    end.* = i;
                    break;
                },
                else => state = .rest_of_description,
            },
        }
    } else {
        defer end.* = str.len;
        switch (state) {
            .rest_of_description => res.id.desc = str[start..],
            .rest_of_description_new_line => res.id.desc = str[start..end.*],
            .rest_of_long_name => res.names.long = str[start..],
            .end_of_short_name,
            .end_of_one_value,
            .before_value_or_description,
            .before_description,
            => {},
            else => return error.InvalidParameter,
        }
    }

    return res;
}

fn testParseParams(str: []const u8, expected_params: []const Param(Help)) !void {
    var end: usize = undefined;
    const actual_params = parseParamsEx(testing.allocator, str, &end) catch |err| {
        const loc = std.zig.findLineColumn(str, end);
        std.debug.print("error:{}:{}: Failed to parse parameter:\n{s}\n", .{
            loc.line + 1,
            loc.column + 1,
            loc.source_line,
        });
        return err;
    };
    defer testing.allocator.free(actual_params);

    try testing.expectEqual(expected_params.len, actual_params.len);
    for (expected_params) |_, i|
        try expectParam(expected_params[i], actual_params[i]);
}

fn expectParam(expect: Param(Help), actual: Param(Help)) !void {
    try testing.expectEqualStrings(expect.id.desc, actual.id.desc);
    try testing.expectEqualStrings(expect.id.val, actual.id.val);
    try testing.expectEqual(expect.names.short, actual.names.short);
    try testing.expectEqual(expect.takes_value, actual.takes_value);
    if (expect.names.long) |long| {
        try testing.expectEqualStrings(long, actual.names.long.?);
    } else {
        try testing.expectEqual(@as(?[]const u8, null), actual.names.long);
    }
}

test "parseParams" {
    try testParseParams(
        \\-s
        \\--str
        \\--str-str
        \\--str_str
        \\-s, --str
        \\--str <str>
        \\-s, --str <str>
        \\-s, --long <val> Help text
        \\-s, --long <val>... Help text
        \\--long <val> Help text
        \\-s <val> Help text
        \\-s, --long Help text
        \\-s Help text
        \\--long Help text
        \\--long <A | B> Help text
        \\<A> Help text
        \\<A>... Help text
        \\--aa
        \\    This is
        \\    help spanning multiple
        \\    lines
        \\--aa This msg should end and the newline cause of new param
        \\--bb This should be a new param
        \\
    , &.{
        .{ .id = .{}, .names = .{ .short = 's' } },
        .{ .id = .{}, .names = .{ .long = "str" } },
        .{ .id = .{}, .names = .{ .long = "str-str" } },
        .{ .id = .{}, .names = .{ .long = "str_str" } },
        .{ .id = .{}, .names = .{ .short = 's', .long = "str" } },
        .{
            .id = .{ .val = "str" },
            .names = .{ .long = "str" },
            .takes_value = .one,
        },
        .{
            .id = .{ .val = "str" },
            .names = .{ .short = 's', .long = "str" },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text", .val = "val" },
            .names = .{ .short = 's', .long = "long" },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text", .val = "val" },
            .names = .{ .short = 's', .long = "long" },
            .takes_value = .many,
        },
        .{
            .id = .{ .desc = "Help text", .val = "val" },
            .names = .{ .long = "long" },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text", .val = "val" },
            .names = .{ .short = 's' },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text" },
            .names = .{ .short = 's', .long = "long" },
        },
        .{
            .id = .{ .desc = "Help text" },
            .names = .{ .short = 's' },
        },
        .{
            .id = .{ .desc = "Help text" },
            .names = .{ .long = "long" },
        },
        .{
            .id = .{ .desc = "Help text", .val = "A | B" },
            .names = .{ .long = "long" },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text", .val = "A" },
            .takes_value = .one,
        },
        .{
            .id = .{ .desc = "Help text", .val = "A" },
            .names = .{},
            .takes_value = .many,
        },
        .{
            .id = .{
                .desc =
                \\    This is
                \\    help spanning multiple
                \\    lines
                ,
            },
            .names = .{ .long = "aa" },
            .takes_value = .none,
        },
        .{
            .id = .{ .desc = "This msg should end and the newline cause of new param" },
            .names = .{ .long = "aa" },
            .takes_value = .none,
        },
        .{
            .id = .{ .desc = "This should be a new param" },
            .names = .{ .long = "bb" },
            .takes_value = .none,
        },
    });

    try testing.expectError(error.InvalidParameter, parseParam("--long, Help"));
    try testing.expectError(error.InvalidParameter, parseParam("-s, Help"));
    try testing.expectError(error.InvalidParameter, parseParam("-ss Help"));
    try testing.expectError(error.InvalidParameter, parseParam("-ss <val> Help"));
    try testing.expectError(error.InvalidParameter, parseParam("- Help"));
}

/// Optional diagnostics used for reporting useful errors
pub const Diagnostic = struct {
    arg: []const u8 = "",
    name: Names = Names{},

    /// Default diagnostics reporter when all you want is English with no colors.
    /// Use this as a reference for implementing your own if needed.
    pub fn report(diag: Diagnostic, stream: anytype, err: anyerror) !void {
        var longest = diag.name.longest();
        if (longest.kind == .positional)
            longest.name = diag.arg;

        switch (err) {
            streaming.Error.DoesntTakeValue => try stream.print(
                "The argument '{s}{s}' does not take a value\n",
                .{ longest.kind.prefix(), longest.name },
            ),
            streaming.Error.MissingValue => try stream.print(
                "The argument '{s}{s}' requires a value but none was supplied\n",
                .{ longest.kind.prefix(), longest.name },
            ),
            streaming.Error.InvalidArgument => try stream.print(
                "Invalid argument '{s}{s}'\n",
                .{ longest.kind.prefix(), longest.name },
            ),
            else => try stream.print("Error while parsing arguments: {s}\n", .{@errorName(err)}),
        }
    }
};

fn testDiag(diag: Diagnostic, err: anyerror, expected: []const u8) !void {
    var buf: [1024]u8 = undefined;
    var slice_stream = io.fixedBufferStream(&buf);
    diag.report(slice_stream.writer(), err) catch unreachable;
    try testing.expectEqualStrings(expected, slice_stream.getWritten());
}

test "Diagnostic.report" {
    try testDiag(.{ .arg = "c" }, error.InvalidArgument, "Invalid argument 'c'\n");
    try testDiag(
        .{ .name = .{ .long = "cc" } },
        error.InvalidArgument,
        "Invalid argument '--cc'\n",
    );
    try testDiag(
        .{ .name = .{ .short = 'c' } },
        error.DoesntTakeValue,
        "The argument '-c' does not take a value\n",
    );
    try testDiag(
        .{ .name = .{ .long = "cc" } },
        error.DoesntTakeValue,
        "The argument '--cc' does not take a value\n",
    );
    try testDiag(
        .{ .name = .{ .short = 'c' } },
        error.MissingValue,
        "The argument '-c' requires a value but none was supplied\n",
    );
    try testDiag(
        .{ .name = .{ .long = "cc" } },
        error.MissingValue,
        "The argument '--cc' requires a value but none was supplied\n",
    );
    try testDiag(
        .{ .name = .{ .short = 'c' } },
        error.InvalidArgument,
        "Invalid argument '-c'\n",
    );
    try testDiag(
        .{ .name = .{ .long = "cc" } },
        error.InvalidArgument,
        "Invalid argument '--cc'\n",
    );
    try testDiag(
        .{ .name = .{ .short = 'c' } },
        error.SomethingElse,
        "Error while parsing arguments: SomethingElse\n",
    );
    try testDiag(
        .{ .name = .{ .long = "cc" } },
        error.SomethingElse,
        "Error while parsing arguments: SomethingElse\n",
    );
}

/// Options that can be set to customize the behavior of parsing.
pub const ParseOptions = struct {
    /// The allocator used for all memory allocations. Defaults to the `heap.page_allocator`.
    /// Note: You should probably override this allocator if you are calling `parseEx`. Unlike
    ///       `parse`, `parseEx` does not wrap the allocator so the heap allocator can be
    ///       quite expensive. (TODO: Can we pick a better default? For `parse`, this allocator
    ///       is fine, as it wraps it in an arena)
    allocator: mem.Allocator = heap.page_allocator,
    diagnostic: ?*Diagnostic = null,
};

/// Same as `parseEx` but uses the `args.OsIterator` by default.
pub fn parse(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
    opt: ParseOptions,
) !Result(Id, params, value_parsers) {
    var arena = heap.ArenaAllocator.init(opt.allocator);
    errdefer arena.deinit();

    var iter = try process.ArgIterator.initWithAllocator(arena.allocator());
    const exe_arg = iter.next();

    const result = try parseEx(Id, params, value_parsers, &iter, .{
        // Let's reuse the arena from the `OSIterator` since we already have it.
        .allocator = arena.allocator(),
        .diagnostic = opt.diagnostic,
    });

    return Result(Id, params, value_parsers){
        .args = result.args,
        .positionals = result.positionals,
        .exe_arg = exe_arg,
        .arena = arena,
    };
}

/// The result of `parse`. Is owned by the caller and should be freed with `deinit`.
pub fn Result(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
) type {
    return struct {
        args: Arguments(Id, params, value_parsers, .slice),
        positionals: []const FindPositionalType(Id, params, value_parsers),
        exe_arg: ?[]const u8,
        arena: std.heap.ArenaAllocator,

        pub fn deinit(result: @This()) void {
            result.arena.deinit();
        }
    };
}

/// Parses the command line arguments passed into the program based on an array of parameters.
///
/// The result will contain an `args` field which contains all the non positional arguments passed
/// in. There is a field in `args` for each parameter. The name of that field will be the result
/// of this expression:
/// ```
/// param.names.longest().name`
/// ```
///
/// The fields can have types other that `[]const u8` and this is based on what `value_parsers`
/// you provide. The parser to use for each parameter is determined by the following expression:
/// ```
/// @field(value_parsers, param.id.value())
/// ```
///
/// Where `value` is a function that returns the name of the value this parameter takes. A parser
/// is simple a function with the signature:
/// ```
/// fn ([]const u8) Error!T
/// ```
///
/// `T` can be any type and `Error` can be any error. You can pass `clap.parsers.default` if you
/// just wonna get something up and running.
///
/// Caller ownes the result and should free it by calling `result.deinit()`
pub fn parseEx(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
    iter: anytype,
    opt: ParseOptions,
) !ResultEx(Id, params, value_parsers) {
    const allocator = opt.allocator;
    const Positional = FindPositionalType(Id, params, value_parsers);

    var positionals = std.ArrayList(Positional).init(allocator);
    var arguments = Arguments(Id, params, value_parsers, .list){};
    errdefer deinitArgs(Id, params, allocator, &arguments);

    var stream = streaming.Clap(Id, meta.Child(@TypeOf(iter))){
        .params = params,
        .iter = iter,
        .diagnostic = opt.diagnostic,
    };
    while (try stream.next()) |arg| {
        // TODO: We cannot use `try` inside the inline for because of a compiler bug that
        //       generates an infinit loop. For now, use a variable to store the error
        //       and use `try` outside. The downside of this is that we have to use
        //       `anyerror` :(
        var res: anyerror!void = {};
        inline for (params) |*param| {
            if (param == arg.param) {
                res = parseArg(
                    Id,
                    param.*,
                    value_parsers,
                    allocator,
                    &arguments,
                    &positionals,
                    arg,
                );
            }
        }

        try res;
    }

    // We are done parsing, but our arguments are stored in lists, and not slices. Map the list
    // fields to slices and return that.
    var result_args = Arguments(Id, params, value_parsers, .slice){};
    inline for (meta.fields(@TypeOf(arguments))) |field| {
        if (@typeInfo(field.type) == .Struct and
            @hasDecl(field.type, "toOwnedSlice"))
        {
            const slice = try @field(arguments, field.name).toOwnedSlice(allocator);
            @field(result_args, field.name) = slice;
        } else {
            @field(result_args, field.name) = @field(arguments, field.name);
        }
    }

    return ResultEx(Id, params, value_parsers){
        .args = result_args,
        .positionals = try positionals.toOwnedSlice(),
        .allocator = allocator,
    };
}

fn parseArg(
    comptime Id: type,
    comptime param: Param(Id),
    comptime value_parsers: anytype,
    allocator: mem.Allocator,
    arguments: anytype,
    positionals: anytype,
    arg: streaming.Arg(Id),
) !void {
    const parser = comptime switch (param.takes_value) {
        .none => undefined,
        .one, .many => @field(value_parsers, param.id.value()),
    };

    const longest = comptime param.names.longest();
    switch (longest.kind) {
        .short, .long => switch (param.takes_value) {
            .none => @field(arguments, longest.name) = true,
            .one => @field(arguments, longest.name) = try parser(arg.value.?),
            .many => {
                const value = try parser(arg.value.?);
                try @field(arguments, longest.name).append(allocator, value);
            },
        },
        .positional => try positionals.append(try parser(arg.value.?)),
    }
}

/// The result of `parseEx`. Is owned by the caller and should be freed with `deinit`.
pub fn ResultEx(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
) type {
    return struct {
        args: Arguments(Id, params, value_parsers, .slice),
        positionals: []const FindPositionalType(Id, params, value_parsers),
        allocator: mem.Allocator,

        pub fn deinit(result: *@This()) void {
            deinitArgs(Id, params, result.allocator, &result.args);
            result.allocator.free(result.positionals);
        }
    };
}

fn FindPositionalType(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
) type {
    const pos = findPositional(Id, params) orelse return []const u8;
    return ParamType(Id, pos, value_parsers);
}

fn findPositional(comptime Id: type, params: []const Param(Id)) ?Param(Id) {
    for (params) |param| {
        const longest = param.names.longest();
        if (longest.kind == .positional)
            return param;
    }

    return null;
}

/// Given a parameter figure out which type that parameter is parsed into when using the correct
/// parser from `value_parsers`.
fn ParamType(
    comptime Id: type,
    comptime param: Param(Id),
    comptime value_parsers: anytype,
) type {
    const parser = switch (param.takes_value) {
        .none => parsers.string,
        .one, .many => @field(value_parsers, param.id.value()),
    };
    return parsers.Result(@TypeOf(parser));
}

/// Deinitializes a struct of type `Argument`. Since the `Argument` type is generated, and we
/// cannot add the deinit declaration to it, we declare it here instead.
fn deinitArgs(
    comptime Id: type,
    comptime params: []const Param(Id),
    allocator: mem.Allocator,
    arguments: anytype,
) void {
    inline for (params) |param| {
        const longest = comptime param.names.longest();
        if (longest.kind == .positional)
            continue;
        if (param.takes_value != .many)
            continue;

        const field = @field(arguments, longest.name);

        // If the multi value field is a struct, we know it is a list and should be deinited.
        // Otherwise, it is a slice that should be freed.
        switch (@typeInfo(@TypeOf(field))) {
            .Struct => @field(arguments, longest.name).deinit(allocator),
            else => allocator.free(@field(arguments, longest.name)),
        }
    }
}

const MultiArgKind = enum { slice, list };

/// Turn a list of parameters into a struct with one field for each none positional parameter.
/// The type of each parameter field is determined by `ParamType`. Positional arguments will not
/// havea field in this struct.
fn Arguments(
    comptime Id: type,
    comptime params: []const Param(Id),
    comptime value_parsers: anytype,
    comptime multi_arg_kind: MultiArgKind,
) type {
    var fields: [params.len]builtin.Type.StructField = undefined;

    var i: usize = 0;
    for (params) |param| {
        const longest = param.names.longest();
        if (longest.kind == .positional)
            continue;

        const T = ParamType(Id, param, value_parsers);
        const default_value = switch (param.takes_value) {
            .none => false,
            .one => @as(?T, null),
            .many => switch (multi_arg_kind) {
                .slice => @as([]const T, &[_]T{}),
                .list => std.ArrayListUnmanaged(T){},
            },
        };

        fields[i] = .{
            .name = longest.name,
            .type = @TypeOf(default_value),
            .default_value = @ptrCast(*const anyopaque, &default_value),
            .is_comptime = false,
            .alignment = @alignOf(@TypeOf(default_value)),
        };
        i += 1;
    }

    return @Type(.{ .Struct = .{
        .layout = .Auto,
        .fields = fields[0..i],
        .decls = &.{},
        .is_tuple = false,
    } });
}

test "str and u64" {
    const params = comptime parseParamsComptime(
        \\--str <str>
        \\--num <u64>
        \\
    );

    var iter = args.SliceIterator{
        .args = &.{ "--num", "10", "--str", "cooley_rec_inp_ptr" },
    };
    var res = try parseEx(Help, &params, parsers.default, &iter, .{
        .allocator = testing.allocator,
    });
    defer res.deinit();
}

test "everything" {
    const params = comptime parseParamsComptime(
        \\-a, --aa
        \\-b, --bb
        \\-c, --cc <str>
        \\-d, --dd <usize>...
        \\<str>
        \\
    );

    var iter = args.SliceIterator{
        .args = &.{ "-a", "-c", "0", "something", "-d", "1", "--dd", "2" },
    };
    var res = try parseEx(Help, &params, parsers.default, &iter, .{
        .allocator = testing.allocator,
    });
    defer res.deinit();

    try testing.expect(res.args.aa);
    try testing.expect(!res.args.bb);
    try testing.expectEqualStrings("0", res.args.cc.?);
    try testing.expectEqual(@as(usize, 1), res.positionals.len);
    try testing.expectEqualStrings("something", res.positionals[0]);
    try testing.expectEqualSlices(usize, &.{ 1, 2 }, res.args.dd);
}

test "empty" {
    var iter = args.SliceIterator{ .args = &.{} };
    var res = try parseEx(u8, &[_]Param(u8){}, parsers.default, &iter, .{
        .allocator = testing.allocator,
    });
    defer res.deinit();
}

fn testErr(
    comptime params: []const Param(Help),
    args_strings: []const []const u8,
    expected: []const u8,
) !void {
    var diag = Diagnostic{};
    var iter = args.SliceIterator{ .args = args_strings };
    _ = parseEx(Help, params, parsers.default, &iter, .{
        .allocator = testing.allocator,
        .diagnostic = &diag,
    }) catch |err| {
        var buf: [1024]u8 = undefined;
        var fbs = io.fixedBufferStream(&buf);
        diag.report(fbs.writer(), err) catch return error.TestFailed;
        try testing.expectEqualStrings(expected, fbs.getWritten());
        return;
    };

    try testing.expect(false);
}

test "errors" {
    const params = comptime parseParamsComptime(
        \\-a, --aa
        \\-c, --cc <str>
        \\
    );

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

pub const Help = struct {
    desc: []const u8 = "",
    val: []const u8 = "",

    pub fn description(h: Help) []const u8 {
        return h.desc;
    }

    pub fn value(h: Help) []const u8 {
        return h.val;
    }
};

pub const HelpOptions = struct {
    /// Render the description of a parameter in a simular way to how markdown would render
    /// such a string. This means that single newlines wont be respected unless followed by
    /// bullet points or other markdown elements.
    markdown_lite: bool = true,

    /// Wether `help` should print the description of a parameter on a new line instead of after
    /// the parameter names. This options works together with `description_indent` to change
    /// where descriptions are printed.
    ///
    /// description_on_new_line=false, description_indent=4
    ///
    ///   -a, --aa <v>    This is a description
    ///                   that is not placed on
    ///                   a new line.
    ///
    /// description_on_new_line=true, description_indent=4
    ///
    ///   -a, --aa <v>
    ///       This is a description
    ///       that is placed on a
    ///       new line.
    description_on_new_line: bool = true,

    /// How much to indent descriptions. See `description_on_new_line` for examples of how this
    /// changes the output.
    description_indent: usize = 8,

    /// How much to indent each paramter.
    ///
    /// indent=0, description_on_new_line=false, description_indent=4
    ///
    /// -a, --aa <v>    This is a description
    ///                 that is not placed on
    ///                 a new line.
    ///
    /// indent=4, description_on_new_line=false, description_indent=4
    ///
    ///     -a, --aa <v>    This is a description
    ///                     that is not placed on
    ///                     a new line.
    ///
    indent: usize = 4,

    /// The maximum width of the help message. `help` will try to break the description of
    /// paramters into multiple lines if they exeed this maximum. Setting this to the width
    /// of the terminal is a nice way of using this option.
    max_width: usize = std.math.maxInt(usize),

    /// The number of empty lines between each printed parameter.
    spacing_between_parameters: usize = 1,
};

/// Print a slice of `Param` formatted as a help string to `writer`. This function expects
/// `Id` to have the methods `description` and `value` which are used by `help` to describe
/// each parameter. Using `Help` as `Id` is good choice.
///
/// The output can be constumized with the `opt` parameter. For default formatting `.{}` can
/// be passed.
pub fn help(
    writer: anytype,
    comptime Id: type,
    params: []const Param(Id),
    opt: HelpOptions,
) !void {
    const max_spacing = blk: {
        var res: usize = 0;
        for (params) |param| {
            var cs = io.countingWriter(io.null_writer);
            try printParam(cs.writer(), Id, param);
            if (res < cs.bytes_written)
                res = @intCast(usize, cs.bytes_written);
        }

        break :blk res;
    };

    const description_indentation = opt.indent +
        opt.description_indent +
        max_spacing * @boolToInt(!opt.description_on_new_line);

    var first_paramter: bool = true;
    for (params) |param| {
        if (param.names.longest().kind == .positional)
            continue;
        if (!first_paramter)
            try writer.writeByteNTimes('\n', opt.spacing_between_parameters);

        first_paramter = false;
        try writer.writeByteNTimes(' ', opt.indent);

        var cw = io.countingWriter(writer);
        try printParam(cw.writer(), Id, param);

        const Writer = DescriptionWriter(@TypeOf(writer));
        var description_writer = Writer{
            .underlying_writer = writer,
            .indentation = description_indentation,
            .printed_chars = @intCast(usize, cw.bytes_written),
            .max_width = opt.max_width,
        };

        if (opt.description_on_new_line)
            try description_writer.newline();

        const min_description_indent = blk: {
            const description = param.id.description();

            var first_line = true;
            var res: usize = std.math.maxInt(usize);
            var it = mem.tokenize(u8, description, "\n");
            while (it.next()) |line| : (first_line = false) {
                const trimmed = mem.trimLeft(u8, line, " ");
                const indent = line.len - trimmed.len;

                // If the first line has no indentation, then we ignore the indentation of the
                // first line. We do this as the parameter might have been parsed from:
                //
                // -a, --aa The first line
                //          is not indented,
                //          but the rest of
                //          the lines are.
                //
                // In this case, we want to pretend that the first line has the same indentation
                // as the min_description_indent, even though it is not so in the string we get.
                if (first_line and indent == 0)
                    continue;
                if (indent < res)
                    res = indent;
            }

            break :blk res;
        };

        const description = param.id.description();
        var it = mem.split(u8, description, "\n");
        var first_line = true;
        var non_emitted_newlines: usize = 0;
        var last_line_indentation: usize = 0;
        while (it.next()) |raw_line| : (first_line = false) {
            // First line might be special. See comment above.
            const indented_line = if (first_line and !mem.startsWith(u8, raw_line, " "))
                raw_line
            else
                raw_line[math.min(min_description_indent, raw_line.len)..];

            const line = mem.trimLeft(u8, indented_line, " ");
            if (line.len == 0) {
                non_emitted_newlines += 1;
                continue;
            }

            const line_indentation = indented_line.len - line.len;
            description_writer.indentation = description_indentation + line_indentation;

            if (opt.markdown_lite) {
                const new_paragraph = non_emitted_newlines > 1;

                const does_not_have_same_indent_as_last_line =
                    line_indentation != last_line_indentation;

                const starts_with_control_char = mem.indexOfScalar(u8, "=*", line[0]) != null;

                // Either the input contains 2 or more newlines, in which case we should start
                // a new paragraph.
                if (new_paragraph) {
                    try description_writer.newline();
                    try description_writer.newline();
                }
                // Or this line has a special control char or different indentation which means
                // we should output it on a new line as well.
                else if (starts_with_control_char or does_not_have_same_indent_as_last_line) {
                    try description_writer.newline();
                }
            } else {
                // For none markdown like format, we just respect the newlines in the input
                // string and output them as is.
                var i: usize = 0;
                while (i < non_emitted_newlines) : (i += 1)
                    try description_writer.newline();
            }

            var words = mem.tokenize(u8, line, " ");
            while (words.next()) |word|
                try description_writer.writeWord(word);

            // We have not emitted the end of this line yet.
            non_emitted_newlines = 1;
            last_line_indentation = line_indentation;
        }

        try writer.writeAll("\n");
    }
}

fn DescriptionWriter(comptime UnderlyingWriter: type) type {
    return struct {
        pub const WriteError = UnderlyingWriter.Error;

        underlying_writer: UnderlyingWriter,

        indentation: usize,
        max_width: usize,
        printed_chars: usize,

        pub fn writeWord(writer: *@This(), word: []const u8) !void {
            debug.assert(word.len != 0);

            var first_word = writer.printed_chars <= writer.indentation;
            const chars_to_write = word.len + @boolToInt(!first_word);
            if (chars_to_write + writer.printed_chars > writer.max_width) {
                // If the word does not fit on this line, then we insert a new line and print
                // it on that line. The only exception to this is if this was the first word.
                // If the first word does not fit on this line, then it will also not fit on the
                // next one. In that case, all we can really do is just output the word.
                if (!first_word)
                    try writer.newline();

                first_word = true;
            }

            if (!first_word)
                try writer.underlying_writer.writeAll(" ");

            try writer.ensureIndented();
            try writer.underlying_writer.writeAll(word);
            writer.printed_chars += chars_to_write;
        }

        pub fn newline(writer: *@This()) !void {
            try writer.underlying_writer.writeAll("\n");
            writer.printed_chars = 0;
        }

        fn ensureIndented(writer: *@This()) !void {
            if (writer.printed_chars < writer.indentation) {
                const to_indent = writer.indentation - writer.printed_chars;
                try writer.underlying_writer.writeByteNTimes(' ', to_indent);
                writer.printed_chars += to_indent;
            }
        }
    };
}

fn printParam(
    stream: anytype,
    comptime Id: type,
    param: Param(Id),
) !void {
    try stream.writeAll(&[_]u8{
        if (param.names.short) |_| '-' else ' ',
        param.names.short orelse ' ',
    });

    if (param.names.long) |l| {
        try stream.writeByte(if (param.names.short) |_| ',' else ' ');
        try stream.writeAll(" --");
        try stream.writeAll(l);
    }

    if (param.takes_value == .none)
        return;

    try stream.writeAll(" <");
    try stream.writeAll(param.id.value());
    try stream.writeAll(">");
    if (param.takes_value == .many)
        try stream.writeAll("...");
}

fn testHelp(opt: HelpOptions, str: []const u8) !void {
    const params = try parseParams(testing.allocator, str);
    defer testing.allocator.free(params);

    var buf: [2048]u8 = undefined;
    var fbs = io.fixedBufferStream(&buf);
    try help(fbs.writer(), Help, params, opt);
    try testing.expectEqualStrings(str, fbs.getWritten());
}

test "clap.help" {
    try testHelp(.{},
        \\    -a
        \\            Short flag.
        \\
        \\    -b <V1>
        \\            Short option.
        \\
        \\        --aa
        \\            Long flag.
        \\
        \\        --bb <V2>
        \\            Long option.
        \\
        \\    -c, --cc
        \\            Both flag.
        \\
        \\        --complicate
        \\            Flag with a complicated and very long description that spans multiple lines.
        \\
        \\            Paragraph number 2:
        \\            * Bullet point
        \\            * Bullet point
        \\
        \\            Example:
        \\                something something something
        \\
        \\    -d, --dd <V3>
        \\            Both option.
        \\
        \\    -d, --dd <V3>...
        \\            Both repeated option.
        \\
    );

    try testHelp(.{ .markdown_lite = false },
        \\    -a
        \\            Short flag.
        \\
        \\    -b <V1>
        \\            Short option.
        \\
        \\        --aa
        \\            Long flag.
        \\
        \\        --bb <V2>
        \\            Long option.
        \\
        \\    -c, --cc
        \\            Both flag.
        \\
        \\        --complicate
        \\            Flag with a complicated and
        \\            very long description that
        \\            spans multiple lines.
        \\
        \\            Paragraph number 2:
        \\            * Bullet point
        \\            * Bullet point
        \\
        \\
        \\            Example:
        \\                something something something
        \\
        \\    -d, --dd <V3>
        \\            Both option.
        \\
        \\    -d, --dd <V3>...
        \\            Both repeated option.
        \\
    );

    try testHelp(.{ .indent = 0 },
        \\-a
        \\        Short flag.
        \\
        \\-b <V1>
        \\        Short option.
        \\
        \\    --aa
        \\        Long flag.
        \\
        \\    --bb <V2>
        \\        Long option.
        \\
        \\-c, --cc
        \\        Both flag.
        \\
        \\    --complicate
        \\        Flag with a complicated and very long description that spans multiple lines.
        \\
        \\        Paragraph number 2:
        \\        * Bullet point
        \\        * Bullet point
        \\
        \\        Example:
        \\            something something something
        \\
        \\-d, --dd <V3>
        \\        Both option.
        \\
        \\-d, --dd <V3>...
        \\        Both repeated option.
        \\
    );

    try testHelp(.{ .indent = 0 },
        \\-a
        \\        Short flag.
        \\
        \\-b <V1>
        \\        Short option.
        \\
        \\    --aa
        \\        Long flag.
        \\
        \\    --bb <V2>
        \\        Long option.
        \\
        \\-c, --cc
        \\        Both flag.
        \\
        \\    --complicate
        \\        Flag with a complicated and very long description that spans multiple lines.
        \\
        \\        Paragraph number 2:
        \\        * Bullet point
        \\        * Bullet point
        \\
        \\        Example:
        \\            something something something
        \\
        \\-d, --dd <V3>
        \\        Both option.
        \\
        \\-d, --dd <V3>...
        \\        Both repeated option.
        \\
    );

    try testHelp(.{ .indent = 0, .max_width = 26 },
        \\-a
        \\        Short flag.
        \\
        \\-b <V1>
        \\        Short option.
        \\
        \\    --aa
        \\        Long flag.
        \\
        \\    --bb <V2>
        \\        Long option.
        \\
        \\-c, --cc
        \\        Both flag.
        \\
        \\    --complicate
        \\        Flag with a
        \\        complicated and
        \\        very long
        \\        description that
        \\        spans multiple
        \\        lines.
        \\
        \\        Paragraph number
        \\        2:
        \\        * Bullet point
        \\        * Bullet point
        \\
        \\        Example:
        \\            something
        \\            something
        \\            something
        \\
        \\-d, --dd <V3>
        \\        Both option.
        \\
        \\-d, --dd <V3>...
        \\        Both repeated
        \\        option.
        \\
    );

    try testHelp(.{
        .indent = 0,
        .max_width = 26,
        .description_indent = 6,
    },
        \\-a
        \\      Short flag.
        \\
        \\-b <V1>
        \\      Short option.
        \\
        \\    --aa
        \\      Long flag.
        \\
        \\    --bb <V2>
        \\      Long option.
        \\
        \\-c, --cc
        \\      Both flag.
        \\
        \\    --complicate
        \\      Flag with a
        \\      complicated and
        \\      very long
        \\      description that
        \\      spans multiple
        \\      lines.
        \\
        \\      Paragraph number 2:
        \\      * Bullet point
        \\      * Bullet point
        \\
        \\      Example:
        \\          something
        \\          something
        \\          something
        \\
        \\-d, --dd <V3>
        \\      Both option.
        \\
        \\-d, --dd <V3>...
        \\      Both repeated
        \\      option.
        \\
    );

    try testHelp(.{
        .indent = 0,
        .max_width = 46,
        .description_on_new_line = false,
    },
        \\-a                      Short flag.
        \\
        \\-b <V1>                 Short option.
        \\
        \\    --aa                Long flag.
        \\
        \\    --bb <V2>           Long option.
        \\
        \\-c, --cc                Both flag.
        \\
        \\    --complicate        Flag with a
        \\                        complicated and very
        \\                        long description that
        \\                        spans multiple lines.
        \\
        \\                        Paragraph number 2:
        \\                        * Bullet point
        \\                        * Bullet point
        \\
        \\                        Example:
        \\                            something
        \\                            something
        \\                            something
        \\
        \\-d, --dd <V3>           Both option.
        \\
        \\-d, --dd <V3>...        Both repeated option.
        \\
    );

    try testHelp(.{
        .indent = 0,
        .max_width = 46,
        .description_on_new_line = false,
        .description_indent = 4,
    },
        \\-a                  Short flag.
        \\
        \\-b <V1>             Short option.
        \\
        \\    --aa            Long flag.
        \\
        \\    --bb <V2>       Long option.
        \\
        \\-c, --cc            Both flag.
        \\
        \\    --complicate    Flag with a complicated
        \\                    and very long description
        \\                    that spans multiple
        \\                    lines.
        \\
        \\                    Paragraph number 2:
        \\                    * Bullet point
        \\                    * Bullet point
        \\
        \\                    Example:
        \\                        something something
        \\                        something
        \\
        \\-d, --dd <V3>       Both option.
        \\
        \\-d, --dd <V3>...    Both repeated option.
        \\
    );

    try testHelp(.{
        .indent = 0,
        .max_width = 46,
        .description_on_new_line = false,
        .description_indent = 4,
        .spacing_between_parameters = 0,
    },
        \\-a                  Short flag.
        \\-b <V1>             Short option.
        \\    --aa            Long flag.
        \\    --bb <V2>       Long option.
        \\-c, --cc            Both flag.
        \\    --complicate    Flag with a complicated
        \\                    and very long description
        \\                    that spans multiple
        \\                    lines.
        \\
        \\                    Paragraph number 2:
        \\                    * Bullet point
        \\                    * Bullet point
        \\
        \\                    Example:
        \\                        something something
        \\                        something
        \\-d, --dd <V3>       Both option.
        \\-d, --dd <V3>...    Both repeated option.
        \\
    );

    try testHelp(.{
        .indent = 0,
        .max_width = 46,
        .description_on_new_line = false,
        .description_indent = 4,
        .spacing_between_parameters = 2,
    },
        \\-a                  Short flag.
        \\
        \\
        \\-b <V1>             Short option.
        \\
        \\
        \\    --aa            Long flag.
        \\
        \\
        \\    --bb <V2>       Long option.
        \\
        \\
        \\-c, --cc            Both flag.
        \\
        \\
        \\    --complicate    Flag with a complicated
        \\                    and very long description
        \\                    that spans multiple
        \\                    lines.
        \\
        \\                    Paragraph number 2:
        \\                    * Bullet point
        \\                    * Bullet point
        \\
        \\                    Example:
        \\                        something something
        \\                        something
        \\
        \\
        \\-d, --dd <V3>       Both option.
        \\
        \\
        \\-d, --dd <V3>...    Both repeated option.
        \\
    );
}

/// Will print a usage message in the following format:
/// [-abc] [--longa] [-d <T>] [--longb <T>] <T>
///
/// First all none value taking parameters, which have a short name are printed, then non
/// positional parameters and finally the positional.
pub fn usage(stream: anytype, comptime Id: type, params: []const Param(Id)) !void {
    var cos = io.countingWriter(stream);
    const cs = cos.writer();
    for (params) |param| {
        const name = param.names.short orelse continue;
        if (param.takes_value != .none)
            continue;

        if (cos.bytes_written == 0)
            try stream.writeAll("[-");
        try cs.writeByte(name);
    }
    if (cos.bytes_written != 0)
        try cs.writeAll("]");

    var positional: ?Param(Id) = null;
    for (params) |param| {
        if (param.takes_value == .none and param.names.short != null)
            continue;

        const prefix = if (param.names.short) |_| "-" else "--";
        const name = if (param.names.short) |*s|
            // Seems the zig compiler is being a little wierd. I doesn't allow me to write
            // @as(*const [1]u8, s)
            @ptrCast([*]const u8, s)[0..1]
        else
            param.names.long orelse {
                positional = param;
                continue;
            };

        if (cos.bytes_written != 0)
            try cs.writeAll(" ");

        try cs.writeAll("[");
        try cs.writeAll(prefix);
        try cs.writeAll(name);
        if (param.takes_value != .none) {
            try cs.writeAll(" <");
            try cs.writeAll(param.id.value());
            try cs.writeAll(">");
            if (param.takes_value == .many)
                try cs.writeAll("...");
        }

        try cs.writeByte(']');
    }

    if (positional) |p| {
        if (cos.bytes_written != 0)
            try cs.writeAll(" ");

        try cs.writeAll("<");
        try cs.writeAll(p.id.value());
        try cs.writeAll(">");
        if (p.takes_value == .many)
            try cs.writeAll("...");
    }
}

fn testUsage(expected: []const u8, params: []const Param(Help)) !void {
    var buf: [1024]u8 = undefined;
    var fbs = io.fixedBufferStream(&buf);
    try usage(fbs.writer(), Help, params);
    try testing.expectEqualStrings(expected, fbs.getWritten());
}

test "usage" {
    @setEvalBranchQuota(100000);
    try testUsage("[-ab]", &comptime parseParamsComptime(
        \\-a
        \\-b
        \\
    ));
    try testUsage("[-a <value>] [-b <v>]", &comptime parseParamsComptime(
        \\-a <value>
        \\-b <v>
        \\
    ));
    try testUsage("[--a] [--b]", &comptime parseParamsComptime(
        \\--a
        \\--b
        \\
    ));
    try testUsage("[--a <value>] [--b <v>]", &comptime parseParamsComptime(
        \\--a <value>
        \\--b <v>
        \\
    ));
    try testUsage("<file>", &comptime parseParamsComptime(
        \\<file>
        \\
    ));
    try testUsage("<file>...", &comptime parseParamsComptime(
        \\<file>...
        \\
    ));
    try testUsage(
        "[-ab] [-c <value>] [-d <v>] [--e] [--f] [--g <value>] [--h <v>] [-i <v>...] <file>",
        &comptime parseParamsComptime(
            \\-a
            \\-b
            \\-c <value>
            \\-d <v>
            \\--e
            \\--f
            \\--g <value>
            \\--h <v>
            \\-i <v>...
            \\<file>
            \\
        ),
    );
}
