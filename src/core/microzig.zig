const std = @import("std");
const root = @import("root");

/// Contains build-time generated configuration options for microzig.
/// Contains a CPU target description, chip, board and cpu information
/// and so on.
pub const config = root.config;

/// Provides access to the low level features of the current microchip.
pub const chip = root.chip;

/// Provides access to board features or is `void` when no board is present.
pub const board = if (config.has_board) root.board else void;

/// Provides access to the low level features of the CPU.
pub const cpu = chip.cpu;

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

pub const debug = @import("debug.zig");

/// The microzig panic handler. Will disable interrupts and loop endlessly.
/// Export this symbol from your main file to enable microzig:
/// ```
/// const micro = @import("microzig");
/// pub const panic = micro.panic;
/// ```
pub fn panic(message: []const u8, maybe_stack_trace: ?*std.builtin.StackTrace) noreturn {
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

comptime {
    _ = cpu.startup_logic;
}
