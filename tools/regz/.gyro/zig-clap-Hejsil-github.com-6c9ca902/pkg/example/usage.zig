const clap = @import("clap");
const std = @import("std");

pub fn main() !void {
    const params = comptime clap.parseParamsComptime(
        \\-h, --help         Display this help and exit.
        \\-v, --version      Output version information and exit.
        \\    --value <str>  An option parameter, which takes a value.
        \\
    );

    var res = try clap.parse(clap.Help, &params, clap.parsers.default, .{});
    defer res.deinit();

    // `clap.usage` is a function that can print a simple help message. It can print any `Param`
    // where `Id` has a `value` method (`Param(Help)` is one such parameter).
    if (res.args.help)
        return clap.usage(std.io.getStdErr().writer(), clap.Help, &params);
}
