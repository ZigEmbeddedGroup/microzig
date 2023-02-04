const clap = @import("clap");
const std = @import("std");

const debug = std.debug;
const io = std.io;

pub fn main() !void {
    // First we specify what parameters our program can take.
    // We can use `parseParamsComptime` to parse a string into an array of `Param(Help)`
    const params = comptime clap.parseParamsComptime(
        \\-h, --help             Display this help and exit.
        \\-n, --number <usize>   An option parameter, which takes a value.
        \\-s, --string <str>...  An option parameter which can be specified multiple times.
        \\<str>...
        \\
    );

    // Initialize our diagnostics, which can be used for reporting useful errors.
    // This is optional. You can also pass `.{}` to `clap.parse` if you don't
    // care about the extra information `Diagnostics` provides.
    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{
        .diagnostic = &diag,
    }) catch |err| {
        // Report useful error and exit
        diag.report(io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help)
        debug.print("--help\n", .{});
    if (res.args.number) |n|
        debug.print("--number = {}\n", .{n});
    for (res.args.string) |s|
        debug.print("--string = {s}\n", .{s});
    for (res.positionals) |pos|
        debug.print("{s}\n", .{pos});
}
