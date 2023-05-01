const std = @import("std");
const microzig = @import("microzig");
const app = @import("app");

pub usingnamespace app;

// Use microzig panic handler if not defined by an application
pub usingnamespace if (!@hasDecl(app, "panic"))
    struct {
        pub const panic = microzig.panic;
    }
else
    struct {};

// Conditionally provide a default no-op logFn if app does not have one
// defined. Parts of microzig use the stdlib logging facility and
// compilations will now fail on freestanding systems that use it but do
// not explicitly set `root.std_options.logFn`
pub usingnamespace if (!@hasDecl(app, "std_options"))
    struct {
        pub const std_options = struct {
            pub fn logFn(
                comptime message_level: std.log.Level,
                comptime scope: @Type(.EnumLiteral),
                comptime format: []const u8,
                args: anytype,
            ) void {
                _ = message_level;
                _ = scope;
                _ = format;
                _ = args;
            }
        };
    }
else
    struct {
        comptime {
            // Technically the compiler's errors should be good enough that we
            // shouldn't include errors like this, but since we add default
            // behavior we should clarify the situation for the user.
            if (!@hasDecl(app.std_options, "logFn"))
                @compileError("By default MicroZig provides a no-op logging function. Since you are exporting `std_options`, you must export the stdlib logging function yourself.");
        }
    };

// Startup logic:
comptime {
    // Instantiate the startup logic for the given CPU type.
    // This usually implements the `_start` symbol that will populate
    // the sections .data and .bss with the correct data.
    // .rodata is not always necessary to be populated (flash based systems
    // can just index flash, while harvard or flash-less architectures need
    // to copy .rodata into RAM).
    _ = microzig.cpu.startup_logic;

    // Export the vector table to flash start if we have any.
    // For a lot of systems, the vector table provides a reset vector
    // that is either called (Cortex-M) or executed (AVR) when initalized.

    // Allow board and chip to override CPU vector table.
    const export_opts = .{
        .name = "vector_table",
        .section = "microzig_flash_start",
        .linkage = .Strong,
    };

    if ((microzig.board != void and @hasDecl(microzig.board, "vector_table")))
        @export(microzig.board.vector_table, export_opts)
    else if (@hasDecl(microzig.chip, "vector_table"))
        @export(microzig.chip.vector_table, export_opts)
    else if (@hasDecl(microzig.cpu, "vector_table"))
        @export(microzig.cpu.vector_table, export_opts)
    else if (@hasDecl(app, "interrupts"))
        @compileError("interrupts not configured");
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
    if (info != .Fn or info.Fn.params.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.Fn.return_type orelse @compileError(invalid_main_msg);

    if (info.Fn.calling_convention == .Async)
        @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

    // A hal can export a default init function that runs before main for
    // procedures like clock configuration. The user may override and customize
    // this functionality by providing their own init function.
    // function.
    if (@hasDecl(app, "init"))
        app.init()
    else if (microzig.hal != void and @hasDecl(microzig.hal, "init"))
        microzig.hal.init();

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

/// Contains references to the microzig .data and .bss sections, also
/// contains the initial load address for .data if it is in flash.
pub const sections = struct {
    extern var microzig_data_start: anyopaque;
    extern var microzig_data_end: anyopaque;
    extern var microzig_bss_start: anyopaque;
    extern var microzig_bss_end: anyopaque;
    extern const microzig_data_load_start: anyopaque;
};

pub fn initialize_system_memories() void {
    @setCold(true);

    // fill .bss with zeroes
    {
        const bss_start = @ptrCast([*]u8, &sections.microzig_bss_start);
        const bss_end = @ptrCast([*]u8, &sections.microzig_bss_end);
        const bss_len = @ptrToInt(bss_end) - @ptrToInt(bss_start);

        @memset(bss_start[0..bss_len], 0);
    }

    // load .data from flash
    {
        const data_start = @ptrCast([*]u8, &sections.microzig_data_start);
        const data_end = @ptrCast([*]u8, &sections.microzig_data_end);
        const data_len = @ptrToInt(data_end) - @ptrToInt(data_start);
        const data_src = @ptrCast([*]const u8, &sections.microzig_data_load_start);

        @memcpy(data_start[0..data_len], data_src[0..data_len]);
    }
}
