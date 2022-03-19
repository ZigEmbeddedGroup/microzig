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

/// The microzig panic handler. Will disable interrupts and loop endlessly.
/// Export this symbol from your main file to enable microzig:
/// ```
/// const micro = @import("microzig");
/// pub const panic = micro.panic;
/// ```
pub fn panic(message: []const u8, maybe_stack_trace: ?*std.builtin.StackTrace) noreturn {

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

    if (@TypeOf(vector_table) != @TypeOf(null)) { // ugh, comptime shenanigans
        @export(vector_table, .{
            .name = "vector_table",
            .section = "microzig_flash_start",
            .linkage = .Strong,
        });
    }
}

/// Allow board and chip to override CPU vector table.
/// This must be a non-`comptime` `var` to be exported properly,
/// see https://github.com/ziglang/zig/issues/5157#issuecomment-618933196 .
var vector_table = if (board != void and @hasDecl(board, "vector_table"))
    board.vector_table
else if (@hasDecl(chip, "vector_table"))
    chip.vector_table
else if (@hasDecl(cpu, "vector_table"))
    cpu.vector_table
else
    null;

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
    hang();
}
