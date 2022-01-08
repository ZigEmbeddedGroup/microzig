const std = @import("std");
const app = @import("app");
const microzig = @import("microzig");

pub usingnamespace app;

/// This is the logical entry point for microzig.
/// It will invoke the main function from the root source file
/// and provides error return handling as well as a event loop if requested.
///
/// Why is this function exported?
/// This is due to the modular design of microzig to allow the "chip" dependency of microzig
/// to call into our main function here. If we would use a normal function call, we'd have a
/// circular dependency between the `microzig` and `chip` package. This function is also likely
/// to be invoked from assembly, so it's also convenient in that regard.
export fn microzig_main() noreturn {
    if (!@hasDecl(app, "main"))
        @compileError("The root source file must provide a public function main!");

    const main = @field(app, "main");
    const info: std.builtin.TypeInfo = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .Fn or info.Fn.args.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.Fn.return_type orelse @compileError(invalid_main_msg);

    if (info.Fn.calling_convention == .Async)
        @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

    if (@typeInfo(return_type) == .ErrorUnion) {
        main() catch |err| {
            // TODO:
            // - Compute maximum size on the type of "err"
            // - Do not emit error names when std.builtin.strip is set.
            var msg: [64]u8 = undefined;
            @panic(std.fmt.bufPrint(&msg, "main() returned error {s}", .{@errorName(err)}) catch @panic("main() returned error."));
        };
    } else {
        main();
    }

    // main returned, just hang around here a bit
    microzig.hang();
}
