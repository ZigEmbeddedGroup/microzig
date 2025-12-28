//! This is the entry point and root file of microzig.
//! If you do a @import("microzig"), you'll *basically* get this file.
//!
//! But microzig employs a proxy tactic

const std = @import("std");
const root = @import("root");
const builtin = @import("builtin");

/// The app that is currently built.
//pub const app = @import("app");

/// Contains build-time generated configuration options for microzig.
/// Contains a CPU target description, chip, board and cpu information
/// and so on.
pub const config = @import("config");

/// Provides access to the low level features of the CPU.
pub const cpu = @import("cpu");

/// Provides access to the low level features of the current microchip.
pub const chip = @import("chip");

/// Provides higher level APIs for interacting with hardware
pub const hal = if (config.has_hal) @import("hal") else void;

/// Provides access to board features or is `void` when no board is present.
pub const board = if (config.has_board) @import("board") else void;

/// Contains device-independent drivers for peripherial devices.
pub const drivers = @import("drivers");

pub const core = @import("core.zig");
pub const concurrency = @import("concurrency.zig");
pub const interrupt = @import("interrupt.zig");
pub const mmio = @import("mmio.zig");
pub const utilities = @import("utilities.zig");
pub const Allocator = @import("allocator.zig");

/// The microzig default panic handler. Will disable interrupts and loop endlessly.
pub const panic = std.debug.FullPanic(struct {
    pub fn panic_fn(message: []const u8, first_trace_address: ?usize) noreturn {
        std.log.err("panic: {s}", .{message});

        var frame_index: usize = 0;
        if (@errorReturnTrace()) |trace| frame_index = utilities.dump_stack_trace(trace);

        var iter = std.debug.StackIterator.init(first_trace_address orelse @returnAddress(), null);
        while (iter.next()) |address| : (frame_index += 1) {
            std.log.err("{d: >3}: 0x{X:0>8}", .{ frame_index, address });
        }

        // Attach a breakpoint. this might trigger another panic internally, so
        // only do that if requested.
        if (options.breakpoint_in_panic) {
            std.log.info("triggering breakpoint...", .{});
            @breakpoint();
        }

        hang();
    }
}.panic_fn);

pub const InterruptOptions = if (@hasDecl(cpu, "InterruptOptions")) cpu.InterruptOptions else struct {};

pub const CPU_Options = if (@hasDecl(cpu, "CPU_Options")) cpu.CPU_Options else struct {};
pub const HAL_Options = if (config.has_hal and @hasDecl(hal, "HAL_Options")) hal.HAL_Options else struct {};

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
            comptime scope: @Type(.enum_literal),
            comptime format: []const u8,
            args: anytype,
        ) void {
            _ = message_level;
            _ = scope;
            _ = format;
            _ = args;
        }
    }.log,
    interrupts: InterruptOptions = .{},
    overwrite_hal_interrupts: bool = false, //force overwrite the Hal default interrupts
    cpu: CPU_Options = .{},
    hal: HAL_Options = .{},

    /// If true, will trigger a breakpoint in the default panic handler.
    breakpoint_in_panic: bool = false,

    /// The default panic called when main returns an error will include the
    /// name of the error. If this option is true, a panic will be invoked with
    /// only a static message, avoiding the call to @errorName. This can help
    /// reduce code size as the string literals for error names no longer have to
    /// be included in the executable.
    simple_panic_if_main_errors: bool = false,
};

pub const options: Options = if (@hasDecl(root, "microzig_options")) root.microzig_options else .{};

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
    if (!@hasDecl(root, "main"))
        @compileError("The root source file must provide a public function main!");

    const main = @field(root, "main");
    const info: std.builtin.Type = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .@"fn" or info.@"fn".params.len > 0)
        @compileError(invalid_main_msg);

    const return_type = info.@"fn".return_type orelse @compileError(invalid_main_msg);

    if (info.@"fn".calling_convention == .async)
        @compileError("TODO: Embedded event loop not supported yet. Please try again later.");

    // A hal can export a default init function that runs before main for
    // procedures like clock configuration. The user may override and customize
    // this functionality by providing their own init function.
    // function.
    if (@hasDecl(root, "init"))
        root.init()
    else if (hal != void and @hasDecl(hal, "init"))
        hal.init();

    if (@typeInfo(return_type) == .error_union) {
        main() catch |err| {
            // Although here we could use @errorReturnTrace similar to
            // `std.start` and just dump the trace (without panic), the user
            // might not use logging and have the panic handler just blink an
            // led.

            const msg_base = "main() returned error.";

            if (!options.simple_panic_if_main_errors) {
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
    hang();
}

/// Hangs the processor and will stop doing anything useful. Use with caution!
pub fn hang() noreturn {
    cpu.interrupt.disable_interrupts();
    while (true) {
        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: .{ .memory = true });
    }
}

test {
    _ = utilities;
}
