//! This is the entry point and root file of microzig.
//! If you do a @import("microzig"), you'll *basically* get this file.
//!
//! But microzig employs a proxy tactic

const std = @import("std");
const root = @import("root");
const builtin = @import("builtin");

/// The app that is currently built.
pub const app = @import("app");

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

pub const options: Options = if (@hasDecl(app, "microzig_options")) app.microzig_options else .{};

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
    _ = Allocator;
}
