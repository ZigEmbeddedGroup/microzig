const std = @import("std");
const microzig = @import("microzig");
const app = @import("app");

// Use microzig panic handler if not defined by an application
pub const panic = if (!@hasDecl(app, "panic")) microzig.panic else app.panic;

pub const Options = struct {
    log_level: std.log.Level = std.log.default_level,
    log_scope_levels: []const std.log.ScopeLevel = &.{},
    logFn: fn (
        comptime message_level: std.log.Level,
        comptime scope: @TypeOf(.enum_literal),
        comptime format: []const u8,
        args: anytype,
    ) void = struct {
        fn log(
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
    }.log,
};

pub const microzig_options: Options = if (@hasDecl(app, "microzig_options")) app.microzig_options else .{};

// Conditionally provide a default no-op logFn if app does not have one
// defined. Parts of microzig use the stdlib logging facility and
// compilations will now fail on freestanding systems that use it but do
// not explicitly set `root.std_options.logFn`
pub const std_options = std.Options{
    .log_level = microzig_options.log_level,
    .log_scope_levels = microzig_options.log_scope_levels,
    .logFn = microzig_options.logFn,
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
    // it looks odd to just use a u8 here, but in C it's common to use a
    // char when linking these values from the linkerscript. What's
    // important is the addresses of these values.
    extern var microzig_data_start: u8;
    extern var microzig_data_end: u8;
    extern var microzig_bss_start: u8;
    extern var microzig_bss_end: u8;
    extern const microzig_data_load_start: u8;
};

pub fn initialize_system_memories() void {
    @setCold(true);

    // fill .bss with zeroes
    {
        const bss_start: [*]u8 = @ptrCast(&sections.microzig_bss_start);
        const bss_end: [*]u8 = @ptrCast(&sections.microzig_bss_end);
        const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss_start);

        @memset(bss_start[0..bss_len], 0);
    }

    // load .data from flash
    {
        const data_start: [*]u8 = @ptrCast(&sections.microzig_data_start);
        const data_end: [*]u8 = @ptrCast(&sections.microzig_data_end);
        const data_len = @intFromPtr(data_end) - @intFromPtr(data_start);
        const data_src: [*]const u8 = @ptrCast(&sections.microzig_data_load_start);

        @memcpy(data_start[0..data_len], data_src[0..data_len]);
    }
}
