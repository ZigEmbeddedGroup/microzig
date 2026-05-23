//! This is the entry point and root file of microzig.
//! If you do a @import("microzig"), you'll *basically* get this file.
//!
//! But microzig employs a proxy tactic

const std = @import("std");
const root = @import("root");

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
        _ = first_trace_address;

        // TODO: sit down and determine if we want to provide our own SelfInfo.
        // Is that what plugs into the standard panic?

        //var frame_index: usize = 0;
        //if (@errorReturnTrace()) |trace| frame_index = utilities.dump_stack_trace(trace);

        //var iter = std.debug.StackIterator.init(first_trace_address orelse @returnAddress(), null);
        //while (iter.next()) |address| : (frame_index += 1) {
        //    std.log.err("{d: >3}: 0x{X:0>8}", .{ frame_index, address });
        //}

        //// Attach a breakpoint. this might trigger another panic internally, so
        //// only do that if requested.
        //if (options.breakpoint_in_panic) {
        //    std.log.info("triggering breakpoint...", .{});
        //    @breakpoint();
        //}

        hang();
    }
}.panic_fn);

pub const InterruptOptions = if (@hasDecl(cpu, "InterruptOptions")) cpu.InterruptOptions else struct {};

pub const CPU_Options = if (@hasDecl(cpu, "CPU_Options")) cpu.CPU_Options else struct {};
pub const HAL_Options = if (config.has_hal and @hasDecl(hal, "HAL_Options")) hal.HAL_Options else struct {};

pub const Options = struct {
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

pub const StdOptions = struct {
    /// Control verbosity of `std.log` calls
    log_level: std.log.Level = std.log.default_level,
    /// Per-scope filtering for fine-grained logging
    log_scope_levels: []const std.log.ScopeLevel = &.{},
    /// The logging callback function, you'll need to provide to be able to log
    /// to UART for example. The default is to do nothing, which is very
    /// portable.
    logFn: fn (
        comptime message_level: std.log.Level,
        comptime scope: @TypeOf(.enum_literal),
        comptime format: []const u8,
        args: anytype,
    ) void = no_op_log,
};

/// Helper for setting std_options relevant to embedded systems and freestanding
/// targets. Makes fewer assumptions about your system that the stdlib, and will
/// compile by default. You can set you own values using the overrides parameter.
pub fn std_options(comptime overrides: StdOptions) std.Options {
    return .{
        .log_level = overrides.log_level,
        .log_scope_levels = overrides.log_scope_levels,
        .logFn = overrides.logFn,
    };
}

fn no_op_log(
    comptime _: std.log.Level,
    comptime _: @TypeOf(.enum_literal),
    comptime _: []const u8,
    _: anytype,
) void {}

/// Hangs the processor and will stop doing anything useful. Use with caution!
pub fn hang() noreturn {
    cpu.interrupt.disable_interrupts();
    while (true) {
        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: .{ .memory = true });
    }
}

/// Call this in the root of your application to ensure that startup code is
/// linked correctly:
///
/// ```zig
/// comptime { _ = microzig.export_startup(); }
/// ```
///
/// Different systems require different startup procedures, and MicroZig will
/// select the right one for your system.
pub fn export_startup() void {
    cpu.export_startup_logic();
    @export(&microzig_main, .{ .name = "microzig_main" });
}

fn microzig_main() callconv(.c) noreturn {
    // A HAL may define `init` (e.g. clocks, PLL) that runs before main. The
    // user's root source file may define its own `init` to override the HAL
    // default.
    if (@hasDecl(root, "init"))
        root.init()
    else if (hal != void and @hasDecl(hal, "init"))
        hal.init();

    const main = @field(root, "main");
    const return_type = @typeInfo(@TypeOf(main)).@"fn".return_type orelse
        @compileError("microzig: `main` must have a return type");

    if (@typeInfo(return_type) == .error_union) {
        main() catch |err| {
            const msg_base = "main() returned error.";

            if (!options.simple_panic_if_main_errors) {
                const max_error_size = comptime blk: {
                    var max: usize = 0;
                    const err_type = @typeInfo(return_type).error_union.error_set;
                    if (@typeInfo(err_type).error_set) |err_set| {
                        for (err_set) |current_err| {
                            max = @max(max, current_err.name.len);
                        }
                    }
                    break :blk max;
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

    hang();
}

test {
    _ = utilities;
    _ = Allocator;
}
