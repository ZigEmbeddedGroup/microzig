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

/// Overrides accepted by `microzig.std_options`. Mirrors only the subset of
/// `std.Options` fields that are meaningful on freestanding/embedded targets.
///
/// Included fields (and why):
///   * `log_level` — controls verbosity of `std.log` calls.
///   * `log_scope_levels` — per-scope filtering for fine-grained logging.
///   * `logFn` — the logging callback. This is the *critical* one: stdlib's
///     default writes to stderr, which doesn't exist on freestanding targets
///     and causes link failures whenever any reachable code touches
///     `std.log.*`. Microzig defaults this to a no-op.
///
/// Fields from `std.Options` that are intentionally NOT exposed here:
///   * `enable_segfault_handler`, `signal_stack_size` — POSIX signal
///     plumbing; no OS-level signals on freestanding.
///   * `page_size_min`, `page_size_max`, `queryPageSize` — OS virtual-memory
///     page-size configuration; embedded firmware doesn't have VM.
///   * `fmt_max_depth` — stdlib fmt recursion bound; rarely customized and
///     orthogonal to embedded concerns.
///   * `http_disable_tls`, `http_enable_ssl_key_log_file` — `std.http.Client`
///     tuning; the HTTP client is hosted-only.
///   * `side_channels_mitigations` — `std.crypto` side-channel mitigations;
///     hosted-oriented, and embedded projects typically select crypto at
///     the module level.
///   * `allow_stack_tracing` — pulls in `std.debug.ElfFile` / debug-info
///     loaders that assume a hosted filesystem.
///   * `networking` — gates `std.Io` networking; hosted-only. (Microzig
///     embedded networking is in `modules/network`.)
///   * `unexpected_error_tracing` — default debug-mode tracing that relies
///     on stderr.
///
/// Users who genuinely need one of the excluded fields can still declare
/// their own `pub const std_options = std.Options{ ... }` directly and skip
/// this helper.
pub const StdOptions = struct {
    log_level: std.log.Level = std.log.default_level,
    log_scope_levels: []const std.log.ScopeLevel = &.{},
    logFn: fn (
        comptime message_level: std.log.Level,
        comptime scope: @TypeOf(.enum_literal),
        comptime format: []const u8,
        args: anytype,
    ) void = no_op_log,
};

/// Build a `std.Options` with microzig's freestanding-safe defaults. Users
/// re-export from their root source file:
///
///     pub const std_options = microzig.std_options(.{});                    // defaults only
///     pub const std_options = microzig.std_options(.{ .log_level = .info }); // with overrides
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

/// Emit microzig's firmware startup symbols. Must be invoked from a
/// `comptime` block in the root source file of every firmware:
///
///     comptime { _ = microzig.export_startup(); }
///
/// Emits the CPU-specific `_start` symbol (and vector table where
/// applicable) and the `microzig_main` wrapper that the CPU startup calls
/// once `.data`/`.bss` have been initialized.
pub fn export_startup() void {
    cpu.export_startup_logic();
    @export(&microzig_main, .{ .name = "microzig_main" });
}

/// Called from the CPU-specific `_start` once `.data`/`.bss` are live. Reads
/// `main` from the root source file and supports HAL `init` / root `init` /
/// error-returning `main`.
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
