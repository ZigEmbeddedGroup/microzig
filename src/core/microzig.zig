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
pub const config = @import("microzig-config");

/// Provides access to the low level features of the current microchip.
pub const chip = @import("chip");

/// Provides access to board features or is `void` when no board is present.
pub const board = if (config.has_board) @import("board") else void;

/// Provides access to the low level features of the CPU.
pub const cpu = @import("cpu");

pub const hal = @import("hal");

/// Module that helps with interrupt handling.
pub const interrupts = @import("interrupts.zig");

/// Module that provides clock related functions
pub const clock = @import("clock.zig");

pub const gpio = @import("gpio.zig");
pub const Gpio = gpio.Gpio;

pub const pin = @import("pin.zig");
pub const Pin = pin.Pin;

pub const uart = @import("uart.zig");
pub const Uart = uart.Uart;

pub const i2c = @import("i2c.zig");
pub const I2CController = i2c.I2CController;

pub const debug = @import("debug.zig");

pub const mmio = @import("mmio.zig");

// Allow app to override the panic handler
pub const panic = if (@hasDecl(app, "panic"))
    app.panic
else
    microzig_panic;

// Conditionally export log_level if the app has it defined.
usingnamespace if (@hasDecl(app, "log_level"))
    struct {
        pub const log_level = app.log_level;
    }
else
    struct {};

// Conditionally export log() if the app has it defined.
usingnamespace if (@hasDecl(app, "log"))
    struct {
        pub const log = app.log;
    }
else
    struct {
        // log is a no-op by default. Parts of microzig use the stdlib logging
        // facility and compilations will now fail on freestanding systems that
        // use it but do not explicitly set `root.log`
        pub fn log(
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

/// The microzig default panic handler. Will disable interrupts and loop endlessly.
pub fn microzig_panic(message: []const u8, maybe_stack_trace: ?*std.builtin.StackTrace) noreturn {

    // utilize logging functions
    std.log.err("microzig PANIC: {s}", .{message});

    if (builtin.cpu.arch != .avr) {
        var writer = debug.writer();
        writer.print("microzig PANIC: {s}\r\n", .{message}) catch unreachable;

        if (maybe_stack_trace) |stack_trace| {
            var frame_index: usize = 0;
            var frames_left: usize = std.math.min(stack_trace.index, stack_trace.instruction_addresses.len);
            while (frames_left != 0) : ({
                frames_left -= 1;
                frame_index = (frame_index + 1) % stack_trace.instruction_addresses.len;
            }) {
                const return_address = stack_trace.instruction_addresses[frame_index];
                writer.print("0x{X:0>8}\r\n", .{return_address}) catch unreachable;
            }
        }
    }
    hang();
}

/// Hangs the processor and will stop doing anything useful. Use with caution!
pub fn hang() noreturn {
    while (true) {
        interrupts.cli();

        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: "memory");
    }
}

// Startup logic:
comptime {
    // Instantiate the startup logic for the given CPU type.
    // This usually implements the `_start` symbol that will populate
    // the sections .data and .bss with the correct data.
    // .rodata is not always necessary to be populated (flash based systems
    // can just index flash, while harvard or flash-less architectures need
    // to copy .rodata into RAM).
    _ = cpu.startup_logic;

    // Export the vector table to flash start if we have any.
    // For a lot of systems, the vector table provides a reset vector
    // that is either called (Cortex-M) or executed (AVR) when initalized.

    // Allow board and chip to override CPU vector table.
    const export_opts = .{
        .name = "vector_table",
        .section = "microzig_flash_start",
        .linkage = .Strong,
    };

    if ((board != void and @hasDecl(board, "vector_table")))
        @export(board.vector_table, export_opts)
    else if (@hasDecl(chip, "vector_table"))
        @export(chip.vector_table, export_opts)
    else if (@hasDecl(cpu, "vector_table"))
        @export(cpu.vector_table, export_opts)
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
    const info: std.builtin.TypeInfo = @typeInfo(@TypeOf(main));

    const invalid_main_msg = "main must be either 'pub fn main() void' or 'pub fn main() !void'.";
    if (info != .Fn or info.Fn.args.len > 0)
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
    else if (@hasDecl(hal, "init"))
        hal.init();

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
    hang();
}
