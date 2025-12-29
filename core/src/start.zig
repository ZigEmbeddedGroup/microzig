const std = @import("std");
const builtin = @import("builtin");
const microzig = @import("microzig");
const app = @import("app");

// Use microzig panic handler if not defined by an application
pub const panic = if (!@hasDecl(app, "panic")) microzig.panic else app.panic;

// Conditionally provide a default no-op logFn if app does not have one
// defined. Parts of microzig use the stdlib logging facility and
// compilations will now fail on freestanding systems that use it but do
// not explicitly set `root.std_options.logFn`
pub const std_options: std.Options = .{
    .log_level = microzig.options.log_level,
    .log_scope_levels = microzig.options.log_scope_levels,
    .logFn = microzig.options.logFn,
};

// Startup logic:
comptime {
    // Instantiate the startup logic for the given CPU type.
    // This usually implements the `_start` symbol that will populate
    // the sections .data and .bss with the correct data.
    // .rodata is not always necessary to be populated (flash based systems
    // can just index flash, while harvard or flash-less architectures need
    // to copy .rodata into RAM).
    microzig.cpu.export_startup_logic();
}

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
    const info: std.builtin.Type = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .@"fn" or info.@"fn".params.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.@"fn".return_type orelse @compileError(invalid_main_msg);

    // A hal can export a default init function that runs before main for
    // procedures like clock configuration. The user may override and customize
    // this functionality by providing their own init function.
    // function.
    if (@hasDecl(app, "init"))
        app.init()
    else if (microzig.hal != void and @hasDecl(microzig.hal, "init"))
        microzig.hal.init();

    if (@typeInfo(return_type) == .error_union) {
        main() catch |err| {
            // Although here we could use @errorReturnTrace similar to
            // `std.start` and just dump the trace (without panic), the user
            // might not use logging and have the panic handler just blink an
            // led.

            const msg_base = "main() returned error.";

            if (!microzig.options.simple_panic_if_main_errors) {
                const max_error_size = comptime blk: {
                    var max_error_size: usize = 0;
                    const err_type = @typeInfo(return_type).error_union.error_set;
                    if (@typeInfo(err_type).error_set) |err_set| {
                        for (err_set) |current_err| {
                            max_error_size = @max(max_error_size, current_err.name.len);
                        }
                    }
                    break :blk max_error_size;
                };

                var buf: [msg_base.len + max_error_size]u8 = undefined;
                const msg = std.fmt.bufPrint(&buf, "{s}{s}", .{ msg_base, @errorName(err) }) catch @panic(msg_base);
                @panic(msg);
            } else {
                @panic(msg_base);
            }
        };
    } else {
        main();
    }

    // Main returned, just hang around here a bit.
    microzig.hang();
}
